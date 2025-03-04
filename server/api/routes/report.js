import app from "app"
import {
  analyzeCondition,
  convertMonitoringData,
  reformatMonitoringData,
  convertToNormalDate,
  reformatDataReport,
  reformatIndicatorReport,
} from "app/utils"
import bodyParser from "body-parser"
import ExcelJs from "exceljs"
import { Router } from "express"
import moment from "moment"
const router = Router()
import HttpStatus from "http-status-codes"


export default (expressRouter) => {
  expressRouter.use("/baocao", router)

  router.post("/", async (req, res, next) => {
    try {
      const { stationId, startAt, endAt, page, limit } = req.body
      const data = await getPaginationSpecificData(
        stationId,
        startAt,
        endAt,
        page,
        limit
      )
      const diffTime = Math.abs(new Date(endAt) - new Date(startAt))
      const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24)); 
      if (diffDays > 31){
        throw { status: HttpStatus.BAD_REQUEST, id: "api.report", messages: "Chỉ tìm kiếm được trong khoảng thời gian nhỏ hơn 31 ngày. Vui lòng chọn lại khoảng thời gian!" }
      }
      const totalData = await app.MonitoringDataInfo.getTotalData(
        stationId,
        startAt,
        endAt
      )
      res.json({
        data,
        totalData,
      })
    } catch (error) {
      console.log(error)
      next(error)
    }
  })

  router.get("/getData", async (req, res, next) => {
    try {
      // console.log(req.query)
      let {
        reportType,
        monitoringType,
        monitoringGroup,
        district,
        station,
        startAt,
        endAt,
      } = req.query

      const condition = analyzeCondition(
        monitoringType,
        monitoringGroup,
        district,
        station
      )
      startAt = moment.utc(startAt).tz("Asia/Ho_Chi_Minh").format()
      endAt = moment.utc(endAt).tz("Asia/Ho_Chi_Minh").format()
      // const timeSubtract = Math.abs(endAt - startAt)
      const timeSubtract = moment(endAt).diff(moment(startAt), "minutes")

      const stationCount = await app.Station.getCountData(
        condition,
        startAt,
        endAt
      )
      const stationDuration = await app.Station.getDataDuration(condition)
      const data = reformatDataReport(
        stationCount,
        stationDuration,
        timeSubtract
      )

      res.json(data)
    } catch (error) {
      console.log(error)
      next(error)
    }
  })

  router.post("/export/:managerId", async (req, res, next) => {
    try {
      const { managerId } = req.params
      await app.Manager.checkManagerPermission(managerId, "export_report")

      let workbook = new ExcelJs.Workbook()
      let data = []
      let { stationId, startAt, endAt } = req.body
      const diffTime = Math.abs(new Date(endAt) - new Date(startAt))
      const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24)); 
      if (diffDays > 7){
        throw { status: HttpStatus.BAD_REQUEST, id: "api.report.export", messages: "Chỉ xuất được dữ liệu trong vòng 7 ngày. Vui lòng chọn lại khoảng thời gian!" }
      }

      const startAtStr = moment(startAt).utc().format("DDMMYYYYHHmmss")
      const endAtStr = moment(endAt).utc().format("DDMMYYYYHHmmss")
      let indicatorList = await app.StationIndicators.findIndicator(stationId)
      indicatorList = indicatorList.map((item) => {
        return item.name
      })
      data = await getSpecificData(stationId, startAt, endAt)
      let excelData = data.map((item, index) => {
        let row = []
        row.push(index + 1)
        row.push(item.name)
        row.push(moment(item.sentAt).utcOffset(0).format("DD/MM/YYYY HH:mm:ss"))
        indicatorList.map((element) => {
          row.push(item.MonitoringData[element])
        })
        return row
      })
      workbook.creator = "Trung tam Quan trac Da Nang"
      workbook.created = new Date()

      workbook.views = [
        {
          x: 0,
          y: 0,
          width: 10000,
          height: 20000,
          firstSheet: 0,
          activeTab: 1,
          visibility: "visible",
        },
      ]
      var worksheet = workbook.addWorksheet("Báo cáo chi tiết")
      let headerRow = [
        { header: "STT", key: "stt", width: 8, bold: true },
        { header: "Tên trạm", key: "stationName", width: 20 },
        { header: "Thời gian", key: "sentAt", width: 20 },
      ]
      indicatorList.forEach((item) => {
        headerRow.push({
          header: item,
          key: "indicatorCode",
          width: 10,
          bold: true,
        })
      })
      worksheet.columns = headerRow

      excelData.forEach((item) => {
        worksheet.addRow(item)
      })

      res.setHeader(
        "Content-Type",
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      )
      res.setHeader(
        "Content-Disposition",
        `Baocaochitiet_${startAtStr}_${endAtStr}.xlsx`
      )
      workbook.xlsx.write(res).then(function (data) {
        res.end()
        console.log("File write done........", Date.now())
      })
    } catch (error) {
      console.log(error)
      next(error)
    }
  })
}

const getData = async (
  monitoringType,
  monitoringGroup,
  district,
  station,
  stationId,
  startAt,
  endAt
) => {
  try {
    const condition = analyzeCondition(
      monitoringType,
      monitoringGroup,
      district,
      station
    )
    // startAt = moment.utc(startAt).tz('Asia/Ho_Chi_Minh').format()
    // endAt = moment.utc(endAt).tz('Asia/Ho_Chi_Minh').format()
    startAt = moment(startAt).utcOffset(-420).format()
    endAt = moment(endAt).utcOffset(-420).format()
    // console.log(startAt, endAt)
    // const timeSubtract = Math.abs(endAt - startAt)

    const stationCount = await app.Station.getCountData(
      { id: stationId },
      startAt,
      endAt
    )
    const stationDuration = await app.Station.getDataDuration({ id: stationId })
    const data = reformatDataReport(
      stationCount,
      stationDuration,
      startAt,
      endAt
    )
    return data
  } catch (err) {
    throw err
  }
}

const getGeneralData = async (
  monitoringType,
  monitoringGroup,
  district,
  station,
  stationId,
  startAt,
  endAt,
  indicator
) => {
  try {
    const arrIndicator = indicator.map((item) => {
      // return JSON.parse(item).name
      return item.name
    })
    // const condition = analyzeCondition(monitoringType, monitoringGroup, district, station)
    const stations = await app.Station.getBasicStationInfo(stationId)
    // console.log(startAt, endAt)
    // startAt = moment.utc(startAt).format()
    // endAt = moment.utc(endAt).format()
    startAt = moment.utc(startAt).tz("Asia/Ho_Chi_Minh").format()
    endAt = moment.utc(endAt).tz("Asia/Ho_Chi_Minh").format()
    // console.log('====================', startAt, endAt)
    // startAt = moment(startAt).utcOffset(-420).format()
    // endAt = moment(endAt).utcOffset(-420).format()
    let data = await Promise.all(
      stations.map(async (item) => {
        let data = await app.MonitoringDataInfo.searchDataGeneral(
          item.id,
          arrIndicator,
          startAt,
          endAt
        )
        let newData = reformatIndicatorReport(arrIndicator, data)
        return {
          id: item.id,
          name: item.name,
          symbol: item.symbol,
          startAt: convertToNormalDate(startAt),
          endAt: convertToNormalDate(endAt),
          // startAt: startAt,
          // endAt: endAt,
          data: newData,
        }
      })
    )
    return data
  } catch (err) {
    throw err
  }
}

const getPaginationSpecificData = async (
  stationId,
  startAt,
  endAt,
  page,
  limit
) => {
  try {
    startAt = moment.utc(startAt).format()
    endAt = moment.utc(endAt).format()
    // startAt = moment(startAt).utcOffset(-420).format()
    // endAt = moment(endAt).utcOffset(-420).format()
    let data = await app.MonitoringDataInfo.searchPaginationSpecificData(
      stationId,
      startAt,
      endAt,
      page,
      limit
    )
    const stationInfo = await app.Station.getBasicStationInfo(stationId)
    data = reformatMonitoringData(data, stationInfo[0])
    // console.log(data)
    return data
  } catch (err) {
    throw err
  }
}

const getSpecificData = async (stationId, startAt, endAt) => {
  try {
    startAt = moment.utc(startAt).format()
    endAt = moment.utc(endAt).format()
    // startAt = moment(startAt).utcOffset(-420).format()
    // endAt = moment(endAt).utcOffset(-420).format()
    let data = await app.MonitoringDataInfo.searchSpecificData(
      stationId,
      startAt,
      endAt
    )
    data = convertMonitoringData(data)
    // console.log(data)
    return data
  } catch (err) {
    throw err
  }
}

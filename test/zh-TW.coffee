assert = require("assert")
dateParser = require("../date-parser")
Moment = require('moment-timezone')
dateToUnix = require('./test-helpers').dateToUnix

describe "dateParser_zh-TW", ->
  dateParser.locale 'zh-TW'

  describe "inTaipei", ->
    timezone = 'Asia/Taipei'

    it "should recognize 今天", ->
      assert.equal(
        dateToUnix dateParser.parse '今天', timezone
        Moment.tz(timezone).hour(0).minute(0).second(0).unix()
      )
      assert.equal(
        dateParser.parse('今天').fullDay
        true
      )

    it "should recognize 今天早上", ->
      assert.equal(
        dateToUnix dateParser.parse '今天早上', timezone
        Moment.tz(timezone).hour(9).minute(0).second(0).unix()
      )
      assert.equal(
        dateToUnix dateParser.parse('今天早上', timezone).endTime
        Moment.tz(timezone).hour(11).minute(0).second(0).unix()
      )

    it "should recognize 明天中午", ->
      assert.equal(
        dateToUnix dateParser.parse '明天中午', timezone
        Moment.tz(timezone).add(1, 'day').hour(12).minute(0).second(0).unix()
      )
      assert.equal(
        dateToUnix dateParser.parse('明天中午', timezone).endTime
        Moment.tz(timezone).add(1, 'day').hour(13).minute(0).second(0).unix()
      )

    it "should recognize 後天晚上", ->
      assert.equal(
        dateToUnix dateParser.parse '後天晚上', timezone
        Moment.tz(timezone).add(2, 'day').hour(18).minute(0).second(0).unix()
      )
      assert.equal(
        dateToUnix dateParser.parse('後天晚上').endTime
        Moment.tz(timezone).add(2, 'day').hour(20).minute(0).second(0).unix()
      )

    it "should recognize 今早八點", ->
      assert.equal(
        dateToUnix dateParser.parse '今早八點', timezone
        Moment.tz(timezone).hour(8).minute(0).second(0).unix()
      )

    it "should recognize 明晚九點", ->
      assert.equal(
        dateToUnix dateParser.parse '明晚九點', timezone
        Moment.tz(timezone).add(1, 'day').hour(21).minute(0).second(0).unix()
      )

    it "should recognize 一個半小時後", ->
      assert.equal(
        dateToUnix dateParser.parse '一個半小時後', timezone
        Moment.tz(timezone).add(1, 'hours').add(30, 'minutes').unix()
      )

    it "should recognize 大概兩小時又三十五分鐘後", ->
      assert.equal(
        dateToUnix dateParser.parse '大概兩小時又三十五分鐘後', timezone
        Moment.tz(timezone).add(2, 'hours').add(35, 'minutes').unix()
      )

    it "should recognize 星期五晚上", ->
      assert.equal(
        dateToUnix dateParser.parse '星期五晚上', timezone
        Moment.tz(timezone).day(5).hour(18).minute(0).second(0).unix()
      )
      assert.equal(
        dateToUnix dateParser.parse('星期五晚上').endTime
        Moment.tz(timezone).day(5).hour(20).minute(0).second(0).unix()
      )

    it "should recognize 下禮拜四晚上八點 搶票", ->
      result = dateParser.parse '下禮拜四晚上八點 搶票', timezone
      assert.equal(
        dateToUnix result
        Moment.tz(timezone).add(1, 'week').day(4).hour(20).minute(0).second(0).unix()
      )
      assert.equal result.eventName, '搶票'

    it "should recognize 這週末要喝茶", ->
      result = dateParser.parse '這週末要喝茶', timezone
      assert.equal(
        dateToUnix result
        Moment.tz(timezone).day(6).hour(0).minute(0).second(0).unix()
      )
      assert.equal(
        dateToUnix result.endTime
        Moment.tz(timezone).add(1, 'week').day(0).hour(23).minute(59).second(59).unix()
      )
      assert.equal result.fullDay, true
      assert.equal result.eventName, '喝茶'

    it "should recognize 二零一四年五月五日", ->
      result = dateParser.parse '二零一四年五月五日', timezone
      assert.equal(
        dateToUnix result
        Moment('2014-05-05').tz(timezone).hour(0).minute(0).second(0).unix()
      )
      assert.equal result.fullDay, true

    it "should recognize 2010/2/28 晚上八點 @自由廣場", ->
      result = dateParser.parse '2010/2/28 晚上八點 @自由廣場', timezone
      assert.equal(
        dateToUnix result
        Moment('2010-02-28').tz(timezone).hour(20).minute(0).second(0).unix()
      )
      assert.equal result.location, '自由廣場'

    it "should recognize 上週五早上九點到下週六晚上7點要去玩", ->
      result = dateParser.parse '上週五早上九點到下週六晚上7點要去玩', timezone
      assert.equal(
        dateToUnix result
        Moment.tz(timezone).subtract(1, 'week').day(5).hour(9).minute(0).second(0).unix()
      )
      assert.equal(
        dateToUnix result.endTime
        Moment.tz(timezone).add(1, 'week').day(6).hour(19).minute(0).second(0).unix()
      )
      assert.equal(
        result.eventName
        '去玩'
      )

    it "should recognize 辦公時間 週五 6:00pm ~ 週六 10:00am", ->
      result = dateParser.parse '辦公時間 週五 6:00pm ~ 週六 10:00am', timezone
      assert.equal(
        dateToUnix result
        Moment.tz(timezone).day(5).hour(18).minute(0).second(0).unix()
      )
      assert.equal(
        dateToUnix result.endTime
        Moment.tz(timezone).day(6).hour(10).minute(0).second(0).unix()
      )
      assert.equal result.eventName, '辦公時間'

    it "should NOT recognize 阿啊啊嗚嗚嗚嗚", ->
      assert.equal(
        dateToUnix dateParser.parse('阿啊啊嗚嗚嗚嗚')
        null
      )

  describe "inMonaco", ->
    timezone = 'Europe/Monaco'

    it "should recognize 下禮拜三 4:32pm ~ 6:17pm", ->
      assert.equal(
        dateToUnix dateParser.parse '下禮拜三 4:32pm ~ 6:17pm', timezone
        Moment.tz(timezone).add(1, 'week').day(3).hour(16).minute(32).second(0).unix()
      )
      assert.equal(
        dateToUnix dateParser.parse('下禮拜三 4:32pm ~ 6:17pm', timezone).endTime
        Moment.tz(timezone).add(1, 'week').day(3).hour(18).minute(17).second(0).unix()
      )

    it "should recognize 下禮拜天", ->
      assert.equal(
        dateToUnix dateParser.parse '下禮拜天', timezone
        Moment.tz(timezone).add(1, 'week').day(7).hour(0).minute(0).second(0).unix()
      )

    it "should recognize 10/33", ->
      assert.equal(
        dateToUnix dateParser.parse '10/40', timezone
        Moment.tz(timezone).month(9).date(10).hour(0).minute(0).second(0).unix()
      )

    it "should recognize 明年1/1 凌晨一點", ->
      assert.equal(
        dateToUnix dateParser.parse '明年1/1 凌晨一點', timezone
        Moment.tz(timezone).add(1, 'year').month(0).date(1).hour(1).minute(0).second(0).unix()
      )

    it "should recognize 下午三點半在銀行有派對", ->
      result = dateParser.parse '下午三點半在銀行有派對', timezone
      assert.equal(
        dateToUnix result
        Moment.tz(timezone).hour(15).minute(30).second(0).unix()
      )
      assert.equal(
        result.location
        '銀行'
      )
      assert.equal(
        result.eventName
        '派對'
      )

  describe "inNewYork", ->
    timezone = 'America/New_York'

    it "should recognize 下個月五號中午 12:00", ->
      assert.equal(
        dateToUnix dateParser.parse '下個月五號中午 12:00', timezone
        Moment.tz(timezone).add(1, 'month').date(5).hour(12).minute(0).second(0).unix()
      )

    it "should recognize 星期五晚上到下禮拜六早上要一直玩一直玩一直玩", ->
      result = dateParser.parse '星期五晚上到下禮拜六早上要一直玩一直玩一直玩', timezone
      assert.equal(
        dateToUnix result
        Moment.tz(timezone).day(5).hour(18).minute(0).second(0).unix()
      )
      assert.equal(
        dateToUnix result.endTime
        Moment.tz(timezone).add(1, 'weeks').day(6).hour(9).minute(0).second(0).unix()
      )
      assert.equal result.eventName, '一直玩一直玩一直玩'

    it "should recognize 今天晚上在聽風家有披薩吃", ->
      result = dateParser.parse '今天晚上在聽風家有披薩吃', timezone
      assert.equal(
        dateToUnix result
        Moment.tz(timezone).hour(18).minute(0).second(0).unix()
      )
      assert.equal(
        dateToUnix result.endTime
        Moment.tz(timezone).hour(20).minute(0).second(0).unix()
      )
      assert.equal result.location, '聽風家'
      assert.equal result.eventName, '披薩吃'

    it "should recognize 明天中午到晚上要開會", ->
      result = dateParser.parse '明天中午到晚上要開會', timezone
      assert.equal(
        dateToUnix result
        Moment.tz(timezone).add(1, 'days').hour(12).minute(0).second(0).unix()
      )
      assert.equal(
        dateToUnix result.endTime
        Moment.tz(timezone).add(1, 'days').hour(18).minute(0).second(0).unix()
      )
      assert.equal result.eventName, '開會'

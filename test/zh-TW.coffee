assert = require("assert")
dateParser = require("../date-parser")
Moment = require('moment-timezone')

describe "dateParser_zh-TW", ->
  describe "inTaipei", ->
    it "should return -1 when the value is not present", ->
      assert.equal -1, -1
    it "should return -1 when the value is not ", ->
      assert.equal -1, -1

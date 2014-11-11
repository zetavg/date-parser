module.exports =
  dateToUnix: (date) ->
    return parseInt(date.getTime()/1000) if date
    return null

Moment = require('moment-timezone')

words =
  at: '(?:在|於|@|要在)'
  zero: '(?:零|０|0)'
  one: '(?:一|１|1)'
  two: '(?:二|兩|２|2)'
  three: '(?:三|３|3)'
  four: '(?:四|４|4)'
  five: '(?:五|５|5)'
  six: '(?:六|６|6)'
  seven: '(?:七|７|7)'
  sun: '(?:日|天)'
  eight: '(?:八|８|8)'
  nine: '(?:九|９|9)'
  ten: '十'
  half: '半'
  end: '末'
  dot: '(?:\\.|點|:|：)'
  hour: '(?:時|小時|點|:|：)'
  minute: '(?:分|分鐘|:|：)'
  second: '秒'
  morning: '(?:早|早上|早晨|am|AM)'
  noon: '(?:中午)'
  afternoon: '(?:下午|午後|pm|PM)'
  night: '(?:晚|晚上|晚間|夜晚|夜間)'
  midnight: '(?:午夜|半夜|凌晨)'
  after: '後'
  today: '(?:今|今天|今日)'
  tomorrow: '(?:明|明天|明日)'
  acquired: '(?:後天|後日)'
  yesterday: '(?:昨天|昨日)'
  the_day_before_yesterday: '(?:前天|前日)'
  this: '(?:這|這個|今)'
  next: '(?:下|下個|明)'
  previous: '(?:上|上個|去|昨)'
  week: '(?:禮拜|星期|週|周)'
  year: '(?:年|\\/|\\-)'
  year_relative: '(?:今年|去年|明年)'
  month: '(?:月|\\/|\\-)'
  month_relative: '(?:這個月|上個月|下個月)'
  day: '(?:日|號|\\/|\\-)'
  to: '(?:到|－|-|~)'
  event_prefix: '(?:有|要|的|，| )'
  event_postfix: '(?:在|，| )'
  separator: '(?:個|的|，| )'
  unit: '(?:個)'
  interjections: '(?:左右|大概|又|吧)'

words.numbers = "(?:#{words.zero}|#{words.one}|#{words.two}|#{words.three}|#{words.four}|#{words.five}|#{words.six}|#{words.seven}|#{words.eight}|#{words.nine}|#{words.ten}|#{words.half}|#{words.unit})"
words.zero_to_nine = "(?:#{words.zero}|#{words.one}|#{words.two}|#{words.three}|#{words.four}|#{words.five}|#{words.six}|#{words.seven}|#{words.eight}|#{words.nine})"
words.am = "(?:#{words.midnight}|#{words.morning})"
words.pm = "(?:#{words.noon}|#{words.afternoon}|#{words.night})"
words.this_previous_next = "(?:#{words.this}|#{words.previous}|#{words.next})"
words.dayPeriods = "(?:#{words.morning}|#{words.noon}|#{words.afternoon}|#{words.night}|#{words.midnight})"
words.time = "(?:#{words.numbers}+#{words.hour}(?:#{words.numbers}+)?(?:#{words.minute})?(?:#{words.numbers}+)?(?:#{words.second})?)"
words.like_time = "(?:#{words.numbers}+(?:#{words.numbers}|#{words.hour}|#{words.minute}|#{words.second}){1,12})"
words.dayTime = "(?:(?:#{words.dayPeriods}?#{words.separator}?#{words.like_time}) ?#{words.dayPeriods}?|#{words.dayPeriods})"
words.year_month_day = "(?:#{words.year}|#{words.month}|#{words.day}|#{words.year_relative}|#{words.month_relative})"
words.date = "(?:(?:(?:(?:#{words.numbers}{1,4}|#{words.this_previous_next}) ?#{words.year})? ?(?:#{words.numbers}{1,3}|#{words.this_previous_next}) ?#{words.month})? ?#{words.numbers}{1,3} ?#{words.day}?)"
words.like_date = "(?:(?:#{words.numbers}|#{words.year_month_day}){1,12}#{words.year_month_day}#{words.numbers}{0,3})"
words.weekdays = "(?:#{words.zero}|#{words.one}|#{words.two}|#{words.three}|#{words.four}|#{words.five}|#{words.six}|#{words.seven}|#{words.sun}|#{words.end})"
words.weekExpression = "(?:#{words.this_previous_next}?#{words.week}#{words.weekdays})"
words.dateExpression = "(?:#{words.like_date}|#{words.weekExpression}|#{words.today}|#{words.tomorrow}|#{words.acquired}|#{words.yesterday}|#{words.the_day_before_yesterday})"
words.separators = "(?:#{words.event_prefix}|#{words.event_postfix})"

number2integer = (number) ->
  return null if not number
  if match = number.match RegExp("(#{words.zero_to_nine})(#{words.zero_to_nine})(#{words.zero_to_nine})(#{words.zero_to_nine})")
    return number2integer(match[1])*1000 + number2integer(match[2])*100 + number2integer(match[3])*10 + number2integer(match[4])
  else if match = number.match RegExp("(#{words.zero_to_nine})(#{words.ten})?(#{words.zero_to_nine})#{words.unit}?")
    n = number2integer(match[3])
    n = 0 if n >= 10
    return number2integer(match[1])*10 + n
  else if match = number.match RegExp("#{words.ten}(#{words.zero_to_nine})#{words.unit}?")
    return number2integer(match[1]) + 10
  else if match = number.match RegExp("(#{words.zero_to_nine})#{words.ten}#{words.unit}?")
    return number2integer(match[1])*10
  else if match = number.match RegExp("(#{words.numbers}+)#{words.unit}#{words.half}")
    return number2integer(match[1]) + 0.5
  else if number.match RegExp(words.half)
    return 0.5
  else if number.match RegExp(words.zero)
    return 0
  else if number.match RegExp(words.one)
    return 1
  else if number.match RegExp(words.two)
    return 2
  else if number.match RegExp(words.three)
    return 3
  else if number.match RegExp(words.four)
    return 4
  else if number.match RegExp(words.five)
    return 5
  else if number.match RegExp(words.six)
    return 6
  else if number.match RegExp(words.seven)
    return 7
  else if number.match RegExp(words.sun)
    return 7
  else if number.match RegExp(words.eight)
    return 8
  else if number.match RegExp(words.nine)
    return 9
  else if number.match RegExp(words.ten)
    return 10
  else
    return null

time2object = (time) ->
  return null if not time
  if match = time.match RegExp("(?:(#{words.numbers}+)#{words.hour}(#{words.numbers}*)(?:#{words.minute})?(#{words.numbers}*)(?:#{words.second})?)")
    hour = number2integer(match[1]) or 0
    minute = number2integer(match[2]) or 0
    second = number2integer(match[3]) or 0
    minute = 30 if minute == 0.5
    if hour == 30
      hour = 0
      minute += 30
    if (f = hour % 1) > 0
      hour -= f
      minute += 30
    while second > 60
      second -= 60
      minute += 1
    while minute > 60
      minute -= 60
      hour += 1
    return {
      hour: hour,
      minute: minute,
      second: second
    }
  else
    return null

dayTime2moment = (daytime, timezone, moment) ->
  return null if not daytime
  if match = daytime.match RegExp("(?:(?:(#{words.dayPeriods})?#{words.separator}?(#{words.time}) ?(#{words.dayPeriods})?)|(#{words.dayPeriods}))")
    if period = match[4]
      moment = moment or Moment().tz(timezone)
      moment.endMoment = moment?.endMoment or (moment and Moment(moment).tz(timezone)) or Moment().tz(timezone)
      moment.minute(0)
      moment.second(0)
      moment.endMoment.minute(0)
      moment.endMoment.second(0)
      if period.match RegExp(words.morning)
        moment.hour(9)
        moment.endMoment.hour(11)
      else if period.match RegExp(words.noon)
        moment.hour(12)
        moment.endMoment.hour(13)
      else if period.match RegExp(words.afternoon)
        moment.hour(14)
        moment.endMoment.hour(16)
      else if period.match RegExp(words.night)
        moment.hour(18)
        moment.endMoment.hour(20)
      else if period.match RegExp(words.midnight)
        moment.hour(0)
        moment.endMoment.hour(4)
      return moment
    else
      period = match[1] or match[3] or ''
      time = time2object(match[2])
      return null if not time
      time.hour += 12 if period.match(RegExp(words.pm)) and time.hour < 12
      moment = moment or Moment().tz(timezone)
      if time.hour < 12 and not period
        time.hour += 12 if time.hour > (moment.hour() - 12) and time.hour < moment.hour()
      moment.hour(time.hour)
      moment.minute(time.minute or 0)
      moment.second(time.second or 0)
      return moment
  else
    return null

date2object = (date) ->
  return null if not date
  if match = date.match RegExp("(?:(?:(?:(#{words.numbers}+|#{words.this_previous_next}) ?#{words.year})? ?(#{words.numbers}+|#{words.separator}|#{words.this_previous_next}) ?#{words.month})? ?(?:(#{words.numbers}+) ?#{words.day}?))")
    now = Moment()
    year = number2integer(match[1]) or null
    if year and year < 100
      c = parseInt(now.year()/100)*100
      year = year + c
    month = number2integer(match[2]) or null
    day = number2integer(match[3]) or null
    if match[1]?.match RegExp(words.this)
      year = now.year()
    else if match[1]?.match RegExp(words.previous)
      year = now.year() - 1
    else if match[1]?.match RegExp(words.next)
      year = now.year() + 1
    if match[2]?.match RegExp(words.this)
      year = now.month() + 1
    else if match[2]?.match RegExp(words.previous)
      month = now.month()
    else if match[2]?.match RegExp(words.next)
      month = now.month() + 2
    return {
      year: year,
      month: month,
      day: day
    }
  else
    return null

dateExpression2moment = (dateExp, timezone) ->
  return null if not dateExp
  moment = Moment().tz(timezone)
  moment.hour(0)
  moment.minute(0)
  moment.second(0)
  if match = dateExp.match RegExp("#{words.today}[^#{words.year}]*$")
    return moment
  else if match = dateExp.match RegExp("#{words.tomorrow}[^#{words.year}]*$")
    moment.date moment.date() + 1
    return moment
  else if match = dateExp.match RegExp(words.acquired)
    moment.date moment.date() + 2
    return moment
  else if match = dateExp.match RegExp(words.yesterday)
    moment.date moment.date() - 1
    return moment
  else if match = dateExp.match RegExp(words.the_day_before_yesterday)
    moment.date moment.date() - 2
    return moment
  else if match = dateExp.match RegExp("(#{words.this_previous_next})?#{words.week}(#{words.weekdays})")
    if match[1]?.match RegExp(words.previous)
      moment.date moment.date() - 7
    else if match[1]?.match RegExp(words.next)
      moment.date moment.date() + 7
    day = number2integer(match[2])
    if match[2].match RegExp(words.end)
      day = 6
    moment.date moment.date() + 7 if day == 7
    day = 0 if day >= 7
    moment.day day
    if match[2].match RegExp(words.end)
      moment.endMoment = Moment(moment).tz(timezone)
      moment.endMoment.date moment.date() + 1
    return moment
  else if match = dateExp.match RegExp(words.like_date)
    dateObj = date2object(match[0])
    return null unless dateObj
    moment.date(dateObj.day) if dateObj.day
    moment.month(dateObj.month - 1) if dateObj.month
    moment.year(dateObj.year) if dateObj.year
    return moment
  else return null

expressions = []

# 「<事件> 時間後 <在...> <事件>」
expressions.push (text, timezone) ->
  if match = text.match RegExp("^(?:([^#{words.separators}]+) ?#{words.event_postfix} ?)?(#{words.time})#{words.after} ?(?:#{words.at} ?([^#{words.separators}]+))? ?(?:#{words.event_prefix}#{words.separator}?([^#{words.separators}]+))?$")
    time = time2object(match[2])
    location = match[3]
    eventName = match[1] or match[4]
    moment = Moment().tz(timezone)
    moment.hour moment.hour() + time.hour
    moment.minute moment.minute() + time.minute
    moment.second moment.second() + time.second
    date = moment.toDate()
    date.location = location if location
    date.eventName = eventName if eventName
    return date

# 「<事件> 日期 <時間> 到 日期 <時間> <在...> <事件>」
expressions.push (text, timezone) ->
  if match = text.match RegExp("^(?:([^#{words.separators}]+) ?#{words.event_postfix})? ?(#{words.dateExpression}) ?(#{words.dayTime})? ?(?:#{words.to} ?(#{words.dateExpression}) ?(#{words.dayTime})? ?) ?(?:#{words.at} ?([^#{words.separators}]+))? ?(?:#{words.event_prefix}#{words.separator}?([^#{words.separators}]+))?$")
    moment = dateExpression2moment(match[2], timezone) or Moment().tz(timezone)
    moment = dayTime2moment(match[3], timezone, moment) if match[3]
    if not match[3] and not match[5]
      fullDay = true
    location = match[6]
    eventName = match[1] or match[7]
    moment.endMoment = dateExpression2moment(match[4], timezone) if match[4]
    if moment.endMoment and match[5]
      moment.endMoment = dayTime2moment(match[5], timezone, moment.endMoment)
    else if moment.endMoment and not match[5]
      moment.endMoment.hour(23)
      moment.endMoment.minute(59)
      moment.endMoment.second(59)
    date = moment.toDate()
    date.endTime = moment.endMoment.toDate() if moment.endMoment
    date.location = location if location
    date.eventName = eventName if eventName
    date.fullDay = fullDay if fullDay
    return date

# 「<事件> 日期 時間 <到 時間> <在...> <事件>」
expressions.push (text, timezone) ->
  if match = text.match RegExp("^(?:([^#{words.separators}]+) ?#{words.event_postfix})? ?(?:(#{words.dateExpression})) ?(#{words.dayTime}) ?(?:#{words.to} ?(#{words.dayTime}) ?)? ?(?:#{words.at} ?([^#{words.separators}]+))? ?(?:#{words.event_prefix}#{words.separator}?([^#{words.separators}]+))?$")
    moment = dateExpression2moment(match[2], timezone) or Moment().tz(timezone)
    moment = dayTime2moment(match[3], timezone, moment) if match[3]
    moment.endMoment = dayTime2moment(match[4], timezone, Moment(moment)) if match[4]
    location = match[5]
    eventName = match[1] or match[6]
    date = moment.toDate()
    date.location = location if location
    date.eventName = eventName if eventName
    date.endTime = moment.endMoment.toDate() if moment.endMoment
    return date

# 「<事件> 時間 <到 時間> <在...> <事件>」
expressions.push (text, timezone) ->
  if match = text.match RegExp("^(?:([^#{words.separators}]+) ?#{words.event_postfix})? ?(#{words.dayTime}) ?(?:#{words.to} ?(#{words.dayTime}) ?)? ?(?:#{words.at} ?([^#{words.separators}]+))? ?(?:#{words.event_prefix}#{words.separator}?([^#{words.separators}]+))?$")
    moment = dayTime2moment(match[2], timezone) if match[2]
    moment.endMoment = dayTime2moment(match[3], timezone)
    location = match[4]
    eventName = match[1] or match[5]
    date = moment.toDate()
    date.location = location if location
    date.eventName = eventName if eventName
    date.endTime = moment.endMoment.toDate() if moment.endMoment
    return date

# 「<事件> 日期 <時間> <到 日期 <時間>> <在...> <事件>」
expressions.push (text, timezone) ->
  if match = text.match RegExp("^(?:([^#{words.separators}]+) ?#{words.event_postfix})? ?(#{words.dateExpression}) ?(#{words.dayTime})? ?(?:#{words.to} ? (#{words.dateExpression}) ?(#{words.dayTime})? ?)? ?(?:#{words.at} ?([^#{words.separators}]+))? ?(?:#{words.event_prefix}#{words.separator}?([^#{words.separators}]+))?$")
    location = match[6]
    eventName = match[1] or match[7]
    moment = dateExpression2moment(match[2], timezone) or Moment().tz(timezone)
    moment = dayTime2moment(match[3], timezone, moment) if match[3]
    if not match[3] and not match[5]
      fullDay = true
    moment.endMoment = dateExpression2moment(match[5], timezone, moment.endMoment) if match[5]
    if moment.endMoment and match[5]
      moment.endMoment = dayTime2moment(match[5], timezone, moment.endMoment)
    else if moment.endMoment and not match[5]
      moment.endMoment.hour(23)
      moment.endMoment.minute(59)
      moment.endMoment.second(59)
    date = moment.toDate()
    date.location = location if location
    date.eventName = eventName if eventName
    date.endTime = moment.endMoment.toDate() if moment.endMoment
    date.fullDay = fullDay if fullDay
    return date

module.exports =
  words: words
  expressions: expressions
  number2integer: number2integer
  time2object: time2object
  dayTime2moment: dayTime2moment
  date2object: date2object
  dateExpression2moment: dateExpression2moment
  testStrings: ['明天晚上到下禮拜六早上要開會', '10月10號 早上 10:00 ~ 下午 4:00', '十月十號']

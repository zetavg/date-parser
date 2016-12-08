DateParser =

  LOCALES:
    'zh-TW': require "./lib/zh-TW"

  DEFAULT_LOCALE: 'zh-TW'
  DEFAULT_TIMEZONE: 'Asia/Taipei'

  locale: (locale) ->
    if @LOCALES[locale]
      @DEFAULT_LOCALE = locale
      @LOCALES[locale].testStrings?.forEach (s) =>
        @parse s
    else
      console.error "No such locale: #{locale}"

  timezone: (timezone) ->
    @DEFAULT_TIMEZONE = timezone

  parse: (text, timezone, locale) ->
    text = '' unless text
    locale = @DEFAULT_LOCALE unless locale
    timezone = @DEFAULT_TIMEZONE unless timezone
    expressions = @LOCALES[locale]?.expressions
    text = text.replace(RegExp(@LOCALES[locale]?.words?.interjections, 'g'), '') if @LOCALES[locale]?.words?.interjections
    if not expressions
      console.error "No such locale: #{locale}"
      return null
    for expression in @LOCALES[locale].expressions
      try
        result = expression(text, timezone)
        console.log result
        return result if result
      catch error
        console.error 'error', error
    return null

  number2integer: (text, locale) ->
    text = '' unless text
    locale = @DEFAULT_LOCALE unless locale
    return @LOCALES[locale]?.number2integer?(text)

  time2object: (text, locale) ->
    text = '' unless text
    locale = @DEFAULT_LOCALE unless locale
    return @LOCALES[locale]?.time2object?(text)

  dayTime2moment: (text, locale) ->
    text = '' unless text
    locale = @DEFAULT_LOCALE unless locale
    return @LOCALES[locale]?.dayTime2moment?(text)

  date2object: (text, locale) ->
    text = '' unless text
    locale = @DEFAULT_LOCALE unless locale
    return @LOCALES[locale]?.date2object?(text)

  dateExpression2moment: (text, locale) ->
    text = '' unless text
    locale = @DEFAULT_LOCALE unless locale
    return @LOCALES[locale]?.dateExpression2moment?(text)

DateParser.locale('zh-TW')

module.exports = DateParser

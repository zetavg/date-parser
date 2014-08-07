DateParser =

  LOCALES:
    'zh-TW': require "./lib/zh-TW"

  DEFAULT_LOCALE: 'zh-TW'

  locale: (locale) ->
    if @LOCALES[locale]
      @DEFAULT_LOCALE = locale
      @LOCALES[locale].testStrings?.forEach (s) =>
        @parse s
    else
      console.error "No such locale: #{locale}"

  parse: (text, locale) ->
    text = '' unless text
    locale = @DEFAULT_LOCALE unless locale
    expressions = @LOCALES[locale]?.expressions
    if not expressions
      console.error "No such locale: #{locale}"
      return null
    for expression in @LOCALES[locale].expressions
      try
        result = expression(text)
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

  dayTime2date: (text, locale) ->
    text = '' unless text
    locale = @DEFAULT_LOCALE unless locale
    return @LOCALES[locale]?.dayTime2date?(text)

  date2object: (text, locale) ->
    text = '' unless text
    locale = @DEFAULT_LOCALE unless locale
    return @LOCALES[locale]?.date2object?(text)

  dateExpression2date: (text, locale) ->
    text = '' unless text
    locale = @DEFAULT_LOCALE unless locale
    return @LOCALES[locale]?.dateExpression2date?(text)

DateParser.locale('zh-TW')

module.exports = DateParser

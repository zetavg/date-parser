# date-parser

Turn spoken datetime into Date object. Only Traditional Chinese is supported now.

## Installation

### Node.js

```bash
$ npm install --save date-parser
$ node
> dateParser = require('date-parser');
```

### Browser

```html
<script src="./script/date-parser.min.js"></script>
```

## Usage

### I18n

Select the default locale with:

```js
dateParser.locale('zh-TW');
dateParser.timezone('Asia/Taipei');
```

Or just specify it on the go:

```js
dateParser.parse('二零一四年五月五日', 'Asia/Taipei', 'zh-TW');
```

### Datetime Parse

The date-parser can parse any kind of spoken datetime into an Data object:

```js
dateParser.parse('2014年10月20日');  // -> Mon Oct 20 2014 00:00:00 GMT+0800 (CST)
dateParser.parse('二零一四年五月五日');  // -> Mon May 05 2014 00:00:00 GMT+0800 (CST)
dateParser.parse('2010/2/28 晚上八點');  // -> Sun Feb 28 2010 20:00:00 GMT+0800 (CST)
dateParser.parse('今天中午');  // -> (Today!) 12:00:00 GMT+0800 (CST)
```

You can just say an incomplete sentence, the parser will smartly guesses what you want:

```js
dateParser.parse('中午');  // -> (Today!) 12:00:00 GMT+0800 (CST)
dateParser.parse('今晚');  // -> (Today!) 18:00:00 GMT+0800 (CST)
dateParser.parse('三點半');  // -> (Today!) 15:30:00 GMT+0800 (CST) (or 03:30:00, depends on current time)
dateParser.parse('五月五');  // -> ... May 05 ... 00:00:00 GMT+0800 (CST)
dateParser.parse('星期五晚上');  // -> Fri ... 18:00:00 GMT+0800 (CST)
```

Relative datetime is supported too.

```js
dateParser.parse('下星期五晚上');  // -> Fri ... 18:00:00 GMT+0800 (CST)
dateParser.parse('兩小時後');  // -> ...
dateParser.parse('這週末');  // -> ...
dateParser.parse('明天凌晨三點');  // -> (Tomorrow!) 03:00:00 GMT+0800 (CST)
dateParser.parse('明年一月一號');  // -> ... Jan 01 ... 00:00:00 GMT+0800 (CST)
```

You can specify an ending datetime if needed:

```js
meeting = dateParser.parse('早上八點到晚上十點');  // -> { (Today!) 08:00:00 GMT+0800 endTime: (Today!) 22:00:00 GMT+0800 }
meeting.endTime;  // -> (Today!) 22:00:00 GMT+0800
party = dateParser.parse('週五 6:00pm ~ 週六 10:00am');  // -> { Fri ... 18:00:00 GMT+0800 endTime: Sat ... 08:00:00 GMT+0800 }
party.endTime;  // -> Sat ... 08:00:00 GMT+0800
```

BTW, the event's name and location can also be parsed out.

```js
play = dateParser.parse('星期五晚上到下禮拜六早上要一直玩一直玩一直玩');
//  -> { ... 18:00:00 GMT+0800
//       eventName: '一直玩一直玩一直玩',
//       endTime: ... 09:00:00 GMT+0800 }
play.eventName;  // -> '一直玩一直玩一直玩'
dateParser.parse('今天晚上在聽風家有披薩吃');
//  -> { ... 18:00:00 GMT+0800
//       location: '聽風家',
//       eventName: '披薩吃' }
dateParser.parse('明天中午到下午要開會');
//  -> { (Tomorrow!) 12:00:00 GMT+0800
//       eventName: '開會',
//       endTime: (Tomorrow!) 14:00:00 GMT+0800 }
```

___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "categories": ["UTILITY", "AFFILIATE_MARKETING"],
  "securityGroups": [],
  "displayName": "アフィリエイト連携",
  "brand": {
    "id": "intimatemerger",
    "displayName": "IntimateMerger"
  },
  "description": "アフィリエイトサービスの成果計測情報を永続化します",
  "containerContexts": [
    "SERVER"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "CHECKBOX",
    "name": "gorillaEnabled",
    "checkboxText": "ゴリラASP",
    "simpleValueType": true,
    "defaultValue": false
  },
  {
    "type": "TEXT",
    "name": "gorillaExpiration",
    "displayName": "有効期限",
    "simpleValueType": true,
    "defaultValue": 30,
    "valueUnit": "日",
    "valueValidators": [
      {
        "type": "NON_NEGATIVE_NUMBER"
      }
    ]
  },
  {
    "type": "CHECKBOX",
    "name": "lombardEnabled",
    "checkboxText": "ロンバード",
    "simpleValueType": true,
    "defaultValue": false
  },
  {
    "type": "TEXT",
    "name": "lombardExpiration",
    "displayName": "有効期限",
    "simpleValueType": true,
    "valueUnit": "日",
    "defaultValue": 30
  },
  {
    "type": "CHECKBOX",
    "name": "accesstradeEnabeld",
    "checkboxText": "アクセストレード",
    "simpleValueType": true,
    "defaultValue": false
  },
  {
    "type": "TEXT",
    "name": "accesstradeExpiration",
    "displayName": "有効期限",
    "simpleValueType": true,
    "defaultValue": 30,
    "valueUnit": "日"
  },
  {
    "type": "LABEL",
    "name": "promotion",
    "displayName": "連携先追加を\u003ca href\u003d\"https://intimatemerger.com/r/Uz8r4D72N\"\u003eリクエスト\u003c/a\u003e\u003cbr/\u003eサーバーサイドGTMコスト削減の\u003ca href\u003d\"https://intimatemerger.com/r/ilf8J5icZ\"\u003eご相談\u003c/a\u003e"
  }
]


___SANDBOXED_JS_FOR_SERVER___

const getRequestHeader = require('getRequestHeader');
const computeEffectiveTldPlusOne = require('computeEffectiveTldPlusOne');
const setCookie = require('setCookie');
const getCookieValues = require('getCookieValues');
const getTimestampMillis = require('getTimestampMillis');
const generateRandom = require('generateRandom');
const makeInteger = require('makeInteger');
const Math = require('Math');
const log = require('logToConsole');

let domain = computeEffectiveTldPlusOne(getRequestHeader('host'));
log("domain = " + domain);

function generateNoahId() {
  const base32chars = '0123456789abcdefghjkmnpqrstvwxyz';
  const ary36chars = '01234567890abcdefgehjklmnopqrstuvwxyz';
  let ts = getTimestampMillis();
  let i = 10;
  let prefix = '';
  log("timestamp = " + ts);
  while (i--) {
    let digit = ts % 32;
    prefix = base32chars[digit] + prefix;
    ts = (ts - digit) / 32;
  }
  let suffix = '';
  for (i = 0; i < 2; i++) {
    let rnd = generateRandom(1679616, 60466175); 
    do {
      suffix  = ary36chars[rnd % 36] + suffix;
      rnd = Math.floor(rnd / 36);
    } while (rnd > 0);
  }
  return prefix + suffix;
}

function processNoah() {
  const key = '_im_noah';
  let value = getCookieValues(key)[0];
  if (! value) {
    value = generateNoahId();
    log("noah = " + value);
  }
  let options = { 
    'path': "/",
    'max-age': 86400 * 400,
    'secure': true
  };
  if (domain) {
    options.domain = domain;
  }
  setCookie(key, value, options);
}

function processSetCoookie(cookies, expiration) {
  let options = { path: "/", secure: true  };
  if (domain) {
    options.domain = domain;
  }
  options['max-age'] = expiration > 0 ? expiration * 86400 : 60;
  cookies.forEach(cookie => {
    let value = getCookieValues(cookie, true)[0];
    if (value) {
      log("setcookie: " + cookie + " = " + value);
      setCookie(cookie, value, options, true);
    }
  });
}

processNoah();

if (data.gorillaEnabled) {
  let cookies = ['_itm_src', '_itm_medium', '_itm_content', '_itm_rid'];
  processSetCoookie(cookies, data.gorillaExpiration);
}
if (data.lombardEnabled) {
  let cookies = ['_fmcs'];
  processSetCoookie(cookies, data.lombardExpiration);
}
if (data.accesstradeEnabeld) {
  let cookies = ['_atnct'];
  processSetCoookie(cookies, data.accesstradeExpiration);
}

data.gtmOnSuccess();


___SERVER_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "read_request",
        "versionId": "1"
      },
      "param": [
        {
          "key": "requestAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "headerAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "queryParameterAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "cookieAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "set_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedCookies",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "name"
                  },
                  {
                    "type": 1,
                    "string": "domain"
                  },
                  {
                    "type": 1,
                    "string": "path"
                  },
                  {
                    "type": 1,
                    "string": "secure"
                  },
                  {
                    "type": 1,
                    "string": "session"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  },
                  {
                    "type": 1,
                    "string": "any"
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []
setup: ''


___NOTES___

Created on 2022/4/7 0:07:44



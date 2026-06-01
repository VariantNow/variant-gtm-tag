___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (later "Developer Terms").

___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Variant A/B Testing & Pixel",
  "categories": ["EXPERIMENTATION", "ANALYTICS", "PERSONALIZATION"],
  "brand": {
    "id": "brand_variant",
    "displayName": "Variant"
  },
  "description": "Installs Variant on your store: loads the Variant storefront SDK (A/B test runner) and the Variant analytics pixel with a single tag. Enter your Variant Shop ID and SDK Key to start running experiments and collecting analytics. Fire this tag on Initialization / All Pages.",
  "containerContexts": [
    "WEB"
  ]
}

___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "shopId",
    "displayName": "Variant Shop ID",
    "simpleValueType": true,
    "help": "Your Variant Shop ID. Find it in the Variant dashboard under \u003Cb\u003ESettings → Install\u003C/b\u003E.",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "sdkKey",
    "displayName": "Variant SDK Key",
    "simpleValueType": true,
    "help": "Your Variant SDK (client) key. Find it in the Variant dashboard under \u003Cb\u003ESettings → Install\u003C/b\u003E.",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  },
  {
    "type": "CHECKBOX",
    "name": "enableDomEvents",
    "checkboxText": "Enable automatic DOM event tracking (clicks \u0026 scroll depth)",
    "simpleValueType": true,
    "defaultValue": true
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// Variant — A/B Testing & Pixel
// Loads two Variant scripts on the page:
//   1. The Variant analytics pixel (pixel.js)
//   2. The Variant storefront SDK / A/B test runner (test-runner.js)
//
// GTM sandboxed JS cannot add data-* attributes to an injected <script>, so the
// storefront SDK configuration is passed through window.GB_CONFIG, which the
// SDK reads before falling back to script-tag attributes.

const injectScript = require('injectScript');
const setInWindow = require('setInWindow');
const callInWindow = require('callInWindow');
const logToConsole = require('logToConsole');

const PIXEL_URL = 'https://storage.googleapis.com/variant_scripts/pixel.js?cache=9';
const SDK_URL = 'https://sdk.variantnow.com/test-runner.js';

const shopId = data.shopId;
const sdkKey = data.sdkKey;
const enableDomEvents = data.enableDomEvents !== false;

if (!shopId || !sdkKey) {
  logToConsole('Variant: missing Shop ID or SDK Key — tag not fired.');
  data.gtmOnFailure();
  return;
}

// Configure the storefront SDK before it loads. It reads window.GB_CONFIG first.
setInWindow('GB_CONFIG', {
  sdkKey: sdkKey,
  variantShopId: shopId
}, true);

let remaining = 2;
let failed = false;

function onOneLoaded() {
  remaining = remaining - 1;
  if (remaining === 0 && !failed) {
    data.gtmOnSuccess();
  }
}

function onLoadError(url) {
  if (!failed) {
    failed = true;
    logToConsole('Variant: failed to load ' + url);
    data.gtmOnFailure();
  }
}

// 1) Variant analytics pixel. Initialize it once the script has loaded.
injectScript(PIXEL_URL, function () {
  callInWindow('VariantPixel.init', {
    shopId: shopId,
    domEvents: enableDomEvents
  });
  onOneLoaded();
}, function () {
  onLoadError(PIXEL_URL);
}, PIXEL_URL);

// 2) Variant storefront SDK / A/B test runner. Reads window.GB_CONFIG.
injectScript(SDK_URL, onOneLoaded, function () {
  onLoadError(SDK_URL);
}, SDK_URL);

___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "inject_script",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://storage.googleapis.com/variant_scripts/*"
              },
              {
                "type": 1,
                "string": "https://sdk.variantnow.com/*"
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
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "GB_CONFIG"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "VariantPixel.init"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
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

___NOTES___

Variant — A/B Testing & Pixel community template.
Loads the Variant analytics pixel (storage.googleapis.com/variant_scripts/pixel.js)
and the Variant storefront SDK / test runner (sdk.variantnow.com/test-runner.js).
Configuration is passed to the SDK via window.GB_CONFIG and to the pixel via
VariantPixel.init(). Recommended trigger: Initialization - All Pages.

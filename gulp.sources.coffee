_       = require 'lodash'
sources = {}

stripSrc  = (arr) -> _.map arr, (str) -> str.replace('./src/', '')
toJs      = (arr) -> _.map arr, (str) -> str.replace('.coffee', '.js').replace('./src/', 'js/')
unmin     = (arr) ->
  _.map arr, (str) -> str.replace('dist/angulartics', 'src/angulartics').replace('.min.js', '.js')

sources.checkoutJs = () ->
  [].concat stripSrc(unmin(sources.checkoutVendorMin))
    .concat stripSrc(sources.checkoutVendorUnmin)
    .concat toJs(sources.appModule)
    .concat toJs(sources.checkoutModule)
    .concat toJs(sources.checkoutDirective)

sources.checkoutModules = () ->
  [].concat sources.appModule
    .concat sources.checkoutModule
    .concat sources.checkoutDirective

### VENDOR ###
sources.checkoutVendorMin = [
  './src/bower_components/angular/angular.min.js'
  # './src/bower_components/angular-sanitize/angular-sanitize.min.js'
  './src/bower_components/angular-cookies/angular-cookies.min.js'
  './src/bower_components/angular-animate/angular-animate.min.js'
  './src/bower_components/angular-bootstrap/ui-bootstrap.min.js'
  './src/bower_components/angular-bootstrap/ui-bootstrap-tpls.min.js'
  './src/bower_components/angular-ui-router/release/angular-ui-router.min.js'
  # './src/bower_components/angulartics/dist/angulartics.min.js'
  # './src/bower_components/angulartics/dist/angulartics-ga.min.js'
  './src/bower_components/keen-js/dist/keen.min.js'
]
sources.checkoutVendorUnmin = [
  './src/bower_components/braintree-web/dist/braintree.js'
  ## TODO remove when stripe is removed
  './src/bower_components/angular-stripe/release/angular-stripe.js'
  './src/bower_components/angular-credit-cards/release/angular-credit-cards.js'
]

### MODULE ###
sources.appModule = [
  # Definitions
  './src/ee-shared/core/core.module.coffee'
  './src/ee-shared/core/constants.coffee'
  './src/ee-shared/core/filters.coffee'
  # './src/checkout/core/config.coffee'
  # './src/ee-shared/core/config.coffee'
  './src/ee-shared/core/run.coffee'
  # Services
  './src/ee-shared/core/svc.modal.coffee'
]
sources.checkoutModule = [
  # Definitions
  './src/checkout/checkout.index.coffee'
  './src/checkout/core/core.module.coffee'
  './src/checkout/core/run.coffee'
  './src/checkout/core/config.coffee'
  './src/checkout/core/core.route.coffee'
  # Services
  './src/checkout/core/svc.back.coffee'
  './src/checkout/core/svc.cart.coffee'
  # './src/checkout/core/svc.modal.coffee'
  # Module - checkout
  './src/checkout/checkout.controller.coffee'
  # Module - collection
  # './src/checkout/collection.controller.coffee'
  # Module - cart
  # './src/checkout/cart.controller.coffee'
  # Module - modal
  # './src/checkout/modal/modal.controller.coffee'
]

### DIRECTIVES ###
sources.checkoutDirective = [
  './src/ee-shared/components/ee-storefront-header.coffee'
  './src/ee-shared/components/ee-storefront-logo.coffee'
  './src/ee-shared/components/ee-exp-combined.coffee'
]

module.exports = sources

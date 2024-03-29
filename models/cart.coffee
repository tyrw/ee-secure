Promise   = require 'bluebird'
_         = require 'lodash'
url       = require 'url'
sequelize = require '../config/sequelize/setup'
constants = require '../server.constants'
utils     = require './utils'

# Shared    = require '../copied-from-ee-back/shared'

User      = require './user'
Sku       = require './sku'

Cart =

  findByUUID: (uuid) ->
    sequelize.query 'SELECT id, uuid, seller_id, quantity_array, cumulative_price, taxes_total, shipping_total, grand_total, coupon_id, coupon_total, purchased, domain FROM "Carts" WHERE uuid = ?', { type: sequelize.QueryTypes.SELECT, replacements: [uuid] }

  defineCheckoutByUUID: (uuid, bootstrap) ->
    Cart.findByUUID uuid
    .then (data) ->
      bootstrap.cart = data[0]
      utils.assignPaths bootstrap, utils.constructRoot(bootstrap.cart.domain)
      User.findById data[0].seller_id
    .then (data) ->
      user = data[0]
      utils.assignBootstrap bootstrap, user

  addTotals: (cart, user) ->
    sku_ids = _.pluck cart.quantity_array, 'sku_id'
    Sku.forCheckout sku_ids, user
    .then (skus) ->
      # cart.cumulative_price = 0
      # cart.shipping_total   = 0
      # cart.taxes_total      = 0
      for elem in cart.quantity_array
        sku = _.where(skus, { id: elem.sku_id })[0]
        if sku
          # cart.shipping_total   += sku.shipping_price * elem.quantity
          # cart.cumulative_price += sku.price * elem.quantity
          elem.sku = sku
          elem.product = sku.product
      # For Free shipping over $49
      # if cart.cumulative_price >= 4900 then cart.shipping_total = 0
      # cart.grand_total = cart.cumulative_price + cart.shipping_total + cart.taxes_total
      cart

module.exports = Cart

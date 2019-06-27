require 'pry'

def consolidate_cart(cart)
  new_cart = {}
  cart.each do |item|
    if new_cart[item.keys[0]]
      new_cart[item.keys[0]][:count] += 1
    else
      new_cart[item.keys[0]] = {
        price: item.values[0][:price],
        clearance: item.values[0][:clearance],
        count: 1
      }
    end
  end
  new_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.keys.include?(coupon[:item])
      if cart[coupon[:item]][:count] >= coupon[:num]
         discounted_tag = "#{coupon[:item]} W/COUPON"
         if cart[discounted_tag]
          cart[discounted_tag][:count] += coupon[:num]
         else
          cart[discounted_tag] = {
            count: coupon[:num],
            price: coupon[:cost]/coupon[:num],
            clearance: cart[coupon[:item]][:clearance]
          }
        end
        cart[coupon[:item]][:count] -= coupon[:num]
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.keys.each do |item|
    if cart[item][:clearance]
      cart[item][:price] = (cart[item][:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  cart_with_coupons = apply_coupons(consolidated_cart, coupons)
  cart_with_clearance = apply_clearance(cart_with_coupons)
  
  cart_total = 0
  cart_with_clearance.keys.each do |item|
    cart_total += cart_with_clearance[item][:price] * cart_with_clearance[item][:count]
  end
  if cart_total > 100
    cart_total *= 0.9
  end
  cart_total
end

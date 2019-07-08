def consolidate_cart(cart)
  copyHash = {}
  n = 0
  cart.each do
    cart[n].map {|food, values|copyHash[food] = values unless copyHash[food] == true} #pulls unique values out of array and inputs into a new hash
    n+=1
  end
  copyHash.map {|key, values| copyHash[key][:count] = 0} #adds count attribute to each food

  cart.each do |food|
    copyHash.map {|key, values| copyHash[key][:count] += 1 if food.include? key}
  end
  copyHash
end

def apply_coupons(cart, coupons)
  copyCart = cart
  coupons.each do |coupon|
    item = coupon[:item]
    if cart.include? item
      if cart[item][:count] > coupon[:num]
        while cart[item][:count] > coupon[:num]
        cart[item][:count] -= coupon[:num]
        if cart["#{item} W/COUPON"]
        cart["#{item} W/COUPON"] = cart[item]
        cart["#{item} W/COUPON"][:count] = coupon[:num]
        cart["#{item} W/COUPON"][:price] = coupon[:cost]/2
        end
      elsif cart[item][:count] == coupon[:num]
        cart[item][:count] = 1
        cart[item][:price] = coupon[:cost]/coupon[:num]
        cart["#{item} W/COUPON"] = cart[item]
        cart["#{item} W/COUPON"][:count] = coupon[:num] - 1
        cart["#{item} W/COUPON"][:price] = coupon[:cost] - cart[item][:price]
      else
        return cart
      end
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end

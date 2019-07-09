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

  couponNumHash = {}
  coupons.each do |food|
    if couponNumHash["#{food[:item]}"] == nil #sets couponNumHash, tracks number of possible items to coupon / tracks coupon count
      couponNumHash["#{food[:item]}"] = food[:num]
    else
      couponNumHash["#{food[:item]}"] += food[:num]
    end
    if cart.include? food[:item]
      cart["#{food[:item]} W/COUPON"] = {:price => food[:cost]/food[:num], :clearance => false, :count => couponNumHash[food[:item]]}
    end
  end
  cart.each_pair do |key, value| #key/value for coupon hashes
    if key.include? "COUPON"
      cart.each_pair do |food, stats| #key/value for food items
        if food != key #if not a coupon
          if key.include? food #if the right food to coupon
            value[:clearance] = stats[:clearance] #couponed items on clearance?

            if stats[:count] > value[:count]
              stats[:count] -= value[:count]
            elsif stats[:count] == value[:count]
              stats[:count] = 0
            elsif stats[:count] < value[:count]
              value[:price] = 0
            end
          end
        end
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each_pair do |key, value|
    if value[:clearance] == true
      value[:price] = (value[:price]*0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  total = 0
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  cart.each_pair do |food, values|
    total+=values[:price]*values[:count]
  end
  if total > 100
    total = (total*0.9).round(2)
  end
  puts cart
  total
end

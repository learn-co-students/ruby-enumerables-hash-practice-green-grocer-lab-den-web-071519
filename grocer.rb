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

    cart["#{food[:item]} W/COUPON"] = {:price => food[:cost]/food[:num], :clearance => false, :count => couponNumHash[food[:item]]}
  end
  cart.each_pair do |key, value| #key/value for coupon hashes
    if key.include? "COUPON"
      cart.each_pair do |food, stats| #key/value for food items
        if food != key #if not a coupon
          if key.include? food #if the right food to coupon









          end
        end
      end
    end
  end

  puts cart
  cart
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end

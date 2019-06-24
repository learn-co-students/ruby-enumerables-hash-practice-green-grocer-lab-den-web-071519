def consolidate_cart(cart)
  fin = {}
  cart.each do |element|
    element.each do |fruit, info|
      fin[fruit] ||= info
      fin[fruit][:count] ||= 0
      fin[fruit][:count] += 1
    end
  end
  p fin
end

def apply_coupons(cart, coupons = [])
    if coupons == []
        return cart
    end
    fin = cart
    coupons.each do |coupon|
        name = coupon[:item]
        c_num = coupon[:num]    
        if cart.include?(name) && cart[name][:count] >= c_num
           fin[name][:count] -= c_num
           if fin["#{name} W/COUPON"]
                fin["#{name} W/COUPON"][:count] += c_num
           else
                fin["#{name} W/COUPON"] = {
                    :price => (coupon[:cost] / c_num),
                    :clearance => fin[name][:clearance],
                    :count => c_num
                }
            end
        end
    end
    p fin
end

def apply_clearance(cart)
    bypass_arr = cart
    fin = bypass_arr
        bypass_arr.each do|item, hash|
            if hash[:clearance]
                 fin[item][:price] = (bypass_arr[item][:price] * 0.8).round(2)
             end
        end
    p fin
end

def checkout(cart, coupons)
    total = 0

  simi_fin = consolidate_cart(cart)
  apply_coupons(simi_fin, coupons)
  apply_clearance(simi_fin)

    simi_fin.each do |name, hash|
        total += (hash[:price] * hash[:count])
    end
    if total >= 100
        total *= 0.9
    end
    p total
end

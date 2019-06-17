require 'pry'

def consolidate_cart(cart)
  consolidated_cart_hash = {}
  name_array = []
  cart.each do |x|
    x.each do |a, b|
      name_array << a
      consolidated_cart_hash[a] = b
    end
  end

  consolidated_cart_hash.each do |hash_key, b|
    name_array.each do |array_name|
      if array_name == hash_key
        consolidated_cart_hash[hash_key][:count] = name_array.count(array_name)
      end
    end
  end
  consolidated_cart_hash
end

def apply_coupons(cart, coupons)
      new_cart = {}
      if coupons == []
        return cart
      else
        cart.each do |a, b| # a == "AVOCADO". b == {:price=>3.0, :clearance=>true, :count=>2}.

            coupons.each_with_index do |array_el, i|
              if cart.keys.include?(coupons[i][:item]) == false
                  return cart
              else

                array_el.each do |attribute, value|
                  if (attribute == :item && value == a) && (coupons[i][:num] <= cart[a][:count])

                    loop_count = 0

                    while (cart[a][:count] > 0) && (cart[a][:count] - coupons[i][:num] >= 0)
                      cart[a][:count] -= coupons[i][:num]
                      loop_count += 1
                    end
                    new_cart[a] = b
                    new_cart["#{a} W/COUPON"] = {}
                    new_cart["#{a} W/COUPON"][:price] = coupons[i][:cost]
                    new_cart["#{a} W/COUPON"][:clearance] = cart[a][:clearance]
                    new_cart["#{a} W/COUPON"][:count] = loop_count
                  else
                    new_cart[a] = b
                  end
                end
              end
              end
            end
        end
new_cart

end

def apply_clearance(cart)
cart.each do |a, b|
  b.each do |c, d|
    if c == :clearance && d == true
      cart[a][:price] = ((cart[a][:price])*0.80).round(1)
    end
  end
end
end

def checkout(cart, coupons)

  total_cost = 0

  consolidated_cart = consolidate_cart(cart)
  consolidated_and_couponed_cart = apply_coupons(consolidated_cart, coupons)
  clearance_coupons_applied = apply_clearance(consolidated_and_couponed_cart)

  clearance_coupons_applied.each do |a, b|
      total_cost += clearance_coupons_applied[a][:price] * clearance_coupons_applied[a][:count]
  end

  if total_cost > 100
    total_cost = (total_cost*0.9)
  end
  total_cost

end

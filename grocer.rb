require "pry"

def consolidate_cart(cart)
  hash = {}
  cart.each do |item| 
    item.each do |name, item_hash|
      if hash[name].nil? 
        hash[name] = item_hash.merge({:count => 1}) 
      else 
        hash[name][:count] += 1  
      end
    end
  end 
  hash
end

def consolidate_cart(cart)
  hash = {}
  cart.each do |item|  #to each item in array
    item.each do |name, item_hash| #separates each item into name and hash
      if hash[name].nil? #if no value for hash[name]
        hash[name] = item_hash.merge({:count => 1}) 
        #set it to hash above plus add count key equal to 1
      else 
        hash[name][:count] += 1  
        #otherwise add 1 to the count if already duplicates
      end
    end
  end 
  hash
end



def apply_coupons(cart, coupons)
    coupons.each do |coupon_hash|
      coupon_item = coupon_hash[:item] #Avocado
      if cart.keys.include?(coupon_hash[:item]) && cart[coupon_hash[:item]][:count] >= coupon_hash[:num]
        
        if cart["#{coupon_item} W/COUPON"]
          cart["#{coupon_item} W/COUPON"][:count] += coupon_hash[:num]
        else
        cart["#{coupon_item} W/COUPON"] = {
          :price => (coupon_hash[:cost]/coupon_hash[:num]),
          :clearance => cart["#{coupon_item}"][:clearance],
          :count => coupon_hash[:num]
          }

        end
        cart[coupon_item][:count] -= coupon_hash[:num]
      end
    end
  cart
end



def apply_clearance(cart)
  cart.each do |item, item_hash|
    if item_hash[:clearance] == true 
      discount = item_hash[:price] * 0.20
      item_hash[:price] -= discount
    end
  end
  cart 
end



def checkout(cart, coupons)
  all_items = consolidate_cart(cart) #item: price, clearance, count
  coupons_applied = apply_coupons(all_items, coupons)  
  all_discounts = apply_clearance(coupons_applied)
      
  total = all_discounts.reduce(0) do |memo, (item, item_info)|
    memo += (item_info[:price] * item_info[:count])
  end
      
  if total > 100
    discount = total * 0.10
    total -= discount
  end
  total
end
 












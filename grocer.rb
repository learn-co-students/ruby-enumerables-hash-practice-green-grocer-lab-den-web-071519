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
  coupon_hash = {}
  if coupons.nil?
    return cart
  else 
    coupons.each do |coup_hash|
        value_price = coup_hash[:cost]/coup_hash[:num] #calculate
        item = coup_hash[:item]
          if coupons.length >= 1 && cart.include?(item)
            item_hash = {
              "#{coup_hash[:item]} W/COUPON" => {
                :price => value_price,
                :clearance => cart[item][:clearance],
                :count => coup_hash[:num]
              }
            }
          else
            coupons.length >= 1 && !cart.include?(item)
            coupons -= coup_hash
          end
          
      cart.each do |food, food_hash| 
        food_hash[:count] -= coup_hash[:num]
      end
      
      final = coupon_hash.merge!(item_hash)
      cart.merge!(final)
    end
  end 
  return cart
end



def apply_clearance(cart)
  cart.each do |item, item_hash|
    if item_hash[:clearance] == true 
      discount = item_hash[:price] * 0.20
      item_hash[:price] -= discount
    end
  end
  return cart 
end

def checkout(cart, coupons)
  # code here
end

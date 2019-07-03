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
    coupons.each do |hash|
      value_price = hash[:cost]/hash[:num] #calculate
      
      item_hash = {
        "#{hash[:item]} W/COUPON" => {
          :price => value_price,
          :clearance => true,
          :count => hash[:num]
        }
      }
      
      cart.each do |food, food_hash| 
        food_hash[:count] -= hash[:num]
      end

      final = coupon_hash.merge!(item_hash)
      cart.merge!(final)
    end
  end 

  return cart
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end

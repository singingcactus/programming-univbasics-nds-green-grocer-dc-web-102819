def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  i = 0
  while i < collection.length do
    if collection[i][:item] == name
      found_item = collection[i]
      break
    else
      i += 1
    end
  end
  found_item
end

def consolidate_cart(cart)
  result = []
  i = 0

  #duplicate_check
  while i < cart.length do
    compare_item = cart[i]

  #kill if already in result array
    if find_item_by_name_in_collection(compare_item[:item], result)
      i += 1

    else
      compare_item_count = 0
      k = 0

      while k < cart.length do
        if compare_item == cart[k]
          compare_item_count += 1
          k += 1
        else
          k += 1
        end
      end

     compare_item[:count] = compare_item_count
     result << compare_item
     i += 1
   end
  end
  result

  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
end

def apply_coupons(cart, coupons)
  new_cart = cart

  #compare_coupon
  i = 0
  while i < coupons.length do
    k = 0
    while k < new_cart.length do
      if coupons[i][:item] == cart[k][:item] && new_cart[k][:count] >= coupons[i][:num]
        coupon_per_item = coupons[i][:cost] / coupons[i][:num]
        new_cart[k][:count] -= coupons[i][:num]

          discount_item = {
          :item => "#{coupons[i][:item]} W/COUPON",
          :price => coupon_per_item,
          :clearance => cart[k][:clearance],
          :count => coupons[i][:num],
        }

          new_cart << discount_item

          k += 1

      else
          k += 1

      end
    end

    i += 1
  end

new_cart


  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
end

def apply_clearance(cart)
  updated_cart = cart
  i = 0

  while i < updated_cart.length do
    if cart[i][:clearance]
      new_price = cart[i][:price] * 0.8
      cart[i][:price] = new_price.round(2)
      i += 1
    else
      i += 1
    end
  end

  updated_cart

  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
end

def checkout(cart, coupons)
  total = 0.00
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  cart_after_clearance = apply_clearance(couponed_cart)

  #totaling
  i = 0
  while i < cart_after_clearance.length do
    item_cost_total = cart_after_clearance[i][:price] * cart_after_clearance[i][:count]
    total += item_cost_total
    i += 1
  end

  #final discount check

  if total > 100.00
    new_total = total * 0.9
    grand_total = new_total.round(2)
  else
    grand_total = total
  end

  grand_total

  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
end

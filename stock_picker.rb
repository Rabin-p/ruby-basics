def stock_picker(array)
  max_profit = 0
  best_days = [0,0]

  # Loop for the BUY day
  array.each_with_index do |buy_price, buy_day|
    # Loop for the SELL day
    ((buy_day + 1)...array.length).each do |sell_day|
      sell_price = array[sell_day]
      diff = sell_price - buy_price
      
      if diff > max_profit
        max_profit = diff
        best_days = [buy_day, sell_day]
      end
    end
  end
  puts "The best days to buy and sell are day #{best_days[0]} and day #{best_days[1]} and the profit will be #{max_profit}"
end

stock_picker([10,2,6,9,15,8,6,1,10])

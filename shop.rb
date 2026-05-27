
def shop

inventory = {
laptop: {price: 1000, stock: 3},
phone: {price: 500, stock: 5},
bag: {price: 200, stock: 6},
candy: {price: 1, stock: 0}
}

cart = Hash.new

menu = ["View Products", "Add to Cart", "View Cart and Total", "Checkout and Exit"]
puts "Welcome to the shop"

loop do
puts "","Please Select Your Options"

menu.each_with_index do |value, index|
    puts "#{index+1}.#{value}"
end

action = gets.chomp.to_i

if (1..4).include?(action) == false
    puts "Please choose a valid option"
    puts
else
    case action

    when 1
        inventory.each do |key, value|
            puts "Product: #{key}, Price: #{value[:price]}, Stock: #{value[:stock]}"
        end


    when 2
        puts "What do you want to buy?"
        item = gets.chomp.downcase.to_sym
        if inventory.has_key?(item) && inventory[item][:stock] > 0
            puts "How many do you want?"
            quan = gets.chomp.to_i
            if quan <= inventory[item][:stock] && quan > 0
            cart[item] = {quantity: quan, price: inventory[item][:price]*quan}
            inventory[item][:stock]-=quan
            puts "The #{item} has been added to cart"
            elsif quan == 0
                puts "Please add an quantity greater than 0"
            else
                puts "Sorry. Only #{inventory[item][:stock]} pieces of #{item} are left"
            end
        elsif inventory.has_key?(item) && inventory[item][:stock] == 0
            puts "Sorry, the #{item} is out of stock currently."
        else
            puts "Sorry, we donot sell that item"
        end

    when 3
        puts "Your Cart"
        cart.each do |key, value|
            puts "Product: #{key}, Quantity: #{value[:quantity]}, Price: #{value[:price]}"
        end

        total = cart.sum {|key, value| value[:price]}
        puts "The total is: #{total}"

    when 4
        total = cart.sum {|key, value| value[:price]}
        puts "Your total comes up to #{total}","Thank you for shopping with us."
        return

    end
end

end

end

shop


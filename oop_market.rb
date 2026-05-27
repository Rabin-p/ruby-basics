class Product
  # We need to expose these attributes so the Cart and Store classes can read them later!
  attr_reader :name, :price, :stock

  def initialize(name, price, stock)
    @name = name
    @price = price
    @stock = stock
  end

  def reduce_stock(quantity)
    if quantity <= @stock
      @stock -= quantity
      true # Return true so the calling class knows the purchase succeeded
    else
      puts "Sorry, not enough stock of #{@name} left!"
      false # Return false to signal the purchase failed
    end
  end

  def increase_stock(quantity)
    @stock += quantity
  end
end

class Cart
    def initialize
        @items = Array.new
    end

    def add_product(prod, quan)
        @items.push({product: prod, quantity: quan})
    end

    def view_cart
        if @items.empty?
            puts "Your Cart is empty"
            return
        else
            @items.each do |i|
                item = i[:product]
                quantity = i[:quantity]
                puts "Product #{item.name}, Quantity #{quantity}, Price: #{item.price * quantity}"
            end
        end
    end

def calculate_total
  return 0 if @items.empty?

  total = 0

  @items.each do |i|
    product = i[:product]
    quantity = i[:quantity]

    total += product.price * quantity
  end

  return total
end

end

class Store
  def initialize
    # We populate our store inventory with an array of real Product objects!
    @inventory = [
      Product.new("Laptop", 1000, 5),
      Product.new("Phone", 500, 10),
      Product.new("Bag", 200, 6),
      Product.new("Candy", 1, 0) # Out of stock by default to test your guardrails!
    ]
    # Every store needs a shopping cart instance
    @cart = Cart.new
  end

  def start
    puts "=================================="
    puts "    Welcome to the OOP Marketplace"
    puts "=================================="

    loop do
      puts "", "Please Select An Option:"
      puts "1. View Products"
      puts "2. Add to Cart"
      puts "3. View Cart and Total"
      puts "4. Checkout and Exit"

      action = gets.chomp.to_i

      case action
      when 1
        puts "\n--- Available Products ---"
        @inventory.each_with_index do |prod, index|
          puts "#{index + 1}. #{prod.name} | Price: $#{prod.price} | Stock: #{prod.stock}"
        end

      when 2
        puts "\nSelect the product number you want to buy:"
        product_index = gets.chomp.to_i - 1

        # Grab the product object using the array index provided by the user
        chosen_product = @inventory[product_index]

        if chosen_product
          puts "How many #{chosen_product.name}(s) do you want?"
          quantity = gets.chomp.to_i

          if quantity <= 0
            puts "Please enter a quantity greater than 0."
          # Ask the product object directly to reduce its stock.
          # It returns true if it works, or false if it fails!
          elsif chosen_product.reduce_stock(quantity)
            @cart.add_product(chosen_product, quantity)
            puts "Successfully added #{quantity} #{chosen_product.name}(s) to your cart."
          end
        else
          puts "Invalid product number. Please try again."
        end

      when 3
        puts "\n--- Your Current Cart ---"
        @cart.view_cart
        puts "Grand Total: $#{@cart.calculate_total}"

      when 4
        puts "\n--- Finalizing Checkout ---"
        @cart.view_cart
        puts "Your total comes up to: $#{@cart.calculate_total}"
        puts "Thank you for shopping with us! Goodbye."
        return # Exits the loop and the start method completely

      else
        puts "Invalid choice. Please choose an option between 1 and 4."
      end
    end
  end
end

# --- RUNNING THE APPLICATION ---
# This is what triggers the whole engine to fire up!
marketplace = Store.new
marketplace.start

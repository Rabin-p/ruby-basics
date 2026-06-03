=begin
1. The Order Class
Each order has an order_id (e.g., "#1001"), a weight (in lbs), and a shipping_speed (:standard or :express).

It should track its own internal state via a status variable, which starts as "unfulfilled".

2. The Base Warehouse Class
Every warehouse has a name and a log_file name (e.g., "domestic_warehouse.log").

It must have a method can_handle?(order_obj) that returns true or false based on warehouse rules.

It must have a method fulfill(order_obj) that changes the order's status to "fulfilled", prints a success message, and logs the action to its specific log file.

3. The Specialized Warehouses (Inheritance)
DroneWarehouse: Only handles orders where the weight is under 5 lbs AND the shipping speed is :express.

StandardWarehouse: Handles any order that doesn't fit the Drone criteria.

4. The Master Router (FulfillmentCenter)
Initializes with a list containing one DroneWarehouse and one StandardWarehouse.

Features a process_queue(orders_array) method. It loops through each order, finds the first warehouse that can_handle? it, and calls that warehouse's fulfill method.

The OOP Twists (Defensive Coding & Separation)
The Fallback Rule: If an order weighs over 100 lbs, it is too heavy for standard shipping. The StandardWarehouse should raise a warning, change the order status to "failed_heavy", and not log it as a success.

Encapsulation Rule: The FulfillmentCenter should not know how a warehouse filters orders. It simply asks the warehouse can_handle?(order) and lets the warehouse decide.
=end

class Order

    attr_reader :order_id, :weight, :shipping_speed
    attr_accessor :status

    def initialize(order_id, weight, shipping_speed)
        @order_id = order_id
        @weight = weight
        @shipping_speed = shipping_speed
        @status = "unfulfilled"
    end

end


class Warehouse

    attr_reader :name, :log_file

    def initialize(name, log_file)
        @name = name
        @log_file = log_file
    end

    def can_handle?(order_obj)
        false
    end

    def fulfill(order_obj)
        order_obj.status = "fulfilled"
        File.open(@log_file, "a") do |file|
            file.puts "FULFILLED: #{order_obj.order_id} at #{Time.now.strftime("%Y-%m-%d %H:%M:%S")} via #{order_obj.shipping_speed} delivery"
        end
    end

end

class DroneWarehouse < Warehouse

    attr_reader :weight_limit

    def initialize(name, log_file, weight_limit)
        super(name, log_file)
        @weight_limit = weight_limit
    end

    def can_handle?(order_obj)
        order_obj.weight <= @weight_limit && order_obj.shipping_speed.to_s.casecmp?("express")
    end

end

class StandardWarehouse < Warehouse

    def can_handle?(order_obj)
        true
    end

    def fulfill(order_obj)
        if order_obj.weight > 100
            order_obj.status = "failed_heavy"
            File.open(@log_file, "a") do |file|
                file.puts "FAILED: #{order_obj.order_id} exceeds weight limit at #{Time.now.strftime("%Y-%m-%d %H:%M:%S")}"
            end
        else
            super(order_obj)
        end
    end

end

class FulfillmentCenter
    def initialize
        @warehouses = [
            DroneWarehouse.new("A1 Drone Delivery", "order_logs.txt", 5),
            StandardWarehouse.new("D&D Shipping and Delivery", "order_logs.txt")
        ]
    end

    def process_queue(order_array)
        order_array.each do |order|
            @warehouses.each do |warehouse|
                if warehouse.can_handle?(order)
                    warehouse.fulfill(order)
                    break
                end
            end
        end
    end
end

center = FulfillmentCenter.new

incoming_orders = [
  Order.new("#1001", 3, "express"),     # Drone should catch this
  Order.new("#1002", 25, "standard"),   # Standard should catch this
  Order.new("#1003", 150, "express")    # Standard catches, but logs error
]

center.process_queue(incoming_orders)

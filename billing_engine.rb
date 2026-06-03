class Merchant
    attr_reader :store_name
    attr_accessor :api_calls_made, :billing_balance

    def initialize(store)
        @store_name = store
        @api_calls_made = 0
        @billing_balance = 0
    end

    def track_api_call
        @api_calls_made += 1
    end

    # Generic Invoice Calculation (Parent)
    def calculate_invoice_total(free_calls, over_cost, monthly_cost)
        base_cost = monthly_cost

        if @api_calls_made <= free_calls
            final_cost = base_cost
        else
            overflow = @api_calls_made - free_calls
            final_cost = base_cost + (overflow * over_cost)
        end

        final_cost
    end
end

class BasicMerchant < Merchant
    def initialize(store)
        super(store)
        @free_calls = 1000
        @over_cost = 0.01
        @monthly_cost = 9
    end

    def generate_invoice

        total = calculate_invoice_total(@free_calls, @over_cost, @monthly_cost)

        if @api_calls_made > 3000
            puts "WARNING: #{@store_name} exceeded limit by over 200%! Applying $5 penalty."
            total += 5
        end

        puts "Invoice for #{@store_name}: $#{'%.2f' % total}"
        total
    end
end

class ProMerchant < Merchant
end

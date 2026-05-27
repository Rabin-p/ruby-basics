def atm_teller
  atm = [
    "1. Check Balance",
    "2. Deposit",
    "3. Withdraw",
    "4. Transaction History",
    "5. Exit"
  ]

  history = Hash.new

  balance = 100

  puts "Welcome to the ATM \nPlease choose your actions"

  atm.each_with_index do |value, index|
    puts value
  end

  loop do
    choice = gets.chomp.to_i

    case choice

    when 5
      puts "Thank you for using our atm"
      return

    when 1
      puts "Check Balance"
      puts "Your balance is $#{balance}"
      history[Time.now] = "Checked the Transaction. Balance: $#{balance}"

    when 2
      puts "Deposit", "Enter your amount to deposit"
      money = gets.chomp.to_i
      if money != 0
        balance += money
        puts "Your deposit has been added sucessfully. Your new balance is #{balance}"
        history[Time.now] = "Deposit $#{money}. Balance: $#{balance}"
      else
        puts "Please input a amount greater than 0"
      end

    when 4
      if history.any?
      puts "Date Action Result"
      else
        puts "No transaction history to display"
      end
       history.each do |key, value|
       puts "#{key} #{value}"
       end

    when 3
      puts "Withdraw", "Enter the amount to withdraw"
      money = gets.chomp.to_i
      if money > balance
        puts "Sorry your balance is too low."
      else
        balance -= money
        puts "You have sucessfully withdrawn the amount. Your new balance is $#{balance}"
        history[Time.now] = "Withdraw $#{money}. Balance $#{balance}"
      end
    end
  end
end

atm_teller

adventure = {
    crossroads: ["1. Go inside the house","2. Investigate the backyard"],
    path1: ["1. Walk up the creaky stairs", "2. Open the basement door"],
    path2: ["1. Walk up to the strange door", "2. Walk up to the strange creature"],
    finale: ["1. This game is under development", "2. This game is under development"]
    }

choices = [1, 2]

puts "Lets begin the adventure game. Choose an option. Type 1 or 2"
puts adventure[:crossroads]
choice = gets.chomp.to_i
if !choices.include?(choice)
    puts "Invalid choice. Try Again"
elsif choice == 1
    puts adventure[:path1]
    choice = gets.chomp.to_i
    if !choices.include?(choice)
        puts "Invalid choice. Try Again"
    elsif choice == 1
        puts adventure[:finale][0]
    elsif choice == 2
        puts adventure[:finale][1]
    end
elsif choice == 2
    puts adventure[:path2]
    choice = gets.chomp.to_i
    if !choices.include?(choice)
        puts "Invalid choice. Try Again"
    elsif choice == 1
        puts adventure[:finale][0]
    elsif choice == 2
        puts adventure[:finale][1]
    end
end

class Pet
  attr_reader :name, :hunger, :boredom

  def initialize(name)
    @name = name       # "@" means it's an instance variable (the object's internal memory)
    @hunger = 5
    @boredom = 5
  end

  # A method (action) the pet can do
  def feed
    puts "#{@name} eats delicious kibble!"
    @hunger -= 2
    @hunger = 0 if @hunger < 0 # Prevent negative hunger
  end

  def play
    puts "You play fetch with #{@name}!"
    @boredom -= 3
    @boredom = 0 if @boredom < 0
    @hunger += 1
  end

  def status
      puts "This is your #{@name}'s current status"
      puts "Hunger: #{@hunger}", "Bordeom: #{@boredom}"
  end
  end

class Dog < Pet
end

puts "What do you want to name your pet?"
pet_name = gets.chomp

# Create the instance using your lowercase variable name
my_pet = Pet.new(pet_name)

loop do
  puts "", "What would you like to do with #{my_pet.name}?", "1. Feed", "2. Play", "3. Check Status", "4. Exit"
  choice = gets.chomp.to_i

  case choice
  when 1
    my_pet.feed
  when 2
    my_pet.play
  when 3
    my_pet.status
  when 4
    puts "Goodbye! Thanks for taking care of #{my_pet.name}."
    break
  else
    puts "Invalid option. Your pet looks at you confused."
  end
end

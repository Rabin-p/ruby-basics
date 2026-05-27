def todo_list
    todos = Array.new
    loop do
        puts "What would you like to do? (add, view, delete, exit)"
        user = gets.chomp
        if user.casecmp?("exit")
            puts ("Goodbye")
            break
        elsif user.casecmp?("add")
            puts "What task do you want to add?"
            task = gets.chomp
            todos << task
        elsif user.casecmp?("view")
            puts "These are your pending task:"
            todos.each_with_index do |task, index|
                puts "#{index + 1} #{task}"
            end
        elsif user.casecmp?("delete")
            puts "Which task number do you want to remove?"
            index = gets.chomp.to_i-1
            task = todos[index]
            todos.delete_at(index)
            puts "The task #{task} has been deleted successfully. Type view to see your remaining task"
            task = nil
        end
    end
end

todo_list

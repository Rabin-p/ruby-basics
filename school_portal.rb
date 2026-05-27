class User
    attr_reader :username, :password

    def initialize(user, pass)
        @username = user
        @password = pass
    end

    def login(user, pass)
       return true if user == @username and pass == @password
       return false
    end
end

class Student < User
    attr_accessor :grade

    def initialize (user, pass, grade)
        super(user, pass)
        @grade = grade
    end

    def view_profile
        puts "Name: #{username}", "Grade: #{@grade}"
    end
end

class Teacher < User
    def initialize (user, pass)
        super(user, pass)
    end

    def change_grade(student_obj, new_grade)
        student_obj.grade = new_grade

    File.open("grade_change_log.txt", "a") do |file|
        file.puts "#{username} changed the grade of #{student_obj.username} to #{new_grade}"
    end

    end
end

class SystemPortal
    attr_reader :members
    def initialize
        @members = [
        Student.new("Adam", "A1", nil),
        Student.new("Harry", "H1", nil),
        Student.new("Tess", "T1", nil),
        Teacher.new("Mr. Johns", "MJ1")
        ]
    end

    def start
        puts "Welcome to the student portal"
        puts "Enter your username"
        input_user = gets.chomp
        puts
        found_user = members.find{ |m| m.username == input_user}
        if !found_user
            puts "Sorry, the user is not registered with us"
            return
        else
            puts
            puts "Enter your password"
            input_pass = gets.chomp
if found_user.password == input_pass
                puts "Welcome #{found_user.username}"
                puts

                if found_user.is_a?(Teacher)
                    puts "Student Details"
                    puts

                    student_list = members.grep(Student)
                    student_list.each_with_index do |student, index|
                        puts "#{index+1} | Name: #{student.username} | Grade: #{student.grade}"
                    end

                    puts
                    puts "Pick the serial number of student you want to change the grade of"
                    index_student = Integer(gets.chomp, exception: false)

                    unless index_student.between?(1, student_list.length)
                        puts "Invalid Selection"
                        return
                    end

                    selected_student = student_list[index_student-1]
                    puts "What do you want to change their garde to? (A-F)"
                    new_grade = gets.chomp.upcase

                    unless new_grade.match?(/\A[A-F]\z/)
                        puts "Invalid grade choice!"
                        return
                    end

                    found_user.change_grade(selected_student, new_grade)

                    puts "The grade has succesfully been changed"
                    return

                elsif found_user.is_a?(Student)
                    puts "Your Details"
                    found_user.view_profile
                    return
                end

            else
                puts "Wrong password"
                return
            end
        end
    end
end

portal = SystemPortal.new
portal.start

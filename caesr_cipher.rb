def cipher (text, shift)
  cipher = String.new
  letters = text.chars
  c_letters = letters.map do |letter|
    if letter.match?(/[[:alpha:]]/)
      new_val = letter.ord + shift
      if letter.match?(/[a-z]/)
        if new_val > 'z'.ord
          new_val = new_val - 26
        end
      elsif letter.match?(/[A-Z]/)
        if new_val > 'Z'.ord
          new_val = new_val - 26
        end
      end
      new_val.chr
    else
      letter
    end
  end
  cipher = c_letters.join
end

print "Please input a text to cipher: "
string = gets.chomp
print "Enter a shift value: "
shift = gets.chomp.to_i

puts cipher(string, shift)
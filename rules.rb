class Rules

# check if args are valid



def check_args (seed, number_of_pros)
  if  ARGV.count != 2
    print invalid_msg
    exit(1)
  end
  if has_letter_or_symbol seed, number_of_pros
    print invalid_msg
    exit(1)
  end
end


def has_letter_or_symbol (seed, number_of_pros)
  # return true if it has true has any symbol like !@#$ etc
  return true if seed.match?(/\W/)|| number_of_pros.match?(/\W/)
  # return true if the string has any small letter
  return true if seed.match?(/[a-z]/)|| number_of_pros.match?(/[a-z]/)
  # return true if it has any small letter
  return true if seed.match?(/[A-Z]/)|| number_of_pros.match?(/[A-Z]/)
  # return true if there is empty string
  false
end

def invalid_msg
  puts "Usage:"
  puts "ruby gold_rush.rb *seed* *num_prospectors*"
  puts "*seed* should be an integer"
  puts "*num_prospectors* should be a non-negative integer"
end



end
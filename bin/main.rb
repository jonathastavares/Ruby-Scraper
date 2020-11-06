require_relative '../lib/search.rb'
require_relative '../lib/display.rb'

puts 'What are you searching for?'
Search.new(gets.chomp)

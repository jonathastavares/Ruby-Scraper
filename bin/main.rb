require_relative '../lib/search.rb'
require_relative '../lib/display.rb'

def check_answer
  user_answer = gets.chomp
  if user_answer == 'y'
    puts 'What are you searching for?'
    Search.new(gets.chomp)
  elsif user_answer == 'n'
    puts 'Thank you for using our Scrapper!'
    false
  elsif user_answer != 'y' && user_answer != 'n'
    print 'Invalid answer! Please answer with [Y] or [N]. Do you want to make a new search? '
    rerun(gets.downcase.chomp)
  end
end

def show_results(list, links)
  result = Table.new(list)
  if result.check_result
    print ' POSITION ' + '                      DESCRIPTION                                  '
    print '                               LINK                            '
    puts ''
    result.build_table(links)
  else
    puts 'No results returned!'
  end
  sleep(1)
  print 'Do you want to make a new search? [Y]es or [N]o? '
end

puts 'What are you searching for?'
Search.new(gets.chomp)

# rubocop:disable Style/RedundantReturn
require_relative '../lib/search.rb'
require_relative '../lib/display.rb'

def check_answer(user_answer)
  user_answer = user_answer.downcase
  if user_answer == 'y'
    puts 'What are you searching for?'
    runscript
  elsif user_answer == 'n'
    puts 'Thank you for using our Scrapper!'
    return false
  elsif user_answer != 'y' && user_answer != 'n'
    print 'Invalid answer! Please answer with [Y] or [N]. Do you want to make a new search? '
    rerun(gets.downcase.chomp)
  end
end

def show_results(list)
  result = Table.new(list[0], list[1], list[2], list[3])
  print ' POSITION ' + '                      DESCRIPTION                                  '
  print '                               LINK                            '
  print '  SIZE       SEEDS      '
  puts ''
  table = result.build_table
  puts table
  sleep(1)
end

def html_builder(list)
  file = Nokogiri::HTML::Builder.new do |html|
    position = 1
    html.body do
      html.node1 do
        while position < list[0].length
          html.article do
            html.span = position
            html.a = list[0][position].text
            link = list[1][position - 1].to_s
            html.a = 'https://thepiratebay.org' + link[9..link.index('>') - 2]
            html.div = 'SIZE  ' + list[2][position].text
            html.div = list[3][position].text + '  SEEDS'
            html.br
            position += 1
          end
        end
      end
    end
  end
  file.to_html
end

def html_format(file)
  doc = Nokogiri::HTML.parse(file)
  doc.xpath('//span').each do |tag|
    tag['style'] = 'align-items: center; color: black; margin: 5px 20px;'
  end

  doc.xpath('//a').each do |tag|
    tag['style'] = 'align-items: center; color: black; margin: 5px 50px; width: 20%; text-decoration: none;'
  end

  doc.xpath('//div').each do |tag|
    tag['style'] = 'align-items: center; color: black; margin: 5px 30px;'
  end

  doc.xpath('//node1').each do |tag|
    tag['style'] = 'align-items: center;'
  end

  doc.xpath('//article').each do |tag|
    tag['style'] = 'display: flex; jutify-content: center; align-items: center; width: 100%; border: 1px black solid;'
  end
end

def runscript
  user_input = gets.chomp
  search = Search.new(user_input)
  list = search.result
  show_results(list)
  file = html_builder(list)
  file = html_format(file)
  File.open(user_input + '.html', 'w') { |f| f.write(file) }
  print('Do you want to make a new search? [Y]es or [N]o? ')
  check_answer(gets.chomp)
end
puts 'This is a Web Scraper for ThePirateBay.org, which is a torrent search website!'
puts 'Type whatever you want to search and the Scraper will retrieve the information found at ThePirateBay.org'
puts 'What are you searching for?'
runscript
# rubocop:enable Style/RedundantReturn

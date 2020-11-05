# rubocop:disable Style/RedundantInterpolation

class Table
  attr_reader :table

  def initialize(list, links)
    @table = list
    @search_results = 1

    if @table[1].text == 'No results returned'
      puts 'No results returned!'
    else
      @table.drop(1).each do |item|
        print @search_results
        print '         '
        print item.text
        print '                                               '
        link = 'https://thepiratebay.org' + "#{links[@search_results - 1]['href']}"
        print link
        puts ''
        @search_results += 1
      end
    end
  end
end
# rubocop:enable Style/RedundantInterpolation

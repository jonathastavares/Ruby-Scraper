# rubocop:disable Style/RedundantInterpolation

class Table
  attr_reader :table

  def initialize(list, links)
    @table = list
    @links = links
    @search_results = 1
  end

  def build_table
    results = []
    @table.drop(1).each do |item|
      description = @links[@search_results - 1].to_s
      link = 'https://thepiratebay.org' + "#{description[9..-1]}"
      position = @search_results.to_s
      results[@search_results - 1] = build_row(position, item, link)
      @search_results += 1
    end
    results
  end

  def build_row(position, description, link)
    row = ' ' * 150
    row[4] = position
    row[14] = description
    row[85] = link[0..link.index('"') - 1]
    row[0..136]
  end
end

# rubocop:enable Style/RedundantInterpolation

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
      link = 'https://thepiratebay.org' + "#{@links[@search_results - 1]['href']}"
      position = @search_results.to_s
      results[@search_results - 1] = build_row(position, item.text, link)
      @search_results += 1
    end
    results
  end

  private

  def build_row(position, description, link)
    row = ' ' * 150
    row[4] = position
    row[14] = description
    row[85] = link
    row[0..150]
  end
end

# rubocop:enable Style/RedundantInterpolation

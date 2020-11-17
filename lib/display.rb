# rubocop:disable Style/RedundantInterpolation

class Table
  attr_reader :table

  def initialize(list, links, sizes, seeds)
    @table = list
    @links = links
    @sizes = sizes
    @seeds = seeds
    @search_results = 1
  end

  def build_table
    results = []
    @table.drop(1).each do |item|
      link = @links[@search_results - 1].to_s
      position = @search_results.to_s
      results[@search_results - 1] = build_row(position, item, link, @sizes[@search_results], @seeds[@search_results])
      @search_results += 1
    end
    results
  end

  def build_row(position, description, link, size, seed)
    row = ' ' * 160
    row[4] = position
    row[14] = description
    str = 'https://thepiratebay.org' + "#{link[9..link.index('>') - 2]}"
    row[85] = str
    row[140] = size
    row[155] = seed
    row[0..156]
  end
end

# rubocop:enable Style/RedundantInterpolation

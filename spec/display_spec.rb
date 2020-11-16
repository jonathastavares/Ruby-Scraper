# ./spec/display_spec.rb
require './lib/display.rb'
require 'nokogiri'

describe Table do
  before(:all) do
    @list = ['Nothing', 'ONE PIECE World Seeker - PLAZA', 'One Piece Season 1,2,3 {EnG SubbeD} [Episode 1-92] L@mBerT']
    @links = ['<a href="/description.php?id=37075887">ONE PIECE World Seeker - PLAZA</a>',
              '<a href="/description.php?id=8764563">One Piece Season 1,2,3 {EnG SubbeD} [Episode 1-92] L@mBerT</a>']
    @sizes = ['Nothing', '7.61 MiB', '3.6 GiB']
    @seeds = %w[Nothing 87 84]
    @table = Table.new(@list, @links, @sizes, @seeds)
    @results = @table.build_table
  end

  describe 'build_table' do
    it 'Checks if the table has been built correctly' do
      expect(@results[0]).to eq('    1         ONE PIECE World Seeker - PLAZA                                         https://thepiratebay.org/description.php?id=37075887   7.61 MiB       87')
      expect(@results[1]).to eq('    2         One Piece Season 1,2,3 {EnG SubbeD} [Episode 1-92] L@mBerT             https://thepiratebay.org/description.php?id=8764563    3.6 GiB        84')
    end
  end

  describe 'build_row' do
    it 'Checks if the row has been built correctly' do
      row = @table.build_row('1', 'ONE PIECE World Seeker - PLAZA',
                             'https://thepiratebay.org/description.php?id=37075887"', '7.61 MiB', '87')
      expect(row).to eq('    1         ONE PIECE World Seeker - PLAZA                                         https://thepiratebay.org/description.php?id=37075887   7.61 MiB       87')
    end
  end
end

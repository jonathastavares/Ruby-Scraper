# ./spec/display_spec.rb
require './lib/display.rb'
require 'nokogiri'

describe Table do
  before(:all) do
    @list = ['Nothing', 'ONE PIECE World Seeker - PLAZA', 'One Piece Pirate Warriors 4 - PLAZA']
    @links = ['<a href="/description.php?id=37038171">ONE PIECE World Seeker - PLAZA</a>',
              '<a href="/description.php?id=37038144">One Piece Pirate Warriors 4 - PLAZA</a>']
    @table = Table.new(@list, @links)
    @results = @table.build_table
  end

  describe 'build_table' do
    it 'Checks if the table has been built correctly' do
      expect(@results[0]).to eq('    1         ONE PIECE World Seeker - PLAZA                                         https://thepiratebay.org/description.php?id=37038171')
      expect(@results[1]).to eq('    2         One Piece Pirate Warriors 4 - PLAZA                                    https://thepiratebay.org/description.php?id=37038144')
    end
  end

  describe 'build_row' do
    it 'Checks if the row has been built correctly' do
      row = @table.build_row('1', 'ONE PIECE World Seeker - PLAZA', 'https://thepiratebay.org/description.php?id=37038171')
      expect(row).to eq('    1         ONE PIECE World Seeker - PLAZA                                         https://thepiratebay.org/description.php?id=37038171')
    end
  end
end

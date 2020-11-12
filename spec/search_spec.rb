# ./spec/search_spec.rb
require './lib/search.rb'

describe Search do
  before(:all) do
    @search = Search.new('one piece')
  end
  describe '.initialize' do
    it 'Checks url builder in initialize method' do
      expect(@search.url).to eq('https://thepiratebay.org/search.php?q=one+piece')
    end

    it 'tests for another URL to certify that it is working properly' do
      new_search = Search.new('hantaro')
      expect(new_search.url).to eq('https://thepiratebay.org/search.php?q=hantaro')
    end

    it 'tests for another URL to certify that it is working properly' do
      new_search = Search.new('need for speed underground 2')
      expect(new_search.url).to eq('https://thepiratebay.org/search.php?q=need+for+speed+underground+2')
    end
  end

  describe 'result' do
    it 'Gets the result list from the website' do
      results = @search.result
      expect(results[1].length).to eq(100)
    end
  end
end

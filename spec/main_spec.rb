# ./spec/main_spec.rb
require './bin/main.rb'

before(:all) do
end
describe 'check_answer' do
  it 'Checks if user wants to make a new search' do
    expect(check_answer('y')).to eq('What are you searching for?')
  end
end

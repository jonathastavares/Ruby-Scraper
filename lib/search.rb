# rubocop:disable Style/RedundantReturn
require 'nokogiri'
require 'watir'
require 'webdrivers'
require_relative '../lib/display.rb'

class Search
  attr_reader :url

  def initialize(input)
    @input = input
    @input = @input.split(' ')
    @url = 'https://thepiratebay.org/search.php?q='
    @input.each do |put|
      if put != @input.last
        @url = @url + put + '+'
      else
        @url += put
      end
    end
  end

  def result
    browser = Watir::Browser.new
    browser.goto(@url)
    sleep(3)
    session = Nokogiri::HTML.parse(browser.html)
    list = session.css('.item-name')
    links = session.css('.item-name//a')
    sizes = session.css('.item-size')
    seeds = session.css('.item-seed')
    browser.quit
    return list, links, sizes, seeds
  end
end
# rubocop:enable Style/RedundantReturn

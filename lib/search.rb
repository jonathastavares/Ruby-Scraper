require 'nokogiri'
require 'open-uri'
require 'watir'
require 'selenium-webdriver'
require_relative '../lib/display.rb'

class Search
  attr_reader :url, :search_results

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
    result
  end

  def result
    Selenium::WebDriver::Chrome.driver_path = './chromedriver.exe'
    browser = Watir::Browser.new
    browser.goto @url
    sleep(3)
    session = Nokogiri::HTML.parse(browser.html)
    list = session.css('.item-name')
    links = session.css('.item-name//a')
    Table.new(list, links)
  end
end

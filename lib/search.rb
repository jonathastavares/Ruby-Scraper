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

  def rerun(user_answer)
    again = true
    while again == true
      if user_answer == 'y'
        puts 'What are you searching for?'
        Search.new(gets.chomp)
      elsif user_answer == 'n'
        puts 'Thank you for using our Scrapper!'
        again = false
      elsif user_answer != 'y' && user_answer != 'n'
        print 'Invalid answer! Please answer with [Y] or [N]. Do you want to make a new search? '
        rerun(gets.downcase.chomp)
      end
    end
  end

  def result
    Selenium::WebDriver::Chrome::Service.driver_path = './chromedriver.exe'
    browser = Watir::Browser.new
    browser.goto @url
    sleep(3)
    session = Nokogiri::HTML.parse(browser.html)
    list = session.css('.item-name')
    links = session.css('.item-name//a')
    Table.new(list, links)
    browser.quit
    sleep(1)
    print 'Do you want to make a new search? [Y]es or [N]o? '
    rerun(gets.downcase.chomp)
  end
end

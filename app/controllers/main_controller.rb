class MainController < ApplicationController

  require 'nokogiri'
  require 'open-uri'

  def index
    doc = Nokogiri::HTML(open('http://www.residentadvisor.net/dj-charts.aspx'))
    @nodes = doc.css('div.null')
    @ra_url = 'http://www.residentadvisor.net/'
  end
end

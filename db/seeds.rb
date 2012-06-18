# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'nokogiri'
require 'open-uri'

puts "Starting to seed the DB..."

years = 2007..Time.now.year
months = 1..12
ra_url = 'http://www.residentadvisor.net'
chart_url = "#{ ra_url }/dj-charts.aspx"

years.each do |year|
  months.each do |month|
    next if (year == 2007 and month < 3) or (year == Time.now.year and month > Time.now.month)
    puts "Fetching charts for #{ month }/#{ year }"
    month_doc = Nokogiri::HTML(open("#{ chart_url }?yr=#{ year }&mn=#{ month }"))

    puts 'Processing DJs...'
    month_doc.css('div.null').each do |node|
      dj_name = node.at_css('a.cat').text()
      dj = Dj.where(name: dj_name).first
      if dj.nil?
        country = node.css('a img')[1]
        dj = Dj.where( name: dj_name,
                  image: node.at_css('img').attr('src'),
                  country: country.attr('alt'),
                  country_image: country.attr('src')
                  ).create
      end
      chart_date = node.at_css('span.grey').text()
      if dj.charts.where(date: chart_date).count == 0
        puts "#{ chart_date }: #{ dj_name }"
        chart_location = ra_url + node.at_css('a.cat').attr('href')
        chart_doc = Nokogiri::HTML(open(chart_location))
        tracks = chart_doc.at_css('table#tracks')

        lines = []

        tracks.css('tr').each do |tr|
          tr.css('td').each do |td|
            text = td.text()
            lines << text unless text.blank?
          end
        end
        p lines.drop(4)
        exit
        # dj.charts.create(date: chart_date, location: chart_location)
      end
    end
  end
end

# doc = Nokogiri::HTML(open('http://www.residentadvisor.net/dj-charts.aspx'))
# doc.css("div.null").each do |node|
#   puts node.to_s
#   puts node.at_css('span.grey').text()
#   puts node.at_css('a.cat').text()
#   puts
# end

puts "Finished seeding the DB -- great!"
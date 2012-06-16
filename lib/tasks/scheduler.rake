namespace :app do
  desc "Aggregate DJ charts from RA"
  task update_charts: :environment do
      puts "Updating charts..."

      require 'nokogiri'
      require 'open-uri'

      doc = Nokogiri::HTML(open('http://www.residentadvisor.net/dj-charts.aspx'))

      puts "Finished updating charts"
  end
end
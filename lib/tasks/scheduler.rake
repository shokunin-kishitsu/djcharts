namespace :app do
  desc "Aggregate DJ charts from RA"
  task update_charts: :environment do
      puts "Updating charts..."

      require 'nokogiri'
      require 'open-uri'

      doc = Nokogiri::HTML(open('http://www.residentadvisor.net/dj-charts.aspx'))
      doc.css("div.null").each do |node|
        puts node.to_s
        puts node.at_css('span.grey').text()
        puts node.at_css('a.cat').text()
        puts
      end

      puts "Finished updating charts"
  end
end
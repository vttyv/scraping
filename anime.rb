# wikipedia アニメ スクレイピング
require 'open-uri'
require 'nokogiri'
require 'csv'

# hash = Hash.new
# file = File.open("eq_title.txt" , 'r')
# file.each do |text|
#   hash[text.strip] = true
# end
# file.close
# 読み込み終了 #

title = /\:\s(.+?)\s\(/

# スクレイピング先のURL
year = 2018
base_url = "https://anime.eiga.com"

url = "#{base_url}/program/season/#{year}/"
# url = "#{base_url}/w/index.php?title=Category:2018%E5%B9%B4%E3%81%AE%E3%83%86%E3%83%AC%E3%83%93%E3%82%A2%E3%83%8B%E3%83%A1&pagefrom=%E3%81%BB%E3%81%B5%E3%81%A6%E3%81%B2%E3%81%B2%E3%81%A4%E3%81%8F%0A%E3%83%9D%E3%83%97%E3%83%86%E3%83%94%E3%83%94%E3%83%83%E3%82%AF#mw-pages"
d_page = ""
# URLなのかチェック
url = URI.parse(url)
html = open(url).read
# htmlをパースする
doc = Nokogiri::HTML.parse(html)

count = 0


test = CSV.open('2018.csv','w')
# loop do
    doc.css(".seasonAnimeTtl a").each do |el|
        d_url = base_url + el.attr('href')
        title = el.text

        sleep(3)
        html = open(d_url).read
        d_doc = Nokogiri::HTML.parse(html)

        hoge = d_doc.css("#detailMusic dd ul li").to_s.match(/OP】(.*)「(.*)」<br>/)

        puts title
        next if hoge == nil
        test.puts ["#{title}","#{hoge[1]}","#{hoge[2]}"]
        count += 1
    end
# end
puts "総計:" + count.to_s
test.close

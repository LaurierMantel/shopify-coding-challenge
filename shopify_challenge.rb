%w{rubygems json logger net/http }.each { |x| require x }
sum_prices = sum_grams = 0
JSON.parse(Net::HTTP.get('shopicruit.myshopify.com', '/products.json'))["products"].select{ |product| product["title"].downcase.include?("computer") || product["title"].downcase.include?("keyboard")}.map{|product| product["variants"]}.flat_map { |i| i}.map {|variant| [variant["price"], variant["grams"]]}.sort_by{|first, second| second}.reverse.each {|item| if item[1]/1000 + sum_grams < 100; sum_prices += item.first.to_f; sum_grams += item[1]/1000; end }
Logger.new(STDOUT).info sum_prices
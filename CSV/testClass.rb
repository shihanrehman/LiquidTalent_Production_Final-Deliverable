require 'open-uri' #Installed by default, This library allows us to access differnt URL's from within the text editor
require 'nokogiri' #Not Installed by default: from Terminal, gem install nokogiri, This gem helps us read and search the HTML content of a webpage
require 'csv' #Installed by default, This library generates a CSV
require 'httpclient'

load 'namescraper.rb' 

#require NameScraper
ns = NameScraper.new() #

puts Dir.pwd

#contains information of each freelancer i.e their name, education, work_history, linked_in, and skills
arrayOfPersons = []

urls = []
i = 0
loop do #scrape through multiple pages
		i += 1
		url = "https://angel.co/people?tag_ids%5B%5D=1664&tag_ids%5B%5D=82532&page=#{i}" #Save the URL in a variable called url
		html = open(url) #opens the url and assigns value to html
		page = Nokogiri::HTML(html) #parses variable html with NOKOgiri
		#puts page.class 
		page.css('div.photo a').each do |line| 
			urls << line['href']	#Forces the extracted text in the html to name array
			#puts line.class 	
		end
		if page.css('a.profile-link').count == 0 	#breaks loop count when there are no more links to count
		   puts "break happened for #{i}"
		   break
		end	
end

puts urls

for url in urls
	# call the createprofile method for every url and converts it into a person object
	# which is added to the arrayOfPersons array
	arrayOfPersons << ns.createProfile(url)
end


CSV.open("person_profiles.csv", "w") do |file|  #generate CSV file 
  file << ["Name","Linkedin","Skills","Education","Experience"]
  		#puts file.class
  arrayOfPersons.length.times do |i|
    file << [arrayOfPersons[i].name, arrayOfPersons[i].linkedin_url, arrayOfPersons[i].skills, arrayOfPersons[i].education, 
    arrayOfPersons[i].experience]

  end
end


# The code below generates text files of the html markup of each free lancer profile
=begin
i = 0
for url in urls
	i = i + 1
	ns.extractFileFromUrl(url,i)
end
=end










require 'open-uri' #Installed by default, This library allows us to access differnt URL's from within the text editor
require 'nokogiri' #Not Installed by default: from Terminal, gem install nokogiri, This gem helps us read and search the HTML content of a webpage
require 'csv' #Installed by default, This library generates a CSV
require 'httpclient'

load 'person.rb' 

class NameScraper

	def createProfile(url)

		html = open(url) #opens the url and assigns value to html
		page = Nokogiri::HTML(html) #parses variable html with NOKOgiri

		# grab the name
		name = page.css('h1.js-name')[0]

		#grab the linkedin_url and initialize the linkedin_url as an empty string 
		linkedin_url = ""
		#search the page for a linkedin_link
		markup = page.css('span.link a.icon.link_el.fontello-linkedin')
		markup.each do |line|
		#grab the href attribute from the a tag
		linkedin_url << line['href']
		end
		
		#grab the skills and initialize skills as an empty string variable
		skills = ""
		#here we select the div which has data-field = tags_skills
		skill_links = page.css("div.value").select{|skillMarkup| skillMarkup['data-field'] == "tags_skills"}
		skill_links.each do |line| 
			skills  << line 	#append what we found to the skills string
			#puts line.class 	
		end

		#grab education text
		education = page.css('span.fontello-college+a').text
		
		#grab experience
		experience = page.css('div.two_col_block').text.strip

		# we initialize the person object with all of the info we grabbed with nokogiri
		person = Person.new(name,linkedin_url,skills,education, experience)

		#return statement
		person
	end	

end
require 'open-uri' #Installed by default, This library allows us to access differnt URL's from within the text editor
require 'nokogiri' #Not Installed by default: from Terminal, gem install nokogiri, This gem helps us read and search the HTML content of a webpage
require 'httpclient'

class NameScraper
	def extractFileFromUrl(url,i)
		clnt=HTTPClient.new
		response = clnt.get(url)
		filename = "file#{i}.txt" 
		#there should no "/" signs in the filename 
		#b/c ruby will assume its a path to a file vs the file name
		File.open(filename, 'w') do |f2|  
	  	# use "\n" for two lines of text  
	  	f2.puts response.content
		end  
		puts "done with file #{i}"
	end	
end

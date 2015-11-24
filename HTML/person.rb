class Person
	attr_reader :name, :linkedin_url, :skills, :education, :experience
	def initialize(name, linkedin_url, skills, education, experience)
		@name, @linkedin_url, @skills, @education, @experience = name, linkedin_url, skills, education, experience
	end

end

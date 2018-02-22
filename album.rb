class Album
	def initialize(rank, year, title)
		@rank = rank
		@year = year
		@title = title
	end
	attr_accessor :rank
	attr_accessor :year
	attr_accessor :title
end

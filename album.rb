class Album

  attr_accessor :rank
  attr_accessor :year
  attr_accessor :title

  def initialize(rank, year, title)
    @rank = rank
    @year = year
    @title = title
  end

end

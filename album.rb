class Album
  attr_accessor :rank
  attr_accessor :year
  attr_accessor :title
  attr_accessor :highlight

  def initialize(rank, year, title, highlight)
    @rank = rank
    @year = year
    @title = title
    @highlight = highlight
  end

end

class AlbumList

  def initialize()
    attr_accessor: @albums

  end

  def file_read

    File.open("top_100_albums.txt").each do |line|
      newline = line.to_s
#chop cuts off the ugly \n after every entry
newline.chop
#splits the line to be able to index the date later for sorting
album_split = newline.split(', ')


end

end




end
require_relative 'album'

class AlbumList

  def initialize()
    @albums = []
    file_read
  end
  attr_accessor :albums
  def file_read
    rank_index = 1
    File.open("top_100_albums.txt").each do |line|
      newline = line.to_s
      #chop cuts off the ugly \n after every entry
      newline.chop
      #splits the line to be able to index the date later for sorting
      album_split = newline.split(', ')
      album_object = Album.new( rank_index, album_split[1], album_split[0])
      albums << album_object
      rank_index += 1
    end
  end

  def sort(accessor)
    albums.sort_by!(&:"#{accessor}")
  end
  
end

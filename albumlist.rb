
class AlbumList

  def initialize()
    @albums = []
    albums = file_read(@albums)
  end
  attr_accessor :albums

  def file_read(albumz)
    rank_index = 1
    File.open("top_100_albums.txt").each do |line|
      newline = line.to_s
      #chop cuts off the ugly \n after every entry
      newline.chop
      #splits the line to be able to index the date later for sorting
      album_split = newline.split(', ')
      album_object = Album.new( rank_index, album_split[1], album_split[0])
      albumz << album_object
      rank_index += 1
    end
    return albumz
  end

  def htmlgenerator(highlight_index)
    gen = HtmlGen.new(@albums, highlight_index)
    return gen.response_body
  end

  def sort(accessor)
    albums.sort_by!(&:"#{accessor}")
  end

end

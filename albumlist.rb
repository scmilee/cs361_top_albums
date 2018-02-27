
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
      newline.chop
      album_split = newline.split(', ')
      album_object = Album.new( rank_index, album_split[1], album_split[0], false)

      albumz << album_object
      rank_index += 1
    end
    return albumz
  end

  def highlight(index)
    highlight = 1
    @albums.each do |album|
      if index.to_s === highlight.to_s
        album.highlight = true
      end
    highlight += 1
    end

  end
  def sort(accessor)
    albums.sort_by!(&:"#{accessor}")
  end

end

require 'CSV'
class AlbumApp

  def call(env)
    albums = []
    response_body = "<h1>Top 100 Albums of All Time</h1><br><br><input placeholder='highlight a song number....'></input><button>Submit</button><br><ol>"

    File.open("top_100_albums.txt").each do |line|

      newline = line.to_s
      #chop cuts off the ugly \n after every entry
      1.times do newline.chop! end
      #splits the line to be able to index the date later for sorting
      albumSplit = newline.split(', ')


      #puts the albumsplit into the array to be turned into html later
      albums << albumSplit
    end

    #have a each loop to sort through the matrix removing the "" and [] from the output
    albums.each do |listedItem|
      response_body << "<li>"
      listedItem.each do |x|
        response_body << x + "  "
      end
      response_body << "</li>"
    end
    response_body << "</ol>"


    [200, {'Content-Type' => 'text/html'}, [response_body.to_s]]
  end

end

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
      newline.split(',', 2)

      listItem = "<li>" + newline + "</li>"
      #puts the listItem into the array to be added on later
      albums << listItem
    end
    # Read the data from the file.



    #have a each loop to get rid of the commas and brackets of the array
    albums.each do |listedItem|
      response_body << listedItem
    end
    response_body << "</ol>"
    [200, {'Content-Type' => 'text/html'}, [response_body.to_s]]
  end

end

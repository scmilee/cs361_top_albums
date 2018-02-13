require 'rack'
class AlbumApp


  def call(env)

    req = Rack::Request.new(env)
    path = req.path

    albums = []
    response_body = "<h1>Top 100 Albums of All Time</h1><br><br>
    <form action = '/highlight'>
    <input placeholder='highlight a song number....'></input>
    <button type='submit'>Submit</button>
    <button type='submit' formaction='/'>Rank</button>
    <button type='submit' formaction='/Alphabetical'>Alphabetical</button>
    <button type='submit' formaction='/Year'>Year</button>
    </form>
    <br>
    <ol>"

    File.open("top_100_albums.txt").each do |line|

      newline = line.to_s
      #chop cuts off the ugly \n after every entry
      1.times do newline.chop! end
      #splits the line to be able to index the date later for sorting
      albumSplit = newline.split(', ')
      #puts the albumsplit into the array to be turned into html later
      albums << albumSplit
    end
    if path == '/Alphabetical'
      albums.sort {|a,b| a[0] <=> b[0]}
      puts albums
    elsif path == '/Year'
      albums.sort {|a,b| a[1] <=> b[1]}
    end





    #have a each loop to sort through the matrix removing the "" and [] from the output
    albums.each do |splittedAlbum|
      response_body << "<li>"
      splittedAlbum.each do |x|
        response_body << x + "  "
      end
      response_body << "</li>"
    end
    response_body << "</ol>"


    [200, {'Content-Type' => 'text/html'}, [response_body.to_s]]
  end

end

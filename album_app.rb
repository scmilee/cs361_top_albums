require 'rack'

class AlbumApp

  def call(env)
    req = Rack::Request.new(env)
    highlight_index = req.params["number"] || 0
    #path = req.path_info
    stored_query = req.params["stored_sort"]
    query =  req.params["sortBy"] || stored_query

    albums = album_generator()
    response_body = ""

    #call cssGen and openFile to generate css and the entries into albums
    css_html_gen(response_body,query,stored_query)
    
    #the query/ path handlers works for either one once the formaction is changed for each button
    path_handler(albums,highlight_index,response_body,query)

    [200, {'Content-Type' => 'text/html'}, [response_body.to_s]]
  end

  def album_generator()

    album = []
    #have a each loop to sort through the matrix removing the "" and [] from the output
    #open the .txt file, read its strings, and add them to the album
    File.open("top_100_albums.txt").each do |line|
      newline = line.to_s
      #chop cuts off the ugly \n after every entry
      1.times do newline.chop! end
      #splits the line to be able to index the date later for sorting
      album_split = newline.split(', ')
      #puts the album_split into the array to be turned into html later
      album << album_split
    end

    return album
  end

#Takes information from album and converts to list format.
def list_generator(albums, number, response_body)
  highlight_index = 0
  albums.each do |splitted_album|
    highlight_index += 1
    if highlight_index.to_s === number.to_s
      response_body << '<li class="highlighted">'
    else
      response_body << "<li>"
    end
    splitted_album.each do |x|
      response_body << x + "  "
    end
    response_body << "</li>"
  end
  response_body << "</ol>"
end

#Handles request queries and sorts list based off of queries.
def path_handler(albums, highlight_index, response_body,query)
    #if path == '/Alphabetical'
    if query == 'alphabet'
      albums = albums.sort {|a,b| a[0] <=> b[0]}
    #elsif path == '/Year'
  elsif query == 'year'
    albums = albums.sort {|a,b| a[1] <=> b[1]}
  end
  list_generator(albums, highlight_index, response_body)
end

#Inserts base css and html code into response body.
def css_html_gen(response_body,query,stored_sort)
  response_body << "
  <style>
  h1 {
   background-color: #e74c3c;
   color: color: #ecf0f1;s
 }
 form {
  width: 50%;
  float: left;
}
ol {
  width: 35%;
}
.highlighted {
  background-color: tomato;
  color: black;
}
.centered {
  float: left;
  margin: auto;
  width: 50%;
  padding: 10px;
  margin-bottom: 10px;
}
button {
  margin-bottom: 10px;
}
</style>
<h1>Top 100 Albums of All Time</h1><br><br>
<form action= '/albums'>
<input type='hidden' name='stored_sort' value='"

    #carry over hidden value from the req
    response_body << (query || "")
    response_body<< "'/>
    <div class='centered'>
    <h2>Sort By:</h2>
    <button type='submit' name='sortBy' value = 'rank'>Rank</button>
    <button type='submit' name='sortBy' value = 'alphabet'>Alphabetical</button>
    <button type='submit' name='sortBy' value = 'year'>Year</button>
    <br>
    <input placeholder='highlight a song number....' name='number' id='number'>
    <button type='submit' name='highlight' value = 'true'>Submit</button>
    </div>
    </form>
    <br>
    <br>
    <ol>"

  end
end

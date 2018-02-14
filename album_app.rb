require 'rack'
class AlbumApp

  def call(env)

    req = Rack::Request.new(env)
    index = req.params["number"] || 0
    #path = req.path_info
    highlightz= req.params["highlight"]
    storedQuery = req.params["storedSort"]
    query =  req.params["sortBy"] || storedQuery

    albums = []
    response_body = ""

    #call cssGen and openFile to generate css and the entries into albums
    cssHtmlGen(response_body,query,storedQuery)
    readFile(albums)
    #the query/ path handlers works for either one once the formaction is changed for each button
    pathHandler(albums,index,response_body,query)

    [200, {'Content-Type' => 'text/html'}, [response_body.to_s]]
  end

  def readFile(albums)
    #have a each loop to sort through the matrix removing the "" and [] from the output
    #open the .txt file, read its strings, and add them to the album
    File.open("top_100_albums.txt").each do |line|
      newline = line.to_s
      #chop cuts off the ugly \n after every entry
      1.times do newline.chop! end
      #splits the line to be able to index the date later for sorting
      albumSplit = newline.split(', ')
      #puts the albumsplit into the array to be turned into html later
      albums << albumSplit
    end
  end

  def listGenerator(albums,number,response_body)
    index = 0
    albums.each do |splittedAlbum|
      index += 1
      if index.to_s === number.to_s
        response_body << '<li class="highlighted">'
      else
        response_body << "<li>"
      end
      splittedAlbum.each do |x|
        response_body << x + "  "
      end
      response_body << "</li>"
    end
    response_body << "</ol>"
  end

  def pathHandler(albums, index, response_body,query)
    #if path == '/Alphabetical'
    if query == 'alphabet'
      albums = albums.sort {|a,b| a[0] <=> b[0]}
    #elsif path == '/Year'
    elsif query == 'year'
      albums = albums.sort {|a,b| a[1] <=> b[1]}
    end
      listGenerator(albums, index, response_body)
  end

  def cssHtmlGen(response_body,query,storedSort)
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
    <input type='hidden' name='storedSort' value='"

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

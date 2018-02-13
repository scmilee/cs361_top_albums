require 'rack'
class AlbumApp


  def call(env)

    req = Rack::Request.new(env)
    path = req.path_info
    query = req.params["sortBy"]

    albums = []
    response_body = "
    <style>
    h1 {
       background-color: #e74c3c;
       color: color: #ecf0f1;s
    }
    .highlighted {
      background-color: tomato;
      color: black;
    }
    .centered {
      margin: auto;
      width: 50%;

      padding: 10px;
    }
    </style>
    <h1>Top 100 Albums of All Time</h1><br><br>
    <form action = '/highlight'>
    <input placeholder='highlight a song number....' name='number' id='number'>
    <button type='submit'name='sortBy' value = 'highlight'>Submit</button>
    <div class='centered'>
    <h2>Sort By:</h2>
    <button type='submit' name='sortBy' value = 'rank'>Rank</button>
    <button type='submit' name='sortBy' value = 'alphabet'>Alphabetical</button>
    <button type='submit' name='sortBy' value = 'year'>Year</button>
    </div>
    </form>
    <br>
    <ol>"
#have a each loop to sort through the matrix removing the "" and [] from the output
      
      listHighlighter = lambda{|albums,number|
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
      }

    File.open("top_100_albums.txt").each do |line|

      newline = line.to_s
      #chop cuts off the ugly \n after every entry
      1.times do newline.chop! end
      #splits the line to be able to index the date later for sorting
      albumSplit = newline.split(', ')
      #puts the albumsplit into the array to be turned into html later
      albums << albumSplit
    end
    #the query/ path handlers works for either one once the formaction is changed for each button
    #if path == '/highlight'
    if query == 'highlight'
      index = req.params["number"] || 0
      listHighlighter.call(albums, index)

    #elsif path == '/Alphabetical'
    elsif query == 'alphabet'

      sortedAl = albums.sort {|a,b| a[0] <=> b[0]}
      index = req.params["number"] || 0
      listHighlighter.call(sortedAl, index)

    #elsif path == '/Year'
    elsif query == 'year'
      sortedAlb = albums.sort {|a,b| a[1] <=> b[1]}
      index = req.params["number"] || 0
      listHighlighter.call(sortedAlb, index)
    else
      index = req.params["number"] || 0
      listHighlighter.call(albums, index)
    end
    [200, {'Content-Type' => 'text/html'}, [response_body.to_s]]
  end

end

require 'rubygems'
require 'rack'
require 'sinatra'
require_relative 'album'
require_relative 'albumlist'
require_relative 'htmlgen'

    albums = AlbumList.new
    helpers do
      def response_gen(highlight, albumz)
        response = albumz.htmlgenerator(highlight)
        [200, {'Content-Type' => 'text/html'}, [response.to_s]]
      end
    end
    before do
      @highlight_index = params["number"] || 0

    end

    get '/' do
      response_gen(@highlight_index, albums)
    end

    get '/rank' do
      albums.sort('rank')
      response_gen(@highlight_index, albums)
    end

    get '/alphabet' do
      albums.sort('title')
      response_gen(@highlight_index, albums)
    end
    get '/year' do
      albums.sort('year')
      response_gen(@highlight_index, albums)
    end
  

# class AlbumApp

#   def call(env)
#     req = Rack::Request.new(env)
#     highlight_index = req.params["number"] || 0
#     #path = req.path_info
#     stored_query = req.params["stored_sort"]
#     query =  req.params["sortBy"] || stored_query

#     albums = album_generator()
#     response_body = add_to_body("top.html")
#     response_body << (query || "")
#     response_body << add_to_body("bottom.html")

#     #the query/ path handlers works for either one once the formaction is changed for each button
#     path_handler(albums,highlight_index,response_body,query)

#     [200, {'Content-Type' => 'text/html'}, [response_body.to_s]]
#   end

#   def album_generator()

#     album = []
#     #have a each loop to sort through the matrix removing the "" and [] from the output
#     #open the .txt file, read its strings, and add them to the album
#     File.open("top_100_albums.txt").each do |line|
#       newline = line.to_s
#       #chop cuts off the ugly \n after every entry
#       newline.chop
#       #splits the line to be able to index the date later for sorting
#       album_split = newline.split(', ')
#       #puts the album_split into the array to be turned into html later
#       album << album_split
#     end

#     return album
#   end

# #Takes information from album and converts to list format.
# def list_generator(albums, number, response_body)
#   highlight_index = 0
#   albums.each do |splitted_album|
#     highlight_index += 1
#     if highlight_index.to_s === number.to_s
#       response_body << '<li class="highlighted">'
#     else
#       response_body << "<li>"
#     end
#     splitted_album.each do |x|
#       response_body << x + "  "
#     end
#     response_body << "</li>"
#   end
#   response_body << "</ol>"
# end

#   #Handles request queries and sorts list based off of queries.
#   def path_handler(albums, highlight_index, response_body,query)
#       #if path == '/Alphabetical'
#       if query == 'alphabet'
#         albums = albums.sort {|a,b| a[0] <=> b[0]}
#       #elsif path == '/Year'
#     elsif query == 'year'
#       albums = albums.sort {|a,b| a[1] <=> b[1]}
#     end
#     list_generator(albums, highlight_index, response_body)
#   end

#   #Add top HTML portion to response body.
#   def add_to_body(file_name)
#     response = ""
#     File.open(file_name).each do |line|
#       response << line
#     end
#     return response
#   end
# end

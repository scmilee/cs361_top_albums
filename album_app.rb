require 'rubygems'
require 'rack'
require 'sinatra/base'
require 'sinatra'
require_relative 'album'
require_relative 'albumlist'
require_relative 'htmlgen'

class AlbumApp < Sinatra::Base
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

end


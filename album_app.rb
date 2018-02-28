require 'rubygems'
require 'rack'
require 'sinatra/base'
require 'sinatra'
require_relative 'album'
require_relative 'albumlist'

class AlbumApp < Sinatra::Base

  helpers do
    def renderer(album_list, sort_by)
      album_list.sort(sort_by)
      album_list.highlight(@highlight)
      erb :index
    end
  end

  before do
    @album_list = AlbumList.new()
    @highlight = params["number"] || 0
    @albums = @album_list.albums
  end

  get '/' do
    erb :index
  end

  get '/rank' do
    renderer(@album_list, 'rank')
  end

  get '/alphabet' do
    renderer(@album_list, 'title')
  end

  get '/year' do
    renderer(@album_list, 'year')
  end

end

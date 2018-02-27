require 'rubygems'
require 'rack'
require 'sinatra/base'
require 'sinatra'
require_relative 'album'
require_relative 'albumlist'


class AlbumApp < Sinatra::Base

  helpers do
    def renderer(album_list)
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
    @album_list.sort('rank')
    renderer(@album_list)
  end

  get '/alphabet' do
    @album_list.sort('title')
    renderer(@album_list)
  end

  get '/year' do
    @album_list.sort('year')
    renderer(@album_list)
  end

end

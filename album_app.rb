class AlbumApp

  def call(env)
    [200, {'Content-Type' => 'text/html'}, ['<h1>Top 100 Albums of All Time</h1>']]
  end

end
class AlbumApp

  def call(env)
    response_body = "<h1>Top 100 Albums of All Time</h1>"
    # Read the data from the file.
    albums = ['fee', 'fi', 'fo', 'funk']
    # Append it to the response body.
    response_body << albums.to_s
    # Send the response
    [200, {'Content-Type' => 'text/html'}, [response_body.to_s]]
  end

end
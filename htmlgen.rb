class HtmlGen

  def initialize(albums, highlight_index)
    @response_body = ""
    @albums = albums
    @higlight = highlight_index
    generate
  end
  attr_accessor :response_body

  def add_to_body(file_name)
    response = ""
    File.open(file_name).each do |line|
      response << line
    end
    return response
  end

  def list_generator(albums, index)
    highlight_index = 0
    response = ""
    albums.each do |splitted_album|
      highlight_index += 1
      if highlight_index.to_s === index.to_s
        response << '<li class="highlighted">'
      else
        response << "<li>"
      end
      response << splitted_album.title
      response << " "
      response << splitted_album.year
      response << "</li>"
    end
    response << "</ol>"
    return response
  end

  def generate
    @response_body = add_to_body("top.html")
    @response_body << list_generator(@albums, @higlight)
  end

end

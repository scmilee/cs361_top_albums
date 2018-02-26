require 'erb'
class HtmlGen
  include ERB::Util
  def initialize(albums, highlight_index)

    @albums = albums
    @higlight = highlight_index
    @template = get_template
    @response_body = ''
    save(File.join(ENV['HOME'], 'top.html'))
  end
  attr_accessor :template, :albums, :response_body

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
    response_bod = ""
    response_bod = add_to_body("top.html")
    return response_bod
  end
  def get_template
    return %{
          <% highlight_index = 1 %>
          <% for @album in @albums %>
            <% if @highlight == highlight_index %>
              <li class = 'highlighted'>
                <%= h(@album) %>
              </li>
            <% else %>
              <li>
                <%= h(@album) %>
              </li>
            <% end %>

          <% highlight_index += 1 %>
          <% end %>
        </ol>
    }

  end

  def render()
    ERB.new(@template).result(binding)
  end

  def save(file)
    File.open(file, "w+") do |f|
      f.write(render)
    end
  end

end

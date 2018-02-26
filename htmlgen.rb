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

  def generate
    response_bod = ""
    response_bod = add_to_body("top.html")
    return response_bod
  end
  def get_template
     %{
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
    File.open(file, "a") do |f|
      f.write(render)
    end
  end

end

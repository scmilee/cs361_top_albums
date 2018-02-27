require 'erb'

class HtmlGen
  include ERB::Util
  def initialize(albums, highlight_index)

    @albums = albums
    @higlight = highlight_index
    @template = get_template
    @response_body = add_to_body('top.html')
    
    save('sorted.html')
    @response_body << add_to_body('sorted.html')
  end
  attr_accessor :template, :albums, :response_body, :highlight

  def add_to_body(file_name)
    response = ""
    File.open(file_name).each do |line|
      response << line.to_s
    end
    return response
  end

  def get_template
   %{
    <% highlight_counter = 1 %>
    <% for @album in @albums %>
    <% if @highlight.to_s === highlight_counter.to_s %>
      <li class = "highlighted">
      <%= h(@album.title) %>
      <%= h(@album.year) %>
      </li>
      <% else %>
      <li>
      <%= h(@album.title) %>
      <%= h(@album.year) %>
      </li>
      
      <% end %>
      <% highlight_counter += 1 %>

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

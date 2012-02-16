$:.push File.expand_path("../../", __FILE__)
require 'erb'
require 'nested_list'
module NestedList
  module Task
    include Generator
    def generate_html
      template = ERB.new <<-EOF
      <!DOCTYPE html>
      <html>
      <head>
        <title>Nested List</title>
      </head>
      <body>
        <select><%= nested_options_example %></select>
      </body>
      </html>
      EOF
      mkdir_p "lib/public/"
      puts "cd lib/public/"
      puts "File nested_list.html preparing..."
      File.open("lib/public/nested_list.html", "w") do |f|        
        f.puts template.result(binding)
      end
      puts "lib/public/nested_list.html was created"
    end
  end
end
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
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
      </head>
      <body>
        Nested categories list:<br/>
        <select><%= nested_options_example %></select><br/><br/>
        Can be used for other language:<br/>
        <select><%= nested_options_example_ru %></select>
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
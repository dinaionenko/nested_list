require "nested_list/nested_select"
require "active_support/inflector"

class NestedList
  # Get Array of nested names:
  #[{name: "All Categories", id: 'all'},
  # {name: "Audio", id: '1'},
  # {name: "Audio>Accessorize", id: '1424'},
  # {name: "Audio>Accessorize>Pillow", id: '45255'}
  # {name: "Audio>DVD", id: '234245'},
  # {name: "Baby", id: '44245tr5'}]
  def initialize(nested_names_arr)
    @nested_names_arr = nested_names_arr
  end

  #Return a list of nested html_options from nested names array
  def html_options
    @wraped_list =  {}
    list = NestedSelect::List.new("root", nil)

    @nested_names_arr.each do |nested_names|
      @names = nested_names[:name].split(">")
      point = list
      length = @names.length - 1
      @names.each_with_index do |name, level|
         id = nested_names[:id]
         full_name = @names[0..level].join(" ").parameterize

         if  exist_node=list.find_by_name(full_name)
           # Use existed name
           if  exist_node.full_name!=full_name && length != level

             found_item = exist_node.find_item(name)
             moved_item = found_item

             exist_node.remove_item(found_item)
             item = NestedSelect::List.new(name, nil)
             item.add_item(moved_item)
             exist_node.add_item(item)
             point = item
           else
             point = exist_node
           end

         else
          # Create new node
          unless (level == length)
            item = NestedSelect::List.new(name, nil)
            item.add_item(NestedSelect::Item.new(name, nil))
          else
            item = NestedSelect::Item.new(name, id)
          end

          point.add_item(item)
          point = item
         end
     end

    end

    @wraped_list = list.wrap
    end
end

# Example
@nested_names_arr = []
@nested_names_arr << {name: "All Categories", id: 'all'}
@nested_names_arr << {name: "Audio", id: '1'}
@nested_names_arr << {name: "Audio>Accessorize>Smile", id: '566767'}
@nested_names_arr << {name: "Audio>Accessorize>Pillow", id: '45255'}
@nested_names_arr << {name: "Audio>DVD", id: '234245'}
@nested_names_arr << {name: "Baby", id: '44245tr5'}

nested_list = NestedList.new(@nested_names_arr)
puts nested_list.html_options
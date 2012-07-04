require 'test/unit'
require 'nested_list'

class NestedListTest < Test::Unit::TestCase
  def test_registry_insensitive
    categories = [
      { id: 1679, name: "Cooking" },
      { id: 8140, name: "COOKING > BICOOKING" },
      { id: 8130, name: "COOKING > BIHOBS" }
    ]
    _expected_html_options = "<option value='cooking:group' class='level_1 group'>Cooking</option><option value='1679' class='level_2 item'>&nbsp;&nbsp;&nbsp;&nbsp;Cooking</option><option value='8140' class='level_2 item'>&nbsp;&nbsp;&nbsp;&nbsp;Bicooking</option><option value='8130' class='level_2 item'>&nbsp;&nbsp;&nbsp;&nbsp;Bihobs</option>"
    nested_list = Generator::NestedList.new(categories)
    assert_equal _expected_html_options, nested_list.html_options
  end
end

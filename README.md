Description
===========

nested_list gem is a tool for creating nested cross browser drop downs. It doesn't use any fancy UI, all margins were done with spaces (&nbsp). It is simple and it works.  

Install
=======

`gem install nested_list`

OR

Put this line in your Gemfile:
`gem 'nested_list'`

Then run the bundle command:
`$ bundle`

Example of usage
=======

Array with nested options which using ">" as a delimiter

	    @nested_names_arr = []
      @nested_names_arr << {name: "All Categories", id: 'all'}
		  @nested_names_arr << {name: "Audio", id: '1'}
  		@nested_names_arr << {name: "Audio>Accessorize>Smile", id: '566767'}
  		@nested_names_arr << {name: "Audio>Accessorize>Pillow", id: '45255'}
  		@nested_names_arr << {name: "Audio>DVD", id: '234245'}
  		@nested_names_arr << {name: "Baby", id: '44245tr5'}

Pass it as a parameter and get options for drop down as an output

	    nested_list = NestedList.new(@nested_names_arr)
	    nested_list.html_options

As a result you will see a drop down like this:
<img src="http://imgur.com/OylKc" alt="generated drop down" />	    

Contributing
============

if you find a bug or have something to add, please do
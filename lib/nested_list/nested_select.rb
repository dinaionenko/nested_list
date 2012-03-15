module NestedSelect
  def parameterized_name(names)
    names.map! { |name| name.to_s.strip.downcase }
    names.join("-")
  end

  class Item
    include NestedSelect
    attr_accessor :name, :parent, :id
    @@use_spaces = true
    def initialize(name, id)
      @name = name.to_s.strip
      @id = id.to_s
      @parent = nil
    end

    def spaces
      space = ""
      if @@use_spaces
        (parents_count-1).to_i.times{|i| space+='&nbsp;&nbsp;&nbsp;&nbsp;'}
      end
      space
    end

    def find_by_name(name_tmp)
      if !self.name.empty? && self.full_name == name_tmp
        self.parent
      else
        false
      end
    end

    def parents_count
      item = self
      count = 0
      while item = item.parent
        count += 1
      end
      count
    end

    def items_count
      1
    end

    def full_name
      unless @full_name_str
        item = self
        full_name = []
        full_name << name
        while item = item.parent
          full_name << item.name
        end
        # Remove last general for all element
        full_name.pop
        full_name_str = parameterized_name(full_name.reverse!)
      end
      @full_name_str ||= full_name_str
    end

    def wrap
      self.id && !self.id.empty? ? "<option value='#{self.id}' class='level_#{parents_count} item'>#{spaces}#{name.humanize}</option>" : ""
    end
  end


  class List < Item

    def initialize(name, id)
      super(name, id)
      @items = []
    end

    def node
      @items.first
    end

    def branches
      @branches = @items[1..@items.size]
    end

    def add_item(item)
      @items << item
      item.parent = self
    end

    def remove_item(item)
      @items.delete(item)
      item.parent = nil
    end

    def find_item(tmp_name)
      tmp_name = tmp_name.to_s.strip
      @items.find do |item|
        item.name == tmp_name
      end
    end

     def items_count
       @items.inject(0){|acc,i| acc+i.items_count}
    end

    def find_by_name(name_tmp)
      existed_item = nil
      existed_items = []

      if self.full_name == name_tmp
        return self
      end

      @items.each do |item|
        existed_item = item.find_by_name(name_tmp)
        existed_items << existed_item if existed_item
      end
      return nil if existed_items.size == 0
      return existed_items[0]
    end

    def wrap
      result = (name == 'root') ? "" : "<option value='#{full_name}:group' class='level_#{(n = parents_count.modulo(4))>0 || parents_count==0 ? n : 4} group'>#{spaces}#{name.humanize}</option>"
      @items.each {|item| result += item.wrap }
      result
    end
  end
end
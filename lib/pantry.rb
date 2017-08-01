class Pantry

  attr_reader :stock,
              :cookbook

  def initialize
    @stock = Hash.new 0
    @cookbook = []
  end

  def stock_check(item)
    @stock[item]
  end

  def restock(item, amount)
    @stock[item] = (@stock[item] + amount)
  end

  def convert_units(recipe)
    recipe.ingredients.each do |k, v|
      recipe.ingredients[k] = convert_units_helper(v)
    end
  end

  def convert_units_helper(value)
    # if value.class == Float
    #   value = other_helper(value)
    if value < 1
      value = {:quantity => value * 1000, :units => "Milli-Units"}
    elsif value > 100
      value = {:quantity => value / 100, :units => "Centi-Units"}
    else
      value = {:quantity => value, :units => "Universal Units"}
    end
  end

  def other_helper(value)
    units_1 = (value % 1).round(value.to_s.length - 1)
    units_2 = value.to_i

    [convert_units_helper(units_1), convert_units_helper(units_2)]
  end

  def add_to_cookbook(recipe)
    @cookbook << recipe
  end

  def what_can_i_make
    i_can_make = []
    cookbook.each do |recipe|
    recipe.ingredients.all? do |k, v|
      if stock[k] > v
      i_can_make << recipe.name
      end
    end
  end
  i_can_make.uniq
end


end

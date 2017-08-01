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
    if value < 0.0999999
      value = {:quantity => value * 1000, :units => "Milli-Units"}
    elsif value > 100
      value = {:quantity => value / 100, :units => "Centi-Units"}
    else
      value = {:quantity => value, :units => "Universal Units"}
    end
  end

  def add_to_cookbook(recipe)
    @cookbook << recipe
  end


end

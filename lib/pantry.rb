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
    converted = Hash.new 0
    recipe.ingredients.each do |k, v|
      converted[k] = convert_units_helper_1(v)
    end
    converted
  end

  def convert_units_helper_1(value)
    if value > 100 && value % 100 != 0
      units_1 = (value % 100).round(3)
      units_2 = (value - value % 100).to_i
      value = [convert_units_helper(units_2), convert_units_helper(units_1)]
    elsif value > 100
      value = [convert_units_helper(value)]
    elsif (1..100).cover?(value) && value % 1 != 0
      units_1 = (value % 1).round(3)
      units_2 = (value - value % 1).to_i
      value = [convert_units_helper(units_1), convert_units_helper(units_2)]
    else
      (1..100).cover?(value)
      value = [convert_units_helper(value)]
    end
  end

  def convert_units_helper(value)
    # if value.class == Float
    #   value = other_helper(value)
    if value < 1
      value = {:quantity => (value * 1000).to_i, :units => "Milli-Units"}
    elsif value > 100
      value = {:quantity => value / 100, :units => "Centi-Units"}
    else
      value = {:quantity => value.to_i, :units => "Universal Units"}
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
    i_can_make = what_can_i_make_helper
    i_can_make.map {|recipe| recipe.name}
  end

  def how_many_can_i_make
    how_many = Hash.new 0
    divs = []
    i_can_make = what_can_i_make_helper
    i_can_make.each do |recipe|
      recipe.ingredients.each do |ingredient, takes|
        divs << stock[ingredient] / takes
      end
      how_many[recipe.name] = divs.sort.shift
    end
    how_many
  end

  def what_can_i_make_helper
    i_can_make = []
    cookbook.each do |recipe|
      recipe.ingredients.all? do |k, v|
        if stock[k] > v
        i_can_make << recipe
        end
      end
    end
    i_can_make.uniq
  end


end

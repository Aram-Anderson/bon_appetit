require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'

class PantryTest < Minitest::Test

  def test_it_exists
    pantry = Pantry.new

    assert_instance_of Pantry, pantry
  end

  def test_it_has_stock
    pantry = Pantry.new

    assert_equal({}, pantry.stock)
  end

  def test_it_can_stock_check
    pantry = Pantry.new

    assert_equal 0, pantry.stock_check("Cheese")
  end

  def test_it_can_restock
    pantry = Pantry.new

    assert_equal 0, pantry.stock_check("Cheese")

    pantry.restock("Cheese", 10)

    assert_equal 10, pantry.stock_check("Cheese")

  end
# pantry.stock_check("Cheese")
# # => 10
# pantry.restock("Cheese", 20)
# pantry.stock_check("Cheese")
# => 30

end

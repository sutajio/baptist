# encoding: UTF-8

require 'test/unit'
require 'baptist'

class BaptistTest < Test::Unit::TestCase

  def test_spaces
    assert_equal 'Arthur-Russell', Baptist.generate('Arthur Russell')
    assert_equal 'Arthur_Russell', Baptist.generate('Arthur Russell', :space => '_')
    assert_equal 'Maher-Shalal-Hash-Baz', Baptist.generate('Maher Shalal Hash Baz')
  end

  def test_multiple_names
    assert_equal 'Arthur-Russell/Calling-Out-of-Context', Baptist.generate(['Arthur Russell', 'Calling Out of Context'])
    assert_equal 'Arthur-Russell|Calling-Out-of-Context', Baptist.generate(['Arthur Russell', 'Calling Out of Context'], :separator => '|')
    assert_equal 'Arthur-Russell/Calling-Out-of-Context', Baptist.generate(['Arthur Russell', nil, 'Calling Out of Context'])
  end

  def test_strange_characters
    assert_equal "-_.!~*'()-", Baptist.generate("-_.!~*'()/")
    assert_equal 'Tr%C3%A4d%2C-Gr%C3%A4s-och-Stenar', Baptist.generate('Träd, Gräs och Stenar')
  end

  def test_modifier
    assert_equal 'Rihanna/Loud-(Explicit)', Baptist.generate(['Rihanna', 'Loud'], :modifier => 'Explicit')
  end

  def test_unique
    assert_equal 'John-Doe', Baptist.generate('John Doe') {|uri| true }
    assert_equal 'John-Doe-3', Baptist.generate('John Doe') {|uri| uri == 'John-Doe-3' }
    assert_equal 'John-Doe-1000', Baptist.generate('John Doe', :multiplier => 10) {|uri| uri == 'John-Doe-1000' }
    assert_equal 'John-Doe-***', Baptist.generate('John Doe', :multiplier => '*') {|uri| uri == 'John-Doe-***' }
  end

  def test_generate_name
    assert_equal 22, Baptist.generate.size
    assert Baptist.generate != Baptist.generate
  end

end

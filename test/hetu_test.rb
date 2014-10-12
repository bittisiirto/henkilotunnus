require 'test_helper'

class HetuTest < Minitest::Test
  def h(s)
    Hetu.new(s)
  end

  def test_valid
    [ '120464-126J',
      '280264-051U' ].each do |pin|
      assert h(pin).valid?
      assert Hetu.valid? pin
    end

    assert_equal false, h(nil).valid?
    assert_equal false, h('').valid?
  end

  def test_date_of_birth
    assert_equal '280264', h('280264-051U').date_of_birth
  end

  def test_century_sign
    assert_equal '-', h('280264-051U').century_sign
  end

  def test_person_number
    assert_equal '051', h('280264-051U').person_number
  end

  def test_gender
    assert_equal 'male', h('280264-051U').gender
    assert_equal true, h('280264-051U').male?
    assert_equal false, h('280264-051U').female?
  end

  def test_checksum
    assert_equal 'U', h('280264-051U').checksum
  end

  def test_special_invalid
    assert_equal false, Hetu.new('311280-999J').valid?
  end

  def test_allow_badly_formatted
    pin = Hetu.new('  2802 6 4-05  1u   ')
    assert pin.valid?
    assert '280264-051U', pin.to_s
  end
end
require './test_helper'

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
    dob = h('280199+972S').date_of_birth
    assert_equal 1899, dob.year
    assert_equal 1, dob.month
    assert_equal 28, dob.day

    dob = h('280264-051U').date_of_birth
    assert_equal 1964, dob.year
    assert_equal 2, dob.month
    assert_equal 28, dob.day

    dob = h('231001A0614').date_of_birth
    assert_equal 2001, dob.year
    assert_equal 10, dob.month
    assert_equal 23, dob.day
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

  def test_century
    assert_equal 1800, h('280199+972S').century
    assert_equal 1900, h('280264-051U').century
    assert_equal 2000, h('231001A0614').century
  end

  def test_age
    Timecop.freeze(Time.utc(1994, 2, 28)) do
      assert_equal 30, h('280264-051U').age
    end
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
require 'test_helper'

class HetuTest < Minitest::Test
  NEW_HETU_LIST = ['010594Y9021', '020594X903P', '020594X902N', '030594W903B', '030694W9024',
  '040594V9030', '040594V902Y', '050594U903M', '050594U902L', '010516B903X',
  '010516B902W', '020516C903K', '020516C902J', '030516D9037', '030516D9026',
  '010501E9032', '020502E902X', '020503F9037', '020504A902E', '020504B904H']

  puts Time.now
  def h(s)
    Hetu.new(s)
  end

  def g(args={})
    Hetu.generate(args)
  end

  def test_new_punctuation
    NEW_HETU_LIST.each do |pin|
      assert h(pin).valid?
    end
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
    assert h('060193-187M').male?
    assert h('060193-158J').female?
    assert_equal h('060193-187M').gender, "male"
    assert_equal false, h('010199Y999X').female?
    assert h('010199Y999X').male?
    assert_equal 'male', h('280264-051U').gender
    assert_equal true, h('280264-051U').male?
    assert_equal false, h('280264-051U').female?
  end

  def test_gender_neutral
    Timecop.travel(2028, 1, 1, 10, 5, 0)

    assert h('010199Y999X').is_gender_neutral?
    assert_equal false, h('090499-185J').is_gender_neutral?
    assert h('090499-185J').male?

    assert_raises RuntimeError do
      h('010199Y999X').gender
    end

    assert_raises RuntimeError do
      h('010199V999X').male?
    end

    assert_raises RuntimeError do
      h('010199W999X').female?
    end

    Timecop.return
  end


  def test_century
    assert_equal 1800, h('280199+972S').century
    assert_equal 1900, h('280264-051U').century
    assert_equal 2000, h('231001A0614').century
    assert_equal 1900, h('020502Y902X').century
    assert_equal 2000, h('020516C903K').century
  end

  def test_age
    Timecop.freeze(Time.utc(1994, 2, 28)) do
      assert_equal 30, h('280264-051U').age
    end
  end

  def test_checksum
    assert_equal 'U', h('280264-051U').checksum
  end

  def test_allow_badly_formatted
    pin = Hetu.new('  2802 6 4-05  1u   ')
    assert pin.valid?
    assert '280264-051U', pin.to_s
  end

  def test_generate
    100.times do
      assert g.valid?
    end
  end

  def test_generate_with_person_number
    assert_equal '051', g(person_number: 51).person_number
  end

  def test_generate_with_date
    date = Date.new(1964, 2, 28)
    hetu = g(date: date)
    assert_equal date, hetu.date_of_birth
  end
end

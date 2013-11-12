require 'test_helper'

class HetuTest < MiniTest::Unit::TestCase
	def setup
		@pin = Hetu.new('280264-051U')
	end

	def test_valid
		assert_equal @pin.valid?, true
	end

	def test_class_valid
		assert_equal Hetu.valid?('280264-051U'), true
	end

	def test_date_of_birth
		assert_equal @pin.date_of_birth, "280264"
	end

	def test_century_sign
		assert_equal @pin.century_sign, "-"
	end

	def test_person_number
		assert_equal @pin.person_number, "051"
	end

	def test_gender
		assert_equal @pin.gender, "male"
	end

	def test_gender_bools
		assert_equal @pin.male?, true
		assert_equal @pin.female?, false
	end

	def test_checksum
		assert_equal @pin.checksum, "U"
	end

	def test_should_compute_correct_checksum
		assert_equal @pin.valid_checksum?, true
	end

	def test_should_be_valid
		["120464-126J"].each do |pin|
			assert_equal Hetu.new(pin).valid?, true	
		end
	end

	def test_special_invalid
		assert_equal Hetu.new("311280-999J").valid?, false
	end

	def test_dont_allow_badly_formatted
		assert_equal Hetu.new("  2802 6 4-05  1u   ").valid?, false
		assert_equal Hetu.new("311280-999j").valid?, false
	end

	def test_to_s
		assert_equal Hetu.new('280264-051U').to_s, '280264-051U'
	end

end
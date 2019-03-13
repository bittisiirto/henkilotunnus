require 'test_helper'
require 'henkilotunnus/test/person_model'

class HetuValidatorTest < Minitest::Test
  def create_model
    PersonModel.new('X')
  end

  def test_validator_valid
    Hetu.stub(:valid?, true) do
      model = create_model
      assert model.valid?
      assert !model.errors.any?
    end
  end

  def test_validator_invalid
    Hetu.stub(:valid?, false) do
      model = create_model
      assert !model.valid?
      assert_includes model.errors.keys, :pin
      assert_equal model.errors.messages[:pin], ["is invalid"]
    end
  end

  def test_validator_invalid_with_message
    Hetu.stub(:valid?, false) do
      model = create_model
      assert !model.valid?
      assert_equal model.errors.messages[:pin_message], ["custom message"]
    end
  end
end

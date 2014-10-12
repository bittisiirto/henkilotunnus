require 'test_helper'

class User
  include ActiveModel::Model

  attr_accessor :pin

  validates :pin, hetu: true

  def persisted?
    false
  end
end

class UserWithMessage
  include ActiveModel::Model

  attr_accessor :pin

  validates :pin, hetu: { message: 'alien pin dawg!' }

  def persisted?
    false
  end
end

describe HetuValidator do
  it 'should be valid' do
    user = User.new
    user.pin = '280264-051U'
    user.valid?.must_equal true
  end

  it 'should be invalid' do
    user = User.new
    user.pin = 'foo'
    user.valid?.must_equal false
    user.errors.added?(:pin).must_equal true
  end

  it 'should work with custom messages' do
    user = UserWithMessage.new
    user.pin = 'foo'
    user.valid?.must_equal false
    user.errors[:pin].must_include 'alien pin dawg!'
  end
end
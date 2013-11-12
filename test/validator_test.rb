require 'test_helper'

class User
	include ActiveModel::Model

	attr_accessor :pin

	validates :pin, hetu: true

	def persisted?
		false
	end
end

describe HetuValidator do
	before {
		@user = User.new
	}

	it "should be valid" do
		@user.pin = "280264-051U"
		@user.valid?.must_equal true
	end

	it "should be invalid" do
		@user.pin = "280264-051M"
		@user.valid?.must_equal false
		@user.errors[:pin].must_include "is invalid"
	end
end
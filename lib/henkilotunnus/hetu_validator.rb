require 'active_model/validator'

module Henkilotunnus
	class HetuValidator < ActiveModel::EachValidator
	  def validate_each(record, attribute, value)
	    record.errors.add(attribute, options[:message] || :invalid) unless Hetu.valid?(value)
	  end
	end
end

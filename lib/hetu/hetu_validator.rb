require 'active_model/validator'

class HetuValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, :invalid) unless Hetu.valid?(value)
  end
end
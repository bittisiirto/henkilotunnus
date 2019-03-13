require 'active_model'

module Henkilotunnus
  # A dummy model for testing the validator.
  class PersonModel
    include ActiveModel::Validations

    validates :pin, hetu: true
    validates :pin_message, hetu: { message: 'custom message' }

    attr_reader :pin
    attr_reader :pin_message

    def initialize(pin)
      @pin = pin
      @pin_message = pin
    end
  end
end

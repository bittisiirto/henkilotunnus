require 'hetu/version'
require 'hetu/hetu_validator' if defined? ActiveModel

class Hetu
  GENDERS = ['female', 'male']

  def self.valid?(pin)
    new(pin).valid?
  end

  attr_reader :pin

  def initialize(pin)
    @pin = format(pin || '')
  end

  def valid?
    valid_format? and valid_checksum? and valid_person_number?
  end

  def date_of_birth
    pin[0..5]
  end

  def century_sign
    pin[6]
  end

  def person_number
    pin[7..9]
  end

  def gender
    GENDERS[person_number.to_i % 2]
  end

  def male?
    gender == 'male'
  end

  def female?
    gender == 'female'
  end

  def checksum
    pin[10]
  end

  def to_s
    pin
  end

  private

  def format(s)
    s.to_s.gsub(/\s+/, '').upcase
  end

  def valid_format?
    !!(pin =~ /^\d{6}[-+A]\d{3}[0-9A-Z]$/)
  end

  def valid_checksum?
    compute_checksum == checksum
  end

  def valid_person_number?
    (2..899).cover?(person_number.to_i)
  end

  def compute_checksum
    '0123456789ABCDEFHJKLMNPRSTUVWXY'[ (date_of_birth + person_number).to_i % 31 ]
  end
end
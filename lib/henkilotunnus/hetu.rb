module Henkilotunnus
  class Hetu
    GENDERS = ['female', 'male']
    CENTURIES = { '+' => 1800, '-' => 1900, 'A' => 2000 }
    CHECKSUM_CHARS = '0123456789ABCDEFHJKLMNPRSTUVWXY'

    def self.valid?(pin)
      new(pin).valid?
    end

    attr_reader :pin

    def initialize(pin)
      @pin = format(pin || '')
    end

    def valid?
      valid_format? && valid_checksum? && valid_person_number?
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

    def age
      dob = date_of_birth
      # TODO: Should use EEST timezone for everything as Finland has only a single timezone (but with DST!).
      now = Time.now.utc.to_date
      now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
    end

    def date_of_birth
      dob = raw_dob
      day = dob[0..1].to_i
      month = dob[2..3].to_i
      year = century + dob[4..5].to_i
      Date.new(year, month, day)
    end

    def century
      CENTURIES[century_sign]
    end

    def checksum
      pin[10]
    end

    def to_s
      pin
    end

    private

    def raw_dob
      pin[0..5]
    end

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
      CHECKSUM_CHARS[ (raw_dob + person_number).to_i % 31 ]
    end
  end
end
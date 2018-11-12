module Henkilotunnus
  class Hetu
    GENDERS = ['female', 'male']
    CENTURIES = { '+' => 1800, '-' => 1900, 'A' => 2000 }
    PERSON_NUMBER_RANGE = 2..899
    CHECKSUM_CHARS = '0123456789ABCDEFHJKLMNPRSTUVWXY'

    def self.valid?(pin)
      new(pin).valid?
    end

    def self.generate(**kwargs)
      dob = date_of_birth(kwargs)
      raw_dob = dob.strftime("%d%m%y")
      person_number = kwargs.fetch(:person_number, rand(PERSON_NUMBER_RANGE)).to_s.rjust(3, "0")
      new(raw_dob + century_sign(century(dob)) + person_number + compute_checksum(raw_dob, person_number)).tap do |h|
        raise "generated hetu was invalid" unless h.valid?
      end
    end

    def self.date_of_birth(**kwargs)
      kwargs.fetch(:date, random_time_between(date_limits(kwargs))).to_date.tap do |date|
        raise "invalid date #{date}" unless date >= Date.new(1800, 1, 1)
      end
    end

    def self.random_time_between(start_date: Date.new(1800, 1, 2), end_date: Time.now.utc.to_date)
      Time.at(rand(start_date.to_time.to_i...(end_date.to_time.to_i + 24*60*60)))
    end

    def self.date_limits(**kwargs)
      kwargs.select { |k,v| [:start_date, :end_date].include?(k) && !v.nil? }
    end

    def self.compute_checksum(raw_dob, person_number)
      CHECKSUM_CHARS[ (raw_dob + person_number).to_i % 31 ]
    end

    def self.century(date)
      date.year - (date.year % 100)
    end

    def self.century_sign(century)
      CENTURIES.key(century)
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
      PERSON_NUMBER_RANGE.cover?(person_number.to_i)
    end

    def compute_checksum
      self.class.compute_checksum(raw_dob, person_number)
    end
  end
end

require 'twilio-ruby'

class Twolio
  ACCT = ENV['TWILIO_ACC']
  TOK = ENV['TWILIO_TOK']

  def self.rest_client
    @rest_client ||= Twilio::REST::Client.new(ACCT, TOK)
  end
end

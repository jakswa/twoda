require 'twilio-ruby'
require 'dotenv'

Dotenv.load

class Twolio
  ACCT = ENV['TWILIO_ACC']
  TOK = ENV['TWILIO_TOK']

  def self.rest_client
    @rest_client ||= Twilio::REST::Client.new(ACCT, TOK)
  end

  class Call
    def initialize(network_id)
      @network_id = network_id
    end

    def conference
      return @conference if defined?(@conference)
      @conference = Twolio.rest_client.conferences.list
        .find { |c| c.friendly_name == @network_id }
    end

    def update_participant(opts)
      Twolio.rest_client.conferences(conference.sid).participants(@network_id).update(opts)
    end

    def hold
      update_participant(hold: true)
    end

    def unhold
      update_participant(hold: false)
    end

    def redirect(path)
      Twolio.reset_client.calls(@network_id).update(url: path)
    end
  end
end

require 'roda'
Dir['./twoda/**/*.rb'].each { |f| require f }

class Twoda < Roda
  plugin :render
  plugin :json_parser

  route do |r|
    r.root { view('index.html') }

    r.on 'calls', String do |network_id|
      r.get do
        view('calls/show.html', locals: { call: call })
      end

      r.post 'unhold' do
        r.redirect
      end

      r.post 'hold' do
        r.redirect
      end
    end

    r.post 'twilio-call-status' do
      'ok'
    end

    r.on 'twiml' do
      r.post 'calls' do
        render('calls/new.xml')
      end

      r.post 'calls/gather', String do |prompt|
        render('calls/gather.xml', locals: { prompt: prompt })
      end

      r.post 'calls', String do
        render('calls/new.xml')
      end
    end
  end
end

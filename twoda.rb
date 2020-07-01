require 'roda'
Dir['./twoda/**/*.rb'].each { |f| require f }

class Twoda < Roda
  plugin :render
  plugin :json_parser

  route do |r|
    r.root { view('index.html', locals: { calls: Call.all }) }

    r.on 'calls', String do |network_id|
      r.get do
        call = Call.find(network_id)
        view('calls/show.html', locals: { call: call })
      end

      r.post 'hold' do
        r.redirect
      end
    end

    r.on 'twiml' do
      r.post 'calls' do
        call = Call.create(request.params)
        render('calls/new.xml', locals: { call: call })
      end

      r.post 'calls', String do
        call = Call.upsert(request.params)
        render('calls/new.xml', locals: { call: call })
      end
    end
  end
end

class Call
  @calls = []

  def self.find(network_id)
    @calls.find { |c| c.network_id == network_id }
  end

  def self.create(params)
    new_call = new(params)
    @calls << new_call
    new_call
  end

  def self.upsert(params)
    call = find(params['CallSid']) 
    return create(params) unless call
    call.params = params
    call
  end

  def self.all
    @calls
  end

  attr_writer :params
  
  def initialize(params)
    @params = params
  end

  def network_id
    @params['CallSid']
  end
end

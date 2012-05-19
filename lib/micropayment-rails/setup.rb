module Micropayment

  def self.setup
    yield Micropayment::Config
    Micropayment::Config.complete = true
    Micropayment::Config
  end

end
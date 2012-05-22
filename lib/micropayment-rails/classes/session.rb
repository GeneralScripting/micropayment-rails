module Micropayment
  class Session < Micropayment::Base

    VALID_ATTRIBUTES  = [:sessionId, :customerId, :status, :expire, :statusDetail, :project, :projectCampaign, :account, :webmasterCampaign, :amount, :openAmount, :currency, :title, :payText, :ip, :freeParams]
    IDENTIFIER        = :sessionId
    FIND_METHOD       = :sessionGet
    CREATE_METHOD     = :sessionCreate


    def self.create!(project, customer, params={})
      params.symbolize_keys!
      params.merge!( :customerId => customer.id, :project => project )
      result = Micropayment::Debit.sessionCreate( params )
      case result["error"]
      when "0"
        self.new( valid_attributes(result) )
      else
        raise "#{result["error"]}: #{result["errorMessage"]}"
      end
    end

    def approve!
      result = Micropayment::Debit.sessionApprove( :sessionId => id )
      case result["error"]
      when "0"
        self.status = result["status"]
        self.expire = result["expire"]
        status
      else
        raise "#{result["error"]}: #{result["errorMessage"]}"
      end
    end


  end
end
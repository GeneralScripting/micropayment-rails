module Micropayment
  class Customer < Micropayment::Base

    IDENTIFIER        = :customerId


    def address=(params={})
      @address = Micropayment::Address.create!( id, params )
    end

    def address
      @address ||= (Micropayment::Address.find( id ) rescue nil)
    end

    def bank_account=(params={})
      @bank_account = Micropayment::BankAccount.create!( id, params )
    end

    def bank_account
      @bank_account ||= (Micropayment::BankAccount.find( id ) rescue nil)
    end


    
  
    def update!(params={})
      params.symbolize_keys!
      bank_account_params = params.delete(:bank_account)
      address_params      = params.delete(:address)
      update_params = {}.tap do |hsh|
        hsh[:customerId]  = id
        hsh[:freeParams]  = params
      end
      result = Micropayment::Debit.customerSet( update_params )
      if result["error"] == "0"
        self.bank_account     = bank_account_params   if bank_account_params
        self.customer.address = address_params        if address_params
        self
      else
        raise "Customer#update! - #{result["error"]}: #{result["errorMessage"]}"
      end
    end




    def self.find(customerId)
      result = Micropayment::Debit.customerGet( :customerId => customerId )
      case result["error"]
      when "0"
        self.new( :customerId => customerId, :freeParams => result["freeParams"] )
      else
        raise "Customer#find - #{result["error"]}: #{result["errorMessage"]}"
      end
    end

    def self.create!(params={})
      params.symbolize_keys!
      bank_account_params = params.delete(:bank_account)
      address_params      = params.delete(:address)
      create_params = {}.tap do |hsh|
        hsh[:customerId]  = params.delete(:customerId)  if params.has_key?(:customerId)
        hsh[:freeParams]  = params
      end
      result = Micropayment::Debit.customerCreate( create_params )
      if result["error"] == "0"
        create_params[:customerId] ||= result["customerId"]
        customer = self.new( create_params )
        customer.bank_account = bank_account_params   if bank_account_params
        customer.address      = address_params        if address_params
        customer
      else
        raise "Customer#create! - #{result["error"]}: #{result["errorMessage"]}"
      end
    end

    def self.find_or_create_by_id(id, params={})
      params.symbolize_keys!
      obj = (find(id) rescue nil)
      obj ? obj : create!( params.merge(:customerId => id) )
    end

    def self.find_create_or_update_by_id(id, params={})
      params.symbolize_keys!
      obj = (find(id) rescue nil)
      obj ? obj.update!(params) : create!( params.merge(:customerId => id) )
    end

    def self.session_list
      # TODO wrap in an array
      Micropayment::Debit.sessionList( :customerId => id )
    end

  end
end
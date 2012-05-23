module Micropayment
  class Base < OpenStruct

    def self.valid_attributes(attrs)
      attrs.reject {|k,v| !self::VALID_ATTRIBUTES.include?(k.to_sym) }
    end



    def id
      send self.class::IDENTIFIER
    end



    def self.find(id)
      result = Micropayment::Debit.send self::FIND_METHOD, self::IDENTIFIER => id
      case result["error"]
      when "0"
        self.new( valid_attributes(result) )
      else
        raise "#{result["error"]}: #{result["errorMessage"]}"
      end
    end

    def self.create!(id, params={})
      params.symbolize_keys!
      params.merge!(self::IDENTIFIER => id) if id
      result = Micropayment::Debit.send self::CREATE_METHOD, params
      if result["error"] == "0"
        self.new( valid_attributes( params.merge(result.symbolize_keys) ) )
      else
        raise "#{result["error"]}: #{result["errorMessage"]}"
      end
    end

    def self.find_or_create_by_id(id, params={})
      params.symbolize_keys!
      obj = (find(id) rescue nil)
      obj ? obj : create( id, params )
    end

  end
end
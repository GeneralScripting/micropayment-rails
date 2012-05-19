module Micropayment
  class Address < Micropayment::Base

    VALID_ATTRIBUTES  = [:customerId, :firstName, :surName, :street, :zip, :city, :country]
    IDENTIFIER        = :customerId
    FIND_METHOD       = :addressGet
    CREATE_METHOD     = :addressSet



  end
end
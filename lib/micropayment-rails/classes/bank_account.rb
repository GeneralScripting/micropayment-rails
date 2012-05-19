module Micropayment
  class BankAccount < Micropayment::Base

    VALID_ATTRIBUTES  = [:customerId, :bankName, :accountHolder, :accountNumber, :barStatus, :bankCode, :country]
    IDENTIFIER        = :customerId
    FIND_METHOD       = :bankaccountGet
    CREATE_METHOD     = :bankaccountSet

  end
end
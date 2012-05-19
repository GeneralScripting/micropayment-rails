# micropayment-rails

Use the micropayment API in your Rails project.

## Installation

In your Gemfile:
```
gem 'micropayment-rails'
```

## Usage

```
# create a blank customer
customer = Micropayment::Customer.create

# create a customer with a customer id
customer = Micropayment::Customer.create :customerId => 'my_customer_id'

# create a customer with a bank_account
customer = Micropayment::Customer.create :bank_account => { :bankCode => '10010010', :accountNumber => '1234567', :accountHolder => 'Jeff Winger' }

# access a customers bank account
customer.bank_account

# set/update a customers bank account
customer.bank_account = { :bankCode => '10010010', :accountNumber => '1234567', :accountHolder => 'Jeff Winger' }

# initiate a session
# (defaults for all hash params can be set on micropayment.de)
Micropayment::Session.create 'project_key', customer, :amount => 1000, :currency => 'EUR'

```

## Contributing to micropayment-rails
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2012 General Scripting UG (haftungsbeschränkt). See LICENSE.txt for further details.


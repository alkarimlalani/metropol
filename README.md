Metropol
==============
metropol is a client for the [Metropol Credit Reference Bureau](https://www.metropol.co.ke/) API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'metropol'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install metropol

## Usage

Create an instance of the Metropol client:
```ruby
client = Metropol::Client.new(public_key: 'YOUR_PUBLIC_KEY',
			      private_key: 'YOUR PRIVATE_KEY')
```
Or, configure the module directly
```ruby
Metropol.configure do |config|
  config.public_key = 'YOUR_PUBLIC_KEY'
  config.private_key = 'YOUR_PRIVATE_KEY'
  config.port = 'YOUR_PORT'             # Defaults to 5555
  config.api_version = 'API_VERSION'    # Defaults to 'v2_1'
end
```
### Making requests
Once you have a client (or have configured the module), you can start making requests.

There are 5 API methods you can call, and you can use the following Legal Identification Types to look up data: `national_id`, `passport`, `service_id`, `alien_registration`, `company_id`

##### verify
```ruby
# You can pass parameters to the method to specify the ID type and number:
client.verify(id_type: :national_id, id_number: 'ID_NUMBER_HERE')
# Or for convenience you can also do:
client.verify.national_id('ID_NUMBER_HERE')
# And lets say you want to look up a company's credit score
client.verify.company_id('ID_NUMBER_HERE')
```

Or, call the method directly on the module
```ruby
Metropol.verify.national_id('ID_NUMBER_HERE')
```

##### delinquency_status
```ruby
client.delinquency_status(id_type: :national_id, id_number: 'ID_NUMBER_HERE')
# Or
client.delinquency_status.national_id('ID_NUMBER_HERE')
# Or
Metropol.delinquency_status.company_id('ID_NUMBER_HERE')
```
##### credit_score
```ruby
Metropol.credit_score.national_id('ID_NUMBER_HERE')
# You know all the other variants by now
```
##### json_report
This method also takes a loan_amount parameter (defaults to 0) and a report_reason parameter which could be either: `:new_credit_app`, `:credit_review`, `:verify_credit_info` or `:customer_request` (defaults to `:new_credit_app`)
```ruby
Metropol.json_report(loan_amount: 2000).national_id('ID_NUMBER_HERE')
# Or
Metropol.json_report(loan_amount: 2000).new_credit_app.national_id('ID_NUMBER_HERE')
```
##### noncredit_data
```ruby
Metropol.noncredit_data.national_id('ID_NUMBER_HERE')
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/alkarimlalani/metropol. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Metropol project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/metropol/blob/master/CODE_OF_CONDUCT.md).

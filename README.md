# Jsql
This is plugin for JSQL - sql with only front-end layer. 

## Usage
Gem creates four end points for executing encoded sql queries.
jsql/select, jsql/update, jsql/insert, jsql/delete, and one for 
transactions : jsql/commit.

## Installation
Jsql gem works with Ruby version under 2.6.0 and Rails 5.2.2
If you don't have Rails installed yet you have to type in your console:
```bash
$ gem install rails
```
Add this line to your application's Gemfile:

```ruby
gem 'jsql'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install jsql
```

## Contributing
In your application.rb file you have to add this code:
```ruby
Jsql.configure do |config|
      config.api_key = 'your_api_key'
      config.member_key = 'your_member_key'
    end
    
```
To get your api and member key you have to register on jsql.it.
## License

 * Copyright (c) 2018 JSQL Sp.z.o.o. (Ltd, LLC) www.jsql.it
 * Licensed under the ISC license


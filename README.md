# parliament_engine

[parliament_routing_engine][parliament_routing_engine] is an engine created by the [Parliamentary Digital Service][pds] that holds all of the routes for the UK parliament prototype website, which can then be called upon by any applications that include this gem.

[![Build Status][shield-travis]][info-travis] [![Test Coverage][shield-coveralls]][info-coveralls] [![License][shield-license]][info-license]

> **NOTE:** This gem is in active development and is likely to change at short notice. It is not recommended that you use this in any production environment.



### Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Getting Started with Development](#getting-started-with-development)
  - [Running the tests](#running-the-tests)
- [Contributing](#contributing)
- [License](#license)

## Requirements
[parliament_routing_engine][parliament_routing_engine] requires the following:
* [Ruby][ruby] - [click here][ruby-version] for the exact version
* [Bundler][bundler]
* [Rails][rails]

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'parliament_routing_engine'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install parliament_routing_engine
```

## Usage
The engine works in the background adding routes to the application that uses it.

In order to run the engine, mount the engine within your application's routes.rb:
```ruby
Rails.application.routes.draw do
  mount Parliament::Engine::Engine => "/parliament_engine"
end
```

## Getting Started with Development
To clone the repository and set up the dependencies, run the following:
```bash
git clone https://github.com/bryonywatson1/parliament_engine.git
cd parliament_engine
bundle install
```

### Running the tests
We use [RSpec][rspec] as our testing framework and tests can be run using:
```bash
bundle exec rspec
```

## Contributing
If you wish to submit a bug fix or feature, you can create a pull request and it will be merged pending a code review.

1. Fork the repository
1. Create your feature branch (`git checkout -b my-new-feature`)
1. Commit your changes (`git commit -am 'Add some feature'`)
1. Push to the branch (`git push origin my-new-feature`)
1. Ensure your changes are tested using [Rspec][rspec]
1. Create a new Pull Request

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

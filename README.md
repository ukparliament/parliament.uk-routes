# Parliament.uk-routes

[Parliament.uk-routes][parliament.uk-routes] is an engine created by the [Parliamentary Digital Service][parliamentary-digital-service] that holds all of the routes for the UK parliament prototype website, which can then be called upon by any applications that include this gem.

[![License][shield-license]][info-license]

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
[Parliament.uk-routes][parliament.uk-routes] requires the following:
* [Ruby][ruby]
* [Bundler][bundler]
* [Rails][rails]

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'parliament-routes'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install parliament-routes
```

## Usage
The engine works in the background adding routes to the application that uses it.

## Getting Started with Development
To clone the repository and set up the dependencies, run the following:
```bash
git clone https://github.com/ukparliament/parliament.uk-routes.git
cd parliament-routes
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
The gem is available as open source under the terms of the [Open Parliament Licence][info-license].

[parliament.uk-routes]:          https://github.com/ukparliament/parliament.uk-routes
[parliamentary-digital-service]: https://github.com/ukparliament
[ruby]:                          https://www.ruby-lang.org/en/
[bundler]:                       http://bundler.io/
[rspec]:                         http://rspec.info
[rails]:                         http://rubyonrails.org

[info-license]:   http://www.parliament.uk/site-information/copyright/open-parliament-licence/
[shield-license]: https://img.shields.io/badge/license-Open%20Parliament%20Licence-blue.svg

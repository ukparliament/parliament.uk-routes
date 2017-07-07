# ParliamentRoutingEngine
This engine stores the routing for the main Parliament Prototype app, and these routes can then be called upon in any application that includes this gem.

## Usage
The engine works in the background adding routes to the application that uses it.

In order to run the engine, mount the engine within your application's routes.rb:
```ruby
Rails.application.routes.draw do
  mount ParliamentRoutingEngine::Engine => "/parliament_routing_engine"
end
```

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

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

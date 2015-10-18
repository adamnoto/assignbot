# Assignbot

In Ruby, assigning variables can be tricky. Could you assign from new? Could you always guarantee that? 

Assignbot guarantee you can assign from `.assign`, code changes to your codebase is not required
unless you want custom behaviour.

# Use cases

1. Assign from the hash, from params
2. Assign from the hash, from JSON

## Installation

To install Assignbot, add this line to your Gemfile:

```ruby
gem 'assignbot'
```

And then execute:

    $ bundle

Or install it system-wide by issuing:

    $ gem install assignbot

## Usage

Assume you have the following User class:

```ruby
class User
  attr_accessor :name, :age, :id
end
```

Basic usage of assigner does not require significant code change to your model/ruby class, other than a one-liner include statement:

```ruby
class User
  include Assignbot

  # your other ruby code
end
```

By doing so, you already make User to be assignable from a Hash:

```ruby
user_params = {
  name: "Adam Pahlevi",
  age: 23,
  id: "934-2311"
}

user = User.new
user.assign(user_params)
user.name == "Adam Pahlevi" # returns true
```

If you would like to explicitly tell Assignbot what are the assignable variables, then you have to define the variables explicitly:

```ruby
class User
  include Assignbot

  assigner do
    name from: :name
    age from: :age
    id from: :id
  end
  # your other ruby code
end
```

Explicitly defining assigner also allow you to map the value from source variable, which have different nomenclature, to the target variable in your Ruby class.

## License

The gem is proudly available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


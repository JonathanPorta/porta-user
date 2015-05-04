# porta_user Cookbook
TODO: Why in the hell does the cookbook exist?

## Requirements
TODO: What does the cookbook require to run?

## Attributes
* `['porta_user']['attribute_name']` - TODO: What attributes does
the cookbook define?

## Recipes
### default
TODO: What does the default recipe do?

## LWRPs
### resource_name
TODO: What are the resources provided by the cookbook?

```
porta_user "portaj" do
  action :create
  github_username "jonathanporta"
  sudo true
end
```

## Usage
TODO: How can the cookbook be used?

## Development and Contributing
0. You'll need [bundler](http://github.com/carlhuda/bundler) and [chef-dk](https://github.com/chef/chef-dk).
1. Clone this repository from GitHub:

        $ git clone git@github.com:_username_/_repo_.git

2. Create a git branch

        $ git checkout -b feature/my_shiny_new_thang

3. Install dependencies:

        $ bundle install

4. Make your changes/patches/fixes, committing appropiately
5. **Write tests**
6. Run the tests:
    - `chef exec rake` - Runs foodcritic, rspec, rubocop, and kitchen test
   Run tests individually:
    - `chef exec foodcritic -f any .`
    - `chef exec rspec`
    - `chef exec rubocop`
    - `chef exec kitchen test`

  In detail:
    - Foodcritic will catch any Chef-specific style errors
    - RSpec will run the unit tests
    - Rubocop will check for Ruby-specific style errors
    - Test Kitchen will run and converge the recipes
### Guard
You can have [Guard](https://github.com/guard/guard) watch files and
automatically run tests as you make changes:
        $ bundle exec guard

## License and Authors
Author: Jonathan Porta

Copyright (C) 2015 Jonathan Porta

Please see `LICENSE` for a copy of the license.

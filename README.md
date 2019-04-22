# W8D1 - Lecture

- Automated Testing with RSpec and Rails

## TTD

- Create the test first
- Write the code to make the test pass

## RSpec

RSpec is a popular test framework in Ruby. MiniTest is the second most popular framework and is included in the Ruby standard library (i.e. comes with ruby. no need to install a gem.)

The reason RSpec is so popular is that the data validators are quite expressive.

- RSpec does BDD (behavior driven development)

  - describe/context
  - it
  - expect

## What to test

Writing good unit tests is an art. You want to make sure that your tests cover most of your public methods - especially the ones that have tricky logic.

Tips for testing:

- Test the happy path
- Test edge cases. pick values that are right at the boundary.
- Test are supposed to be easy to read. be careful how you DRY up your code. you need to strike a good balance between readability and DRY.
- Don't use random data in your setup stage. tests need to be reproducible, meaning if you run the test twice without changing your application code, you should get the same result.
- Test are supposed to be easy to maintain, meaning easy to update when your requirements change.
- don't over test. when unit testing you want to test that a specific method works. no need to check that another method used by your method under test works.

## Testing Rails applications using RSpec

First, wel'll generate a new rails app:

`rails new music_library -T`

## Configuring RSpec

Add `rspec-rails` gem to `:test` and `:development` groups on your `Gemfile`:

```ruby
group :development, :test do
  # ...more stuff here
  gem 'rspec-rails', '~> 3.8'
end
```

- run bundle install

We'll execute the basic setup for rspec:

`rails g rspec:install`

ps: you might need to fix sqlite3...

This is going to install 3 config files:

- .rspec
- spec/spec_helper.rb
- spec/rails_helper.rb

## Create a new model

- Create the Album model:

`rails g model Album title:string year:integer`

- run the migration

`rake db:migrate`

Try running the test:

`rspec .`

## Create Test Cases

Create test case using 'it' and RSpec Expectations

```ruby
  it 'is not valid without a title' do
    album = Album.new
    expect(album).to_not be_valid
  end
```

- using subject allows us to remain DRY

`subject(:album) {Album.new}`

[BetterSpecs](http://www.betterspecs.org/)

## Generating data

- fixtures
- factories

- Let's create new model for users:

`rails g model User name:string email:string password_digest:string`

- run the migration

### Fixtures

- create a `fixtures` folder under the `spec` folder
- create albums.yml and users.yml

```yml
:divide
  title: 'Divide'
```

```yml
:bob
  name: "Bob Squarepants"
  email: 'bob@sq.com'
```

- add the email_validator gem and run bundle install
- add validations to the users model

```ruby
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, email: true
```

- to use fixtures add them to the describe of the test file
- fixtures can be tedious if we need more than simple data
- it is recommended to use factories

** factory girl has been replaced with factory_bot_rails **

Add it to the Gemfile:

```ruby
group :development, :test do
  #other gems
  gem 'factory_bot_rails'
end
```

Configure `factory_bot_rails`. Make sure the top of your `/spec/rails_helper.rb` file includes the following lines:

```ruby
require 'factory_bot_rails'

RSpec.configure do |config|
  # other stuff
  config.include FactoryBot::Syntax::Methods
end
```

- Create a `factories` folder under the `spec` folder
- Create users.rb with the following:

```ruby
FactoryBot.define do
  factory :user do
    name 'Bob Squarepants'
    sequence(:email, 10) { |n| "bob#{n}@sq.com"}
  end
end
```

in users_spec, add to the describe block:

```
subject {build(:user)}
```

User create instead of build to save to database

## Shoulda Matchers

Simple one-liner tests for common Rails functionality

[shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers)

## FactoryBot

[FactoryBot](http://www.rubydoc.info/gems/factory_bot/file/GETTING_STARTED.md) is a gem that allows you to create customizable test assets with different traits. Be sure to check out [`/code/spec/factories`](code/spec/factories) to see how to define them and [`bicycle_spec.rb`](code/spec/models/bicycle_spec.rb) to see it in use.

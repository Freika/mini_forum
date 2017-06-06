# Setup

Requirements: Redis, Ruby 2.4+

1. `bundle install`
2. `rails db:create db:migrate`
3. `rails server`
4. Visit `http://localhost:3000`
5. Register via email/password or Facebook
6. Create some messages
7. If you've registered via Facebook, list of your FB friends should be on the left.
8. ???
9. PROFIT!!!

## Tests

```
RAILS_ENV=test rails db:migrate
bundle exec rspec
```

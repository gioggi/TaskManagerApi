# Testing with RSpec, FactoryBot, and Faker

This document provides an overview of the testing setup in this project using RSpec, FactoryBot, and Faker.

## Setup

The following gems have been added to the project:

- `rspec-rails`: The RSpec testing framework for Rails
- `factory_bot_rails`: A fixtures replacement for creating test data
- `faker`: A library for generating fake data for tests

## Directory Structure

- `spec/`: The main directory for all RSpec tests
  - `models/`: Tests for models
  - `controllers/`: Tests for controllers
  - `factories/`: Factory definitions for test data
  - `support/`: Support files for testing
    - `factory_bot.rb`: Configuration for FactoryBot
    - `faker.rb`: Configuration for Faker

## Tipi di test

- **Model spec**: testano la logica dei modelli (in `spec/models`).
- **Request spec**: testano le richieste HTTP alle API (in `spec/requests`).
- **Integration spec**: usati anche per la documentazione Swagger/OpenAPI (in `spec/integration`).

## Writing Tests

### Model Tests

```ruby
require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validations' do
    it 'is valid with a title, description, and completed status' do
      task = build(:task)
      expect(task).to be_valid
    end
  end
end
```

### Using Factories

```ruby
# In spec/factories/tasks.rb
FactoryBot.define do
  factory :task do
    title { Faker::Lorem.sentence(word_count: 3) }
    description { Faker::Lorem.paragraph(sentence_count: 2) }
    completed { [true, false].sample }
  end
end

# In your tests
task = build(:task)  # Build but don't save
task = create(:task) # Build and save
```

### Using Faker

Faker is used within factories to generate realistic test data:

```ruby
title { Faker::Lorem.sentence(word_count: 3) }
description { Faker::Lorem.paragraph(sentence_count: 2) }
email { Faker::Internet.email }
name { Faker::Name.name }
```

## Running Tests

Run all tests:

```bash
bundle exec rspec
```

Run specific tests:

```bash
bundle exec rspec spec/models/task_spec.rb
```

## Best Practices

1. Use factories instead of fixtures for test data
2. Use Faker to generate realistic test data
3. Keep tests focused and isolated
4. Use descriptive test names
5. Group related tests with `describe` and `context` blocks
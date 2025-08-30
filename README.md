
# Lab 7: Testing a Rails Mini-App (Users & Posts)

## Learning Goals

- Practice writing RSpec model, request, and feature specs in a real Rails app.
- Learn to use FactoryBot for test data and Capybara for simulating user actions.
- Understand how to structure specs for clarity and maintainability.
- Gain experience with best practices for Rails testing.

Welcome to your Rails testing lab! In this lab, you'll practice writing RSpec specs for a real Rails app with Users and Posts. You'll write model specs, request specs, and at least one feature spec. This lab is designed to help you apply everything you've learned so far about RSpec in a Rails context.

**Make sure you have Ruby 3.3.5 and Rails 7.1.5.2 installed.**

Before starting:

- Run `bundle install` to install dependencies.
- Run `bin/rails db:migrate` to set up the database.
- Run `bin/rails db:seed` to load sample data (recommended for testing and feature specs).

## Instructions

### Step 1: Model Specs

- In `spec/student/user_spec.rb`, write specs for the User model:
  - Test validations (e.g., presence, uniqueness) and associations (e.g., has_many :posts).
  - Use `describe` and `it` blocks to organize your tests.
- In `spec/student/post_spec.rb`, write specs for the Post model:
  - Test validations and associations (e.g., belongs_to :user).
  - Use FactoryBot to create test data.
  - The User factory is provided in `spec/factories/users.rb`.
  - **You must implement the Post factory yourself in `spec/factories/posts.rb`.**
    - Your Post factory should include all required attributes to pass model validations:
      - `title` (string, required)
      - `body` (text, required)
      - `user` (association, required)

### Step 2: Request Specs

- In `spec/student/users_request_spec.rb`, write request specs for the Users resource.
- In `spec/student/posts_request_spec.rb`, write request specs for the Posts resource.
  - For both, cover all RESTful actions: `index`, `show`, `new`, `edit`, `create`, `update`, `destroy`.
  - Use FactoryBot to set up data as needed.
  - Organize your specs with `describe` and `it` blocks.

### Step 3: Feature Spec

- In a file ending with `_feature_spec.rb` (e.g., `app_feature_spec.rb`), write at least one feature spec using Capybara.
  - Capybara is already set up for you in the Gemfile.
  - Simulate user actions and check for expected page content or navigation.
  - Example (not a solution):

    ```ruby
    # spec/student/app_feature_spec.rb
    describe 'User visits the posts index page' do
      it 'shows the list of posts' do
        visit posts_path
        expect(page).to have_content('All Posts')
      end
    end
    ```

  - Use Capybara methods like `visit`, `have_content`, `click_link`, `fill_in`, `within`, `select`, or `click_button` to interact with the app.

### Step 4: Run and Iterate

- Run your specs with `bin/rspec` to see your progress.
  - You should see `[LAB CHECKER]` specs in the output. These only check your test files (not your app code) to ensure your specs are present and structured correctly.
  - As you write your specs, the lab checker specs will start to pass.
  - For fast feedback, you can run a single spec file: `bin/rspec spec/student/user_spec.rb`
  - **Tip:** If you are overwhelmed by the number of failures, use the `--f-f` (fail-fast) option: `bin/rspec --f-f`. This will stop running after the first failure, making it easier to focus on fixing one issue at a time.

### Step 5: Reference and Restrictions

- Reference the lesson repos for examples of model, request, and feature specs.
  - FactoryBot is already set up for you in `spec/factories/`.
- **Do not write or change any implementation code in the app/models or app/controllers directories.**
  - Your job is to write tests only.

## Lab Checker Requirements Checklist

The `[LAB CHECKER]` specs will check for the following. Use this as a checklist before submitting:

### Model Specs

- [ ] Each model spec file (`user_spec.rb`, `post_spec.rb`) must:
  - [ ] Use `describe` or `RSpec.describe` with `type: :model` (can be on any line or as metadata).
  - [ ] Have at least 2 `it` blocks.
  - [ ] Test at least one validation (e.g., presence, uniqueness) and one association (e.g., has_many, belongs_to) with a real assertion (using `expect(...)` or shoulda-matchers like `should validate_presence_of`).
  - [ ] (Recommended) Use FactoryBot for test data inside `it` blocks.
  - [ ] (Recommended) Use `subject`, `let`, or `before` for setup.
  - [ ] Avoid testing implementation details (e.g., `instance_variable_get`, `send`).

### Request Specs

- [ ] Each request spec file (`users_request_spec.rb`, `posts_request_spec.rb`) must:
  - [ ] Have at least 2 `it` blocks.
  - [ ] Reference all RESTful actions: `index`, `show`, `new`, `edit`, `create`, `update`, `destroy`.
  - [ ] Include at least one assertion for response or flash (e.g., `expect(response)`, `expect(flash)`, `expect(redirect_to)`).

### Feature Specs

- [ ] At least one file ending with `_feature_spec.rb` must exist.
- [ ] Collectively, your feature specs must:
  - [ ] Test both User and Post functionality (can be in separate files).
  - [ ] Use at least 2 different Capybara methods (e.g., `visit`, `fill_in`, `click_link`, `find`, etc.).
  - [ ] Use FactoryBot for test data in at least one spec.
  - [ ] Include meaningful assertions (e.g., `expect(page)`, `have_content`, `have_selector`, `have_current_path`, etc.).
- [ ] Each feature spec file should:
  - [ ] Use `describe` and have at least 2 `it` blocks.
  - [ ] (Recommended) Use `let` or `before` for setup.
  - [ ] Avoid testing implementation details.
  - [ ] Use at least one Capybara method and at least one assertion.

If you see a `[LAB CHECKER]` failure, check this list to see what you might be missing!

## Tips and Best Practices

- Use `describe` or `RSpec.describe` with `type: :model` for model specs.
- Write at least 2 `it` blocks per spec file.
- Use FactoryBot for test data (recommended for all specs).
- Use `let` or `before` for setup (recommended).
- Make meaningful assertions with `expect(...)`, `should`, or Capybara matchers.
- Avoid testing implementation details (e.g., `instance_variable_get`, `send`).

## Submission / Next Steps

1. Make sure all `[LAB CHECKER]` specs pass by running `bin/rspec`.
2. Review the checklist above to confirm you’ve met all requirements.
3. Commit your changes and submit your work according to your instructor’s instructions.

## Resources

- [RSpec Documentation](https://rspec.info/documentation/)
- [FactoryBot Documentation](https://github.com/thoughtbot/factory_bot)
- [Capybara Documentation](https://teamcapybara.github.io/capybara/)

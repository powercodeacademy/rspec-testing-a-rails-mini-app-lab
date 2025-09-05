# frozen_string_literal: true

describe '[LAB CHECKER] Model Spec Requirements' do
  student_spec_dir = File.expand_path('../student', __dir__)
  specs = { 'user_spec.rb' => 'User', 'post_spec.rb' => 'Post' }

  specs.each do |file, model|
    path = File.join(student_spec_dir, file)

    it "has #{file} in spec/student/" do
      expect(File).to exist(path), "Expected #{file} to exist in spec/student/. Did you create it?"
    end

    next unless File.exist?(path)

    content = File.read(path)
    # Extract the full it block text for processing - use non-capturing group for the do/end or {} part
    it_blocks = content.scan(/it\s+['"][^'"]*['"]\s*(?:do[\s\S]*?end|\{[\s\S]*?\})/)
    describe_block = content.match(/(RSpec\.)?describe\s+#{model}/)

    it "#{file} uses describe (or RSpec.describe), type: :model, and at least 2 it blocks for #{model}" do
      expect(describe_block).to be_truthy, "Expected a describe or RSpec.describe block for #{model} in #{file}."
      expect(content).to match(/type:\s*:model/), "Expected describe #{model} with type: :model in #{file}."
      expect(it_blocks.size).to be >= 2, "Expected at least 2 it blocks for #{model} in #{file}."
    end

    it "#{file} has meaningful assertions for validations and associations for #{model}" do
      # Check for validation tests either in it blocks or as shoulda matchers
      validation_in_it = it_blocks.any? do |blk|
        (blk.match?(/validate|validates|presence|uniqueness/i) && blk.match?(/expect\s*\(/)) ||
          blk.match?(/should\s+validate_\w+/i) ||
          blk.match?(/expect\([^)]+\)\.to\s+validate_\w+/i)
      end
      validation_shoulda = content.match?(/should\s+validate_\w+/i)

      # Check for association tests either in it blocks or as shoulda matchers
      association_in_it = it_blocks.any? do |blk|
        (blk.match?(/has_many|belongs_to|association/i) && blk.match?(/expect\s*\(/)) ||
          blk.match?(/should\s+(have_many|belong_to)/i) ||
          blk.match?(/expect\([^)]+\)\.to\s+(have_many|belong_to)/i)
      end
      association_shoulda = content.match?(/should\s+(have_many|belong_to)/i)

      expect(validation_in_it || validation_shoulda).to be(true),
                                                        "Expected at least one validation test (either in it block with assertion or shoulda matcher) for #{model}."
      expect(association_in_it || association_shoulda).to be(true),
                                                          "Expected at least one association test (either in it block with assertion or shoulda matcher) for #{model}."
    end

    it "#{file} uses FactoryBot for test data for #{model}" do
      factorybot_used = content.match?(/FactoryBot\.(build|create)(_list|_stubbed)?\s*\(:\w+/)
      expect(factorybot_used).to be(true), "Tip: Use FactoryBot.create or FactoryBot.build for #{model} test data."
    end

    it "#{file} uses subject, let, or before for setup and avoids implementation details for #{model}" do
      subject_used = content.match?(/subject(\s*\(|\s*\{)/)
      setup_used = content.match?(/(let\s*\(|let\s*:|before\s*\{)/)
      any_setup_used = subject_used || setup_used
      expect(any_setup_used).to be(true), "Tip: Use subject, let, or before blocks for setup in #{model} specs."
      expect(content).not_to match(/instance_variable_get|send\s*\(/),
                             "Avoid testing implementation details directly in #{model} specs."
    end
  end
end

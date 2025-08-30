# frozen_string_literal: true

describe '[LAB CHECKER] Model Spec Requirements' do
  student_spec_dir = File.expand_path('../../student', __FILE__)
  specs = { 'user_spec.rb' => 'User', 'post_spec.rb' => 'Post' }

  specs.each do |file, model|
    path = File.join(student_spec_dir, file)

    it "has #{file} in spec/student/" do
      expect(File).to exist(path), "Expected #{file} to exist in spec/student/. Did you create it?"
    end

    next unless File.exist?(path)
    content = File.read(path)
    it_blocks = content.scan(/it\s+['"][^'"]*['"]\s*(do[\s\S]*?end|\{[\s\S]*?\})/)
    describe_block = content.match(/(RSpec\.)?describe\s+#{model}/)

    it "#{file} uses describe (or RSpec.describe), type: :model, and at least 2 it blocks for #{model}" do
      expect(describe_block).to be_truthy, "Expected a describe or RSpec.describe block for #{model} in #{file}."
      expect(content).to match(/type:\s*:model/), "Expected describe #{model} with type: :model in #{file}."
      expect(it_blocks.size).to be >= 2, "Expected at least 2 it blocks for #{model} in #{file}."
    end

    it "#{file} has meaningful assertions for validations and associations for #{model}" do
      validation_in_it = it_blocks.any? do |blk|
        (blk.match?(/validate|validates|presence|uniqueness/i) && blk.match?(/expect\s*\(/)) ||
          blk.match?(/should\s+validate_\w+/i)
      end
      association_in_it = it_blocks.any? do |blk|
        (blk.match?(/has_many|belongs_to|association/i) && blk.match?(/expect\s*\(/)) ||
          blk.match?(/should\s+(have_many|belong_to)/i)
      end
      expect(validation_in_it).to be(true), "Expected at least one it block to test a validation with an assertion for #{model}."
      expect(association_in_it).to be(true), "Expected at least one it block to test an association with an assertion for #{model}."
    end

    it "#{file} uses FactoryBot for test data inside it blocks for #{model}" do
      factorybot_in_it = it_blocks.any? { |blk| blk.match?(/(build|create)(_list|_stubbed)?\s*\(:\w+/) }
      expect(factorybot_in_it).to be(true), "Tip: Use FactoryBot inside your it blocks for #{model} test data."
    end

    it "#{file} uses subject, let, or before for setup and avoids implementation details for #{model}" do
      expect(content.match?(/subject(\s*\(|\s*\{)/)).to be(true), "Tip: Use subject for #{model} specs."
      setup_used = content.match?(/(let\s*\(|let\s*:|before\s*\{)/)
      expect(setup_used).to be(true), "Tip: Use let or before blocks for setup in #{model} specs."
      expect(content).not_to match(/instance_variable_get|send\s*\(/), "Avoid testing implementation details directly in #{model} specs."
    end
  end
end

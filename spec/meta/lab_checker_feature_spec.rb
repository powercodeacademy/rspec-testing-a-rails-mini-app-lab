# frozen_string_literal: true

describe '[LAB CHECKER] Feature Spec Requirements' do
  student_spec_dir = File.expand_path('../student', __dir__)
  feature_files = Dir[File.join(student_spec_dir, '*_feature_spec.rb')]
  capybara_methods = %w[visit fill_in click_link click_button within have_content have_selector check select choose
                        attach_file]
  models = %w[User Post]

  it 'has at least one feature spec file ending with _feature_spec.rb' do
    expect(feature_files.size).to be >= 1, 'Expected at least one feature spec file in spec/student/.'
  end

  all_content = feature_files.map { |f| File.read(f) }.join("\n")

  it 'collectively covers User and Post functionality across feature specs' do
    models.each do |model|
      expect(all_content.match?(/#{model}/i)).to be(true),
                                                 "Expected at least one feature spec to test #{model} functionality."
    end
  end

  it 'uses at least 2 distinct Capybara methods across feature specs' do
    used_methods = capybara_methods.select { |m| all_content.include?(m) }
    expect(used_methods.size).to be >= 2, 'Expected feature specs to use at least 2 different Capybara methods.'
  end

  it 'uses FactoryBot for test data in at least one feature spec' do
    expect(all_content.match?(/FactoryBot\.(build|create)(_list|_stubbed)?\s*\(:\w+/)).to be(true),
                                                                                          'Tip: Use FactoryBot.create or FactoryBot.build for creating test data in feature specs.'
  end

  it 'includes meaningful assertions using expect(page) or have_content/selector/current_path' do
    expect(all_content.match?(/expect\(page\)|have_content|have_selector|have_current_path/)).to be(true),
                                                                                                 'Expected feature specs to check page content or state.'
  end

  feature_files.each do |file|
    content = File.read(file)
    it_blocks = content.scan(/it\s+['"][^'"]*['"]\s*(?:do[\s\S]*?end|\{[\s\S]*?\})/)

    it "#{File.basename(file)} uses describe, at least 2 it blocks, setup best practices, and avoids implementation details" do
      expect(content.match?(/describe/)).to be(true)
      expect(it_blocks.size).to be >= 2
      setup_used = content.match?(/(let\s*\(|before\s*\{)/)
      expect(setup_used).to be(true), 'Tip: Use let or before blocks for setup in feature specs.'
      expect(content).not_to match(/instance_variable_get|send\s*\(/)
      capybara_found = capybara_methods.any? { |m| content.include?(m) }
      expect(capybara_found).to be(true)
      assertion_found = content.match?(/expect\(page\)|have_content|have_selector|have_current_path/)
      expect(assertion_found).to be(true)
    end
  end
end

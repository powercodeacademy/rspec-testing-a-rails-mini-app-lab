# frozen_string_literal: true

describe '[LAB CHECKER] Request Spec Requirements' do
  student_spec_dir = File.expand_path('../student', __dir__)
  specs = { 'users_request_spec.rb' => 'Users', 'posts_request_spec.rb' => 'Posts' }
  actions = %w[index show new edit create update destroy]

  specs.each do |file, resource|
    path = File.join(student_spec_dir, file)

    it "has #{file} in spec/student/" do
      expect(File).to exist(path), "Expected #{file} to exist in spec/student/. Did you create it?"
    end

    next unless File.exist?(path)

    content = File.read(path)
    it_blocks = content.scan(/it\s+['"][^'"]*['"]\s*(?:do[\s\S]*?end|\{[\s\S]*?\})/)
    describe_block = content.match(/describe\s+['"].*#{resource}/i)

    it "#{file} uses describe and at least 2 it blocks for #{resource}Controller" do
      expect(describe_block).to be_truthy, "Expected describe block for #{resource} in #{file}."
      expect(it_blocks.size).to be >= 2, "Expected at least 2 it blocks for #{resource}Controller in #{file}."
    end

    it "#{file} mentions all RESTful actions for #{resource}Controller" do
      actions.each do |action|
        expect(content.match?(/#{action}/i)).to be(true), "Expected #{file} to reference the '#{action}' action."
      end
    end

    it "#{file} includes meaningful assertions for responses and redirects" do
      has_assertions = it_blocks.any? { |blk| blk.match?(/expect\(response\)|expect\(flash\)|expect\(redirect_to\)/) }
      expect(has_assertions).to be(true), "Expected at least one assertion for response or flash in #{file}."
    end
  end
end

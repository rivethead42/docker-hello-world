require 'spec_helper'

puts "Run rake spec"

describe group('nodejs') do
  it { should exist }
end

describe user('nodejs') do
  it { should exist }
  it { should belong_to_group 'nodejs' }
  it { should_not have_login_shell '/bin/bash' }
  it { should have_login_shell '/bin/false' }
end

describe file('/var/node/helloworld') do
  it { should be_directory }
  it { should be_owned_by 'nodejs' }
  it { should be_grouped_into 'nodejs' }
end

describe file('/var/node/helloworld/bin/www') do
  it { should exist }
  it { should be_file }
  it { should be_owned_by 'nodejs' }
  it { should be_grouped_into 'nodejs' }
end

require 'json'

namespace :hiera do
  desc "build common.json"
  task :build do |task|
    hiera_common = {
      "classes" => ["profiles::docker::nodejs"],
      "profiles::docker::nodejs::git_repo" => "https://github.com/tthomsen/ci-demo.git",
      "profiles::docker::nodejs::git_revision" => ENV["GIT_REVISION"],
      "profiles::docker::nodejs::environment" => ENV["NODE_ENV"],
      "profiles::docker::nodejs::service_name" => "helloworld",
      "profiles::docker::nodejs::deploy_dir" => "/var/node/helloworld",
      "profiles::docker::nodejs::service_run_command" => "/var/node/helloworld/bin/www",
      "profiles::docker::nodejs::node_version" => "6.x"
    }

    puts JSON.pretty_generate(hiera_common)

    puts "write out common.json"
    File.open('puppet/hiera/common.json', 'w') { |file| file.write(JSON.pretty_generate(hiera_common)) }
  end
end

#! /usr/bin/env ruby
require 'optparse'
require_relative '../lib/caz/monitor'
require_relative '../lib/caz/orchestrator'
require_relative '../lib/caz/notifier'

options = {
  check_interval: 15,
  region: 'us-east-1',
  ignore_username: nil
}

OptionParser.new do |opti|
  opti.banner = 'caz_monitor.rb [options]'

  opti.on('-t', '--refresh_interval SECONDS', Integer, 'number of seconds to wait between refresh loops (default 15)') do |check_interval|
    options[:check_interval] = check_interval
  end

  opti.on('-u', '--ignore-username NAME', 'a username to ignore alerts for (probably your own)') do |ignore_username|
    options[:ignore_username] = ignore_username
  end

  opti.on('-r', '--region REGION', 'your preferred aws region (default: us-east-1)') do |region|
    options[:region] = region
  end

  opti.on('-h', '--help', 'Prints this help') do
    puts opti
    exit
  end
end.parse!

orchestrator = Caz::Orchestrator.new(**options)
orchestrator.run

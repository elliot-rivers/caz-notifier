#! /usr/bin/env ruby
require_relative '../lib/caz/monitor'
require_relative '../lib/caz/orchestrator'
require_relative '../lib/caz/notifier'

require 'io/console'
$stdout.sync = true


orchestrator = Caz::Orchestrator.new
orchestrator.run

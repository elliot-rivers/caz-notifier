#! /usr/bin/env ruby
require_relative '../lib/caz/monitor'
require_relative '../lib/caz/orchestrator'
require_relative '../lib/caz/notifier'

orchestrator = Caz::Orchestrator.new
orchestrator.run

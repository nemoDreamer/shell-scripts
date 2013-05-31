#!/usr/bin/env ruby -w

require './lib/classes/class.String.rb'
require './lib/classes/class.Monitor.rb'

monitor = Monitor.new( 'https://www.cpg.org/account/sign-in/' )

monitor.should_contain( "CCIS Username", /<input[^>]+(name|id)="ccis_username"[^>]?>/im )
monitor.should_not_contain( "A CF error", "[pattern for CF error here]" )
monitor.should_not_contain( "A BODY tag", "<body" ) # would fail, of course.

puts monitor

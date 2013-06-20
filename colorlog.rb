#!/usr/bin/env ruby -w

require 'trollop'

Trollop::options do
	version 'ColorLog v1.1 (Philip Blyth)'
	banner <<-BANNER
Installation:
-------------
* On dev instance, save to:

    ~/vm_home_devuser/scripts/

* Make sure is executable:

    chmod +x ~/vm_home_devuser/scripts/colorlog.rb

* Symlink to `bin`:

    ln -s ~/vm_home_devuser/scripts/colorlog.rb /usr/local/bin/colorlog


Usage:
------
* Pipe any output into it:

    svn log -l 10 | colorlog

* Optionally, create handy alias to pipe svn log w/ limit:
  Add the following to your `~/.profile` or `~/.bash_profile`:

	function fn_log() { svn log -l $1 | colorlog; }
	alias log=fn_log


Dependencies:
-------------
Requires `class.String.rb` in `lib/classes/`


Options:
--------
BANNER
end

# load dependencies:
require_relative 'lib/classes/class.String.rb'

# colorize lines:
$stdin.each do |line|
	print(if line.match(/^r\d+/)
			# r14382 | pblyth | 2013-03-20 13:38:26 -0400 (Wed, 20 Mar 2013) | 1 line
			line.color('blue')
		elsif line.match(/^\-\-\-/)
			# ------------------------------------------------------------------------
			"\n"
		elsif line.match(/^$/)
			''
		else
			# WCPG-1278: removed form/cfm's dependency on forcedLeftNav's variables.requestingPathIDs
			line.color('white')
		end)
end

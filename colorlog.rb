#!/usr/bin/env ruby -w

##
# ColorLog
# =========
# @author Philip Blyth
#
#
# Installation:
# -------------
# * On dev instance, save to:
#     ~/vm_home_devuser/scripts/
#
# * Make sure is executable:
#     chmod +x ~/vm_home_devuser/scripts/colorlog.rb
#
# * Symlink to 'bin':
#     ln ~/vm_home_devuser/scripts/colorlog.rb /usr/local/bin/colorlog
#
#
# Usage:
# ------
# * Pipe any output into it:
#     svn log -l 10 | colorlog
#
# * Optionally, create handy alias to pipe svn diff w/ 'ignore whitespace all':
#     Add the following to your ~/.profile or ~/.bash_profile:
#       alias log="svn log -l | colorlog"
#
#
# Dependencies:
# -------------
# Requires 'classes/class.String.rb' in same folder
#


# load dependencies:
Dir.chdir( ENV['HOME'] + '/vm_home_devuser/scripts/' ) do |dir|
	require './classes/class.String.rb'
end

# colorize lines:
$stdin.each do |line|
	print (if line.match(/^r\d+/)
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

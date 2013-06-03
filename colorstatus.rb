#!/usr/bin/env ruby -w

##
# ColorStatus
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
#     chmod +x ~/vm_home_devuser/scripts/colorstatus.rb
#
# * Symlink to 'bin':
#     ln -s ~/vm_home_devuser/scripts/colorstatus.rb /usr/local/bin/colorstatus
#
#
# Usage:
# ------
# * Pipe any output into it:
#     svn status | colorstatus
#     cat my_saved_status_output | colorstatus
#
# * Optionally, create handy alias to pipe svn status w/ color:
#     Add the following to your ~/.profile or ~/.bash_profile:
#       alias stx="svn status | colorstatus"
#
#
# Dependencies:
# -------------
# Requires 'class.String.rb' in same folder
#


# load dependencies:
Dir.chdir( ENV['HOME'] + '/vm_home_devuser/scripts/' ) do |dir|
	require './lib/classes/class.String.rb'
end

# colorize lines:
$stdin.each do |line|
	print(if line.match(/^A/)
			# A       master.css
			# R       master.css
			line.color('green')
		elsif line.match(/^\s*[CD!]/)
			# C       master.css
			# D       master.css
			# !       master.css
			line.color('red')
		elsif line.match(/^\s*M/)
			# M       master.css
			line.color('blue')
		elsif line.match(/^\?/)
			# ?       master.css
			line.color('yellow')
		else
			line
		end)
end

# svn help status
# ---------------
#
# The first seven columns in the output are each one character wide:
#   First column: Says if item was added, deleted, or otherwise changed
#     ' ' no modifications
#     'A' Added
#     'C' Conflicted
#     'D' Deleted
#     'I' Ignored
#     'M' Modified
#     'R' Replaced
#     'X' an unversioned directory created by an externals definition
#     '?' item is not under version control
#     '!' item is missing (removed by non-svn command) or incomplete
#     '~' versioned item obstructed by some item of a different kind
#   Second column: Modifications of a file's or directory's properties
#     ' ' no modifications
#     'C' Conflicted
#     'M' Modified
#   Third column: Whether the working copy directory is locked
#     ' ' not locked
#     'L' locked
#   Fourth column: Scheduled commit will contain addition-with-history
#     ' ' no history scheduled with commit
#     '+' history scheduled with commit
#   Fifth column: Whether the item is switched or a file external
#     ' ' normal
#     'S' the item has a Switched URL relative to the parent
#     'X' a versioned file created by an eXternals definition
#   Sixth column: Repository lock token
#     (without -u)
#     ' ' no lock token
#     'K' lock token present
#     (with -u)
#     ' ' not locked in repository, no lock token
#     'K' locked in repository, lock toKen present
#     'O' locked in repository, lock token in some Other working copy
#     'T' locked in repository, lock token present but sTolen
#     'B' not locked in repository, lock token present but Broken
#   Seventh column: Whether the item is the victim of a tree conflict
#     ' ' normal
#     'C' tree-Conflicted
#   If the item is a tree conflict victim, an additional line is printed
#   after the item's status line, explaining the nature of the conflict.

# The out-of-date information appears in the ninth column (with -u):
#     '*' a newer revision exists on the server
#     ' ' the working copy is up to date

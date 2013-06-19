#!/usr/bin/env ruby -w

require 'trollop'

Trollop::options do
	version 'RM Unstaged v1.1 (Philip Blyth)'
	banner <<-BANNER
Purpose:
--------
`svn revert -R .` only reverts your working copy files, but leaves un-staged
files cluttering your `svn status`.

When you want the SVN equivalent of `git reset . --hard`, choose rm_unstaged!


Installation:
-------------
* On dev instance, save to:

	~/vm_home_devuser/scripts/

* Make sure is executable:

	chmod +x ~/vm_home_devuser/scripts/rm_unstaged.rb

* Symlink to `bin`:

	ln -s ~/vm_home_devuser/scripts/rm_unstaged.rb /usr/local/bin/rm_unstaged


Usage:
------
* Pipe any output into it:

	svn status | rm_unstaged
	cat my_saved_status_output | rm_unstaged

* Optionally, create handy alias to pipe svn status w/ color:
  Add the following to your `~/.profile` or `~/.bash_profile`:

	alias rmx="svn status | rm_unstaged"


Options:
--------
BANNER
end


# colorize lines:
$stdin.each do |line|
	if line.match(/^\?\s*(.*)$/)
		if File.directory? $1
			puts "Deleting folder: '#{$1}'."
			if Dir.entries($1).length > 2
				`rm -rf #{$1}`
			else
				Dir.rmdir $1
			end
		else
			puts "Deleting file:   '#{$1}'."
			File.delete $1
		end
	end
end

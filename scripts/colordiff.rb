#!/usr/bin/env ruby -w

require 'trollop'

Trollop::options do
	version 'ColorDiff v1.1 (Philip Blyth)'
	banner <<-BANNER
Installation:
-------------
* On dev instance, save to:

    ~/vm_home_devuser/scripts/

* Make sure is executable:

    chmod +x ~/vm_home_devuser/scripts/colordiff.rb

* Symlink to `bin`:

    ln -s ~/vm_home_devuser/scripts/colordiff.rb /usr/local/bin/colordiff


Usage:
------
* Pipe any output into it:

    diff [old] [new] | colordiff
    svn diff | colordiff
    cat my_saved_diff_output | colordiff

* Optionally, create handy alias to pipe svn diff w/ 'ignore whitespace all':
  Add the following to your `~/.profile` or `~/.bash_profile`:

	function fn_diff() { svn diff -x -w $* | colordiff; }
	alias diffx=fn_diff


Dependencies:
-------------
Requires `class.String.rb` in `lib/classes/`


Options:
--------
BANNER
end

# load dependencies:
require_relative '../lib/classes/class.String.rb'

# colorize lines:
$stdin.each do |line|
	print(if line.match(/^(Index\:|===)/)
			# Index: css/master.css
			# ===================================================================
			line.color('white').bold
		elsif line.match(/^(\-\-\-|\+\+\+|@@)/)
			# --- css/master.css	(revision 13748)
			# +++ css/master.css	(working copy)
			# @@ -1645,11 +1645,27 @@
			line.color('blue')
		elsif line.match(/^\-/)
			# -#left-rail .box-05 ul ul li.current a.current {
			line.color('red')
		elsif line.match(/^\+/)
			# +#left-rail .box-05 ul ul li.current {
			line.color('green')
		else
			line
		end)
end

#!/usr/bin/env ruby -w

require 'trollop'

Trollop::options do
	version 'ColorProps v0.1 (Philip Blyth)'
	banner <<-BANNER
Installation:
-------------
* On dev instance, save to:

    ~/vm_home_devuser/scripts/

* Make sure is executable:

    chmod +x ~/vm_home_devuser/scripts/colorprops.rb

* Symlink to `bin`:

    ln -s ~/vm_home_devuser/scripts/colorprops.rb /usr/local/bin/colorprops


Usage:
------
* Pipe svn prop output into it:

    svn propget svn:externals . -R | colorprops
    svn propget svn:mergeinfo . -R | colorprops


Dependencies:
-------------
Requires `class.String.rb` in `lib/classes/`


Options:
--------
BANNER
end

# load dependencies:
require_relative '../lib/classes/class.String.rb'

def line_match line
	if line.match(/^(.*) - (.*)$/)
		# webroot/lib/cpg -
		"#{$1.color('blue')}\n#{line_match $2}"
	elsif line.match(/^(\/[^:]+)(.*)$/)
		# svn:mergeinfo path
		"\t#{$1.white}#{$2}\n"
	elsif line.match(/^([\w\/]+)\s+(-r\d+)?\s?(.+)$/)
		# svn:externals reference
		"\t#{$1.white.ljust(32)}#{($2 || '').color('red')} #{$3}\n"
	else
		line.color('green')
	end
end

# colorize lines:
$stdin.each do |line|
	print line_match line
end


# svn:mergeinfo example:
# ----------------------
# . - /branches/WCPG-1449:14946,14952,14963,14966-14967,14969-14970,14991
# /branches/ui-minify:14989-15059
# /trunk:14644-14989


# svn:externals example:
# ----------------------
# . -

# webroot/lib/cpg -
# CCIS			https://svn.cpg.org/web-ccis/branches/webSignIn/webroot/lib/cpg/CCIS
# UI				https://svn.cpg.org/web-ccis/branches/webSignIn/webroot/lib/cpg/UI

# OSSCR			-r2039 https://svn.cpg.org/web-lib/releases/osscr/0009/webroot/lib/cpg/OSSCR

# UtilsGeneral	https://svn.cpg.org/web-lib/branches/ER/webroot/lib/cpg/UtilsGeneral
# UtilsOSSCR		https://svn.cpg.org/web-lib/branches/ER/webroot/lib/cpg/UtilsOSSCR
# UtilsWSS		https://svn.cpg.org/web-lib/branches/ER/webroot/lib/cpg/UtilsWSS

# webroot/lib/external -
# jquery		-r1364 https://svn.cpg.org/web-ccis/tags/20110830-a-gberman-newCPG_development/webroot/lib/external/jquery

# webroot/org/cpg/employee_roster/externals -
# ecd/client/css					https://svn.cpg.org/web-ecd/trunk/webroot/client/css
# ecd/client/assets				https://svn.cpg.org/web-ecd/trunk/webroot/client/assets
# ecd/client/scripts/cpg/plugins	https://svn.cpg.org/web-ecd/trunk/webroot/client/scripts/cpg/plugins
# ecd/client/scripts/support		https://svn.cpg.org/web-ecd/trunk/webroot/client/scripts/support

# CCIS							https://svn.cpg.org/web-ccis/branches/webSignIn/webroot/lib/cpg/CCIS
# cpg/UI							https://svn.cpg.org/web-ccis/branches/webSignIn/webroot/lib/cpg/UI
# jquery/newCPG					https://svn.cpg.org/web-ccis/branches/webSignIn/webroot/lib/external/jquery
# jquery/plugin					https://svn.cpg.org/web-ccis/branches/webSignIn/webroot/lib/external/jquery

# OSSCR							https://svn.cpg.org/web-lib/tags/20110222-a-gberman/webroot/lib/cpg/OSSCR

# webroot/requirements -
# ValidateThis		-r1960 https://svn.cpg.org/web-lib/tags/20110830-c-gberman-validateThis-fixes/webroot/lib/external/ValidateThis

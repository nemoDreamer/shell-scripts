#!/usr/bin/env ruby -w

##
# CPG Branches
# ============
# @author Philip Blyth
#
#
# Purpose:
# --------
# Lists parallel check-outs you have in your 'branches' folder.
# Replicates the functionality of the following aliases in an enriched way:
#
#   alias url='svn info | grep URL'
#   alias cpg='cd ~/sites/web-cpg/active && pwd && url'
#   alias cpg_br='cpg && cd branches && ls -l && cat README && cd ../..'
#
#
# Installation:
# -------------
# * On dev instance, save to:
#     ~/vm_home_devuser/scripts/
#
# * Make sure is executable:
#     chmod +x ~/vm_home_devuser/scripts/cpg_branches.rb
#
# * Symlink to 'bin':
#     ln ~/vm_home_devuser/scripts/cpg_branches.rb /usr/local/bin/cpg_branches
#
#
# Hierarchy:
# ----------
# This script expects the following hierarchy:
#
# - web-cpg
#   - active
#     - webroot
#     - ...
#   - branches
#     - RFC-xxxx
#       - webroot
#       - ...
#     - WCPG-xxxx
#       - webroot
#       - ...
#     - README
#     - ...
#
#
# README file:
# ------------
# README's content is optional, and helps you with remembering what each branch was:
#
#   RFC-xxxx  Changes to so-and-so
#   WCPG-xxxx Fixing this-and-this
#


# configuration:
DEFAULT  = 'web-cpg'
BRANCHES = 'branches'
README   = 'README'

DS = ENV['HOME'][0,1]

# load dependencies:
Dir.chdir( ENV['HOME'] + DS + 'vm_home_devuser' + DS + 'scripts' ) do |dir|
	require '.' + DS + 'lib/classes/class.String.rb'
end

# run!
Dir.chdir( ENV['HOME'] + DS + 'projects' + DS + 'dev' ) do |sites_dir| # was: Dir.pwd().sub(%r{(/sites/[^/]+/).*$}, '\\1')

	# change to 'web-cpg' or 1st ARGV
	Dir.chdir(ARGV[0] || DEFAULT) do |web_dir|

		# get branches info
		Dir.chdir(BRANCHES) do |branches_dir|

			# get 'README' content
			$read_me = (File.readable?(README) ? IO.readlines(README) : []).map do |line|
				line.match(/^(\S+)\s+(.*)$/)
				[$1, $2]
			end

			# get directory listing
			$dir_listing = Dir.entries('.').select do |entry|
				# only get directories, except for '.' and '..'
				!entry[/^\.+$/] && File.directory?(entry)
			end.sort.map do |entry|
				"%s %s\n" % [entry.ljust(9).color('blue'), $read_me.assoc(entry).to_a[1]]
			end.join

		end

		# get active branch URL
		$current = Dir.chdir('active') { `svn info` }.match(/^URL:\s+(.*\/(.*))$/)
		$current_README = $read_me.assoc($current[2]).to_a[1]

		# trick ENV into returning us to this directory after exit?
		# ENV['OLDPWD'] = sites_dir + DS + web_dir
		# nope, ruby can't modify the pwd of the parent shell... :'(

	end

end

# output
puts "\nCurrent branch:\n".white.bold + $current[1].color('green')
puts $current_README if $current_README
puts "\nAvailable branches:\n".white.bold + $dir_listing.color('blue')

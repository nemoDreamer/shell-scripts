#!/usr/bin/env ruby -w

# Dependencies:
# -------------
# Requires 'classes/class.String.rb' in same folder
#

# load dependencies:
Dir.chdir( ENV['HOME'] + '/vm_home_devuser/scripts/' ) do |dir|
  require './classes/class.String.rb'
end

# define sites list
sites = %w[
  web-apps
  web-bible
  web-board
  web-boardcms
  web-ccis
  web-churchpub
  web-control
  web-cpg
  web-cpg
  web-cpidownload
  web-download
  web-ecd
  web-ecdplus
  web-episcinvest
  web-eproductservices
  web-foo
  web-intranet
  web-lib
  web-livingthegood
  web-morehouseeducation
  web-mspr
  web-prepsunday
  web-previewbooks
  web-riteseries
  web-ritestuff
  web-theredbook
  web-weavinggods
  web-wss
]

# define fixed sites
httpd = 'active/conf/httpd.virtualhost.conf'
httpd_fixed = %w[
  web-cpg
  web-intranet
  web-churchpub
  web-weavinggods
  web-prepsunday
]

# change to projects/dev
Dir.chdir('/Users/' << `id -un`.chop << '/projects/dev') do |projects_dir|

  sites.each do |site|

    # create web-...?
    `mkdir -p #{site}`

    # change to web-...
    Dir.chdir(site) do |site_dir|

      # TODO check whether active contains .svn?

      puts "\nChecking out '#{site}'".white
      puts "--------------------------------------------------\n".white
      system %Q{svn co https://svn.cpg.org/#{site}/trunk active};

      begin
        File.rename(httpd, httpd + '_bkp') if !httpd_fixed.include?(site)
        puts "Backing-up #{httpd}."
      rescue
      end

    end
  end
end

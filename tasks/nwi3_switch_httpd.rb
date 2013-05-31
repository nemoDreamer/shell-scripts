#!/usr/bin/env ruby -w

httpd = 'conf/httpd.virtualhost.conf'
httpd_bkp = httpd + '_bkp'

if File.exists?(httpd)
  File.rename(httpd, httpd_bkp)
  puts "Hiding #{httpd}."
elsif File.exists?(httpd_bkp)
  File.rename(httpd_bkp, httpd)
  puts "Restored from #{httpd_bkp}."
end

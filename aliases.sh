# Directories

# - Projects
alias p-s='cd ~/projects/dev'
alias p='p-s; pwd'
alias mg='p-s; cd ../merges'

alias int-s="p-s && cd web-intranet/active"
alias cpg-s="p-s && cd web-cpg/active"
alias ecd-s="p-s && cd web-ecd/active"

alias int="int-s && pwd && url"
alias cpg="cpg-s && pwd && url"
alias ecd="ecd-s && pwd && url"

alias ir="cpg-s && cd webroot/org/cpg/institution_roster && pwd && url"
alias er="cpg-s && cd webroot/org/cpg/employee_roster && pwd && url"
alias acc="cpg-s && cd webroot/org/cpg/myBenefits && pwd && url"
alias hbpc="cpg-s && cd webroot/org/cpg/hbpc && pwd && url"
alias ecd_poc="ecd-s && webroot/poc && pwd && url"
alias ccis="p-s && cd web-ccis/active && pwd && url"
alias cccis="p-s && cd ../cpg-ccis/dev/active && pwd && url"
alias foo="p-s && cd web-foo/active/ && pwd && url"
alias cl="cpg-s && cd ../branches/redesign_UI_Clicker_Templates/active/webroot/_redesign/clicker_templates && pwd && url"

# - Themes
alias theme="cpg-s && r_theme"
alias int_theme="int-s && r_theme"
#   - Relatives
alias r_theme="cd webroot/default/includes/themes/cpg && pwd && url"
alias r_ccis="cd webroot/lib/cpg/CCIS && pwd && url"


# Local Development
alias vm='ssh devuser@vm.dev'
alias _vm='cd ~/vm_home_devuser'


# SVN
alias svn_revs="svn diff --depth empty ."
alias svn_inf="svn pg svn:mergeinfo . -R"
alias svn_x="svn pg svn:externals . -R"
alias svn_ign="svn pg svn:ignore ."
alias svn_ign_set="svn propset svn:ignore . --file 'ignore' -R"
alias svn_ls="svn ls \^/branches"
alias url="svn info 2>&1 | grep URL"

# - SVN scripts
alias cpg_br="cpg-s && cd .. && cpg.branches"
alias int_br="int-s && cd .. && cpg.branches web-intranet"
function fn_diff_c() { svn diff -x -w --no-diff-deleted $* | colordiff; }
alias diffc=fn_diff_c
function fn_diff_x() { svn diff -x -w --no-diff-deleted $* | subl; }
alias diffx=fn_diff_x
alias stx="svn status --ignore-externals | colorstatus"
alias stxx="svn status | colorstatus"
function fn_log() { svn log -l $1 | colorlog; }
alias log=fn_log
alias svx="svn_x    | colorprops"
alias svi="svn_inf  | colorprops"
alias svr="svn_revs | colorprops"
function fn_pe_x() { svn propedit svn:externals $*; }
alias pe_x=fn_pe_x
function fn_pe_i() { svn propedit svn:mergeinfo $*; }
alias pe_i=fn_pe_i


# CCIS tests
alias html_email="to=pblyth@cpg.org bundle exec rspec spec/ccis_mailer/templates_spec.rb"

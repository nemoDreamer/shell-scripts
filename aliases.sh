# ==================================================
# Directories
# ==================================================

# Listings
# --------------------------------------------------
alias ll="ls -la"


# Local Development
# --------------------------------------------------
# - SSH into VM
alias vm='ssh devuser@vm.dev'
# - local VM's ~
alias _vm='cd ~/vm_home_devuser'
# - local dev projects
alias p-s='cd ~/projects/dev'
alias p='p-s; pwd'
# - tmp merges
alias mg='p-s; cd ../merges'


# Projects
# --------------------------------------------------
# - Intranet
alias int-s="p-s && cd web-intranet/active"
alias int="int-s && pwd && url"
# - CPG.org
alias cpg-s="p-s && cd web-cpg/active"
alias cpg="cpg-s && pwd && url"
# - ECD
alias ecd-s="p-s && cd web-ecd/active"
alias ecd="ecd-s && pwd && url"
# - Institution Roster
alias ir="cpg-s && cd webroot/org/cpg/institution_roster && pwd && url"
# - Employee Roster
alias er="cpg-s && cd webroot/org/cpg/employee_roster && pwd && url"
# - MyCPG Accounts
alias acc="cpg-s && cd webroot/org/cpg/myBenefits && pwd && url"
# - HBPC
alias hbpc="cpg-s && cd webroot/org/cpg/hbpc && pwd && url"
# - Proof of Concept
alias ecd_poc="ecd-s && webroot/poc && pwd && url"
# - Living the Good News
alias ecd_poc="p-s && cd web-livingthegood && pwd && url"
# - foo
alias foo="p-s && cd web-foo/active/ && pwd && url"
# - Clicker Templates (obsolete)
alias cl="cpg-s && cd ../branches/redesign_UI_Clicker_Templates/active/webroot/_redesign/clicker_templates && pwd && url"


# Themes
# --------------------------------------------------
# - Relative to current MURA branch
alias r_theme="cd webroot/default/includes/themes/cpg && pwd && url"
# - CPG.org trunk theme
alias theme="cpg-s && r_theme"
# - Intranet trunk theme
alias int_theme="int-s && r_theme"


# CCIS
# --------------------------------------------------
# - CCIS admin
alias ccis="p-s && cd web-ccis/active && pwd && url"
# - CCIS service
alias cccis="p-s && cd ../cpg-ccis/dev/active && pwd && url"
# - Relative to current CPG.org/Intranet/MLPS/... branch
alias r_ccis="cd webroot/lib/cpg/CCIS && pwd && url"
# - HTML Email tests
alias html_email="to=pblyth@cpg.org bundle exec rspec spec/ccis_mailer/templates_spec.rb"



# ==================================================
# SVN aliases & scripts
# ==================================================
# (grouped w/ their colorized shortcut equivalents)


# SVN Properties
# --------------------------------------------------

# - Get merged revisions
#   (for useful info to add to a merge's commit message!)
alias svn_r="svn diff --depth empty ."
alias svr="svn_r | colorprops"

# - Get recursive svn:merginfo
alias pg_m="svn pg svn:mergeinfo . -R"
alias pgm="pg_m  | colorprops"

# - Edit svn:mergeinfo
#   (usage: pe_m [folder])
function pe_m() { svn propedit svn:mergeinfo $*; }

# - Get recursive svn:externals
alias pg_x="svn pg svn:externals . -R"
alias pgx="pg_x    | colorprops"

# - Edit svn:externals
#   (usage: pe_x [folder])
function pe_x() { svn propedit svn:externals $*; }

# - Get svn:ignore
alias pg_i="svn pg svn:ignore ."

# - Edit svn:ignore
alias pe_i="svn propset svn:ignore . --file 'ignore' -R"


# Branches
# --------------------------------------------------

# - List repo branches
alias svn_ls="svn ls \^/branches"

# - Display current branch
alias url="svn info 2>&1 | grep URL"

# - Super-fast branch switching
#   (see `cpg.branches -h` for setup and usage!)
alias cpg_br="cpg-s && cd .. && cpg.branches"
alias int_br="int-s && cd .. && cpg.branches web-intranet"


# DIFFs
# --------------------------------------------------

# - Colorized SVN diff (ignores white-space changes!)
#   (usage: diffc [files])
function diffc() { svn diff -x -w --no-diff-deleted $* | colordiff; }

# - View same SVN diff in Sublime Text (ignores white-space changes!)
#   (usage: diffc [files])
function diffx() { svn diff -x -w --no-diff-deleted $* | subl; }


# Status and Logs
# --------------------------------------------------

# - Fast colorized SVN status
#   (ignores svn:externals)
alias stx="svn status --ignore-externals | colorstatus"

# - Full colorized SVN status
alias stxx="svn status | colorstatus"

# - Colorized SVN logs
#   (usage: log [number of lines])
function log() { svn log -l $1 | colorlog; }

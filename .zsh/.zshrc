# set prompts
[[ $TERM == (cons25*|linux) ]] && LENGTH=22 || LENGTH=36

NC=$'%{\e[0m%}'
(( $EUID == 0 )) && UC=$'%{\e[1;31m%}' || UC=$'%{\e[1;32m%}'

UC=$'%{\e[1;32m%}'
#PS1="${UC}[${NC}%n@%m${UC}:${NC}%${LENGTH}<..<%B%~%b${UC}]%#${NC} "
PS1="${UC}[${NC}%n${UC}:${NC}%${LENGTH}<..<%B%~%b${UC}]%#${NC} "
PS2="%_${UC}>${NC} "
PS2="%_${UC}>${NC} "
PS3="?# "
PS4="+%N:%i${UC}>${NC} "

unset NC UC LENGTH RPS1

# set spelling prompt
SPROMPT="zsh: correct "%R" to "%r"? ([y]es/[n]o/[e]dit/[a]bort) "

# don't ask "do you wish to see all XX possibilities" before menu selection
LISTPROMPT=""

# functions for displaying some information in x-terminals
if [[ $TERM == (*xterm*|rxvt|(a|E)term) ]]; then
        # display user and directory in terminal title
        precmd () {
                print -Pn "\033]0;%n:%30<..<%~%# <%l>\007"
        }
        # display user, directory and name of current
        # process in terminal title
        preexec () {
                print -Pn "\033]0;%n:%30<..<%~%# $1 <%l>\007"
        }
fi

# use hard limits, except for a smaller stack and no core dumps
# unlimit
# limit stack 8192
# limit coredumpsize 0
# limit -s

# set history file
HISTFILE=$ZDOTDIR/.zhistory
# the maximum number of history events in internal history list
HISTSIZE=10000
# the maximum number of history events to save in the history file
SAVEHIST=10000

DIRSTACKSIZE=30

# don't terminate zsh after TMOUT
unset TMOUT

# set editors
#which vim >&/dev/null && EDITOR="vim" || EDITOR="vi"
EDITOR="vim"
VISUAL="$EDITOR"
FCEDIT="$EDITOR"
export EDITOR VISUAL FCEDIT

# set pager and options for less
PAGER="less -s"
#PAGER="most -s"
LESS="-iMW"
export PAGER LESS

# set BLOCKSIZE
export BLOCKSIZE="K"

# endings
alias -s pdf="evince"
alias -s doc="ooffice"
alias -s xls="ooffice"

alias -s gif="gqview"
alias -s jpg="gqview"
alias -s jpeg="gqview"
alias -s png="gqview"
alias -s tif="gqview"
alias -s tiff="gqview"

alias -s properties="vi"
alias -s txt="vi"
alias -s log="less"

# set aliases
alias ls="ls -FGh"
alias la="ls -a"
alias ll="ls -lh"
alias lla="ls -la"
alias ltr="ls -ltr"

alias pu="pushd"
alias po="popd"
alias d="dirs -v"
alias h="fc -l"
alias sd="sudo"
alias vi="vim"
alias svi="sudo vim"
alias svndiff="svn diff --diff-cmd=meld"

alias tcdie="kill -9 \`ps aux G tomcat GV grep | awk '{print \$2}'\`"
alias cdtc="cd $TOMCAT_HOME"

alias '..'='cd ..'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

alias cp="cp -i"
alias mv="mv -i"

# maven
alias mvnnt="mvn -Dmaven.test.skip=true"
alias mvnc="mvn clean"
alias mvninst="mvnnt && /bin/cp -v target/*[^source].jar $TOMCAT_HOME/pblib"

alias cdsvn="cd /home/kuro/work/pirobase"

# set global aliases
alias -g L="| less"
alias -g H="| head"
alias -g T="| tail"
alias -g XG="| xargs grep"
alias -g G="| grep"
alias -g GI="| grep -i"
alias -g GV="| grep -v"
alias -g GVI="| grep -vi"
alias -g EG="| egrep"
alias -g EGI="| egrep -i"
alias -g EGV="| egrep -v"
alias -g EGVI="| egrep -vi"
alias -g SORT="| sort"
alias -g LINES="| wc -l"
alias -g JSON="| python -mjson.tool"

alias -g N="&>/dev/null"
alias -g 1N="1>/dev/null"
alias -g 2N="2>/dev/null"
alias -g DN="/dev/null"
alias -g DZ="/dev/zero"
alias -g DR="/dev/random"

# redefine or delete useless aliases for linux
alias ls="ls -F --color"

# set key bindings
bindkey -e

case $TERM in
        cons25*)
                bindkey "^?" delete-char                # cons25
                bindkey "^[[1~" beginning-of-line        # cons25
                bindkey "^[[4~" end-of-line		# cons25
        ;;
        xterm*)
                bindkey "^[[3~" delete-char             # xterm
                bindkey "^[[1~" beginning-of-line	# xterm
                bindkey "^[[4~" end-of-line		# xterm
                bindkey "^[OF" end-of-line
		bindkey "^[OH" beginning-of-line
        ;;
        rxvt-*)
                bindkey "^[[3~" delete-char             # rxvt
                bindkey "^?" backward-delete-char       # rxvt
                bindkey "^[[7~" beginning-of-line       # rxvt
                bindkey "^[[8~" end-of-line             # rxvt
                bindkey "^[[1~" beginning-of-line       # aterm
                bindkey "^[[4~" end-of-line             # aterm
		export TERM=xterm
        ;;
esac
# bindkey "^[[A" up-line-or-search
# bindkey "^[[B" down-line-or-search

# bindkey "^[[0A" up-line-or-search
# bindkey "^[[0B" down-line-or-search

bindkey "${terminfo[kcuu1]}" up-line-or-search
bindkey "${terminfo[kcud1]}" down-line-or-search

bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

# setup style completion system
autoload -U compinit
compinit -C

# general completion technique, complete as much u can
zstyle ':completion:*' completer _complete _list _oldlist _expand _ignored \
                                 _match _correct _approximate _prefix

# allow one error
#zstyle ':completion:*:approximate:*' max-errors 1 numeric
# allow one error for every four characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
        'reply=($(( ($#PREFIX+$#SUFFIX)/4 )) numeric)'

# formatting and messages
zstyle ':completion:*' verbose yes

NC=$'%{\e[0m%}'
C=$'%{\e[1;36m%}'

zstyle ':completion:*:descriptions' format "${C}%d${NC}"
zstyle ':completion:*:messages'     format "${C}%d${NC}"
zstyle ':completion:*:warnings'     format "${C}No matches for: %d${NC}"
zstyle ':completion:*:corrections'  format "${C}%d (errors: %e)${NC}"
zstyle ':completion:*' group-name ''
zstyle ':completion:*' special-dirs true

# determine in which order the names (files) should be
# listed and completed when using menu completion
zstyle ':completion:*' file-sort name

# set menu completion
zstyle ':completion:*' menu select=5

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# ignore completion functions for commands you don't have
zstyle ':completion:*:functions' ignored-patterns '_*'

# completion caching
zstyle ':completion::complete:*' use-cache 1

# add colors to completions
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# add colors to processes for kill completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

# don't complete backup files as executables
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'

# host completion
hosts=($(hostname)
		localhost
		${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*}	
	)

zstyle ':completion:*' hosts $hosts

# completions for some progs. not in default completion system
zstyle ':completion:*:*:mpg123:*' file-patterns \
        '*.(mp3|MP3):mp3\ files *(-/):directories'

zstyle ':completion:*:*:ogg123:*' file-patterns \
        '*.(ogg|OGG):ogg\ files *(-/):directories'

# set options
setopt  always_to_end
setopt  auto_cd
setopt  auto_name_dirs
setopt  auto_pushd
setopt  NO_auto_resume
setopt  brace_ccl
setopt  bsd_echo
setopt  NO_c_bases
setopt  cdable_vars
setopt  NO_chase_dots
setopt  NO_chase_links
setopt  NO_clobber
setopt  NO_complete_aliases
setopt  complete_in_word
setopt  NO_correct
setopt  NO_correct_all
setopt  extended_glob
setopt  NO_hist_allow_clobber
setopt  hist_expire_dups_first
setopt  hist_find_no_dups
setopt  hist_ignore_all_dups
setopt  hist_ignore_dups
setopt  hist_ignore_space
setopt  hist_no_functions
setopt  hist_no_store
setopt  hist_reduce_blanks
setopt  hist_save_no_dups
setopt  hist_verify
setopt  inc_append_history
setopt  interactive_comments
setopt  NO_list_ambiguous
setopt  list_packed 
setopt  NO_list_rows_first 
setopt  list_types
setopt  long_list_jobs
setopt  magic_equal_subst
setopt  NO_mail_warning
setopt  NO_nomatch
setopt  NO_numeric_glob_sort
setopt  NO_path_dirs
setopt  print_eight_bit
setopt  pushd_ignore_dups
setopt  pushd_minus
setopt  pushd_silent
setopt  rc_quotes
setopt  rm_star_silent
setopt  share_history

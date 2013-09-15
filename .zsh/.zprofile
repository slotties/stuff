# .zprofile is sourced in login shells before .zshrc.

# set TERMCAP and terminal settings to current terminal window size
[[ $TERM != (cons25*|linux) ]] && eval $(resize)

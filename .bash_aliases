# enable color support of ls and also add handy aliases

if [ "$TERM" != "dumb" ]; then
    LSCOLOR="yes"
else
    LSCOLOR="no"
fi

eval "`dircolors -b`"

if [ $TERM == "dumb" ] || [ $TERM == "emacs" ]; then
    alias ls="ls -F"
    alias la="ls -AF"
    alias lf="ls -lsAg"
    alias lr="ls -AR"
    alias lt="ls -ltr"
else
    alias ls="ls --color=$LSCOLOR -F"
    alias la="ls --color=$LSCOLOR -AF"
    alias lf="ls --color=$LSCOLOR -lsAg"
    alias lr="ls --color=$LSCOLOR -AR"
    alias lt="ls --color=$LSCOLOR -ltr"
fi

alias clean="/bin/mv -f \#* *~ \.*~ \.\#* ${HOME}/.DEL/ > /dev/null 2>&1"

ps="ps auxww"
alias psme='$ps | head -1; $ps | grep `whoami` | grep -v "ps auxww" | grep -v "grep `whoami`"'

alias cvs-checkout="cvs checkout -P"
alias cvs-update="cvs update -d -P 2>&1 | grep -v Updating | grep -vP '^\?'"

cvs-vstatus() { cvs status $1 2>&1 | grep -E "(^cvs status)|(Status:)"; }
cvs-status() { cvs status $1 2>&1 | grep -E "(^cvs status)|(Status:)" | grep -v 'Up-to-date';  }

alias ldel="ls ${HOME}/.DEL/"

alias he="history | egrep"
                    
del() { mv $* ${HOME}/.DEL/; }

alias rm=del

alias h=history

eg() { env | grep $1; }

f() { find . -iname $1; }

alias cls=clear

alias pg="ps auxww | head -1; ps auxww | grep -v grep | egrep"

alias wl="wc -l"

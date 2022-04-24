# enable color support of ls and also add handy aliases

if [ "$TERM" != "dumb" ]; then
    LSCOLOR="yes"
else
    LSCOLOR="no"
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    # on a mac there is no dircolors so we do not execute this block on OS X
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi

# ls aliases
if [ "`uname`" == "Darwin" ]; then
    # on a mac it's a different ls, override previous alias if made
    alias ls='ls -G'
    alias ls="ls -GF"
    alias la="ls -GAF"
    alias lf="ls -GlsAg"
    alias lr="ls -GAR"
    alias lt="ls -Gltr"
    alias ll='ls -GalF'
    alias l='ls -GCF'
elif [ $TERM == "dumb" ] || [ $TERM == "emacs" ]; then
    alias ls="ls -F"
    alias la="ls -AF"
    alias lf="ls -lsAg"
    alias lr="ls -AR"
    alias lt="ls -ltr"
    alias ll='ls -alF'
    alias l='ls -CF'
else
    alias ls="ls --color=$LSCOLOR -F"
    alias la="ls --color=$LSCOLOR -AF"
    alias lf="ls --color=$LSCOLOR -lsAg"
    alias lr="ls --color=$LSCOLOR -AR"
    alias lt="ls --color=$LSCOLOR -ltr"
    alias ll='ls --color=$LSCOLOR -alF'
    alias l='ls --color=$LSCOLOR -CF'
fi

# give greps a color
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

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

alias cleanup='sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g"'

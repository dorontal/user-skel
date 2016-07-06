# .bash_profile

# Initialize keychain if needed
# if [ -r $HOME/.ssh/identity -o -r $HOME/.ssh/id_dsa -o -r $HOME/.ssh/id_rsa ]; then
#       if [ ! -d $HOME/.keychain ]; then
#               keychain
#        fi
#fi

SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo -n "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
     # looks like we already have an agent, ensure this using ps command
    . "${SSH_ENV}" > /dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent
    }
else
    /home/dtal/bin/zap ssh-agent
    start_agent
fi

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Determine platform first
export platform='unknown'
uname=$(uname)
if [[ "x${uname}" == "xDarwin" ]]; then
    export platform='mac'
elif [[ "x${uname}" == "xLinux" ]]; then
    export platform='linux'
fi

echo "I am a $platform"

export dnsdomainname='unknown'
if which dnsdomainname >/dev/null; then
    export dnsdomainname=$(dnsdomainname)
else
    export dnsdomainname='unknown'
fi

export domainname='unknown'
if which domainname >/dev/null; then
    export domainname=$(domainname)
else
    export domainname='unknown'
fi

export hostname='unknown'
if which domainname >/dev/null; then
    export hostname=$(hostname)
else
    export hostname='unknown'
fi


#EXPORT
export EDITOR=/usr/bin/nano
export PATH="/usr/local/sbin:$PATH"
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

#ALIAS
alias ll='ls -FGlAhp'   
alias c='clear'
alias f='open -a Finder ./'
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'
alias myip='curl ipecho.net/plain; echo'
alias gmailKey='/usr/bin/ssh-add $HOME/.ssh/id_rsa_gmail'
alias adistaKey='/usr/bin/ssh-add $HOME/.ssh/id_rsa_adista'

SSH_ENV=$HOME/.ssh/environment

# start the ssh-agent
function start_agent {
    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
}

if [ -f "${SSH_ENV}" ]; then
     . "${SSH_ENV}" > /dev/null
     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

export PS1="\[\e[36m\]\u@\h\[\e[m\] \[\e[32m\]\w\[\e[m\]\nλ: "

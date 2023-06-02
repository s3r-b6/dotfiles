export ZSH="$HOME/.oh-my-zsh"
export TERM='kitty'
export ZELLIJ_AUTO_EXIT="true"
export ZELLIJ_AUTO_ATTACH="true"
export PATH="$HOME/.local/bin:$PATH"

alias lvim='~/.local/bin/lvim'
alias backup_pkgs='pacman -Qqe > ~/.config/pkglist.txt'
alias clean_orphans='sudo pacman -Qtdq | sudo pacman -Rns -'
alias start_mariadb='sudo systemctl start mariadb.service'
alias stop_mariadb='sudo systemctl stop mariadb.service'

## Two little scripts to make mvn usage more ergonomic
mvn_exec() {mvn exec:java -Dexec.mainClass=$1}
mvn_arch() {
    if [[ $# -eq 1 ]]; then
        if [[ $1 == "-h" || $1 == "--help" ]]; then
            echo "Params:"
            echo "  -h --help -> Shows this information"
            echo "  -d --def -> Creates a my-app template"
            echo "Normal usage of the function: param1 - groupId, param2 - artifactId"
        elif [[ $1 == "-d" || $1 == "--default" ]]; then
            mvn archetype:generate -DgroupId=com.mycompany.app -DartifactId=my-app -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.4 -DinteractiveMode=false
        fi
    elif [[ $# -ne 2 ]]; then
        echo "Missing parameters or wrong usage:"
        echo "Usage of the function: \$1 - groupId, \$2 - artifactId"
        echo "Params:"
        echo "  -h --help -> Shows this information"
        echo "  -d --def -> Creates a my-app template"
        echo "Normal usage of the function: param1 - groupId, param2 - artifactId"
    elif [[ $# -eq 2 ]]; then
        mvn archetype:generate -DgroupId=$1 -DartifactId=$2 -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.4 -DinteractiveMode=false
    else
        echo "Wrong usage:"
        echo "Params:"
        echo "  -h --help -> Shows this information"
        echo "  -d --def -> Creates a my-app template"
        echo "Normal usage of the function: param1 - groupId, param2 - artifactId"
    fi
}

# https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Plugins
plugins=(git z)
source $ZSH/oh-my-zsh.sh
source $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#open ZelliJ on shell start
if [[ -z "$ZELLIJ" ]]; then
    if [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]] && pgrep zellij >dev/null ; then
        zellij attach
    else
        zellij
    fi

    if [[ "$ZELLIJ_AUTO_EXIT" == "true" ]]; then
        exit
    fi
fi

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi
autoload -U compinit; compinit

#load ssh key
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l > /dev/null || ssh-add ~/.config/.ssh/key

neofetch

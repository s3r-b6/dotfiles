export ZSH="$HOME/.oh-my-zsh"
export TERM=xterm-256color
export PATH="$HOME/.local/bin:$HOME/go/bin:$PATH"
export HSA_OVERRIDE_GFX_VERSION="10.3.0"

export JAVA_HOME="/usr/lib/jvm/java-21-openjdk/"

alias backup_pkgs='pacman -Qqe > ~/.config/pkglist.txt'
alias clean_orphans='sudo pacman -Qtdq | sudo pacman -Rns -'

alias ollama_serve='docker run --name ollama_server --env HSA_OVERRIDE_GFX_VERSION=10.3.0 -d --device /dev/kfd --device /dev/dri -v ollama:/root/.ollama -p 11434:11434 ollama/ollama:rocm'


# https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Plugins
plugins=(git z)
source $ZSH/oh-my-zsh.sh
source $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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

fastfetch

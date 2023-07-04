export ZSH="$HOME/.oh-my-zsh"
export TERM='kitty'
export ZELLIJ_AUTO_EXIT="true"
export ZELLIJ_AUTO_ATTACH="true"
export PATH="$HOME/.local/bin:$PATH"

alias lvim='~/.local/bin/lvim'
alias backup_pkgs='pacman -Qqe > ~/.config/pkglist.txt'
alias clean_orphans='sudo pacman -Qtdq | sudo pacman -Rns -'

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

# opam configuration
[[ ! -r /home/ser/.opam/opam-init/init.zsh ]] || source /home/ser/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

OPAM_SWITCH_PREFIX='/home/ser/.opam/default'; export OPAM_SWITCH_PREFIX;
CAML_LD_LIBRARY_PATH='/home/ser/.opam/default/lib/stublibs:/home/ser/.opam/default/lib/ocaml/stublibs:/home/ser/.opam/default/lib/ocaml'; export CAML_LD_LIBRARY_PATH;
OCAML_TOPLEVEL_PATH='/home/ser/.opam/default/lib/toplevel'; export OCAML_TOPLEVEL_PATH;
MANPATH=':/home/ser/.opam/default/man'; export MANPATH;
PATH='/home/ser/.opam/default/bin:/home/ser/.local/bin:/home/ser/.local/bin:/home/ser/.cargo/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl'; export PATH;

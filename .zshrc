# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# If not running interactively, don't do anything
export PATH="$HOME/.local/bin:$PATH"
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTFILE=~/.zsh_history

# Set the number of commands to remember in the current session
HISTSIZE=10000

# Set the number of commands to save in the history file
SAVEHIST=10000

# Append history from all sessions to the history file
setopt APPEND_HISTORY

# Share history across all sessions
setopt SHARE_HISTORY

# Write history to the history file as each command is entered
setopt INC_APPEND_HISTORY

# Avoid duplicate entries in the history
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS

# Ignore commands that start with a space
setopt HIST_IGNORE_SPACE

# Remove old duplicates from the history
setopt HIST_FIND_NO_DUPS

# Load history immediately when starting a new session
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_NO_STORE
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# if [ "$color_prompt" = yes ]; then
#     PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# else
#     PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
# fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
# case "$TERM" in
# xterm*|rxvt*)
#     PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#     ;;
# *)
#     ;;
# esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
winpath=~/../../mnt/c/Users/DerekDerekZuurmondKB/OneDrive\ -\ \KBenP\ Holding/

# eval "$(zoxide init --cmd cd bash)"
# Alias to navigate to GitHub directory
# # alias hub='cd "${winpath}Documenten/GitHub"'
# alias dijkstra='cd "${winpath}Documenten/GitHub/Logistiek-backend-func-DijkstraPath-v2"'
# alias dtp='cd "${winpath}Documenten/GitHub/DTP"'
# alias dos='cd "${winpath}Documenten/GitHub/dtp-utility-opensource"'
# alias util='cd "${winpath}Documenten/GitHub/analyze-utils"'
#alias fzf="find . \( -name 'venv' -o -name '.git' -o -name '__pycache__' -o -name 'myvenv' \) -prune -o -type f -print | fzf"
alias ff="find . \( -name 'venv' -o -name '.git' -o -name '__pycache__' -o -name 'myvenv' \) -prune -o -type f -print | fzf"

# alias fzfp="vim $(find . \( -name 'venv' -o -name '.git' -o -name '__pycache__' -o -name 'myvenv' \) -prune -o -type f -print | fzf --preview 'batcat --style=numbers --color=always --line-range :500 {}')"


# ---- Eza (better ls) -----

# alias ls="eza  --git --long --git-ignore --no-filesize    --no-user --no-permissions --icons"
alias ls="eza --git --long --git-ignore --no-user --no-permissions --icons --binary"
alias tree="eza --git --long --git-ignore --no-filesize    --no-user --no-permissions --icons --tree"











alias :q='echo You are not editing a file, dummy.'
alias :wq='echo You are not editing a file, dummy.'
alias cat=batcat
alias brandweer='cd "/mnt/c/Users/DerekDerekZuurmondKB/OneDrive - KBenP Holding/Documenten/GitHub/brandweer"'




# source ~/.config/git-prompt.sh/git-prompt.sh
#export PS1='\w $(__git_ps1 "(%s) ")$ '

#if [ -f ~/.config/git-prompt.sh/git-prompt.sh ]; then
#  . ~/.config/git-prompt.sh/git-prompt.sh
##  GIT_PS1_SHOWUPSTREAM="auto"
#  GIT_PS1_SHOWCOLORHINTS=true
# #PS1='[\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\]]\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '
# PS1='\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\]\[\033[31m\]$(__git_ps1)\[\033[00m\]\n\$ '
#fi




# source ~/fshow.sh
## Function to search bash history using fzf with an exact match option
fh() {
    local query="$1"
    local selected_command

    if [ -n "$query" ]; then
        selected_command=$(history | fzf --tac +s --tiebreak=index --exact --query="$query" | sed -E 's/^[ ]*[0-9]+\*?[ ]+//')
    else
        selected_command=$(history | fzf --tac +s --tiebreak=index | sed -E 's/^[ ]*[0-9]+\*?[ ]+//')
    fi

    if [ -n "$selected_command" ]; then
        echo $selected_command
        eval $selected_command
    fi
}



declare -A pomo_options
pomo_options["work"]="1"
pomo_options["break"]="10"

pomodoro () {
  if [ -n "$1" -a -n "${pomo_options["$1"]}" ]; then
  val=$1
  echo $val | lolcat
  timer ${pomo_options["$val"]}m
  spd-say "'$val' session done"
  fi
}

alias wo="pomodoro 'work'"
alias br="pomodoro 'break'"
hgt='f() {history | grep $1 | tail -n 2}; f'
# alias lfzf='function _lfzf() { vim "$(locate "$1" | fzf)"; }; _lfzf'

autoload -U compinit; compinit
source ~/zsh/fzf-tab.plugin.zsh


locate_vim() {
  if [ -z "$1" ]; then
    echo "Usage: locate_vim <search_pattern>"
    return 1
  fi

  results=$(locate "$1")
  count=$(echo "$results" | wc -l)

  if [ "$count" -eq 0 ]; then
    echo "No files found matching the pattern."
    return 1
  elif [ "$count" -eq 1 ]; then
    vim "$results"
  else
    echo "Multiple files found:"
    echo "$results" | nl
    echo
    read -p "Enter the number of the file to open: " file_number
    file=$(echo "$results" | sed -n "${file_number}p")
    if [ -n "$file" ]; then
      vim "$file"
    else
      echo "Invalid selection."
    fi
  fi
}

# Create an alias for convenience
alias lvim=locate_vim
alias vim=nvim
# alias fff="vim $(find . \( -name 'venv' -o -name '.git' -o -name '__pycache__' -o -name 'myvenv' \) -prune -o -type f -print | fzf)"


gfzf() {
    local search_term="$1"
    ag --hidden --ignore 'venv' --ignore '.git' --ignore '__pycache__' --ignore 'myvenv' --color "$search_term" | fzf
}


eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# Set up a simple prompt showing the full path
export PROMPT='%F{green}%n@%m%f:%F{blue}%~%f%# '
# Load vcs_info module

eval "$(starship init zsh)"
unset STARSHIP_CONFIG
unset STARSHIP_CONFIG
export STARSHIP_CONFIG=~/.config/starship.toml
# Remove or adjust any recursive sourcing or problematic functions
eval "$(zoxide init --cmd cd zsh)"




function fshow() {
  git log  --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort --preview \
         'f() { set -- $(echo -- "$@" | grep -o "[a-f0-9]\{7\}"); [ $# -eq 0 ] || git show --color=always $1 ; }; f {}' \
      --header "enter to view, ctrl-o to checkout" \
      --bind "ctrl-q:abort,ctrl-f:preview-page-down,ctrl-b:preview-page-up" \
      --bind "ctrl-o:execute:(echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | xargs git checkout)" \
      --bind "ctrl-m:execute:(echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | xargs -I % sh -c 'git show --color=always % | less -R')" \
      --preview-window=right:60%
}

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh


function set_win_title(){
    echo -ne "\033]0; $(basename "$PWD") \007"
}

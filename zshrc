# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="avit"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# External IP
alias myip="curl http://ipecho.net/plain; echo"

# Kill user
alias killme="pkill -KILL -u $(whoami)"

# Exit
alias e=exit

# Git
alias g-="git checkout -"
alias gs="git status"
alias gbranch="git branch | cat"
alias gslist="git stash list"
alias gspush="git stash push -u -m"
alias gspop="git stash pop"
alias gundo="git reset HEAD~1"
alias gdiscard="git reset --hard"
alias gcb="git checkout -b"
alias ga="git add"
alias gcm="git commit -m"

function gmain() {
  git checkout main
  if [ $? -ne 0 ]; then
    git checkout master
  fi
}
function gdev() {
  git checkout staging
  if [ $? -ne 0 ]; then
    git checkout development
  fi
}
function gpush() {
  git push --no-verify
  if [ $? -eq 128 ]; then
    git push -u origin $(git rev-parse --abbrev-ref HEAD) --no-verify
  fi
}
function gpull() {
  git pull
  if [ $? -ne 0]; then
    fit pull -u origin $(git rev-parse --abbrev-ref HEAD)
  fi
}
function gprune() {
  git remote prune origin
  git branch --merged | grep  -v '\*\|master\|develop' | xargs -n 1 git branch -d
}
function gpurge() {
  gbranch | grep  -v '\*\|master\|develop' | xargs -n 1 git branch -D
}
function grebase() {
  git rebase main
  if [ $? -ne 0 ]; then
    git rebase master
    if [ $? -ne 0 ]; then
      git rebase staging
    fi
  fi
}
function gac() {
  git add .
  if [ "$1" -ne "" ]; then
    git commit -m "$1"
  else
    git commit -m "fix: minor improvements"
  fi
}
function grifle(){
  echo COMMIT_MSG > ~/.gitignore
  git config --global core.excludesfile '~/.gitignore'
}
function gaim() {
  echo "\n\n# This commit will..." > ./COMMIT_MSG
  vim ./COMMIT_MSG
}
function gfire() {
  vim ./COMMIT_MSG
  git commit -F ./COMMIT_MSG $*
  rm ./COMMIT_MSG
}
function glines(){
  git ls-files | while read f; do git blame -w --line-porcelain -- "$f" | grep -I '^author '; done | sort -f | uniq -ic | sort -n
}
function gcommits(){
  git shortlog -s -n --all --no-merges
}


# NPM
function npmi() {
  if [ -f "package-lock.json" ]; then
    npm install
  elif [ -f "yarn.lock" ]; then
    yarn install
  elif [ -f "pnpm-lock.yaml" ]; then
    pnpm install
  else
    npm install
  fi
}
alias rnpm="rm -fr node_modules; npmi"

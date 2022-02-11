# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/$USER/.oh-my-zsh"

source $ZSH/oh-my-zsh.sh
source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 

. `brew --prefix`/etc/profile.d/z.sh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
bindkey \^U backward-kill-line

ZSH_THEME="mh"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be int2erchangeable.
HYPHEN_INSENSITIVE="true"

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
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git brew)

# Truncate terminal user info to nothing
export PS1="$ ";

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_GB.UTF-8

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

#Setting Python
export PATH="/usr/local/opt/python@3.8/bin:$PATH"
export PYTHONPATH=$PYTHONPATH:.

# Update Go Path
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# added by Snowflake SnowSQL installer
export PATH=/Applications/SnowSQL.app/Contents/MacOS:$PATH

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

# git
alias gac="git add . && git commit --amend --no-edit"
alias gfp='branch="$(git rev-parse --symbolic-full-name --abbrev-ref HEAD)" && git push origin $branch --force-with-lease'
alias gcfp='branch="$(git rev-parse --symbolic-full-name --abbrev-ref HEAD)" && gac && git push origin $branch --force-with-lease'
alias gs="git status"
alias gtp="git pull"
alias ghpr="gh pr create --fill && gh pr view --web"
alias grb='branch=$(git rev-parse --symbolic-full-name --abbrev-ref HEAD) && default_branch=$(git remote show origin | grep "HEAD" | tr -s " " | cut -d " " -f 4) && git checkout $default_branch && git pull && git checkout $branch && git rebase $default_branch'
alias gcm='default_branch=$(git remote show origin | grep "HEAD" | tr -s " " | cut -d " " -f 4) && git checkout $default_branch'

# terraform
alias tf='/usr/local/bin/terraform'
alias tfi='/usr/local/bin/terraform init'
alias tfp='/usr/local/bin/terraform plan'
alias tfpo='/usr/local/bin/terraform plan -out'
alias tfa='/usr/local/bin/terraform apply'
alias tfd='/usr/local/bin/terraform destroy'
alias tfrm='rm -rfv ./.terraform/'
alias tfv='/usr/local/bin/terraform -v'
alias tfwl='/usr/local/bin/terraform workspace list'
alias tfws='/usr/local/bin/terraform workspace select'
alias tfwn='/usr/local/bin/terraform workspace new'
alias tfsl='/usr/local/bin/terraform state list'
alias tfg='/usr/local/bin/terraform get --update'

# AWS
alias lambdas='aws lambda list-functions --region eu-west-1 | jq .Functions | jq ".[].FunctionName"'
alias roles='aws iam list-roles | jq .Roles| jq ".[].RoleName"'

# z
alias zp="z public"
alias p='pwd'

# chrome
alias chrome="/usr/bin/open -a \"/Applications/Google Chrome.app\""
alias gcal="/usr/bin/open -a \"/Applications/Google Chrome.app\" 'https://calendar.google.com/calendar/u/0/r/week'"
alias gmail="/usr/bin/open -a \"/Applications/Google Chrome.app\" 'https://mail.google.com/mail/u/0/#inbox'"
alias youtube="/usr/bin/open -a \"/Applications/Google Chrome.app\" 'https://youtube.com'

# Snowflake env vars
# export SNOWFLAKE_PRIVATE_KEY_PATH="~/.ssh/snowflake-terraform/snowflake_key"
export SNOWFLAKE_PRIVATE_KEY_PATH="~/.ssh/snowsql/rsa_key.p8"
export SNOWSQL_PRIVATE_KEY_PASSPHRASE=
export TF_PLUGIN_CACHE_DIR=/Users/adam.q/.terraform.d/plugin-cache


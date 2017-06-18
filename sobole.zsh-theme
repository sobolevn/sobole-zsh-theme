#
# Sobole ZSH Theme
#
# Author: Nikita Sobolev, github.com/sobolevn
# License: WTFPL
# https://github.com/sobolevn/sobole-zsh-theme

# ----------------------------------------------------------------------------
# PROMPT settings
# These settings changes how your terminal prompt looks like
# ----------------------------------------------------------------------------

if [[ "$USER" == "root" ]]; then
  CARETCOLOR="red"
else
  CARETCOLOR="black"
fi

PROMPT='
$(current_venv)$(user_info)$(current_dir) $(git_prompt_info)
%{$fg[$CARETCOLOR]%}»%{$resetcolor%} '

PROMPT2='%{$fg[$CARETCOLOR]%}.%{$reset_color%} '

RPROMPT='%{$(echotc UP 1)%} $(git_prompt_status) ${_return_status}%{$(echotc DO 1)%}'

local _current_dir="%{$fg_bold[blue]%}%3~%{$reset_color%} "
local _return_status="%(?..%{$fg[red]%}%? ⚡%{$reset_color%})%{$reset_color%}"

function current_dir() {
  # Settings up current directory and settings max width for it:
  local _max_pwd_length="65"
  if [[ $(echo -n $PWD | wc -c) -gt ${_max_pwd_length} ]]; then
    echo "%{$fg_bold[blue]%}%-2~ ... %3~%{$reset_color%} "
  else
    echo "%{$fg_bold[blue]%}%~%{$reset_color%} "
  fi
}

function user_info() {
  if [[ ! -z "$DEFAULT_USER" ]] && [[ "$USER" != "$DEFAULT_USER" ]]; then
    # This only works if `$DEFAULT_USER` is not empty.
    # So, when you log in as other user, using `su` for example,
    # your shell tells you who you are. Otherwise it stays silent.
    # You should set `$DEFAULT_USER` somewhere in your `.zshrc`:
    echo "@$USER "
  fi
}

# ----------------------------------------------------------------------------
# virtualenv settings
# These settings changes how virtualenv is displayed
# ----------------------------------------------------------------------------

# Disable the standard prompt:
export VIRTUAL_ENV_DISABLE_PROMPT=1

function current_venv {
  if [[ ! -z "$VIRTUAL_ENV" ]]; then
    # Show this info only if virtualenv is activated:
    local dir=$(basename "$VIRTUAL_ENV")
    echo "($dir) "
  fi
}

# ----------------------------------------------------------------------------
# Git specific colors and icons
# These settings defines how icons and text is displayed for
#   `git`-related stuff
# ----------------------------------------------------------------------------

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}✚%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}⚑%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✖%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}▴%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[cyan]%}§%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[black]%}⚓%{$reset_color%}"

# ----------------------------------------------------------------------------
# `ls` colors
# Made with: http://geoff.greer.fm/lscolors/
# ----------------------------------------------------------------------------

export LSCOLORS="exfxcxdxBxegedabagacab"
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=1;31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;41"
export CLICOLOR=1

# ----------------------------------------------------------------------------
# `grep` colors and options
# ----------------------------------------------------------------------------

export GREP_COLOR='1;35'
export GREP_OPTIONS='--color=auto'

# ----------------------------------------------------------------------------
# `zstyle` colors
# Internal zsh styles: completions, suggestions, etc
# ----------------------------------------------------------------------------

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:descriptions' format "$fg[yellow]%B--- %d%b%{$reset_color%}"

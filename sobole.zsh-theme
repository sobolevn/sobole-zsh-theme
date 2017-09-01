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
elif [[ "$SOBOLE_THEME_MODE" == "dark" ]]; then
  CARETCOLOR="white"
else
  CARETCOLOR="black"
fi

PROMPT='
$(current_venv)$(user_info)$(current_dir) $(vcs_prompt_info)
$(current_caret) '

PROMPT2='. '

_return_status="%(?..%{$fg[red]%}%? ⚡%{$reset_color%})"

RPROMPT='%{$(echotc UP 1)%} $(vcs_status) ${_return_status}%{$(echotc DO 1)%}'

function current_caret {
  # This function sets caret color and sign
  # based on theme and privileges.
  if [[ "$USER" == "root" ]]; then
    CARET_COLOR="red"
    CARET_SIGN="$"
  else
    CARET_SIGN="»"

    if [[ "$SOBOLE_THEME_MODE" == "dark" ]]; then
      CARET_COLOR="white"
    else
      CARET_COLOR="black"
    fi
  fi

  echo "%{$fg[$CARET_COLOR]%}$CARET_SIGN%{$reset_color%}"
}

function vcs_prompt_info {
  git_prompt_info
}

function vcs_status {
  git_prompt_status
}

function current_dir {
  # Settings up current directory and settings max width for it:
  local _max_pwd_length="65"
  local color

  if [[ "$SOBOLE_THEME_MODE" == "dark" ]]; then
    color="white"
  else
    color="blue"
  fi

  if [[ $(echo -n $PWD | wc -c) -gt ${_max_pwd_length} ]]; then
    echo "%{$fg_bold[$color]%}%-2~ ... %3~%{$reset_color%} "
  else
    echo "%{$fg_bold[$color]%}%~%{$reset_color%} "
  fi
}

function user_info {
  # Shows user in the PROMPT if needed.
  if [[ ! -z "$SOBOLE_DEFAULT_USER" ]] &&
     [[ "$USER" != "$SOBOLE_DEFAULT_USER" ]]; then
    # This only works if `$SOBOLE_DEFAULT_USER` is not empty.
    # So, when you log in as other user, using `su` for example,
    # your shell tells you who you are. Otherwise it stays silent.
    # You should set `$SOBOLE_DEFAULT_USER` somewhere in your `.zshrc`:
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
# VCS specific colors and icons
# These settings defines how icons and text is displayed for
# vcs-related stuff. We support: `git`, `hg` and `svn`
# ----------------------------------------------------------------------------

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[cyan]%}§%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}✚%{$reset_color%}"

ZSH_THEME_SVN_PROMPT_PREFIX="$ZSH_THEME_GIT_PROMPT_PREFIX"
ZSH_THEME_SVN_PROMPT_SUFFIX="$ZSH_THEME_GIT_PROMPT_SUFFIX"
ZSH_THEME_SVN_PROMPT_DIRTY="$ZSH_THEME_GIT_PROMPT_DIRTY"
ZSH_THEME_SVN_PROMPT_CLEAN="$ZSH_THEME_GIT_PROMPT_CLEAN"
ZSH_THEME_SVN_PROMPT_UNMERGED="$ZSH_THEME_GIT_PROMPT_UNMERGED"
ZSH_THEME_SVN_PROMPT_ADDED="$ZSH_THEME_GIT_PROMPT_ADDED"

ZSH_THEME_HG_PROMPT_PREFIX="$ZSH_THEME_GIT_PROMPT_PREFIX"
ZSH_THEME_HG_PROMPT_SUFFIX="$ZSH_THEME_GIT_PROMPT_SUFFIX"
ZSH_THEME_HG_PROMPT_DIRTY="$ZSH_THEME_GIT_PROMPT_DIRTY"
ZSH_THEME_HG_PROMPT_CLEAN="$ZSH_THEME_GIT_PROMPT_CLEAN"
ZSH_THEME_HG_PROMPT_UNMERGED="$ZSH_THEME_GIT_PROMPT_UNMERGED"
ZSH_THEME_HG_PROMPT_ADDED="$ZSH_THEME_GIT_PROMPT_ADDED"

# ----------------------------------------------------------------------------
# `ls` colors
# Made with: http://geoff.greer.fm/lscolors/
# ----------------------------------------------------------------------------

if [[ "$SOBOLE_THEME_MODE" == "dark" ]]; then
  export LSCOLORS="ehfxcxdxbxegedabagacad"
  export LS_COLORS="di=34;47:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
else
  export LSCOLORS="exfxcxdxBxegedabagacab"
  export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=1;31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;41"
fi

export CLICOLOR=1

# ----------------------------------------------------------------------------
# `grep` colors and options
# ----------------------------------------------------------------------------

export GREP_COLOR='1;35'

# ----------------------------------------------------------------------------
# `zstyle` colors
# Internal zsh styles: completions, suggestions, etc
# ----------------------------------------------------------------------------

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:descriptions' format "%B--- %d%b"

# ----------------------------------------------------------------------------
# zsh-syntax-highlighting tweaks
# This setting works only unless `$SOBOLE_DONOTTOUCH_HIGHLIGHTING`
# is set. Any value is fine. Set to `true`, for example.
# Anyway, it will only take effect if `zsh-syntax-highlighting`
# is installed, otherwise it does nothing.
# ----------------------------------------------------------------------------

if [[ -z "$SOBOLE_DONOTTOUCH_HIGHLIGHTING" ]]; then
  typeset -A ZSH_HIGHLIGHT_STYLES

  # Disable strings highlighting:
  ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='none'
  ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='none'

  if [[ "$SOBOLE_THEME_MODE" == "dark" ]]; then
    ZSH_HIGHLIGHT_STYLES[path]='fg=white,underline'
  fi
fi

#
# Sobole ZSH Theme
#
# Author: Nikita Sobolev, github.com/sobolevn
# License: WTFPL
# https://github.com/sobolevn/sobole-zsh-theme

# Testing colors:
#
# for i in {0..255} ; do
#   printf "\x1b[48;5;%sm%3d\e[0m " "$i" "$i"
#   if (( i == 15 )) || (( i > 15 )) && (( (i-15) % 6 == 0 )); then
#     printf "\n";
#   fi
# done

# ----------------------------------------------------------------------------
# PROMPT settings
# These settings changes how your terminal prompt looks like
# ----------------------------------------------------------------------------

PROMPT='$(__sobole::current_venv)$(__sobole::user_info)$(__sobole::current_dir) $(git_prompt_info)
$(__sobole::current_caret) '

PROMPT2='. '

_return_status="%(?..%{$fg[red]%}%? ⚠️%{$reset_color%})"

RPROMPT='%{$(echotc UP 1)%} ${_return_status}%{$(echotc DO 1)%}'

__sobole::current_caret () {
  # This function sets caret color and sign
  # based on theme and privileges.
  if [[ "$USER" == 'root' ]] || [[ "$(id -u "$USER")" == 0 ]]; then
    CARET_COLOR='red'
    CARET_SIGN='#'
  else
    CARET_SIGN='»'

    if [[ "$SOBOLE_THEME_MODE" == 'dark' ]]; then
      CARET_COLOR='white'
    else
      CARET_COLOR='black'
    fi
  fi

  echo "%{$fg[$CARET_COLOR]%}$CARET_SIGN%{$reset_color%}"
}

__sobole::current_dir () {
  # Settings up current directory and settings max width for it:
  local max_pwd_length="${SOBOLE_MAX_DIR_LEN:-65}"
  local color

  if [[ "$SOBOLE_THEME_MODE" == 'dark' ]]; then
    color='white'
  else
    color='blue'
  fi

  if [[ $(echo -n "$PWD" | wc -c) -gt "$max_pwd_length" ]]; then
    echo "%{$fg_bold[$color]%}%-1~ ... %2~%{$reset_color%} "
  else
    echo "%{$fg_bold[$color]%}%~%{$reset_color%} "
  fi
}

__sobole::user_info () {
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
# These settings changes how virtualenv is displayed.
# ----------------------------------------------------------------------------

# Disable the standard prompt:
export VIRTUAL_ENV_DISABLE_PROMPT=1

__sobole::current_venv () {
  # Despite the fact that `_OLD_VIRTUAL_PATH` is undocumented, it is always
  # set in `activate` script. It is needed to fix `vscode` terminal.
  if [[ ! -z "$VIRTUAL_ENV" ]] && [[ ! -z "$_OLD_VIRTUAL_PATH" ]]; then
    # Show this info only if virtualenv is activated:
    local dir=$(basename "$VIRTUAL_ENV")
    echo "($dir) "
  fi
}

# ----------------------------------------------------------------------------
# VCS specific colors and icons
# These settings defines how icons and text is displayed for
# vcs-related stuff. We support only `git`.
# ----------------------------------------------------------------------------

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[cyan]%}§%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}✚%{$reset_color%}"

# ----------------------------------------------------------------------------
# `ls` colors
# Made with: http://geoff.greer.fm/lscolors/
# ----------------------------------------------------------------------------

if [[ "$SOBOLE_THEME_MODE" == 'dark' ]]; then
  export LSCOLORS='gxfxcxdxbxegedabagacad'
  export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
else
  export LSCOLORS='exfxcxdxBxegedabagacab'
  export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=1;31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;41'
fi

# Turns on colors with default unix `ls` command:
export CLICOLOR=1

# ----------------------------------------------------------------------------
# `grep` colors and options
# ----------------------------------------------------------------------------

export GREP_COLORS='mt=1;35'

# ----------------------------------------------------------------------------
# `zstyle` colors
# Internal zsh styles: completions, suggestions, etc
# ----------------------------------------------------------------------------

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'

# ----------------------------------------------------------------------------
# zsh-syntax-highlighting, fzf, and bat tweaks
# This setting works only if `$SOBOLE_SYNTAX_HIGHLIGHTING` is not false.
# Each tool is only modified if installed.
# ----------------------------------------------------------------------------

if [[ "$SOBOLE_SYNTAX_HIGHLIGHTING" != 'false' ]]; then
  typeset -A ZSH_HIGHLIGHT_STYLES

  # Disable strings highlighting:
  ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='none'
  ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='none'

  if [[ "$SOBOLE_THEME_MODE" == 'dark' ]]; then
    ZSH_HIGHLIGHT_STYLES[path]='fg=white,underline'
  fi

  if [[ "$SOBOLE_THEME_MODE" == 'dark' ]]; then
    export SOBOLE_SYNTAX_THEME="${SOBOLE_SYNTAX_THEME_LIGHT:-base16-256}"
  else
    export SOBOLE_SYNTAX_THEME="${SOBOLE_SYNTAX_THEME_LIGHT:-Monokai Extended Light}"
  fi

  # If `bat` is installed, then change the theme for it:
  # https://github.com/sharkdp/bat
  if (( $+commands[bat] )); then
    export BAT_THEME="$SOBOLE_SYNTAX_THEME"
  fi
fi

# ----------------------------------------------------------------------------
# fzf and fzf-tab tweaks.
# See:
# - https://github.com/junegunn/fzf
# - https://github.com/Aloxaf/fzf-tab
# ----------------------------------------------------------------------------

if [[ "$SOBOLE_FZF_THEME" != 'false' ]]; then
  if (( $+commands[fzf] )); then
    # This theme is the same for both light and dark themes:
    export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS
      --color=bg:-1,fg:-1,bg+:#dce7f2,fg+:bright-black
      --color=hl:bright-blue,hl+:blue
      --color=header:green,info:green,pointer:blue
      --color=marker:bright-blue,prompt:black,spinner:blue"

    # fzf-tab theme, setting the default color for suggestions (blue for me)
    # Test all colors: `msgcat --color=test`
    zstyle ':fzf-tab:*' default-color $'\x1b[30m'

    # Matched text highlight
    local fzf_flags
    fzf_flags=( '--color=hl:bright-blue' )
    zstyle ':fzf-tab:*' fzf-flags $fzf_flags
  fi
fi

# ----------------------------------------------------------------------------
# less (and man) colors
# ----------------------------------------------------------------------------

if [[ "$SOBOLE_LESS_THEME" != 'false' ]]; then
  if [[ "$SOBOLE_THEME_MODE" == 'dark' ]]; then
    export LESS_TERMCAP_mb="$(printf '\e[1;35m')"
    export LESS_TERMCAP_md="$(printf '\e[1;35m')"
  else
    export LESS_TERMCAP_mb="$(printf '\e[1;34m')"
    export LESS_TERMCAP_md="$(printf '\e[1;34m')"
  fi
  export LESS_TERMCAP_me="$(printf '\e[0m')"
  export LESS_TERMCAP_se=$(printf '\e[0m')
  export LESS_TERMCAP_so=$(printf '\e[30m')
  export LESS_TERMCAP_ue=$(printf '\e[0m')
  export LESS_TERMCAP_us=$(printf '\e[1;32m')
fi

# ----------------------------------------------------------------------------
# zsh hooks
# ----------------------------------------------------------------------------

_SOBOLE_ADD_LINE_SEPARATOR='false'

__sobole::preexec () {
  if [[ $# -eq 0 ]] || [[ "$2" == 'clear' ]]; then
    _SOBOLE_ADD_LINE_SEPARATOR='false'
  else
    _SOBOLE_ADD_LINE_SEPARATOR='true'
  fi
}

__sobole::precmd () {
  local cmd_result="$?"
  if [[ "$_SOBOLE_ADD_LINE_SEPARATOR" == 'true' ]] ||
     [[ "$cmd_result" -ne 0 ]]; then
    print
  fi
}

autoload -Uz add-zsh-hook
add-zsh-hook preexec __sobole::preexec
add-zsh-hook precmd __sobole::precmd

# SOBOL ZSH Theme

PROMPT='
$(current_venv)${_current_dir} $(git_prompt_info)
%{$fg[$CARETCOLOR]%}»%{$resetcolor%} '

PROMPT2='%{$fg[$CARETCOLOR]%}◀%{$reset_color%} '

RPROMPT='%{$(echotc UP 1)%} $(git_prompt_status) ${_return_status}%{$(echotc DO 1)%}'

local _current_dir="%{$fg_bold[blue]%}%3~%{$reset_color%} "
local _return_status="%(?..%{$fg[red]%}%? ⚡%{$reset_color%})%{$reset_color%}"


function _current_dir() {
  local _max_pwd_length="65"
  if [[ $(echo -n $PWD | wc -c) -gt ${_max_pwd_length} ]]; then
    echo "%{$fg_bold[blue]%}%-2~ ... %3~%{$reset_color%} "
  else
    echo "%{$fg_bold[blue]%}%~%{$reset_color%} "
  fi
}

if [[ $USER == "root" ]]; then
  CARETCOLOR="red"
else
  CARETCOLOR="black"
fi

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

# LS colors, made with http://geoff.greer.fm/lscolors/
export LSCOLORS="exfxcxdxbxegedabagacad"
export GREP_COLOR='1;33'

# virtualenv

export VIRTUAL_ENV_DISABLE_PROMPT=1

function current_venv {
  if [[ ! -z "$VIRTUAL_ENV" ]]; then
    local dir=$(basename "$VIRTUAL_ENV")
    echo "($dir) "
  fi
}

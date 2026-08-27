# :fzf-tab:complete:* --preview-window=+0,wrap
# Default preview for every completion context.
#
# Overrides fzf-tab-source's own sources/--complete.zsh, which runs
# `less ${realpath#-*=}` unconditionally. Candidates that are not paths (options,
# subcommands, parameters) have no $realpath, so less receives an empty argument
# and the preview pane renders blank. Those candidates do carry a description,
# which fzf truncates to the width of the left column, so render it in full here.

local target=${realpath#-*=}

if [[ -n $target && -e $target ]]; then
  less $target
  return
fi

# $desc is the rendered list line: "<word><padding> -- <description>"
local body=''
[[ $desc == *' -- '* ]] && body=${desc#* -- }

print -r -- $'\e[1m'${word}$'\e[0m'
[[ -n $group ]] && print -r -- $'\e[2m'${group}$'\e[0m'
[[ -n $body ]] && { print; print -r -- ${body} }

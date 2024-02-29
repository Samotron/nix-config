
if command -v tmux &>/dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
	exec tmux
fi
export PATH="$HOME/.nix-profile/bin:$PATH"

# sams tools
export PATH="$HOME/Projects/sam/bin:$PATH"
export PATH="$HOME/Projects/common_design_environment/build:$PATH"

# aliases
alias nrepl="clj -M:nREPL -m nrepl.cmdline"

eval "$(direnv hook bash)"

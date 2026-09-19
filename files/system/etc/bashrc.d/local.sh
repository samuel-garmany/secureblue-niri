alias cat=bat
alias ls=eza
alias ll="eza -l"
alias la="eza -la"
alias vim="nvim"

eval "$(starship init bash)"
eval "$(zoxide init --cmd cd bash)"
eval "$(fzf --bash)"

y() {
  local tmp cwd
  tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  command yazi "$@" --cwd-file="$tmp"
  cwd="$(command cat -- "$tmp")"
  if [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && [ -d "$cwd" ]; then
    cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

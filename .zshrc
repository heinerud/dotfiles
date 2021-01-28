# Non default stuff
plugins=(
      git
      fzf
      colored-man-pages
      autojump
      zsh-autosuggestions
      zsh-syntax-highlighting
      zsh-abbr
      )

DEFAULT_USER=`whoami`

### Fix slowness of pastes with zsh-syntax-highlighting.zsh
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
## Fix slowness of pastes

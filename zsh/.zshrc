pokemon-colorscripts -r

############################################
# 0) Speed-up: Powerlevel10k instant prompt
# Keep this at the very top.
############################################
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


############################################
# 1) Oh My Zsh core
############################################
# Path to Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Custom folder (use home-based path, no hardcode)
export ZSH_CUSTOM="${ZSH_CUSTOM:-$ZSH/custom}"

# Theme (Powerlevel10k)
ZSH_THEME="powerlevel10k/powerlevel10k"


############################################
# 2) Plugins
# Keep the list short for speed. Add more only if you use them.
############################################
plugins=(
  asdf
  git
  sudo
  zsh-autosuggestions
  fast-syntax-highlighting
  zsh-autocomplete
  colored-man-pages
  extract
  web-search
)

# Load Oh My Zsh (must come after ZSH, ZSH_THEME, plugins)
source "$ZSH/oh-my-zsh.sh"


############################################
# 3) User preferences
############################################
# tldr pages in Brazilian Portuguese
export TLDR_LANGUAGE=pt_BR

# necessario para rodar o black_hole
export PATH=$HOME/vcpkg:$PATH

# Snapshot com Timeshift 
tsnap() {
  local msg="${*:-manual}"
  sudo timeshift --create --comments "$msg $(date +'%F %T')" --tags O
  sudo timeshift --list | sed -n '1,20p'
}

# Powerlevel10k config (run `p10k configure` to regenerate)
[[ -f "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"

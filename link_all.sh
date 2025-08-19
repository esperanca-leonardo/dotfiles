#!/usr/bin/env bash
set -euo pipefail

log() { printf "[dotfiles] %s\n" "$*"; }

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

backup_if_needed() {
  local target="$1"
  local src="$2"
  if [[ -e "$target" || -L "$target" ]]; then
    # já é link correto?
    if [[ -L "$target" ]]; then
      local curr="$(readlink -f "$target" || true)"
      local src_real="$(readlink -f "$src" || true)"
      if [[ "$curr" == "$src_real" ]]; then
        log "ok: ${target} já aponta para ${src}"
        return 1  # nada a fazer
      fi
    fi
    local ts="$(date +%Y%m%d-%H%M%S)"
    local bak="${target}.bak.${ts}"
    log "backup: movendo ${target} -> ${bak}"
    mv -f -- "$target" "$bak"
  fi
  return 0
}

link_one() {
  local rel_src="$1"
  local target="$2"
  local src="${REPO_DIR}/${rel_src}"

  if [[ ! -f "$src" ]]; then
    log "ERRO: não encontrei origem no repo: ${rel_src}"
    return 1
  fi

  mkdir -p -- "$(dirname "$target")"

  if backup_if_needed "$target" "$src"; then
    :
  else
    return 0  # já estava certo
  fi

  ln -s -- "$src" "$target"
  log "link: ${target} -> ${src}"
}

# ====== MAPEAMENTOS ======
# zsh
link_one "zsh/.zshrc"                "${HOME}/.zshrc"

# neofetch
link_one "neofetch/config.conf"      "${HOME}/.config/neofetch/config.conf"

# htop
link_one "htop/htoprc"               "${HOME}/.config/htop/htoprc"

# kitty
link_one "kitty/kitty.conf"          "${HOME}/.config/kitty/kitty.conf"
link_one "kitty/colors.conf"         "${HOME}/.config/kitty/colors.conf"

# tmux
link_one "tmux/.tmux.conf"           "${HOME}/.tmux.conf"

# hyprland
link_one "hyprland/hyprland.conf"    "${HOME}/.config/hypr/hyprland.conf"
link_one "hyprland/hyprpaper.conf"   "${HOME}/.config/hypr/hyprpaper.conf"

# neovim
link_one "nvim/init.lua"             "${HOME}/.config/nvim/init.lua"

# powerlevel10k
link_one "powerlevel10k/.p10k.zsh"   "${HOME}/.p10k.zsh"


log "✅ pronto! abra um novo terminal (ou recarregue cada app)."


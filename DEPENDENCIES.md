# zsh dependencies

Stowing this package links `~/.zshrc`, `~/.dircolors` and `~/.config/starship.toml`. Install the following first; any `~/.zshrc` that isn't the stowed link (such as the template the Oh My Zsh installer writes) has to be moved aside before stowing (see the commands below).

The prompt comes from starship (`eval "$(starship init zsh)"` at the end of `.zshrc`); no Oh My Zsh theme is loaded (`ZSH_THEME=""`). `~/.config/starship.toml` is starship's pastel-powerline preset with its fixed hex colors swapped for the terminal's 16 ANSI slots (the slot for each segment is listed at the top of the file).

`.zshrc` loads `~/.dircolors` into `LS_COLORS` (used by `ls`, `fd` and completion menus) before Oh My Zsh, so it also replaces colors inherited from a parent shell. `LS_COLORS` and the prompt both use the terminal's 16 ANSI colors rather than fixed ones, so they follow whatever palette pywal16 gives the terminal (the `ghostty` package includes it), and open shells recolor along with it. Without pywal16 they use the terminal's default 16 colors.

## Required

| Dependency | Why | Install docs |
|---|---|---|
| zsh | The shell itself | https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH |
| Oh My Zsh | Framework sourced from `$HOME/.oh-my-zsh` | https://github.com/ohmyzsh/ohmyzsh#basic-installation |
| starship | Draws the prompt; `.zshrc` errors at startup without it | https://starship.rs/guide/#%F0%9F%9A%80-installation |
| zsh-autosuggestions | Listed in `plugins=(...)`; must be cloned into `$ZSH_CUSTOM/plugins` | https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md (source of truth; use the "Oh My Zsh" section) |

Install commands (copied from the linked docs for convenience; if they disagree, the linked docs win):

```sh
# zsh (pick the one for your package manager)
sudo pacman -S zsh          # Arch / CachyOS
sudo apt install zsh        # Debian / Ubuntu
brew install zsh            # macOS

# Oh My Zsh. --keep-zshrc keeps an existing ~/.zshrc; without one, the installer
# writes its template there, which blocks stowing
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc

# Move any ~/.zshrc that isn't the stowed link aside before stowing
[ -f ~/.zshrc ] && [ ! -L ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.pre-dotfiles

# starship (pick one)
sudo pacman -S starship     # Arch / CachyOS
brew install starship       # macOS
curl -sS https://starship.rs/install.sh | sh   # anywhere else

# zsh-autosuggestions plugin, Oh My Zsh method from INSTALL.md.
# Already enabled in plugins=(...) in .zshrc, so only the clone is needed.
git clone https://github.com/zsh-users/zsh-autosuggestions \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"

# Make zsh the login shell (optional)
chsh -s "$(command -v zsh)"
```

## Optional

| Dependency | Why | Install docs |
|---|---|---|
| pywal16 | Sets the terminal palette `LS_COLORS` and the prompt are drawn in. Without it they use the terminal's default 16 colors | https://github.com/eylles/pywal16 |
| A Nerd Font in the terminal | The prompt's powerline separators and its git, language and folder symbols are Nerd Font glyphs; without one they show as boxes. The `ghostty` package sets JetBrainsMono Nerd Font | https://www.nerdfonts.com/font-downloads |
| Bun | `~/.bun/bin` is prepended to `PATH` for Bun's own installer and `bun install -g`; harmless if absent, and not needed when Bun comes from a package manager | https://bun.sh/docs/installation |
| Qt 6 (`qt6-declarative`) | `/usr/lib/qt6/bin` is prepended to `PATH` (Qt's tools, such as `qmlls` and `qmlformat`) and `QML2_IMPORT_PATH` lists the Qt 6 QML module directories, for working on QML / Quickshell configs; harmless if absent | https://doc.qt.io/qt-6/qtqml-index.html |

## Verify

```sh
zsh --version
test -L ~/.zshrc && echo ".zshrc stowed" || echo ".zshrc NOT stowed"
test -L ~/.config/starship.toml && echo "starship.toml stowed" || echo "starship.toml NOT stowed"
test -f ~/.oh-my-zsh/oh-my-zsh.sh && echo "oh-my-zsh ok"
command -v starship >/dev/null && echo "starship ok" || echo "starship MISSING"
test -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" && echo "autosuggestions ok"
```

# provision-linux

Development environment provisioning scripts for setting up a fresh Linux system with essential development tools and shell customizations.

## Overview

This repository contains automation scripts to quickly provision a Linux development environment. The provisioning script is interactive and will prompt you before installing each component, allowing you to customize your setup.

## Installation

### Quick Start

```bash
git clone git@github.com:freshstacks/provision-linux.git
cd provision-linux
make provision
```

### Step-by-Step

1. Clone the repository:
   ```bash
   git clone git@github.com:freshstacks/provision-linux.git
   ```

2. Navigate to the repository:
   ```bash
   cd provision-linux
   ```

3. Run the provision script:
   ```bash
   make provision
   ```
   
   Or directly:
   ```bash
   ./bin/provision.sh
   ```

## Features

The provision script interactively installs the following components (you'll be prompted for each):

### Shell Environment

- **Oh-My-Zsh** - A delightful community-driven framework for managing your Zsh configuration
- **zsh-syntax-highlighting** - Provides syntax highlighting for Zsh commands
- **zsh-autosuggestions** - Suggests commands as you type based on history

### Development Tools

- **NVM (Node Version Manager)** - Easily install and manage multiple Node.js versions
- **Ollama** - Run large language models locally

### Shell Additions

Automatically sources custom shell additions from the `shell-additions/` directory in your `~/.zshrc`:

- **aliases.sh** - Custom aliases that complement oh-my-zsh default aliases (see below)
- **docker-aliases.sh** - Comprehensive Docker and Docker Compose aliases
- **editor.sh** - Sets default editor environment variables (VISUAL/EDITOR)
- **completions.sh** - Bash completion for Makefile targets
- **nvm.sh** - Auto-loads NVM when opening a new shell

> **Note:** The aliases in this repository are designed to complement, not replace, the extensive default aliases provided by oh-my-zsh. The oh-my-zsh aliases will be available once oh-my-zsh is installed.

## Shell Additions Details

### Oh-My-Zsh Default Aliases

When you install oh-my-zsh, you automatically get hundreds of useful aliases. Here are some of the most commonly used ones:

#### Directory Navigation
- `-` - Go to previous working directory
- `...` - Go up two directories (`../..`)
- `....` - Go up three directories (`../../..`)
- `1-9` - Navigate to directories in your directory stack (`cd -1` through `cd -9`)

#### Git Aliases (extensive collection)
- `g` - `git`
- `ga` - `git add`
- `gc` - `git commit --verbose`
- `gco` - `git checkout`
- `gp` - `git push`
- `gl` - `git pull`
- `gst` - `git status`
- `gd` - `git diff`
- `gb` - `git branch`
- `gcb` - `git checkout -b` (create new branch)
- `gcm` - `git checkout $(git_main_branch)` (checkout main/master)
- `gpsup` - `git push --set-upstream origin $(git_current_branch)`
- And many more! (see full list below)

#### General Aliases
- `l`, `ll`, `la`, `lsa` - Enhanced `ls` commands with colors and details
- `md` - `mkdir -p` (create directory with parents)
- `rd` - `rmdir`
- `grep` - Enhanced grep with colors, excluding version control directories
- `history` - oh-my-zsh history function

#### Complete Oh-My-Zsh Git Aliases Reference

Oh-my-zsh includes a comprehensive set of git aliases covering virtually every git operation:

**Branching:**
- `gb`, `gba` (all branches), `gbd` (delete), `gbnm` (not merged), `gbr` (remote branches), `gbg` (gone branches)

**Committing:**
- `gc` (commit), `gca` (commit all), `gcam` (commit all with message), `gcmsg` (commit with message)
- `gca!` (amend commit), `gcans!` (amend with signoff), `gcn!` (amend no-edit)

**Staging:**
- `ga`, `gaa` (add all), `gau` (add updated), `gav` (add verbose), `gapa` (add patch/interactive)

**Checking out:**
- `gco`, `gcb` (checkout new branch), `gcm` (checkout main), `gcd` (checkout develop)

**Pushing/Pulling:**
- `gp`, `gpf` (force with lease), `gpsup` (push and set upstream)
- `gl`, `glg` (pull with log), `ggpull` (pull from origin current branch), `ggpush` (push to origin current branch)

**Merging:**
- `gm`, `gma` (merge abort), `gmc` (merge continue), `gmom` (merge origin main)

**Rebasing:**
- `grb`, `grba` (rebase abort), `grbc` (rebase continue), `grbi` (interactive rebase), `grbm` (rebase main)

**Stashing:**
- `gsta` (stash), `gstaa` (apply), `gstp` (pop), `gstl` (list), `gstd` (drop), `gstc` (clear)

**Status & Diff:**
- `gst`, `gss` (short status), `gd`, `gdca` (diff cached), `gdup` (diff upstream)

**Log:**
- `glog` (oneline graph), `glo` (oneline decorate), `glol` (colored relative time), `glola` (all branches), `glp` (pretty)

**Remote:**
- `gr`, `gra` (add), `grv` (verbose), `grmv` (rename), `grrm` (remove)

**And many more!** For the complete list of all 200+ oh-my-zsh aliases, see the [oh-my-zsh aliases documentation](https://github.com/ohmyzsh/ohmyzsh/wiki/Cheatsheet).

### Custom Aliases (`aliases.sh`)

These aliases complement the oh-my-zsh defaults with additional convenience shortcuts:

- `..` - Navigate up one directory (also available in oh-my-zsh, but kept for consistency)
- `c` - Clear the terminal
- `cu` / `cur` - Open Cursor editor (current/reopen)
- `e` / `er` - Open VS Code (current/reopen)
- `x` - Exit shell

### Docker Aliases (`docker-aliases.sh`)

Comprehensive Docker shortcuts including:
- Container management: `ds` (ps), `dsa` (ps -a), `de` (exec)
- Image management: `di` (images), `drmi` (rmi), `db` (build)
- Docker Compose: `dcu` (up -d), `dcd` (down), `dcb` (build), `dcl` (logs)
- And many more for volumes, networks, and system maintenance

### Editor Configuration (`editor.sh`)

- Sets `VISUAL` and `EDITOR` environment variables to `vim`
- Ensures git and other tools use vim as the default editor

### Completions (`completions.sh`)

- Tab completion for Makefile targets when typing `make`

## Requirements

- Linux-based operating system (Ubuntu, Debian, Fedora, Arch, etc.)
- Bash shell
- `curl` and `git` installed
- `zsh` installed (for Oh-My-Zsh and related features)
- `make` installed (optional, but recommended)

## How It Works

The provisioning script:

1. Checks if components are already installed to avoid duplicates
2. Prompts you for confirmation before each installation
3. Installs components in order:
   - Oh-My-Zsh and plugins
   - NVM
   - Ollama
   - Shell additions configuration in `~/.zshrc`

4. Adds shell additions to your `~/.zshrc` if not already present:
   ```bash
   # Shell Additions by Freshstack
   for f in /path/to/provision-linux/shell-additions/*; do source $f; done
   ```

## Customization

You can customize the shell additions by editing the files in `shell-additions/`:

- Add your own aliases to `aliases.sh` (these will work alongside oh-my-zsh aliases)
- Extend Docker functionality in `docker-aliases.sh`
- Modify editor settings in `editor.sh`
- Add more completions in `completions.sh`
- Modify NVM configuration in `nvm.sh`

After making changes, restart your terminal or run `source ~/.zshrc` to apply them.

**Note about aliases:** If you define an alias that conflicts with an oh-my-zsh alias, your custom alias will take precedence since shell-additions are sourced after oh-my-zsh. To disable specific oh-my-zsh aliases, you can unset them in your `~/.zshrc` file.

## Troubleshooting

### Shell additions not working

If the shell additions aren't being sourced, check that the path in `~/.zshrc` is correct. The script uses an absolute path, so if you move the repository, you'll need to update the path in `~/.zshrc`.

### NVM not found after installation

Make sure to restart your terminal or run `source ~/.zshrc` after installation. The `nvm.sh` file ensures NVM is loaded in new shell sessions.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a pull request.

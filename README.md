# Dotfiles

![Dotfiles Preview](path/to/preview.png) <!-- Optional: Add a screenshot of your setup -->

My personal dotfiles for various programs and tools I use in my development environment. These configurations are optimized for my workflow and may be opinionated.

## Table of Contents

- [About](#about)
- [Installation](#installation)
- [Usage](#usage)
- [Customization](#customization)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgments](#acknowledgments)

## About

This repository contains configuration files for:

- **Shell**: `zsh`/`bash` configuration (`.zshrc`, `.bashrc`)
- **Editor**: `neovim` configuration (`nvim`)
- **Terminal Emulator**: `kitty` configuration
- **Window Manager**: `hypr` configuration
- **Status Bar**: `waybar` configuration
- **Application Launcher**: `wofi` configuration
- **Multiplexer**: `tmux` configuration (`.tmux.conf`)
- **Version Control**: `git` configuration (`.gitconfig`)
- **Other Tools**: Configuration for various CLI tools and utilities

## Installation

### Prerequisites

- `git` - for cloning the repository
- `GNU Stow` - for symlink management (recommended)
- Basic UNIX tools: `make`, `curl`, etc.

### Quick Start

1. Clone the repository:
    ```bash
    git clone https://github.com/your-actual-username/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles

# Requirements
### For [folke/lazy.nvim](https://github.com/folke/lazy.nvim)
- Download [JetBrains Mono Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip)
- Unzip in ```~/.local/share/fonts```
- Run ```fc-cache -f -v```
- Configure your terminal to use the installed font
### For [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- Install [BurntSushi/ripgrep](https://github.com/BurntSushi/ripgrep)
- Install [sharkdp/fd](https://github.com/sharkdp/fd)
### For [jedi-language-server](https://github.com/pappasam/jedi-language-server)
- Install Python 3 venv module with ```sudo apt install python3-venv```
### To paste text copied from Neovim to the system clipboard
- Install xclip with ```sudo apt install xclip```
- Use ```"+y``` to save the selected text to the "+ register
# Instructions
- Install neovim from source (see [instructions](https://github.com/neovim/neovim/blob/master/BUILD.md))
- ```cd``` to ```~/.config```
- ```git clone https://github.com/Cavalleri/nvim```
- Run neovim

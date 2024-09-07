# Git Branch Selector Plugin for Neovim

This Neovim plugin allows you to fetch remote branches, select them from a popup, and create local branches based on the selected remote ones.

## Installation

To install this plugin using [Lazy.nvim](https://github.com/folke/lazy.nvim), add the following to your plugin configuration:

```lua
{
  "tu-usuario/git_branch_selector",
  config = function()
    vim.api.nvim_set_keymap('n', '<leader>gb', ':lua require("git_branch_selector").select_branches()<CR>', { noremap = true, silent = true })
  end
}
```

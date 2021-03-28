# telescope-doc.nvim

A plugin powered by [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) to find the document you want.
Because find a pdf or a html document is long when you have a ton of them.

[Neovim Nightly (0.5)](https://github.com/neovim/neovim/releases/tag/nightly) is required to use this plugin.

## Installation

Using [vim-plug](https://github.com/junegunn/vim-plug)

```viml
Plug 'to268/telescope-doc.nvim'

" Requirements
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
```

Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  'to268/telescope-doc.nvim',
  requires = {{'nvim-telescope/telescope.nvim'}, {'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
}
```

## Usage

This is a sample configuration in viml

```viml
" Base directory (default : project root)
let g:telescope_doc_path = "$HOME/Documents/"
" Pdf viewer (default : $READER or zathura or empty)
let g:telescope_doc_pdf_viewer = "$READER"
" Html viewer (default : xdg-open)
let g:telescope_doc_html_viewer = "xdg-open"

" Fork the viewer process (default : true)
" (available: false, true)
let g:telescope_doc_fork_process = ""
" Open mode to others files in neovim (default : vsplit)
" (available: edit, split, vsplit, tab)
let g:telescope_doc_open_mode = ""

" <leader>d to launch telescope-doc.nvim
nnoremap <silent><leader>d <cmd>call TelescopeDoc()<CR>
```

This is a sample configuration in lua

```lua
require("telescope-doc.nvim").open_file({
    -- Base directory (default : project root)
    cwd = "$HOME/Documents/",
    -- Pdf viewer (default : "$READER" or "zathura" or "")
    pdf_viewer = "$READER",
    -- Html viewer (default : "xdg-open")
    html_viewer = "xdg-open",

    -- Fork the viewer process (default : true)
    -- (available: false, true)
    fork_process = true,
    -- Open mode to others files in neovim (default : "vsplit")
    -- (available: "edit", "split", "vsplit", "tab")
    open_mode = "vsplit"
})
```

## Help

Additional information is available at [:h telescope-doc.txt](doc/telescope-doc.txt)

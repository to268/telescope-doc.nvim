# telescope-doc.nvim

A plugin powered by [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) to find the document you want.
Because find a pdf or a html document is long when you have a ton of them.

Neovim >= 0.5 is required to use this plugin.

## Installation

Using [vim-plug](https://github.com/junegunn/vim-plug)

```viml
Plug 'to268/telescope-doc.nvim'

" Requirements
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/popup.nvim'
```

Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  'to268/telescope-doc.nvim',
  requires = {{'nvim-telescope/telescope.nvim'}, {'nvim-lua/popup.nvim'}}
}
```

## Usage

This is a sample call in viml

```viml
" Base directory (default : project root), with trailing separator
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

This is a sample call in lua

```lua
require("telescope-doc").open_path({
    -- Base directory (default : project root), with trailing separator
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

## Notes for macOS

To be able to use `fork_process=true` on macOS, it is necessary to install `setsid`, which is not part of the OS.
Homebrew users can install it with `brew install utils-linux`.
Because `utils-linux` is not linked by default, make sure `setsid` appears on your `PATH`.
For instance, create a symbolic link using `ln -s /opt/homebrew/opt/utils-linux/bin/setsid ~/.local/bin`.

An example call on macOS might look like
```
:lua require("telescope-doc").open_path({ cwd="$HOME/Documents/", pdf_viewer="open -a Skim", fork_process = true })
```

## Help

Additional information is available at [:h telescope-doc.txt](doc/telescope-doc.txt)

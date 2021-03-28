fun! TelescopeDoc()
    " Line fore test only
    " lua for k in pairs(package.loaded) do if k:match("^telescope%-doc") then package.loaded[k] = nil end end
    lua require("telescope-doc").open()
endfunc

augroup TelescopeDoc
    autocmd!
augroup END

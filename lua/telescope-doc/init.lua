local telescope = require("telescope.builtin")
local actions = require("telescope.actions")
local state = require("telescope.actions.state")
local fopen = require("telescope-doc.open-file")
local vim = vim

local M = {}

local function selection_handler(prompt_bufnr, map, tbl)
    local function item_handler(close)
        -- Get attributes of the selected file
        local file = state.get_selected_entry(prompt_bufnr)

        -- Select the best method to preview the selected file
        tbl.bufnr = prompt_bufnr
        tbl.file = file
        local filetype = fopen.show(tbl)

        -- Need to close telescope ?
        if close and filetype ~= 2 then
            actions.close(prompt_bufnr)
        end
    end

    -- Close telescope when entrer is pressed
    map('i', '<CR>', function()
        item_handler(true)
    end)

end

-- Default Function in vimscript
M.open = function()
    -- Create an empty table
    local tbl = {}
    tbl.cwd = vim.g["telescope_doc_path"]

    -- Set viewers
    tbl.pdf_viewer = vim.g["telescope_doc_pdf_viewer"]
    tbl.html_viewer = vim.g["telescope_doc_html_viewer"]

    -- Set options
    tbl.fork_process = vim.g["telescope_doc_fork_process"]
    tbl.open_mode = vim.g["telescope_doc_open_mode"]

    -- Launch telescope
    telescope.find_files({
        prompt_title = "Select Documentation",
        cwd = tbl.cwd,

        -- Handle file selection proccess
        attach_mappings = function(prompt_bufnr, map)
            selection_handler(prompt_bufnr, map, tbl)

           -- Keep telescope open while a file is not selected
            return true
        end
    })

end

-- Default Function in lua
M.open_path = function(tbl)
    -- Launch telescope
    telescope.find_files({
        prompt_title = "Select Documentation",
        cwd = tbl.cwd,

        -- Handle file selection proccess
        attach_mappings = function(prompt_bufnr, map)
            selection_handler(prompt_bufnr, map, tbl)

           -- Keep telescope open while a file is not selected
            return true
        end
    })

end

return M

local actions = require("telescope.actions")
local Job = require("plenary.job")
local vim = vim

local M = {}

--[[
    table values:
        cwd (path to search):
        pdf_viewer (program to preview a pdf file)
        html_viewer (program to prevew a html file)
        bufnr (telescope item number)
        file (file attributes)

        fork_process (need to fork the viewer)
            values: false, true
            default: true

        open_mode (mode to use when opening a file in neovim)
            values: "edit", "split", "vsplit", "tab"
            default: "vsplit"
--]]

local function initialize_viewers(tbl)
    -- Set pdf reader
    tbl.pdf_viewer = tbl.pdf_viewer or vim.fn.system("echo $READER") or
                vim.fn.system("whereis -b zathura | grep '/.*'") or nil

    -- Set html reader
    tbl.html_viewer = tbl.html_viewer or "xdg-open"

    -- Remove new lines
    tbl.pdf_viewer = string.gsub(tbl.pdf_viewer, "[\r\n]", "")
    tbl.html_viewer = string.gsub(tbl.html_viewer, "[\r\n]", "")
end

--[[
    Default behavior to have when opening a file:
        *.pdf   -> find $READER or try zathura else throw an error
        *.html  -> xdg-open
        *       -> try with neovim

    Return value:
        0       -> html file
        1       -> pdf file
        2       -> other file
--]]
M.show = function(tbl)
    -- Get filename with his path and his extension
    local filename = tbl.file.cwd .. tbl.file.value
    local extension = filename:match("^.+(%..+)$")

    -- Initialize viewers
    initialize_viewers(tbl)

    print(filename)
    if extension == ".html" or extension == ".htm" then
        -- Check if a html viewer is found
        if tbl.html_viewer == nil then error("No html viewer avariable !") end

        -- Execute the command whether fork_process is false or not
        if tbl.fork_process == false then
            Job:new({
                command = tbl.html_viewer,
                args = { filename },
            }):start()
        else
            Job:new({
                command = "setsid -f" .. tbl.html_viewer,
                args = { filename },
            }):start()
        end
        return 0
    elseif extension == ".pdf" then
        -- Check if a pdf viewer is found
        if tbl.pdf_viewer == nil then error("No pdf viewer avariable !") end

        -- Execute the command whether fork_process is false or not
        if tbl.fork_process == false then
            Job:new({
                command = tbl.pdf_viewer,
                args = { filename },
            }):start()
        else
            Job:new({
                command = "setsid -f" .. tbl.pdf_viewer,
                args = { filename },
            }):start()
        end

        return 1
    else
        -- Open the file with the right mode
        if tbl.open_mode == "edit" then
            actions.file_edit(tbl.bufnr)
        elseif tbl.open_mode == "split" then
            actions.file_split(tbl.bufnr)
        elseif tbl.open_mode == "tab" then
            actions.file_tab(tbl.bufnr)
        else
            actions.file_vsplit(tbl.bufnr)
        end
        return 2
    end
end

return M

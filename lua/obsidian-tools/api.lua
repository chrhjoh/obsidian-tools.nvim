---@class ObsidianTools.Api
local M = {}
-- Both selection and prompt
local notes = require("obsidian-tools.notes")
local config = require("obsidian-tools.config").get()

M.new_from_prompt = function()
  vim.ui.input({ prompt = "Enter title for new note" }, function(title)
    if not title and title ~= "" then
      return
    end
    notes.generate_note(title, config.notes)
  end)
end

M.new_from_visual = function()
  local title = require("obsidian-tools.utils").get_visual_selection()
  if title then
    local filestem = notes.generate_note(title, config.notes)
    vim.cmd("s/" .. title .. "/[[" .. filestem .. "|" .. title .. "]]")
  end
end

M.open_in_obsidian = function()
  local file_path = vim.api.nvim_buf_get_name(0)
  local workspace = require("obsidian-tools.workspace").get_current()
  local relative_path = file_path:match(".*/" .. workspace.name .. "/(.*)")

  if relative_path then
    -- Construct the Obsidian URI
    local obsidian_uri = string.format("obsidian://open?vault=%s&file=%s", workspace.name, relative_path)

    -- Open the URI using the default method
    -- For macOS
    os.execute(string.format("open '%s'", obsidian_uri))
    -- For Linux
    -- os.execute(string.format("xdg-open '%s'", obsidian_uri))
    -- For Windows
    -- os.execute(string.format("start '%s'", obsidian_uri))
  else
    print("Current file is not within the specified Obsidian vault.")
  end
end

M.quickswitch = require("obsidian-tools.picker.snacks").quickswitch

local function prepend_to_file(filename, content)
  local file = io.open(filename, "r")
  local original_content = ""

  if file then
    original_content = file:read("*all")
    file:close()
  end

  file = io.open(filename, "w")
  if file then
    file:write(content .. "\n" .. original_content)
    file:close()
  else
    vim.notify("Error: Could not open file for writing.")
  end
end

M.apply_template = function()
  local path = vim.api.nvim_buf_get_name(0)
  vim.ui.input({ prompt = "Title to use for template" }, function(title)
    if not title or title == "" then
      return
    end
    local content = require("obsidian-tools.templates").format_template(title)
    prepend_to_file(path, content)
    vim.cmd("e")
  end)
end

M.select_workspace = require("obsidian-tools.workspace").select_workspace

return M

local function open_in_obsidian()
  -- Get the full path of the current file
  local file_path = vim.api.nvim_buf_get_name(0)

  -- Replace your vault name here
  local vault_name = "YourVaultName"

  -- Extract the relative path of the file within the vault
  local relative_path = file_path:match(".*/" .. vault_name .. "/(.*)")

  if relative_path then
    -- Construct the Obsidian URI
    local obsidian_uri = string.format("obsidian://open?vault=%s&file=%s", vault_name, relative_path)

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

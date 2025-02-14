local M = {}

local relative_date_recursively
---@param ts integer
---@param counter integer
---@param opts ObsidianTools.DailyConfig
---@return string
relative_date_recursively = function(ts, counter, opts)
  if counter == 0 then
    return vim.fn.strftime(opts.date_format, ts)
  end

  ts = ts + (counter > 0 and 86400 or -86400)
  if not (opts.weekday and vim.list_contains({ 1, 7 }, os.date("*t", ts).wday)) then
    counter = counter + (counter > 0 and -1 or 1)
  end
  return relative_date_recursively(ts, counter, opts)
end

---@param days? integer
---@param opts? ObsidianTools.DailyConfig
---@return string
M.relative_date = function(days, opts)
  local ts = vim.fn.localtime()
  opts = vim.tbl_deep_extend("force", require("obsidian-tools.config").get().daily, opts or {})
  days = days or 0
  return relative_date_recursively(ts, days, opts)
end

M.relative_date(1)

return M

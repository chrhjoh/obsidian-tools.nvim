local M = {}

---@param ts integer
---@param counter integer
---@param opts ObsidianTools.DailyConfig
---@return string
M.get_relative_date = function(ts, counter, opts)
  if counter == 0 then
    return vim.fn.strftime(opts.date_format, ts)
  end

  local next_ts = ts + (counter > 0 and 86400 or -86400)
  if not (opts.weekday and vim.list_contains({ 1, 7 }, os.date("*t", next_ts).wday)) then
    counter = counter + (counter > 0 and -1 or 1)
  end
  return M.get_relative_date(next_ts, counter, opts)
end

return M

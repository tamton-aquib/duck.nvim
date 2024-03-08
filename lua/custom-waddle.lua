local M = {}

function M.worming_default(conf)
  local w = require("duck")
  local col_strategy = require("tendency_waddle").new()


  local parent_col_strategy = require("tendency_waddle").new()
  parent_col_strategy.default_setup_for_row(parent_col_strategy)
  parent_col_strategy.sub_strategy = col_strategy.random_waddle(col_strategy)
  w.hatch(conf.character, conf.speed, conf.color, parent_col_strategy.random_waddle(parent_col_strategy))
end

return M

local M = {}

function M.worming_default(conf)
    local w = require("duck")
    local right_strategy = require("right_waddle")

    w.hatch(conf.character, conf.speed, conf.color, right_strategy.random_waddle(right_strategy))
end

return M

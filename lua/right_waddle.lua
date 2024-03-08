local M = {}

function M.get_random()
    -- replace this function if you want to control the random values
    return math.random()
end

function M.sub_strategy(duck)
    local rndstr = require('random_waddle')
    return rndstr.random_waddle(rndstr)(duck)
end

-- this is the default waddlw
function M.random_waddle(self)
    return function(duck)
        local trigger_col = vim.o.columns * 2 / 3 -- if duck is not at 2/3
        if duck.col < trigger_col then
            if self.get_random() > 0.66 then      -- then 1/3 chance to go right
                return { row = duck.row, col = duck.col + 1 }
            end
        end

        local rnd_pos = self.sub_strategy(duck)
        if rnd_pos.col == vim.o.columns then -- do not reach the end of the screen
            rnd_pos.col = duck.col
        end
        return rnd_pos
    end
end

return M

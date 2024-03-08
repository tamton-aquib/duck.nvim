local M = {}

function M.get_random()
    -- replace this function if you want to control the random values
    return math.random()
end

-- this is the default waddlw
function M.random_waddle(self)
    return function(duck)
        local row = duck.row
        local col = duck.col

        local angle = 2 * math.pi * self:get_random()
        local sin = math.sin(angle)
        local cos = math.cos(angle)

        if row < 0 and sin < 0 then
            row = vim.o.lines
        end

        if row > vim.o.lines and sin > 0 then
            row = 0
        end

        if col < 0 and cos < 0 then
            col = vim.o.columns
        end

        if col > vim.o.columns and cos > 0 then
            col = 0
        end

        return { row = row + 0.5 * sin, col = col + 1 * cos }
    end
end

return M

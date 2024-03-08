local L = {}

function L.new()
  local M = {}

  function M.col_or_row(self)
    return {
      comparer = function(duck)
        return duck.col < self.screen_pos_trigger()
      end,
      returner = function(duck)
        return { row = duck.row, col = duck.col + 1 }
      end,
      end_of_screen_returner = function(duck)
        local duck = vim.deepcopy(duck)
        duck.col = duck.col - 1
        return duck
      end,
      end_of_screen_reached = function(duck)
        return duck.col > vim.o.columns - 1
      end
    }
  end

  function M.screen_pos_trigger()
    return vim.o.columns * 2 / 3
  end

  M.probability = 0.66

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
      local global_strategy = self.col_or_row(self)
      if global_strategy.comparer(duck) then
        if self.get_random() > self.probability then -- then 1/3 chance to go right
          return global_strategy.returner(duck)
        end
      end

      local rnd_pos = self.sub_strategy(duck)
      if global_strategy.end_of_screen_reached(duck) then -- do not reach the end of the screen
        rnd_pos = global_strategy.end_of_screen_returner(rnd_pos)
      end
      return rnd_pos
    end
  end

  function M.default_setup_for_row(self)
    self.col_or_row = function()
      return {
        comparer = function(duck)
          return duck.row > self.screen_pos_trigger()
        end,
        returner = function(duck)
          return { row = duck.row - 1, col = duck.col }
        end,
        end_of_screen_reached = function(duck)
          return duck.row < 1
        end,
        end_of_screen_returner = function(duck)
          local duck = vim.deepcopy(duck)
          duck.row = duck.row + 1
          return duck
        end
      }
    end

    self.screen_pos_trigger = function()
      return vim.o.lines * 1 / 3
    end
  end

  return M
end

return L

local M = {}
M.ducks_list = {}
local conf = {
	character="🦆",
	speed=10,
	width=2,
	height=1,
	screensaver = false,
	wait_mins = 1
}

local init_screensaver = function(cfg_tbl)
	local saving_screen = false
	local timer = vim.loop.new_timer()
	local wait_ms = cfg_tbl.wait_mins * 1000 * 60

	vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "ModeChanged", "InsertCharPre" }, {
		callback = function()

			if saving_screen then
				require("duck").cook()
				saving_screen = false
			else
				timer:start(wait_ms, 0, vim.schedule_wrap(function()
					require("duck").hatch(cfg_tbl.character, cfg_tbl.speed)
					saving_screen = true
				end))
			end
		end,
	})
end

-- TODO: a mode to wreck the current buffer?
local waddle = function(duck, speed)
	local timer = vim.loop.new_timer()
	local new_duck = { name = duck, timer = timer }
	table.insert(M.ducks_list, new_duck)

	local waddle_period = 1000 / (speed or conf.speed)
	vim.loop.timer_start(timer, 1000, waddle_period, vim.schedule_wrap(function()
		if vim.api.nvim_win_is_valid(duck) then
			local config = vim.api.nvim_win_get_config(duck)
			local col, row = config["col"][false], config["row"][false]

			math.randomseed(os.time()*duck)
			local movement = math.ceil(math.random()*4)
			if movement == 1 or row <= 0 then
				config["row"] = row + 1
			elseif movement == 2 or row >= vim.o.lines-1 then
				config["row"] = row - 1
			elseif movement == 3 or col <= 0 then
				config["col"] = col + 1
			elseif movement == 4 or col >= vim.o.columns-2 then
				config["col"] = col - 1
			end
			vim.api.nvim_win_set_config(duck, config)
		end
	end))
end

M.hatch = function(character, speed)
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf , 0, 1, true , {character or conf.character})

	local duck = vim.api.nvim_open_win(buf, false, {
		relative='cursor', style='minimal', row=1, col=1, width=conf.width, height=conf.height
	})
	vim.api.nvim_win_set_option(duck, 'winhighlight', 'Normal:Normal')

	waddle(duck, speed)
end

M.cook = function()
	local last_duck = M.ducks_list[#M.ducks_list]

    if not last_duck then
        vim.notify("No ducks to cook!")
        return
    end

	local duck = last_duck['name']
	local timer = last_duck['timer']
	table.remove(M.ducks_list, #M.ducks_list)
	timer:stop()

	vim.api.nvim_win_close(duck, true)
end

M.setup = function(opts)
  conf = vim.tbl_deep_extend('force', conf, opts or {})

	if conf.screensaver then
		init_screensaver(conf)
	end
end

return M 

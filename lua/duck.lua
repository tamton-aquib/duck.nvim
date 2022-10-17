local M = {}
M.ducks_list = {}
local conf = {character="🦆", speed=1, width=2, height=1}

-- TODO: a mode to wreck the current buffer?
local waddle = function(duck)
	local timer = vim.loop.new_timer()
	local new_duck = { name = duck, timer = timer }
	table.insert(M.ducks_list, new_duck)

	local speed = math.abs(100 - conf.speed)
	vim.loop.timer_start(timer, 1000, speed , vim.schedule_wrap(function()
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

M.hatch = function(character)
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf , 0, 1, true , {character or conf.character})

	local duck = vim.api.nvim_open_win(buf, false, {
		relative='cursor', style='minimal', row=1, col=1, width=conf.width, height=conf.height
	})
	vim.api.nvim_win_set_option(duck, 'winhighlight', 'Normal:Normal')

	waddle(duck)
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
end

return M

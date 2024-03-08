# duck.nvim

A duck that waddles between your codes

![Peek 2021-11-18 15-43](https://user-images.githubusercontent.com/77913442/142396581-787616c0-92c9-4ddd-aa15-7bd218f6011b.gif)

> Coding? release the duck. <br />
> bored? release the duck. <br />
> not bored? release the duck. <br />

### Install and Configure

```lua
{
    'tamton-aquib/duck.nvim',
    config = function()
        vim.keymap.set('n', '<leader>dd', function() require("duck").hatch() end, {})
        vim.keymap.set('n', '<leader>dk', function() require("duck").cook() end, {})
        vim.keymap.set('n', '<leader>da', function() require("duck").cook_all() end, {})
    end
}
```

To set custom character:
```lua
nnoremap <leader>dd :lua require("duck").hatch("ඞ")<CR>
```
> popular candidates: 🦆 ඞ  🦀 🐈 🐎 🦖 🐤 

You can also specify how fast a duck moves (measured in steps per second):
```lua
vim.keymap.set('n', '<leader>dd', function() require("duck").hatch("🦆", 10) end, {}) -- A pretty fast duck
vim.keymap.set('n', '<leader>dc', function() require("duck").hatch("🐈", 0.75) end, {}) -- Quite a mellow cat
```

### New position strategies

hatch function support a strategy to pass to override the current one.

for example, the following strategy always push the duck to the right:
```lua
local always_right_strategy = function(positions) -- {col = <val>, row = <val>}
    return {col = positions.col + 1, row = positions.row}
end

require("duck").hatch("🦆", 5, "none", always_right_strategy)
```

> This strategies is available at `require("duck").default_strategies.always_right_strategy`

### Features
- can release multiple ducks.
- does not load on startup.
- Light weight, <100 LOC
- Its a duck
- custom strategies for new position

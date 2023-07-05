# duck.nvim

A duck that waddles between your codes

![Peek 2021-11-18 15-43](https://user-images.githubusercontent.com/77913442/142396581-787616c0-92c9-4ddd-aa15-7bd218f6011b.gif)

> Coding? release the duck. <br />
> bored? release the duck. <br />
> not bored? release the duck. <br />

### Install and Configure

```lua
use {
    'tamton-aquib/duck.nvim',
    config = function()
        vim.keymap.set('n', '<leader>dd', function() require("duck").hatch() end, {})
        vim.keymap.set('n', '<leader>dk', function() require("duck").cook() end, {})
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

### Features
- can release multiple ducks.
- does not load on startup.
- Light weight, <100 LOC
- Its a duck

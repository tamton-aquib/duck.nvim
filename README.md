# duck.nvim

A duck that waddles between your codes

![Peek 2021-11-18 15-43](https://user-images.githubusercontent.com/77913442/142396581-787616c0-92c9-4ddd-aa15-7bd218f6011b.gif)

> Coding? release the duck. <br />
> bored? release the duck. <br />
> not bored? release the duck. <br />

### Install and Configure

```lua
use {
    'tamton-aquib',
    config = function()
        vim.api.nvim_set_keymap('n', '<leader>dd', ':lua require("duck").hatch()<CR>', {noremap=true})
        vim.api.nvim_set_keymap('n', '<leader>dk', ':lua require("duck").cook()<CR>', {noremap=true})
    end
}
```

To set custom character:
```lua
nnoremap <leader>dd :lua require("duck").hatch("ඞ")<CR>
```
> popular candidates: 🦆 ඞ 🐈 🐎 🦖 🐤

### Features
- can release multiple ducks.
- does not load on startup.
- Light weight, approximately 50LOC
- Its a duck

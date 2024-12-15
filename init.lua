local keymaps = {
    {'v', 'J', ":m '>+1<CR>gv=gv", {desc = 'Move selected lines down'}},
    {'v', 'K', ":m '<-2<CR>gv=gv", {desc = 'Move selected lines up'}},
    {{'n', 'v'}, '<Space>', '<Nop>', {desc = 'Disables <Space> in normal and visual modes', silent = true}},
    {'n', '<leader>nd', vim.diagnostic.goto_next, {desc = 'Go to the next diagnostic message'}},
    {'n', '<leader>pd', vim.diagnostic.goto_prev, {desc = 'Go to the previous diagnostic message'}},
}

for _, keymap in pairs(keymaps) do
    -- https://neovim.io/doc/user/lua.html
    vim.keymap.set(unpack(keymap))
end

local options = {
    autoindent = true,
    breakindent = true,
    completeopt = 'menuone,noselect',
    cursorline = true,
    equalalways = true,
    expandtab = true,
    hidden = true,
    hlsearch = false,
    incsearch = true,
    ignorecase = true,
    linebreak = true,
    number = true,
    mouse = '',
    relativenumber = true,
    ruler = true,
    scrolloff = 4,
    signcolumn = 'yes',
    shiftwidth = 4,
    smartcase = true,
    smartindent = true,
    softtabstop = 4,
    splitright = true,
    splitbelow = true,
    statusline = '%<%F %h%m%r%=%(%l/%L, %c%)',
    tabstop = 4,
    termguicolors = true,
    undofile = true,
    wrap = false,
}

for option, value in pairs(options) do
    vim.o[option] = value
end

local keymaps = {
    {"v", "J", ":m '>+1<CR>gv=gv", {desc = "Move selected lines down"}},
    {"v", "K", ":m '<-2<CR>gv=gv", {desc = "Move selected lines up"}},
    {{"n", "v"}, "<Space>", "<Nop>", {desc = "Disables <Space> in normal and visual modes", silent = true}},
    {"n", "<Leader>nd", vim.diagnostic.goto_next, {desc = "Go to the next diagnostic message"}},
    {"n", "<Leader>pd", vim.diagnostic.goto_prev, {desc = "Go to the previous diagnostic message"}},
    {"n", "<Esc>", ":nohlsearch<Enter>", {desc = "To disable search pattern highlight after a search"}},
}

for _, keymap in pairs(keymaps) do
    -- https://neovim.io/doc/user/lua.html
    vim.keymap.set(unpack(keymap))
end

local options = {
    autoindent = true,
    breakindent = true,
    completeopt = "menuone,noselect",
    cursorline = true,
    expandtab = true,
    ignorecase = true,
    incsearch = true,
    laststatus = 3,
    linebreak = true,
    mouse = "",
    number = true,
    relativenumber = true,
    scrolloff = 4,
    shiftwidth = 4,
    smartcase = true,
    smartindent = true,
    softtabstop = -1,
    splitbelow = true,
    splitright = true,
    statusline = "%<%F %h%m%r%=%(%l/%L, %c%)",
    syntax="ON",
    tabstop = 4,
    termguicolors = true,
    undofile = true,
    winheight = 5,
    winminheight = 5,
    winwidth = 5,
    winminwidth = 5,
    wrap = false,
    wrapscan = false,
}

for option, value in pairs(options) do
    vim.o[option] = value
end

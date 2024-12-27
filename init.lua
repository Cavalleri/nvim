-- Lazy nvim bootstrap
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

-- Keymaps
local keymaps = {
    {"v", "J", ":m '>+1<CR>gv=gv", {desc = "Move selected lines down"}},
    {"v", "K", ":m '<-2<CR>gv=gv", {desc = "Move selected lines up"}},
    {{"n", "v"}, "<Space>", "<Nop>", {desc = "Disables <Space> in normal and visual modes", silent = true}},
    {"n", "<Esc>", ":nohlsearch<Enter>", {desc = "To disable search pattern highlight after a search"}},
}

for _, keymap in pairs(keymaps) do
    -- https://neovim.io/doc/user/lua.html
    vim.keymap.set(unpack(keymap))
end

-- Options
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
    tabstop = 4,
    termguicolors = true,
    undofile = true,
    wrap = false,
    wrapscan = false,
}

for option, value in pairs(options) do
    vim.o[option] = value
end

-- Lazy nvim configuration
local lazy_config = {
    -- Even with luarocks disabled, :checkhealth shows warnings
    rocks = {
        enable = false,
        hererocks = false,
    },
    ui = {
        icons = {
            cmd = "⌘",
            config = "🛠",
            event = "📅",
            ft = "📂",
            init = "⚙",
            keys = "🗝",
            plugin = "🔌",
            runtime = "💻",
            require = "🌙",
            source = "📄",
            start = "🚀",
            task = "📌",
            lazy = "💤 ",
        },
    },
}

-- Plugins
local plugins = {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate'
    },
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        config = function()
            vim.cmd.colorscheme('rose-pine')
        end,
    },
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = true,
    },
}

require("lazy").setup(plugins, lazy_config)

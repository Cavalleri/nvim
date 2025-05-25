-- Mini.nvim
local path_package = vim.fn.stdpath('data') .. '/site'

local mini_path = path_package .. '/pack/deps/start/mini.nvim'

if not vim.loop.fs_stat(mini_path) then
	vim.cmd('echo "Installing `mini.nvim`" | redraw')

	local clone_cmd = {
		'git', 'clone', '--filter=blob:none',
		'--branch', 'stable',
		'https://github.com/echasnovski/mini.nvim', mini_path
	}

	vim.fn.system(clone_cmd)
	vim.cmd('packadd mini.nvim | helptags ALL')
end

local mini_plugins = {
	-- Text editing plugins
	ai = {},
	comment = {},
	move = {},
	operators = {},
	pairs = {},
	surround = {},

	-- Appearance plugins
	-- hues = {
	--	background = '#002734',
	--	foreground = '#c0c8cc',
	--	saturation = 'high',
	-- },

	-- Package manager
	deps = {},
}

for plugin, config in pairs(mini_plugins) do
	require('mini.' .. plugin).setup(config)
end


-- Plugins
local plugins = {
	{
		source = 'nvim-treesitter/nvim-treesitter',
		-- hooks = { post_checkout =  function () vim.cmd('TSUpdate') end},
		hooks = {build = ':TSUpdate'}
	},
	{
		source = 'rose-pine/neovim',
		hooks = {name = 'rose-pine'},
	},
}

for _, plugin in ipairs(plugins) do
		require('mini.deps').add(plugin)
end

-- Treesitter
require('nvim-treesitter.configs').setup({
		ensure_installed = {'c', 'python', 'lua', 'vim', 'vimdoc'},
		highlight = {enable = true},
})

-- Rose Pine
require('mini.deps').now(function() vim.cmd('colorscheme rose-pine') end)


-- Keymaps
local keymaps = {
	{{"n", "v"}, "<Space>", "<Nop>", {desc = "Disables <Space> in normal and visual modes", silent = true}},
	{"n", "<Esc>", ":nohlsearch<Enter>", {desc = "Disables search pattern highlight after a search"}},
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
	expandtab = false, -- Use spaces instead of tabs
	ignorecase = true,
	incsearch = true,
	laststatus = 3,
	linebreak = true,
	mouse = "",
	number = true,
	relativenumber = true,
	scrolloff = 4,
	shiftwidth = 4, -- Indentation level
	smartcase = true,
	smartindent = true,
	softtabstop = -1, -- Editor behaviour when inserting or deleting tabs
	splitbelow = true,
	splitright = true,
	statusline = "%<%F %h%m%r%=%(%l/%L, %c%)",
	tabstop = 4, -- Tab width
	termguicolors = true,
	undofile = true,
	wrap = false,
	wrapscan = false,
}

for option, value in pairs(options) do
	vim.o[option] = value
end

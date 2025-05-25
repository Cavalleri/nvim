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
	ai = {},
	comment = {},
	move = {},
	operators = {},
	pairs = {},
	surround = {},
}

for plugin, config in pairs(mini_plugins) do
	require('mini.' .. plugin).setup(config)
end

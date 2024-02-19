require('globals')

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable',
		lazypath,
	}
end

vim.opt.rtp:prepend(lazypath)

vim.cmd [[let g:loaded_python3_provider = 0]]
vim.cmd [[let g:loaded_perl_provider = 0]]
vim.cmd [[let g:loaded_node_provider = 0]]

-- Try to load a ./.nvim.lua if it exists in the project dir...
-- I am using this to map <F5> to my cpp build scripts right now
local project_config = vim.fn.expand('%:p:h') .. '/.nvim.lua'
if vim.fn.filereadable(project_config) == 1 then
	vim.print(project_config)
	vim.cmd('luafile ' .. project_config)
end

require('lazy').setup("plugins", {})

require('ui')
require('misc')

require('keymaps')
require('formatting')
require('lsp')
require('linting')
require('dap_cfg')
require('largefile')

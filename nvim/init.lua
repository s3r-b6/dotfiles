vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.number = true
vim.opt.hidden = true
vim.opt.hlsearch = false
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.numberwidth = 4
vim.g.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeout = true
vim.opt.timeoutlen = 300
vim.opt.completeopt = 'menuone,noselect'
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.sidescroll = 1
vim.opt.sidescrolloff = 8
vim.opt.wrap = false
vim.opt.whichwrap = 'lh'
vim.cmd('filetype plugin on')
vim.cmd('set guicursor=n-v-c-sm-i:block,ci-ve:ver25,r-cr-o:hor20')
vim.cmd([[
let g:LanguageClient_serverCommands = {
      \ 'c': ['C:\Program Files (x86)\mingw64\bin'],
      \ 'cpp': ['C:\Program Files (x86)\mingw64\bin'],
      \ }]])
vim.cmd([[let g:LanguageClient_autoStart = 1]])

vim.diagnostic.config({ severity_sort = true })
vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }

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

require('lazy').setup("plugins", {})
require('setup_plugins').setup_plugins()
require('keymaps').setup_keys()

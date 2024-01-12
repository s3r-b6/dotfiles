vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.coq_settings = {
	clients = {
		lsp = {
			enabled = true,
			weight_adjust = 2,
		},
		tree_sitter = {
			enabled = true,
			weight_adjust = 1,
		},
	},
	auto_start = 'shut-up',
	keymap = {
		recommended = false,
		bigger_preview = '',
	}
}
vim.opt.number = true
vim.opt.hidden = true
vim.opt.hlsearch = false
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.numberwidth = 4

vim.bo.tabstop = 4
vim.bo.ts = vim.bo.tabstop

vim.bo.shiftwidth = 4
vim.bo.sw = vim.bo.shiftwidth

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
vim.opt.completeopt = 'menuone,noselect,noinsert'
vim.opt.termguicolors = true
vim.opt.sidescroll = 1
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.tabstop = 4
vim.opt.wrap = false
vim.o.guicursor = 'n-i-v-c-sm:block,ci-ve:ver25,r-cr-o:hor20'
vim.diagnostic.config({ severity_sort = true })

-- Leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Appearance
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 4
vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true
vim.wo.signcolumn = "yes:2"

-- Editing
vim.opt.hidden = true
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.wrap = false

-- Indentation
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.opt.tabstop = 4

-- Search
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Performance
vim.opt.updatetime = 250
vim.opt.timeout = true
vim.opt.timeoutlen = 300

-- Scrolling
vim.opt.sidescroll = 1
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Completion
vim.opt.completeopt = 'menuone,noselect,noinsert'

-- Cursor
vim.o.guicursor = 'n-i-v-c-sm:block,ci-ve:ver25,r-cr-o:hor20'

-- Diagnostic configuration
vim.diagnostic.config({
	float = {
		border = "rounded",
		header = "",
		prefix = "",
	},
	severity_sort = true,
	signs = true,
	underline = { severity = vim.diagnostic.severity.ERROR },
	update_in_insert = true,
})

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Bazel
vim.g.bazel_cmd = "bzl"
vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }

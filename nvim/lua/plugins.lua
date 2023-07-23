return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function() vim.cmd.colorscheme 'catppuccin-mocha' end,
	},
	{ "brenoprata10/nvim-highlight-colors" },
	{ 'lunarwatcher/auto-pairs' },
	{ "kdheepak/lazygit.nvim",             dependencies = { "nvim-lua/plenary.nvim", } },
	{ 'unblevable/quick-scope' },
	{ 'mbbill/undotree' },
	{ 'tpope/vim-surround' },
	{ 'tpope/vim-repeat' },
	{ 'nacro90/numb.nvim',                 event = 'bufread', },
	{ 'mhartington/formatter.nvim' },
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			{ 'williamboman/mason.nvim', config = true },
			'williamboman/mason-lspconfig.nvim',
			{ 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },
			'folke/neodev.nvim',
		},
	},
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'l3mon4d3/luasnip',
			'saadparwaiz1/cmp_luasnip',
			'hrsh7th/cmp-nvim-lsp',
			'rafamadriz/friendly-snippets',
		},
	},
	{ 'folke/which-key.nvim',    opts = { plugins = { registers = true } } },
	{
		'lewis6991/gitsigns.nvim',
		opts = {
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},
			on_attach = function(bufnr)
				vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
					{ buffer = bufnr, desc = '[g]o to [p]revious hunk' })
				vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk,
					{ buffer = bufnr, desc = '[g]o to [n]ext hunk' })
				vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk,
					{ buffer = bufnr, desc = '[p]review [h]unk' })
			end,
		},
	},
	{
		'nvim-lualine/lualine.nvim',
		opts = {
			options = {
				icons_enabled = false,
				theme = 'onedark',
				component_separators = '|',
				section_separators = '',
			},
		},
	},
	{
		'lukas-reineke/indent-blankline.nvim',
		opts = { show_trailing_blankline_indent = false, },
	},
	{
		'nvim-tree/nvim-tree.lua',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		opts = {
			disable_netrw = true,
			sort_by = "case_sensitive",
			view = { width = 30, },
			renderer = { group_empty = true, },
			filters = { dotfiles = true, },
		},
	},
	{ 'ahmedkhalf/project.nvim', },
	{
		'rrethy/vim-illuminate',
		config = function()
			require('illuminate').configure({
				{
					providers = { 'lsp', 'treesitter', 'regex', },
					delay = 100,
					filetype_overrides = {},
					filetypes_denylist = { 'dirvish', 'fugitive', },
					filetypes_allowlist = {},
					modes_denylist = {},
					modes_allowlist = {},
					providers_regex_syntax_denylist = {},
					providers_regex_syntax_allowlist = {},
					under_cursor = true,
					large_file_cutoff = 2000,
					large_file_overrides = nil,
					min_count_to_highlight = 1,
				}
			})
		end
	},
	{ 'numtostr/comment.nvim',         opts = {} },
	{ 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		build = 'make',
		cond = function()
			return vim.fn.executable 'make' == 1
		end,
	},
	{
		'nvim-treesitter/nvim-treesitter',
		dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects', },
		build = ':tsupdate',
	},
}

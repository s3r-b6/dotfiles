return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function() vim.cmd.colorscheme 'catppuccin-mocha' end,
	},
	{ 'akinsho/toggleterm.nvim',           version = "*",                              config = true },
	{ "brenoprata10/nvim-highlight-colors" },
	{ "kdheepak/lazygit.nvim",             dependencies = { "nvim-lua/plenary.nvim", } },
	{ 'unblevable/quick-scope' },
	{ 'mbbill/undotree' },
	{ 'tpope/vim-surround' },
	{ 'kosayoda/nvim-lightbulb' },
	{ 'tpope/vim-repeat' },
	{ 'nacro90/numb.nvim',                 event = 'bufread', },
	{ 'mhartington/formatter.nvim' },
	{
		'stevearc/oil.nvim',
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" }
	},
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
		'ms-jpq/coq_nvim',
		branch = 'coq',
		dependencies = {
			{ 'ms-jpq/coq.artifacts' },
			{ 'ms-jpq/coq.thirdparty' },
		},
	},
	{ 'folke/which-key.nvim', opts = { plugins = { registers = true } } },
	{ 'tpope/vim-sleuth' },
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
		main = "ibl",
		opts = {},
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
	{ "mfussenegger/nvim-jdtls" },
	{ "David-Kunz/gen.nvim" }
}

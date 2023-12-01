return {
	-- Telescope
	{
		'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		build = 'make',
		cond = function()
			return vim.fn.executable 'make' == 1
		end,
	},
	{ 'ahmedkhalf/project.nvim', },

	-- Treesitter
	{ 'nvim-treesitter/nvim-treesitter', dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' } },

	-- LSP / Formatting / Autocomplete
	{ 'mhartington/formatter.nvim', },
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
	{ "mfussenegger/nvim-jdtls", event = "VeryLazy", },
	-- DAP
	{
		'mfussenegger/nvim-dap',
		dependencies = {
			'jay-babu/mason-nvim-dap.nvim',
			'mfussenegger/nvim-dap',
			'williamboman/mason.nvim',
			'rcarriga/nvim-dap-ui',
			'theHamsta/nvim-dap-virtual-text',
		},
		event = "VeryLazy",
	},

	-- Useful
	{ 'tpope/vim-surround',      event = "VeryLazy" },
	{ 'tpope/vim-sleuth', },
	{ 'tpope/vim-repeat',        event = "VeryLazy" },
	{ 'mbbill/undotree',         event = "VeryLazy" },
	{ 'unblevable/quick-scope',  event = "VeryLazy" },
	{ 'numtostr/comment.nvim',   opts = {},                                   event = "VeryLazy" },
	{ 'folke/which-key.nvim',    opts = { plugins = { registers = true } } },
	{ 'rrethy/vim-illuminate', },

	-- Git things
	{ "kdheepak/lazygit.nvim",   dependencies = { "nvim-lua/plenary.nvim", }, event = "VeryLazy" },
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
				vim.keymap.set('n', '[g', require('gitsigns').prev_hunk,
					{ buffer = bufnr, desc = 'Previous hunk' })
				vim.keymap.set('n', ']g', require('gitsigns').next_hunk,
					{ buffer = bufnr, desc = 'Next hunk' })
				vim.keymap.set('n', '<leader>h', require('gitsigns').preview_hunk,
					{ buffer = bufnr, desc = 'preview [h]unk' })
			end,
		},
	},

	-- Pretty
	-- nvim-tree/nvim-web-devicons
	{
		"catppuccin/nvim", name = "catppuccin", config = function() vim.cmd.colorscheme 'catppuccin-mocha' end,
	},
	{ 'lukas-reineke/indent-blankline.nvim', main = "ibl", opts = {}, },
	{ 'kosayoda/nvim-lightbulb' },
	{
		'nvim-lualine/lualine.nvim',
		opts = {
			options = {
				icons_enabled = false,
				theme = 'nightfly',
				component_separators = '|',
				section_separators = '',
			},
		},
	},

	-- Testing this, will see if it stays
	{ "David-Kunz/gen.nvim", event = "VeryLazy", },
}

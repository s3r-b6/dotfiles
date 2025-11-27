return {

	-- File management
	{
		'stevearc/oil.nvim',
		event = 'VeryLazy',
		opts = { columns = { "icon", "mtime", } },
		dependencies = { { 'echasnovski/mini.icons', opts = {} } },
	},

	-- Utility plugins
	{ 'tpope/vim-surround', event = 'VeryLazy' },
	{ 'tpope/vim-sleuth', },
	{ 'tpope/vim-repeat',   event = 'VeryLazy' },
	{ 'mbbill/undotree',    event = 'VeryLazy' },
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"<leader>?",
				function() require("which-key").show({ global = false }) end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},

	-- Comments and todos
	{
		'folke/todo-comments.nvim',
		event = { "BufReadPost", "BufNewFile" },
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			require("todo-comments").setup({ columns = { "icon", "mtime", }, })
		end
	},

	-- Git integration
	{
		'lewis6991/gitsigns.nvim',
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			watch_gitdir = {
				interval = 0,
				follow_files = false,
			},
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},
		},
		config = function(_, opts)
			local gitsigns = require("gitsigns")
			gitsigns.setup(opts)

			local group = vim.api.nvim_create_augroup("GitsignsRefresh", { clear = true })
			vim.api.nvim_create_autocmd("InsertLeave", { group = group, callback = gitsigns.refresh })
			vim.api.nvim_create_autocmd("BufWritePost", { group = group, callback = gitsigns.refresh })
			vim.api.nvim_create_autocmd("BufEnter", { group = group, callback = gitsigns.refresh })
			vim.api.nvim_create_autocmd("FocusGained", { group = group, callback = gitsigns.refresh })
		end,
	},
	{
		'f-person/git-blame.nvim',
		event = 'VeryLazy',
		opts = {
			enabled = false,
			message_template = ' <summary> • <date> • <author> ',
			date_format = '%m-%d-%Y',
			virtual_text_column = math.floor(vim.api.nvim_win_get_width(0) * 0.45),
		},
	},
	{
		'NeogitOrg/neogit',
		event = 'VeryLazy',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'sindrets/diffview.nvim',
		},
		config = function()
			require("diffview").setup({})
		end
	},

	{ -- Incremental rename
		"smjonas/inc-rename.nvim",
		event = 'VeryLazy',
		opts = { input_buffer_type = "snacks", }
	},
}

return {
	-- Colorscheme
	{
		'catppuccin/nvim',
		name = 'catppuccin',
		priority = 1000,
		config = function()
			require('catppuccin').setup({
				integrations = {
					gitsigns = true,
					treesitter = true,
					snacks = true,
					which_key = true,
				}
			})
			vim.cmd.colorscheme "catppuccin"
		end
	},

	-- Status line
	{
		'nvim-lualine/lualine.nvim',
		event = 'VeryLazy',
		config = function()
			require('lualine').setup {
				options = {
					icons_enabled = false,
					theme = "catppuccin",
					component_separators = '|',
					section_separators = '',
				},
				extensions = {
					'quickfix',
					'oil',
					'mason',
					'lazy',
				}
			}
		end
	},

	-- Visual enhancements
	-- {
	-- 	'lukas-reineke/indent-blankline.nvim',
	-- 	main = 'ibl',
	-- 	config = function()
	-- 		require('ibl').setup({ scope = { enabled = false } })
	-- 	end
	-- },
	{
		'kosayoda/nvim-lightbulb',
		event = 'VeryLazy',
		config = function()
			require('nvim-lightbulb').setup({ autocmd = { enabled = true } })
		end
	},
	{
		'rrethy/vim-illuminate',
		event = 'VeryLazy',
		config = function()
			require('illuminate').configure({
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
			})
		end
	},
	{ 'unblevable/quick-scope', event = 'VeryLazy' },

	-- Snacks.nvim for UI components and picker
	{
		'folke/snacks.nvim',
		priority = 1000,
		lazy = false,
		keys = {
		},
		opts = {
			styles = {
				scratch = {
					width = 150,
					height = 40,
					bo = { buftype = "", buflisted = false, bufhidden = "hide", swapfile = false },
					minimal = false,
					noautocmd = false,
					zindex = 20,
					wo = { winhighlight = "NormalFloat:Normal" },
					footer_keys = true,
					border = true,
				},
			},

			statuscolumn = { enabled = true },
			quickfile = { enabled = true },
			dashboard = { enabled = true, },
			bigfile = { enabled = true },
			words = { enabled = true },
			quick = { enabled = true },
			input = { enabled = true },
			dim = { enabled = true },
			scratch = { enabled = true },
			indent = {
				enabled = true,
				only_scope = true,
				animate = { enabled = false, },
				scope = { enabled = true, }
			},
			picker = {
				enabled = true,
				layout = {
					preset = 'ivy',
					layout = { height = 0.6, }
				},
				ui_select = true,
				formatters = {
					file = {
						filename_first = true,
						filename_only = false,
						truncate = 50,
					},
				},
				sources = {
					files = {
						hidden = false,
						follow_symlinks = true,
						exclude = {
							'.git', '.yarncache', '.pnpm-store', '.venv', 'venv',
							'__pycache__', '.ruff_cache', 'node_modules',
							"bazel-bin", "bazel-dd-source", "bazel-out", "bazel-testlogs",
							'**/*.pyc', '**/*.snap', '**/*.pb.go',
							'**/*.pb.validate.go', '**/.DS_STORE',
						}
					},
					grep = {
						multiline = true,
						max_results = 1000,
						context = { before = 2, after = 2 },
						exclude = {
							'.git', '.yarncache', '.pnpm-store', '.venv', 'venv',
							'__pycache__', '.ruff_cache', 'node_modules',
							"bazel-bin", "bazel-dd-source", "bazel-out", "bazel-testlogs",
							'**/*.pyc', '**/*.snap', '**/*.pb.go',
							'**/*.pb.validate.go', '**/.DS_STORE',
						}
					},
				},
				filter = {
					default_hidden = false,
				},
				performance = {
					max_results = 1000,
					debounce = 20,
					prefilter_threshold = 1000,
					async_threshold = 100,
				},
			},
		},
	},

	-- Notifications
	{
		'folke/noice.nvim',
		event = 'VeryLazy',
		opts = {
			lsp = {
				override = {
					['vim.lsp.util.convert_input_to_markdown_lines'] = true,
					['vim.lsp.util.stylize_markdown'] = true,
					-- ['cmp.entry.get_documentation'] = true,
				},
			},
			presets = {
				command_palette = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = true,
			},
		},
		dependencies = {
			'MunifTanjim/nui.nvim',
			'rcarriga/nvim-notify',
		}
	},
	{
		'mcauley-penney/visual-whitespace.nvim',
		config = true,
		event = "VeryLazy",
		opts = {},
	},
	{
		'pwntester/octo.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'folke/snacks.nvim',
			'nvim-tree/nvim-web-devicons',
		},
		config = function()
			require "octo".setup({
				use_local_fs = true,
				picker = "snacks",
			})
		end
	},
	{
		"OXY2DEV/markview.nvim",
		lazy = false,
	}
}

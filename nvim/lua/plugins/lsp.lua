return {
	-- Treesitter
	{
		'nvim-treesitter/nvim-treesitter',
		dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
		config = function()
			require('nvim-treesitter.configs').setup {
				ensure_installed = { 'go', 'lua', 'vimdoc', 'vim', },
				auto_install = false,
				highlight = { enable = true },
				indent = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						node_incremental = '<leader>v',
						node_decremental = '<leader>V',
					},
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							['aa'] = '@parameter.outer',
							['ia'] = '@parameter.inner',
							['af'] = '@function.outer',
							['if'] = '@function.inner',
							['ac'] = '@class.outer',
							['ic'] = '@class.inner',
						},
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							[']f'] = '@function.outer',
							[']]'] = '@class.outer',
						},
						goto_next_end = {
							[']F'] = '@function.outer',
							[']['] = '@class.outer',
						},
						goto_previous_start = {
							['[f'] = '@function.outer',
							['[['] = '@class.outer',
						},
						goto_previous_end = {
							['[F'] = '@function.outer',
							['[]'] = '@class.outer',
						},
					},
					swap = {
						enable = true,
						swap_next = {
							['<leader>a'] = '@parameter.inner',
						},
						swap_previous = {
							['<leader>A'] = '@parameter.inner',
						},
					},
				},
			}
		end
	},

	-- LSP Configuration
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			{ 'williamboman/mason.nvim', config = true },
			'williamboman/mason-lspconfig.nvim',
			'folke/neodev.nvim',
		},
		config = function()
			require('neodev').setup()
			require('mason').setup()

			local on_attach = function(client, bufnr)
				local utils = require('config.utils')
				local nmap = utils.nmap
				local vmap = utils.vmap
				local imap = utils.imap

				nmap('K', require('noice.lsp').hover,
					{ desc = 'Hover Documentation' })
				nmap('<leader>lr', ':IncRename ',
					{ desc = '[R]ename', noremap = true })
				nmap('<leader>la', vim.lsp.buf.code_action,
					{ desc = 'Code [A]ction', noremap = true })
				vmap('<leader>la', vim.lsp.buf.code_action,
					{ desc = 'Code [A]ction', noremap = true })
				nmap('<leader>D', vim.lsp.buf.type_definition,
					{ desc = 'Type [D]efinition', noremap = true })
				nmap('gd', function() Snacks.picker.lsp_definitions() end,
					{ desc = '[G]oto [D]efinition', noremap = true })
				nmap('gr', function() Snacks.picker.lsp_references() end,
					{ desc = '[G]oto [R]eferences', noremap = true })
				nmap('gi', function() Snacks.picker.lsp_implementations() end,
					{ desc = '[G]oto [I]mplementation', noremap = true })
				nmap('<leader>ds', function() Snacks.picker.lsp_symbols() end,
					{ desc = '[D]ocument [S]ymbols', noremap = true })
			end


			vim.lsp.config('gopls', {
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
				name = "gopls",
				on_attach = on_attach,
				settings = {
					gopls = {
						ui = {
							codelenses = {
								generate = false,
								test = false,
								tidy = false,
								upgrade_dependency = false,
								vendor = false
							},
							completion = {
								usePlaceholders = true,
							},
						},
						build = {
							directoryFilters = {
								"-**/bazel-bin",
								"-**/bazel-dd-source",
								"-**/bazel-out",
								"-**/bazel-testlogs",
							},
						},
						analyses = {
							unusedparams = true,
							unreachable  = true,
						},
						staticcheck = true,
						gofumpt = true,
					}
				}
			})
			vim.lsp.enable('gopls')

			local servers = {
				'lua_ls',
				'jsonls',
				'yamlls',
				'zls',
			}

			for _, server in ipairs(servers) do
				vim.lsp.config(server, { on_attach = on_attach })
			end

			require('mason-lspconfig').setup({
				ensure_installed = servers,
			})
		end
	},

	-- Go-specific tools
	-- {
	-- 	'crispgm/nvim-go',
	-- 	config = function()
	-- 		require('go').setup({
	-- 			maintain_cursor_pos = true,
	-- 			lint_prompt_style = 'qf',
	-- 			auto_format = false,
	-- 			auto_lint = false,
	-- 		})
	-- 	end
	-- },

	-- Linting
	{
		'mfussenegger/nvim-lint',
		event = 'VeryLazy',
	},

	-- Schema validation
	{
		'b0o/SchemaStore.nvim',
		lazy = true,
	},
}

local function setup_plugins()
	local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
	vim.api.nvim_create_autocmd('TextYankPost', {
		callback = function()
			vim.highlight.on_yank()
		end,
		group = highlight_group,
		pattern = '*',
	})
	require('nvim-highlight-colors').setup {}

	require('numb').setup {
		show_numbers = true,
		show_cursorline = true,
		hide_relativenumbers = true,
		number_only = false,
		centered_peeking = true,
	}

	require('lsp/java_cfg')

	require("nvim-lightbulb").setup({
		autocmd = { enabled = true }
	})

	require('project_nvim').setup {
		manual_mode = false,
		detection_methods = { "lsp", "pattern" },
		patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
		ignore_lsp = {},
		exclude_dirs = {},
		show_hidden = false,
		silent_chdir = true,
		scope_chdir = 'global',
		datapath = vim.fn.stdpath("data"),
	}

	local actions = require "telescope.actions"
	require('telescope').setup {
		defaults = {
			mappings = {
				i = {
					['<C-k>'] = actions.move_selection_previous,
					['<C-j>'] = actions.move_selection_next,
					["<C-u>"] = actions.preview_scrolling_up,
					["<C-d>"] = actions.preview_scrolling_down,
				},
			},
		},
	}

	pcall(require('telescope').load_extension, 'fzf')
	pcall(require('telescope').load_extension, 'projects')

	local util = require 'formatter.util'

	local mason_bin = "C:\\Users\\Sergio\\AppData\\Local\\nvim-data\\mason\\bin\\"
	-- TODO: ésto no funciona en windows por alguna misteriosa razón
	local formatter_settings = {
		html = { function()
			return {
				exe = mason_bin .. "prettier",
				args = { util.escape_path(util.get_current_buffer_file_path()), },
				stdin = true
			}
		end,
		},
		css = { function()
			return {
				exe = mason_bin .. "prettier",
				args = { util.escape_path(util.get_current_buffer_file_path()), },
				stdin = true
			}
		end,
		},
		json = { function()
			return {
				exe = mason_bin .. "fixjson",
				args = { util.escape_path(util.get_current_buffer_file_path()), },
				stdin = true
			}
		end
		},
		python = { function()
			return {
				cwd = mason_bin,
				exe = "black",
				args = { util.escape_path(util.get_current_buffer_file_path()), },
				stdin = false
			}
		end,
		},
		["*"] = {
			require("formatter.filetypes.any").remove_trailing_whitespace
		}
	}

	require('ibl').setup({ scope = { enabled = false } })

	require('formatter').setup {
		logging = true,
		log_level = vim.log.levels.WARN,
		filetype = formatter_settings,
	}

	vim.keymap.set("n", "<leader>lf", function()
			if formatter_settings[vim.bo.filetype] ~= nil then
				-- vim.cmd('write')
				vim.cmd([[Format]])
			else
				vim.lsp.buf.format()
			end
		end,
		{ desc = "Format the current buffer. Use formatter.nvim, if possible, else, try LSP formatting" })


	---@diagnostic disable-next-line: missing-fields
	require('nvim-treesitter.configs').setup {
		ensure_installed = {
			'c', 'cpp', 'go', 'lua', 'python', 'rust',
			'tsx', 'typescript', 'vimdoc', 'vim', 'ocaml',
			'java'
		},

		auto_install = true,

		highlight = { enable = true },
		indent = { enable = true },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = '<c-space>',
				node_incremental = '<c-space>',
				scope_incremental = '<c-s>',
				node_decremental = '<M-space>',
			},
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
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
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					[']m'] = '@function.outer',
					[']]'] = '@class.outer',
				},
				goto_next_end = {
					[']M'] = '@function.outer',
					[']['] = '@class.outer',
				},
				goto_previous_start = {
					['[m'] = '@function.outer',
					['[['] = '@class.outer',
				},
				goto_previous_end = {
					['[M'] = '@function.outer',
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

	local servers = {
		gopls = {},
		rust_analyzer = {},
		tsserver = {},
		lua_ls = {
			Lua = {
				workspace = { checkThirdParty = false },
				telemetry = { enable = false },
			},
		},
		jdtls = {},
	}


	local cmp = require 'cmp'
	cmp.setup({
		snippet = {
			expand = function(args)
				require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
				-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
				-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
				-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			end,
		},
		window = {
			--	completion = cmp.config.window.bordered(),
			--	documentation = cmp.config.window.bordered(),
		},
		mapping = cmp.mapping.preset.insert({
			['<C-j>'] = cmp.mapping.select_next_item(),
			['<C-k>'] = cmp.mapping.select_prev_item(),
			['<C-b>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			['<C-Space>'] = cmp.mapping.complete(),
			['<C-e>'] = cmp.mapping.abort(),
			['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		}),
		sources = cmp.config.sources({
			{ name = 'nvim_lsp' },
			{ name = 'vsnip' },
		}, {
			{ name = 'buffer' },
		})
	})

	cmp.setup.filetype('gitcommit', {
		sources = cmp.config.sources({
			{ name = 'git' },
		}, {
			{ name = 'buffer' },
		})
	})
	cmp.setup.cmdline({ '/', '?' }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = 'buffer' }
		}
	})
	cmp.setup.cmdline(':', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = 'path' }
		}, {
			{ name = 'cmdline' }
		})
	})

	require 'marks'.setup {
		default_mappings = false,
		builtin_marks = { "." },
		cyclic = true,
		force_write_shada = false,
		refresh_interval = 250,
		sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
		excluded_filetypes = {},
		mappings = {
			set_next = "m,",
			next = "m]",
			prev = "m[",
			set = "m",
			delete = "dm"
		}
	}

	require('neodev').setup()
	require('mason').setup()
	local mason_lspconfig = require('mason-lspconfig')
	mason_lspconfig.setup { ensure_installed = vim.tbl_keys(servers), }
	mason_lspconfig.setup_handlers {
		function(server_name)
			require('lspconfig')[server_name].setup {
				capabilities = require('cmp_nvim_lsp').default_capabilities(),
				on_attach = require('lsp_keymaps'),
				settings = servers[server_name]
			}
		end,
	}

	require('lspconfig').clangd.setup {
		capabilities = require('cmp_nvim_lsp').default_capabilities(),
		on_attach = require('lsp_keymaps'),
	}

	local dapui, dap = require('dapui'), require('dap')
	require('mason-nvim-dap').setup()
	require('nvim-dap-virtual-text').setup()

	dapui.setup(
		{
			layouts = { {
				elements = {
					{ id = "scopes",      size = 0.40 },
					{ id = "breakpoints", size = 0.20 },
					{ id = "stacks",      size = 0.20 },
					{ id = "watches",     size = 0.20 }
				},
				position = "left",
				size = 60
			}, {
				elements = {
					{ id = "repl",    size = 0.5 },
					{ id = "console", size = 0.5 }
				},
				position = "bottom",
				size = 10
			} }
		}
	)
	dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
	dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
	dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

	vim.keymap.set("n", ",do", function() dapui.toggle() end, { desc = '[D]AP UI [O]pen' })
	vim.keymap.set("n", ",db", ":DapToggleBreakpoint<CR>", { desc = '[D]AP toggle [B]reakpoint' })
	vim.keymap.set("n", ",dr", ":DapToggleRepl<CR>", { desc = '[D]AP toggle [R]EPL' })
	vim.keymap.set("n", ",dc", ":DapContinue<CR>", { desc = '[D]AP [C]ontinue' })
	vim.keymap.set("n", ",de", ":lua require'dapui'.eval()", { desc = '[D]AP [E]val' })


	vim.keymap.set("n", "<F10>", ":DapStepOver<CR>", { desc = 'Step over' })
	vim.keymap.set("n", "<F11>", ":DapStepInto<CR>", { desc = 'Step into' })
	vim.keymap.set("n", "<F12>", ":DapStepOut<CR>", { desc = 'Step out' })
end

return { setup_plugins = setup_plugins }

local function setup_plugins()
	-- Global settings
	vim.g.lazygit_floating_window_winblend = 5
	vim.g.lazygit_floating_window_scaling_factor = 0.85
	vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }

	vim.api.nvim_create_autocmd('TextYankPost', {
		callback = function()
			vim.highlight.on_yank()
		end,
		group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
		pattern = '*',
	})

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
	local mason_bin = "~/.local/share/nvim/mason/bin/"
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
		ocaml = {
			function()
				return {
					exe = "ocamlformat",
					args = { "--enable-outside-detected-project",
						util.escape_path(util.get_current_buffer_file_path()), },
					stdin = true
				}
			end,
		},
		python = { function()
			return {
				exe = mason_bin .. "black",
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
		auto_install = false,
		highlight = { enable = true },
		indent = { enable = true },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = '<leader>v',
				node_incremental = '<leader>v',
				scope_incremental = '<leader>V',
				node_decremental = '<M-v>',
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

	local coq = require("coq")
	require('neodev').setup()
	require('mason').setup()

	local keymaps = require('lsp_keymaps')
	local lspconfig = require('lspconfig')

	local handlers = {
		-- This is what runs when a specific config is not available (DEFAULT)
		function(server_name)
			local cfg = { on_attach = keymaps }
			lspconfig[server_name].setup(coq.lsp_ensure_capabilities(cfg))
		end,
		-- This is handled through nvim-jdtls
		["jdtls"] = function() end,

		--- Specific server configs:

		["rust_analyzer"] = function()
			require("rust-tools").setup { server = { on_attach = keymaps } }
		end,

		["lua_ls"] = function(server_name)
			local cfg = {
				on_attach = keymaps,
				settings = {
					Lua = {
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
					}
				}
			}
			lspconfig[server_name].setup(coq.lsp_ensure_capabilities(cfg))
		end,
	}

	require('mason-lspconfig').setup {
		automatic_installation = false,
		handlers = handlers
	}

	local dapui, dap = require('dapui'), require('dap')
	require('mason-nvim-dap').setup()
	require('nvim-dap-virtual-text').setup({})

	dapui.setup({
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
	})

	dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
	dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
	dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
end

return { setup_plugins = setup_plugins }

local function setup_plugins()
	local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
	vim.api.nvim_create_autocmd('TextYankPost', {
		callback = function()
			vim.highlight.on_yank()
		end,
		group = highlight_group,
		pattern = '*',
	})

	require("nvim-autopairs").setup({
		enable_check_bracket_line = true,
		check_ts = true,
		ts_config = {
			lua = { 'string' }, -- it will not add a pair on that treesitter node
			javascript = { 'template_string' },
			java = false, -- don't check treesitter on java
		}
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
				args = { util.get_current_buffer_file_name() },
				stdin = true
			}
		end
		},
		ocaml = { function()
			return {
				exe = "ocamlformat",
				args = { "--enable-outside-detected-project",
					util.escape_path(util.get_current_buffer_file_path()), },
				stdin = true
			}
		end,
		},

		["*"] = {
			require("formatter.filetypes.any").remove_trailing_whitespace
		}
	}

	require('formatter').setup {
		logging = true,
		log_level = vim.log.levels.WARN,
		filetype = formatter_settings,
	}

	vim.keymap.set("n", "<leader>lf", function()
			if formatter_settings[vim.bo.filetype] ~= nil then
				vim.cmd('write')
				vim.cmd([[Format]])
			else
				vim.lsp.buf.format()
			end
		end,
		{
			desc =
			"Format the current buffer. If there is a config in formatter.nvim, it will use that, if not, it will try to use LSP formatting"
		})


	---@diagnostic disable-next-line: missing-fields
	require('nvim-treesitter.configs').setup {
		ensure_installed = {
			'c', 'cpp', 'go', 'lua', 'python', 'rust',
			'tsx', 'typescript', 'vimdoc', 'vim', 'ocaml'
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
		-- pyright = {},
		clangd = {},
		ocamllsp = {},
		rust_analyzer = {},
		tsserver = {},
		lua_ls = {
			Lua = {
				workspace = { checkThirdParty = false },
				telemetry = { enable = false },
			},
		},
	}

	local coq = require("coq")

	require('neodev').setup()
	require('mason').setup()
	local mason_lspconfig = require('mason-lspconfig')
	mason_lspconfig.setup { ensure_installed = vim.tbl_keys(servers), }
	mason_lspconfig.setup_handlers {
		function(server_name)
			require('lspconfig')[server_name].setup {
				capabilities = coq.lsp_ensure_capabilities(),
				on_attach = require('lsp_keymaps'),
				settings = servers[server_name],
			}
		end,
	}

	local npairs = require('nvim-autopairs')
	npairs.setup({ map_bs = false, map_cr = false })

	_G.MUtils = {}
	MUtils.CR = function()
		if vim.fn.pumvisible() ~= 0 then
			if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
				return npairs.esc('<c-y>')
			else
				return npairs.esc('<c-e>') .. npairs.autopairs_cr()
			end
		else
			return npairs.autopairs_cr()
		end
	end
	vim.api.nvim_set_keymap('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })
	MUtils.BS = function()
		if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
			return npairs.esc('<c-e>') .. npairs.autopairs_bs()
		else
			return npairs.autopairs_bs()
		end
	end
	vim.api.nvim_set_keymap('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })
end

return { setup_plugins = setup_plugins }

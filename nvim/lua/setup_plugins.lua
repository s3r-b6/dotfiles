local function setup_plugins()
	local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
	vim.api.nvim_create_autocmd('TextYankPost', {
		callback = function()
			vim.highlight.on_yank()
		end,
		group = highlight_group,
		pattern = '*',
	})

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


	require('nvim-tree').setup({
		sync_root_with_cwd = true,
		respect_buf_cwd = true,
		update_focused_file = {
			enable = true,
			update_root = true
		},
	})

	-- [[ Configure Treesitter ]]
	require('nvim-treesitter.configs').setup {
		ensure_installed = {
			'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim'
		},

		auto_install = false,

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
		-- gopls = {},
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

	require('neodev').setup()
	-- [ Configure LSP ]
	local on_attach = function(_, bufnr)
		vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { desc = '[R]ename' })
		vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { desc = 'Code [A]ction' })
		vim.keymap.set('v', '<leader>la', vim.lsp.buf.code_action, { desc = 'Code [A]ction' })

		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = '[G]oto [D]efinition' })
		vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { desc = '[G]oto [R]eferences' })
		vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, { desc = '[G]oto [I]mplementation' })
		vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, { desc = 'Type [D]efinition' })
		vim.keymap.set('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols,
			{ desc = '[D]ocument [S]ymbols' })
		vim.keymap.set('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols,
			{ desc = '[W]orkspace [S]ymbols' })

		-- See `:help K` for why this keymap
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Signature Documentation' })

		vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
			vim.lsp.buf.format()
		end, { desc = 'Format current buffer with LSP' })
		vim.keymap.set('n', '<leader>lf', ':Format<CR>', { desc = '[F]ormat', silent = true })
	end


	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
	local mason_lspconfig = require 'mason-lspconfig'
	mason_lspconfig.setup {
		ensure_installed = vim.tbl_keys(servers),
	}
	mason_lspconfig.setup_handlers {
		function(server_name)
			require('lspconfig')[server_name].setup {
				capabilities = capabilities,
				on_attach = on_attach,
				settings = servers[server_name],
			}
		end,
	}

	-- See `:help cmp`
	local cmp = require 'cmp'
	local luasnip = require 'luasnip'
	require('luasnip.loaders.from_vscode').lazy_load()
	luasnip.config.setup {}
	cmp.setup {
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		mapping = cmp.mapping.preset.insert {
			['<C-j>'] = cmp.mapping.select_next_item(),
			['<C-k>'] = cmp.mapping.select_prev_item(),
			['<C-d>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			['<C-Space>'] = cmp.mapping.complete {},
			['<CR>'] = cmp.mapping.confirm {
				behavior = cmp.ConfirmBehavior.Replace,
				select = true,
			},
			['<Tab>'] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_locally_jumpable() then
					luasnip.expand_or_jump()
				else
					fallback()
				end
			end, { 'i', 's' }),
			['<S-Tab>'] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.locally_jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { 'i', 's' }),
		},
		sources = {
			{ name = 'nvim_lsp' },
			{ name = 'luasnip' },
		},
	}
end

return { setup_plugins = setup_plugins }

return {
	{
		'saghen/blink.cmp',
		dependencies = {
			'rafamadriz/friendly-snippets',
		},
		version = '1.*',
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				preset = 'none',
				['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
				['<C-e>'] = { 'hide' },
				['<Up>'] = { 'select_prev', 'fallback' },
				['<Down>'] = { 'select_next', 'fallback' },
				['<C-k>'] = { 'select_prev', 'fallback' },
				['<C-j>'] = { 'select_next', 'fallback' },
				['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
				['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
				['<Tab>'] = { 'snippet_forward', 'fallback' },
				['<S-Tab>'] = { 'snippet_backward', 'fallback' },
				['<CR>'] = { 'accept', 'fallback' },
				['<C-h>'] = { 'show_signature', 'hide_signature', 'fallback' },
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = 'mono',
			},
			signature = { enabled = true },
			completion = { documentation = { auto_show = false } },
			sources = {
				default = { 'lsp', 'path', 'snippets', 'buffer'  },
				providers = { },
			},
			fuzzy = { implementation = 'prefer_rust_with_warning' }
		},
		opts_extend = { 'sources.default' }
	},

	{
		'saghen/blink.compat',
		version = '2.*',
		lazy = true,
		opts = {},
	},
}

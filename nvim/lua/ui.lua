require('catppuccin').setup({
	integrations = {
		gitsigns = true,
		treesitter = true,
		telescope = { enabled = true },
		which_key = true,
	}
})


vim.cmd.colorscheme "catppuccin"

vim.g.lazygit_floating_window_winblend = 5
vim.g.lazygit_floating_window_scaling_factor = 0.85
vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }

vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function() vim.highlight.on_yank() end,
	group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
	pattern = '*',
})

local actions = require 'telescope.actions'
require('telescope').setup {
	defaults = {
		mappings = {
			i = {
				['<C-k>'] = actions.move_selection_previous,
				['<C-j>'] = actions.move_selection_next,
				['<C-u>'] = actions.preview_scrolling_up,
				['<C-d>'] = actions.preview_scrolling_down,
			},
		},
	}
}

pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')

require('ibl').setup({ scope = { enabled = false } })


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




require('lualine').setup {
	options = {
		icons_enabled = false,
		theme = "catppuccin",
		component_separators = '|',
		section_separators = '',
	}
}

require('rabbit').setup({
	default_keys = { open = { "<leader><space>" }, },
	float = "center",
	plugin_opts = {
		window = { float = "center" },
		history = {
			color = "#7FA9E8",
			switch = "r",
			keys = {},
			opts = {},
		},
		reopen = {
			color = "#907aa9",
			switch = "o",
			keys = {},
			opts = {},
		},
	},
})

require('rabbit').opts.window.float = "center"

require('nvim-lightbulb').setup({ autocmd = { enabled = true } })

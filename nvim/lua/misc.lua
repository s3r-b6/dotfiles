vim.cmd([[autocmd BufRead,BufNewFile *.hlsl setfiletype hlsl]])
vim.cmd([[autocmd BufRead,BufNewFile *.glsl setfiletype glsl]])

-- Treesitter
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
			node_incremental = '<leader>v',
			node_decremental = '<leader>V',
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

require("todo-comments").setup()

require("mini.files").setup({
	mappings = {
		close       = 'q',
		go_in       = 'l',
		go_in_plus  = 'L',
		go_out      = 'h',
		go_out_plus = 'H',
		reset       = '<BS>',
		reveal_cwd  = '@',
		show_help   = 'g?',
		synchronize = '=',
		trim_left   = '<',
		trim_right  = '>',
	},

	windows = {
		max_number = math.huge,
		preview = true,
		width_focus = 30,
		width_nofocus = 15,
		width_preview = 45,
	},
})

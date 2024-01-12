vim.cmd([[autocmd BufRead,BufNewFile *.hlsl setfiletype hlsl]])
vim.cmd([[autocmd BufRead,BufNewFile *.glsl setfiletype glsl]])

require("todo-comments").setup {}

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

-- Oil
require("oil").setup(
	{
		keymaps = {
			["g?"] = "actions.show_help",
			["<CR>"] = "actions.select",
			--["<C-s>"] = "actions.select_vsplit",
			--["<C-h>"] = "actions.select_split",
			--["<C-t>"] = "actions.select_tab",
			["<C-p>"] = "actions.preview",
			["<C-c>"] = "actions.close",
			["<C-l>"] = "actions.refresh",
			["<BS>"] = "actions.parent",
			["_"] = "actions.open_cwd",
			["`"] = "actions.cd",
			["~"] = "actions.tcd",
			["gs"] = "actions.change_sort",
			["gx"] = "actions.open_external",
			["g."] = "actions.toggle_hidden",
			--["g\\"] = "actions.toggle_trash",
		},
	}

)

vim.keymap.set("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })


-- VimTex settings
vim.cmd("let g:vimtex_view_method = 'zathura'")
vim.cmd("let g:tex_flavor = 'latex'")
-- This uses entr to force reloading
vim.cmd("let g:vimtex_compiler_method = 'generic'")
vim.cmd([[let g:vimtex_compiler_generic = {
	\ 'command': 'ls *.tex | entr -c tectonic /_ --synctex --keep-logs -n',
\}]])

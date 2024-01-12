local util = require 'formatter.util'
local mason_bin = '~/.local/share/nvim/mason/bin/'
local formatter_settings = {
	html = { function()
		return {
			exe = mason_bin .. 'prettier',
			args = { util.escape_path(util.get_current_buffer_file_path()), },
			stdin = true
		}
	end,
	},
	css = { function()
		return {
			exe = mason_bin .. 'prettier',
			args = { util.escape_path(util.get_current_buffer_file_path()), },
			stdin = true
		}
	end,
	},
	json = { function()
		return {
			exe = mason_bin .. 'fixjson',
			args = { util.escape_path(util.get_current_buffer_file_path()), },
			stdin = true
		}
	end
	},
	ocaml = {
		function()
			return {
				exe = 'ocamlformat',
				args = { '--enable-outside-detected-project',
					util.escape_path(util.get_current_buffer_file_path()), },
				stdin = true
			}
		end,
	},




	python = { function()
		return {
			exe = mason_bin .. 'black',
			args = { util.escape_path(util.get_current_buffer_file_path()), },
			stdin = false
		}
	end,
	},
	tex = { function()
		return {
			exe = mason_bin .. 'latexindent',
			args = { util.escape_path(util.get_current_buffer_file_path()), },
			stdin = true
		}
	end,
	},
	['*'] = {
		require('formatter.filetypes.any').remove_trailing_whitespace
	}
}


require('formatter').setup {
	logging = true,
	log_level = vim.log.levels.WARN,
	filetype = formatter_settings,
}

vim.keymap.set('n', '<leader>lf', function()
		if formatter_settings[vim.bo.filetype] ~= nil then
			-- vim.cmd('write')
			vim.cmd([[Format]])
		else
			vim.lsp.buf.format()
		end
	end,
	{ desc = 'Format the current buffer. Use formatter.nvim, if possible, else, try LSP formatting' })

local coq = require('coq')

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
	['jdtls'] = function() end,
	['hyprls'] = function() end,

	--- Specific server configs:

	['rust_analyzer'] = function()
		require('rust-tools').setup { server = { on_attach = keymaps } }
	end,

	['lua_ls'] = function(server_name)
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

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
	pattern = { "*.hl", "hypr*.conf" },
	callback = function(event)
		print(string.format("starting hyprls for %s", vim.inspect(event)))
		vim.lsp.start {
			name = "hyprlang",
			cmd = { "hyprls" },
			root_dir = vim.fn.getcwd(),
		}
	end
})

require('mason-lspconfig').setup {
	automatic_installation = false,
	handlers = handlers
}

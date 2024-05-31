local dapui, dap = require('dapui'), require('dap')

require('nvim-dap-virtual-text').setup({})
require('mason-nvim-dap').setup({
	ensure_installed = { 'codelldb' },
	handlers = {
		function(config)
			require('mason-nvim-dap').default_setup(config)
		end,
	},
})

dapui.setup({
	layouts = { {
		elements = {
			{ id = 'scopes',      size = 0.40 },
			{ id = 'breakpoints', size = 0.20 },
			{ id = 'stacks',      size = 0.20 },
			{ id = 'watches',     size = 0.20 }
		},
		position = 'left',
		size = 60
	}, {
		elements = {
			{ id = 'repl',    size = 0.5 },
			{ id = 'console', size = 0.5 }
		},
		position = 'bottom',
		size = 10
	} }
})



local codelldb_cfg = {
	name = 'DEF: LLDB Launch',
	type = 'codelldb',
	request = 'launch',
	program = function()
		local dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':p')
		return vim.fn.input('Path to executable: ', dir, 'file')
	end,
	cwd = '${workspaceFolder}',
	stopOnEntry = false,
	args = {},
}

dap.configurations.cpp = { codelldb_cfg }
dap.configurations.c = { codelldb_cfg }
dap.configurations.rust = { codelldb_cfg }
dap.configurations.zig = { codelldb_cfg }

dap.listeners.before.attach.dapui_config = function() dapui.open() end
dap.listeners.before.launch.dapui_config = function() dapui.open() end
dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

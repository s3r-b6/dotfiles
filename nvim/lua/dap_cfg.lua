local dapui, dap = require('dapui'), require('dap')
require('mason-nvim-dap').setup()
require('nvim-dap-virtual-text').setup({})

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

dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end

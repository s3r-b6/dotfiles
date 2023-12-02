-- TODO: Set up the formatter
local path_fmt = vim.fn.stdpath('config') .. '/lua/fmt/Default.xml'
local mason_dir = vim.fn.stdpath('data') .. '/mason/packages/'

local jdtls_cfg_dir = mason_dir .. 'jdtls/config_linux'

local jdtls_jar = vim.fn.glob(mason_dir ..
	'jdtls/plugins/org.eclipse.equinox.launcher_*.jar', true)
local debugger_jar = vim.fn.glob(mason_dir ..
	'java-debug-adapter/extension/server/com.microsoft.java.debug.plugin*.jar', true)
local java_test_jars = vim.fn.glob("~/.local/share/vscode-java-test-0.40.1/server/*.jar", true)

local bundles = { debugger_jar }
vim.list_extend(bundles, vim.split(java_test_jars, '\n'))

local root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw', 'pom.xml' }, {
	upward = true,
	path = vim.api.nvim_buf_get_name(0)
})[1])

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local data_dir = '/tmp/jdtls/' .. project_name

local config = {
	cmd = {
		'java',
		'-Declipse.application=org.eclipse.jdt.ls.core.id1',
		'-Dosgi.bundles.defaultStartLevel=4',
		'-Declipse.product=org.eclipse.jdt.ls.core.product',
		'-Dlog.protocol=true',
		'-Dlog.level=ALL',
		'-Xmx1g',
		'--add-modules=ALL-SYSTEM',
		'--add-opens', 'java.base/java.util=ALL-UNNAMED',
		'--add-opens', 'java.base/java.lang=ALL-UNNAMED',

		'-jar', jdtls_jar,
		'-configuration', jdtls_cfg_dir,
		'-data', data_dir
	},
	root_dir = root_dir,
	init_options = { bundles = bundles, },
	on_attach = function(_, bufnr)
		require('lsp_keymaps')() -- This binds my general lsp keymaps
		vim.keymap.set('n', '<leader>loi', function() require('jdtls').organize_imports() end,
			{ desc = '[O]rganize [I]mports' })
		vim.keymap.set('n', '<leader>lb', function() require('jdtls').build_projects() end,
			{ desc = 'Build' })

		vim.keymap.set('n', ',jd', function() require('jdtls.dap').setup_dap_main_class_configs() end,
			{ desc = '[J]ava [D]iscover main classes and create nvim-dap configuration entries' })
		vim.keymap.set('n', ',jc', function() require('jdtls').test_class() end,
			{ desc = '[J]ava Test [C]lass' })
		vim.keymap.set('n', ',jm', function() require('jdtls').test_nearest_method() end,
			{ desc = '[J]ava run nearest [M]ethod' })

		require 'lsp_signature'.on_attach({
			bind = true, -- This is mandatory, otherwise border config won't get registered.
			floating_window_above_cur_line = false,
			padding = '',
			handler_opts = { border = 'rounded' }
		}, bufnr)
	end
}

require('jdtls.dap').setup_dap()
require('jdtls').start_or_attach(config)

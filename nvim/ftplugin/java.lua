local path_fmt = vim.fn.stdpath('config') .. '/lua/fmt/Default.xml'
local mason_dir = vim.fn.stdpath('data') .. '/mason/packages/'

local jdtls_cfg_dir = mason_dir .. 'jdtls/config_linux'


local jdtls_jar = vim.fn.glob(mason_dir ..
	'jdtls/plugins/org.eclipse.equinox.launcher_*.jar', true)
local debugger_jar = vim.fn.glob(mason_dir ..
	'java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar', true)
local java_test_jars = vim.fn.glob(mason_dir ..
	"java-test/extension/server/*.jar", true)

local bundles = {
	debugger_jar
}

vim.list_extend(bundles, vim.split(java_test_jars, "\n"))

local root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw', 'pom.xml' }, { upward = true })[1])

-- If you started neovim within `~/dev/xy/project-1` this would resolve to `project-1`
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local data_dir = root_dir .. 'jdtls_data'


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
		vim.keymap.set('n', '<leader>loi', function() require('jdtls').organize_imports() end,
			{ desc = '[O]rganize [I]mports' })
		vim.keymap.set('n', '<leader>lb', function() require('jdtls').build_projects() end,
			{ desc = '[O]rganize [I]mports' })

		vim.keymap.set('n', ',jd', ':JdtUpdateDebugConfigs',
			{ desc = '[J]ava [D]iscover main classes and create nvim-dap configuration entries' })
		vim.keymap.set('n', ',jt', function() require('jdtls.tests').generate() end,
			{ desc = '[J]ava Generate [T]ests' })

		vim.keymap.set('n', ',jtc', function() require 'jdtls'.test_class() end,
			{ desc = '[J]ava [T]est [C]lass' })
		vim.keymap.set('n', ',jtm', function() require 'jdtls'.test_nearest_method() end,
			{ desc = '[J]ava run nearest [M]ethod' })

		require 'lsp_signature'.on_attach({
			bind = true, -- This is mandatory, otherwise border config won't get registered.
			floating_window_above_cur_line = false,
			padding = '',
			handler_opts = { border = 'rounded' }
		}, bufnr)
	end
}

require('jdtls').start_or_attach(config)

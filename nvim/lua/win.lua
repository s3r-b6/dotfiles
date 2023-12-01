-- I don't really mind my windows config being hacky :s
return {
	win_cfg = function()
		vim.o.shell = 'pwsh'
		vim.o.shellcmdflag =
		'-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
		vim.o.shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		vim.o.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		vim.o.shellquote = ''
		vim.o.shellxquote = ''
		vim.cmd([[
		let g:LanguageClient_serverCommands = {
		      \ 'c': ['C:\Program Files (x86)\mingw64\bin'],
		      \ 'cpp': ['C:\Program Files (x86)\mingw64\bin'],
		\}]])
		vim.cmd("let g:LanguageClient_autoStart = 1")

		-- The idea is overriding some globals and just using them
		vim.g.mason_bin = "C:\\Users\\Sergio\\AppData\\Local\\nvim-data\\mason\\bin\\"

		local dap = require('dap')
		-- NOTE: For some reason, mason installs vscode-lldb, not codelldb
		local codelldb_root = "C:\\Program Files (x86)\\codelldb\\"
		local codelldb_path = codelldb_root .. "adapter\\codelldb.exe"

		-- https://www.cnblogs.com/Searchor/p/17277235.html
		dap.adapters.codelldb = function(on_adapter)
			local tcp = vim.loop.new_tcp()
			tcp:bind('127.0.0.1', 0)
			local port = tcp:getsockname().port
			tcp:shutdown()
			tcp:close()

			local stdout = vim.loop.new_pipe(false)
			local stderr = vim.loop.new_pipe(false)
			local opts = {
				stdio = { nil, stdout, stderr },
				args = { '--port', tostring(port) },
			}
			local handle
			local pid_or_err
			handle, pid_or_err = vim.loop.spawn(codelldb_path, opts, function(code)
				stdout:close()
				stderr:close()
				handle:close()
				if code ~= 0 then
					print("codelldb exited with code", code)
				end
			end)
			if not handle then
				vim.notify("Error running codelldb: " .. tostring(pid_or_err), vim.log.levels.ERROR)
				stdout:close()
				stderr:close()
				return
			end
			vim.notify('codelldb started. pid=' .. pid_or_err)
			stderr:read_start(function(err, chunk)
				assert(not err, err)
				if chunk then
					vim.schedule(function()
						require("dap.repl").append(chunk)
					end)
				end
			end)
			local adapter = {
				type = 'server',
				host = '127.0.0.1',
				port = port
			}
			-- 💀
			-- Wait for codelldb to get ready and start listening before telling nvim-dap to connect
			-- If you get connect errors, try to increase 500 to a higher value, or check the stderr (Open the REPL)
			vim.defer_fn(function() on_adapter(adapter) end, 500)
		end
	end
}

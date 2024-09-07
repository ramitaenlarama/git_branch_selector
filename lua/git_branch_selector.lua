-- git_branch_selector.lua

local M = {}

-- Función para obtener ramas remotas
local function get_remote_branches()
	local handle = io.popen("git branch -r")
	local result = handle:read("*a")
	handle:close()

	local branches = {}
	for branch in string.gmatch(result, "origin/([^\n]+)") do
		table.insert(branches, branch)
	end
	return branches
end

-- Función para crear una rama local
local function create_local_branch(branch, local_name)
	local command = "git checkout -b " .. local_name .. " origin/" .. branch
	os.execute(command)
end

-- Función principal que muestra el popup de selección
function M.select_branches()
	-- Obtenemos las ramas remotas
	local branches = get_remote_branches()

	-- Si no hay ramas remotas, mostramos un mensaje
	if #branches == 0 then
		vim.notify("No remote branches found.", vim.log.levels.WARN)
		return
	end

	-- Usamos vim.ui.select para mostrar el popup de selección
	vim.ui.select(branches, { prompt = "Select remote branches:" }, function(selected_branch)
		if not selected_branch then
			return
		end

		-- Pedimos el nombre local de la rama seleccionada
		local default_name = selected_branch
		vim.ui.input(
			{ prompt = "Local name for " .. selected_branch .. ": ", default = default_name },
			function(local_name)
				if local_name then
					create_local_branch(selected_branch, local_name)
					vim.notify("Created local branch " .. local_name, vim.log.levels.INFO)
				else
					vim.notify("Cancelled creation for branch " .. selected_branch, vim.log.levels.WARN)
				end
			end
		)
	end)
end

-- Retornar el módulo
return M

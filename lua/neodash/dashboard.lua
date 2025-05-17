-- /neodash.nvim/lua/neodash/dashboard.lua created by DBTow

-- This code will be responsible for rendering the dashboard on startup

local dashboard = {}

local buf

local art = {
	"	⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣶⣄⡀⢀⣀⣠⣤⣤⣶⣶⣶⣤⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ",
	"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣠⣤⣿⠿⣩⣿⣿⣿⣿⣯⣛⣻⣯⣍⡛⣿⣿⣦⢰⣶⣄⡀⠀⠀⠀⠀⠀⠀⠀ ",
	"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣽⣿⡟⢹⣫⡿⠛⣿⣿⣿⠿⣛⣿⣿⣿⣿⠙⣿⣿⣿⣯⠻⣿⣿⣷⣄⠀⠀⠀⠀⠀ ",
	"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⣿⡿⡟⣰⣶⠈⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⢻⣿⣿⡿⣧⣈⠻⣿⣿⣷⡀⠀⠀⠀⠀",
	"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⢰⡇⢿⡟⢰⣿⣿⣿⣿⣿⣿⣿⠿⠿⣿⣿⣿⣿⣿⣿⣷⠈⢿⣧⡀⣿⣿⣿⡄⠀⠀⠀",
	"⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⠘⣷⢨⣿⠀⠻⢿⣿⣯⣤⣾⢃⣤⣶⣿⣿⣿⣿⣿⣿⣿⡏⠙⣿⣷⣿⣿⣿⣃⣤⡶⠀",
	"⠀⠀⠀⠀⣠⣴⣶⣶⣶⣿⡿⢹⣿⣿⠀⣿⣌⠛⠀⣠⣤⣌⡛⠿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⣠⡙⢿⣿⣿⣿⣿⠋⠀⠀",
	"⠈⠓⠦⢾⠿⠛⠙⠛⠛⢉⣠⣾⣿⡟⠙⣦⡀⠀⡻⣿⣿⣿⣿⠒⠀⣿⠟⠁⣹⣉⠉⣿⣿⣿⣿⣿⣿⣷⠈⣿⣿⣿⡿⣾⠏⠀",
	"⣀⡤⠤⠦⣴⣴⣶⣶⣶⣿⣿⣿⣿⡇⣰⣿⡟⠀⠳⣦⣄⣉⠛⠀⠀⢿⣿⣿⣿⡻⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢹⣤⡄",
	"⠁⢀⣀⣠⣤⡽⠟⠿⣿⣿⣿⠿⢋⣴⣿⣿⣿⠀⠀⠻⣷⣉⠉⢛⢷⣦⣝⠿⠿⣯⣭⣸⣿⣿⣿⣇⠻⣿⣿⣿⡿⣋⠁⢸⡿⠁",
	"⠀⠈⠙⣿⣥⣄⣀⣀⣀⣠⠤⠒⠋⢿⣿⠟⣩⠴⣶⠖⠈⠙⢷⣮⠳⣦⡍⢁⣾⣿⣿⣿⣿⣿⣿⣿⣿⣾⠿⢿⣃⡿⠃⣭⣧⣄",
	"⠀⠀⠒⠉⢿⣿⣿⣿⣿⣿⣶⣤⣄⣈⣉⣹⣵⡾⠋⠻⠿⢶⡆⠉⣡⣈⠁⠀⢮⣉⠙⠻⣅⢸⣿⠿⠋⣠⣴⡿⢋⣵⡖⣿⡉⠉",
	"⠐⠒⠲⢦⣌⠛⠛⢋⣠⣾⣿⣿⣿⣿⣿⠿⠋⢀⠀⢀⠀⠸⠦⠔⠉⢻⣠⠤⢤⠉⠙⣛⡟⠉⠐⣶⠐⢿⡿⠃⠾⣁⡴⣿⣿⠀",
	"⠀⠀⠀⠀⣿⣷⣶⣿⣿⠏⢀⣴⣶⠖⠀⠀⠀⠈⢩⠛⠻⢷⣦⡀⠀⠈⠁⠀⢠⡧⠴⠿⠿⡆⢀⣨⡤⣀⣠⣿⣶⣿⡷⢹⣧⠀",
	"⠀⠀⠀⠀⠙⠻⠿⠟⠋⠀⣾⣿⣧⡀⠀⠀⠀⠀⠈⠳⣤⣀⠈⠛⢷⣤⣀⡀⠉⠀⠀⠀⠀⠸⠋⠀⠀⢸⣿⣿⣿⡏⠀⢸⣿⠀",
	"⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠉⠛⠛⠉⠀⠉⠀⠀⠀⢀⣠⣤⠤⠤⠴⢶⣾⣿⣿⣿⡇⠀⣼⠏⠀",
	"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⢿⣁⣀⣀⠀⣠⣿⣿⣿⣿⡟⠃⣰⡏⠀⠀",
	"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⠃⠀⠈⠉⢀⣴⣿⣿⣿⣿⣿⡇⢰⣿⡇⠀⠀",
	"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⢰⡀⠀⠀⠀⢰⡇⠀⠀⣠⣴⣿⣿⣿⣿⣿⣿⣿⣇⢸⣿⠀⠀⠀",
	"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⣀⣀⣤⣶⣿⣷⣶⣦⣌⣧⠀⠀⢠⣿⣀⣠⣾⣿⣿⣿⡿⢋⡩⠟⣿⣿⣇⡿⠋⠀⠀⠀",
	"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿⣿⣿⠟⠁⠀⠈⠙⠻⣿⣿⣷⣤⣾⣿⣿⣿⠛⢉⣼⣟⣵⠏⣠⣾⢿⣿⡟⠁⠀⠀⠀⠀",
	"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⠀⠀⠈⣲⣶⣤⣤⡀⢀⡿⠉⢻⣿⡇⠀⣾⡿⢸⠏⣴⡿⠁⣼⣿⡇⠀⠀⠀⠀⠀",
	"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⣦⠀⠀⢻⣿⡏⠀⣰⡿⠁⠀⣾⣿⣿⢰⣿⠇⢸⣾⡟⠁⣼⣿⣿⡇⠀⠀⠀⠀⠀",
	"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠛⢿⣿⣿⣦⣼⣿⣃⡴⠋⠀⠀⢰⡿⣿⣿⢸⡿⢀⣾⠟⢀⣾⣿⣿⣿⠇⠀⠀⠀⠀⠀",
	"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠛⠛⠋⠉⠀⠀⠀⢀⣞⡕⢻⣿⢸⣷⡞⠁⣤⡿⢿⣿⣿⡟⠀⠀⠀⠀⠀⠀",
	"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡼⠎⣠⣾⡿⢸⡟⢀⣾⠟⢀⣼⣿⠏⠀⠀⠀⠀⠀  ",
}

--function createbuffer() {
--	buf = nvim_create_buf(false, true)
--	vim.api.nvim_buf_set_lines(buf, 0, -1, false, art)
--return buf

-- function dashboard.draw() {}

function dashboard.test_floating_window()
	-- Create a new scratch buffer
	buf = vim.api.nvim_create_buf(false, true)

	-- Set the content of the buffer (the ASCII art)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, art)

	-- Get the dimensions of the current Neovim UI
	local ui = vim.api.nvim_list_uis()[1]
	local width = math.floor(ui.width * 0.8)
	local height = #art

	local row = math.floor((ui.height - height) / 2)
	local col = math.floor((ui.width - width) / 2)

	-- Create a floating window
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded"
	})
end


return dashboard

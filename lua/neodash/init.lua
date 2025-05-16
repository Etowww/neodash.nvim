-- neodash.nvim/lua/neodash/init.lua created by DBTow

local M = {}

print("hello from neodash")

vim.api.nvim_create_autocmd({ "VimEnter"}, {
	callback = function()
		print("Entered Neovim")
		local check = vim.fn.argc()
		if check == 0 then
			-- The function that draws the window will go here
			print("function to display window")
		end
	end,
})

return M

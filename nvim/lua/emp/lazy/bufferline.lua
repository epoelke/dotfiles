return {
    {
        'akinsho/bufferline.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
        require("bufferline").setup{
			options = {
                separator_style = "thick", -- slant, slope, thick, thin
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						text_align = "center",
						highlight = "Directory",
						separator = true,
					},
				},
			}
		}
        end
    }
}

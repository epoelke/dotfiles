return {
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          width = {
            min = 15,
            max = 30,
          },

        },
        renderer = {
          group_empty = true,
        },
        filters = {
          enable = true,
          dotfiles = true,
          git_ignored = false,
          custom = {},
          exclude = {},
        },
        git = {
          ignore = false,
        },
      })
      vim.keymap.set('n', '<c-n>', ':NvimTreeFindFile<CR>')
    end,
  }
}

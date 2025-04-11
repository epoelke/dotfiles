require("emp.set")
require("emp.keymap")
require("emp.lazy_init")
require("emp.nftables")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.nft",
  callback = function()
    vim.bo.filetype = "nftables"
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.gotmpl",
    callback = function()
        vim.bo.filetype = "gotmpl"
    end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local api = require("nvim-tree.api")

    local args = vim.fn.argv()

    api.tree.open()

    if #args > 0 and vim.fn.filereadable(args[1]) == 1 then
        vim.schedule(function()
            vim.cmd("wincmd l")
        end)
    end
  end
})


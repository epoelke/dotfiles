require("emp.set")
require("emp.keymap")
require("emp.lazy_init")
require("emp.floaterminal")
require("emp.nftables")

vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1
vim.g.terminal_color_0   = "#1c1c1c" -- black
vim.g.terminal_color_1   = "#af005f" -- red
vim.g.terminal_color_2   = "#5faf00" -- green
vim.g.terminal_color_3   = "#d7af5f" -- yellow
vim.g.terminal_color_4   = "#5fafd7" -- blue
vim.g.terminal_color_5   = "#808080" -- magenta
vim.g.terminal_color_6   = "#d7875f" -- cyan
vim.g.terminal_color_7   = "#d0d0d0" -- white
vim.g.terminal_color_8   = "#585858" -- bright black (gray)
vim.g.terminal_color_9   = "#5faf5f" -- bright red
vim.g.terminal_color_10  = "#afd700" -- bright green
vim.g.terminal_color_11  = "#af87d7" -- bright yellow
vim.g.terminal_color_12  = "#ffaf00" -- bright blue
vim.g.terminal_color_13  = "#ff5faf" -- bright magenta
vim.g.terminal_color_14  = "#00afaf" -- bright cyan
vim.g.terminal_color_15  = "#5f8787" -- bright white

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

--vim.api.nvim_create_autocmd("VimEnter", {
--  callback = function()
--    local api = require("nvim-tree.api")
--
--    local args = vim.fn.argv()
--
--    api.tree.open()
--
--    if #args > 0 and vim.fn.filereadable(args[1]) == 1 then
--        vim.schedule(function()
--            vim.cmd("wincmd l")
--        end)
--    end
--  end
--})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == "gopls" then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    -- Link TermNormal and related groups to Normal
    vim.api.nvim_set_hl(0, "TermNormal", { link = "Normal" })
    vim.api.nvim_set_hl(0, "TermNormalNC", { link = "Normal" })
    vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
  end
})

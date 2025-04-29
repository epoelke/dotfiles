vim.g.mapleader = " "

vim.keymap.set("n", "<leader>p", ":BufferLinePick<CR>")
vim.keymap.set("n", "<leader>c", ":BufferLinePickClose<CR>")

vim.keymap.set("n", "<leader><Up>", "<C-w>+<C-w>+")
vim.keymap.set("n", "<leader><Down>", "<C-w>-<C-w>-")
vim.keymap.set("n", "<leader><Left>", "<C-w><<C-w><")
vim.keymap.set("n", "<leader><Right>", "<C-w>><C-w>>")
--vim.keymap.set("n", "<leader>s", ":AerialToggle!<CR>")
--vim.keymap.set('n', "<leader>s", ':SymbolsOutline<CR>', { noremap = true, silent = true })

vim.keymap.set("n", "<leader>w", "<C-w>", { noremap = true, silent = true })
--vim.keymap.set("n", "<leader>f", "za", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>b", ":BlameToggle<CR>")
vim.keymap.set("n", "<leader>n", ":NvimTreeToggle<CR>")

vim.keymap.set("n", "<leader>s", "<cmd>Outline<CR>")

-- Map Leader Key
vim.g.mapleader = " "

-- Set clipboard
vim.o.clipboard = "unnamed"
--
-- Enable visual line navigation
vim.keymap.set("n", "<leader><Esc>", vim.cmd.Ex)
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = false })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = false })
vim.api.nvim_set_keymap('n', '0', 'g0', { noremap = false })
vim.api.nvim_set_keymap('n', '$', 'g$', { noremap = false })
vim.keymap.set("n", "<F9>", vim.cmd.nohl)

-- remap window navigation
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-|>", vim.cmd.vs)
vim.keymap.set("n", "<C-_>", vim.cmd.sp)

-- remap window resizing.
vim.keymap.set("n", "=", [[<cmd>vertical resize +5<cr>]])
vim.keymap.set("n", "-", [[<cmd>vertical resize -5<cr>]])
vim.keymap.set("n", "+", [[<cmd>horizontal resize +2<cr>]])
vim.keymap.set("n", "_", [[<cmd>horizontal resize -2<cr>]])

--
vim.keymap.set("n", "<C-b>", vim.cmd.NvimTreeToggle)

vim.o.clipboard = "unnamed"

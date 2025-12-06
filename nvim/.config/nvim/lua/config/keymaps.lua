-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.api.nvim_create_autocmd("User", {
  pattern = "ObsidianNoteEnter",
  callback = function(ev)
    vim.keymap.set("n", "<leader>ch", "<cmd>Obsidian toggle_checkbox<cr>", {
      buffer = ev.buf,
      desc = "Obsidian: Toggle checkbox",
    })
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "ObsidianNoteEnter",
  callback = function()
    vim.keymap.set("n", "<leader>td", function()
      -- Get today's date in YYYY-MM-DD format
      local date_str = os.date("%Y-%m-%d")

      -- Command to insert: "- [ ] 📅 YYYY-MM-DD "
      local command = "i- [ ] 📅 " .. date_str .. " "

      -- Execute the command in Normal mode
      vim.cmd("normal! " .. command)
    end, { desc = "Obsidian: Insert Task with Date" })
  end,
})

-- vim.api.nvim_create_autocmd("User", {
--   pattern = "ObsidianNoteEnter",
--   callback = function(ev)
--     vim.keymap.set("x", "<leader>ol", "<cmd>ObsidianLink<cr>", {
--       buffer = ev.buf,
--       desc = "Obsidian: Toggle checkbox",
--     })
--   end,
-- })

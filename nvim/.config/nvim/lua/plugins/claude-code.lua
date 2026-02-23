return {
  "greggh/claude-code.nvim",
  lazy = true,
  cmd = {
    "ClaudeCode",
    "ClaudeCodeContinue",
    "ClaudeCodeResume",
    "ClaudeCodeVerbose",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("claude-code").setup({
      window = {
        position = "vertical",  -- Opens on the side instead of bottom
        split_ratio = 0.4,      -- 40% of screen width
      },
    })

    -- Custom function to ask Claude about visual selection
    _G.claude_ask_selection = function()
      -- Get the visual selection
      local start_pos = vim.fn.getpos("'<")
      local end_pos = vim.fn.getpos("'>")
      local start_line = start_pos[2]
      local end_line = end_pos[2]
      local lines = vim.fn.getline(start_line, end_line)

      -- Handle single line selection
      if #lines == 1 then
        lines[1] = string.sub(lines[1], start_pos[3], end_pos[3])
      else
        -- Handle multi-line selection
        lines[1] = string.sub(lines[1], start_pos[3])
        lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
      end

      local selected_text = table.concat(lines, "\n")

      -- Get the current file info
      local filepath = vim.fn.expand("%:.")  -- Relative path

      -- Format the context message
      local context = string.format("%s:%d-%d", filepath, start_line, end_line)

      -- Build the prompt with file context
      local prompt = string.format('Claude, can you explain this code from %s?\n\n```\n%s\n```\n', context, selected_text)

      -- Store prompt in a register for pasting
      vim.fn.setreg('c', prompt)

      -- Check if there's an active Claude Code session
      local claude = require("claude-code")
      local current_instance = claude.claude_code.current_instance
      local existing_bufnr = nil

      if current_instance and claude.claude_code.instances[current_instance] then
        existing_bufnr = claude.claude_code.instances[current_instance]
      end

      -- Check if the Claude Code window is visible
      local claude_win = nil
      if existing_bufnr and vim.api.nvim_buf_is_valid(existing_bufnr) then
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          if vim.api.nvim_win_get_buf(win) == existing_bufnr then
            claude_win = win
            break
          end
        end
      end

      local function paste_to_terminal()
        -- Enter insert mode and paste from register c
        vim.cmd('startinsert')
        vim.defer_fn(function()
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-\\><C-n>"cpi', true, false, true), 'n', false)
        end, 50)
      end

      if claude_win then
        -- Session exists and window is visible, just focus it and paste
        vim.api.nvim_set_current_win(claude_win)
        paste_to_terminal()
      else
        -- Open Claude Code first
        vim.cmd("ClaudeCode")
        -- Wait for terminal to open, then paste
        vim.defer_fn(paste_to_terminal, 300)
      end
    end

    -- Create a command for the function
    vim.api.nvim_create_user_command("ClaudeAskSelection", function()
      _G.claude_ask_selection()
    end, { range = true })
  end,
  keys = {
    { "<C-,>", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude Code", mode = { "n", "i", "t" } },
    { "<leader>cc", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude Code" },
    { "<leader>cC", "<cmd>ClaudeCodeContinue<cr>", desc = "Claude Code Continue" },
    { "<leader>cr", "<cmd>ClaudeCodeResume<cr>", desc = "Claude Code Resume" },
    { "<leader>cV", "<cmd>ClaudeCodeVerbose<cr>", desc = "Claude Code Verbose" },
    { "<leader>cx", ":<C-u>ClaudeAskSelection<cr>", desc = "Claude eXplain selection", mode = "v" },
  },
}

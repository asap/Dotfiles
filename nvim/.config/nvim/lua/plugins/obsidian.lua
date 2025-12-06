return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  ft = "markdown",
  lazy = false,
  -- event = "CmdlineEnter",

  keys = {
    { "<leader>ot", "<cmd>ObsidianToday<CR>", desc = "Obsidian: Daily Note", mode = "n" },
    -- { "<leader>ol", "<cmd>Obsidian link<CR>", desc = "Obsidian: Link", mode = "v" },
    -- { "<leader>ch", "", desc = "Obsidian: Toggle Checkbox", mode = "n" },
    { "<leader>ol", 'c[[<C-r>"]]<Esc>', desc = "Obsidian Link", mode = "v" },
  },

  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    new_notes_location = "notes_subdir",
    notes_subdir = "_index",
    note_id_func = function(title)
      return title
    end,
    workspaces = {
      {
        name = "personal",
        path = "~/Documents/Obsidian/Life/",
      },
      -- {
      --   name = "work",
      --   path = "~/Documents/Obsidian/Life/",
      -- },
    },

    completion = {
      nvim_cmp = false,
      min_chars = 2,
    },

    daily_notes = {
      folder = "Logs/Daily",
      default_tags = { "daily_notes" },
      template = "Templates/Daily Template.md",
    },

    templates = {
      folder = "Templates",
      substitutions = {
        yesterday = function()
          return os.date("%Y-%m-%d")
        end,

        year = function()
          return os.date("%Y")
        end,

        week_number = function()
          return os.date("%V", os.time())
        end,
      },
    },

    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Toggle check-boxes.
      ["<leader>ch"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
      -- Smart action depending on context, either follow link or toggle checkbox.
      ["<cr>"] = {
        action = function()
          return require("obsidian").util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      },
    },

    ui = {
      enable = false,
    },

    -- see below for full list of options 👇
  },

  -- config = function()
  --   local obs = require("obsidian")
  --   --   require("obsidian")
  --   --
  --   vim.keymap.set("n", "<leader>ch", function()
  --     require("obsidian").util.toggle_checkbox()
  --   end, { buffer = true, desc = "Obsidian: Toggle Checkbox" })
  -- end,
}

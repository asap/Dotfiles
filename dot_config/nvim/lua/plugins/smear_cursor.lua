return {
  "sphamba/smear-cursor.nvim",
  dependencies = { "catppuccin/nvim" },
  opts = function()
    local catppuccin = require("catppuccin.palettes").get_palette()

    return {
      cursor_color = catppuccin.mauve, -- or any other Catppuccin color
      normal_bg = catppuccin.base,
      -- You can use other Catppuccin colors like:
      -- catppuccin.rosewater, catppuccin.flamingo, catppuccin.pink,
      -- catppuccin.mauve, catppuccin.red, catppuccin.maroon,
      -- catppuccin.peach, catppuccin.yellow, catppuccin.green,
      -- catppuccin.teal, catppuccin.sky, catppuccin.sapphire,
      -- catppuccin.blue, catppuccin.lavender, catppuccin.text,
      -- catppuccin.subtext1, catppuccin.subtext0, catppuccin.overlay2,
      -- catppuccin.overlay1, catppuccin.overlay0, catppuccin.surface2,
      -- catppuccin.surface1, catppuccin.surface0, catppuccin.base,
      -- catppuccin.mantle, catppuccin.crust
    }
  end,
  config = function(_, opts)
    require("smear_cursor").setup(opts)

    -- Update smear cursor colors when colorscheme changes
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "catppuccin*",
      callback = function()
        local catppuccin = require("catppuccin.palettes").get_palette()
        require("smear_cursor").setup({
          cursor_color = catppuccin.mauve,
          normal_bg = catppuccin.base,
        })
      end,
    })
  end,
}

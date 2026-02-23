return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    -- Add prettier as formatter for JS/TS files
    opts.formatters_by_ft = opts.formatters_by_ft or {}
    opts.formatters_by_ft.javascript = { "prettier" }
    opts.formatters_by_ft.javascriptreact = { "prettier" }
    opts.formatters_by_ft.typescript = { "prettier" }
    opts.formatters_by_ft.typescriptreact = { "prettier" }

    -- Configure prettier to use project root so it finds .prettierrc
    opts.formatters = opts.formatters or {}
    opts.formatters.prettier = {
      require_cwd = true,
      cwd = require("conform.util").root_file({
        ".prettierrc",
        ".prettierrc.json",
        ".prettierrc.js",
        "prettier.config.js",
        "package.json",
      }),
    }

    return opts
  end,
}

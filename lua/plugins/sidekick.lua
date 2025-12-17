return {
  {
    "folke/sidekick.nvim",
    -- stylua: ignore
    keys = {
      -- nes is also useful in normal mode
      {
        "<c-.>",
        function() require("sidekick.cli").toggle() end,
        desc = "Sidekick Toggle",
        mode = { "n", "t", "i", "x" },
      },
    },
  },
}

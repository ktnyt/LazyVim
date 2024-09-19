return {
  "stevearc/conform.nvim",
  opts = {
    log_level = vim.log.levels.DEBUG,
    formatters_by_ft = {
      python = {
        "autopep8",
        "isort",
      },
    },
    formatters = {
      isort = {
        prepend_args = {
          "--profile",
          "black",
        },
      },
      autopep8 = {
        prepend_args = {
          "--ignore",
          "E402,E704,F405,F403,F841,W503,E721",
          "--max-line-length",
          "120",
        },
      },
    },
  },
}

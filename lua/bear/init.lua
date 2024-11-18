require("bear.remap")
require("bear.set")

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"},{
    pattern = "*.v",
    command = "set filetype=verilog"
})

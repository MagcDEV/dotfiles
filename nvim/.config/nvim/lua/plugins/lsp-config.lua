return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "ts_ls", "omnisharp", "lua_ls", "jdtls", "rust_analyzer", "sqls" },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
            })
            lspconfig.omnisharp.setup({
                capabilities = capabilities,
                cmd = {
                    os.getenv("HOME") .. "/.local/share/nvim/mason/bin/omnisharp",
                    "--languageserver",
                    "--hostPID",
                    tostring(vim.fn.getpid()),
                    "--DotNet:enablePackageRestore=false",
                    "--encoding",
                    "utf-8",
                    "--FormattingOptions:EnableEditorConfigSupport=true",
                    "--Sdk:IncludePrereleases=true",
                },
            })
            lspconfig.ts_ls.setup({
                capabilities = capabilities,
            })
            lspconfig.jdtls.setup({
                capabilities = capabilities,
            })

            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
            vim.keymap.set({ "n" }, "<leader>ca", vim.lsp.buf.code_action, {})
        end,
    },
}

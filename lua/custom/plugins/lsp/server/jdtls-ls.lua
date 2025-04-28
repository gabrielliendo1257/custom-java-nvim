local M = {}

local jdtls_module = require 'jdtls'
local extendedClientCapabilities = jdtls_module.extendedClientCapabilities

local jdtls_config = require 'custom.plugins.config.jdtls'
local jdtls_paths = jdtls_config.get_jdtls()

local lsp_common_config = require 'custom.plugins.config.lsp-config'
-- Create a table called init_options to pass the bundles with debug and testing jar, along with the extended client capablies to the start or attach function of JDTLS
local init_options = {
    bundles = jdtls_config.get_bundles(),
    extendedClientCapabilities = extendedClientCapabilities,
}

local on_attach = function(_, bufnr)
    -- Setup the java debug adapter of the JDTLS server
    require('jdtls.dap').setup_dap()

    require('jdtls.dap').setup_dap_main_class_configs()
    vim.lsp.codelens.refresh()

    vim.api.nvim_create_autocmd('BufWritePost', {
        pattern = { '*.java' },
        callback = function()
            local _, _ = pcall(vim.lsp.codelens.refresh)
        end,
    })
end

-- Set the command that starts the JDTLS language server jar
local cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-javaagent:' .. jdtls_paths.lombok,
    '-jar',
    jdtls_paths.launcher,
    '-configuration',
    jdtls_paths.config,
    '-data',
    jdtls_config.get_workspace(),
}

local root_dir = jdtls_module.setup.find_root { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }

-- Configure settings in the JDTLS server
local settings = {
    java = {
        -- Enable code formatting
        format = {
            enabled = true,
            -- Use the Google Style guide for code formattingh
            settings = {
                -- url = vim.fn.stdpath("config") .. "/lang_servers/intellij-java-google-style.xml",
                profile = 'GoogleStyle',
            },
        },
        -- Enable downloading archives from eclipse automatically
        eclipse = {
            downloadSource = true,
        },
        -- Enable downloading archives from maven automatically
        maven = {
            downloadSources = true,
        },
        -- Enable method signature help
        signatureHelp = {
            enabled = true,
        },
        -- Use the fernflower decompiler when using the javap command to decompile byte code back to java code
        contentProvider = {
            preferred = 'fernflower',
        },
        -- Setup automatical package import oranization on file save
        saveActions = {
            organizeImports = true,
        },
        -- Customize completion options
        completion = {
            -- When using an unimported static method, how should the LSP rank possible places to import the static method from
            favoriteStaticMembers = {
                'org.hamcrest.MatcherAssert.assertThat',
                'org.hamcrest.Matchers.*',
                'org.hamcrest.CoreMatchers.*',
                'org.junit.jupiter.api.Assertions.*',
                'java.util.Objects.requireNonNull',
                'java.util.Objects.requireNonNullElse',
                'org.mockito.Mockito.*',
            },
            -- Try not to suggest imports from these packages in the code action window
            filteredTypes = {
                'com.sun.*',
                'io.micrometer.shaded.*',
                'java.awt.*',
                'jdk.*',
                'sun.*',
            },
            -- Set the order in which the language server should organize imports
            importOrder = {
                'java',
                'jakarta',
                'javax',
                'com',
                'org',
            },
        },
        sources = {
            -- How many classes from a specific package should be imported before automatic imports combine them all into a single import
            organizeImports = {
                starThreshold = 9999,
                staticThreshold = 9999,
            },
        },
        -- How should different pieces of code be generated?
        codeGeneration = {
            -- When generating toString use a json format
            toString = {
                template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
            },
            -- When generating hashCode and equals methods use the java 7 objects method
            hashCodeEquals = {
                useJava7Objects = true,
            },
            -- When generating code use code blocks
            useBlocks = true,
        },
        -- If changes to the project will require the developer to update the projects configuration advise the developer before accepting the change
        configuration = {
            updateBuildConfiguration = 'interactive',
        },
        -- enable code lens in the lsp
        referencesCodeLens = {
            enabled = true,
        },
        -- enable inlay hints for parameter names,
        inlayHints = {
            parameterNames = {
                enabled = 'all',
            },
        },
    },
}

M.config = {
    cmd = cmd,
    root_dir = root_dir,
    settings = settings,
    capabilities = lsp_common_config.capabilities,
    init_options = init_options,
    on_attach = on_attach,
}

return M

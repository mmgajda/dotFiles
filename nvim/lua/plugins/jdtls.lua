-- lua/plugins/jdtls.lua (or in your lazy setup):
return {
	"mfussenegger/nvim-jdtls",
	ft = "java",
	config = function()
		local jdtls = require("jdtls")
		local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
		local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

		jdtls.start_or_attach({
			cmd = {
				-- Adjust paths to your local installation
				"java",
				"-Declipse.application=org.eclipse.jdt.ls.core.id1",
				"-Dosgi.bundles.defaultStartLevel=4",
				"-Declipse.product=org.eclipse.jdt.ls.core.product",
				"-Dlog.protocol=true",
				"-Dlog.level=ALL",
				"-Xms1g",
				"--add-modules=ALL-SYSTEM",
				"--add-opens",
				"java.base/java.util=ALL-UNNAMED",
				"--add-opens",
				"java.base/java.lang=ALL-UNNAMED",
				"-jar",
				"/path/to/your/jdtls_installation/plugins/org.eclipse.equinox.launcher_VERSION.jar",
				"-configuration",
				"/path/to/your/jdtls_installation/config_linux",
				-- ^ or config_win, config_mac, etc.
				"-data",
				workspace_dir,
			},
			root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),
			settings = {
				java = {
					configuration = {
						-- Example: specify a Java 17 JDK
						-- runtimes = {
						--   { name = "JavaSE-17", path = "/usr/lib/jvm/java-17-openjdk" }
						-- },
					},
				},
			},
			-- You can also add `capabilities = ...` if you want the same nvim-cmp
			-- capabilities that you set up for other languages
		})
	end,
}

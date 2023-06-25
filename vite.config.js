import { defineConfig } from "vite";
import { viteCommonjs } from "@originjs/vite-plugin-commonjs";
import { ViteEjsPlugin } from "vite-plugin-ejs";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    viteCommonjs(),
    ViteEjsPlugin((config) => {
      return {
        isDev: config.mode === "development",
      };
    }),
  ],
  server: {
    port: 8080,
  },
});

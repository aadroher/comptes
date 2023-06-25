const fs = require("fs");
const { viteCommonjs } = require("@originjs/vite-plugin-commonjs");

const PROD_FILE_PATH = "./src/index.prod.js";

const code = fs.readFileSync(PROD_FILE_PATH, { encoding: "utf-8" });
// const transformedCode = viteCommonjs().transform(code, PROD_FILE_PATH);
fs.writeFileSync(PROD_FILE_PATH, code, { encoding: "utf-8" });

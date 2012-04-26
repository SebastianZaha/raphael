#!/usr/bin/env node

var setup = {
        input: {
            core: "raphael.core.js",
            svg:  "raphael.svg.js",
            vml:  "raphael.vml.js",
            eve:  "eve/eve.js"
        },
        output: {
            "raphael.js": function () {
                return this.eve + "\n\n" + this.core + "\n\n" + this.svg + "\n\n" + this.vml;
            }
        }
    },
    fs = require("fs"),
    rxdr = /\/\*\\[\s\S]+?\\\*\//g;

var files = {};
for (var file in setup.input) {
    files[file] = String(fs.readFileSync(setup.input[file], "utf8")).replace(rxdr, "");
}
for (file in setup.output) {
    (function (file) {
        fs.writeFile(file, setup.output[file].call(files), function () {
            console.log("Saved to \033[32m" + file + "\033[0m\n");
        });
    })(file);
}
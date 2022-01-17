const nunjucks = require("nunjucks");
const fs = require("fs");
const pageData = require("./pageData");

const compileTemplates = () => {
    console.log("Compiling templates");
    const numPages = pageData.length;

    for (let i = 0; i < numPages; i++) {
        const page = pageData[i];
        const nextPage = i === numPages - 1 ? {} : pageData[i + 1];
        const { name, title } = page;
        console.log("    ", name);
        const html = nunjucks.render(
            `templates/${name}.njk`,
            { title, pageData, nextPage },
        );
        fs.writeFileSync(`html/${name}.html`, html);
    }

    console.log("Finished compiling templates");
};

module.exports = compileTemplates;
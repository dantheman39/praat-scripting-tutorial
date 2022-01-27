const nunjucks = require("nunjucks");
const fs = require("fs");

const pageData = [
    ["default", "Home", "Praat scripting - Intro"],
    ["infoWindow", "Info window", "Praat scripting - Info Window"],
    ["textEditor", "Text editor", "Praat scripting - Text Editor"],
    ["numVariables", "Numeric variables", "Praat scripting - Numeric variables"],
    ["stringsIntro", "String variables", "Praat scripting - String variables"],
    ["strings2", "Strings: continued", "Praat scripting - Strings continued"],
    ["boolean", "Boolean variables", "Praat scripting - Boolean variables"],
    ["findingCommands", "Praat commands", "Praat scripting - Finding commands"],
    ["conditionals", "Conditionals", "Praat scripting - Conditionals"],
    ["objectSelection", "Object selection", "Praat scripting - Object selection"],
    ["loops", "Loops", "Praat scripting - Loops"],
    ["filePaths", "File paths", "Praat scripting - File paths"],
    ["files", "Files", "Praat scripting - Files"],
    ["loopingThroughFiles", "Looping through files", "Praat scripting - Looping through files"],
    ["filesExtendedExample", "Challenge: Formant script", "Praat scripting - Formant script"],
    ["popupWindows", "Popup windows", "Praat Scripting - Forms, beginPause, Popup windows"],
    ["procedures", "Procedures", "Praat scripting - Procedures"],
    ["advancedStrings", "Advanced strings", "Praat scripting - Advanced String Operations"],
    ["theEnd", "The End", "Praat scripting - The End"],
    ["downloads", "Downloads", "Praat scripting - Downloads page"],
    ["contact", "Contact", "Praat scripting - Contact"],
].map(([name, humanName, title]) => ({ name, humanName, title }));

const excludeFromNext = ["downloads", "contact"];

const DEBUG = process.env.DEBUG === "true";

const compileTemplates = () => {
    console.log("Compiling templates");
    const numPages = pageData.length;

    for (let i = 0; i < numPages; i++) {
        const page = pageData[i];
        const isLastPage = i === numPages - 1;
        let nextPage = {};
        if (!isLastPage) {
            const nextPageMaybe = pageData[i + 1];
            const shouldExclude = excludeFromNext.indexOf(nextPageMaybe.name) > -1;
            if (!shouldExclude) {
                nextPage = nextPageMaybe;
            }
        }
        const { name, title } = page;
        console.log("    ", name);
        const html = nunjucks.render(
            `templates/${name}.njk`,
            { title, pageData, nextPage, debug: DEBUG },
        );
        fs.writeFileSync(`html/${name}.html`, html);
    }

    console.log("Finished compiling templates");
};

module.exports = compileTemplates;

if (require.main === module) {
    compileTemplates();
}
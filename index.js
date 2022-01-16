const nunjucks = require("nunjucks");
const fs = require("fs");

const navPages = [
    {name: "page1", human: "Page 1"},
];

const h = nunjucks.render(
    "templates/infoWindow.njk",
    { title: "Jameson", navPages, nextPage: "nextPage", nextPageHuman: "Next Page" },
);

fs.writeFileSync("html/infoWindow.html", h);
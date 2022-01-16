const nunjucks = require("nunjucks");

const navPages = [
    {name: "page1", human: "Page 1"},
];

const s = nunjucks.render("templates/infoWindow.njk", { title: "Jameson", navPages, nextPage: "nextPage", nextPageHuman: "Next Page" });
console.log(s);
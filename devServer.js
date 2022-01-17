const express = require("express");
const fs = require("fs");
const path = require("path");

const app = express();
const port = process.env.PORT || 8000;

app.use(express.static("static"));
app.use(express.static("images"));

app.get("*", (req, res) => {
    // A ghetto little server to dev with.
    if (req.path === "/") {
        res.sendFile(path.join(__dirname, "html", "infoWindow.html"));
        return;
    }
    if (fs.existsSync(`.${req.path}`)) {
        res.sendFile(path.join(__dirname, req.path));
        return;
    } else {
        const noSlash = req.path.replace("/", "");
        const fp = path.join(__dirname, "html", `${noSlash}.html`)
        if (fs.existsSync(fp)) {
            res.sendFile(fp);
            return;
        }
    }
    res.sendStatus(404);
});

const runServer = () => {
    console.log(`Listening on port ${port}`);
    app.listen(port);
};

module.exports = runServer;

if (require.main === module) {
    runServer();
}

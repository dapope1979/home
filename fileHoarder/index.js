const express = require('express')
const app = express()
const port = 3000
const fileUpload = require('express-fileupload')
const filenamify = require('filenamify')
const fs = require('fs');
const targetDir = "uploads";

if (!fs.existsSync(targetDir)){
    fs.mkdirSync(targetDir);
}

app.use(fileUpload());

app.get('/', (req, res) => {
    res.send("hi");
});

app.post('/', (req, res) => {
    let email = filenamify(req.body.email, {replacement: '_'});

    let requestDir = `${targetDir}/${email}`;
    if (!fs.existsSync(requestDir)){
        fs.mkdirSync(requestDir);
    }
    
    let file = req.files.file;
    file.mv(`./${requestDir}/${file.name}`, (err) => {
        if (err) {
            console.error(err);
            res.status(500).send(err);
            return;
        }
        console.log("completed");
        res.send("ok");
    });
});

app.listen(port, () => {
    console.log(`listening on port ${port}!`);
});
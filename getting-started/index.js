const express = require("express");
const bodyParser = require("body-parser");
const app = express();

app.use(bodyParser.json());

app.post("/", (req, res) => {

    if (!req.body) {
        const msg = "no Pub/Sub message received";
        console.error(`error: ${msg}`);
        res.status(400).send(`Bad Request: ${msg}`);
        return
    }
    if (!req.body.message) {
        const msg = "invalid Pub/Sub message format";
        console.error(`error: ${msg}`);
        res.status(400).send(`Bad Request: ${msg}`);
        return
    }

    const pubSubMessage = req.body.message;
    const originatorMessage = Buffer.from(pubSubMessage.data, "base64").toString().trim();
    const now = new Date();

    console.log(`${originatorMessage} says the time is ${now.toString()}`);
    res.status(204).send()
});

const PORT = process.env.PORT || 8080;

app.listen(PORT, () => console.log(`listening on port ${PORT}`));

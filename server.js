import express from "express";
const app = express();
const port = 3000;

let count = 0;

app.get('/', (req, res) => {
	count++;
	res.send(`Hello World, number ${count}!`);
	console.log(`/ called ${count} time(s) already !!`);
})

app.listen(port, () => {
	console.log(`Listening on port ${port}`)
})

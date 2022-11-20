const express = require("express");
const mongoose = require("mongoose");

//
const defaultRouter = require("./route/default");

//
const PORT = 3000;
const app = express();
const DB = "mongodb+srv://Thanh:19032001@cluster0.ipw4nt3.mongodb.net/?retryWrites=true&w=majority";


//
app.use(express.json());
app.use(defaultRouter);

//
mongoose.connect(DB).then(() => {
    console.log("Connection Successful");
}).catch((e) => {
    console.log(e);
});

app.listen(PORT, "0.0.0.0", () => {
    console.log(`connected at port ${PORT}`);
});
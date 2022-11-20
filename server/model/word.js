const mongoose = require("mongoose");

const wordSchema = mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true,
  },
  description: {
    type: String,
    required: true,
    trim: true,
  },
  translate: {
    type: String,
  },
  favorite: {
    type: String,
  },
});

const Word = mongoose.model("Word", wordSchema);
module.exports = { Word, wordSchema };
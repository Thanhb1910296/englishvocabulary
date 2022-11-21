const express = require("express");

const defaultRouter = express.Router();

const { Word} = require("../model/word");

const { PromiseProvider } = require("mongoose");

defaultRouter.get("/api/get-all-words" ,async (req, res) => {
  try {
    const words = await Word.find({});
    res.json(words);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

defaultRouter.post("/api/add-word",async (req, res) => {
  try {
    const { name, description, translate, favorite } = req.body;
    let word = new Word({
      name,
      description,
      translate,
      favorite,
    });
    word = await word.save();
    res.json(word);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

defaultRouter.post("/api/delete-word", async (req, res) => {
  try {
    const { id } = req.body;
    let word = await Word.findByIdAndDelete(id);
    res.json(word);

  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

defaultRouter.post("/api/update-word", async (req, res) => {
  try {
    const { id, name, description, translate, favorite } = req.body;
    
    let word_x = await Word.findById(id);

    word_x.name = name;
    word_x.description = description;
    word_x.translate = translate;
    // word_x.favorite = favorite; 

    word_x = await word_x.save();

    res.json(word_x);

  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

defaultRouter.post("/api/update-favorite", async (req, res) => {
  try {
    const { id, favorite } = req.body;
    
    let word_x = await Word.findById(id);

    word_x.favorite = favorite; 

    word_x = await word_x.save();

    res.json(word_x);

  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

defaultRouter.get("/api/get-all-words-fav" ,async (req, res) => {
  try {
    const favorite = 'yes';
    const words = await Word.find({favorite});
    res.json(words);

  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});


module.exports = defaultRouter;
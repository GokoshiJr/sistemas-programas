const express = require("express");
const router = express.Router();
const pool = require("../database");

router.get('/', (req, res)=>{
  if (req.session.user_logeado) {
    res.send(`Bienvenido ${req.session.user_id}`)
  } else {
    res.redirect("/home")
  }
});

module.exports = router;
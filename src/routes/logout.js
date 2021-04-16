const express = require("express");
const router = express.Router();
const pool = require("../database");

router.get('/', (req, res) => {
  // desactivamos la bandera user_logeado
  req.session.user_logeado = false;
  req.session.cargo_id = 0;
  res.redirect("/home");
});

module.exports = router;

const express = require("express");
const router = express.Router();
const pool = require("../database");

// GET - users/login
router.get("/login", async(req, res) => {
  res.render("users/login"); // views/users/login.hbs
});

// POST - users/login
router.post("/login", async(req, res) => {
  // Se comprueba con la base de datos, si falla deberiamos hacer en partials algo para los errores
  const {email, password} = req.body;

  console.log(`Email: ${email} \n Password: ${password}`);

  res.send(`Email: ${email} \n Password: ${password}`);
});

module.exports = router;

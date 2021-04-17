const express = require("express");
const router = express.Router();
const pool = require("../database");

router.get("/home", async(req, res) => {
  res.redirect("/users/login")
});

module.exports = router;
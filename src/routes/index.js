const express = require("express");
const router = express.Router();
const pool = require("../database");

router.get("/", async (req, res) => {
  res.send("Hola mundo")
  const data = await pool.query("SELECT * FROM estatus");
  console.log(data);
});

module.exports = router;

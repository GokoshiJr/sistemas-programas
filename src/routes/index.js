const express = require("express");
const router = express.Router();
const pool = require("../database");

router.get("/", async(req, res) => {
  res.redirect("/home")
});

router.get("/home", async (req, res) => {

  const rutas_home = [
    {nombre: "Ruta1", ruta: "/#"},
    {nombre: "Ruta2", ruta: "/#"},
    {nombre: "Ruta3", ruta: "/#"},
    {nombre: "Ruta4", ruta: "/#"}
  ];

  res.render("home", { rutas_home });

  /* 
  const data = await pool.query("SELECT * FROM estatus");
  console.log(data); 
  */

});

module.exports = router;

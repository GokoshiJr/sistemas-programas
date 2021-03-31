const express = require("express");
const router = express.Router();
const pool = require("../database");

router.get("/", async(req, res) => {
  res.redirect("/home")
});

router.get("/home", async (req, res) => {

  const rutas_home = [
    {nombre: "About", ruta: "/#"},
    {nombre: "Events", ruta: "/#"},
    {nombre: "Info", ruta: "/#"},
    {nombre: "Ruta4", ruta: "/#"}
  ];

  const ruta_login = {
    nombre: "Login",
    ruta: "/users/login"
  };

  res.render("home", { rutas_home, ruta_login });

  /* 
  const data = await pool.query("SELECT * FROM estatus");
  console.log(data); 
  */

});

module.exports = router;

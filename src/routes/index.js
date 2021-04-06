const express = require("express");
const router = express.Router();
const pool = require("../database");

router.get("/", async(req, res) => {
  res.redirect("/home")
});

router.get("/home", async (req, res) => {

  const rutas_home = [
    {nombre: "Usuarios", ruta: "/users"},
    {nombre: "Reglamento", ruta: "/#"},
  ];

  const ruta_login = {
    nombre: "Login",
    ruta: "/users/login"
  };

  const rutas_contacto = [
    {nombre: "twitter", ruta: "https://twitter.com/GokoshiJr"},
    {nombre: "github", ruta: "https://github.com/GokoshiJr/sistemas-programas"}
  ];

  res.render("home", { rutas_home, ruta_login, rutas_contacto });

});

module.exports = router;

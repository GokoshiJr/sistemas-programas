const express = require("express");
const router = express.Router();
const pool = require("../database");

router.get("/", async(req, res) => {
  res.redirect("/home")
});

router.get("/home", async (req, res) => {

  let rutas_home = [];

  let ruta_login = {
    nombre: "Login",
    ruta: "/users/login"
  };

  const rutas_contacto = [
    {nombre: "twitter", ruta: "https://twitter.com/GokoshiJr"},
    {nombre: "github", ruta: "https://github.com/GokoshiJr/sistemas-programas"}
  ];

  if (req.session.user_logeado === true && req.session.cargo_id === 1) {
    // cargo_id == 1 (Administrador)
    rutas_home = [
      {nombre: "Instrucciones", ruta: "/instrucciones"},
      {nombre: "Reglamento", ruta: "/#"},
      {nombre: "Vista General", ruta: "/administrador"},
      {nombre: "Salir", ruta: "/logout"},
      {nombre: "Salir", ruta: "/logout"},
    ];
    // Vaciamos la ruta de login porque ya esta logeado el usuario
    ruta_login = {};
  }

  res.render("home", { rutas_home, ruta_login, rutas_contacto });

});

module.exports = router;

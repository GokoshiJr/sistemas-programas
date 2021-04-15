const express = require("express");
const router = express.Router();
const pool = require("../database");

router.get('/', (req, res)=>{
  // res.send(`Bienvenido ${req.session.user_id}`)
  if (req.session.user_logeado === true) {
    let ruta_login = { ruta: "/logout", nombre: "Salir" }
    res.render("administrador/request", { ruta_login });
  } else {
    res.redirect("/home")
  }
});

module.exports = router;
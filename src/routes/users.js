const express = require("express");
const router = express.Router();
const pool = require("../database");

router.get("/users/login", async(req,res)=>{
    res.render("users/login");
  });

router.post("/users/login", async(req,res)=>{
  const {email,password} = req.body;
  console.log(`Email: ${email} \n Password: ${password}`);
  res.send(`Email: ${email} \n Password: ${password}`)
  //Se comprueba con la base de datos, si falla deberiamos hacer en partials algo para los errores
});

module.exports = router;
const { Router } = require("express");
const express = require("express");
const router = express.Router();
const pool = require("../database");


router.get('/', (req, res)=>{
    res.send(`Bienvenido ${req.session.user_id}`)
})
module.exports = router;
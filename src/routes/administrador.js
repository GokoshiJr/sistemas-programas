const express = require("express");
const router = express.Router();
const pool = require("../database");
const helpers = require("../lib/handlebars");

router.get('/', async (req, res) => {
  if (req.session.user_logeado === true) {
    const rutas_home = [  
      {nombre: "Salir", ruta: "/logout"},
    ];
    const rutas_contacto = [
      {nombre: "twitter", ruta: "https://twitter.com/GokoshiJr"},
      {nombre: "github", ruta: "https://github.com/GokoshiJr/sistemas-programas"}
    ];

    const productos = await pool.query("SELECT COUNT(*), SUM(cantidad) AS cantidad, nombre FROM productos WHERE almacen_id = 1 GROUP BY nombre ");
    
    productos.forEach(producto => {      
      codigo = helpers.codigo_productos(producto.nombre)
      codigo.then((value) => {        
        producto.codigo = value;
      });
    });

    const instrucciones = await pool.query(
      "SELECT especificacion, tipoinstrucciones.nombre AS tipo, productos.nombre AS producto FROM ((instrucciones "+
      "INNER JOIN productos ON instrucciones.producto_id = productos.producto_id) "+
      "INNER JOIN tipoinstrucciones ON instrucciones.tipoinstruccion_id = tipoinstrucciones.tipoinstruccion_id);"
    );

    res.render("administrador/request", { rutas_home, rutas_contacto, productos, instrucciones });
  } else {
    res.redirect("/home");
  }
});

module.exports = router;
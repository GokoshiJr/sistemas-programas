const express = require("express");
const router = express.Router();
const pool = require("../database");
const helpers = require("../lib/handlebars");

router.get('/', async (req, res) => {

  if (req.session.user_logeado === true && req.session.cargo_id === 1) {

    const rutas_home = [  
      {nombre: "Salir", ruta: "/logout"},
    ];

    const rutas_contacto = [
      {nombre: "twitter", ruta: "https://twitter.com/GokoshiJr"},
      {nombre: "github", ruta: "https://github.com/GokoshiJr/sistemas-programas"}
    ];

    const productos_norte = await pool.query(
      "SELECT COUNT(*), SUM(cantidad) AS cantidad, nombre FROM productos WHERE almacen_id = 1 GROUP BY nombre;"
    );

    productos_norte.forEach(producto => {      
      codigo = helpers.codigo_productos(producto.nombre)
      codigo.then((value) => {        
        producto.codigo = value;
      });
    });

    productos_norte.forEach(producto => {      
      tipo = helpers.tipo_productos(producto.nombre)
      tipo.then((value) => {        
        producto.tipo = value;
      });
    });
    
    const productos_sur = await pool.query(
      "SELECT COUNT(*), SUM(cantidad) AS cantidad, nombre FROM productos WHERE almacen_id = 2 GROUP BY nombre "
    );

    productos_sur.forEach(producto => {      
      codigo = helpers.codigo_productos(producto.nombre)
      codigo.then((value) => {        
        producto.codigo = value;
      });
    });

    productos_sur.forEach(producto => {      
      tipo = helpers.tipo_productos(producto.nombre)
      tipo.then((value) => {        
        producto.tipo = value;
      });
    });
    
    const instrucciones_norte = await pool.query(
      "SELECT instruccion_id AS id, especificacion, cantidad_producto AS cantidad, tipoinstrucciones.nombre AS tipo, productos.nombre AS producto FROM ((instrucciones "+
      "INNER JOIN productos ON instrucciones.producto_id = productos.producto_id) "+
      "INNER JOIN tipoinstrucciones ON instrucciones.tipoinstruccion_id = tipoinstrucciones.tipoinstruccion_id) WHERE estatusinstruccion_id = 5 AND instrucciones.almacen_id = 1;"
    );

    const instrucciones_sur = await pool.query(
      "SELECT instruccion_id AS id, especificacion, cantidad_producto AS cantidad, tipoinstrucciones.nombre AS tipo, productos.nombre AS producto FROM ((instrucciones "+
      "INNER JOIN productos ON instrucciones.producto_id = productos.producto_id) "+
      "INNER JOIN tipoinstrucciones ON instrucciones.tipoinstruccion_id = tipoinstrucciones.tipoinstruccion_id) WHERE estatusinstruccion_id = 5 AND instrucciones.almacen_id = 2;"
    );

    const instrucciones = await pool.query(
      "SELECT instruccion_id AS id, estatusinstrucciones.nombre AS estatus, cantidad_producto AS cantidad, tipoinstrucciones.nombre AS tipo, productos.nombre AS producto FROM (((instrucciones "+
      "INNER JOIN productos ON instrucciones.producto_id = productos.producto_id) "+
      "INNER JOIN tipoinstrucciones ON instrucciones.tipoinstruccion_id = tipoinstrucciones.tipoinstruccion_id) "+
      "INNER JOIN estatusinstrucciones ON instrucciones.estatusinstruccion_id = estatusinstrucciones.estatusinstruccion_id) WHERE instrucciones.estatusinstruccion_id <> 5;"
    );
    
    res.render("administrador/request", { rutas_home, rutas_contacto, productos_norte, productos_sur, instrucciones_norte, instrucciones_sur, instrucciones });

  } else {
    res.redirect("/home");
  }

});

router.post("/autorizar/:id", async(req, res) => {
  if (req.session.user_logeado === true && req.session.cargo_id === 1) {
    await pool.query(
      "UPDATE instrucciones SET estatusinstruccion_id = 1 WHERE instruccion_id = ?", [req.params.id]
    );
    req.flash("success", "Tarea autorizada con éxito");
  }
  res.redirect("/administrador");
});

router.post("/denegar/:id", async(req, res) => { 
  if (req.session.user_logeado === true && req.session.cargo_id === 1) {
    await pool.query(
      "UPDATE instrucciones SET estatusinstruccion_id = 2 WHERE instruccion_id = ?", [req.params.id]
    );
    req.flash("success", "Tarea denegada con éxito");
  }
  res.redirect("/administrador");
});

module.exports = router;
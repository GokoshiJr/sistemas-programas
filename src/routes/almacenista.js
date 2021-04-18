const express = require("express");
const router = express.Router();
const pool = require("../database");
const helpers = require("../lib/handlebars");

router.get('/', async (req, res) => {

  if (req.session.user_logeado === true && req.session.cargo_id === 3) {
    
    const rutas_home = [
      {nombre: "Salir", ruta: "/logout"}
    ];

    const rutas_contacto = [
      {nombre: "twitter", ruta: "https://twitter.com/GokoshiJr"},
      {nombre: "github", ruta: "https://github.com/GokoshiJr/sistemas-programas"}
    ];
    const empleado = await pool.query(
      "SELECT nombre, apellido, fecha_nacimiento, cedula, telefono, a.sector AS almacen FROM empleados INNER JOIN almacenes AS a "+
      "ON a.almacen_id = empleados.almacen_id where empleado_id = ?", [req.session.user_id]
    );
    
    let almacen_id = await pool.query(
      "SELECT empleados.almacen_id FROM empleados INNER JOIN almacenes AS a "+
      "ON a.almacen_id = empleados.almacen_id where empleado_id = ?", [req.session.user_id]
    );

    almacen_id = almacen_id[0].almacen_id;

    const productos = await pool.query(
      "SELECT COUNT(*), SUM(cantidad) AS cantidad, nombre FROM productos WHERE almacen_id = ? GROUP BY nombre;", [ almacen_id ]
    );

    productos.forEach(producto => {      
      codigo = helpers.codigo_productos(producto.nombre)
      codigo.then((value) => {        
        producto.codigo = value;
      });
    });
    productos.forEach(producto => {      
      tipo = helpers.tipo_productos(producto.nombre)
      tipo.then((value) => {        
        producto.tipo = value;
      });
    });

    const instrucciones = await pool.query(
      "SELECT almacenes.sector AS almacen, instruccion_id AS id, estatusinstrucciones.nombre AS estatus, cantidad_producto AS cantidad, tipoinstrucciones.nombre AS tipo, productos.nombre AS producto, especificacion FROM ((((instrucciones "+
      "INNER JOIN productos ON instrucciones.producto_id = productos.producto_id) "+
      "INNER JOIN tipoinstrucciones ON instrucciones.tipoinstruccion_id = tipoinstrucciones.tipoinstruccion_id) "+
      "INNER JOIN estatusinstrucciones ON instrucciones.estatusinstruccion_id = estatusinstrucciones.estatusinstruccion_id) "+
      "INNER JOIN almacenes ON instrucciones.almacen_id = almacenes.almacen_id) WHERE (instrucciones.estatusinstruccion_id = 1 AND almacenes.almacen_id = ?);", [ almacen_id ]
    );

    res.render("almacenista/request", { rutas_home, rutas_contacto, empleado, productos, instrucciones });
  } else {
    res.redirect("/home");
  }

});

router.post('/:id', async (req, res) => {

  if (req.session.user_logeado === true && req.session.cargo_id === 3) {
    let instruccion_id = req.params.id;
    /*

      Aqui va la logica para marcar la instruccion como ejecutada
    
    */
  } else {
    res.redirect("/home");
  }

});

module.exports = router;

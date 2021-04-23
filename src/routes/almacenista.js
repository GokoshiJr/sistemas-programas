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
      "SELECT almacenes.sector AS almacen, instruccion_id AS id, estatusinstrucciones.nombre AS estatus, cantidad_producto AS cantidad, tipoinstrucciones.nombre AS tipo,tipoinstrucciones.tipoinstruccion_id AS tipo_id, productos.nombre AS producto, productos.codigo AS codigo, especificacion FROM ((((instrucciones "+
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

router.post("/:id/:codigo", async (req, res) => {

  if (req.session.user_logeado === true && req.session.cargo_id === 3) {

    let instruccion_id = req.params.id;
    let codigo = req.params.codigo;
    let cant_update;
    const { tipo_id, cant} = req.body;
    const total_product = await pool.query("SELECT cantidad from productos where codigo = ?", [codigo]);

    if (parseInt(tipo_id) == 2) {

      /* Tipo de instruccion_id = 2 (Salida de productos)*/

      if (total_product[0].cantidad >= cant) {
        cant_update = total_product[0].cantidad - parseInt(cant);
        await pool.query("UPDATE instrucciones SET estatusinstruccion_id = 6 where instruccion_id = ?", [instruccion_id]);
        await pool.query("UPDATE productos SET cantidad = ? WHERE codigo = ?", [cant_update,codigo]);
        req.flash("success", "Operación Satisfactoria");
      } else {
        /* Los productos a salir superan a los que estan en el stock */        
        req.flash("danger", "No hay suficientes lotes en Stock para realizar esta Accion");
      }

    } else {

      /* Tipo de instruccion_id = 1 (Entrada de productos)*/

      cant_update = total_product[0].cantidad + parseInt(cant);
      await pool.query("UPDATE instrucciones SET estatusinstruccion_id = 6 where instruccion_id = ?", [instruccion_id]);
      await pool.query("UPDATE productos SET cantidad = ? WHERE codigo = ?", [cant_update, codigo]);
      req.flash("success", "Operación Satisfactoria");

    }

    res.redirect("/almacenista");

  } else {

    res.redirect("/home");

  }

});

module.exports = router;

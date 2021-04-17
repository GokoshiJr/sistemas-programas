const express = require("express");
const router = express.Router();
const pool = require("../database");

router.get('/', async(req, res)=>{
  if (req.session.user_logeado && req.session.cargo_id === 2) {

    const rutas_home = [  
      {nombre: "Salir", ruta: "/logout"},
    ];
    const rutas_contacto = [
      {nombre: "github", ruta: "https://github.com/GokoshiJr/sistemas-programas"}
    ];
    const productos = await pool.query("SELECT producto_id, codigo, productos.nombre as producto, cantidad, tipoproductos.nombre as tipoproducto "+
    "FROM productos INNER JOIN tipoproductos ON productos.tipoproducto_id =  tipoproductos.tipoproducto_id "+
    "where almacen_id = ?", [req.session.almacen_id]);

    productos.forEach(element => {
      if(element.cantidad == 0){
        element.cantidad = null;
      }  
    });
    
    const instrucciones = await pool.query("SELECT * FROM tipoinstrucciones");
    const empleado = await pool.query("SELECT nombre, apellido, fecha_nacimiento ,cedula ,telefono, a.sector as almacen FROM empleados INNER JOIN almacenes as a"+
     " ON a.almacen_id = empleados.almacen_id where empleado_id = ?",[req.session.user_id]);
    const conexiones = await pool.query("SELECT *  FROM usuarios where empleado_id = ?", [req.session.user_id]);
    
    res.render('supervisor/supervisor',{rutas_home, rutas_contacto ,productos,instrucciones, empleado,conexiones})
  } else {
    res.redirect("/home")
  }
});

router.post('/',(req,res)=>{
  const data = req.body;

  pool.query("INSERT INTO instrucciones values(NULL,?,?,?,?,?,5)",[parseInt(data.tipoinstruccion_id),
  parseInt(data.producto_id), parseInt(data.cant), data.espec, req.session.almacen_id]);
  
  req.flash('success', "Intruccion enviada satisfactoriamente")
  res.redirect('/supervisor')
})
module.exports = router;
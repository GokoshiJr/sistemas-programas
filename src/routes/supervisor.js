const express = require("express");
const router = express.Router();
const pool = require("../database");

router.get('/', async(req, res)=>{
  if (req.session.user_logeado) {
    console.log(req.session)
    const productos = await pool.query("SELECT codigo, productos.nombre as producto, cantidad, tipoproductos.nombre as tipoproducto "+
    "FROM productos INNER JOIN tipoproductos ON productos.tipoproducto_id =  tipoproductos.tipoproducto_id "+
    "where almacen_id = ?", [req.session.almacen_id]);
    productos.forEach(element => {
      if(element.cantidad == 2){
        element.cantidad = null;
      }  
    });
    const instrucciones = await pool.query("SELECT * FROM instrucciones");
    const empleado = await pool.query("SELECT * FROM empleados where empleado_id = ?",[req.session.user_id]);
    const conexiones = await pool.query("SELECT *  FROM usuarios where empleado_id = ?", [req.session.user_id]);
    
    console.log(empleado[0].fecha_nacimiento)
    res.render('supervisor/supervisor',{productos,instrucciones, empleado,conexiones})
  } else {
    res.redirect("/home")
  }
});

router.post('/',(req,res)=>{
  const datos_instruccion = req.body;
  //enviar instrucciones (redirect)
})
module.exports = router;
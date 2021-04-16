const pool = require("../database");

const helpers = {};

helpers.codigo_productos = async(name) => {
  let codigo = await pool.query("SELECT codigo FROM productos WHERE nombre = ?", [name]);
  codigo = codigo[0].codigo;
  return codigo;
}

helpers.tipo_productos = async(name) => {
  let tipo = await pool.query(
    "SELECT tipoproductos.nombre AS tipop FROM productos "+
    "INNER JOIN tipoproductos ON productos.tipoproducto_id = tipoproductos.tipoproducto_id WHERE productos.nombre = ?", [name]
  );
  tipo = tipo[0].tipop;
  return tipo;
}

module.exports = helpers
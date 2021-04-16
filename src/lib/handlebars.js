const pool = require("../database");

const helpers = {};

helpers.codigo_productos = async(name) => {
  let codigo = await pool.query("SELECT codigo FROM productos WHERE nombre = ?", [name]);
  codigo = codigo[0].codigo;
  
  return codigo;
}

module.exports = helpers
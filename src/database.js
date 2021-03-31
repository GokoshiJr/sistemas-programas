const mysql = require("mysql"); // controlador de MySQL
const { promisify } = require("util"); // Para manejar promesas en los querys
const { database } = require("./keys"); // Import de la BD
const pool = mysql.createPool(database); // Inicializamos (conexion a la bd)

pool.getConnection((err, conexi) => {
  if (err) {
    // en caso de error, muestralo
    console.log(
      `Error to Connect MySql \nCode: ${err.code} \nErrno: ${err.errno} \nSqlMessage: ${err.sqlMessage} \nSql State: ${err.sqlState}`
    );
    console.log(err);
  }
  if (conexi) {
    conexi.release(); // lanza la conexion
    const db_info = {
      port: conexi.config.port,
      host: conexi.config.host,
      name: conexi.config.database,
    };
    console.log(
      `MySQL Conection Successfully \nDB Name: ${db_info.name} \nDB Host: ${db_info.host} \nDB Port: ${db_info.port}`
    );
  }
  return;
});

pool.query = promisify(pool.query);
module.exports = pool;

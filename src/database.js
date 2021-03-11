const mysql = require("mysql");
const { promisify } = require("util");
const { database } = require("./keys");
const pool = mysql.createPool(database);

pool.getConnection((err, conexi) => {
  if (err) {
    console.log(`Error to Connect MySql \nCode: ${err.code} \nErrno: ${err.errno} \nSqlMessage: ${err.sqlMessage} \nSql State: ${err.sqlState}`);
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

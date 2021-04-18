const express = require("express");
const router = express.Router();
const pool = require("../database");

router.get("/login", async(req, res) => {
  if (req.session.user_logeado) {
    if (req.session.cargo_id === 3) { res.redirect("/almacenista") }
    else if (req.session.cargo_id === 2) { res.redirect("/supervisor") }
    else if (req.session.cargo_id === 1) { res.redirect("/administrador")}
  } else {
    const rutas_contacto = [{ nombre: "github", ruta: "https://github.com/GokoshiJr/sistemas-programas" }];
    res.render("users/login",{ rutas_contacto });
  }
});

router.post("/login", async(req, res) => {

  const { email, password } = req.body;
  const dato = await pool.query(
    "SELECT correo, clave, empleado_id FROM usuarios WHERE correo = ? AND clave = ?", [ email, password ]
  );
  
  if (dato[0] == null) {

    req.flash("danger", "Datos invalidos");
    res.render("users/login", req.session.flash);

  } else {

    req.session.user_id = dato[0].empleado_id;
    data =  await pool.query(
      "SELECT cargo_id, almacen_id FROM empleados WHERE empleado_id = ? ", [ req.session.user_id ]
    );

    const test = await pool.query(
      "SELECT empleados.nombre, empleados.apellido, usuarios.ultima_conexion FROM usuarios, empleados WHERE empleados.empleado_id = ?", [ req.session.user_id ]
    );

    await pool.query(
      "UPDATE usuarios SET ultima_conexion = NOW() WHERE usuario_id = ?", [ req.session.user_id ]
    );

    req.session.cargo_id = data[0].cargo_id;
    req.session.almacen_id = data[0].almacen_id;
    req.session.user_logeado = true;
    
    req.flash("success", `Bienvenido ${test[1].nombre} ${test[1].apellido}, última conexión fue ${test[0].ultima_conexion}`);
    
    if (req.session.cargo_id === 3) { res.redirect("/almacenista") }
    else if (req.session.cargo_id === 2) { res.redirect("/supervisor") }
    else if (req.session.cargo_id === 1) { res.redirect("/administrador")} 
  }
});

router.get("/", async(req, res) => {
  if (req.session.user_logeado && req.session.cargo_id === 2) {
    res.redirect("/users/request");
  } else {
    res.redirect("/home");
  }
});

router.get("/request", async(req, res) => {
  if (req.session.user_logeado && req.session.cargo_id === 2) {
    const data = await pool.query(
      "SELECT usuario_id, empleados.empleado_id, correo, clave, almacenes.sector as sector FROM usuarios "+
      "INNER JOIN empleados ON empleados.empleado_id = usuarios.empleado_id "+
      "INNER JOIN almacenes ON almacenes.almacen_id = empleados.almacen_id"
    );
    res.render("users/request", { data });
  } else {
    res.redirect("/home");
  }
});

router.get("/create", async(req, res) => {
  if (req.session.user_logeado && req.session.cargo_id === 2) {
    /*
      Con el left join solo nos van aparecer los empleados que no tengan un 
      usuario creado
    */
    const data = await pool.query(
      "SELECT empleados.nombre AS nombre, empleados.apellido AS apellido, usuarios.usuario_id AS usuario_id, " + 
      "empleados.empleado_id AS empleado_id FROM empleados " +
      "LEFT JOIN usuarios ON empleados.empleado_id = usuarios.empleado_id WHERE usuario_id IS NULL;"
    );
    res.render("users/create", { data });
  } else {
    res.redirect("/home");
  }
});

router.post("/create", async(req, res) => {
  if (req.session.user_logeado && req.session.cargo_id === 2) {
    const { correo, clave, empleado_id } = req.body;
    await pool.query(
      "INSERT INTO usuarios " +
      "VALUES (NULL,?, ?, ?, ?);", [empleado_id, correo, clave, new Date()]
    );
    res.redirect("/users");
  } else {
    res.redirect("/home");
  }
});

router.get("/update/:id", async(req, res) => {
  if (req.session.user_logeado && req.session.cargo_id === 2) {
    let { id } = req.params;
    data = await pool.query(
      "SELECT * FROM usuarios WHERE usuario_id = ?;", [id]
    );
    res.render("users/update", { data });
  } else {
    res.redirect("/home");
  }
});

router.post("/update/:id", async(req, res) => {
  if (req.session.user_logeado && req.session.cargo_id === 2) {
    const { correo, clave } = req.body;
    const { id } = req.params;
    await pool.query(
      "UPDATE usuarios SET correo = ?, clave = ? WHERE usuario_id = ?;", [correo, clave, id]
    );
    res.redirect("/users");
  } else {
    res.redirect("/home");
  }
});

router.get("/delete/:id", async(req, res) => {
  if (req.session.user_logeado && req.session.cargo_id === 2) {
    let { id } = req.params;
    await pool.query(
      "UPDATE usuarios SET estatus_id = ? WHERE usuario_id = ?;", [2, id]
    );
    res.redirect("/users");
  } else {
    res.redirect("/home");
  }
});

module.exports = router;
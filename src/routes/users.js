const express = require("express");
const router = express.Router();
const pool = require("../database");

router.get("/login", async(req, res) => {
  res.render("users/login");
});

router.post("/login", async(req, res) => {

  const { email, password} = req.body;
  const dato = await pool.query(
    'Select correo, clave, empleado_id from usuarios where correo = ? AND clave = ?', [ email, password ]
  );
  
  if (dato[0] == null) {
    req.flash("danger", "Correo o contrasena erronea")
    res.render('users/login',req.session.flash);
  } else {

    req.session.user_id = dato[0].empleado_id;
    data =  await pool.query(
      "SELECT cargo_id, almacen_id FROM empleados WHERE empleado_id = ? ", [req.session.user_id]
    );
    const test = await pool.query(
      'Select empleados.nombre, empleados.apellido, usuarios.ultima_conexion FROM usuarios, empleados WHERE empleados.empleado_id = ?', [ req.session.user_id ]
    );
    req.session.cargo_id = data[0].cargo_id;
    req.session.almacen_id = data[0].almacen_id;
    req.session.user_logeado = true;
    
    req.flash("success", `Bienvenido ${test[1].nombre} ${test[1].apellido}, última conexión fue ${test[1].ultima_conexion}`);
    if (req.session.cargo_id === 3) {
      res.redirect("/almacenista");
    } else if (req.session.cargo_id === 2) {
      res.redirect("/supervisor");
    } else {  
      res.redirect("/administrador");
      await pool.query(
        "UPDATE usuarios SET ultima_conexion = NOW() WHERE usuario_id = ?", [ req.session.user_id ]
      );
    }

  }
});

router.get("/", async(req, res) => {
  res.redirect("/users/request")
});

// GET - users/request
router.get("/request", async(req, res) => {
  const data = await pool.query(
    "SELECT usuario_id, empleados.empleado_id, correo, clave, estatus.nombre AS estatus, almacen.sector as sector FROM usuarios "+
    "INNER JOIN estatus ON estatus.estatus_id = usuarios.estatus_id "+
    "INNER JOIN empleados ON empleados.empleado_id = usuarios.empleado_id "+
   "INNER JOIN almacen ON almacen.almacen_id = empleados.almacen_id WHERE (usuarios.estatus_id = 1) "
  );
  res.render("users/request", { data });
});

// GET - users/create
router.get("/create", async(req, res) => {
  const data = await pool.query(
    "SELECT empleados.nombre AS nombre, empleados.apellido AS apellido, usuarios.usuario_id AS usuario_id, " + 
    "empleados.empleado_id AS empleado_id FROM empleados " +
    "LEFT JOIN usuarios ON empleados.empleado_id = usuarios.empleado_id WHERE usuario_id IS NULL;"
  );
  res.render("users/create", { data });
});

// POST - users/create
router.post("/create", async(req, res) => {
  const { correo, clave, empleado_id } = req.body;
  /*
    Con el left join solo nos van aparecer los empleados que no tengan un 
    usuario creado
  */
  await pool.query(
    "INSERT INTO usuarios (empleado_id, correo, clave, fecha_registro, ultima_conexion, estatus_id) " +
    "VALUES (?, ?, ?, ?, ?, ?);", [empleado_id, correo, clave, new Date(), new Date(), 1]
  );
  res.redirect("/users");
});

// GET - users/update
router.get("/update/:id", async(req, res) => {
  let { id } = req.params;
  data = await pool.query(
    "SELECT * FROM usuarios WHERE usuario_id = ?;", [id]
  );
  res.render("users/update", { data });
});

router.post("/update/:id", async(req, res) => {
  const { correo, clave } = req.body;
  const { id } = req.params;
  await pool.query(
    "UPDATE usuarios SET correo = ?, clave = ? WHERE usuario_id = ?;", [correo, clave, id]
  );
  res.redirect("/users")
});

router.get("/delete/:id", async(req, res) => {
  let { id } = req.params;
  await pool.query(
    "UPDATE usuarios SET estatus_id = ? WHERE usuario_id = ?;", [2, id]
  );
  res.redirect("/users");
});

module.exports = router;
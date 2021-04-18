const express = require("express"); // framework de node
const morgan = require("morgan"); // middleware
const exphbs = require("express-handlebars"); // extension al motor de plantilla
const { urlencoded } = require("express"); // recibir los datos del form html
const path = require("path"); // nativo de node - para manejar ruta de archivos
const flash = require("connect-flash"); // para enviar mensajes a las vistas
const session = require("express-session")
// initializations
const app = express();

// settings
app.set("port", process.env.port || 3000);
app.set("views", path.join(__dirname, "views"));
// motor de plantilla
app.engine(
  ".hbs",
  exphbs({
    defaultLayout: "main", // partes comunes de la navegacion
    layoutsDir: path.join(app.get("views"), "layouts"), // donde estan los layouts viwes/layouts
    partialsDir: path.join(app.get("views"), "partials"), // donde estan los partials views/partials
    extname: ".hbs", // extension mas resumida
    helpers: require("./lib/handlebars"), // para usar las funciones que estan en lib/
  })
);
// para usar el view engine que configuramos arriba, hbs
app.set("view engine", ".hbs");

// config express session
app.use(session({ // config de la sesion
  secret: "session", // nombre
  resave: false, // para que no se renueve
  saveUninitialized: false, // para que no se vuelva a establecer
  //store: new MySQLStore(database) // donde guardar la sesion
}));
// middlewares
app.use(morgan("dev"));
app.use(urlencoded({ extended: false })); // urlencoded para recibir los datos de los formularios html, extended false (no imagenes)
app.use(express.json()); // para enviar-recibir json
app.use(flash()); // para enviar mensajes

// global variables
app.use((req, res, next) => {
  // middleware
  /*
    req, toma la info del usuario 
    res, toma lo que el servidor quiere responder
    next, una funcion para continuar con el resto del codigo
  */
  app.locals.success = req.flash("success"); // mensaje success "alert"
  app.locals.danger = req.flash("danger");
  next();
});

// routes
app.use("/", require("./routes/index"));
app.use("/logout", require("./routes/logout"));
app.use("/users", require("./routes/users"));
app.use("/administrador", require("./routes/administrador"));
app.use("/supervisor", require("./routes/supervisor"));
app.use("/almacenista", require("./routes/almacenista"));

// public - para usar archivos estaticos
app.use("/public", express.static(path.join(__dirname, "public")));

// strating the server
app.listen(app.get("port"), () => {
  console.log(`Server on port`, app.get("port"));
});

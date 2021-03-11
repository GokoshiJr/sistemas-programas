const express = require("express"); // framework de node
const morgan = require("morgan"); // middleware
const exphbs = require("express-handlebars"); // extension al motor de plantilla
const { urlencoded } = require("express"); // recibir los datos del form html
const path = require("path"); // nativo de node - para manejar ruta de archivos

// initializations
const app = express();

// settings
app.set("port", process.env.port || 3000);
app.set("views", path.join(__dirname, "views"));
// motor de plantilla
app.engine(".hbs", exphbs({
  defaultLayout: "main", // partes comunes de la navegacion
  layoutsDir: path.join(app.get("views"), "layouts"), // donde estan los layouts viwes/layouts
  partialsDir: path.join(app.get("views"), "partials"), // donde estan los partials views/partials
  extname: ".hbs", // extension mas resumida
  helpers: require("./lib/handlebars"), // para usar las funciones que estan en lib/
}));
app.set("view engine", ".hbs");

// middlewares
app.use(morgan("dev"));
app.use(urlencoded({ extended: false })); // urlencoded para recibir los datos de los formularios html, extended false (no imagenes)
app.use(express.json()); // para enviar-recibir json

// global variables
app.use((req, res, next) => {
  // middleware
  /*
    req, toma la info del usuario 
    res, toma lo que el servidor quiere responder
    next, una funcion para continuar con el resto del codigo
  */
  next();
});

// routes
app.use("/", require("./routes/index"));

// public
app.use("/public", express.static(path.join(__dirname, "public")));

// strating the server
app.listen(app.get("port"), () => {
  console.log(`Server on port`, app.get("port"));
});

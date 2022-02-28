const mysql = require("mysql");
require("dotenv").config();

let db;
console.log(
  process.env.DB_host,
  process.env.DB_user,
  process.env.DB_password,
  process.env.DB_database
);
function connectDatabase() {
  if (!db) {
    db = mysql.createConnection({
      host: process.env.DB_host,
      user: process.env.DB_user,
      password: process.env.DB_password,
      database: process.env.DB_database,
    });

    db.connect(function (err) {
      if (!err) {
        console.log("Database is connected!");
      } else {
        console.log(err);
        console.log("Error connecting database!");
      }
    });
  }

  return db;
}

module.exports = connectDatabase();

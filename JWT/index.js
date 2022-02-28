const jwt = require("jsonwebtoken");
require("dotenv").config();

const signToken = (id) => {
  return new Promise((resolve, reject) => {
    jwt.sign({ id }, process.env.private_key, (err, token) => {
      if (err) {
        reject("WRONG CREDS");
      }
      if (token) {
        resolve(token);
      }
    });
  });
};

const verifyToken = (token) => {
  return new Promise((resolve, reject) => {
    jwt.verify(token, process.env.private_key, (err, decode) => {
      if (err) {
        reject("WRONG CRED");
      }
      if (decode) {
        resolve(decode);
      }
    });
  });
};

module.exports = {
  signToken,
  verifyToken,
};

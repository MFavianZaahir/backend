const jsonwebtoken = require("jsonwebtoken");
const SECRET_KEY = process.env.SECRET_KEY;
const cookieParser = require("cookie-parser");
const express = require("express");
const app = express();
app.use(cookieParser());

const mustLogin = async (req, res, next) => {
  try {
    const header = req.headers.authorization;
    if (!header) {
      return res.status(400).json({ message: "missing token" });
    }

    const token = header.split(" ")[1];
    let decodedToken;
    try {
      decodedToken = jsonwebtoken.verify(token, SECRET_KEY);
    } catch (error) {
      if (error instanceof jsonwebtoken.TokenExpiredError) {
        return res.status(400).json({ message: "token expired", err: error });
      }
      return res.status(400).json({ message: "invalid token", err: error });
    }

    // Store role in req.userData
    req.userData = {
      email: decodedToken.email,
      id_pelanggan: decodedToken.id_pelanggan,
      role: decodedToken.role
    };
    next();
  } catch (error) {
    console.error(error);
    return res.status(400).json({ message: "Authentication failed" });
  }
};


// Middleware to ensure user is admin
const mustAdmin = (req, res, next) => {
  const role = req.user?.role;

  if (!role || role !== "admin") {
    return res.status(403).json({ message: "Forbidden" });
  }

  next();
};

const mustReceptionist = (req, res, next) => {
  const role = req.user?.role;

  if (!role || role !== "resepsionis") {
    return res.status(403).json({ message: "Forbidden" });
  }

  next();
};

const auth = (req, res, next) => {
  let header = req.headers.authorization;
  let token = header && header.split(" ")[1];

  let jwtHeader = {
    algorithm: "HS256",
  };

  if (token == null) return res.status(401).json({ message: "Unauthorized" });

  jwt.verify(token, SECRET_KEY, jwtHeader, (err, usr) => {
    if (err) return res.status(401).json({ message: "Invalid Token" });
    next();
  });
};

module.exports = {
  auth,
  mustAdmin,
  mustReceptionist,
  mustLogin,
};

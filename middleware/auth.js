const jsonwebtoken = require("jsonwebtoken");
const SECRET_KEY = process.env.SECRET_KEY;
const cookieParser = require("cookie-parser");
const express = require("express");
const app = express();
app.use(cookieParser());

const mustLogin = async (req, res, next) => {
  //   console.log(req.cookie);
  try {
    const header = req.headers.authorization;
    if (header == null) {
      return res.status(400).json({
        message: "missing token",
        err: null,
      });
    }

    let token = header.split(" ")[1];
    const SECRET_KEY = "bzzzttt";

    let decodedToken;
    try {
      decodedToken = await jsonwebtoken.verify(token, SECRET_KEY);
    } catch (error) {
      if (error instanceof jsonwebtoken.TokenExpiredError) {
        return res.status(400).json({
          message: "token expired",
          err: error,
        });
      }
      return res.status(400).json({
        message: "invalid token",
        err: error,
      });
    }

    req.userData = decodedToken;
    next();
  } catch (error) {
    console.log(error);
    return res.status(400).json({
      message: error,
    });
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

    // req.user = usr;
    // console.log(req.user);
    next();
  });
};

module.exports = {
  auth,
  mustAdmin,
  mustReceptionist,
  mustLogin,
};

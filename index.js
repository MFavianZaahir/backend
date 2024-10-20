const express = require("express");
const cors = require("cors");
const dotenv = require("dotenv").config();
const path = require("path");
const moment = require("moment-timezone"); // Import moment-timezone
const app = express();
const PORT = process.env.SERVER_PORT || 8000;

// Your route imports
const user = require("./routes/user");
const pelanggan = require("./routes/pelanggan");
const tipe_kamar = require("./routes/tipe_kamar");
const kamar = require("./routes/kamar");
const pemesanan = require("./routes/pemesanan");
const detail_pemesanan = require("./routes/detail_pemesanan");
const filter_kamar = require("./routes/filter_kamar");
const bodyparser = require("body-parser");

app.use(
  cors({
    origin: "http://localhost:3000",
    credentials: true,
  })
);
app.use(bodyparser.json());
app.use(bodyparser.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, "public")));

// Your routes
app.use("/user", user);
app.use("/customer", pelanggan);
app.use("/room-type", tipe_kamar);
app.use("/room", kamar);
app.use("/booking", pemesanan);
app.use("/booking/detail", detail_pemesanan);
app.use("/filter", filter_kamar);

app.listen(PORT, () =>
  console.log(`Server started on http://localhost:${PORT} 🚀`)
);

process.on("uncaughtException", (error) => {
  console.error("Uncaught Exception:", error.message);
});

process.on("unhandledRejection", (error) => {
  console.error("Unhandled Rejection:", error.message);
});

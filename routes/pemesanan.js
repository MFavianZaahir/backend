// backend/routes/pemesanan.js
const express = require("express");
const { Op } = require("sequelize");

const {
  mustLogin,
  mustAdmin,
  mustReceptionist,
} = require("../middleware/auth");
const pelanggan = require("../models/index").pelanggan;
const pemesanan = require("../models/index").pemesanan;
const detail_pemesanan = require("../models/index").detail_pemesanan;
const kamar = require("../models/index").kamar;
const tipe_kamar = require("../models/index").tipe_kamar;
const cors = require("cors");

const app = express();
app.use(cors());

/**
 * @apiRoutes {get} /hotel/booking/
 * @apiName GetAllBooking
 * @apiGroup Booking
 * @apiDescription Get all booking data
 */
app.get("/", mustLogin, async (req, res) => {
  const email = req.userData?.email;
  const status = req.query.status || "";

  const filterConditions = [
    { status_pemesanan: { [Op.like]: `%${status}%` } }
  ];

  // If the user is a pelanggan, add email filter; otherwise, skip it
  if (req.userData.role === "pelanggan") {
    filterConditions.push({ "$pelanggan.email$": email });
  }

  try {
    const bookings = await pemesanan.findAll({
      where: {
        [Op.and]: filterConditions
      },
      include: [
        { model: pelanggan, as: "pelanggan" },
        { model: tipe_kamar, as: "tipe_kamar" }
      ]
    });

    res.json({ success: true, data: bookings });
  } catch (error) {
    console.error("Error fetching bookings:", error);
    res.status(500).json({ success: false, message: error.message });
  }
});

app.get(
  "/resepsionis",
  // mustLogin,
  async (req, res) => {
    let status = req.query.status || "";

    await pemesanan
      .findAll({
        where: {
          [Op.or]: [
            {
              status_pemesanan: { [Op.like]: `%${status}%` },
            },
          ],
        },
        include: ["pelanggan", "tipe_kamar"],
      })
      .then((result) => res.json({ data: result }))
      .catch((error) => res.json({ message: error.message }));
  }
);

/**
 * @apiRoutes {get} /hotel/booking/:id
 * @apiName GetBookingById
 * @apiGroup Booking
 * @apiDescription Get booking data by id
 */
app.get(
  "/:id",
  // mustLogin,
  async (req, res) => {
    let params = { id_pemesanan: req.params.id };

    await pemesanan
      .findOne({ where: params, include: ["user", "pelanggan", "tipe_kamar"] })
      .then((result) => res.json({ data: result }))
      .catch((error) => res.json({ message: error.message }));
  }
);

/**
 * @apiRoutes {get} /hotel/booking/customer/:id
 * @apiName GetBookingByCustomerId
 * @apiGroup Booking
 * @apiDescription Get booking data by customer id
 */
app.get(
  "/customer/:id",
   mustLogin,
  async (req, res) => {
    let params = { id_pelanggan: req.params.id };

    await pemesanan
      .findAll({ where: params, include: ["user", "pelanggan", "tipe_kamar"] })
      .then((result) => res.json({ data: result }))
      .catch((error) => res.json({ message: error.message }));
  }
);

/**
 * @apiRoutes {post} /hotel/booking/
 * @apiName PostBooking
 * @apiGroup Booking
 * @apiDescription Insert booking data
 */
app.post("/", mustLogin, async (req, res) => {
  try {
    const dt = Date.now();
    const receiptNum = Math.floor(Math.random() * (1000000000 - 99999999) + 99999999);
    const tgl_check_in = new Date(req.body.tgl_check_in);
    const tgl_check_out = new Date(req.body.tgl_check_out);

    let status_pemesanan;
    if (Date.now() < tgl_check_in) {
      status_pemesanan = "baru";
    } else if (Date.now() >= tgl_check_in && Date.now() < tgl_check_out) {
      status_pemesanan = "check_in";
    } else if (Date.now() >= tgl_check_out) {
      status_pemesanan = "check_out";
    }

    const data = {
      nomor_pemesanan: `WH-${receiptNum}`,
      tgl_pemesanan: dt,
      tgl_check_in: req.body.tgl_check_in,
      tgl_check_out: req.body.tgl_check_out,
      id_pelanggan: req.userData.id_pelanggan,
      nama_tamu: req.body.nama_tamu,
      jumlah_kamar: req.body.jumlah_kamar,
      id_tipe_kamar: req.body.id_tipe_kamar,
      status_pemesanan: status_pemesanan,
      email_pemesanan: req.body.email_pemesanan.toLowerCase(),
    };

    const pelangganRecord = await pelanggan.findOne({
      where: { email: { [Op.like]: data.email_pemesanan } }
    });
    if (!pelangganRecord) {
      return res.status(400).json({ message: "Invalid user" });
    }

    const dataKamar = await kamar.findAll({ where: { id_tipe_kamar: data.id_tipe_kamar } });
    if (!dataKamar || dataKamar.length === 0) {
      return res.status(400).json({ message: "No rooms available for the given type" });
    }

    const dataTipeKamar = await tipe_kamar.findOne({ where: { id_tipe_kamar: data.id_tipe_kamar } });
    if (!dataTipeKamar) {
      return res.status(400).json({ message: "Room type not found" });
    }

    const totalHari = Math.round((tgl_check_out - tgl_check_in) / (1000 * 3600 * 24));
    if (totalHari <= 0) {
      return res.status(400).json({ message: "Invalid stay duration" });
    }

    const dataPemesanan = await tipe_kamar.findAll({
      attributes: ["id_tipe_kamar", "nama_tipe_kamar"],
      where: { id_tipe_kamar: data.id_tipe_kamar },
      include: [
        {
          model: kamar,
          as: "kamar",
          attributes: ["id_kamar", "id_tipe_kamar"],
          include: [
            {
              model: detail_pemesanan,
              as: "detail_pemesanan",
              attributes: ["tgl_akses"],
              where: {
                tgl_akses: {
                  [Op.between]: [tgl_check_in, tgl_check_out],
                },
              },
            },
          ],
        },
      ],
    });

    const bookedRoomIds = dataPemesanan[0]?.kamar.map((room) => room.id_kamar) || [];
    const availableRooms = dataKamar.filter((room) => !bookedRoomIds.includes(room.id_kamar));

    if (availableRooms.length < data.jumlah_kamar) {
      return res.status(400).json({ message: "Not enough rooms available" });
    }

    const totalHarga = dataTipeKamar.harga * data.jumlah_kamar * totalHari;
    data.total_harga = totalHarga;  // Assign calculated total_harga

    const newPemesanan = await pemesanan.create(data);

    const selectedRooms = availableRooms.slice(0, data.jumlah_kamar);
    for (let i = 0; i < totalHari; i++) {
      for (const room of selectedRooms) {
        const tgl_akses = new Date(tgl_check_in);
        tgl_akses.setDate(tgl_akses.getDate() + i);

        const bookingDetail = {
          id_pemesanan: newPemesanan.id_pemesanan,
          id_kamar: room.id_kamar,
          tgl_akses: tgl_akses,
          harga: dataTipeKamar.harga,
        };

        await detail_pemesanan.create(bookingDetail);
      }
    }

    res.json({
      success: true,
      message: "Booking successful",
      data: {
        nomor_pemesanan: data.nomor_pemesanan,
        id: newPemesanan.id_pemesanan,
        total_harga: totalHarga  // Include total_harga in response
      },
    });

  } catch (error) {
    console.error("Error:", error);
    res.status(500).json({
      success: false,
      message: "An error occurred while processing your request",
      error: error.message,
    });
  }
});


/**
 * @apiRoutes {put} /hotel/booking/:id
 * @apiName PutBooking
 * @apiGroup Booking
 * @apiDescription Update booking data
 */
app.put("/:id",
  // mustLogin, mustAdmin,
  async (req, res) => {
    let params = { id_pemesanan: req.params.id };

    let data = {
      status_pemesanan: req.body.status_pemesanan,
    };

    try {
      // Update the status first
      const updatedPemesanan = await pemesanan.update(data, {
        where: params,
        returning: true,
      });

      // Check if the status is being changed to 'check_out'
      if (data.status_pemesanan === 'check_out') {
        // Instead of deleting, update the detail entries to indicate check-out
        await detail_pemesanan.update(
          { is_active: false }, // Assuming `is_active` is a boolean column to mark active/inactive
          { where: { id_pemesanan: req.params.id } }
        );
      }

      res.json({ success: 1, message: "Data has been updated!" });
    } catch (err) {
      console.error("Error during update:", err.message); // Log error message
      res.status(500).json({ message: err.message });
    }
  }
);


/**
 * @apiRoutes {delete} /hotel/booking/:id
 * @apiName DeleteBooking
 * @apiGroup Booking
 * @apiDescription Delete booking data
 */
app.delete(
  "/:id",
  // mustLogin, mustReceptionist,
  async (req, res) => {
    try {
      let params = { id_pemesanan: req.params.id };

      detail_pemesanan
        .destroy({ where: params })
        .then((result) => {
          if (result !== null) {
            pemesanan
              .destroy({ where: params })
              .then((results) =>
                res.json({ success: 1, message: "Data has been deleted!" })
              )
              .catch((err) => res.json({ message: err.message }));
          }
        })
        .catch((err) => res.json({ message: err.message }));
    } catch (err) {
      res.json({ message: err.message });
    }
  }
);

module.exports = app;

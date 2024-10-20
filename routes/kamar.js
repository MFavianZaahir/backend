//backend/routes/kamar.js
const express = require("express");
const { mustLogin, mustAdmin } = require("../middleware/auth");
const kamar = require("../models/index").kamar;
const detailPemesanan = require("../models/index").detail_pemesanan;

const app = express();

/**
 * @apiRoutes {get} /hotel/room/
 * @apiName GetAllRoom
 * @apiGroup Room
 * @apiDescription Get all room data
 */
app.get("/", async (req, res) => {
  await kamar
    .findAll({ include: ["tipe_kamar"] })
    .then((result) => res.json({ data: result }))
    .catch((error) => res.json({ message: error.message }));
});

/**
 * @apiRoutes {get} /hotel/room/:id
 * @apiName GetRoomById
 * @apiGroup Room
 * @apiDescription Get room data by id
 */
app.get("/:id", mustLogin, mustAdmin, async (req, res) => {
  let params = { id_kamar: req.params.id };

  await kamar
    .findOne({
      where: { ...params, deletedAt: null }, // Exclude soft-deleted rooms
      include: ["tipe_kamar"],
    })
    .then((result) => res.json({ data: result }))
    .catch((error) => res.json({ message: error.message }));
});

/**
 * @apiRoutes {post} /hotel/room/
 * @apiName PostRoom
 * @apiGroup Room
 * @apiDescription Insert room data
 */
app.post("/",
  //  mustLogin, mustAdmin,
    async (req, res) => {
  try {
    let data = {
      nomor_kamar: req.body.nomor_kamar,
      id_tipe_kamar: req.body.id_tipe_kamar,
    };

    await kamar.create(data);
    return res.json({
      success: true,
      message: "Success Added New Room",
      data: data,
    });
  } catch (error) {
    return res.json({ success: false, message: error });
  }
});

/**
 * @apiRoutes {put} /hotel/room/:id
 * @apiName PutRoom
 * @apiGroup Room
 * @apiDescription Update room data
 */
app.put("/:id", 
  // mustLogin, mustAdmin,
   async (req, res) => {
  let params = { id_kamar: req.params.id }; // Get the id from the URL params
  let data = {
    nomor_kamar: req.body.nomor_kamar,
    id_tipe_kamar: req.body.id_tipe_kamar,
  };

  await kamar
    .update(data, { where: params })
    .then((result) => {
      if (result[0] === 1) {
        // Sequelize returns an array, the first element is the affected row count
        res.json({ success: true, message: "Data has been updated" });
      } else {
        res.json({ success: false, message: "No rows updated" });
      }
    })
    .catch((error) => res.json({ success: false, message: error.message }));
});

/**
 * @apiRoutes {delete} /hotel/room/:id
 * @apiName DeleteRoom
 * @apiGroup Room
 * @apiDescription Delete room data
 */
app.delete("/:id",
  //  mustLogin, mustAdmin,
    async (req, res) => {
  let params = { id_kamar: req.params.id };

  try {
    // Delete related records in detail_pemesanan first
    await detailPemesanan.destroy({ where: { id_kamar: params.id_kamar } });

    // Now delete the room
    await kamar.destroy({ where: params });

    return res.json({
      success: 1,
      message: "Room and related records deleted successfully",
    });
  } catch (error) {
    return res.json({ message: error.message });
  }
});

module.exports = app;

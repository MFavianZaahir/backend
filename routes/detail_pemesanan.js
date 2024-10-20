//backend/routes/detail_pemesanan.js
const express = require('express');

const { mustLogin, mustReceptionist } = require('../middleware/auth');
const detail_pemesanan = require('../models/index').detail_pemesanan;
const kamar = require('../models/index').kamar; // Import the Kamar model if needed

const app = express();

/**
 * @apiRoutes {get} /hotel/booking/detail/:id
 * @apiName GetDetailBookingById
 * @apiGroup Booking
 * @apiDescription Get detail booking data by id, including the total price for all rooms ordered
 */
app.get('/:id', 
  // mustLogin, mustReceptionist,
   async (req, res) => {
  let params = { id_pemesanan: req.params.id };

  try {
    // Fetch all the booking details for the given reservation ID
    const detailPemesanan = await detail_pemesanan.findAll({
      where: params,
      include: ['kamar'],
    });

    // Calculate the total price by summing up the price of each room
    const totalPrice = detailPemesanan.reduce((total, detail) => {
      return total + detail.harga;
    }, 0);

    res.json({ 
      data: detailPemesanan, 
      totalPrice: totalPrice // Include the total price in the response
    });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

module.exports = app;

'use strict';

module.exports = {
  async up(queryInterface, Sequelize) {
    /**
     * Add seed commands here.
     *
     * Example:
     * await queryInterface.bulkInsert('People', [{
     *   name: 'John Doe',
     *   isBetaMember: false
     * }], {});
    */

    await queryInterface.bulkInsert('tipe_kamar', [{
      nama_tipe_kamar: 'Jerapah',
      harga: '350000',
      deskripsi: 'ini adalah deskripsi dari tipe kamar jerapah',
      foto: null,
    }], {});

    await queryInterface.bulkInsert('tipe_kamar', [{
      nama_tipe_kamar: 'Gajah',
      harga: '450000',
      deskripsi: 'ini adalah deskripsi dari tipe kamar gajah',
      foto: null,
    }], {});
  },

  async down(queryInterface, Sequelize) {
    /**
     * Add commands to revert seed here.
     *
     * Example:
     * await queryInterface.bulkDelete('People', null, {});
     */

    await queryInterface.bulkDelete('tipe_kamar', null, {});
  }
};

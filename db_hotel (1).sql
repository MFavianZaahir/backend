-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 20, 2024 at 08:08 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_hotel`
--

-- --------------------------------------------------------

--
-- Table structure for table `detail_pemesanan`
--

CREATE TABLE `detail_pemesanan` (
  `id_detail_pemesanan` int(11) NOT NULL,
  `id_pemesanan` int(11) DEFAULT NULL,
  `id_kamar` int(11) DEFAULT NULL,
  `tgl_akses` datetime DEFAULT NULL,
  `harga` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `detail_pemesanan`
--

INSERT INTO `detail_pemesanan` (`id_detail_pemesanan`, `id_pemesanan`, `id_kamar`, `tgl_akses`, `harga`, `createdAt`, `updatedAt`) VALUES
(25, 19, 1, '2024-10-21 00:00:00', 650000, '2024-10-20 14:28:15', '2024-10-20 14:28:15'),
(28, 21, 2, '2024-10-21 00:00:00', 650000, '2024-10-20 14:54:26', '2024-10-20 14:54:26'),
(29, 22, 3, '2024-10-21 00:00:00', 650000, '2024-10-20 14:54:39', '2024-10-20 14:54:39'),
(30, 22, 4, '2024-10-21 00:00:00', 650000, '2024-10-20 14:54:39', '2024-10-20 14:54:39'),
(33, 24, 6, '2024-10-21 00:00:00', 720000, '2024-10-20 15:57:35', '2024-10-20 15:57:35'),
(34, 25, 1, '2024-10-22 00:00:00', 650000, '2024-10-20 16:30:23', '2024-10-20 16:30:23'),
(35, 25, 2, '2024-10-22 00:00:00', 650000, '2024-10-20 16:30:23', '2024-10-20 16:30:23');

-- --------------------------------------------------------

--
-- Table structure for table `kamar`
--

CREATE TABLE `kamar` (
  `id_kamar` int(11) NOT NULL,
  `nomor_kamar` int(11) DEFAULT NULL,
  `id_tipe_kamar` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kamar`
--

INSERT INTO `kamar` (`id_kamar`, `nomor_kamar`, `id_tipe_kamar`, `createdAt`, `updatedAt`) VALUES
(1, 101, 1, '2024-10-18 06:22:38', '2024-10-18 06:22:38'),
(2, 102, 1, '2024-10-18 06:22:43', '2024-10-18 06:22:43'),
(3, 103, 1, '2024-10-18 06:22:45', '2024-10-18 06:22:45'),
(4, 104, 1, '2024-10-18 06:22:47', '2024-10-18 06:22:47'),
(5, 105, 1, '2024-10-18 06:22:50', '2024-10-18 06:22:50'),
(6, 201, 2, '2024-10-18 06:23:00', '2024-10-18 06:23:00'),
(7, 202, 2, '2024-10-18 06:23:01', '2024-10-18 06:23:01'),
(8, 203, 2, '2024-10-18 06:23:03', '2024-10-18 06:23:03'),
(9, 204, 2, '2024-10-18 06:23:04', '2024-10-18 06:23:04'),
(10, 205, 2, '2024-10-18 06:23:07', '2024-10-18 06:23:07');

-- --------------------------------------------------------

--
-- Table structure for table `pelanggan`
--

CREATE TABLE `pelanggan` (
  `id_pelanggan` int(11) NOT NULL,
  `nama` varchar(255) DEFAULT NULL,
  `foto` text DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` text DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pelanggan`
--

INSERT INTO `pelanggan` (`id_pelanggan`, `nama`, `foto`, `slug`, `email`, `password`, `role`, `createdAt`, `updatedAt`) VALUES
(1, 'Ogyaku-San', 'http://localhost:8000/usr/48c9522aaa31a27582216bec737e92ce-1729231996641.gif', 'ogyaku-san', 'customer@mail.com', '91ec1f9324753048c0096d036a694f86', 'pelanggan', '2024-10-18 06:13:16', '2024-10-18 06:13:16');

-- --------------------------------------------------------

--
-- Table structure for table `pemesanan`
--

CREATE TABLE `pemesanan` (
  `id_pemesanan` int(11) NOT NULL,
  `nomor_pemesanan` varchar(255) DEFAULT NULL,
  `id_pelanggan` int(11) DEFAULT NULL,
  `tgl_pemesanan` datetime DEFAULT NULL,
  `tgl_check_in` datetime DEFAULT NULL,
  `tgl_check_out` datetime DEFAULT NULL,
  `nama_tamu` varchar(255) DEFAULT NULL,
  `email_pemesanan` varchar(255) DEFAULT NULL,
  `jumlah_kamar` int(11) DEFAULT NULL,
  `id_tipe_kamar` int(11) DEFAULT NULL,
  `status_pemesanan` enum('baru','check_in','check_out') DEFAULT NULL,
  `id_user` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pemesanan`
--

INSERT INTO `pemesanan` (`id_pemesanan`, `nomor_pemesanan`, `id_pelanggan`, `tgl_pemesanan`, `tgl_check_in`, `tgl_check_out`, `nama_tamu`, `email_pemesanan`, `jumlah_kamar`, `id_tipe_kamar`, `status_pemesanan`, `id_user`, `createdAt`, `updatedAt`) VALUES
(17, 'WH-515583943', 1, '2024-10-20 10:36:12', '2024-10-20 00:00:00', '2024-10-21 00:00:00', 'Pelanggan', 'customer@mail.com', 1, 2, 'check_out', NULL, '2024-10-20 10:36:12', '2024-10-20 18:04:01'),
(18, 'WH-638359011', 1, '2024-10-20 10:51:46', '2024-10-20 00:00:00', '2024-10-21 00:00:00', 'Pelanggan', 'customer@mail.com', 2, 1, 'check_out', NULL, '2024-10-20 10:51:46', '2024-10-20 18:03:52'),
(19, 'WH-941595523', 1, '2024-10-20 14:28:15', '2024-10-21 00:00:00', '2024-10-22 00:00:00', 'Pelanggan', 'customer@mail.com', 1, 1, 'check_in', NULL, '2024-10-20 14:28:15', '2024-10-20 18:04:08'),
(20, 'WH-361322973', 1, '2024-10-20 14:52:57', '2024-10-19 17:00:00', '2024-10-20 17:00:00', 'Pelanggan', 'customer@mail.com', 2, 1, 'check_out', NULL, '2024-10-20 14:52:57', '2024-10-20 15:17:08'),
(21, 'WH-397097063', 1, '2024-10-20 14:54:26', '2024-10-21 00:00:00', '2024-10-22 00:00:00', 'Pelanggan', 'customer@mail.com', 1, 1, 'check_in', NULL, '2024-10-20 14:54:26', '2024-10-20 18:04:10'),
(22, 'WH-434043840', 1, '2024-10-20 14:54:39', '2024-10-21 00:00:00', '2024-10-22 00:00:00', 'Pelanggan', 'customer@mail.com', 2, 1, 'check_in', NULL, '2024-10-20 14:54:39', '2024-10-20 18:04:12'),
(23, 'WH-162476681', 1, '2024-10-20 15:17:16', '2024-10-19 17:00:00', '2024-10-20 17:00:00', 'Pelanggan', 'customer@mail.com', 2, 1, 'check_out', NULL, '2024-10-20 15:17:16', '2024-10-20 18:04:04'),
(24, 'WH-560363857', 1, '2024-10-20 15:57:35', '2024-10-21 00:00:00', '2024-10-22 00:00:00', 'Pelanggan', 'customer@mail.com', 1, 2, 'check_in', NULL, '2024-10-20 15:57:35', '2024-10-20 18:04:25'),
(25, 'WH-190344759', 1, '2024-10-20 16:30:23', '2024-10-22 00:00:00', '2024-10-23 00:00:00', 'Ogyaku-san', 'customer@mail.com', 2, 1, 'baru', NULL, '2024-10-20 16:30:23', '2024-10-20 16:30:23');

-- --------------------------------------------------------

--
-- Table structure for table `sequelizemeta`
--

CREATE TABLE `sequelizemeta` (
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `sequelizemeta`
--

INSERT INTO `sequelizemeta` (`name`) VALUES
('1-create-user.js'),
('2-create-tipe-kamar.js'),
('3-create-kamar.js'),
('4-create-pelanggan.js'),
('5-create-pemesanan.js'),
('6-create-detail-pemesanan.js');

-- --------------------------------------------------------

--
-- Table structure for table `tipe_kamar`
--

CREATE TABLE `tipe_kamar` (
  `id_tipe_kamar` int(11) NOT NULL,
  `nama_tipe_kamar` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `harga` int(11) DEFAULT NULL,
  `deskripsi` text DEFAULT NULL,
  `foto` text DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tipe_kamar`
--

INSERT INTO `tipe_kamar` (`id_tipe_kamar`, `nama_tipe_kamar`, `slug`, `harga`, `deskripsi`, `foto`, `createdAt`, `updatedAt`) VALUES
(1, 'Deluxe', 'deluxe', 650000, 'Those who work for the full stomach and ignore the hungry', 'http://localhost:8000/img/amimi-1729232067341.jpg', '2024-10-18 06:14:27', '2024-10-18 06:14:27'),
(2, 'Luxury', 'luxury', 720000, 'Those who work for the full stomach and ignore the hungry', 'http://localhost:8000/img/FFpE7TxX0AELICz-1729232097842.jpg', '2024-10-18 06:14:57', '2024-10-18 06:14:57');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id_user` int(11) NOT NULL,
  `nama_user` varchar(255) DEFAULT NULL,
  `foto` text DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` text DEFAULT NULL,
  `role` enum('admin','resepsionis') DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id_user`, `nama_user`, `foto`, `slug`, `email`, `password`, `role`, `createdAt`, `updatedAt`) VALUES
(1, 'admin', 'http://localhost:8000/usr/48c9522aaa31a27582216bec737e92ce-1729232022265.gif', 'admin', 'admin@mail.com', '21232f297a57a5a743894a0e4a801fc3', 'admin', '2024-10-18 06:13:42', '2024-10-18 06:13:42'),
(2, 'resespsionis', 'http://localhost:8000/usr/ezgif-5-4e4a40d8fa-1729232759301.gif', 'resespsionis', 'resepsionis@mail.com', '21232f297a57a5a743894a0e4a801fc3', 'resepsionis', '2024-10-18 06:25:59', '2024-10-18 06:25:59');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `detail_pemesanan`
--
ALTER TABLE `detail_pemesanan`
  ADD PRIMARY KEY (`id_detail_pemesanan`),
  ADD KEY `id_pemesanan` (`id_pemesanan`),
  ADD KEY `id_kamar` (`id_kamar`);

--
-- Indexes for table `kamar`
--
ALTER TABLE `kamar`
  ADD PRIMARY KEY (`id_kamar`),
  ADD KEY `id_tipe_kamar` (`id_tipe_kamar`);

--
-- Indexes for table `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`id_pelanggan`);

--
-- Indexes for table `pemesanan`
--
ALTER TABLE `pemesanan`
  ADD PRIMARY KEY (`id_pemesanan`),
  ADD KEY `id_pelanggan` (`id_pelanggan`),
  ADD KEY `id_tipe_kamar` (`id_tipe_kamar`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `sequelizemeta`
--
ALTER TABLE `sequelizemeta`
  ADD PRIMARY KEY (`name`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `tipe_kamar`
--
ALTER TABLE `tipe_kamar`
  ADD PRIMARY KEY (`id_tipe_kamar`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `detail_pemesanan`
--
ALTER TABLE `detail_pemesanan`
  MODIFY `id_detail_pemesanan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `kamar`
--
ALTER TABLE `kamar`
  MODIFY `id_kamar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `pelanggan`
--
ALTER TABLE `pelanggan`
  MODIFY `id_pelanggan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pemesanan`
--
ALTER TABLE `pemesanan`
  MODIFY `id_pemesanan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `tipe_kamar`
--
ALTER TABLE `tipe_kamar`
  MODIFY `id_tipe_kamar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `detail_pemesanan`
--
ALTER TABLE `detail_pemesanan`
  ADD CONSTRAINT `detail_pemesanan_ibfk_1` FOREIGN KEY (`id_pemesanan`) REFERENCES `pemesanan` (`id_pemesanan`),
  ADD CONSTRAINT `detail_pemesanan_ibfk_2` FOREIGN KEY (`id_kamar`) REFERENCES `kamar` (`id_kamar`);

--
-- Constraints for table `kamar`
--
ALTER TABLE `kamar`
  ADD CONSTRAINT `kamar_ibfk_1` FOREIGN KEY (`id_tipe_kamar`) REFERENCES `tipe_kamar` (`id_tipe_kamar`);

--
-- Constraints for table `pemesanan`
--
ALTER TABLE `pemesanan`
  ADD CONSTRAINT `pemesanan_ibfk_1` FOREIGN KEY (`id_pelanggan`) REFERENCES `pelanggan` (`id_pelanggan`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pemesanan_ibfk_2` FOREIGN KEY (`id_tipe_kamar`) REFERENCES `tipe_kamar` (`id_tipe_kamar`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pemesanan_ibfk_3` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

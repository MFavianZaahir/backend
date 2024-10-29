-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 29, 2024 at 10:48 AM
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
(1, 1, 1, '2024-10-29 00:00:00', 1200000, '2024-10-29 09:31:03', '2024-10-29 09:31:03'),
(2, 1, 4, '2024-10-29 00:00:00', 1200000, '2024-10-29 09:31:03', '2024-10-29 09:31:03'),
(3, 2, 7, '2024-10-30 00:00:00', 690000, '2024-10-29 09:38:22', '2024-10-29 09:38:22'),
(4, 3, 10, '2024-10-31 00:00:00', 750000, '2024-10-29 09:38:41', '2024-10-29 09:38:41'),
(5, 3, 11, '2024-10-31 00:00:00', 750000, '2024-10-29 09:38:41', '2024-10-29 09:38:41');

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
(1, 101, 1, '2024-10-29 09:01:45', '2024-10-29 09:01:45'),
(4, 103, 1, '2024-10-29 09:05:00', '2024-10-29 09:05:00'),
(5, 102, 1, '2024-10-29 09:05:45', '2024-10-29 09:05:45'),
(7, 201, 2, '2024-10-29 09:25:17', '2024-10-29 09:28:35'),
(8, 202, 2, '2024-10-29 09:36:59', '2024-10-29 09:36:59'),
(9, 203, 2, '2024-10-29 09:37:04', '2024-10-29 09:37:11'),
(10, 301, 3, '2024-10-29 09:37:20', '2024-10-29 09:37:20'),
(11, 302, 3, '2024-10-29 09:37:26', '2024-10-29 09:37:30'),
(12, 303, 3, '2024-10-29 09:37:39', '2024-10-29 09:37:39');

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
(1, 'Pelanggan yang Terhomat', 'http://localhost:8000/usr/im-nothing-like-yall-nothing-like-yall-1730195202998.jpg', 'pelanggan-yang-terhomat', '', '91ec1f9324753048c0096d036a694f86', 'pelanggan', '2024-10-29 08:51:43', '2024-10-29 09:46:43'),
(2, '', 'http://localhost:8000/usr/maw-1730195217785.jpg', '', '', '91ec1f9324753048c0096d036a694f86', 'pelanggan', '2024-10-29 09:29:39', '2024-10-29 09:46:57');

-- --------------------------------------------------------

--
-- Table structure for table `pemesanan`
--

CREATE TABLE `pemesanan` (
  `id_pemesanan` int(11) NOT NULL,
  `nomor_pemesanan` varchar(255) DEFAULT NULL,
  `total_harga` int(11) DEFAULT NULL,
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

INSERT INTO `pemesanan` (`id_pemesanan`, `nomor_pemesanan`, `total_harga`, `id_pelanggan`, `tgl_pemesanan`, `tgl_check_in`, `tgl_check_out`, `nama_tamu`, `email_pemesanan`, `jumlah_kamar`, `id_tipe_kamar`, `status_pemesanan`, `id_user`, `createdAt`, `updatedAt`) VALUES
(1, 'WH-360776123', 2400000, 1, '2024-10-29 09:31:03', '2024-10-29 00:00:00', '2024-10-30 00:00:00', 'Pelanggan', 'customer@mail.com', 2, 1, 'check_in', NULL, '2024-10-29 09:31:03', '2024-10-29 09:31:03'),
(2, 'WH-868223884', 690000, 2, '2024-10-29 09:38:22', '2024-10-30 00:00:00', '2024-10-31 00:00:00', 'Benefactor', 'ogyakusan@mail.com', 1, 2, 'baru', NULL, '2024-10-29 09:38:22', '2024-10-29 09:38:22'),
(3, 'WH-468697091', 1500000, 2, '2024-10-29 09:38:41', '2024-10-31 00:00:00', '2024-11-01 00:00:00', 'Benefactor', 'ogyakusan@mail.com', 2, 3, 'baru', NULL, '2024-10-29 09:38:41', '2024-10-29 09:38:41');

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
(1, 'Premierre', 'premierre', 1200000, 'Lorem Ipsum Dolor sit Amet', 'http://localhost:8000/img/premierre-1730192414391.jpg', '2024-10-29 09:00:14', '2024-10-29 09:00:14'),
(2, 'Deluxe', 'deluxe', 690000, 'Lorem Ipusm Dolor sit Amet', 'http://localhost:8000/img/deluxe_harbour_web-1730192464218.jpg', '2024-10-29 09:01:04', '2024-10-29 09:01:04'),
(3, 'Luxury', 'luxury', 750000, 'Lorem Ipusm Dolor sit Amet', 'http://localhost:8000/img/luxury-1730194145320.jpg', '2024-10-29 09:01:24', '2024-10-29 09:29:05');

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
(1, 'Admin', 'http://localhost:8000/usr/6647bdb054b54-1730191844663.jpg', 'admin', 'admin@mail.com', '21232f297a57a5a743894a0e4a801fc3', 'admin', '2024-10-29 08:50:44', '2024-10-29 08:50:44'),
(2, 'Resepsionis', 'http://localhost:8000/usr/jadi gini le-1730191872810.jpg', 'resepsionis', 'resepsionis@mail.com', '21232f297a57a5a743894a0e4a801fc3', 'resepsionis', '2024-10-29 08:51:12', '2024-10-29 08:51:12');

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
  MODIFY `id_detail_pemesanan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `kamar`
--
ALTER TABLE `kamar`
  MODIFY `id_kamar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `pelanggan`
--
ALTER TABLE `pelanggan`
  MODIFY `id_pelanggan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `pemesanan`
--
ALTER TABLE `pemesanan`
  MODIFY `id_pemesanan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tipe_kamar`
--
ALTER TABLE `tipe_kamar`
  MODIFY `id_tipe_kamar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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

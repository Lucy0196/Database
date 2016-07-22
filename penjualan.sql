-- phpMyAdmin SQL Dump
-- version 4.4.12
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Mar 08, 2016 at 04:36 AM
-- Server version: 5.6.25
-- PHP Version: 5.6.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `penjualan`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_pembelian`
--

CREATE TABLE IF NOT EXISTS `tbl_pembelian` (
  `No_Faktur` char(15) NOT NULL DEFAULT '',
  `Tgl_Transaksi` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Total_Harga` int(11) DEFAULT NULL,
  `Kode_Suplier` char(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_pembelian`
--

INSERT INTO `tbl_pembelian` (`No_Faktur`, `Tgl_Transaksi`, `Total_Harga`, `Kode_Suplier`) VALUES
('F001', '2015-05-08 06:59:09', 2200000, 'SP001'),
('F02', '2015-05-13 14:06:59', 1380000, 'SP001'),
('f04', '2015-05-13 14:13:42', 2000000, 'SP001');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_pembelian_detail`
--

CREATE TABLE IF NOT EXISTS `tbl_pembelian_detail` (
  `ID_Transaksi` int(11) NOT NULL,
  `Qty` int(20) DEFAULT NULL,
  `Sub_Total` int(20) DEFAULT NULL,
  `No_Faktur` char(15) NOT NULL,
  `Kode_Barang` char(15) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_pembelian_detail`
--

INSERT INTO `tbl_pembelian_detail` (`ID_Transaksi`, `Qty`, `Sub_Total`, `No_Faktur`, `Kode_Barang`) VALUES
(28, 5, 1000000, 'F001', 'BR03'),
(29, 10, 800000, 'F001', 'BR05'),
(30, 2, 400000, 'F001', 'BR06'),
(33, 3, 1200000, 'F02', 'BR04'),
(34, 3, 180000, 'F02', 'BR02'),
(35, 10, 2000000, 'f04', 'BR06');

--
-- Triggers `tbl_pembelian_detail`
--
DELIMITER $$
CREATE TRIGGER `tambah_stok` AFTER INSERT ON `tbl_pembelian_detail`
 FOR EACH ROW BEGIN
	update tbl_stok set Stok=(Stok+New.Qty) where Kode_Barang=new.Kode_Barang;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_penjualan`
--

CREATE TABLE IF NOT EXISTS `tbl_penjualan` (
  `No_Nota` char(15) NOT NULL DEFAULT '',
  `Tgl_Transaksi` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Total_Harga` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_penjualan`
--

INSERT INTO `tbl_penjualan` (`No_Nota`, `Tgl_Transaksi`, `Total_Harga`) VALUES
('TS2015000001', '2015-05-13 15:45:00', 2600000),
('TS2015000002', '2015-05-13 15:47:38', 2240000),
('TS2015000003', '2015-05-13 15:50:34', 1200000);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_penjualan_dtl`
--

CREATE TABLE IF NOT EXISTS `tbl_penjualan_dtl` (
  `ID_Transaksi` int(11) NOT NULL,
  `Qty` int(10) DEFAULT NULL,
  `Sub_Total` int(20) DEFAULT NULL,
  `No_Nota` char(15) NOT NULL,
  `Kode_Barang` char(15) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_penjualan_dtl`
--

INSERT INTO `tbl_penjualan_dtl` (`ID_Transaksi`, `Qty`, `Sub_Total`, `No_Nota`, `Kode_Barang`) VALUES
(1, 2, 600000, 'TS2015000001', 'BR01'),
(2, 5, 2000000, 'TS2015000001', 'BR04'),
(3, 5, 2000000, 'TS2015000002', 'BR04'),
(4, 4, 240000, 'TS2015000002', 'BR02'),
(5, 2, 800000, 'TS2015000003', 'BR04'),
(6, 2, 400000, 'TS2015000003', 'BR06');

--
-- Triggers `tbl_penjualan_dtl`
--
DELIMITER $$
CREATE TRIGGER `kurangi_stok` AFTER INSERT ON `tbl_penjualan_dtl`
 FOR EACH ROW BEGIN
	update tbl_stok set Stok=(Stok-New.Qty) where Kode_Barang=new.Kode_Barang;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_stok`
--

CREATE TABLE IF NOT EXISTS `tbl_stok` (
  `Kode_Barang` char(15) NOT NULL DEFAULT '',
  `Nama_Barang` varchar(50) DEFAULT NULL,
  `Jenis_Barang` varchar(35) DEFAULT NULL,
  `Harga_Pembelian` int(20) DEFAULT NULL,
  `Harga_Penjualan` int(20) DEFAULT NULL,
  `Stok` int(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_stok`
--

INSERT INTO `tbl_stok` (`Kode_Barang`, `Nama_Barang`, `Jenis_Barang`, `Harga_Pembelian`, `Harga_Penjualan`, `Stok`) VALUES
('BR01', 'X-TREME MB', 'Motherboard', 300000, 390000, 3),
('BR02', 'Acer', 'Mouse', 60000, 80000, 19),
('BR03', 'SEGATE 320 GB', 'Hard Disk', 200000, 300000, 5),
('BR04', 'HITACHI 320 GB', 'Hard Disk', 400000, 500000, 31),
('BR05', 'SANDISK 8 GB', 'Flash Disk', 80000, 120000, 10),
('BR06', 'LITE-ON ', 'Optik Drive', 200000, 250000, 10);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_suplier`
--

CREATE TABLE IF NOT EXISTS `tbl_suplier` (
  `Kode_Suplier` char(15) NOT NULL DEFAULT '',
  `Nama_Suplier` varchar(50) DEFAULT NULL,
  `No_Telp` char(12) DEFAULT NULL,
  `Email` varchar(70) DEFAULT NULL,
  `Alamat` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_suplier`
--

INSERT INTO `tbl_suplier` (`Kode_Suplier`, `Nama_Suplier`, `No_Telp`, `Email`, `Alamat`) VALUES
('1', '2', '3', '1', '4'),
('SP001', 'PT.Galang Rejeki', '081907664914', 'galang.rejeki@gmail.com', 'Jl.Chingcaule No.8 Karang Sukun Mataram'),
('SP002', 'PT.Mekar Indah', '081917424201', 'mekar.indah@gmail.com', 'Jl.Amir Hamzah No.10 Karang Tapen');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id_user` int(11) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `kontak` varchar(15) DEFAULT NULL,
  `alamat` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_pembelian`
--
CREATE TABLE IF NOT EXISTS `v_pembelian` (
`No_Faktur` char(15)
,`Tgl_Transaksi` timestamp
,`Total_Harga` int(11)
,`Kode_Suplier` char(15)
,`Nama_Suplier` varchar(50)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_pembelian_detail`
--
CREATE TABLE IF NOT EXISTS `v_pembelian_detail` (
`ID_Transaksi` int(11)
,`Kode_Barang` char(15)
,`Nama_Barang` varchar(50)
,`Jenis_Barang` varchar(35)
,`Harga_Pembelian` int(20)
,`Qty` int(20)
,`Sub_Total` int(20)
,`No_Faktur` char(15)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_penjualan_detail`
--
CREATE TABLE IF NOT EXISTS `v_penjualan_detail` (
`ID_Transaksi` int(11)
,`Kode_Barang` char(15)
,`Nama_Barang` varchar(50)
,`Jenis_Barang` varchar(35)
,`Harga_Penjualan` int(20)
,`Qty` int(10)
,`Sub_Total` int(20)
,`No_Nota` char(15)
);

-- --------------------------------------------------------

--
-- Structure for view `v_pembelian`
--
DROP TABLE IF EXISTS `v_pembelian`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_pembelian` AS select `tp`.`No_Faktur` AS `No_Faktur`,`tp`.`Tgl_Transaksi` AS `Tgl_Transaksi`,`tp`.`Total_Harga` AS `Total_Harga`,`tp`.`Kode_Suplier` AS `Kode_Suplier`,`ts`.`Nama_Suplier` AS `Nama_Suplier` from (`tbl_pembelian` `tp` join `tbl_suplier` `ts` on((`ts`.`Kode_Suplier` = `tp`.`Kode_Suplier`)));

-- --------------------------------------------------------

--
-- Structure for view `v_pembelian_detail`
--
DROP TABLE IF EXISTS `v_pembelian_detail`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_pembelian_detail` AS select `tpd`.`ID_Transaksi` AS `ID_Transaksi`,`tpd`.`Kode_Barang` AS `Kode_Barang`,`ts`.`Nama_Barang` AS `Nama_Barang`,`ts`.`Jenis_Barang` AS `Jenis_Barang`,`ts`.`Harga_Pembelian` AS `Harga_Pembelian`,`tpd`.`Qty` AS `Qty`,`tpd`.`Sub_Total` AS `Sub_Total`,`tpd`.`No_Faktur` AS `No_Faktur` from ((`tbl_pembelian_detail` `tpd` join `tbl_stok` `ts` on((`ts`.`Kode_Barang` = `tpd`.`Kode_Barang`))) join `v_pembelian` `vp` on((`vp`.`No_Faktur` = `tpd`.`No_Faktur`)));

-- --------------------------------------------------------

--
-- Structure for view `v_penjualan_detail`
--
DROP TABLE IF EXISTS `v_penjualan_detail`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_penjualan_detail` AS select `tpd`.`ID_Transaksi` AS `ID_Transaksi`,`tpd`.`Kode_Barang` AS `Kode_Barang`,`ts`.`Nama_Barang` AS `Nama_Barang`,`ts`.`Jenis_Barang` AS `Jenis_Barang`,`ts`.`Harga_Penjualan` AS `Harga_Penjualan`,`tpd`.`Qty` AS `Qty`,`tpd`.`Sub_Total` AS `Sub_Total`,`tpd`.`No_Nota` AS `No_Nota` from ((`tbl_penjualan_dtl` `tpd` join `tbl_stok` `ts` on((`ts`.`Kode_Barang` = `tpd`.`Kode_Barang`))) join `tbl_penjualan` `tp` on((`tp`.`No_Nota` = `tpd`.`No_Nota`)));

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_pembelian`
--
ALTER TABLE `tbl_pembelian`
  ADD PRIMARY KEY (`No_Faktur`),
  ADD KEY `fk_tbl_pembelian_tbl_suplier1_idx` (`Kode_Suplier`);

--
-- Indexes for table `tbl_pembelian_detail`
--
ALTER TABLE `tbl_pembelian_detail`
  ADD PRIMARY KEY (`ID_Transaksi`),
  ADD KEY `fk_tbl_pembelian_detail_tbl_pembelian_idx` (`No_Faktur`),
  ADD KEY `fk_tbl_pembelian_detail_tbl_stok1_idx` (`Kode_Barang`);

--
-- Indexes for table `tbl_penjualan`
--
ALTER TABLE `tbl_penjualan`
  ADD PRIMARY KEY (`No_Nota`);

--
-- Indexes for table `tbl_penjualan_dtl`
--
ALTER TABLE `tbl_penjualan_dtl`
  ADD PRIMARY KEY (`ID_Transaksi`),
  ADD KEY `fk_tbl_penjualan_dtl_tbl_penjualan1_idx` (`No_Nota`),
  ADD KEY `fk_tbl_penjualan_dtl_tbl_stok1_idx` (`Kode_Barang`);

--
-- Indexes for table `tbl_stok`
--
ALTER TABLE `tbl_stok`
  ADD PRIMARY KEY (`Kode_Barang`);

--
-- Indexes for table `tbl_suplier`
--
ALTER TABLE `tbl_suplier`
  ADD PRIMARY KEY (`Kode_Suplier`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_pembelian_detail`
--
ALTER TABLE `tbl_pembelian_detail`
  MODIFY `ID_Transaksi` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=36;
--
-- AUTO_INCREMENT for table `tbl_penjualan_dtl`
--
ALTER TABLE `tbl_penjualan_dtl`
  MODIFY `ID_Transaksi` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `tbl_pembelian`
--
ALTER TABLE `tbl_pembelian`
  ADD CONSTRAINT `fk_tbl_pembelian_tbl_suplier1` FOREIGN KEY (`Kode_Suplier`) REFERENCES `tbl_suplier` (`Kode_Suplier`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tbl_pembelian_detail`
--
ALTER TABLE `tbl_pembelian_detail`
  ADD CONSTRAINT `fk_tbl_pembelian_detail_tbl_pembelian` FOREIGN KEY (`No_Faktur`) REFERENCES `tbl_pembelian` (`No_Faktur`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_tbl_pembelian_detail_tbl_stok1` FOREIGN KEY (`Kode_Barang`) REFERENCES `tbl_stok` (`Kode_Barang`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tbl_penjualan_dtl`
--
ALTER TABLE `tbl_penjualan_dtl`
  ADD CONSTRAINT `fk_tbl_penjualan_dtl_tbl_penjualan1` FOREIGN KEY (`No_Nota`) REFERENCES `tbl_penjualan` (`No_Nota`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_tbl_penjualan_dtl_tbl_stok1` FOREIGN KEY (`Kode_Barang`) REFERENCES `tbl_stok` (`Kode_Barang`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

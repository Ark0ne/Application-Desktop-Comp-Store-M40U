-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 14, 2021 at 02:51 
-- Server version: 5.1.41
-- PHP Version: 5.3.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `db_5n_v3`
--
CREATE DATABASE `db_5n_v3` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `db_5n_v3`;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE IF NOT EXISTS `admin` (
  `kd_admin` varchar(50) NOT NULL,
  `u_name` varchar(12) NOT NULL,
  `u_pass` varchar(13) NOT NULL,
  `divisi` varchar(15) NOT NULL,
  PRIMARY KEY (`kd_admin`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`kd_admin`, `u_name`, `u_pass`, `divisi`) VALUES
('15-21-01-45-05testMas', 'afri', '12345', 'master'),
('15-21-14-25-44testGud', 'test', '1234', 'gudang'),
('15-21-14-27-23gudaGud', 'gudang12', '123', 'gudang');

-- --------------------------------------------------------

--
-- Table structure for table `barang`
--

CREATE TABLE IF NOT EXISTS `barang` (
  `kd_brg` varchar(10) NOT NULL,
  `nm_brg` varchar(255) NOT NULL,
  `kd_kat` varchar(18) DEFAULT NULL,
  `kd_sp` varchar(20) DEFAULT NULL,
  `harga_beli` double NOT NULL,
  `harga_jual` double NOT NULL,
  `tgl_brg` date NOT NULL,
  `qty_thn` double unsigned NOT NULL DEFAULT '0',
  `biy_pesan` double NOT NULL DEFAULT '0',
  `biy_simpan` double NOT NULL DEFAULT '0',
  `qty_hari_max` double NOT NULL DEFAULT '0',
  `qty_eoq` double NOT NULL DEFAULT '0',
  `lead_time` double NOT NULL DEFAULT '0',
  `jual_total` double NOT NULL,
  `rop_safety` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`kd_brg`),
  KEY `fk_kategori` (`kd_kat`),
  KEY `fk_suplier` (`kd_sp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `barang`
--

INSERT INTO `barang` (`kd_brg`, `nm_brg`, `kd_kat`, `kd_sp`, `harga_beli`, `harga_jual`, `tgl_brg`, `qty_thn`, `biy_pesan`, `biy_simpan`, `qty_hari_max`, `qty_eoq`, `lead_time`, `jual_total`, `rop_safety`) VALUES
('G1148', 'GA-G31M-S2L (rev. 1.1/2.0)', 'MBO270621043537', 'SSMAN17112157', 350000, 370000, '2010-11-23', 100, 4000, 10500, 3, 0.24, 10, 375150, 30),
('S1135', 'Seagate', 'HDD270621043352', 'SDDIO17112132', 500000, 6500000, '2020-07-15', 100, 500000, 15000, 3, 0.2, 10, 6754500, 30);

-- --------------------------------------------------------

--
-- Table structure for table `kategori`
--

CREATE TABLE IF NOT EXISTS `kategori` (
  `kd_kat` varchar(18) NOT NULL,
  `nm_kat` varchar(25) NOT NULL,
  `tgl_kat` date NOT NULL,
  PRIMARY KEY (`kd_kat`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `kategori`
--

INSERT INTO `kategori` (`kd_kat`, `nm_kat`, `tgl_kat`) VALUES
('AMD270621043216', 'AMD PROSESOR', '2020-04-16'),
('CAR270621043235', 'CARD READER', '2020-04-15'),
('CRT270621043246', 'CRT Monitor', '2020-04-15'),
('GRA270621043313', 'GRAPHIC CARD', '2020-04-15'),
('HAN171121150500', 'HANDYCAM', '2020-04-15'),
('HAN220721042935', 'HANDYCAM', '2020-04-16'),
('HDD270621043324', 'HDD SCSI', '0000-00-00'),
('HDD270621043330', 'HDD SATA', '0000-00-00'),
('HDD270621043352', 'HDD EXTERNAL', '0000-00-00'),
('HDD270621043403', 'HDD ATA/UATA', '0000-00-00'),
('HDD270621043412', 'HDD NOTEBOOK', '0000-00-00'),
('HUB270621043419', 'HUB', '0000-00-00'),
('INT270621043432', 'INTEL PROSESOR', '0000-00-00'),
('LAN270621043441', 'LAN CARD', '0000-00-00'),
('LAP270621043859', 'LAPTOP', '0000-00-00'),
('LCD270621043453', 'LCD Monitor', '0000-00-00'),
('MBO270621043537', 'MBOARD SOKET 775', '0000-00-00'),
('MBO270621043549', 'MBOARD SOKET 478', '0000-00-00'),
('MBO270621043559', 'MBOARD SOKET A', '0000-00-00'),
('MEM270621043612', 'MEMORI NOTEBOOK USB', '0000-00-00'),
('MEM270621043624', 'MEMORI SDRAM', '0000-00-00'),
('MEM270621043632', 'MEMORI FLASH', '0000-00-00'),
('MEM270621043646', 'MEMORI DDRAM', '0000-00-00'),
('MIC181121124929', 'MICHROPHONE', '2021-11-18'),
('MOD270621043658', 'MODEM', '0000-00-00'),
('OPT270621043707', 'OPTICAL DRIVE', '0000-00-00'),
('WEB220721044959', 'WEBCAM', '0000-00-00');

-- --------------------------------------------------------

--
-- Table structure for table `penjualan`
--

CREATE TABLE IF NOT EXISTS `penjualan` (
  `kd_pjl` varchar(15) NOT NULL,
  `kd_brg` varchar(10) DEFAULT NULL,
  `tgl_pjl` date NOT NULL,
  `nm_pbl` varchar(50) NOT NULL,
  `alamat_pbl` varchar(50) NOT NULL,
  `kontak_pbl` varchar(14) DEFAULT NULL,
  `email_pbl` varchar(255) DEFAULT NULL,
  `perusahaan_pbl` varchar(255) DEFAULT NULL,
  `jumlah_pbl` double NOT NULL,
  `total_harga` double NOT NULL,
  PRIMARY KEY (`kd_pjl`),
  KEY `fk_barang` (`kd_brg`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `penjualan`
--

INSERT INTO `penjualan` (`kd_pjl`, `kd_brg`, `tgl_pjl`, `nm_pbl`, `alamat_pbl`, `kontak_pbl`, `email_pbl`, `perusahaan_pbl`, `jumlah_pbl`, `total_harga`) VALUES
('PJASH28112100', 'S1135', '2021-11-22', 'Ash', 'Jl.Atas Bawah Kiri Kana no 90', '0899999999', '', '', 5, 33097050),
('PJAWA28112129', 'G1148', '2021-11-03', 'Awa', 'Jl.Binjai Atas', '089934859302', '', '', 3, 1102941),
('PJKET28112108', 'S1135', '2021-11-22', 'Ketchum', 'Jl.Atas Bawah Kiri Kana no 90', '0899999999', '', '', 5, 33097050),
('PJNUR28112110', 'G1148', '2020-12-11', 'Nur Cahyadi Tri Purnomo', 'Jl. Sejahtera Karya No.67 Rt 43 Rw 10', '087734859572', 'MajuSejahtera.Official@gmail.Com', 'PT. Maju Sejahtera', 10, 3451380),
('PJRAH23112100', 'G1148', '2010-12-23', 'Rahman', 'Jl. Lampung Keatas KeBawah Jungkir Balik No 100', '086978657812', 'ArRahman@yahoo.co.id', '', 5, 1838235),
('PJSAB23112154', 'G1148', '2010-11-23', 'Sabi', 'Jl. Mana Saja No.45', '087787689723', 'MajuBersamaBisa@Gmail.Com', 'PT.Bisa Maju', 50, 9566325);

-- --------------------------------------------------------

--
-- Table structure for table `suplier`
--

CREATE TABLE IF NOT EXISTS `suplier` (
  `kd_sp` varchar(20) NOT NULL,
  `nama_sp` varchar(50) NOT NULL,
  `perusahaan_sp` varchar(50) NOT NULL,
  `alamat_sp` varchar(50) NOT NULL,
  `kontak_sp` varchar(20) NOT NULL,
  PRIMARY KEY (`kd_sp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `suplier`
--

INSERT INTO `suplier` (`kd_sp`, `nama_sp`, `perusahaan_sp`, `alamat_sp`, `kontak_sp`) VALUES
('SDDIO17112132', 'Dio', 'PT.Distri com', 'Jl. Laut Merah no 17 Jawa Barat', '081256778999'),
('SSMAN17112157', 'Sudirman', 'PT.Astra Indo', 'Jl. Semangi no 35 Jawa Barat', '081287678493');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `barang`
--
ALTER TABLE `barang`
  ADD CONSTRAINT `barang_ibfk_1` FOREIGN KEY (`kd_kat`) REFERENCES `kategori` (`kd_kat`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `barang_ibfk_2` FOREIGN KEY (`kd_sp`) REFERENCES `suplier` (`kd_sp`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `penjualan`
--
ALTER TABLE `penjualan`
  ADD CONSTRAINT `penjualan_ibfk_1` FOREIGN KEY (`kd_brg`) REFERENCES `barang` (`kd_brg`) ON DELETE SET NULL ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50505
Source Host           : 127.0.0.1:3306
Source Database       : dyani

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2018-04-25 23:29:42
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for bahan_produksi
-- ----------------------------
DROP TABLE IF EXISTS `bahan_produksi`;
CREATE TABLE `bahan_produksi` (
  `id_bahan_produksi` int(11) NOT NULL AUTO_INCREMENT,
  `nama_bahan` varchar(255) DEFAULT NULL,
  `stok_bahan` int(11) DEFAULT NULL,
  `id_satuan` int(255) DEFAULT NULL,
  `harga` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_bahan_produksi`),
  KEY `id_stuan` (`id_satuan`),
  CONSTRAINT `id_stuan` FOREIGN KEY (`id_satuan`) REFERENCES `satuan` (`id_satuan`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of bahan_produksi
-- ----------------------------

-- ----------------------------
-- Table structure for desain
-- ----------------------------
DROP TABLE IF EXISTS `desain`;
CREATE TABLE `desain` (
  `id_desain` int(255) NOT NULL AUTO_INCREMENT,
  `id_pesanan` int(255) DEFAULT NULL,
  `id_bahan` int(255) DEFAULT NULL,
  `id_satuan_desain` int(11) DEFAULT NULL,
  `ukuran_panjang` varchar(255) DEFAULT NULL,
  `ukuran_lebar` varchar(255) DEFAULT NULL,
  `ukuran_tinggi` varchar(255) DEFAULT NULL,
  `jumlah` varchar(255) DEFAULT NULL,
  `id_satuan_jumlah` int(11) DEFAULT NULL,
  `nama_file` varchar(255) DEFAULT NULL,
  `id_finishing` int(255) DEFAULT NULL,
  `jumlah_finishing` varchar(255) DEFAULT NULL,
  `id_satuan_finishing` int(255) DEFAULT NULL,
  `id_jenis_tinta` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_desain`),
  KEY `id_psanan` (`id_pesanan`),
  KEY `id_jnis_tinta` (`id_jenis_tinta`),
  KEY `id_finish` (`id_finishing`),
  KEY `id_bahn` (`id_bahan`),
  KEY `id_satun_jml` (`id_satuan_jumlah`),
  KEY `id_satun_fins` (`id_satuan_finishing`),
  KEY `id_satuan` (`id_satuan_desain`),
  CONSTRAINT `id_bahn` FOREIGN KEY (`id_bahan`) REFERENCES `bahan_produksi` (`id_bahan_produksi`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_finish` FOREIGN KEY (`id_finishing`) REFERENCES `bahan_produksi` (`id_bahan_produksi`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_jnis_tinta` FOREIGN KEY (`id_jenis_tinta`) REFERENCES `bahan_produksi` (`id_bahan_produksi`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_psanan` FOREIGN KEY (`id_pesanan`) REFERENCES `pesanan` (`id_pesanan`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_satuan` FOREIGN KEY (`id_satuan_desain`) REFERENCES `satuan` (`id_satuan`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_satun_fins` FOREIGN KEY (`id_satuan_finishing`) REFERENCES `satuan` (`id_satuan`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_satun_jml` FOREIGN KEY (`id_satuan_jumlah`) REFERENCES `satuan` (`id_satuan`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of desain
-- ----------------------------

-- ----------------------------
-- Table structure for jenis_pesanan
-- ----------------------------
DROP TABLE IF EXISTS `jenis_pesanan`;
CREATE TABLE `jenis_pesanan` (
  `id_jenis_pesanan` int(255) NOT NULL AUTO_INCREMENT,
  `nama_pesanan` varchar(255) DEFAULT NULL,
  `harga` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_jenis_pesanan`),
  KEY `id_jenis_pesanan` (`id_jenis_pesanan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of jenis_pesanan
-- ----------------------------

-- ----------------------------
-- Table structure for pesanan
-- ----------------------------
DROP TABLE IF EXISTS `pesanan`;
CREATE TABLE `pesanan` (
  `id_pesanan` int(11) NOT NULL,
  `nama_pemesan` varchar(255) DEFAULT NULL,
  `telp_pemesan` varchar(255) DEFAULT NULL,
  `datetime_pesanan` datetime DEFAULT NULL,
  `datetime_selesai` datetime DEFAULT NULL,
  `id_jenis_pesanan` int(255) DEFAULT NULL,
  `jumlah_jenis_pesanan` varchar(255) DEFAULT NULL,
  `id_satuan_jumlah_jenis_pesanan` int(11) DEFAULT NULL,
  `id_bahan` int(255) DEFAULT NULL,
  `jumlah` varchar(255) DEFAULT NULL,
  `id_satuan_jumlah` int(11) DEFAULT NULL,
  `tipe_pembayaran` varchar(255) DEFAULT NULL,
  `via_bank` varchar(255) DEFAULT NULL,
  `id_penerima` int(255) DEFAULT NULL,
  `id_pembuat` int(255) DEFAULT NULL,
  `id_operator_finishing` int(255) DEFAULT NULL,
  `id_operator_cetak` int(255) DEFAULT NULL,
  `tracking` varchar(255) DEFAULT NULL,
  `biaya` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_pesanan`),
  KEY `id_op_finish` (`id_operator_finishing`),
  KEY `id_op_cetak` (`id_operator_cetak`),
  KEY `id_bahan` (`id_bahan`),
  KEY `id_penerma` (`id_penerima`),
  KEY `id_jnis_pesanan` (`id_jenis_pesanan`),
  KEY `id_stn_jmlh` (`id_satuan_jumlah`),
  KEY `id_pembuat` (`id_pembuat`),
  KEY `id_stn_jmlh_pesanan` (`id_satuan_jumlah_jenis_pesanan`),
  CONSTRAINT `id_bahan` FOREIGN KEY (`id_bahan`) REFERENCES `bahan_produksi` (`id_bahan_produksi`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_jnis_pesanan` FOREIGN KEY (`id_jenis_pesanan`) REFERENCES `jenis_pesanan` (`id_jenis_pesanan`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_op_cetak` FOREIGN KEY (`id_operator_cetak`) REFERENCES `user` (`id_user`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_op_finish` FOREIGN KEY (`id_operator_finishing`) REFERENCES `user` (`id_user`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_pembuat` FOREIGN KEY (`id_pembuat`) REFERENCES `user` (`id_user`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_penerma` FOREIGN KEY (`id_penerima`) REFERENCES `user` (`id_user`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_stn_jmlh` FOREIGN KEY (`id_satuan_jumlah`) REFERENCES `satuan` (`id_satuan`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_stn_jmlh_pesanan` FOREIGN KEY (`id_satuan_jumlah_jenis_pesanan`) REFERENCES `satuan` (`id_satuan`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of pesanan
-- ----------------------------

-- ----------------------------
-- Table structure for satuan
-- ----------------------------
DROP TABLE IF EXISTS `satuan`;
CREATE TABLE `satuan` (
  `id_satuan` int(255) NOT NULL AUTO_INCREMENT,
  `nama_satuan` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_satuan`),
  KEY `id_satuan` (`id_satuan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of satuan
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `hak_akses` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of user
-- ----------------------------

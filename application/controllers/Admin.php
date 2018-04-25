<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Account extends CI_Controller {
	function __construct(){
		parent::__construct();
		date_default_timezone_set("Asia/Jakarta");
	}

	/*
	*	dashboard ini memuat informasi yang dapat diatur rentang tampilannya berdasar tanggal
	*	ongoing order (nama pemesan,jenis order (banner || name tag || x-banner), harga order, jenis pembayaran, tgl order, status (dalam antrian || sedang dalam pengerjaan || sedang proses pelunasan))
	*	finished order (detail order : jenis order, harga order, tgl order, tgl finished)
	*	log pembelian bahan (nama bahan, harga bahan, tgl beli)
	*	log pemakaian bahan (tinta / botol, kertas / rim, banner / meter2)
	*	biaya produksi (grafik)
	*	pemasukan uang (grafik)
	*/
	function dashboard(){}

}k
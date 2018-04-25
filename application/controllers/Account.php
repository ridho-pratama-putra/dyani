<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Account extends CI_Controller {
	function __construct(){
		parent::__construct();
		date_default_timezone_set("Asia/Jakarta");
	}

	function login(){
		$this->load->view();
		$this->load->view();
		$this->load->view();
	}

	function register_user(){
		$this->load->view();
		$this->load->view();
		$this->load->view();
	}

	function registered_user(){
		$this->load->view();
		$this->load->view();
		$this->load->view();
	}

	function change_password(){
		$this->load->view();
		$this->load->view();
		$this->load->view();
	}

	function handle_login()
	{
		$this->form_validation->set_rules('nomor_identitas', 'Username', 'trim|required|xss_clean');
		$this->form_validation->set_rules('password', 'Password', 'trim|required|xss_clean');
		if ($this->form_validation->run() == FALSE) { 
			$this->form_validation->set_error_delimiters('<div class="alert alert-primary" role="alert">', '</div>');
			/*<?php echo validation_errors(); ?>*/
			redirect('Account/login');
		}
		else {
			$data = array(	
							'username'	=>	$this->input->post('username'),
							'password'	=>	hash("sha256", $this->input->post('password'))
			);
			$result = $this->SO_M->read('user',$data)->result();
			if ($result != array()) {
				$data_user['id_user']		= $result[0]->id_user;
				$data_user['username']		= $result[0]->username;
				$data_user['hak_akses']		= $result[0]->hak_akses;
				$session_data = array(
											'hak_akses'		=>	$result[0]->hak_akses,
											'id_user'	=>	$result[0]->id_user,
											'username'	=>	$result[0]->username
				);
				alert('alert_akun','success','Berhasil','Selamat datang '.$session_data['username']);
				$this->session->set_userdata('dyani_session', $session_data);
				/*
				*	SADM : superadmin
				*	ADM : admin
				*	CS : customer service
				*	KP : karyawan produksi
				*/
				if ($data_user['hak_akses'] == 0) {
					redirect('SADM/');
				}
				elseif ($data_user['hak_akses'] == '1') {
					redirect('Admin/');
				}
				elseif ($data_user['hak_akses'] == '2') {
					redirect('CustServ/');
				}
				elseif($data_user['hak_akses'] == '3'){
					redirect("KarProd/");
				}
			}
			else {
				alert('alert_akun','danger','Gagal','Account anda tidak terdaftar');
				redirect('Account/login');
			}
		}
	}
	
	function handle_logout() 
	{
		$sess_array = array(
							'username' => '',
							'id_user' => '',
							'hak_akses' => ''
		);
		$hapus_session = $this->session->unset_userdata('dyani_session', $sess_array);
		alert('alert_akun','success','Berhasil','Anda berhasil logout');
		redirect('Account/login');
	}

	/*
	*	function dibawah ini digunakan oleh admin saat akan mendaftarkan pengguna baru.
	*	bisa admin, ppk, atau pengguna
	*/
	function handle_register_user()
	{
		$this->form_validation->set_rules('username','Nama','trim|required');
		$this->form_validation->set_rules('hak_akses','Hak akses','trim|required');

		if ($this->form_validation->run() == FALSE) {
			alert('alert_akun','danger','Gagal','Kesalahan pada form validation');
			redirect('Account/register_user');
		}
		else {			
			$data = array(	
							'username'			=>	$this->input->post('username'),
							'password'			=>	hash("sha256", "Dyani123"),
							'hak_akses'			=>	$this->input->post('hak_akses')
			);

			$result 		=	$this->SO_M->create('user',$data);
			$results		=	json_decode($result,true);
			if ($results['status']) {
				alert('alert_akun','success','Berhasil','Registrasi berhasil');
			}
			else{
				alert('alert_akun','success','Gagal','Kegagalan database');
			}
			redirect('Account/registered_user');
		}
	}


	/*
	*	function ini dipanggil pada change_password
	*/
	function handle_reset_password($id_user)
	{
		if ($this->session->userdata['dyani_session']['hak_akses'] == '1' OR $this->session->userdata['dyani_session']['hak_akses'] == '0') {
			$result 				= $this->SO_M->update('user',array("id_user" => $id_user),array("password" => hash("sha256", "SO")));
			$result 				= json_decode($result);
			if ($result->status) {
				alert('alert_akun','success','Berhasil','Reset password berhasil');
			}
			else{
				alert('alert_akun','danger','Gagal','Reset password gagal');
			}
			redirect('Account/registered_user');
		}else{
			$data['heading']		=	"Anda tidak memiliki hak";
			$data['message']		=	"Hubungi admin untuk melakukan reset password";
			$this->load->view('errors/html/error_404',$data);
		}
	}

	function handle_change_password()
	{
		if ($this->input->post()!= null) {
			$id_user 				= $this->input->post('id_user');
			$current_password 		= $this->input->post('current_password');
			$new_password 			= $this->input->post('new_password');
			$verif_password 		= $this->input->post('verif_password');
			$encrypted_current 		= hash("sha256",$current_password);
			$cek_user_dan_password 	= $this->SO_M->readCol('user',array('id_user'=>$id_user,'password'=>$encrypted_current),array('id_user'));
			if ($cek_user_dan_password->num_rows() == 1) {
				$encrypted_new 		= hash('sha256',$new_password);
				$encrypted_verif 	= hash('sha256',$verif_password);
				if ($encrypted_new == $encrypted_verif) {
					$result 		= $this->SO_M->update('user',array('id_user'=>$id_user),array('password'=>$encrypted_verif));
					$results 		= json_decode($result);
					if ($results->status) {
						alert('alert_akun','success','Berhasil','Ubah password berhasil');
					}
					else{
						alert('alert_akun','danger','Gagal','Ubah password gagal');
					}
				}else{
					alert('alert_akun','danger','Gagal','password baru dengan password verifikasi tidak sama');
				}
			}else{
				alert('alert_akun','danger','Gagal','data user tidak ditemukan');
			}
		}else{
			alert('alert_akun','danger','Gagal','tidak ada data yang di post');
		}
		redirect('Account/change_password/'.$id_user);
	}
}k
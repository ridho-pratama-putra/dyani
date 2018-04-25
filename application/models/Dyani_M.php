<?php 
defined('BASEPATH') OR exit('No direct script access allowed');
class Dyani_M extends CI_Model {
	public function __construct(){
		parent::__construct();
	}
	
	/*	
	*	untuk baca data >1 baris
	*	harus result() jika ingin fetch
	*	num_rows()
	*	etc
	*/
	public function readS($table){
		return $this->db->get($table);
	}
	
	/*	
	*	untuk baca data 1 baris/ spesifik
	*	harus result() jika ingin fetch
	*	num_rows()
	*	etc
	*/
	public function read($table,$dataCondition){
		$this->db->where($dataCondition);
		return $this->db->get($table);
	}

	/*	
	*	dapatkan data hanya kolom tertentu saja
	*	harus result() jika ingin fetch
	*	num_rows()
	*	etc
	*	1 baris data
	*/
	public function readCol($table,$dataCondition,$cols)
	{
		$this->db->select($cols);
		$this->db->where($dataCondition);
		return $this->db->get($table);
	}

	/*	
	*	dapatkan data hanya kolom tertentu saja
	*	harus result() jika ingin fetch
	*	num_rows()
	*	etc
	*	>1 baris
	*/
	public function readSCol($table,$cols)
	{
		$this->db->select($cols);
		return $this->db->get($table);
	}

	/*	
	*	untuk insert sebuah data ke sebuah tabel
	*/
	public function create($table,$data){
		return $this->db->insert($table, $data);
	}

	/*	
	*	untuk insert sebuah data ke tabel dan ambil idnya
	*/
	public function create_id($table,$data)
	{
		return $this->db->insert($table, $data);		
	}

	/*	
	*	untuk insert >1 baris data
	*/
	public function createS($table,$data){
		return $this->db->insert_batch($table,$data);
	}
	
	public function delete($table,$dataCondition){
		$this->db->where($dataCondition);
		return $this->db->delete($table);
	}

	/*	
	*	untuk update data
	*/
	public function update($table,$dataCondition,$dataUpdate){
		$this->db->where($dataCondition);
		return $this->db->update($table,$dataUpdate);
	}

	public function whereLike($table,$where,$like){
		$this->db->where($where);
		$this->db->like($like);
		return $this->db->get($table);
	}

	public function rawQuery($query){
		return $this->db->query($query);		
	}
}
?>
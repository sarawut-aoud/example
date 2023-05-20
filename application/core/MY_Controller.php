<?php
if (!defined('BASEPATH'))
	exit('No direct script access allowed');

class MY_Controller extends CI_Controller
{

	public $data;

	protected $another_js;
	protected $another_css;

	private $_version = '0.1';

	public function __construct()
	{
		parent::__construct();
		$this->data = array();


		$data['base_url'] = base_url();
		$data['site_url'] = site_url();
		$data['tab_header'] = array();
		$data['page_title'] = "Lotto Ver. $this->_version ";
		$data['system_title'] = "Lotto [ Ver. $this->_version ]";
		$this->data = $data;
		$csrf_token_name = $this->security->get_csrf_token_name();
		$this->data['csrf_token_name'] = $csrf_token_name;
		$this->data['csrf_cookie_name'] = $this->config->item('csrf_cookie_name');
		$data['csrf_protection_field'] = insert_csrf_field(true);
	}
	public function setRes($status = false, $data, $code)
	{
		$json = [
			'status' => $status,
			'data' => $data,
			'code' => $code,
		];
		echo json_encode($json);
	}
	public function response($data = '')
	{
		$json = [
			'status' => false,
			'data' => null,
			'code' => 400,
		];
		echo json_encode($json);
	}
}

<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Dashboard extends MY_Controller
{

    function __construct()
    {
        parent::__construct();
        // $this->another_js = '<script src="' . base_url('assets/js_module/home.js?ft=') . time() . '"> </script>';
        $this->data['tab_header'] = array();
    }
    protected function renderview($path)
    {
        $this->data['page_content'] = $this->parser->parse_repeat($path, $this->data, TRUE);
        $this->data['another_css'] = $this->another_css;
        $this->data['another_js'] = $this->another_js;
        $this->parser->parse('templates/pageview', $this->data);
    }
    public function index()
    {
        // $this->renderview('');
    }
   
}

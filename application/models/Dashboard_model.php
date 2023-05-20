<?php

if (!defined('BASEPATH'))  exit('No direct script access allowed');

class Dashboard_model extends CI_Model

{
    public function __construct()
    {
        parent::__construct();
        $this->code = 200;
        $this->status = false;
    }
}

<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Dashboard extends CI_Controller {

    public function index() {
        if (!$this->session->userdata('user_data')) {
            redirect($this->config->item('base_url_redirect') . 'users/login');
        } else {
            $this->load->helper('locale');

            $localesArray = getLocaleFromDB($this->db);
            $this->load->view('Dashboard', array(
                "T" => $localesArray,
                'baseUrl' => $this->config->item('base_url'),
                'baseUrlRedirect' => $this->config->item('base_url_redirect'),
                "localeDictionary" => getLocaleDictionary($localesArray)
            ));
        }
	}

}

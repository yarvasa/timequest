<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Users extends CI_Controller {

    public function index() {
        $this->load->library('ulogin');
        $this->load->library('uauth');

        $accountRecord = $this->ulogin->userdata($_REQUEST['token']);

        $query = $this->db->select('*')
                      ->from('users')
                      ->where('uid', $accountRecord['uid'])
                      ->where('network', $accountRecord['network'])
                      ->get();

        if ($query->num_rows() == 0) {
            $this->create_new_account($accountRecord);
        } else {
            $this->update_last_logged($accountRecord, $query);
        }

        $this->session->set_userdata('user_data', json_encode($accountRecord));
        redirect($this->config->item('base_url_redirect'), 'local');
	}

    private function create_new_account($accountRecord) {
        $currentTimeStamp = $this->getCurrentTime();

        $this->db->insert('users', array(
            "uid"       => $accountRecord['uid'],
            "photo"     => $accountRecord['photo'],
            "identity"  => $accountRecord['identity'],
            "first_name"=> $accountRecord['first_name'],
            "last_name" => $accountRecord['last_name'],
            "profile"   => $accountRecord['profile'],
            "network"   => $accountRecord['network'],
            "email"     => $accountRecord['email'],
            "type"      => "USER",
            "createdTime"   => $currentTimeStamp,
            "lastLoggedBy"  => $currentTimeStamp
        ));
    }

    private function update_last_logged($accountRecord, $query) {
        $currentTimeStamp = $this->getCurrentTime();

        $this->db->where("uid", $accountRecord['uid']);
        $this->db->update('users', array(
            "lastLoggedBy" => $currentTimeStamp
        ));

        $this->db->insert('users_history', array(
            "id_user"   => $accountRecord['uid'],
            "loginTime" => $currentTimeStamp
        ));
    }

    private function getCurrentTime() {
        return date_timestamp_get(date_create());
    }

    public function logout() {
        $this->session->unset_userdata("user_data");
        redirect($this->config->item('base_url_redirect'), 'local');
    }

    public function login() {
        $this->load->library('ulogin');
        $this->load->library('uauth');

        $this->load->view('Login', array(
            "loginButtonsView" => $this->ulogin->get_html(),
            'baseUrl' => $this->config->item('base_url')
        ));
    }
}

<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Team extends CI_Controller {

    public function getCurrentTeamData() {
        $result = array();
        $userdata = $this->session->userdata('user_data');

        if (!$userdata) {
            $result['success'] = false;
            $result['errorReason'] = 'AUTH';
        } else {
            $userdata = json_decode($userdata);

            $result['data'] = array(
                "currentTeam" => $this->getCurrentTeam($userdata),
                "invites" => $this->getUserInvites($userdata)
            );

            $result['success'] = true;
        }

        echo json_encode($result);
	}

    private function getCurrentTeam($userdata) {
        $query = $this->db->select('*')
                      ->from('users_in_team')
                      ->where('id_user', $userdata->uid)
                      ->get();

        if ($query->num_rows() == 0) {
            return null;
        } else {
            return $query->row_array();
        }
    }

    private function getUserInvites($userdata) {
        $query = $this->db->select('ui.*, CONCAT(u.first_name, \' \', u.last_name) AS author_name, t.name AS team_name')
                      ->from('users_invites ui')
                      ->join('users u', 'u.uid = ui.id_author')
                      ->join('teams t', 't.id = ui.id_team')
                      ->where('ui.id_user', $userdata->uid)
                      ->where('ui.status', 'IN_PROGRESS')
                      ->get();

        $result = array();
        foreach ($query->result_array() as $row) {
            $result[] = $row;
        }

        return $result;
    }
}

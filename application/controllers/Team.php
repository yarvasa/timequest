<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Team extends CI_Controller {

    public function getCurrentTeamData() {
        if ($this->isUserData()) {
            $userdata = $this->isUserData();
            $result = array();

            $result['data'] = array(
                "currentTeam" => $this->getCurrentTeam($userdata),
                "invites" => $this->getUserInvites($userdata)
            );

            $result['success'] = true;
            echo json_encode($result);
        }
	}

    private function isUserData() {
        $userdata = $this->session->userdata('user_data');

        if (!$userdata) {
            $result = array();
            $result['success'] = false;
            $result['errorReason'] = 'AUTH';
            echo json_encode($result);
            return false;
        }
        return json_decode($userdata);
    }

    private function getCurrentTeam($userdata) {
        $query = $this->db->select('uit.*, t.name AS teamName')
                      ->from('users_in_team uit')
                      ->join('teams t', 't.id = uit.id_team')
                      ->where('uit.id_user', $userdata->uid)
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

    public function declineInvite($id) {
        if ($this->isUserData()) {
            $result = array();
            $userdata = $this->isUserData();

            if ($this->getUserInviteQuery($id, $userdata->uid)->num_rows() == 0) {
                $result['success'] = false;
                $result['error'] = 'app.error.unresolved_invite';
            } else {
                $this->db
                    ->where('id', $id)
                    ->update('users_invites', array(
                        "status" => "DECLINED"
                    ));
                $result['success'] = true;
            }

            echo json_encode($result);
        }
    }

    public function acceptInvite($id) {
        if ($this->isUserData()) {
            $result = array();
            $userdata = $this->isUserData();
            $inviteQuery = $this->getUserInviteQuery($id, $userdata->uid);

            if ($inviteQuery->num_rows() == 0) {
                $result['success'] = false;
                $result['error'] = 'app.error.unresolved_invite';
            } else if ($this->getCurrentTeam($userdata)) {
                $result['success'] = false;
                $result['error'] = 'app.invites.not_available_reason';
            } else {
                $inviteRecord = $inviteQuery->row_array();
                $this->db->insert("users_in_team", array(
                    "id_user" => $userdata->uid,
                    "id_team" => $inviteRecord["id_team"],
                    "status" => "HUMAN"
                ));
                $this->db
                    ->where('id', $id)
                    ->update('users_invites', array(
                        "status" => "ACCEPTED"
                    ));
                $result['success'] = true;
            }

            echo json_encode($result);
        }
    }

    private function getUserInviteQuery($inviteId, $user_id) {
        return $this->db
            ->select('id, id_team')
            ->from('users_invites')
            ->where('id', $inviteId)
            ->where('id_user', $user_id)
            ->where('status', "IN_PROGRESS")
            ->get();
    }

    public function leaveTeam() {
        if ($this->isUserData()) {
            $result = array("success" => true);
            $userdata = $this->isUserData();

            $this->db
                ->where('id_user', $userdata->uid)
                ->delete('users_in_team');

            echo json_encode($result);
        }
    }
}

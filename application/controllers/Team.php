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

            $result["data"]["usersInTeam"] = $result["data"]["currentTeam"]
                ? $this->getUsersInTeam($result["data"]["currentTeam"]["id_team"])
                : null;

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

    private function getCountUsersInTeam($teamId) {
        $query = $this->db->select('id')
            ->from('users_in_team')
            ->where('id_team', $teamId)
            ->get();

        return $query->num_rows() == 0;
    }

    private function getTeamIdByUserId($userId) {
        $query = $this->db->select('id_team')
            ->from('users_in_team')
            ->where('id_user', $userId)
            ->get();

        if ($query->num_rows() == 0) {
            return null;
        } else {
            $record = $query->row_array();
            return $record["id_team"];
        }
    }

    public function leaveTeam() {
        if ($this->isUserData()) {
            $result = array("success" => false);
            $userdata = $this->isUserData();
            $teamId = $this->getTeamIdByUserId($userdata->uid);

            if ($teamId == null) {
                $result["error"] = 'app.error.without_team';
            } else if ($this->getCountUsersInTeam($teamId) < 2) {
                $result["error"] = 'app.error.team.last_participant';
            } else {
                $result["success"] = true;
                $this->db
                    ->where('id_user', $userdata->uid)
                    ->delete('users_in_team');

            }
            echo json_encode($result);
        }
    }

    private function getUsersInTeam($idTeam) {
        $query = $this->db->select('uit.id_user, uit.status, CONCAT(u.first_name, \' \', u.last_name) AS username, u.profile')
            ->from('users u')
            ->join('users_in_team uit', 'uit.id_user = u.uid')
            ->where('uit.id_team', $idTeam)
            ->get();

        if ($query->num_rows() == 0) {
            return null;
        } else {
            $result = array();
            foreach ($query->result_array() as $row) {
                $result[] = $row;
            }
            return $result;
        }
    }

    private function getTeamByName($teamName) {
        $query = $this->db->select('id')
            ->from('teams')
            ->where('name', $teamName)
            ->where('status', "ACTIVE")
            ->get();

        if ($query->num_rows() == 0) {
            return null;
        } else {
            return $query->row_array();
        }
    }

    public function createTeam() {
        $json = file_get_contents('php://input');
        $post = json_decode($json);

        if ($this->isUserData()) {
            $result = array(
                "success" => false
            );
            $userdata = $this->isUserData();
            $teamName = $post->teamName;

            if (!$teamName) {
                $result["error"] = 'app.team.empty_name';
            } else if ($this->getCurrentTeam($userdata)) {
                $result["error"] = 'app.error.cant_create_in_team';
            } else if ($this->getTeamByName($teamName)) {
                $result["error"] = 'app.error.not_unique_team_name';
            } else {
                $this->db->insert("teams", array(
                    "name" => $teamName,
                    "status" => "ACTIVE"
                ));

                $createdTeam = $this->getTeamByName($teamName);
                $this->db->insert("users_in_team", array(
                    "id_user" => $userdata->uid,
                    "id_team" => $createdTeam['id'],
                    "status" => "CAPTAIN"
                ));

                $result["success"] = true;
            }

            echo json_encode($result);
        }
    }
}

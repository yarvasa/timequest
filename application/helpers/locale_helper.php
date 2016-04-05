<?php
defined('BASEPATH') OR exit('No direct script access allowed');

function getLocaleFromDB($db) {
    $query = $db->select('*')
                ->from('locale')
                ->get();

    $localeArray = array();
    foreach ($query->result_array() as $locale) {
        $localeArray[$locale['key']] = $locale['value'];
    }
    return $localeArray;
}

function getLocaleDictionary($localesArray) {
    $result = array();

    foreach ($localesArray as $key => $value) {
        $result[] = "'$key':'" . addslashes($value) . "'";
    }

    return '{' . implode($result, ',') . '}';
}
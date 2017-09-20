<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/8/28
 * Time: 16:47
 */

namespace app\admin\controller;


class Admin extends Common
{
    public function index() {
        return $this->fetch('admin-list');
    }
    public function add() {
        return $this->fetch('admin-add');
    }
    public function role() {
        return $this->fetch('admin-role');
    }
    public function roleAdd() {
        return $this->fetch('admin-role-add');
    }
    public function permission() {
        return $this->fetch('admin-permission');
    }
    public function permissionEdit() {
        return $this->fetch('admin-permission-edit');
    }
}
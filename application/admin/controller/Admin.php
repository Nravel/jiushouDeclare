<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/8/28
 * Time: 16:47
 */

namespace app\admin\controller;


use think\Loader;
use think\Session;

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
    public function passwordEdit() {
        $request = $this->request->post();
        if ($request!=null) {
            $admin = Loader::model('Admin');
            $result = $admin->get(['username'=>Session::get('username'),'password'=>md5($request['oldpassword'])]);
            if ($result) {
                $admin->save(['password'=>$request['newpassword']]);
            }else{
                return [
                    'code' => '0002',
                    'msg' => "原密码错误！"
                ];
            }
        }else{
            return $this->fetch('admin-password-edit');
        }
    }
}
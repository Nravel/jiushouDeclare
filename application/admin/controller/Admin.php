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
            $admin = new \app\admin\model\Admin();
            $result = $admin->get(['username'=>Session::get('username'),'password'=>md5($request['oldpassword'])]);
            if ($result) {
                $admin->noUpdate();
                $admin->save(['password'=>md5($request['newpassword'])],['username'=>Session::get('username')]);
                return [
                    'code' => '0000',
                    'msg' => "修改成功！"
                ];
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
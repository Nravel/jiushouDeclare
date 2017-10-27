<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/8/28
 * Time: 16:47
 */

namespace app\admin\controller;


use think\Db;
use think\Loader;
use think\Session;
use think\Validate;

class Admin extends Common
{
    public function index() {
        return $this->fetch('admin-list');
    }
    public function add() {
        return $this->fetch('admin-add');
    }
    public function edit() {
        $uid = $this->request->param('uid');
        return $this->fetch('admin-edit',['uid'=>$uid]);
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

    /**
     * 修改后台用户密码
     * @return array|mixed
     */
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

    /**
     * 获取管理员列表
     * @return array
     */
    public function getUsers() {
        $limit = $this->request->get('limit');
        $page = $this->request->get('page');
        $join = [
                ['ceb_auth_group_access b','a.id=b.uid'],
//                ['ceb_auth_group c','b.group_id=c.id']
            ];
//        $field = "*,a.status as status,c.status as group_status,a.id as id";
        $field = "";
        $admin = new \app\admin\model\Admin();
        $data = $admin->alias('a')->join($join)->field($field)->select();
        $count = $admin->alias('a')->join($join)->count();
        if ($count>0) {
            foreach ($data as $k => $record) {
                if ($record['group_id']==="") {
                    $data[$k]['title'] = "未分组";
                }else{
                    $auth_group = Db::name('auth_group');
                    $res = $auth_group->where('id','in',$record['group_id'])->select();
                    $temp = null;
                    foreach ($res as $val) {
                        $temp[]=$val['title'];
                    }
                    $data[$k]['title'] = implode(',',$temp);
                }
            }
            $data_format = [
                "code" => 0,
                "msg" => "success",
                "count" => $count,
                "data" => $data,
            ];
            return $data_format;
        }else{
            return [
                'code' => '0001',
                'msg' => '无数据！'
            ];
        }
    }

    /**
     * 删除用户
     * @return array
     */
    public function delUsers() {
        $id = $this->request->post('id');
        $data = $this->request->post('data');
        $admin = Loader::model('admin');
        $auth_group_access = Db::name('auth_group_access');
        if ($data===null) {
            $res = $admin::destroy(['id'=>$id]) or 0;
            $res ? $auth_group_access->where('uid='.$id)->delete() : "" ;
        }else{
            foreach (explode('|',$data) as $val) {
                $res = $admin::destroy(['id'=>$val]) or 0;
                $res ? $auth_group_access->where('uid='.$val)->delete() : "" ;
                if (!$res) break;
            }
        }
        if ($res) {
            return [
                'code' => '0000',
                'msg' => '删除成功！'
            ];
        }else{
            return [
                'code' => '0001',
                'msg' => '删除失败！'
            ];
        }
    }

    /**
     * 获取用户组
     * @return array
     */
    public function getAuthGroup() {
        $auth_group = Db::name('auth_group');
        $data = $auth_group->select();  //->where('type','<>','-1')
        return [
            'code' => '0000',
            'data' => $data
        ];
    }

    /**
     * 添加用户
     * @return array
     */
    public function addUser() {
        $username = $this->request->post('username');
        $password = $this->request->post('password');
        $status = $this->request->post('status');
        $gid = $this->request->post('gid/a') ? implode(',',$this->request->post('gid/a')) : "";
        $validate = new Validate([
            'username' => 'require',
            'password' => 'require'
        ]);
        if (!$validate->batch()->check(['username'=>$username,'password'=>$password])) {
            return [
                'code' => '0003',
                'msg' => $validate->getError()
            ];
        }
        $admin = new \app\admin\model\Admin();
        $auth_group_access = Db::name('auth_group_access');
        Db::startTrans();
        try{
            $admin->data(['username'=>$username,'password'=>md5($password),'status'=>$status]);
            $admin->noUpdate();
            $admin->isUpdate(false)->save();
            $res = $auth_group_access->insert(['uid'=>$admin->id,'group_id'=>$gid]);
            if ($res) {
                Db::commit();
                return [
                    'code' => '0000',
                    'msg' => '用户添加成功！'
                ];
            }
        }catch (\Exception $e) {
            Db::rollback();
            return [
                'code' => '0002',
                'msg' => $e->getMessage()
            ];
        }
    }
}
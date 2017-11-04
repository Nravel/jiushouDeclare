<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/8/28
 * Time: 9:23
 */
//公共控制器类
namespace app\admin\controller;


use app\common\controller\Auth;
use think\Controller;
use think\Request;
use think\Session;
use think\Url;

class Common extends Controller
{
    protected $request = null;
    protected $username;
    protected $status;
    protected $allowLists = [
        'admin/order/getorderdatas',
        'admin/order/getorderbatch',
        'admin/admin/getusers',
        'admin/admin/getgroups',
        'admin/admin/getpermissiondata',
        'admin/search/searchbymultiple',
        'admin/admin/search',
        'admin/admin/getrules',
        'admin/admin/getauthgroup'
        ];

    public function __construct(Request $request = null) {
        parent::__construct($request);
        $this->request = $request;
        //登录控制
        if (!Session::get('username')) {
            $this->redirect('login/index');
            exit;
        }
        $auth = new Auth();
        $rule = $request->path();
        $uid = Session::get('uid');
//        dump($rule);exit;
        if (!$auth->check($rule,$uid)&&$uid != SUPER&&!in_array($rule,$this->allowLists)) {
//            $this->error('您没有权限访问！','','',1);
//         return   file_get_contents(url('admin/Index/index','',true,true));
//            header('X-Frame-Options:Deny');
            dump($rule);exit;
//            echo '<script>
////                    alert("您没有权限访问！");
//                    window.onload = function() {removeIframe();}
////                    top.location.href = "'.Url::build('admin/index/index','',true,true).'"
//                    </script>';
        }
//        $this->username = Session::get('username');
//        $this->status = Session::get('status');
//        if(Session::get('status')){
//            $this->error('请注意，该帐户已登录！',Url::build('admin/Index/index'),'',1);
//        }
    }

}
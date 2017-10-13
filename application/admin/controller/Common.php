<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/8/28
 * Time: 9:23
 */
//公共控制器类
namespace app\admin\controller;


use think\Controller;
use think\Request;
use think\Session;
use think\Url;

class Common extends Controller
{
    protected $request = null;
    protected $username;
    protected $status;

    public function __construct(Request $request = null) {
        parent::__construct($request);
        $this->request = $request;
        //登录控制
        if (!Session::get('username')) {
            $this->redirect('login/index');
        }
        $this->username = Session::get('username');
        $this->status = Session::get('status');
        if(Session::get('status')){
            $this->error('请注意，该帐户已登录！',Url::build('admin/Index/index'),'',1);
        }
    }

}
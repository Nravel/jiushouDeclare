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
//        'admin/index/index',
        'admin/order/preview',
        'admin/order/clearUploads',
        'admin/search/searchbymultiple',
		'admin/admin/search',
		'admin/admin/getauthgroup'
        ];

    public function __construct(Request $request = null) {
        parent::__construct($request);
        $this->request = $request;
        //登录控制
//        if (!Session::get('username')) {
////            $this->redirect('login/index');
//            $this->error('请先登录！',"javascript:top.location.href="."'".$request->domain() .Url::build('login/index')."'",'',1);
//        }
        //权限验证
//        $auth = new Auth();
//        $rule = substr_replace($request->path(),'',strpos($request->path(),'/orderNum'));
//        $rule = preg_replace('/\/orderNum(.*)$/','',$request->path());
//        if ($request->isAjax()) {array_push($this->allowLists,'admin/order/details');}
//        $uid = Session::get('uid');
//        if ($uid != SUPER&&!in_array($rule,$this->allowLists)&&!$auth->check($rule,$uid)) {
////            dump($rule);exit;
//            if (!$request->isAjax()) {
//                echo '<script>
//                        var navtabs = window.parent.document.getElementById("min_title_list");
//                        var iframes = window.parent.document.getElementById("iframe_box");
//                        if (iframes===null) {
//                            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
//                            parent.layer.open({content: "您没有权限访问！"});
//                            parent.layer.close(index); //执行关闭自身操作
//                        }else{
//                            window.onload = function() {layer.open({content: "您没有权限访问！"})}
//                            iframes.removeChild(iframes.lastElementChild);
//                            iframes.lastElementChild.style.display = "block";
//                            navtabs.removeChild(navtabs.lastElementChild);
//                            navtabs.lastElementChild.classList.add("active");
//                            iframes.lastElementChild.querySelector("iframe").contentWindow.layer.open({content: "您没有权限访问！"});
//                        }
//                   </script>';
//                die('没有权限！');
//            }else{
//                die('没有权限！');
//            }
//        }
    }
}
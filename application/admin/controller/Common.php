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

class Common extends Controller
{
    protected $request = null;
    public function __construct(Request $request = null)
    {
        parent::__construct($request);
        $this->request = $request;
    }
}
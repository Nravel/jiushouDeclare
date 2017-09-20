<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/8/28
 * Time: 9:43
 */

namespace app\admin\controller;


class Login extends Common
{
    public function index() {
        return $this->fetch('login');
    }
}
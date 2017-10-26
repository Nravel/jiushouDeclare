<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/8/17
 * Time: 15:48
 */
namespace app\admin\model;
use think\Model;

class Admin extends Model {
    protected $autoWriteTimestamp = 'datetime';
    protected $createTime  = false;
    protected $updateTime = 'login_time';

    public function noUpdate() {
        $this->updateTime = false;
    }

}
<?php
/**
 * Created by PhpStorm.
 * Client: clientistrator
 * Date: 2017/12/4
 * Time: 17:33
 */

namespace app\admin\controller;

use think\Validate;
use app\admin\model\Client as ClientModel;


class Client extends Common {

    protected $clientModel;
    protected $noParam = true;    //请求参数为空

    public function _initialize()
    {
        parent::_initialize(); // TODO: Change the autogenerated stub
        $this->clientModel = new ClientModel();
        $this->clientModel->request = $this->request;
        $this->noParam = count($this->request->param())===0;
    }

    /**
     * 客户列表
     * @return mixed
     */
    public function index() {
        if ($this->noParam) {
            return $this->fetch('client-list');
        }else{
            return $this->clientModel->getClients();
        }
    }

    /**
     * 客户添加
     * @return mixed
     */
    public function add() {
        if ($this->noParam) {
            return $this->fetch('client-add');
        }else{
            return $this->clientModel->addClient();
        }
    }

    /**
     * 客户修改
     * @return mixed
     */
    public function edit() {
        if ($this->noParam) {
            return $this->fetch('client-edit');
        }else{
            return $this->clientModel->editClient();
        }
    }

    /**
     * 客户删除
     * @return mixed
     */
    public function delClients() {
        return $this->clientModel->delClients();
    }

    /**
     * 客户搜索
     * @return mixed
     */
    public function search() {
        return $this->clientModel->search();
    }

    /**
     * 删除的客户
     * @return mixed
     */
    public function delList() {
        if ($this->noParam) {
            return $this->fetch('client-del-list');
        }else{
            return $this->clientModel->getClients(true);
        }
    }
}
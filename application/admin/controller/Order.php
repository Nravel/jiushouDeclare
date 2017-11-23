<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/9/11
 * Time: 11:49
 */

namespace app\admin\controller;


//use app\admin\model\OrderHead;
use app\admin\model\OrderPreview;
use app\common\controller\Excel;
//use think\Db;
//use think\Exception;
use think\Loader;
use app\admin\model\Order as OrderModel;

class Order extends Common
{
    protected $orderModel;
    protected $hasParam = false;

    public function _initialize()
    {
        parent::_initialize(); // TODO: Change the autogenerated stub
        $this->orderModel = new OrderModel();
        $this->orderModel->request = $this->request;
        $this->hasParam = count($this->request->param())>0;
    }

    /**
     * 订单列表页
     * @return mixed
     */
    public function index() {
        if ($this->hasParam) {
            return $this->orderModel->getOrderDatas();
        }else{
            return $this->fetch('order-list');
        }
    }

    /**
     * 订单详情
     * @return mixed
     */
    public function details() {
        $orderNo = $this->request->param('orderNum');
        if ($orderNo === null) {
            return $this->orderModel->getOrderDetails();
        }else{
            return $this->fetch('order-details',['orderNo'=>$orderNo]);
        }
    }

    /**
     * 订单修改
     * @return mixed
     */
    public function edit() {
        $orderNo = $this->request->param('orderNum');
        if ($orderNo === null) {
            return $this->orderModel->editOrder();
        }else{
            return $this->fetch('order-edit',['orderNo'=>$orderNo]);
        }
    }

    /**
     * 删除订单
     * @return mixed
     */
    public function delOrder() {
        return $this->orderModel->delOrder();
    }

    /**
     * 导入订单
     * @return mixed
     */
    public function importData() {
        return $this->orderModel->importData();
    }

    /**
     * 订单预览
     * @return mixed
     */
    public function preview() {
        if ($this->request->param('req')==='del') {
            return $this->orderModel->delPreviewOrder();
        }else if ($this->request->param('req')==='save') {
            try {
                return $this->orderModel->savePreviewData(json_decode($this->request->param('datas'),true));
            }catch (\Exception $e) {
                return $this->orderModel->savePreviewData($this->request->param('datas/a'));
            }
        }else if ($this->request->param('req')==='get') {
            return $this->orderModel->getPreviewData();
        }else if ($this->request->param('req')==='edit') {
            return $this->orderModel->editPreviewOrder();
        }else{
            return $this->fetch('order-preview');
        }
    }

    /**
     * 导出订单页
     * @return mixed
     */
    public function export() {
        if ($this->hasParam) {
            return $this->orderModel->getOrderBatch();
        }else{
            return $this->fetch('order-export');
        }
    }

    /**
     *导出excel数据
     */
    public function exportData() {
        //获取要导出的类型和批次
                $ex_info = explode("|",$this->request->post("ex_info"));
                $datatype = $this->request->post("datatype");
                $data = $this->request->post("data/a");
                Loader::model("OrderBatch")->exportOrders($ex_info,$data,$datatype);
    }

    /**
     *清空上传目录
     */
    public function clearUploads() {
        $excelObj = new Excel();
        is_dir("uploads") ? $excelObj->del_dir("uploads",1) : "" ;
    }
}
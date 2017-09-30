<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/9/11
 * Time: 11:49
 */

namespace app\admin\controller;


use app\admin\model\OrderHead;
use app\admin\model\OrderPreview;
use app\common\controller\Excel;
use think\Exception;
use think\Loader;

class Order extends Common
{
    public function index() {
        $type = $this->request->param("type");
        $orderNo =  $this->request->param("orderNo");
//        if (isset($orderNo)) {
//            return $this->fetch("order-details");
//        }else{
            return $this->fetch("order-".$type,['orderNo'=>$orderNo]);
//        }
    }

    /**
     * 导出时显示的批次信息
     * @return array
     */
    public function getOrderBatch() {
        $limit = $this->request->get('limit');
        $page = $this->request->get('page');
        $orderModel = Loader::model("OrderBatch");
        $field = "*,@i:=@i+1 as autonum";
        //数据集序号设定
        $i = 0;
        if ($page>1) {
            $i = ($page-1)*$limit;
        }
        $orderModel->query("set @i=".$i);
        $data = $orderModel->field($field)->page($page,$limit)->select();
        $dataCount = $orderModel->field($field)->count();
        $data_format = [
            "code" => 0,
            "msg" => "success",
            "count" => $dataCount,
            "data" => $data,
        ];
        return $data_format;
    }

    /**
     * 订单列表页获取数据
     * @return array
     */
    public function getOrderDatas() {
        $limit = $this->request->get('limit');
        $page = $this->request->get('page');
        $orderModel = Loader::model("OrderBatch");
        $batch = $this->request->param('batch');
        if (!isset($batch)) {
            $batch = $orderModel->field("batch_time")->order("id desc")->find()['batch_time'];
        }
//        $orderField = $this->request->get('field');
//        $orderType = $this->request->get('order');
        $alias = "a";
        $join = [
            ["OrderHead b","a.batch_time = b.batch_time"],
//            ["OrderGoods c","b.order_no = c.order_no"],
        ];
        $where = ['a.batch_time'=>$batch];
        $field = "*,@i:=@i+1 as autonum";
//        $orderBy = [$orderField => $orderType];
        $orderModel = Loader::model("OrderBatch");
        //数据集序号设定
        $i = 0;
        if ($page>1) {
            $i = ($page-1)*$limit;
        }
        $orderModel->query("set @i=".$i);
//        $data = $orderHead->alias($alias)->join($join)->field($field)->page($page,$limit)->order($orderBy)->select();
        $data = $orderModel->alias($alias)->join($join)->where($where)->field($field)->page($page,$limit)->select();
        $dataCount = $orderModel->alias($alias)->where($where)->join($join)->field($field)->count();
        if (!$dataCount) $orderModel::destroy(['batch_time'=>$batch]);
        $data_format = [
            "code" => 0,
            "msg" => "success",
            "count" => $dataCount,
            "data" => $data,
        ];
        return $data_format;
    }

    /**
     * 获取订单详细信息
     * @return array
     */
    public function getOrderDetails() {
        $order_no = $this->request->param("orderNo");
        $limit = $this->request->param("limit");
        $page = $this->request->param("page");
        $join = [["order_goods b","a.order_no = b.order_no"]];
        $where = ['a.order_no'=> $order_no];
        $field = ["*","a.currency"=>"currency","b.currency"=>"item_currency"];
        $orderHead = Loader::model("OrderHead");
        $data = $orderHead->alias('a')->join($join)->field($field)->where($where)->page($page,$limit)->select();
        $dataCount = $orderHead->alias('a')->join($join)->where($where)->count();
        $data_format = [
            "code" => 0,
            "msg" => "success",
            "count" => $dataCount,
            "data" => $data,
        ];
        return $data_format;
    }

    /**
     * 获取预览数据
     * @return array
     */
    public function getPreviewData() {
        $batch_no = $this->request->param("batch_no");
        $limit = $this->request->param("limit");
        $page = $this->request->param("page");
        $where = ['batch_no'=> $batch_no];
        $field = "*,@i:=@i+1 as autonum";
        $orderPreview = Loader::model("OrderPreview");
        //数据集序号设定
        $i = 0;
        if ($page>1) {
            $i = ($page-1)*$limit;
        }
        $orderPreview->query("set @i=".$i);
        $data = $orderPreview->field($field)->where($where)->page($page,$limit)->select();
        $dataCount = $orderPreview->where($where)->count();
        $data_format = [
            "code" => 0,
            "msg" => "success",
            "count" => $dataCount,
            "data" => $data,
        ];
        return $data_format;
    }

    /**
     * 修改预览数据
     * @return array
     */
    public function editPreviewOrder() {
        $batch_no = $this->request->param("batch_no");
        $orderNo = $this->request->param("orderNo");
        $data = $this->request->param("data/a");
        try{
            $res=Loader::model("OrderPreview")->allowField(true)->save($data,['order_no'=>$orderNo,'batch_no'=>$batch_no]);    //"order_no='".$data['order_no']."'"
            if ($res) {
                return ['code'=>"0000",'msg'=>"修改成功！"];
            }else{
                return ['code'=>"0001",'msg'=>"数据没有变更！"];
            }
        }catch (\Exception $e) {
            return ['code'=>"0002",'msg'=>$e];
        }
    }

    /**
     * 删除预览数据
     * @return array
     */
    public function delPreviewOrder() {
        $orderNo = $this->request->param('order_no');
        $order_nos = $this->request->param('order_nos');
        $batch_no = $this->request->param('batch_no');
        $orderPreview = Loader::model('OrderPreview');
        if ($orderNo!=null&&$batch_no!=null) {
            $res = $orderPreview::destroy(['order_no'=>$orderNo,'batch_no'=>$batch_no]);
        }elseif ($order_nos!=null&&$batch_no!=null) {
            foreach (explode('|',$order_nos) as $val) {
                $res = $orderPreview::destroy(['order_no'=>$val,'batch_no'=>$batch_no]);
                if (!$orderPreview) break;
            }
        }
        if ($res) {
            return ['code'=>'0000','msg'=>'success'];
        }else{
            return ['code'=>'0003','msg'=>'删除失败！'];
        }
    }

    /**
     * 修改订单信息
     * @return array
     */
    public function editOrder() {
        $etype = $this->request->param("etype");
        $orderNo = $this->request->param("orderNo");
        $data = $this->request->param("data/a");
        if ($etype == "head") {
            $data = $this->request->param();
            try{
                $res=Loader::model("OrderHead")->allowField(true)->save($data,"order_no='".$data['order_no']."'");
            }catch (\Exception $e) {
                return ['code'=>"0002",'msg'=>$e];
            }
        }elseif ($etype == "goods") {
            $data['currency'] = $data['item_currency'];
            try{
                $res=Loader::model("OrderGoods")->allowField(true)->save($data,"order_no=".$data['order_no']);
            }catch (\Exception $e) {
                return ['code'=>"0002",'msg'=>$e];
            }
        }
        if ($res) {
            return ['code'=>"0000",'msg'=>"修改成功！"];
        }else{
            return ['code'=>"0001",'msg'=>"数据没有变更！"];
        }
    }

    /**
     * 删除订单
     * @return array
     */
    public function delOrder() {
        $orderNo = $this->request->param('order_no');
        $data = $this->request->param('data');
        $og_data_no = $this->request->param('og_data_no');
        $gnum = $this->request->param('gnum');
        $orderHead = Loader::model('OrderHead');
        $orderGoods = Loader::model('OrderGoods');
        if ($data==null&&$gnum==null) {
            $orderGoods::destroy(['order_no'=>$orderNo]);
            $res = $orderHead::destroy(['order_no'=>$orderNo]);
        }elseif($gnum==null&&isset($data)){
            foreach (explode('|',$data) as $val) {
                $orderGoods::destroy(['order_no'=>$val]);
                $res = $orderHead::destroy(['order_no'=>$val]);
                if (!$orderHead) break;
            }
        }elseif ($gnum!=null&&$data==null&&$og_data_no==null) {
            $res = $orderGoods::destroy(['order_no'=>$orderNo,'gnum'=>$gnum]);
        }elseif ($gnum!=null&&$og_data_no!=null) {
            foreach (explode('|',$gnum) as $val) {
                $res = $orderGoods::destroy(['order_no'=>$og_data_no,'gnum'=>$val]);
                if (!$orderGoods) break;
            }
            if (!$orderGoods::get(['order_no'=>$og_data_no])) {
                $orderHead::destroy(['order_no'=>$og_data_no]);
            }
        }
        if ($res) {
            return ['code'=>'0000','msg'=>'success'];
        }else{
            return ['code'=>'0003','msg'=>'删除失败！'];
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
     * 导入excel数据
     * @return \think\response\Json
     */
    public function importData() {
        $file = $this->request->file("excelFile");
        $note = $this->request->post("note");
        $rootpath = 'public' . DS . 'uploads';
        // 移动到框架应用根目录/public/uploads/ 目录下
        $info = $file->validate(['ext'=>'xls,xlsx'])->move(ROOT_PATH.$rootpath);
        if($info){
            $excelObj = new Excel();
            // 成功上传后 获取文件路径
            $filepath =ROOT_PATH.$rootpath.DS.$info->getSaveName();
            $excelObj->setFilePath($filepath);
            //获得excel表中所有记录
            $datas = $excelObj->getSameOrder($excelObj->getSheetsContent(),0, false);
            //去除数据的表头行
            array_shift($datas);
            $this->savePreviewData($datas,true);
            exit;



            $datas = $excelObj->getSameOrder($excelObj->getSheetsContent(),0);
            $result = Loader::model("OrderBatch")->saveBatch($datas, $note);
//            $result = [
//                "code" => "0000",
//                "error" => "",
//                "data" => [
//                    "batch" => date("Y-m-d H:i:s")
//                ]
//            ];
            if ($result["code"] == "0000") {
                return json($result);
            }else{
                return json([
                    "code" => $result["code"],
                    "error" => $result["error"],
                ]);
            }
        }else{
            // 上传失败获取错误信息
            return json(['error'=>$file->getError()]);
        }
    }

    public function savePreviewData($datas,$first=false) {
        if (!$first) {
            $res = Loader::model('OrderPreview')->saveData($datas,true);
        }else{
            $res = Loader::model('OrderPreview')->saveData($datas);
        }
        return $res;
    }
}
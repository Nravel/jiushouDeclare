<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/9/11
 * Time: 11:49
 */

namespace app\admin\controller;


use app\admin\model\OrderHead;
use app\common\controller\Excel;
use think\Exception;
use think\Loader;

class Order extends Common
{
    public function index() {
        $type = $this->request->param("type");
        return $this->fetch("order-".$type);
    }

    public function getDatas() {
        $limit = $this->request->get('limit');
        $page = $this->request->get('page');
        $orderModel = Loader::model("OrderBatch");
        if (isset($batch)) {
            $batch = $this->request->get('batch');
        }else {
            $batch = $orderModel->field("batch_time")->order("id desc")->find();
        }
//        $orderField = $this->request->get('field');
//        $orderType = $this->request->get('order');
        $alias = "a";
        $join = [
            ["OrderHead b","a.batch_time = b.batch_time"],
            ["OrderGoods c","b.order_no = c.order_no"],
        ];
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
        $data = $orderModel->alias($alias)->join($join)->field($field)->page($page,$limit)->select();
        $dataCount = $orderModel->alias($alias)->join($join)->field($field)->count();
        $data_format = [
            "code" => 0,
            "msg" => "success",
            "count" => $dataCount,
            "data" => $data,
        ];
        return $data_format;
    }

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
            $datas = $excelObj->getSameOrder($excelObj->getSheetsContent(),0);
            //去除数据的表头行
            array_shift($datas);
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
}
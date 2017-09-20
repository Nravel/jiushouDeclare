<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/9/15
 * Time: 15:02
 */

namespace app\admin\model;


use app\common\controller\Excel;
use think\Db;
use think\Model;

class OrderHeShan extends Model
{
    protected $table = "heshan_order_batch";

    /**
     * 添加批次和备注
     * @param $datas
     * @param $note
     * @return array
     */
    public function saveBatch($datas, $note) {
        $data = ["batch"=>date("Y-m-d H:i:s"),"note"=>$note];
        OrderHeShan::startTrans();
        try{
            $res = $this->saveOrders($datas,$data['batch']);
            if ($res['code']!="0000") return $res;
            OrderHeShan::isUpdate(false)->save($data);
            OrderHeShan::commit();
            return ["code"=>"0000","msg"=>"success"];
        }catch (\Exception $e) {
            OrderHeShan::rollback();
            return ["code"=>"0001","error"=>$e->getMessage()];
        }
    }

    /**
     * 添加订单数据
     * @param $datas
     * @param $batch
     */
    public function saveOrders($datas, $batch) {
        $orderList = Db::name("order_list");
        //获取表字段
        $fields = $orderList->getTableFields();
        //取出与数据相对应的字段并赋值
        $fields = array_slice($fields,2,count($fields)-2);
        $data_arr = null;
        try{
            foreach ($datas as $k => $record) {
                foreach ($fields as $key => $val) {
                    if (array_key_exists($key,$record))
                    $data_arr[$k][$val] = $record[$key];
                }
                $data_arr[$k]["batch"] = $batch;
            }
            $orderList->startTrans();
            $orderList->insertAll($data_arr);
            $orderList->commit();
            return ["code"=>"0000","msg"=>"success"];
        }catch (\Exception $e) {
            $orderList->rollback();
            return ["code"=>"0002","error"=>$e->getMessage()];
        }
    }

    /**
     * 导出订单数据
     * @param $ex_info  导出单批数据时的信息
     * @param null $data 导出多批数据的批次号数组
     * @param null $datatype    区分批量操作的类型
     */
    public function exportOrders($ex_info, $data=null, $datatype=null) {
        if (!empty($ex_info)&&count($ex_info)==2) {
            $ex_batch = $ex_info[0];
            $ex_type = $ex_info[1];
            $where = ["batch"=>$ex_batch];
        }
        $orderList = Db::name("order_list");
        $fields = [
            [
              "order_no",
              "ebp_bno",
              "ebp_name",
              "ebc_code",
              "ebc_name",
              "ac_price",
              "freight",
              "deduction",
              "tax_deduction",
              "ac_total",
              "wb_currency",
              "sender_reg_no",
              "sender_name",
              "sender_telephone",
              "sender_id_type",
              "sender_id_num",
              "paycom_code",
              "paycom_name",
              "paydeal_no",
              "consignee",
              "consignee_telephone",
              "consignee_address",
              "com_wb_no",
              "trade_way",
              "book_no",
              "licence",
              "start_con",
              "waybill",
              "insure_price",
              "packing_type",
              "item_gweight",
              "item_nweight",
              "item_seria_no",
              "mainitem_name",
              "qty",
              "unit",
              "law_qty",
              "law_unit",
              "origin_con",
              "item_bak_no",
              "item_spec_type",
              "price",
              "total",
              "item_currency"
          ],
            [
              "app_type",
              "app_status",
              "order_no",
              "ebp_bno",
              "ebp_name",
              "ebc_code",
              "ebc_name",
              "com_wb_no",
              "logc_bno",
              "logc_name",
              "logc_inner_no",
              "preset_no",
              "insure_com_no",
              "book_no",
              "wb_list_no",
              "ie_mark",
              "declare_date",
              "custom_clare_code",
              "port_code",
              "import_date",
              "sender_id_type",
              "sender_id_num",
              "sender_name",
              "sender_telephone",
              "consignee_address",
              "declare_com_code",
              "declare_com_name",
              "area_com_code",
              "area_com_name",
              "trade_way",
              "trans_way",
              "trans_tool",
              "trans_code",
              "lading_trans_no",
              "supervise_code",
              "licence",
              "start_con",
              "waybill",
              "insure_price",
              "wb_currency",
              "packing_type",
              "cases_num",
              "wb_gweight",
              "wb_nweight",
              "trans_note",
              "trans_seria_no",
              "book_bak_no",
              "item_no",
              "mainitem_name",
              "item_code",
              "mainitem_name as mainitem_name2",
              "item_spec_type",
              "bar_code",
              "origin_con",
              "item_currency",
              "qty",
              "law_qty",
              "law_qty2",
              "unit",
              "law_unit",
              "law_unit2",
              "price",
              "total",
              "item_note",
              "lading_no"
          ],
            [
                "app_type",
                "app_status",
                "custom_clare_code",
                "logc_inner_no",
                "preset_no",
                "enbase_no",
                "supervise_code",
                "supervise_name",
                "ie_mark",
                "trans_way",
                "trans_tool",
                "trans_code",
                "lading_trans_no",
                "logc_bno",
                "logc_name",
                "unload_base",
                "enbase_note",
                "enbase_seria_no",
                "com_wb_no",
                "enbase_list_note"
            ],
            [
                "app_type",
                "app_status",
                "logc_bno",
                "logc_name",
                "com_wb_no",
                "lading_trans_no",
                "waybill",
                "insure_price",
                "wb_currency",
                "wb_gweight",
                "cases_num",
                "mainitem_name",
                "consignee",
                "consignee_address",
                "consignee_telephone",
                "trans_note",
                "lading_no"
            ]
        ];
        $excelObj = new Excel();
        is_dir("uploads") ? $excelObj->del_dir("uploads",1) : "" ;      //删除导入时生成的目录，节省空间
        if ($data!=null&&$datatype!=null&&count($data)>0) {      //多批次打包导出
            if ($datatype!=4) {         //多批次纵向单表数据导出
                foreach ($data as $batch) {
                    $res = $orderList
                        ->where(["batch"=>$batch])
                        ->field($fields[$datatype])
                        ->select();
                    $excelObj->exportExcel($res,$datatype,$batch,true);
                }
            }else{                      //多批次所有表数据导出
                foreach ($data as $batch) {
                    for ($i=0;$i<4;$i++) {
                        $res = $orderList
                            ->where(["batch"=>$batch])
                            ->field($fields[$i])
                            ->select();
                        $excelObj->exportExcel($res,$i,$batch,true,$batch);
                    }
                }
            }
            $zip=new \ZipArchive();
            if($zip->open('excel.zip', \ZipArchive::CREATE)=== TRUE){
                $excelObj->addFileToZip('downloads', $zip); //调用方法，对要打包的根目录进行操作，并将ZipArchive的对象传递给方法
                $zip->close(); //关闭处理的zip文件
                $excelObj->del_dir("downloads",1);
            }
            //导出的文件名
            $ex_filenames = [
                "批量就手订单",
                "批量清单",
                "批量入库单",
                "批量运单",
                "批量一次性导出",
            ];
            $excelObj->download($ex_filenames[$datatype],'zip');
            @readfile("excel.zip");
            unlink("excel.zip");
        }else{
            if ($ex_type!=5) {  //导出对应的分表
                $res = $orderList
                    ->where($where)
                    ->field($fields[$ex_type-1])
                    ->select();
                $excelObj->exportExcel($res,$ex_type-1,$ex_batch);
            }else{  //单批次导出四个分表的压缩包
                for ($i=0;$i<4;$i++) {
                    $res = $orderList
                        ->where($where)
                        ->field($fields[$i])
                        ->select();
                    $excelObj->exportExcel($res,$i,$ex_batch,true);
                }
                $zip=new \ZipArchive();
                if($zip->open('excel.zip', \ZipArchive::CREATE)=== TRUE){
                    $excelObj->addFileToZip('downloads', $zip); //调用方法，对要打包的根目录进行操作，并将ZipArchive的对象传递给方法
                    $zip->close(); //关闭处理的zip文件
                    $excelObj->del_dir("downloads");
                }
                $ex_batch = str_replace(":",".",$ex_batch);
                $excelObj->download($ex_batch.' 批次','zip');
                @readfile("excel.zip");
                unlink("excel.zip");
            }
        }
    }
}
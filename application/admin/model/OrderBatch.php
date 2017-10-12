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
use think\Loader;

class OrderBatch extends Model
{
    /**
     * 添加批次和备注
     * @param $datas
     * @param $note
     * @return array
     */
    public function saveBatch($datas, $note) {
        $data = ["batch_time"=>date("YmdHis").random_int(1000,9999),"batch_note"=>$note];
        try{
            OrderBatch::startTrans();
            $res = $this->saveOrders($datas,$data['batch_time']);
            if ($res['code']!="0000") {
                return $res;
            }
            OrderBatch::isUpdate(false)->save($data);
            OrderBatch::commit();
            $res['data'] = ["batch" => $data['batch_time']];
            return $res;
        }catch (\Exception $e) {
            OrderBatch::rollback();
            return ["code"=>"0011","error"=>$e->getMessage()];
        }
    }

    /**
     * 添加订单数据
     * @param $datas
     * @param $batch
     */
    public function saveOrders($datas, $batch) {
        //定义订单头的字段
        $head_fields = Loader::model("OrderHead")->getTableFields();
        //移除不需要的字段
        $hfields_no = ["id","pay_code","pay_name","pay_transaction_id","oh_note","batch_time","declare_status","create_time"];
        $head_fields = array_merge(array_diff($head_fields,$hfields_no));
        //定义商品信息的字段
        $goods_fields = Loader::model("OrderGoods")->getTableFields();
        //移除不需要的字段
        $gfields_no = ["id","order_no","item_no","item_describe","bar_code","qty2","unit2"];
        //由于数据位置已在数组中固定，故要保持商品字段与数据位置对应，适当进行偏移
        foreach ($head_fields as $k => $val) {
            $temp[$k] = "";
        }
        $goods_fields = array_merge($temp,array_diff($goods_fields,$gfields_no));
        //交换一些字段顺序，保正与数据对应
//        $field_index1 = array_search('qty1',$goods_fields);
//        $field_index2 = array_search('unit',$goods_fields);
//        $goods_fields[$field_index1] = 'unit';
//        $goods_fields[$field_index2] = 'qty1';
        $result = Loader::model("OrderHead")->saveDatas($datas,$head_fields,$goods_fields,$batch);
        return $result;
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
            $where = ["a.batch_time"=>$ex_batch];
        }
        $join = [["order_goods b","a.order_no = b.order_no"]];
        $orderHead = Db::name("order_head");
        //定义订单头的字段
        $head_fields = $orderHead->getTableFields();
        //移除不需要的字段
        $hfields_no = ["id","pay_code","pay_name","pay_transaction_id","oh_note","batch_time"];
        $head_fields = array_merge(array_diff($head_fields,$hfields_no));
        //定义商品信息的字段
        $goods_fields = Loader::model("OrderGoods")->getTableFields();
        //移除不需要的字段
        $gfields_no = ["id","order_no","item_no","item_describe","bar_code","qty2","unit2","goods_note"];
        //由于数据位置已在数组中固定，故要保持商品字段与数据位置对应，适当进行偏移
//        foreach ($head_fields as $k => $val) {
//            $temp[$k] = "";
//        }
        $jiushou_fields = array_merge($head_fields,array_diff($goods_fields,$gfields_no));
        //交换一些字段顺序，保正与数据对应
        $field_index1 = array_search('qty1',$jiushou_fields);
        $field_index2 = array_search('unit',$jiushou_fields);
        $field_index3 = array_search('order_no',$jiushou_fields);
        $jiushou_fields[count($jiushou_fields)-1] = 'b.currency as item_currency';
        $field_index4 = array_search('currency',$jiushou_fields);
        $jiushou_fields[$field_index1] = 'unit';
        $jiushou_fields[$field_index2] = 'qty1';
        $jiushou_fields[$field_index3] = 'a.order_no as order_no';
        $jiushou_fields[$field_index4] = 'a.currency as currency';
        $fields = [
            $jiushou_fields,
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
                    $res = $orderHead
                        ->alias('a')
                        ->join($join)
                        ->field($fields[$datatype])
                        ->where(["a.batch_time"=>$batch])
                        ->select();
                    $excelObj->exportExcel($res,$datatype,$batch,true);
                }
            }else{                      //多批次所有表数据导出
                foreach ($data as $batch) {
                    for ($i=0;$i<4;$i++) {
                        $res = $orderHead
                            ->alias('a')
                            ->join($join)
                            ->field($fields[$i])
                            ->where(["a.batch_time"=>$batch])
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
                $res = $orderHead
                    ->alias('a')
                    ->join($join)
                    ->field($fields[$ex_type-1])
                    ->where($where)
                    ->select();
                $excelObj->exportExcel($res,$ex_type-1,$ex_batch);
            }else{  //单批次导出四个分表的压缩包
                for ($i=0;$i<4;$i++) {
                    $res = $orderHead
                        ->alias('a')
                        ->join($join)
                        ->field($fields[$i])
                        ->where($where)
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
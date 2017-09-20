<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/8/30
 * Time: 16:38
 */

namespace app\admin\model;


use think\Db;
use think\Loader;
use think\Model;

class OrderHead extends Model
{
    //新增订单头记录
    public function saveDatas($datas,$harr,$larr) {
        $orderHead = new OrderHead();
        $orderList = Loader::model('OrderList');
        //excel表中不存在，数据库中不能为空的字段
        $datas_fill = [
            'app_time' => 'YYYYMMDDhhmmss',
            'order_type' => 'I',
            'guid' => '11111111111111',
            'ebp_code' => '11111111111111',
            'ebp_name' => '11111111111111',
            'ebc_code' => '11111111111111',
            'ebc_name' => '11111111111111',
            'goods_value' => '11111111111111',
            'freight' => '11111111111111',
            'discount' => '11111111111111',
            'tax_total' => '11111111111111',
            'actural_paid' => '11111111111111',
            'currency' => '142',
            'buyer_reg_no' => '142',
            'buyer_id_type' => '1',
            'buyer_name' => '1232323232332',
            'pay_code' => '1232323232332',
            'pay_name' => '1232323232332',
            'batch_numbers' => '1232323232332',
            'pay_transaction_id' => '1232323232332',
            'consignee_ditrict' => '12323'
        ];
//        $tel_index = array_keys($harr,'consignee_telephone')[0];
        foreach ($datas as $records) {
            if (array_key_exists('same',$records)) {
                $datas = null;
                foreach ($harr as $k => $val) {
                    if (array_key_exists($k,$records['same'])&&$val) {
                        $datas[$val] = $records['same'][$k];
                    }
                }
                $datas = array_merge($datas,$datas_fill);
                Db::startTrans();
                try {
                    $orderHead->data($datas);
                    $orderHead->isUpdate(false)->save();
                }catch (\Exception $e) {
//                    dump($e->getMessage());
                    Db::rollback();
                    return [
                        "code" => "0002",
                        "error" => $e->getMessage(),
                    ];
                }
                $orderList->saveMoreDatas($records['same'], $records['diff'], $larr);
            }else{
                $datas = null;
                foreach ($harr as $k => $val) {
                    if ($val) {
                        $datas[$val] = $records[$k];
                    }
                }
                Db::startTrans();
                try {
                    $datas = array_merge($datas, $datas_fill);
                    $orderHead->data($datas);
                    $orderHead->isUpdate(false)->save($datas);
                }catch (\Exception $e) {
//                    dump($e->getMessage());
                    Db::rollback();
                    return [
                        "code" => "0002",
                        "error" => $e->getMessage(),
                    ];
                }
                $orderList->saveSingleData($records, $larr);
            }
        }
        return [
            "code" => "0000",
            "msg" => "success"
        ];
    }

}
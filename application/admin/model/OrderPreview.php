<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/9/28
 * Time: 11:01
 */

namespace app\admin\model;


use think\Db;
use think\Loader;
use think\Model;

class OrderPreview extends Model {
    public function saveData($datas,$modify=false) {
        $oPreview = new OrderPreview();
        $fields = OrderPreview::getTableFields();
        $fields_no = ["id","pay_code","pay_name","pay_transaction_id","oh_note","batch_no","item_no","item_describe","bar_code","qty2","unit2",'goods_note'];
        $fields = array_merge(array_diff($fields,$fields_no));
        $batch_no = date('YmdHis').random_int(1000,9999);
        $duplic_arr = null;
        if (!$modify) {
            $ndatas = null;
            foreach ($datas as $key => $rows) {
                foreach ($rows as $k => $row) {
                    $ndatas[] = $row;
                }
            }
            foreach ($ndatas as $key => $row) {
                foreach ($fields as $k => $val) {
                    $newdatas[$key][$val] = $row[$k];
                }
                $newdatas[$key]['batch_no'] = $batch_no;
            }
            $duplic_key = $this->checkOrderNo($newdatas);
            if (count($duplic_key)>0) {
                $i = 0;
                foreach ($duplic_key as $key) {
                    $duplic_arr[$i] = $newdatas[$key];
                    $duplic_arr[$i]['autonum'] = $i+1;
                    unset($newdatas[$key]);
                    $i++;
                }
            }
        }else{
            if (count($datas)==count($datas,1)) {
                $newdatas[] = $datas;
            }else{
                $newdatas = $datas;
            }
            $duplic_key = $this->checkOrderNo($newdatas);
            if (count($duplic_key)>0) {
                foreach ($duplic_key as $key) {
                    $duplic_arr[] = $newdatas[$key];
                    unset($newdatas[$key]);
                }
            }
        }
        $oPreview->startTrans();
        try{
            $res = $oPreview->allowField(true)->saveAll($newdatas);
            $oPreview->commit();
            return [
                'code' => '0000',
                'msg' => '更改成功！',
                'data' => ['batch_no'=>$batch_no,'duplic_arr'=>$duplic_arr],
            ];
            dump($res);
            exit;
        }catch (\Exception $e) {
            dump($e);
            exit;
            return [
                'code' => '0005',
                'msg' => $e->getMessage()
            ];
        }
    }

    public function checkOrderNo($datas) {
        $res = Loader::model('OrderHead')->field('order_no')->select();
        $check_arr = null;
        $orderNo_arr = null;
        foreach ($res as $val) {
            $orderNo_arr[] = $val['order_no'];
        }
        foreach ($datas as $val) {
            $check_arr[] = $val['order_no'];
        }
        $orderNo_arr == null ? $duplicate_key=[] : $duplicate_key = array_keys(array_intersect($check_arr,$orderNo_arr));
        return $duplicate_key;
    }
}
<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/8/30
 * Time: 16:39
 */

namespace app\admin\model;


use think\Model;

class OrderList extends Model
{
    public $datas_fill = [
        'gnum' => '1111',
        'bar_code' => '11111111111',
        'qty1' => '11111111111',
        'unit' => '111',
        'unit1' => '111',
        'total_price' => '11111111',
        'country' => 'prc',
    ];
    public function saveMoreDatas($rsame,$rdiff,$larr) {
        $alldatas = null;
        $datas = null;
        foreach ($larr as $k => $val) {
            if (array_key_exists($k,$rsame)&&$val) {
                $datas[$val] = $rsame[$k];
            }
        }
        foreach ($rdiff as $row) {
            foreach ($larr as $i => $val) {
                if ($val&&array_key_exists($i,$row)) {
                    $datas[$val] = $row[$i];
                }
            }
            $datas['order_no'] = $row[0];
            $datas = array_merge($datas,$this->datas_fill);
            $alldatas[] = $datas;
        }
        OrderList::saveAll($alldatas);
    }

    public function saveSingleData($record,$larr) {
//        $orderList = new OrderList();
        foreach ($larr as $k => $val) {
            if ($val) {
                $datas[$val] = $record[$k];
            }
        }
        $datas['order_no'] = $record[0];
        $datas = array_merge($datas,$this->datas_fill);
        OrderList::data($datas);
        OrderList::isUpdate(false)->save($datas);
    }
}
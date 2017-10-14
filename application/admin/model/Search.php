<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/10/14
 * Time: 11:10
 */

namespace app\admin\model;


use think\Db;

class Search {
    public $where = [];
    public $join = [];
    public $name = '';
    public $page= '';
    public $limit = '';

    public function searchSingle() {
        $i = 1;
        if ($this->page>1) {
            $i = ($this->page-1)*$this->limit+1;
        }
        $searchObj = Db::name($this->name);
        $result = $searchObj
            ->where($this->where)
            ->join($this->join)
            ->page($this->page,$this->limit)
            ->select();
        foreach ($result as $k => $record) {
            $result[$k]['autonum'] = $i++;
        }
        $count = $searchObj
            ->where($this->where)
            ->join($this->join)
            ->count();
        return $data_format = [
            "code" => 0,
            "msg" => "success",
            "count" => $count,
            "data" => $result,
        ];;
    }
}
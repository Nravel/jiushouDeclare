<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/10/14
 * Time: 11:00
 */

namespace app\admin\controller;


use think\Loader;

class Search extends Common {
    protected $type = [
        'olist_single' => ['name'=>'order_head a','join'=>[['order_batch b','a.batch_time=b.batch_time']],'whereKey'=>'a.order_no']
    ];
    public function searchBySingle() {
        $request = $this->request->get();
        $search = Loader::model('Search');
        $type_index = $request['type'];
        $search->name = $this->type[$type_index]['name'];
        $search->join = $this->type[$type_index]['join'];
        $search->page = $request['page'];
        $search->limit = $request['limit'];
        $search->where = [ $this->type[$type_index]['whereKey'] => $request['condition']];
        $res = $search->searchSingle();
        return $res;
    }
}
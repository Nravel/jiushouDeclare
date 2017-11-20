<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/10/26
 * Time: 11:56
 */

namespace Order\Service;


class Nfexcel {
	private $val = [
		'logistics_code'=>'4407986010',
		'logistics_name'=>'鹤山市南方国际速递有限公司',
		'assure_code'=>'4407986010',
		'customs_code'=>'6861',
		'port_code'=>'6861',
	];

	private function billExcel($batch, $data){

		$col_name = ['报送类型','业务状态','订单编号','电商平台代码','电商平台名称','电商企业代码','电商企业名称','物流运单编号','物流企业代码','物流企业名称','企业内部编号',
		'预录入编号','担保企业编号','账册编号','清单编号','进出口标记','申报日期','申报海关代码','口岸海关代码','进口日期','订购人证件类型','订购人证件号码','订购人姓名',
		'订购人电话','收件地址','申报企业代码','申报企业名称','区内企业代码','区内企业名称','贸易方式','运输方式','运输工具编号','航班航次号','提运单号','监管场所代码',
		'许可证件号','起运国（地区）','运费','保费','币制','包装种类代码','件数','毛重（公斤）','净重（公斤）','备注','序号','账册备案料号','企业商品货号','企业商品品名',
		'商品编码','商品名称','商品规格型号','条码','原产国（地区）','币制','数量','法定数量','第二数量','计量单位','法定计量单位','第二计量单位','单价','总价','备注',
		'提单号'];

		$objPHPExcel = $this->CreatePHPExcel($col_name);
		//行计数器
		$j = 3;
		foreach ($data as $item){
			$objPHPExcel->getActiveSheet()
				->setCellValue("A{$j}", '1')    //报送类型
				->setCellValue("B{$j}", '2')    //业务状态
				->setCellValueExplicit("C{$j}", $item['orderNo'], \PHPExcel_Cell_DataType::TYPE_STRING)    //订单编号

				->setCellValueExplicit("D{$j}", $item['ebpCode'], \PHPExcel_Cell_DataType::TYPE_STRING)    //电商平台代码
				->setCellValue("E{$j}", $item['ebpName'])    //电商平台名称
				->setCellValueExplicit("F{$j}", $item['ebcCode'], \PHPExcel_Cell_DataType::TYPE_STRING)    //电商企业代码
				->setCellValue("G{$j}", $item['ebcName'])    //电商企业名称

				->setCellValueExplicit("H{$j}", $item['logisticsNo'],\PHPExcel_Cell_DataType::TYPE_STRING) //物流运单编号
				->setCellValueExplicit("I{$j}", $this->val['logistics_code'], \PHPExcel_Cell_DataType::TYPE_STRING)    //物流企业代码
				->setCellValue("J{$j}", $this->val['logistics_name']) //物流企业名称
				->setCellValueExplicit("K{$j}", $item['logisticsNo'], \PHPExcel_Cell_DataType::TYPE_STRING)    //企业内部编号
				->setCellValue("L{$j}", '') //预录入编号
				->setCellValueExplicit("M{$j}", $this->val['assure_code'], \PHPExcel_Cell_DataType::TYPE_STRING)    //担保企业编号
				->setCellValue("N{$j}", '') //账册编号
				->setCellValue("O{$j}", '') //清单编号
				->setCellValue("P{$j}", 'I') //进出口标记
				->setCellValue("Q{$j}", date("Ymd")) //申报日期
				->setCellValueExplicit("R{$j}", $this->val['customs_code'], \PHPExcel_Cell_DataType::TYPE_STRING)//申报海关代码
				->setCellValueExplicit("S{$j}", $this->val['port_code'], \PHPExcel_Cell_DataType::TYPE_STRING)//口岸海关代码
				->setCellValue("T{$j}", date("Ymd",strtotime('-3 day'))) //进口日期

				->setCellValue("U{$j}", $item['buyerIdType']) //订购人证件类型
				->setCellValueExplicit("V{$j}", $item['buyerIdNumber'], \PHPExcel_Cell_DataType::TYPE_STRING)//订购人证件号码
				->setCellValue("W{$j}", $item['buyerName']) //订购人姓名
				->setCellValueExplicit("X{$j}", $item['buyerTelephone'], \PHPExcel_Cell_DataType::TYPE_STRING)//订购人电话

				->setCellValue("Y{$j}", $item['consigneeAddress']) //收件地址

				->setCellValueExplicit("Z{$j}", $this->val['logistics_code'], \PHPExcel_Cell_DataType::TYPE_STRING)    //申报企业代码
				->setCellValue("AA{$j}", $this->val['logistics_name']) //申报企业名称

				->setCellValue("AB{$j}", '') //区内企业代码
				->setCellValue("AC{$j}", '') //区内企业名称

				->setCellValueExplicit("AD{$j}", $item['tradeMode'], \PHPExcel_Cell_DataType::TYPE_STRING)    //贸易方式
				->setCellValueExplicit("AE{$j}", '4', \PHPExcel_Cell_DataType::TYPE_STRING)    //运输方式
				->setCellValueExplicit("AF{$j}", '01', \PHPExcel_Cell_DataType::TYPE_STRING)    //运输工具编号

				->setCellValue("AG{$j}", $item['voyage_no']) //航班航次号
				->setCellValueExplicit("AH{$j}", $item['bill_no'], \PHPExcel_Cell_DataType::TYPE_STRING)    //提运单号
				->setCellValueExplicit("AI{$j}", $this->val['assure_code'],\PHPExcel_Cell_DataType::TYPE_STRING) //监管场所代码
				->setCellValue("AJ{$j}", '') //许可证件号
				->setCellValueExplicit("AK{$j}", $item['a_country'], \PHPExcel_Cell_DataType::TYPE_STRING)    //起运国（地区）

				->setCellValue("AL{$j}", $item['freight']) //运费
				->setCellValue("AM{$j}", $item['insuredFee']) //保费
				->setCellValue("AN{$j}", $item['order_currency']) //币制

				->setCellValue("AO{$j}", $item['wrapType']) //包装种类代码
				->setCellValue("AP{$j}", $item['pack_no']) //件数
				->setCellValue("AQ{$j}", $item['grossWeight']) //毛重（公斤）
				->setCellValue("AR{$j}", $item['netWeight']) //净重（公斤）
				->setCellValue("AS{$j}", '') //备注
				->setCellValue("AT{$j}", $item['gnum']) //序号
				->setCellValue("AU{$j}", '') //账册备案料号

				->setCellValue("AV{$j}", rand(1000,9999)) //企业商品货号
				->setCellValue("AW{$j}", $item['itemName']) //企业商品品名
				->setCellValueExplicit("AX{$j}", $item['gcode'],\PHPExcel_Cell_DataType::TYPE_STRING) //商品编码
				->setCellValue("AY{$j}", $item['itemName']) //商品名称
				->setCellValue("AZ{$j}",  $item['gmodel']) //商品规格型号

				->setCellValue("BA{$j}",  '') //条码
				->setCellValue("BB{$j}",  $item['b_country']) //原产国（地区）
				->setCellValue("BC{$j}",  $item['order_currency']) //币制
				->setCellValue("BD{$j}",  $item['qty']) //数量
				->setCellValue("BE{$j}",  $item['qty1']) //法定数量
				->setCellValue("BF{$j}",  '') //第二数量
				->setCellValue("BG{$j}",  $item['unit']) //计量单位
				->setCellValue("BH{$j}",  $item['unit1']) //法定计量单位
				->setCellValue("BI{$j}",  '') //第二计量单位
				->setCellValue("BJ{$j}",  $item['price']) //单价
				->setCellValue("BK{$j}",  $item['totalPrice']) //法定数量
				->setCellValue("BL{$j}",  '') //第二数量
				->setCellValueExplicit("BM{$j}", $item['bill_no'], \PHPExcel_Cell_DataType::TYPE_STRING)    //提运单号
			;
			$j++;
		}
		$this->saveExcel($objPHPExcel, $batch, 'QingDan', '清单');
	}

	private function storageExcel($batch, $data){

		$col_name = ['报送类型','业务状态','申报海关代码','企业内部编号','预录入编号','入库单编号','监管场所经营人代码','监管场所经营人名称','进出口标记','运输方式',
		'运输工具编号','航班航次号','提运单号','物流企业代码','物流企业名称','卸货库位','入库明细备注','序号','物流运单编号','入库明细单表体备注'];

		$objPHPExcel = $this->CreatePHPExcel($col_name);
		//行计数器
		$j = 3;
		foreach ($data as $item){
			$objPHPExcel->getActiveSheet()
				->setCellValue("A{$j}", '1')    //报送类型
				->setCellValue("B{$j}", '2')    //业务状态
				->setCellValue("C{$j}",  $this->val['customs_code']) //申报海关代码
				->setCellValueExplicit("D{$j}", $item['logisticsNo'], \PHPExcel_Cell_DataType::TYPE_STRING)    //企业内部编号
				->setCellValue("E{$j}",  '') //预录入编号
				->setCellValue("F{$j}",  '') //入库单编号
				->setCellValueExplicit("G{$j}", $this->val['logistics_code'], \PHPExcel_Cell_DataType::TYPE_STRING)    //物流企业代码
				->setCellValue("H{$j}", $this->val['logistics_name']) //物流企业名称
				->setCellValue("I{$j}",  'I') //进出口标记
				->setCellValueExplicit("J{$j}", '4', \PHPExcel_Cell_DataType::TYPE_STRING)    //运输方式
				->setCellValueExplicit("K{$j}", '01', \PHPExcel_Cell_DataType::TYPE_STRING)    //运输工具编号
				->setCellValue("L{$j}", $item['voyage_no']) //航班航次号
				->setCellValueExplicit("M{$j}", $item['bill_no'], \PHPExcel_Cell_DataType::TYPE_STRING)    //提运单号
				->setCellValueExplicit("N{$j}", $this->val['logistics_code'], \PHPExcel_Cell_DataType::TYPE_STRING)    //物流企业代码
				->setCellValue("O{$j}", $this->val['logistics_name']) //物流企业名称
				->setCellValue("P{$j}",  '') //卸货库位
				->setCellValue("Q{$j}",  '') //入库明细备注
				->setCellValue("R{$j}",  $item['gnum']) //序号
				->setCellValueExplicit("S{$j}",  $item['logisticsNo'], \PHPExcel_Cell_DataType::TYPE_STRING) //物流运单编号
				->setCellValue("T{$j}",  '') //入库明细单表体备注

			;
			$j++;
		}
		$this->saveExcel($objPHPExcel, $batch, 'RuKuDan', '入库单');
	}

	private function waybillExcel($batch, $data){

		$col_name = ['报送类型','业务状态','物流企业代码','物流企业名称','物流运单编号','提运单号','运费','保价费','币制','毛重','件数','主要货物信息','收货人姓名',
		'收货地址','收货人电话','运单备注','提单号'];

		$objPHPExcel = $this->CreatePHPExcel($col_name);
		//行计数器
		$j = 3;
		foreach ($data as $item){
			$objPHPExcel->getActiveSheet()
				->setCellValue("A{$j}", '1')    //报送类型
				->setCellValue("B{$j}", '2')    //业务状态
				->setCellValueExplicit("C{$j}", $this->val['logistics_code'], \PHPExcel_Cell_DataType::TYPE_STRING)    //物流企业代码
				->setCellValue("D{$j}", $this->val['logistics_name']) //物流企业名称
				->setCellValueExplicit("E{$j}", $item['logisticsNo'], \PHPExcel_Cell_DataType::TYPE_STRING)    //物流运单编号
				->setCellValueExplicit("F{$j}", $item['bill_no'], \PHPExcel_Cell_DataType::TYPE_STRING)    //提运单号
				->setCellValue("G{$j}", $item['freight']) //运费
				->setCellValue("H{$j}", $item['insuredFee']) //保费
				->setCellValue("I{$j}", $item['order_currency']) //币制
				->setCellValue("J{$j}", $item['grossWeight']) //毛重（公斤）
				->setCellValue("K{$j}", $item['pack_no']) //件数
				->setCellValue("L{$j}", $item['itemName']) //商品名称
				->setCellValue("M{$j}", $item['consignee']) //收货人姓名
				->setCellValue("N{$j}", $item['consigneeAddress']) //收货地址
				->setCellValueExplicit("O{$j}", $item['consigneeTelephone'],\PHPExcel_Cell_DataType::TYPE_STRING) //收货人电话
				->setCellValue("P{$j}",  '') //运单备注
				->setCellValueExplicit("Q{$j}", $item['bill_no'], \PHPExcel_Cell_DataType::TYPE_STRING)    //提运单号
			;
			$j++;
		}
		$this->saveExcel($objPHPExcel, $batch, 'YunDan', '运单');
	}

	public function dowloadZip($batch){
		$data = M('order_new')
			->join('a LEFT JOIN ' . C('DB_PREFIX') . 'order_goods b ON a.id = b.pid')
			->field(['a.orderNo', 'ebpCode', 'ebpName', 'ebcCode', 'ebcName', 'logisticsNo', 'tradeMode', 'emsNo', 'buyerIdType', 'buyerIdNumber',
				'buyerName', 'buyerTelephone', 'consignee', 'consigneeTelephone', 'consigneeAddress', 'tradeMode', 'bill_no', 'voyage_no', 'licenseNo',
				'a.country' => 'a_country', 'freight', 'insuredFee', 'order_currency','wrapType', 'grossWeight', 'netWeight', 'gnum', 'gcode', 'itemName', 'gmodel',
				'b.country' => 'b_country', 'qty', 'qty1', 'unit', 'unit1', 'price', 'totalPrice','pack_no'])
			->where(['a.batch' => $batch])
			->select();
		if(!$data) return;

		$this->billExcel($batch, $data);
		$this->storageExcel($batch, $data);
		$this->waybillExcel($batch, $data);

		$zip=new \ZipArchive();
		if($zip->open(Excel.$batch.'.zip', \ZipArchive::OVERWRITE)=== TRUE){
			$this->addFileToZip(Excel.$batch, $zip); //调用方法，对要打包的根目录进行操作，并将ZipArchive的对象传递给方法
			$zip->close(); //关闭处理的zip文件
		}

	}

	/**
	 * @param $col_name
	 *
	 * @return \PHPExcel
	 */
	private function CreatePHPExcel($col_name) {
		import('Vendor.PHPExcel.Classes.PHPExcel', '', '.php');
		$objPHPExcel = new \PHPExcel();
		$objPHPExcel->getProperties()->setCreator("JiuShou")
			->setLastModifiedBy("JiuShou")
			->setTitle("JiuShou")
			->setSubject("JiuShou")
			->setDescription("JiuShou")
			->setKeywords("JiuShou")
			->setCategory("JiuShou");
		$objPHPExcel->setActiveSheetIndex(0)
			->fromArray($col_name, null, 'A2');
		return $objPHPExcel;
}

	/**
	 * @param $objPHPExcel
	 * @param $batch
	 * @param $title
	 * @param $filename
	 */
	private function saveExcel($objPHPExcel, $batch, $title, $filename) {
		// Rename worksheet
		$objPHPExcel->getActiveSheet()->setTitle($title);
		// Set active sheet index to the first sheet, so Excel opens this as the first sheet
		$objPHPExcel->setActiveSheetIndex(0);
		$path = Excel.$batch;
		if(!file_exists($path)){
			mkdir($path);
		}
		$filename  = $path .DIRECTORY_SEPARATOR. $filename.'.xls';
		$objWriter = \PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
		$filename = iconv("utf-8", "gb2312", $filename);
		$objWriter->save($filename);
		unset($objPHPExcel);
	}


	private function addFileToZip($path,$zip){
		$handler=opendir($path); //打开当前文件夹由$path指定。
		while(($filename=readdir($handler))!==false){
			if($filename != "." && $filename != ".."){//文件夹文件名字为'.'和‘..'，不要对他们进行操作
				if(is_dir($path."/".$filename)){// 如果读取的某个对象是文件夹，则递归
					$this->addFileToZip($path."/".$filename, $zip);
				}else{ //将文件加入zip对象
					$zip->addFile($path.DIRECTORY_SEPARATOR.$filename,$filename);
				}
			}
		}
		@closedir($path);
	}
}
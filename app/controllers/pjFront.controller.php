<?php
if (!defined("ROOT_PATH"))
{
	header("HTTP/1.1 403 Forbidden");
	exit;
}
class pjFront extends pjAppController
{	
	public $defaultLocale = 'pjSimpleCMS_LocaleId';
	
	public $changedLocale = 'pjSimpleCMS_Changed';
	
	public function __construct()
	{
		$this->setLayout('pjActionFront');
		self::allowCORS();
	}
	public function isXHR()
	{
		return parent::isXHR() || isset($_SERVER['HTTP_ORIGIN']);
	}
	
	static protected function allowCORS()
	{
		$origin = isset($_SERVER['HTTP_ORIGIN']) ? $_SERVER['HTTP_ORIGIN'] : '*';
		header('P3P: CP="ALL DSP COR CUR ADM TAI OUR IND COM NAV INT"');
		header("Access-Control-Allow-Origin: $origin");
		header("Access-Control-Allow-Credentials: true");
		header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
		header("Access-Control-Allow-Headers: Origin, X-Requested-With");
	}
	public function afterFilter()
	{		
		if (!isset($_GET['hide']) || (isset($_GET['hide']) && (int) $_GET['hide'] !== 1) &&
			in_array($_GET['action'], array('pjActionViewJs', 'pjActionViewPhp')))
		{
			$locale_arr = pjLocaleModel::factory()->select('t1.*, t2.file, t2.title')
				->join('pjLocaleLanguage', 't2.iso=t1.language_iso', 'left')
				->where('t2.file IS NOT NULL')
				->orderBy('t1.sort ASC')->findAll()->getData();
			
			$this->set('locale_arr', $locale_arr);
		}
		if($_GET['action'] == 'pjActionViewPhp')
		{
			$this->appendCss('front.css');
		}
	}
	
	public function beforeFilter()
	{
		$OptionModel = pjOptionModel::factory();
		$this->option_arr = $OptionModel->getPairs($this->getForeignId());
		$this->set('option_arr', $this->option_arr);
		$this->setTime();

		if (!isset($_SESSION[$this->defaultLocale]))
		{
			$locale_arr = pjLocaleModel::factory()->where('is_default', 1)->limit(1)->findAll()->getData();
			if (count($locale_arr) === 1)
			{
				$this->setLocaleId($locale_arr[0]['id']);
			}
		}
		$this->loadSetFields();
	}
	
	public function beforeRender()
	{
		if (isset($_GET['iframe']))
		{
			$this->setLayout('pjActionIframe');
		}
	}
		
	public function pjActionLocale()
	{
		$this->setAjax(true);
	
		if ($this->isXHR())
		{
			if (isset($_GET['locale_id']))
			{
				$this->pjActionSetLocale($_GET['locale_id']);
				
				pjAppController::setFields($this->getLocaleId());
				
				$day_names = __('day_names', true);
				ksort($day_names, SORT_NUMERIC);
				
				$months = __('months', true);
				ksort($months, SORT_NUMERIC);
				
				pjAppController::jsonResponse(array('status' => 'OK', 'code' => 200, 'text' => 'Locale have been changed.', 'opts' => array(
					'day_names' => array_values($day_names),
					'month_names' => array_values($months)
				)));
			}
		}
		exit;
	}
	
	public function pjActionSetLocale($locale)
	{
		if ((int) $locale > 0)
		{
			$_SESSION[$this->defaultLocale] = (int) $locale;
		}
		return $this;
	}
	
	public function pjActionSetLocalePhp()
	{
		if ((int) $_GET['locale_id'] > 0)
		{
			$_SESSION[$this->defaultLocale] = (int) $_GET['locale_id'];
			$_SESSION[$this->changedLocale] = true;
		}
		pjUtil::redirect($_SERVER['HTTP_REFERER']);
	}
	
	public function pjActionGetLocale()
	{
		return isset($_SESSION[$this->defaultLocale]) && (int) $_SESSION[$this->defaultLocale] > 0 ? (int) $_SESSION[$this->defaultLocale] : FALSE;
	}
	
	public function pjActionLoadCss()
	{
		$arr = array(
			array('file' => 'front.css', 'path' => PJ_CSS_PATH)
		);
		header("Content-Type: text/css; charset=utf-8");
		foreach ($arr as $item)
		{
			$string = FALSE;
			if ($stream = fopen($item['path'] . $item['file'], 'rb'))
			{
				$string = stream_get_contents($stream);
				fclose($stream);
			}
			
			if ($string !== FALSE)
			{
				echo str_replace(
					array('[URL]', '../'),
					array(
						PJ_INSTALL_URL,
						PJ_INSTALL_URL . 'app/web/'
						), $string
				) . "\n";
			}
		}
		exit;
	}
	
	public function pjActionLoad()
	{
		ob_start();
		header("Content-Type: text/javascript; charset=utf-8");
	}
	
	public function pjActionViewJs()
	{
		$this->setAjax(true);
		
		if ($this->isXHR() || isset($_GET['_escaped_fragment_']))
		{
			if(isset($_GET['locale']) && $_GET['locale'] > 0)
			{
				$_SESSION[$this->defaultLocale] = (int) $_GET['locale'];
			}
			$arr = pjSectionModel::factory()
				->join('pjMultiLang', "t2.foreign_id = t1.id AND t2.model = 'pjSection' AND t2.locale = '".$this->getLocaleId()."' AND t2.field = 'section_content'", 'left')					
				->select('t1.*, t2.content as section_content')
				->find($_GET['id'])
				->getData();
			
			$this->set('arr', $arr);
		}
	}
	
	public function pjActionViewPhp()
	{
		$this->setLayout('pjActionContent');
		
		if(isset($_GET['locale']) && $_GET['locale'] > 0 && !isset($_SESSION[$this->changedLocale]))
		{
			$_SESSION[$this->defaultLocale] = (int) $_GET['locale'];
		}
		if(isset($_GET['id']))
		{
			$arr = pjSectionModel::factory()
				->join('pjMultiLang', "t2.foreign_id = t1.id AND t2.model = 'pjSection' AND t2.locale = '".$this->getLocaleId()."' AND t2.field = 'section_content'", 'left')					
				->select('t1.*, t2.content as section_content')
				->find($_GET['id'])
				->getData();
			
			$this->set('arr', $arr);
		}
	}

	public function pjActionDownloadFile()
	{
		$id = $_GET['id'];
		$arr = pjFileModel::factory()->find($id)->getData();
		if(!empty($arr))
		{
			if($arr['hash'] == $_GET['hash'])
			{
				pjToolkit::download(@file_get_contents(PJ_INSTALL_PATH . $arr['file_path']), $arr['file_name'], $arr['mime_type']);
			}else{
				__('front_file_not_found');
			}
		}else{
			__('front_file_not_found');
		}
		exit;
	}
}
?>
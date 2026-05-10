<?php
if (!defined("ROOT_PATH"))
{
	header("HTTP/1.1 403 Forbidden");
	exit;
}
class pjAdminFiles extends pjAdmin
{
	public function pjActionCreate()
	{
		$this->checkLogin();
		
		if ($this->isAdmin() || ($this->isEditor() && $this->isFileAllowed()))
		{
			$post_max_size = pjUtil::getPostMaxSize();
			if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_SERVER['CONTENT_LENGTH']) && (int) $_SERVER['CONTENT_LENGTH'] > $post_max_size)
			{
				pjUtil::redirect(PJ_INSTALL_URL . "index.php?controller=pjAdminFiles&action=pjActionIndex&err=AF05");
			}
			
			if (isset($_POST['file_create']))
			{
				$err = NULL;
				$valid = true;
				$data = array();
				$data['user_id'] = $this->getUserId();
				if (isset($_FILES['file']) && $_FILES['file']['error'] == 0)
				{
					$path = $_FILES['file']['name'];
					$extension = strtolower(pathinfo($path, PATHINFO_EXTENSION));
					$allowed_arr = explode("|", $this->option_arr['o_extension_allow']);
					if(in_array($extension, $allowed_arr))
					{
						$handle = new pjUpload();
						if ($handle->load($_FILES['file'])) {
							$hash = md5(uniqid(rand(), true));
							$file_path = PJ_UPLOAD_PATH . 'files/' . $hash . '.' . $handle->getExtension();
							if($handle->save($file_path))
							{
								$data['file_path'] = $file_path;
								$data['file_name'] = $_FILES['file']['name'];
								$data['mime_type'] = $_FILES['file']['type'];
								$data['hash'] = $hash;
								$data['size'] = pjUtil::formatSizeUnits($_FILES['file']['size']);
							}
						}
					}else{
						$err = 'AF09';
						$valid = false;
					}
				}else{
					$err = 'AF09';
					$valid = false;
				}

				if($valid == true)
				{
					$pjFileModel = pjFileModel::factory();
					$id = $pjFileModel->setAttributes($data)->insert()->getInsertId();
					
					if ($id !== false && (int) $id > 0)
					{
						$pjUserFileModel = pjUserFileModel::factory();
						if(isset($_POST['user_id']))
						{
							$pjUserFileModel->begin();
							foreach ($_POST['user_id'] as $user_id)
							{
								$data = array();
								$data['user_id'] = $user_id;
								$data['file_id'] = $id;
								$pjUserFileModel->reset()->setAttributes($data)->insert();
							}
							$pjUserFileModel->commit();
						}else{
							$data = array();
							$data['user_id'] = $this->getUserId();
							$data['file_id'] = $id;
							$pjUserFileModel->reset()->setAttributes($data)->insert();
						}
						
						$err = 'AF03';
					} else {
						if(isset($data['file_path']))
						{
							@unlink(PJ_INSTALL_PATH . $data['file_path']);
						}
						$err = 'AF04';
					}
				}
				pjUtil::redirect($_SERVER['PHP_SELF'] . "?controller=pjAdminFiles&action=pjActionIndex&err=$err");
			} else {
				$user_arr = pjUserModel::factory()
					->where('status', 'T')
					->where('t1.role_id <> 1')
					->orderBy('name ASC')
					->findAll()
					->getData();
				
				$this->set('user_arr', $user_arr);
				
				$this->appendJs('jquery.multiselect.min.js', PJ_THIRD_PARTY_PATH . 'multiselect/');
				$this->appendCss('jquery.multiselect.css', PJ_THIRD_PARTY_PATH . 'multiselect/');
				$this->appendJs('jquery.validate.min.js', PJ_THIRD_PARTY_PATH . 'validate/');
				$this->appendJs('additional-methods.js', PJ_THIRD_PARTY_PATH . 'validate/');
				$this->appendJs('pjAdminFiles.js');
			}
		} else {
			$this->set('status', 2);
		}
	}
	
	public function pjActionDeleteFile()
	{
		$this->setAjax(true);
		
		if ($this->isXHR())
		{
			$response = array();
			if ($this->isAdmin() || $this->isEditor())
			{
				$allowed = true;
				if($this->isEditor() && !in_array($_GET['id'], $this->getAllowedFileIds($this->getUserId())))
				{
					$allowed = false;
				}
				if($allowed == true)
				{
					$pjFileModel = pjFileModel::factory();
					$arr = $pjFileModel->find($_GET['id'])->getData();
					if ($pjFileModel->reset()->setAttributes(array('id' => $_GET['id']))->erase()->getAffectedRows() == 1)
					{
						pjUserFileModel::factory()->where('file_id', $_GET['id'])->eraseAll();
						
						$file_path = $arr['file_path'];
						if (file_exists(PJ_INSTALL_PATH . $file_path)) {
							@unlink(PJ_INSTALL_PATH . $file_path);
						}
						
						$response['code'] = 200;
					} else {
						$response['code'] = 100;
					}
				}else{
					$response['code'] = 100;
				}
			}
			pjAppController::jsonResponse($response);
		}
		exit;
	}
	
	public function pjActionDeleteFileBulk()
	{
		$this->setAjax(true);
	
		if ($this->isXHR())
		{
			if ($this->isAdmin() || $this->isEditor())
			{
				if (isset($_POST['record']) && count($_POST['record']) > 0)
				{
					$pjFileModel = pjFileModel::factory();
					$file_arr = $pjFileModel->whereIn('id', $_POST['record'])->findAll()->getData();
					foreach($file_arr as $f)
					{
						$file_path = $f['file_path'];
						if (file_exists(PJ_INSTALL_PATH . $file_path)) {
							@unlink(PJ_INSTALL_PATH . $file_path);
						}
					}
					$pjFileModel->reset()->whereIn('id', $_POST['record'])->eraseAll();
					pjUserFileModel::factory()->whereIn('file_id', $_POST['record'])->eraseAll();
				}
			}
		}
		exit;
	}
	
	public function pjActionExportFile()
	{
		$this->checkLogin();
		
		if (isset($_POST['record']) && is_array($_POST['record']))
		{
			$arr = pjFileModel::factory()->whereIn('id', $_POST['record'])->findAll()->getData();
			$csv = new pjCSV();
			$csv
				->setHeader(true)
				->setName("Files-".time().".csv")
				->process($arr)
				->download();
		}
		exit;
	}
	
	public function pjActionGetFile()
	{
		$this->setAjax(true);
	
		if ($this->isXHR())
		{
			$pjFileModel = pjFileModel::factory()
				->join('pjUser', "t2.id = t1.user_id", 'left');
			
			if (isset($_GET['q']) && !empty($_GET['q']))
			{
				$q = $pjFileModel->escapeStr($_GET['q']);
				$q = str_replace(array('%', '_'), array('\%', '\_'), trim($q));
				$pjFileModel->where("(t1.file_name LIKE '%$q%')");
			}

			if (isset($_GET['status']) && !empty($_GET['status']) && in_array($_GET['status'], array('T', 'F')))
			{
				$pjFileModel->where('t1.status', $_GET['status']);
			}
			if($this->isEditor())
			{
				$file_ids_arr = $this->getAllowedFileIds($this->getUserId()); 
				if(!empty($file_ids_arr))
				{
					$pjFileModel->whereIn('t1.id', $file_ids_arr);
				}else{
					$pjFileModel->where("t1.id IN(SELECT t3.file_id FROM `".pjUserFileModel::factory()->getTable()."` AS t3 WHERE t3.user_id = '".$this->getUserId()."')");
				}
			}
				
			$column = 'created';
			$direction = 'DESC';
			if (isset($_GET['direction']) && isset($_GET['column']) && in_array(strtoupper($_GET['direction']), array('ASC', 'DESC')))
			{
				$column = $_GET['column'];
				$direction = strtoupper($_GET['direction']);
			}

			$total = $pjFileModel->findCount()->getData();
			$rowCount = isset($_GET['rowCount']) && (int) $_GET['rowCount'] > 0 ? (int) $_GET['rowCount'] : 10;
			$pages = ceil($total / $rowCount);
			$page = isset($_GET['page']) && (int) $_GET['page'] > 0 ? intval($_GET['page']) : 1;
			$offset = ((int) $page - 1) * $rowCount;
			if ($page > $pages)
			{
				$page = $pages;
			}
			
			$data = $pjFileModel
				->select('t1.*, t2.name')
				->orderBy("$column $direction")
				->limit($rowCount, $offset)
				->findAll()
				->getData();
			foreach($data as $k => $v)
			{
				$v['created'] = pjUtil::formatDate(date('Y-m-d', strtotime($v['created'])), 'Y-m-d', $this->option_arr['o_date_format']) . ', ' . pjUtil::formatTime(date('H:i:s', strtotime($v['created'])), 'H:i:s', $this->option_arr['o_time_format']);
				$data[$k] = $v;
			}
			pjAppController::jsonResponse(compact('data', 'total', 'pages', 'page', 'rowCount', 'column', 'direction'));
		}
		exit;
	}
	
	public function pjActionIndex()
	{
		$this->checkLogin();
		
		if ($this->isAdmin() || $this->isEditor())
		{
			$this->appendJs('jquery.datagrid.js', PJ_FRAMEWORK_LIBS_PATH . 'pj/js/');
			$this->appendJs('pjAdminFiles.js');
		} else {
			$this->set('status', 2);
		}
	}
	
	public function pjActionStatusFile()
	{
		$this->setAjax(true);
	
		if ($this->isXHR())
		{
			if (isset($_POST['record']) && count($_POST['record']) > 0)
			{
				pjFileModel::factory()->whereIn('id', $_POST['record'])->modifyAll(array(
					'status' => ":IF(`status`='F','T','F')"
				));
			}
		}
		exit;
	}
	
	public function pjActionUpdate()
	{
		$this->checkLogin();
		
		if ($this->isAdmin() || $this->isEditor())
		{
			$post_max_size = pjUtil::getPostMaxSize();
			if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_SERVER['CONTENT_LENGTH']) && (int) $_SERVER['CONTENT_LENGTH'] > $post_max_size)
			{
				pjUtil::redirect(PJ_INSTALL_URL . "index.php?controller=pjAdminFiles&action=pjActionIndex&err=AF05");
			}
			
			if (isset($_POST['file_update']))
			{
				$pjFileModel = pjFileModel::factory();
				$arr = $pjFileModel->find($_POST['id'])->getData();
				
				$err = 'AF01';
				$valid = true;
				$data = array();
				$data['user_id'] = $this->getUserId();
				if (isset($_FILES['file']) && $_FILES['file']['error'] == 0)
				{
					$path = $_FILES['file']['name'];
					$extension = strtolower(pathinfo($path, PATHINFO_EXTENSION));
					$allowed_arr = explode("|", $this->option_arr['o_extension_allow']);
					if(in_array($extension, $allowed_arr))
					{
						$handle = new pjUpload();
						if ($handle->load($_FILES['file'])) 
						{
							$hash = md5(uniqid(rand(), true));
							$file_path = PJ_UPLOAD_PATH . 'files/' . $hash . '.' . $handle->getExtension();
							if($handle->save($file_path))
							{
								$data['file_path'] = $file_path;
								$data['file_name'] = $_FILES['file']['name'];
								$data['mime_type'] = $_FILES['file']['type'];
								$data['hash'] = $hash;
								$data['size'] = pjUtil::formatSizeUnits($_FILES['file']['size']);
								$pjFileModel->reset()->set('id', $_POST['id'])->modify($data);
							}
							$file_path = $arr['file_path'];
							if (file_exists(PJ_INSTALL_PATH . $file_path)) {
								@unlink(PJ_INSTALL_PATH . $file_path);
							}
						}
					}else{
						$err = 'AF10';
						$valid = false;
					}
				}else if($_FILES['file']['error'] != 4){
					$err = 'AF10';
					$valid = false;
				}
				
				if($valid == true)
				{
					$pjUserFileModel = pjUserFileModel::factory();
					$pjUserFileModel->where('file_id', $_POST['id'])->eraseAll();
					if(isset($_POST['user_id']))
					{
						$pjUserFileModel->reset()->begin();
						foreach ($_POST['user_id'] as $user_id){
							$data = array();
							$data['user_id'] = $user_id;
							$data['file_id'] = $_POST['id'];
							$pjUserFileModel->reset()->setAttributes($data)->insert();
						}
						$pjUserFileModel->commit();
					}else{
						$data = array();
						$data['user_id'] = $this->getUserId();
						$data['file_id'] = $_POST['id'];
						$pjUserFileModel->reset()->setAttributes($data)->insert();
					}
				}
				
				if($err == 'AF01')
				{
					pjUtil::redirect(PJ_INSTALL_URL . "index.php?controller=pjAdminFiles&action=pjActionIndex&err=$err");
				}else{
					pjUtil::redirect(PJ_INSTALL_URL . "index.php?controller=pjAdminFiles&action=pjActionUpdate&id=".$_POST['id']."&err=$err");
				}
			} else {
				$allowed = true;
				if($this->isEditor() && !in_array($_GET['id'], $this->getAllowedFileIds($this->getUserId())))
				{
					$allowed = false;
				}
				if($allowed == true)
				{
					$arr = pjFileModel::factory()					
						->select("t1.*, (SELECT GROUP_CONCAT(t2.user_id SEPARATOR '~:~') FROM `".pjUserFileModel::factory()->getTable()."` AS t2 WHERE t2.file_id=t1.id ) AS user_ids")
						->find($_GET['id'])
						->toArray('user_ids', '~:~')
						->getData();
						
					if (count($arr) === 0)
					{
						pjUtil::redirect(PJ_INSTALL_URL. "index.php?controller=pjAdminFiles&action=pjActionIndex&err=AF08");
					}
					$user_arr = pjUserModel::factory()
						->where('status', 'T')
						->where('t1.role_id <> 1')
						->orderBy('name ASC')
						->findAll()
						->getData();
					
					$this->set('arr', $arr);
					$this->set('user_arr', $user_arr);
					
					$this->appendJs('jquery.multiselect.min.js', PJ_THIRD_PARTY_PATH . 'multiselect/');
					$this->appendCss('jquery.multiselect.css', PJ_THIRD_PARTY_PATH . 'multiselect/');
					$this->appendJs('jquery.validate.min.js', PJ_THIRD_PARTY_PATH . 'validate/');
					$this->appendJs('additional-methods.js', PJ_THIRD_PARTY_PATH . 'validate/');
					$this->appendJs('pjAdminFiles.js');
				}else{
					$this->set('status', 2);
				}
			}
		} else {
			$this->set('status', 2);
		}
	}
}
?>
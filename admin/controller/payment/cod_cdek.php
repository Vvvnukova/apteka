<?php 
class ControllerPaymentCodCdek extends Controller {
	
	private $error = array(); 
	 
	public function index() { 
		
		$this->load->language('payment/cod_cdek');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('cod_cdek', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');
			
			$this->response->redirect($this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		$this->load->model('setting/store');
		
		if (version_compare(VERSION, '2.1', '>=')) {
			$this->load->model('customer/customer_group');
		} else {
			$this->load->model('sale/customer_group');
		}
		
		$this->load->model('localisation/language');
		
		$this->document->addStyle('view/stylesheet/cdek.css');
		
		$data['heading_title'] = $this->language->get('heading_title');
		
		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_all_zones'] = $this->language->get('text_all_zones');
		$data['text_select_all'] = $this->language->get('text_select_all');
		$data['text_unselect_all'] = $this->language->get('text_unselect_all');
				
		$data['entry_title'] = $this->language->get('entry_title');
		$data['entry_order_status'] = $this->language->get('entry_order_status');
		$data['entry_city_ignore'] = $this->language->get('entry_city_ignore');
		$data['entry_view_mode'] = $this->language->get('entry_view_mode');
		$data['entry_view_mode_cdek'] = $this->language->get('entry_view_mode_cdek');
		$data['entry_active'] = $this->language->get('entry_active');
		$data['entry_min_total'] = $this->language->get('entry_min_total');
		$data['entry_max_total'] = $this->language->get('entry_max_total');
		$data['entry_store'] = $this->language->get('entry_store');
		$data['entry_customer_group'] = $this->language->get('entry_customer_group');
		$data['entry_geo_zone'] = $this->language->get('entry_geo_zone');
		$data['entry_cache_on_delivery'] = $this->language->get('entry_cache_on_delivery');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_price'] = $this->language->get('entry_price');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');
		
		$data['help_cache_on_delivery'] = $this->language->get('help_cache_on_delivery');
		$data['help_min_total'] = $this->language->get('help_min_total');
		$data['help_max_total'] = $this->language->get('help_max_total');
		$data['help_city_ignore'] = $this->language->get('help_city_ignore');
		
		$data['tab_general'] = $this->language->get('tab_general');
		$data['tab_additional'] = $this->language->get('tab_additional');
		
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		
		$data['boolean_variables'] = array($this->language->get('text_no'), $this->language->get('text_yes'));
		$data['status_variables'] = array($this->language->get('text_disabled'), $this->language->get('text_enabled'));

 		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
		
		$data['error'] = $this->error;

  		$data['breadcrumbs'] = array();

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL')
   		);

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_payment'),
			'href'      => $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL')
   		);
		
   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('payment/cod_cdek', 'token=' . $this->session->data['token'], 'SSL')
   		);
		
		$data['action'] = $this->url->link('payment/cod_cdek', 'token=' . $this->session->data['token'], 'SSL');

		$data['cancel'] = $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL');	
		
		$data['view_mode'] = array(
			'all'	=> $this->language->get('text_all'),
			'cdek'	=> $this->language->get('text_cdek')
		);
		
		$data['view_mode_cdek'] = array(
			'all'		=> $this->language->get('text_all_tariff'),
			'courier'	=> $this->language->get('text_tariff_courier'),
			'pvz'		=> $this->language->get('text_tariff_pvz'),
		);
		
		$data['discount_type'] = array(
			'fixed'				=> $this->language->get('text_fixed'),
			'percent'			=> $this->language->get('text_percent_product'),
			'percent_total'		=> $this->language->get('text_percent_total')
		);
		
		if (isset($this->request->post['cod_cdek_title'])) {
			$data['cod_cdek_title'] = $this->request->post['cod_cdek_title'];
		} else {
			$data['cod_cdek_title'] = $this->config->get('cod_cdek_title');
		}
		
		if (isset($this->request->post['cod_cdek_price'])) {
			$data['cod_cdek_price'] = $this->request->post['cod_cdek_price'];
		} else {
			$data['cod_cdek_price'] = $this->config->get('cod_cdek_price');
		}
		
		if (isset($this->request->post['cod_cdek_mode'])) {
			$data['cod_cdek_mode'] = $this->request->post['cod_cdek_mode'];
		} elseif ($this->config->get('cod_cdek_mode')) {
			$data['cod_cdek_mode'] = $this->config->get('cod_cdek_mode'); 
		} else {
			$data['cod_cdek_mode'] = 'cdek';
		}
		
		if (isset($this->request->post['cod_cdek_mode_cdek'])) {
			$data['cod_cdek_mode_cdek'] = $this->request->post['cod_cdek_mode_cdek'];
		} elseif ($this->config->get('cod_cdek_mode_cdek')) {
			$data['cod_cdek_mode_cdek'] = $this->config->get('cod_cdek_mode_cdek'); 
		} else {
			$data['cod_cdek_mode_cdek'] = 'all';
		}
		
		if (isset($this->request->post['cod_cdek_active'])) {
			$data['cod_cdek_active'] = $this->request->post['cod_cdek_active'];
		} else {
			$data['cod_cdek_active'] = $this->config->get('cod_cdek_active'); 
		}
		
		if (isset($this->request->post['cod_cdek_cache_on_delivery'])) {
			$data['cod_cdek_cache_on_delivery'] = $this->request->post['cod_cdek_cache_on_delivery'];
		} elseif ($this->config->get('cod_cdek_cache_on_delivery')) {
			$data['cod_cdek_cache_on_delivery'] = $this->config->get('cod_cdek_cache_on_delivery');
		} else {
			$data['cod_cdek_cache_on_delivery'] = 0;
		}
		
		if (isset($this->request->post['cod_cdek_min_total'])) {
			$data['cod_cdek_min_total'] = $this->request->post['cod_cdek_min_total'];
		} else {
			$data['cod_cdek_min_total'] = $this->config->get('cod_cdek_min_total'); 
		}
		
		if (isset($this->request->post['cod_cdek_max_total'])) {
			$data['cod_cdek_max_total'] = $this->request->post['cod_cdek_max_total'];
		} else {
			$data['cod_cdek_max_total'] = $this->config->get('cod_cdek_max_total'); 
		}
		
		if (isset($this->request->post['cod_cdek_store'])) {
			$data['cod_cdek_store'] = $this->request->post['cod_cdek_store'];
		} elseif ($this->config->get('cod_cdek_store')) {
			$data['cod_cdek_store'] = $this->config->get('cod_cdek_store'); 
		} else {
			$data['cod_cdek_store'] = array();
		}
		
		if (isset($this->request->post['cod_cdek_customer_group_id'])) {
			$data['cod_cdek_customer_group_id'] = $this->request->post['cod_cdek_customer_group_id'];
		} else {
			$data['cod_cdek_customer_group_id'] = $this->config->get('cod_cdek_customer_group_id');
		}
				
		if (isset($this->request->post['cod_cdek_order_status_id'])) {
			$data['cod_cdek_order_status_id'] = $this->request->post['cod_cdek_order_status_id'];
		} else {
			$data['cod_cdek_order_status_id'] = $this->config->get('cod_cdek_order_status_id'); 
		}
		
		$this->load->model('localisation/order_status');
		
		$data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();
		
		if (isset($this->request->post['cod_cdek_geo_zone_id'])) {
			$data['cod_cdek_geo_zone_id'] = $this->request->post['cod_cdek_geo_zone_id'];
		} else {
			$data['cod_cdek_geo_zone_id'] = $this->config->get('cod_cdek_geo_zone_id'); 
		}
		
		$this->load->model('localisation/geo_zone');						
		
		$data['geo_zones'] = $this->model_localisation_geo_zone->getGeoZones();
		
		if (isset($this->request->post['cod_cdek_city_ignore'])) {
			$data['cod_cdek_city_ignore'] = $this->request->post['cod_cdek_city_ignore'];
		} else {
			$data['cod_cdek_city_ignore'] = $this->config->get('cod_cdek_city_ignore');
		}
		
		if (isset($this->request->post['cod_cdek_status'])) {
			$data['cod_cdek_status'] = $this->request->post['cod_cdek_status'];
		} else {
			$data['cod_cdek_status'] = $this->config->get('cod_cdek_status');
		}
		
		if (isset($this->request->post['cod_cdek_sort_order'])) {
			$data['cod_cdek_sort_order'] = $this->request->post['cod_cdek_sort_order'];
		} else {
			$data['cod_cdek_sort_order'] = $this->config->get('cod_cdek_sort_order');
		}
		
		$data['languages'] = $this->model_localisation_language->getLanguages();
		
		if (version_compare(VERSION, '2.1', '>=')) {
			$customer_groups = $this->model_customer_customer_group->getCustomerGroups();
		} else {
			$customer_groups = $this->model_sale_customer_group->getCustomerGroups();
		}
		
		$data['customer_groups'] = $customer_groups;
		
		$data['stores'] = array();
		$data['stores'][] = array(
			'store_id' => 0,
			'name'	   => $this->config->get('config_name')
		);
		
		$data['stores'] = array_merge($data['stores'], $this->model_setting_store->getStores());

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('payment/cod_cdek.tpl', $data));
	}
	
	private function validate() {
		
		if (!$this->user->hasPermission('modify', 'payment/cod_cdek')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		foreach (array('cod_cdek_min_total', 'cod_cdek_max_total', 'cod_cdek_sort_order') as $item) {
			
			if ($this->request->post[$item] != "" && !is_numeric($this->request->post[$item])) {
				$this->error[$item] = $this->language->get('error_numeric');
			}
			
		}
		
		if ($this->request->post['cod_cdek_price']['value'] != '' && !is_numeric($this->request->post['cod_cdek_price']['value'])) {
			$this->error['cod_cdek_price']['value'] = $this->language->get('error_numeric');
		}
		
		if ($this->error && !isset($this->error['warning'])) {
			$this->error['warning'] = $this->language->get('error_warning');
		}
		
		return !$this->error;
	}
	
	public function install() {
		
		$this->load->model('setting/setting');
		$this->load->model('extension/extension');
		
		$totals = $this->model_extension_extension->getInstalled('total');
		
		if (!in_array('cod_cdek_total', $totals)) {
		
			$this->model_extension_extension->install('total', 'cod_cdek_total');
			$this->model_setting_setting->editSetting('cod_cdek_total', array('cod_cdek_total_status' => 1, 'cod_cdek_total_sort_order' => 2));
		
		}
	}
	
	public function uninstall() {
		
		$this->load->model('setting/setting');
		$this->load->model('extension/extension');
			
		$this->model_extension_extension->uninstall('payment', 'cod_cdek_total');
		$this->model_setting_setting->deleteSetting('cod_cdek_total');
	}
}
?>
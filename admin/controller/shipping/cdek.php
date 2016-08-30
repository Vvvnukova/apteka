<?php

class ControllerShippingCdek extends Controller
{
	private $error = array();
	
	const VERSION = '1.8.1';
	
	public function index()
	{
		$this->load->language('shipping/cdek');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		if (!extension_loaded('curl')) {
			$this->error['warning'] = $this->language->get('error_curl');
		} elseif (!extension_loaded('SimpleXML')) {
			$this->error['warning'] = $this->language->get('error_simple_xml');
		} elseif (!extension_loaded('mbstring')) {
			$this->error['warning'] = $this->language->get('error_mbstring');
		}
		
		$this->load->model('setting/setting');
				
		if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->validate()) {
			
			if (isset($this->request->get['redirect'])) {
				$url = $this->url->link('shipping/cdek', 'token=' . $this->session->data['token'], 'SSL');
			} else {
				$url = $this->url->link('extension/shipping', 'token=' . $this->session->data['token'], 'SSL');
			}

			if (in_array($this->request->post['cdek_view_type'], array('group', 'map'))) {
				$this->request->post['cdek_pvz_more_one'] = 'split';
			}

			$this->model_setting_setting->editSetting('cdek', $this->request->post);
			
			$this->saveTariffList();

			// Clear cache PVZ
			$this->cache->delete('cdek.shipping.pvz');
			
			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($url);
		}
		
		if (version_compare(VERSION, '2.1', '>=')) {
			$this->load->model('customer/customer_group');
		} else {
			$this->load->model('sale/customer_group');
		}
		
		$this->load->model('localisation/geo_zone');
		$this->load->model('localisation/country');
		$this->load->model('localisation/tax_class');
		$this->load->model('localisation/language');
		$this->load->model('localisation/length_class');
		$this->load->model('localisation/weight_class');
		
		$this->document->addStyle('view/stylesheet/cdek.css');
		$this->document->addScript('view/javascript/jquery/jquery.tablednd.0.7.min.js');
				
		$data['heading_title'] = $this->language->get('heading_title') . ' <span class="version">v' . self::VERSION . '</span>';

		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_all_zones'] = $this->language->get('text_all_zones');
		$data['text_none'] = $this->language->get('text_none');
		$data['text_select'] = $this->language->get('text_select');
		$data['text_date_current'] = $this->language->get('text_date_current');
		$data['text_date_append'] = $this->language->get('text_date_append');
		$data['entry_more_days'] = $this->language->get('entry_more_days');
		$data['text_day'] = $this->language->get('text_day');
		$data['text_insurance_cost'] = $this->language->get('text_insurance_cost');
		$data['text_loading'] = $this->language->get('text_loading');
		$data['text_help_auth'] = $this->language->get('text_help_auth');
		$data['text_drag'] = $this->language->get('text_drag');
		$data['text_geo_zone'] = $this->language->get('text_geo_zone');
		$data['text_tariff'] = $this->language->get('text_tariff');
		$data['text_help_im'] = $this->language->get('text_help_im');
		$data['text_show_password'] = $this->language->get('text_show_password');
		$data['text_hide_password'] = $this->language->get('text_hide_password');
		$data['text_more_attention'] = $this->language->get('text_more_attention');
		$data['text_from'] = $this->language->get('text_from');
		$data['text_discount_help'] = $this->language->get('text_discount_help');
		$data['text_short_length'] = $this->language->get('text_short_length');
		$data['text_short_width'] = $this->language->get('text_short_width');
		$data['text_short_height'] = $this->language->get('text_short_height');
		$data['text_all_tariff'] = $this->language->get('text_all_tariff');
		$data['text_select_all'] = $this->language->get('text_select_all');
		$data['text_unselect_all'] = $this->language->get('text_unselect_all');
		$data['text_weight'] = $this->language->get('text_weight');
		$data['text_tariff_auth'] = $this->language->get('text_tariff_auth');
		$data['text_view_type_attention'] = $this->language->get('text_view_type_attention');
		
		$data['entry_log'] = $this->language->get('entry_log');
		$data['entry_title'] = $this->language->get('entry_title');
		$data['entry_description'] = $this->language->get('entry_description');
		$data['entry_period'] = $this->language->get('entry_period');
		$data['entry_delivery_data'] = $this->language->get('entry_delivery_data');
		$data['entry_empty_address'] = $this->language->get('entry_empty_address');
		$data['entry_show_pvz'] = $this->language->get('entry_show_pvz');
		$data['entry_work_mode'] = $this->language->get('entry_work_mode');
		$data['entry_max_weight'] = $this->language->get('entry_max_weight');
		$data['entry_cache_on_delivery'] = $this->language->get('entry_cache_on_delivery');
		$data['entry_city_from'] = $this->language->get('entry_city_from');
		$data['entry_length_class'] = $this->language->get('entry_length_class');
		$data['entry_weight_class'] = $this->language->get('entry_weight_class');
		$data['entry_default_size'] = $this->language->get('entry_default_size');
		$data['entry_volume'] = $this->language->get('entry_volume');
		$data['entry_default_weight_use'] = $this->language->get('entry_default_weight_use');
		$data['entry_default_weight'] = $this->language->get('entry_default_weight');
		$data['entry_default_weight_work_mode'] = $this->language->get('entry_default_weight_work_mode');
		$data['entry_size'] = $this->language->get('entry_size');
		$data['entry_login'] = $this->language->get('entry_login');
		$data['entry_password'] = $this->language->get('entry_password');
		$data['entry_cost'] = $this->language->get('entry_cost');
		$data['entry_tax_class'] = $this->language->get('entry_tax_class');
		$data['entry_geo_zone'] = $this->language->get('entry_geo_zone');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$data['entry_min_weight'] = $this->language->get('entry_min_weight');
		$data['entry_max_weight'] = $this->language->get('entry_max_weight');
		$data['entry_min_total'] = $this->language->get('entry_min_total');
		$data['entry_max_total'] = $this->language->get('entry_max_total');
		$data['entry_customer_group'] = $this->language->get('entry_customer_group');
		$data['entry_store'] = $this->language->get('entry_store');
		$data['entry_date_execute'] = $this->language->get('entry_date_execute');
		$data['entry_pvz_more_one'] = $this->language->get('entry_pvz_more_one');
		$data['entry_weight_limit'] = $this->language->get('entry_weight_limit');
		$data['entry_use_region'] = $this->language->get('entry_use_region');
		$data['entry_default_size_type'] = $this->language->get('entry_default_size_type');
		$data['entry_default_size_work_mode'] = $this->language->get('entry_default_size_work_mode');
		$data['entry_packing_min_weight'] = $this->language->get('entry_packing_min_weight');
		$data['entry_packing_additional_weight'] = $this->language->get('entry_packing_additional_weight');
		$data['entry_city_ignore'] = $this->language->get('entry_city_ignore');
		$data['entry_pvz_ignore'] = $this->language->get('entry_pvz_ignore');
		$data['entry_empty'] = $this->language->get('entry_empty');
		$data['entry_empty_cost'] = $this->language->get('entry_empty_cost');
		$data['entry_check_ip'] = $this->language->get('entry_check_ip');
		$data['entry_view_type'] = $this->language->get('entry_view_type');
		$data['entry_rounding'] = $this->language->get('entry_rounding');
		$data['entry_rounding_type'] = $this->language->get('entry_rounding_type');
		$data['entry_insurance'] = $this->language->get('entry_insurance');
		
		$data['help_log'] = $this->language->get('help_log');
		$data['help_packing_additional_weight'] = $this->language->get('help_packing_additional_weight');
		$data['help_column_total'] = $this->language->get('help_column_total');
		$data['help_empty_address'] = $this->language->get('help_empty_address');
		$data['help_min_weight'] = $this->language->get('help_min_weight');
		$data['help_max_weight'] = $this->language->get('help_max_weight');
		$data['help_min_total'] = $this->language->get('help_min_total');
		$data['help_max_total'] = $this->language->get('help_max_total');
		$data['help_length_class'] = $this->language->get('help_length_class');
		$data['help_weight_class'] = $this->language->get('help_weight_class');
		$data['help_city_from'] = $this->language->get('help_city_from');
		$data['help_use_region'] = $this->language->get('help_use_region');
		$data['help_size'] = $this->language->get('help_size');
		$data['help_work_mode'] = $this->language->get('help_work_mode');
		$data['help_show_pvz'] = $this->language->get('help_show_pvz');
		$data['help_pvz_more_one'] = $this->language->get('help_pvz_more_one');
		$data['help_column_title'] = $this->language->get('help_column_title');
		$data['help_column_geo_zone'] = $this->language->get('help_column_geo_zone');
		$data['help_discount_column_geo_zone'] = $this->language->get('help_discount_column_geo_zone');
		$data['help_city_ignore'] = $this->language->get('help_city_ignore');
		$data['help_pvz_ignore'] = $this->language->get('help_pvz_ignore');
		$data['help_empty_cost'] = $this->language->get('help_empty_cost');
		$data['help_check_ip'] = $this->language->get('help_check_ip');
		$data['help_insurance'] = $this->language->get('help_insurance');
		
		$data['column_tariff'] = $this->language->get('column_tariff');
		$data['column_title'] = $this->language->get('column_title');
		$data['column_mode'] = $this->language->get('column_mode');
		$data['column_markup'] = $this->language->get('column_markup');
		$data['column_limit'] = $this->language->get('column_limit');
		$data['column_customer_group'] = $this->language->get('column_customer_group');
		$data['column_geo_zone'] = $this->language->get('column_geo_zone');
		$data['column_total'] = $this->language->get('column_total');
		$data['column_tax_class'] = $this->language->get('column_tax_class');
		$data['column_discount_type'] = $this->language->get('column_discount_type');
		$data['column_discount_value'] = $this->language->get('column_discount_value');
		
		$data['button_save'] = $this->language->get('button_save');
		$data['button_apply'] = $this->language->get('button_apply');
		$data['button_remove'] = $this->language->get('button_remove');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['button_add_discount'] = $this->language->get('button_add_discount');
		
		$data['tab_general'] = $this->language->get('tab_general');
		$data['tab_data'] = $this->language->get('tab_data');
		$data['tab_auth'] = $this->language->get('tab_auth');
		$data['tab_tariff'] = $this->language->get('tab_tariff');
		$data['tab_additional'] = $this->language->get('tab_additional');
		$data['tab_package'] = $this->language->get('tab_package');
		$data['tab_discount'] = $this->language->get('tab_discount');
		$data['tab_empty'] = $this->language->get('tab_empty');
		
		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
		
			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

 		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
		
		$data['error'] = $this->error;
		
  		$data['breadcrumbs'] = array();

   		$data['breadcrumbs'][] = array(
       		'text'	=> $this->language->get('text_home'),
			'href'	=> $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL')
   		);

   		$data['breadcrumbs'][] = array(
       		'text'	=> $this->language->get('text_shipping'),
			'href'	=> $this->url->link('extension/shipping', 'token=' . $this->session->data['token'], 'SSL')
   		);
		
   		$data['breadcrumbs'][] = array(
       		'text'	=> $this->language->get('heading_title'),
			'href'	=> $this->url->link('shipping/cdek', 'token=' . $this->session->data['token'], 'SSL')
   		);
		
		$data['boolean_variables'] = array($this->language->get('text_no'), $this->language->get('text_yes'));
		
		$data['size_types'] = array(
			'volume' => $this->language->get('text_size_type_volume'),
			'size'	 => $this->language->get('text_size_type_size'),
		);
		
		$data['default_work_mode'] = array(
			'order'		=> $this->language->get('text_mode_order'),
			'all'		=> $this->language->get('text_mode_product_all'),
			'optional'	=> $this->language->get('text_mode_product_optional')
		);
		
		$data['pvz_more_one_action'] = array(
			'first'  => $this->language->get('text_first'),
			'split'  => $this->language->get('text_split')
		);
		
		$data['work_mode'] = array(
			'single' => $this->language->get('text_single'),
			'more'	 => $this->language->get('text_more')
		);
		
		$data['discount_type'] = array(
			'fixed'				=> $this->language->get('text_fixed'),
			'percent'			=> $this->language->get('text_percent_source_product'),
			'percent_shipping'	=> $this->language->get('text_percent_shipping'),
			'percent_cod'		=> $this->language->get('text_percent_source_cod')
		);
		
		$data['additional_weight_mode'] = array(
			'fixed'			=> $this->language->get('text_weight_fixed'),
			'all_percent'	=> $this->language->get('text_weight_all')
		);
		
		$data['action'] = $this->url->link('shipping/cdek', 'token=' . $this->session->data['token'], 'SSL');
		$data['cancel'] = $this->url->link('extension/shipping', 'token=' . $this->session->data['token'], 'SSL');
		
		$data['token'] = $this->session->data['token'];
		
		if (isset($this->request->post['cdek_title'])) {
			$data['cdek_title'] = $this->request->post['cdek_title'];
		} else {
			$data['cdek_title'] = $this->config->get('cdek_title');
		}
		
		if (isset($this->request->post['cdek_cache_on_delivery'])) {
			$data['cdek_cache_on_delivery'] = $this->request->post['cdek_cache_on_delivery'];
		} else {
			$data['cdek_cache_on_delivery'] = $this->config->get('cdek_cache_on_delivery');
		}
		
		if (isset($this->request->post['cdek_weight_limit'])) {
			$data['cdek_weight_limit'] = $this->request->post['cdek_weight_limit'];
		} else {
			$data['cdek_weight_limit'] = $this->config->get('cdek_weight_limit');
		}
		
		if (isset($this->request->post['cdek_use_region'])) {
			$data['cdek_use_region'] = $this->request->post['cdek_use_region'];
		} elseif ($this->config->get('cdek_use_region')) {
			$data['cdek_use_region'] = $this->config->get('cdek_use_region');
		} else {
			$data['cdek_use_region'] = array();
		}

		if (isset($this->request->post['cdek_log'])) {
			$data['cdek_log'] = $this->request->post['cdek_log'];
		} else {
			$data['cdek_log'] = $this->config->get('cdek_log');
		}

		$data['cdek_custmer_tariff_list'] = array();

		if ($this->request->server['REQUEST_METHOD'] == 'POST') {

			if (isset($this->request->post['cdek_custmer_tariff_list'])) {
				$data['cdek_custmer_tariff_list'] = $this->request->post['cdek_custmer_tariff_list'];
			}

		} elseif ($this->config->get('cdek_custmer_tariff_list')) {
			$data['cdek_custmer_tariff_list'] = $this->config->get('cdek_custmer_tariff_list');
		} else {
			$data['cdek_custmer_tariff_list'] = array();
		}

		$data['tariff_list'] = array();

		$tariff_list = $this->getTariffList();

		$tariff_groups = $this->getTariffGroups();

		$tariff_mode = $this->getTariffMode();

		foreach ($tariff_list as $tariff_id => &$tariff_info) {

			if (!isset($data['tariff_list'][$tariff_info['group_id']])) {

				$data['tariff_list'][$tariff_info['group_id']] = array(
					'title'	=> $tariff_groups[$tariff_info['group_id']],
					'list'	=> array()
				);

			}

			if (!empty($tariff_info['weight'])) {
				$tariff_info['weight'] = $this->getWeightText($tariff_info['weight']);
			}

			$mode = $tariff_mode[$tariff_info['mode_id']];

			$tariff_info += array(
				'title_full'	=> $tariff_info['title'] . ' (' . $mode['code'] . ')',
				'mode'			=> $mode
			);

			$data['tariff_list'][$tariff_info['group_id']]['list'][$tariff_id] = $tariff_info;
		}


		
		if (isset($data['cdek_custmer_tariff_list'])) {
		
			foreach ($data['cdek_custmer_tariff_list'] as $tariff_row => $customer_tariff) {
				
				if (!empty($customer_tariff['tariff_id']) && isset($tariff_list[$customer_tariff['tariff_id']])) {

					$tariff_info = $tariff_list[$customer_tariff['tariff_id']];
					
					$im_only = isset($tariff_info['im']);

					$data['cdek_custmer_tariff_list'][$tariff_row] += array(
						'tariff_name'	=> $tariff_info['title'] . ($im_only ? ' ***' : ''),
						'mode'			=> $tariff_info['mode'],
						'im'			=> $im_only,
						'weight'		=> $tariff_info['weight'],
						'note'			=> $tariff_info['note']
					);
					
				} else {
					unset($data['cdek_tariff_list'][$tariff_row]);
				}
			}
		
		}
		
		if (isset($this->request->post['cdek_work_mode'])) {
			$data['cdek_work_mode'] = $this->request->post['cdek_work_mode'];
		} else {
			$data['cdek_work_mode'] = $this->config->get('cdek_work_mode');
		}
		
		if (isset($this->request->post['cdek_show_pvz'])) {
			$data['cdek_show_pvz'] = $this->request->post['cdek_show_pvz'];
		} else {
			$data['cdek_show_pvz'] = $this->config->get('cdek_show_pvz');
		}

		if (isset($this->request->post['cdek_view_type'])) {
			$data['cdek_view_type'] = $this->request->post['cdek_view_type'];
		} else {
			$data['cdek_view_type'] = $this->config->get('cdek_view_type');
		}

		$data['view_types'] = array(
			'default' => $this->language->get('text_view_type_default'),
			'group' => $this->language->get('text_view_type_group'),
			'map' => $this->language->get('text_view_type_map')
		);
		
		if (isset($this->request->post['cdek_pvz_more_one'])) {
			$data['cdek_pvz_more_one'] = $this->request->post['cdek_pvz_more_one'];
		} else {
			$data['cdek_pvz_more_one'] = $this->config->get('cdek_pvz_more_one');
		}
		
		if (isset($this->request->post['cdek_default_size'])) {
			$data['cdek_default_size'] = $this->request->post['cdek_default_size'];
		} else {
			$data['cdek_default_size'] = $this->config->get('cdek_default_size');
		}
		
		if (isset($this->request->post['cdek_default_weight'])) {
			$data['cdek_default_weight'] = $this->request->post['cdek_default_weight'];
		} else {
			$data['cdek_default_weight'] = $this->config->get('cdek_default_weight');
		}
		
		if (isset($this->request->post['cdek_tax_class_id'])) {
			$data['cdek_tax_class_id'] = $this->request->post['cdek_tax_class_id'];
		} else {
			$data['cdek_tax_class_id'] = $this->config->get('cdek_tax_class_id');
		}
		
		if (isset($this->request->post['cdek_geo_zone_id'])) {
			$data['cdek_geo_zone_id'] = $this->request->post['cdek_geo_zone_id'];
		} else {
			$data['cdek_geo_zone_id'] = $this->config->get('cdek_geo_zone_id');
		}
		
		if (isset($this->request->post['cdek_customer_group_id'])) {
			$data['cdek_customer_group_id'] = $this->request->post['cdek_customer_group_id'];
		} else {
			$data['cdek_customer_group_id'] = $this->config->get('cdek_customer_group_id');
		}
		
		if (isset($this->request->post['cdek_status'])) {
			$data['cdek_status'] = $this->request->post['cdek_status'];
		} else {
			$data['cdek_status'] = $this->config->get('cdek_status');
		}
		
		if (isset($this->request->post['cdek_period'])) {
			$data['cdek_period'] = $this->request->post['cdek_period'];
		} else {
			$data['cdek_period'] = $this->config->get('cdek_period');
		}
		
		if (isset($this->request->post['cdek_delivery_data'])) {
			$data['cdek_delivery_data'] = $this->request->post['cdek_delivery_data'];
		} else {
			$data['cdek_delivery_data'] = $this->config->get('cdek_delivery_data');
		}
		
		if (isset($this->request->post['cdek_empty_address'])) {
			$data['cdek_empty_address'] = $this->request->post['cdek_empty_address'];
		} elseif (null !== $this->config->get('cdek_empty_address')) {
			$data['cdek_empty_address'] = $this->config->get('cdek_empty_address');
		} else {
			$data['cdek_empty_address'] = 1;
		}

		if (isset($this->request->post['cdek_check_ip'])) {
			$data['cdek_check_ip'] = $this->request->post['cdek_check_ip'];
		} else {
			$data['cdek_check_ip'] = $this->config->get('cdek_check_ip');
		}
		
		if (isset($this->request->post['cdek_min_weight'])) {
			$data['cdek_min_weight'] = $this->request->post['cdek_min_weight'];
		} else {
			$data['cdek_min_weight'] = $this->config->get('cdek_min_weight');
		}
		
		if (isset($this->request->post['cdek_max_weight'])) {
			$data['cdek_max_weight'] = $this->request->post['cdek_max_weight'];
		} else {
			$data['cdek_max_weight'] = $this->config->get('cdek_max_weight');
		}
		
		if (isset($this->request->post['cdek_min_total'])) {
			$data['cdek_min_total'] = $this->request->post['cdek_min_total'];
		} else {
			$data['cdek_min_total'] = $this->config->get('cdek_min_total');
		}
		
		if (isset($this->request->post['cdek_max_total'])) {
			$data['cdek_max_total'] = $this->request->post['cdek_max_total'];
		} else {
			$data['cdek_max_total'] = $this->config->get('cdek_max_total');
		}
		
		if (isset($this->request->post['cdek_city_from'])) {
			$data['cdek_city_from'] = $this->request->post['cdek_city_from'];
		} else {
			$data['cdek_city_from'] = $this->config->get('cdek_city_from');
		}
		
		if (isset($this->request->post['cdek_length_class_id'])) {
			$data['cdek_length_class_id'] = $this->request->post['cdek_length_class_id'];
		} elseif ($this->config->get('cdek_length_class_id')) {
			$data['cdek_length_class_id'] = $this->config->get('cdek_length_class_id');
		} else {
			$data['cdek_length_class_id'] = 1;
		}
		
		if (isset($this->request->post['cdek_weight_class_id'])) {
			$data['cdek_weight_class_id'] = $this->request->post['cdek_weight_class_id'];
		} elseif ($this->config->get('cdek_weight_class_id')) {
			$data['cdek_weight_class_id'] = $this->config->get('cdek_weight_class_id');
		} else {
			$data['cdek_weight_class_id'] = 1;
		}
		
		if (isset($this->request->post['cdek_city_from_id'])) {
			$data['cdek_city_from_id'] = $this->request->post['cdek_city_from_id'];
		} else {
			$data['cdek_city_from_id'] = $this->config->get('cdek_city_from_id');
		}
		
		if (isset($this->request->post['cdek_append_day'])) {
			$data['cdek_append_day'] = $this->request->post['cdek_append_day'];
		} else {
			$data['cdek_append_day'] = (int)$this->config->get('cdek_append_day');
		}
		
		if (isset($this->request->post['cdek_more_days'])) {
			$data['cdek_more_days'] = $this->request->post['cdek_more_days'];
		} else {
			$data['cdek_more_days'] = (int)$this->config->get('cdek_more_days');
		}
		
		if (isset($this->request->post['cdek_login'])) {
			$data['cdek_login'] = $this->request->post['cdek_login'];
		} else {
			$data['cdek_login'] = $this->config->get('cdek_login');
		}
		
		if (isset($this->request->post['cdek_password'])) {
			$data['cdek_password'] = $this->request->post['cdek_password'];
		} else {
			$data['cdek_password'] = $this->config->get('cdek_password');
		}
		
		$data['cdek_store'] = array();
		
		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
			
			if (isset($this->request->post['cdek_store'])) {
				$data['cdek_store'] = $this->request->post['cdek_store'];
			}
			
		} elseif($this->config->get('cdek_store')) {
			$data['cdek_store'] = $this->config->get('cdek_store');
		}
		
		if (isset($this->request->post['cdek_sort_order'])) {
			$data['cdek_sort_order'] = $this->request->post['cdek_sort_order'];
		} else {
			$data['cdek_sort_order'] = $this->config->get('cdek_sort_order');
		}
		
		if (isset($this->request->post['cdek_packing_weight_class_id'])) {
			$data['cdek_packing_weight_class_id'] = $this->request->post['cdek_packing_weight_class_id'];
		} else {
			$data['cdek_packing_weight_class_id'] = $this->config->get('cdek_packing_weight_class_id');
		}
		
		if (isset($this->request->post['cdek_packing_prefix'])) {
			$data['cdek_packing_prefix'] = $this->request->post['cdek_packing_prefix'];
		} else {
			$data['cdek_packing_prefix'] = $this->config->get('cdek_packing_prefix');
		}
		
		if (isset($this->request->post['cdek_packing_mode'])) {
			$data['cdek_packing_mode'] = $this->request->post['cdek_packing_mode'];
		} else {
			$data['cdek_packing_mode'] = $this->config->get('cdek_packing_mode');
		}
		
		if (isset($this->request->post['cdek_packing_value'])) {
			$data['cdek_packing_value'] = $this->request->post['cdek_packing_value'];
		} else {
			$data['cdek_packing_value'] = $this->config->get('cdek_packing_value');
		}
		
		if (isset($this->request->post['cdek_packing_min_weight'])) {
			$data['cdek_packing_min_weight'] = $this->request->post['cdek_packing_min_weight'];
		} else {
			$data['cdek_packing_min_weight'] = $this->config->get('cdek_packing_min_weight');
		}
		
		$data['cdek_discounts'] = array();
		
		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
			
			if (isset($this->request->post['cdek_discounts'])) {
				$data['cdek_discounts'] = $this->request->post['cdek_discounts'];
			}
			
		} elseif ($this->config->get('cdek_discounts')) {
			$data['cdek_discounts'] = $this->config->get('cdek_discounts');
		}
		
		if (isset($this->request->post['cdek_city_ignore'])) {
			$data['cdek_city_ignore'] = $this->request->post['cdek_city_ignore'];
		} else {
			$data['cdek_city_ignore'] = $this->config->get('cdek_city_ignore');
		}

		if (isset($this->request->post['cdek_pvz_ignore'])) {
			$data['cdek_pvz_ignore'] = $this->request->post['cdek_pvz_ignore'];
		} else {
			$data['cdek_pvz_ignore'] = $this->config->get('cdek_pvz_ignore');
		}
		
		if (isset($this->request->post['cdek_empty'])) {
			$data['cdek_empty'] = $this->request->post['cdek_empty'];
		} else {
			$data['cdek_empty'] = $this->config->get('cdek_empty');
		}

		if (isset($this->request->post['cdek_insurance'])) {
			$data['cdek_insurance'] = $this->request->post['cdek_insurance'];
		} else {
			$data['cdek_insurance'] = $this->config->get('cdek_insurance');
		}

		if (isset($this->request->post['cdek_rounding'])) {
			$data['cdek_rounding'] = $this->request->post['cdek_rounding'];
		} else {
			$data['cdek_rounding'] = $this->config->get('cdek_rounding');
		}

		if (isset($this->request->post['cdek_rounding_type'])) {
			$data['cdek_rounding_type'] = $this->request->post['cdek_rounding_type'];
		} else {
			$data['cdek_rounding_type'] = $this->config->get('cdek_rounding_type');
		}

		$data['rounding_types'] = array(
			'round' => $this->language->get('text_rounding_type_round'),
			'floor' => $this->language->get('text_rounding_type_floor'),
			'ceil' => $this->language->get('text_rounding_type_ceil')
		);
		
		$data['languages'] = $this->model_localisation_language->getLanguages();
		$data['geo_zones'] = $this->model_localisation_geo_zone->getGeoZones();
		$data['tax_classes'] = $this->model_localisation_tax_class->getTaxClasses();
		
		if (version_compare(VERSION, '2.1', '>=')) {
			$customer_groups = $this->model_customer_customer_group->getCustomerGroups();
		} else {
			$customer_groups = $this->model_sale_customer_group->getCustomerGroups();
		}
		
		$data['customer_groups'] = $customer_groups;
		
		$data['length_classes'] = $this->model_localisation_length_class->getLengthClasses();
		$data['weight_classes'] = $this->model_localisation_weight_class->getWeightClasses();
		$data['countries'] = $this->model_localisation_country->getCountries();
		
		$this->load->model('setting/store');
		
		$data['stores'] = array();
		$data['stores'][] = array(
			'store_id' => 0,
			'name'	   => $this->language->get('text_store_default')
		);
		
		$data['stores'] = array_merge($data['stores'], $this->model_setting_store->getStores());
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('shipping/cdek.tpl', $data));
	}
	
	private function validate()
	{
		if (!$this->user->hasPermission('modify', 'shipping/cdek')) {
			$this->error['warning'] = $this->language->get('error_permission');
		} else {
			
			if (!isset($this->request->post['cdek_city_from_id']) || $this->request->post['cdek_city_from_id'] == 0) {
				$this->error['cdek_city_from'] = $this->language->get('error_cdek_city_from');
			}
			
			foreach (array('cdek_weight_class_id', 'cdek_length_class_id') as $item) {
				if (!$this->request->post[$item]) $this->error[$item] = $this->language->get('error_empty');
			}
			
			if ($this->request->post['cdek_default_size']['use']) {
				
				$default_size = $this->request->post['cdek_default_size'];
				
				switch ($default_size['type']) {
					case 'volume':
					
						if (!is_numeric($default_size['volume'])) {
							$this->error['cdek_default_size']['volume'] = $this->language->get('error_numeric');
						} elseif ($default_size['volume'] <= 0) {
							$this->error['cdek_default_size']['volume'] = $this->language->get('error_positive_numeric');
						}
					
						break;
					case 'size':
					
						foreach (array('size_a', 'size_b', 'size_c') as $item) {
							
							if (!is_numeric($default_size[$item])) {
								$this->error['cdek_default_size']['size'] = $this->language->get('error_numeric');
								break;
							} elseif ($default_size[$item] <= 0) {
								$this->error['cdek_default_size']['size'] = $this->language->get('error_positive_numeric');
								break;
							}
							
						}
					
						break;
				}
				
			}
			
			if ($this->request->post['cdek_default_weight']['use']) {
				
				$default_weight = $this->request->post['cdek_default_weight'];
				
				if (!is_numeric($default_weight['value'])) {
					$this->error['cdek_default_weight']['value'] = $this->language->get('error_numeric');
				} elseif ($default_weight['value'] <= 0) {
					$this->error['cdek_default_weight']['value'] = $this->language->get('error_positive_numeric');
				}
				
			}
			
			foreach (array('cdek_append_day', 'cdek_max_weight', 'cdek_min_weight', 'cdek_min_total', 'cdek_max_total', 'cdek_sort_order', 'cdek_packing_value', 'cdek_more_days') as $item) {
				if ($this->request->post[$item] != "" && !is_numeric($this->request->post[$item])) {
					$this->error[$item] = $this->language->get('error_numeric');
				}
			}
			
			if ($this->request->post['cdek_packing_min_weight'] != "") {
				
				if (!is_numeric($this->request->post['cdek_packing_min_weight'])) {
					$this->error['cdek_packing_min_weight'] = $this->language->get('error_numeric');
				} elseif ($this->request->post['cdek_packing_min_weight'] <= 0) {
					$this->error['cdek_packing_min_weight'] = $this->language->get('error_positive_numeric');
				}
				
			}
			
			if (!isset($this->request->post['cdek_custmer_tariff_list']) || empty($this->request->post['cdek_custmer_tariff_list'])) {
				$this->error['tariff_list'] = $this->language->get('error_tariff_list');
			} else {
				
				$geo_zones = $tariff_exists = array();
				
				$this->load->model('localisation/geo_zone');
				
				foreach ($this->model_localisation_geo_zone->getGeoZones() as $item) {
					$geo_zones[$item['geo_zone_id']] = '«' . $item['name'] . '»';
				}
				
				foreach ($this->request->post['cdek_custmer_tariff_list'] as $tariff_row => $tariff_info) {
					
					$tariff_id = $tariff_info['tariff_id'];
					
					foreach (array('max_weight', 'min_weight', 'min_total', 'max_total') as $item) {
						if ($tariff_info[$item] != "" && !is_numeric($tariff_info[$item])) {
							$this->error['tariff_list_item'][$tariff_row][$item] = $this->language->get('error_numeric');
						} elseif (is_numeric($tariff_info[$item]) && $tariff_info[$item] <= 0) {
							$this->error['tariff_list_item'][$tariff_row][$item] = $this->language->get('error_positive_numeric');
						}
					}
					
					$geo_zone = !empty($tariff_info['geo_zone']) ? array_flip($tariff_info['geo_zone']) : array('all' => 'all');
					
					if (array_key_exists($tariff_id, $tariff_exists)) {
						
						$exists = array_intersect_key($geo_zone, $tariff_exists[$tariff_id]);
						
						if (!empty($exists)) {
							
							$error_zones = array();
							
							foreach (array_keys($exists) as $zone_id) {
								if (array_key_exists($zone_id, $geo_zones)) {
									$error_zones[] = $geo_zones[$zone_id];
								} elseif ($zone_id == 'all')  {
									$error_zones[] = 'все регионы';
								}
							}
							
							if (!empty($error_zones)) {
								$this->error['tariff_list_item'][$tariff_row]['exists'] = sprintf($this->language->get('error_tariff_item_exists'), implode(', ', array_unique($error_zones)));
							}
						}
						
						$tariff_exists[$tariff_id] += $geo_zone;
						
					} else {
						$tariff_exists[$tariff_id] = $geo_zone;
					}
					
				}
				
			}
			
			if (!empty($this->request->post['cdek_discounts'])) {
				
				foreach ($this->request->post['cdek_discounts'] as $discount_row => $discount_data) {
					
					if ($discount_data['total'] == "" || !is_numeric($discount_data['total'])) {
						$this->error['cdek_discounts'][$discount_row]['total'] = $this->language->get('error_numeric');
					}

					if ($discount_data['value'] == '') {
						$this->error['cdek_discounts'][$discount_row]['value'] = $this->language->get('error_empty');
					} elseif (!is_numeric($discount_data['value'])) {
						$this->error['cdek_discounts'][$discount_row]['value'] = $this->language->get('error_numeric');
					}
					
				}
			}

			if (!empty($this->request->post['cdek_empty']['use'])) {
				
				if ($this->request->post['cdek_empty']['cost'] != "" && !is_numeric($this->request->post['cdek_empty']['cost'])) {
					$this->error['cdek_empty']['cost'] = $this->language->get('error_numeric');
				}
				
			}
			
			if ($this->error && !isset($this->error['warning'])) {
				$this->error['warning'] = $this->language->get('error_warning');
			}
		}
		
		return !$this->error;
	}

	private function getTariffMode()
	{
		return array(
			1 => array(
				'title'	=> 'дверь-дверь',
				'code'	=> 'Д-Д'
			),
			2 => array(
				'title'	=> 'дверь-склад',
				'code'	=> 'Д-С'
			),
			3 => array(
				'title'	=> 'склад-дверь',
				'code'	=> 'С-Д'
			),
			4 => array(
				'title'	=> 'склад-склад',
				'code'	=> 'С-С'
			)
		);
	}

	private function getTariffGroups()
	{
		return array(
			1 => 'Тарифы только для Интернет-магазинов',
			2 => 'Тарифы Китайский экспресс',
			3 => 'Тарифы для обычной доставки',
			4 => 'Тарифы для международной доставки'
		);
	}

	private function getTariffList()
	{
		return array(
			136 => array(
				'title'		=> 'Посылка',
				'group_id'	=> 1,
				'mode_id'	=> 4,
				'im'        => 1,
				'weight'    => array('max' => 30),
				'note'      => 'Услуга экономичной доставки товаров по России для компаний, осуществляющих дистанционную торговлю.',
			),
			137 => array(
				'title'		=> 'Посылка',
				'group_id'	=> 1,
				'mode_id'	=> 3,
				'im'		=> 1,
				'weight'    => array('max' => 30),
				'note'      => 'Услуга экономичной доставки товаров по России для компаний, осуществляющих дистанционную торговлю.'
			),
			138 => array(
				'title'		=> 'Посылка',
				'group_id'	=> 1,
				'mode_id'	=> 2,
				'im'		=> 1,
				'weight'    => array('max' => 30),
				'note'      => 'Услуга экономичной доставки товаров по России для компаний, осуществляющих дистанционную торговлю.'
			),
			139 => array(
				'title'		=> 'Посылка',
				'group_id'	=> 1,
				'mode_id'	=> 1,
				'im'		=> 1,
				'weight'    => array('max' => 30),
				'note'      => 'Услуга экономичной доставки товаров по России для компаний, осуществляющих дистанционную торговлю.',
			),
			233 => array(
				'title'		=> 'Экономичная посылка',
				'group_id'	=> 1,
				'mode_id'	=> 3,
				'im'		=> 1,
				'weight'    => array('max' => 50),
				'note'      => 'Услуга экономичной наземной доставки товаров по России для компаний, осуществляющих дистанционную торговлю. Услуга действует по направлениям из Москвы в подразделения СДЭК, находящиеся за Уралом и в Крым.',
			),
			234 => array(
				'title'		=> 'Экономичная посылка',
				'group_id'	=> 1,
				'mode_id'	=> 4,
				'im'		=> 1,
				'weight'    => array('max' => 50),
				'note'      => '',
			),
			301 => array(
				'title'		=> 'До постомата InPost',
				'group_id'	=> 1,
				'mode_id'	=> 2,
				'im'		=> 1,
				'weight'    => array(),
				'note'      => 'Услуга доставки товаров по России с использованием постоматов. Для компаний, осуществляющих дистанционную торговлю.<br /><br />Характеристики услуги:<ul type="circle"><li>по услуге принимаются только одноместные заказы</li><li>выбранный при оформлении заказа постомат изменить на другой нельзя</li><li>при невозможности использования постоматов осуществляется доставка до ПВЗ СДЭК или «до двери» клиента с изменением тарификации на услугу «Посылка»</li><li>срок хранения заказа в ячейке: 5 дней с момента закладки в постомат</li><li>возможность приема наложенного платежа</li></ul>3 вида ячеек:<ol><li>А (8*38*64 см)— до 5 кг</li><li>В (19*38*64 см) — до 7 кг</li><li>С (41*38*64 см)— до 20 кг</li></ol>',
				'postomat'	=> true
			),
			302 => array(
				'title'		=> 'До постомата InPost',
				'group_id'	=> 1,
				'mode_id'	=> 4,
				'im'		=> 1,
				'weight'    => array(),
				'note'      => 'Услуга доставки товаров по России с использованием постоматов. Для компаний, осуществляющих дистанционную торговлю.<br /><br />Характеристики услуги:<ul type="circle"><li>по услуге принимаются только одноместные заказы</li><li>выбранный при оформлении заказа постомат изменить на другой нельзя</li><li>при невозможности использования постоматов осуществляется доставка до ПВЗ СДЭК или «до двери» клиента с изменением тарификации на услугу «Посылка»</li><li>срок хранения заказа в ячейке: 5 дней с момента закладки в постомат</li><li>возможность приема наложенного платежа</li></ul>3 вида ячеек:<ol><li>А (8*38*64 см)— до 5 кг</li><li>В (19*38*64 см) — до 7 кг</li><li>С (41*38*64 см)— до 20 кг</li></ol>',
				'postomat'	=> true
			),
			243 => array(
				'title'		=> 'Китайский экспресс',
				'group_id'	=> 2,
				'mode_id'	=> 4,
				'weight'    => array(),
				'note'      => 'Услуга по доставке из Китая в Россию, Белоруссию и Казахстан.<br /><br />Стоимость разбита по интервалам:<ul type="circle"><li>до 200 гр;</li><li>каждые последующие 100 гр до 1 кг;</li><li>каждый последующий 1кг свыше 1 кг.</li></ul>',
			),
			245 => array(
				'title'		=> 'Китайский экспресс',
				'group_id'	=> 2,
				'mode_id'	=> 1,
				'weight'    => array(),
				'note'      => 'Услуга по доставке из Китая в Россию, Белоруссию и Казахстан.<br /><br />Стоимость разбита по интервалам:<ul type="circle"><li>до 200 гр;</li><li>каждые последующие 100 гр до 1 кг;</li><li>каждый последующий 1кг свыше 1 кг.</li></ul>',
			),
			246 => array(
				'title'		=> 'Китайский экспресс',
				'group_id'	=> 2,
				'mode_id'	=> 3,
				'weight'    => array(),
				'note'      => 'Услуга по доставке из Китая в Россию, Белоруссию и Казахстан.<br /><br />Стоимость разбита по интервалам:<ul type="circle"><li>до 200 гр;</li><li>каждые последующие 100 гр до 1 кг;</li><li>каждый последующий 1кг свыше 1 кг.</li></ul>',
			),
			247 => array(
				'title'		=> 'Китайский экспресс',
				'group_id'	=> 2,
				'mode_id'	=> 2,
				'weight'    => array(),
				'note'      => 'Услуга по доставке из Китая в Россию, Белоруссию и Казахстан.<br /><br />Стоимость разбита по интервалам:<ul type="circle"><li>до 200 гр;</li><li>каждые последующие 100 гр до 1 кг;</li><li>каждый последующий 1кг свыше 1 кг.</li></ul>',
			),
			1	=> array(
				'title'		=> 'Экспресс лайт',
				'group_id'	=> 3,
				'mode_id'	=> 1,
				'weight'    => array('max' => 30),
				'note'      => 'Классическая экспресс-доставка по России документов и грузов'
			),
			3 => array(
				'title'		=> 'Супер-экспресс до 18',
				'group_id'	=> 3,
				'mode_id'	=> 1,
				'weight'    => array(),
				'note'      => 'Срочная доставка документов и грузов «из рук в руки» по России к определенному часу.'
			),
			5 => array(
				'title'		=> 'Экономичный экспресс',
				'group_id'	=> 3,
				'mode_id'	=> 4,
				'weight'    => array(),
				'note'      => 'Недорогая доставка грузов по России ЖД и автотранспортом (доставка грузов с увеличением сроков).'
			),
			10 => array(
				'title'		=> 'Экспресс лайт',
				'group_id'	=> 3,
				'mode_id'	=> 4,
				'weight'    => array('max' => 30),
				'note'      => 'Классическая экспресс-доставка по России документов и грузов.'
			),
			11 => array(
				'title'		=> 'Экспресс лайт',
				'group_id'	=> 3,
				'mode_id'	=> 3,
				'weight'    => array('max' => 30),
				'note'      => 'Классическая экспресс-доставка по России документов и грузов.'
			),
			12 => array(
				'title'		=> 'Экспресс лайт',
				'group_id'	=> 3,
				'mode_id'	=> 2,
				'weight'    => array('max' => 30),
				'note'      => 'Классическая экспресс-доставка по России документов и грузов.'
			),
			15 => array(
				'title'		=> 'Экспресс тяжеловесы',
				'group_id'	=> 3,
				'mode_id'	=> 4,
				'weight'    => array('min' => 30),
				'note'      => 'Классическая экспресс-доставка по России грузов.'
			),
			16 => array(
				'title'		=> 'Экспресс тяжеловесы',
				'group_id'	=> 3,
				'mode_id'	=> 3,
				'weight'    => array('min' => 30),
				'note'      => 'Классическая экспресс-доставка по России грузов.'
			),
			17 => array(
				'title'		=> 'Экспресс тяжеловесы',
				'group_id'	=> 3,
				'mode_id'	=> 2,
				'weight'    => array('min' => 30),
				'note'      => 'Классическая экспресс-доставка по России грузов.'
			),
			18 => array(
				'title'		=> 'Экспресс тяжеловесы',
				'group_id'	=> 3,
				'mode_id'	=> 1,
				'weight'    => array('min' => 30),
				'note'      => 'Классическая экспресс-доставка по России грузов.'
			),
			57 => array(
				'title'		=> 'Супер-экспресс до 9',
				'group_id'	=> 3,
				'mode_id'	=> 1,
				'weight'    => array('max' => 5),
				'note'      => 'Срочная доставка документов и грузов «из рук в руки» по России к определенному часу (доставка за 1-2 суток).'
			),
			58 => array(
				'title'		=> 'Супер-экспресс до 10',
				'group_id'	=> 3,
				'mode_id'	=> 1,
				'weight'    => array('max' => 5),
				'note'      => 'Срочная доставка документов и грузов «из рук в руки» по России к определенному часу (доставка за 1-2 суток).'
			),
			59 => array(
				'title'		=> 'Супер-экспресс до 12',
				'group_id'	=> 3,
				'mode_id'	=> 1,
				'weight'    => array('max' => 5),
				'note'      => 'Срочная доставка документов и грузов «из рук в руки» по России к определенному часу (доставка за 1-2 суток).'
			),
			60 => array(
				'title'		=> 'Супер-экспресс до 14',
				'group_id'	=> 3,
				'mode_id'	=> 1,
				'weight'    => array('max' => 5),
				'note'      => 'Срочная доставка документов и грузов «из рук в руки» по России к определенному часу (доставка за 1-2 суток).'
			),
			61 => array(
				'title'		=> 'Супер-экспресс до 16',
				'group_id'	=> 3,
				'mode_id'	=> 1,
				'weight'    => array(),
				'note'      => 'Срочная доставка документов и грузов «из рук в руки» по России к определенному часу (доставка за 1-2 суток).'
			),
			62 => array(
				'title'		=> 'Магистральный экспресс',
				'group_id'	=> 3,
				'mode_id'	=> 4,
				'weight'    => array(),
				'note'      => 'Быстрая экономичная доставка грузов по России'
			),
			63 => array(
				'title'		=> 'Магистральный супер-экспресс',
				'group_id'	=> 3,
				'mode_id'	=> 4,
				'weight'    => array(),
				'note'      => 'Быстрая экономичная доставка грузов к определенному часу'
			),
			7 => array(
				'title'		=> 'Международный экспресс документы',
				'group_id'	=> 4,
				'mode_id'	=> 1,
				'weight'    => array('max' => 1.5),
				'note'      => 'Экспресс-доставка за/из-за границы документов и писем'
			),
			8 => array(
				'title'		=> 'Международный экспресс грузы',
				'group_id'	=> 4,
				'mode_id'	=> 1,
				'weight'    => array('min' => 0.5, 'max' => 30),
				'note'      => 'Экспресс-доставка за/из-за границы грузов и посылок от 0,5 кг до 30 кг.'
			),
			161 => array(
				'title'		=> 'Международный экспресс Внуково VKO',
				'group_id'	=> 4,
				'mode_id'	=> 1,
				'weight'    => array(),
				'note'      => 'Доставка через аэропорт Внуково г. Москва'
			),
			162 => array(
				'title'		=> 'Международный экспресс Внуково VKO',
				'group_id'	=> 4,
				'mode_id'	=> 4,
				'weight'    => array(),
				'note'      => 'Доставка через аэропорт Внуково г. Москва'
			),
			163 => array(
				'title'		=> 'Международный экспресс Внуково VKO',
				'group_id'	=> 4,
				'mode_id'	=> 3,
				'weight'    => array(),
				'note'      => 'Доставка через аэропорт Внуково г. Москва'
			),
			164 => array(
				'title'		=> 'Международный экспресс Внуково VKO',
				'group_id'	=> 4,
				'mode_id'	=> 2,
				'weight'    => array(),
				'note'      => 'Доставка через аэропорт Внуково г. Москва'
			),
			166 => array(
				'title'		=> 'Международный экспресс Кольцово SVX',
				'group_id'	=> 4,
				'mode_id'	=> 1,
				'weight'    => array(),
				'note'      => 'Доставка через аэропорт Кольцово г. Екатеринбург'
			),
			167 => array(
				'title'		=> 'Международный экспресс Кольцово SVX',
				'group_id'	=> 4,
				'mode_id'	=> 4,
				'weight'    => array(),
				'note'      => 'Доставка через аэропорт Кольцово г. Екатеринбург'
			),
			168 => array(
				'title'		=> 'Международный экспресс Кольцово SVX',
				'group_id'	=> 4,
				'mode_id'	=> 3,
				'weight'    => array(),
				'note'      => 'Доставка через аэропорт Кольцово г. Екатеринбург'
			),
			169 => array(
				'title'		=> 'Международный экспресс Кольцово SVX',
				'group_id'	=> 4,
				'mode_id'	=> 2,
				'weight'    => array(),
				'note'      => 'Доставка через аэропорт Кольцово г. Екатеринбург'
			),
			170 => array(
				'title'		=> 'Международный экспресс Толмачево OVB',
				'group_id'	=> 4,
				'mode_id'	=> 1,
				'weight'    => array(),
				'note'      => 'Доставка через аэропорт Толмачево г. Новосибирск'
			),
			171 => array(
				'title'		=> 'Международный экспресс Толмачево OVB',
				'group_id'	=> 4,
				'mode_id'	=> 4,
				'weight'    => array(),
				'note'      => 'Доставка через аэропорт Толмачево г. Новосибирск'
			),
			172 => array(
				'title'		=> 'Международный экспресс Толмачево OVB',
				'group_id'	=> 4,
				'mode_id'	=> 3,
				'weight'    => array(),
				'note'      => 'Доставка через аэропорт Толмачево г. Новосибирск'
			),
			173 => array(
				'title'		=> 'Международный экспресс Толмачево OVB',
				'group_id'	=> 4,
				'mode_id'	=> 2,
				'weight'    => array(),
				'note'      => 'Доставка через аэропорт Толмачево г. Новосибирск'
			),
			174 => array(
				'title'		=> 'Международный экспресс Кневичи VVO',
				'group_id'	=> 4,
				'mode_id'	=> 1,
				'weight'    => array(),
				'note'      => 'Доставка через аэропорт Кневичи г. Владивосток'
			),
			175 => array(
				'title'		=> 'Международный экспресс Кневичи VVO',
				'group_id'	=> 4,
				'mode_id'	=> 4,
				'weight'    => array(),
				'note'      => 'Доставка через аэропорт Кневичи г. Владивосток'
			),
			176 => array(
				'title'		=> 'Международный экспресс Кневичи VVO',
				'group_id'	=> 4,
				'mode_id'	=> 3,
				'weight'    => array(),
				'note'      => 'Доставка через аэропорт Кневичи г. Владивосток'
			),
			177 => array(
				'title'		=> 'Международный экспресс Кневичи VVO',
				'group_id'	=> 4,
				'mode_id'	=> 2,
				'weight'    => array(),
				'note'      => 'Доставка через аэропорт Кневичи г. Владивосток'
			),
			178 => array(
				'title'		=> 'Международный экспресс грузы',
				'group_id'	=> 4,
				'mode_id'	=> 4,
				'weight'    => array('min' => 0.5, 'max' => 30),
				'note'      => 'Экспресс-доставка за/из-за границы грузов и посылок от 0,5 кг до 30 кг.'
			),
			179 => array(
				'title'		=> 'Международный экспресс грузы',
				'group_id'	=> 4,
				'mode_id'	=> 3,
				'weight'    => array('min' => 0.5, 'max' => 30),
				'note'      => 'Экспресс-доставка за/из-за границы грузов и посылок от 0,5 кг до 30 кг.'
			),
			180 => array(
				'title'		=> 'Международный экспресс грузы',
				'group_id'	=> 4,
				'mode_id'	=> 2,
				'weight'    => array('min' => 0.5, 'max' => 30),
				'note'      => 'Экспресс-доставка за/из-за границы грузов и посылок от 0,5 кг до 30 кг.'
			),
			181 => array(
				'title'		=> 'Международный экспресс документы',
				'group_id'	=> 4,
				'mode_id'	=> 4,
				'weight'    => array('max' => 1.5),
				'note'      => 'Экспресс-доставка за/из-за границы документов и писем'
			),
			182 => array(
				'title'		=> 'Международный экспресс документы',
				'group_id'	=> 4,
				'mode_id'	=> 3,
				'weight'    => array('max' => 1.5),
				'note'      => 'Экспресс-доставка за/из-за границы документов и писем'
			),
			183 => array(
				'title'		=> 'Международный экспресс документы',
				'group_id'	=> 4,
				'mode_id'	=> 2,
				'weight'    => array('max' => 1.5),
				'note'      => 'Экспресс-доставка за/из-за границы документов и писем'
			),
			184 => array(
				'title'		=> 'Международный экономичный экспресс',
				'group_id'	=> 4,
				'mode_id'	=> 1,
				'weight'    => array(),
				'note'      => 'Доставка морем'
			),
			185 => array(
				'title'		=> 'Международный экономичный экспресс',
				'group_id'	=> 4,
				'mode_id'	=> 4,
				'weight'    => array(),
				'note'      => 'Доставка морем'
			),
			186 => array(
				'title'		=> 'Международный экономичный экспресс',
				'group_id'	=> 4,
				'mode_id'	=> 3,
				'weight'    => array(),
				'note'      => 'Доставка морем'
			),
			187 => array(
				'title'		=> 'Международный экономичный экспресс',
				'group_id'	=> 4,
				'mode_id'	=> 2,
				'weight'    => array(),
				'note'      => 'Доставка морем'
			)
		);
	}
	
	private function getWeightText($weight)
	{
		$text = '';

		if (!empty($weight['min'])) {
			$text .= 'от ' . $weight['min'] . ' кг. ';
		}

		if (!empty($weight['max'])) {
			$text .= 'до ' . $weight['max'] . ' кг.';
		}

		return trim($text);
	}
	
	private function getStores()
	{
		$this->load->model('setting/store');
		
		$stores = $this->model_setting_store->getStores();
        $stores[] = array('store_id' => 0, 'name' => $this->config->get('config_name'));
		
		return $stores;
	}

	private function saveTariffList()
	{
		$this->load->model('setting/setting');

		$tariff_list = array(
			'cdek_tariff_list' => $this->getTariffList()
		);

		foreach ($this->getStores() as $key => $store_info) {
			$this->model_setting_setting->editSetting('cdek_tariff_list', $tariff_list, $store_info['store_id']);
		}

	}

	public function uninstall()
	{
		$this->load->model('setting/setting');

		foreach ($this->getStores() as $key => $store_info) {
			$this->model_setting_setting->deleteSetting('cdek_tariff_list', $store_info['store_id']);
		}

	}
}

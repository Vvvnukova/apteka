<?php

class ControllerShippingCdek extends Controller
{
    public function index()
    {
        if ($this->isAjax()) {

            $status = 'error';

            if (isset($this->request->get['code']) && ($pvz_info = $this->getPVZ($this->request->get['code']))) {

                $old_code = $this->request->get['old_key'];
                $parts = explode('.', $old_code);

                if (isset($this->session->data['shipping_methods'][$parts[0]]['quote'][$parts[1]])) {

                    $quote_info = $this->session->data['shipping_methods'][$parts[0]]['quote'][$parts[1]];

                    $code = 'pvz_' . (int)$this->request->get['tariff_id'] . '_' . $this->request->get['code'];

                    $quote_info['code'] = 'cdek.' . $code;
                    $quote_info['title'] = $quote_info['title_clear'] . ': ' . $pvz_info['address_short'];

                    $this->session->data['shipping_methods'][$parts[0]]['quote'][$code] = $quote_info;
                    $this->session->data['cdek_last_pvz'][$this->request->get['tariff_id']] = $this->request->get['code'];

                    $status = 'ok';
                }
            }

            echo json_encode(array('status' => $status));

        } else {
            $this->request->get['route'] = 'error/not_found';
            return new Action($this->request->get['route']);
        }
    }

    public function map()
    {
        if ($this->isAjax()) {

            if (isset($this->request->get['tariff_id'])) {
                $tariff_id = $this->request->get['tariff_id'];
            } else {
                $tariff_id = 0;
            }

            if (($tariff_info = $this->getTariff($tariff_id)) && !empty($this->request->get['city_id'])) {

                $type = 'PVZ';

                if (isset($tariff_info['postomat'])) {
                    $type = 'POSTOMAT';
                }

                $pvz_all = $this->getPVZList();

                if (isset($pvz_all[$type][$this->request->get['city_id']])) {
                    $data['pvz_list'] = $pvz_all[$type][$this->request->get['city_id']];
                } else {
                    $data['pvz_list'] = array();
                }

                $data['tariff_id'] = $tariff_id;

                $data['active'] = $this->request->get['active'];

                if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/total/cdek_map.tpl')) {
                    $template = $this->config->get('config_template') . '/template/total/cdek_map.tpl';
                } else {
                    $template = 'default/template/total/cdek_map.tpl';
                }

                $this->response->setOutput($this->load->view($template, $data));
            }

        } else {
            $this->request->get['route'] = 'error/not_found';
            return new Action($this->request->get['route']);
        }

    }

    private function getPVZ($code)
    {
        $list = array();

        foreach ($this->getPVZList() as $type => $type_cities) {
            foreach ($type_cities as $city_id => $city_list) {
                foreach ($city_list as $key => $pvz_info) {
                    $list[$pvz_info['code']] = $pvz_info;
                }

            }

        }

        return isset($list[$code]) ? $list[$code] : false;
    }

    private function getPVZList()
    {
        $this->load->model('shipping/cdek');

        return $this->model_shipping_cdek->getPVZAll();;
    }

    private function getTariff($tariff_id)
    {
        $tariff_list = $this->getTariffList();

        return isset($tariff_list[$tariff_id]) ? $tariff_list[$tariff_id] : false;
    }

    private function getTariffList()
    {
        return  $this->config->get('cdek_tariff_list');
    }

    private function isAjax()
    {
        return !empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest';
    }
}
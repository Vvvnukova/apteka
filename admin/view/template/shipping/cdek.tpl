<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<button type="submit" form="form-cdek" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
				<button type="submit" form="form-cdek" data-toggle="tooltip" title="<?php echo $button_apply; ?>" class="btn btn-primary apple"><?php echo $button_apply; ?></button>
				<a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
			</div>
			<h1><?php echo $heading_title; ?></h1>
			<ul class="breadcrumb">
				<?php foreach ($breadcrumbs as $breadcrumb) { ?>
				<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
				<?php } ?>
			</ul>
		</div>
	</div>
	<div class="container-fluid">
		<?php if ($error_warning) { ?>
		<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
		</div>
		<?php } ?>
		<?php if ($success) { ?>
		<div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
		</div>
		<?php } ?>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
			</div>
			<div class="panel-body">
				<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-cdek" class="form-horizontal">
					<ul class="nav nav-tabs">
						<li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
						<li><a href="#tab-data" data-toggle="tab"><?php echo $tab_data; ?></a></li>
						<li><a href="#tab-auth" data-toggle="tab"><?php echo $tab_auth; ?></a></li>
						<li><a href="#tab-tariff" data-toggle="tab"><?php echo $tab_tariff; ?></a></li>
						<li><a href="#tab-discount" data-toggle="tab"><?php echo $tab_discount; ?></a></li>
						<li><a href="#tab-package" data-toggle="tab"><?php echo $tab_package; ?></a></li>
						<li><a href="#tab-additional" data-toggle="tab"><?php echo $tab_additional; ?></a></li>
						<li><a href="#tab-empty" data-toggle="tab"><?php echo $tab_empty; ?></a></li>
					</ul>
					<div class="tab-content">
						<div class="tab-pane active" id="tab-general">
							<div class="form-group">
								<label class="col-sm-2 control-label"><?php echo $entry_title; ?></label>
								<div class="col-sm-2">
									<?php foreach ($languages as $language) { ?>
									<div class="input-group"><span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
										<input type="text" name="cdek_title[<?php echo $language['language_id']; ?>]" value="<?php echo isset($cdek_title[$language['language_id']]) ? $cdek_title[$language['language_id']] : ''; ?>"	class="form-control" />
									</div>
									<?php } ?>
								</div>
							</div>
							<div class="form-group">
								<label for="cdek-log" class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_log; ?>"><?php echo $entry_log; ?></span></label>
								<div class="col-sm-1">
									<select id="cdek-log" name="cdek_log" class="form-control">
										<?php foreach($boolean_variables as $key => $variable) { ?>
										<option <?php if ($cdek_log == $key) echo 'selected="selected"'; ?> value="<?php echo $key; ?>"><?php echo $variable; ?></option>
										<?php } ?>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="cdek-status"><?php echo $entry_status ?></label>
								<div class="col-sm-1">
									<select name="cdek_status" id="cdek-status" class="form-control">
										<?php if ($cdek_status) { ?>
										<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
										<option value="0"><?php echo $text_disabled; ?></option>
										<?php } else { ?>
										<option value="1"><?php echo $text_enabled; ?></option>
										<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
										<?php } ?>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>
								<div class="col-sm-1">
									<input type="text" name="cdek_sort_order" value="<?php echo $cdek_sort_order; ?>" id="input-sort-order" class="form-control" />
									<?php if (!empty($error['cdek_sort_order'])) { ?>
									<div class="text-danger"><?php echo $error['cdek_sort_order']; ?></div>
									<?php } ?>
								</div>
							</div>
						</div>
						<div class="tab-pane" id="tab-data">
							<div class="form-group required">
								<label class="col-sm-2 control-label" for="cdek-city-from"><span data-toggle="tooltip" title="<?php echo $help_city_from; ?>"><?php echo $entry_city_from; ?></span></label>
								<div class="col-sm-1">
									<input type="hidden" id="cdek-city-from-id" name="cdek_city_from_id" value="<?php echo $cdek_city_from_id; ?>"/>
									<a class="js city-from"<?php if ($cdek_city_from_id == '') echo ' style="display:none"'; ?>><?php echo $cdek_city_from; ?></a>
									<input type="text" id="cdek-city-from" name="cdek_city_from" value="<?php echo $cdek_city_from; ?>" class="form-control"<?php if ($cdek_city_from_id != '') echo ' style="display:none;"'; ?> />
									<?php if (!empty($error['cdek_city_from'])) { ?>
									<div class="text-danger"><?php echo $error['cdek_city_from']; ?></div>
									<?php } ?>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="cdek-append-day"><?php echo $entry_date_execute; ?></label>
								<div class="col-sm-3">
									<?php echo $text_date_current; ?> + <input type="text" name="cdek_append_day" value="<?php echo $cdek_append_day; ?>" id="cdek-append-day" class="form-control auto m w40" /><?php echo $text_day; ?>
									<?php if (!empty($error['cdek_append_day'])) { ?>
									<div class="text-danger"><?php echo $error['cdek_append_day']; ?></div>
									<?php } ?>
								</div>
							</div>
							<div class="form-group parent">
								<label class="col-sm-2 control-label" for="cdek-default-size"><?php echo $entry_default_size; ?></label>
								<div class="col-sm-1">
									<select id="cdek-default-size" name="cdek_default_size[use]" class="form-control slider">
										<?php foreach($boolean_variables as $key => $variable) { ?>
										<option <?php if (!empty($cdek_default_size['use']) && $cdek_default_size['use'] == $key) echo 'selected="selected"'; ?> value="<?php echo $key; ?>"><?php echo $variable; ?></option>
										<?php } ?>
									</select>
								</div>
							</div>
							<div class="children"<?php if (empty($cdek_default_size['use']) || !$cdek_default_size['use']) echo ' style="display:none;"'; ?>>
								<div class="form-group">
									<label class="col-sm-2 control-label" for="cdek-default-size-type"><?php echo $entry_default_size_type; ?></label>
									<div class="col-sm-1">
										<select class="slider form-control" id="cdek-default-size-type" name="cdek_default_size[type]">
											<?php foreach($size_types as $key => $size_type) { ?>
											<option <?php if (!empty($cdek_default_size['type']) && $cdek_default_size['type'] == $key) echo 'selected="selected"'; ?> value="<?php echo $key; ?>"><?php echo $size_type; ?></option>
											<?php } ?>
										</select>
									</div>
								</div>
								<div class="form-group cdek-default-size volume required" <?php if (!empty($cdek_default_size['type']) && $cdek_default_size['type'] == 'size') echo ' style="display:none"'; ?>>
									<label class="col-sm-2 control-label" for="cdek-default-size-type-volume"><?php echo $entry_volume; ?></label>
									<div class="col-sm-2">
										<input id="cdek-default-size-type-volume" type="text" name="cdek_default_size[volume]" value="<?php if (!empty($cdek_default_size['volume'])) echo $cdek_default_size['volume']; ?>" size="1" class="form-control auto" /> м³
										<?php if (isset($error['cdek_default_size']['volume'])) { ?>
										<div class="text-danger"><?php echo $error['cdek_default_size']['volume']; ?></div>
										<?php } ?>
									</div>
								</div>
								<div class="form-group cdek-default-size size required" <?php if (empty($cdek_default_size['type']) || $cdek_default_size['type'] == 'volume') echo ' style="display:none"'; ?>>
									<label class="cdek-default-size-type-size-a col-sm-2 control-label" for="cdek-default-size-type-size-a"><span data-toggle="tooltip" title="<?php echo $help_size; ?>"><?php echo $entry_size; ?></span></label>
									<div class="col-sm-3">
										<input id="cdek-default-size-type-size-a" type="text" placeholder="<?php echo $text_short_length; ?>" name="cdek_default_size[size_a]" value="<?php if (!empty($cdek_default_size['size_a'])) echo $cdek_default_size['size_a']; ?>" size="2" class="form-control auto m w40" /> x 
										<input type="text" placeholder="<?php echo $text_short_width; ?>" name="cdek_default_size[size_b]" value="<?php if (!empty($cdek_default_size['size_b'])) echo $cdek_default_size['size_b']; ?>" size="2" class="form-control auto m w40"/> x 
										<input type="text" placeholder="<?php echo $text_short_height; ?>" name="cdek_default_size[size_c]" value="<?php if (!empty($cdek_default_size['size_c'])) echo $cdek_default_size['size_c']; ?>" size="2" class="form-control auto m w40"/>
										<?php if (isset($error['cdek_default_size']['size'])) { ?>
										<div class="text-danger"><?php echo $error['cdek_default_size']['size']; ?></div>
										<?php } ?>
									</div>
								</div>
								<div class="form-group">
									<label for="cdek-default-size-work-mode" class="col-sm-2 control-label"><?php echo $entry_default_size_work_mode; ?></label>
									<div class="col-sm-2">
										<select id="cdek-default-size-work-mode" name="cdek_default_size[work_mode]" class="form-control auto">
											<?php foreach($default_work_mode as $key => $mode) { ?>
											<option <?php if (!empty($cdek_default_size['work_mode']) && $cdek_default_size['work_mode'] == $key) echo 'selected="selected"'; ?> value="<?php echo $key; ?>"><?php echo $mode; ?></option>
											<?php } ?>
										</select>
									</div>
								</div>
							</div>
							<div class="form-group parent">
								<label class="col-sm-2 control-label" for="cdek-default-weight"><?php echo $entry_default_weight; ?></label>
								<div class="col-sm-1">
									<select id="cdek-default-weight" name="cdek_default_weight[use]" class="form-control slider">
										<?php foreach($boolean_variables as $key => $variable) { ?>
										<option <?php if (!empty($cdek_default_weight['use']) && $cdek_default_weight['use'] == $key) echo 'selected="selected"'; ?> value="<?php echo $key; ?>"><?php echo $variable; ?></option>
										<?php } ?>
									</select>
								</div>
							</div>
							<div class="children"<?php if (empty($cdek_default_weight['use']) || !$cdek_default_weight['use']) echo ' style="display:none;"'; ?>>
								<div class="form-group required">
									<label for="cdek-default-weight-value" class="col-sm-2 control-label"><?php echo $entry_default_weight; ?></label>
									<div class="col-sm-2">
										<input id="cdek-default-weight-value" type="text" name="cdek_default_weight[value]" value="<?php if (!empty($cdek_default_weight['value'])) echo $cdek_default_weight['value']; ?>" size="1" class="form-control auto" /> кг.
										<?php if (isset($error['cdek_default_weight']['value'])) { ?>
										<div class="text-danger"><?php echo $error['cdek_default_weight']['value']; ?></div>
										<?php } ?>
									</div>
								</div>
								<div class="form-group">
									<label for="cdek-default-weight-work-mode" class="col-sm-2 control-label"><?php echo $entry_default_weight_work_mode; ?></label>
									<div class="col-sm-2">
										<select id="cdek-default-weight-work-mode" name="cdek_default_weight[work_mode]" class="form-control auto">
											<?php foreach($default_work_mode as $key => $mode) { ?>
											<option <?php if (!empty($cdek_default_weight['work_mode']) && $cdek_default_weight['work_mode'] == $key) echo 'selected="selected"'; ?> value="<?php echo $key; ?>"><?php echo $mode; ?></option>
											<?php } ?>
										</select>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label for="cdek-cache-on-delivery" class="col-sm-2 control-label"><?php echo $entry_cache_on_delivery; ?></label>
								<div class="col-sm-1">
									<select id="cdek-cache-on-delivery" name="cdek_cache_on_delivery" class="form-control">
										<?php foreach($boolean_variables as $key => $variable) { ?>
										<option <?php if ($cdek_cache_on_delivery == $key) echo 'selected="selected"'; ?> value="<?php echo $key; ?>"><?php echo $variable; ?></option>
										<?php } ?>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label for="cdek-weight-limit" class="col-sm-2 control-label"><?php echo $entry_weight_limit; ?></label>
								<div class="col-sm-1">
									<select id="cdek-weight-limit" name="cdek_weight_limit" class="form-control">
										<?php foreach($boolean_variables as $key => $variable) { ?>
										<option <?php if ($cdek_weight_limit == $key) echo 'selected="selected"'; ?> value="<?php echo $key; ?>"><?php echo $variable; ?></option>
										<?php } ?>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="cdek-empty-address"><span data-toggle="tooltip" title="<?php echo $help_empty_address; ?>"><?php echo $entry_empty_address; ?></span></label>
								<div class="col-sm-1">
									<select id="cdek-empty-address" name="cdek_empty_address" class="form-control">
										<?php foreach($boolean_variables as $key => $variable) { ?>
										<option <?php if ($cdek_empty_address == $key) echo 'selected="selected"'; ?> value="<?php echo $key; ?>"><?php echo $variable; ?></option>
										<?php } ?>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_use_region; ?>"><?php echo $entry_use_region; ?></span></label>
								<div class="col-sm-10">
									<div class="well well-sm" style="height: 150px; overflow: auto;">
										<?php foreach ($countries as $county) { ?>
										<div class="checkbox">
											<label>
												<input type="checkbox" name="cdek_use_region[]" value="<?php echo $county['country_id']; ?>" <?php  if (in_array($county['country_id'], $cdek_use_region)) echo 'checked="checked"'; ?> />
												<?php echo $county['name']; ?>
											</label>
										</div>
										<?php } ?>
									</div>
									<a onclick="$(this).parent().find(':checkbox').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="cdek-check-ip"><span data-toggle="tooltip" title="<?php echo $help_check_ip; ?>"><?php echo $entry_check_ip; ?></span></label>
								<div class="col-sm-1">
									<select id="cdek-check-ip" name="cdek_check_ip" class="form-control">
										<?php foreach($boolean_variables as $key => $variable) { ?>
										<option <?php if ($cdek_check_ip == $key) echo 'selected="selected"'; ?> value="<?php echo $key; ?>"><?php echo $variable; ?></option>
										<?php } ?>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label for="cdek-tax-class-id" class="col-sm-2 control-label"><?php echo $entry_tax_class; ?></label>
								<div class="col-sm-2">
									<select id="cdek-tax-class-id" name="cdek_tax_class_id" class="form-control">
										<option value="0"><?php echo $text_none; ?></option>
										<?php foreach ($tax_classes as $tax_class) { ?>
										<?php if ($tax_class['tax_class_id'] == $cdek_tax_class_id) { ?>
										<option value="<?php echo $tax_class['tax_class_id']; ?>" selected="selected"><?php echo $tax_class['title']; ?></option>
										<?php } else { ?>
										<option value="<?php echo $tax_class['tax_class_id']; ?>"><?php echo $tax_class['title']; ?></option>
										<?php } ?>
										<?php } ?>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"><?php echo $entry_store; ?></label>
								<div class="col-sm-10">
									<div class="well well-sm" style="height: 150px; overflow: auto;">
										<?php foreach ($stores as $store) { ?>
										<div class="checkbox">
											<label>
												<input type="checkbox" name="cdek_store[]" value="<?php echo $store['store_id']; ?>" <?php if (isset($cdek_store) && in_array($store['store_id'], $cdek_store)) echo 'checked="checked"'; ?> />
												<?php echo $store['name']; ?>
											</label>
										</div>
										<?php } ?>
									</div>
									<a onclick="$(this).parent().find(':checkbox').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a>
								</div>
							</div>
							<div class="form-group required">
								<label class="col-sm-2 control-label" for="cdek-length-class-id"><span data-toggle="tooltip" title="<?php echo $help_length_class; ?>"><?php echo $entry_length_class; ?></span></label>
								<div class="col-sm-2">
									<select id="cdek-length-class-id" name="cdek_length_class_id" class="form-control">
										<?php foreach ($length_classes as $length_class) { ?>
										<option value="<?php echo $length_class['length_class_id']; ?>" <?php if ($length_class['length_class_id'] == $cdek_length_class_id) echo 'selected="selected"'; ?>><?php echo $length_class['title']; ?></option>
										<?php } ?>
									</select>
									<?php if (isset($error['length_class_id'])) { ?>
									<div class="text-danger"><?php echo $error['length_class_id']; ?></div>
									<?php } ?>
								</div>
							</div>
							<div class="form-group required">
								<label class="col-sm-2 control-label" for="cdek-weight-class-id"><span data-toggle="tooltip" title="<?php echo $help_weight_class; ?>"><?php echo $entry_weight_class; ?></span></label>
								<div class="col-sm-2">
									<select id="cdek-weight-class-id" name="cdek_weight_class_id" class="form-control">
										<?php foreach ($weight_classes as $weight_class) { ?>
										<option value="<?php echo $weight_class['weight_class_id']; ?>" <?php if ($weight_class['weight_class_id'] == $cdek_weight_class_id) echo 'selected="selected"'; ?>><?php echo $weight_class['title']; ?></option>
										<?php } ?>
									</select>
									<?php if (isset($error['cdek_weight_class_id'])) { ?>
									<div class="text-danger"><?php echo $error['cdek_weight_class_id']; ?></div>
									<?php } ?>
								</div>
							</div>
						</div>
						<div class="tab-pane" id="tab-auth">
							<?php if (!$cdek_login || !$cdek_password) { ?>
							<p class="help-block"><?php echo $text_help_auth; ?></p>
							<?php } ?>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="cdek-login"><?php echo $entry_login; ?></label>
								<div class="col-sm-3">
									<input type="text" id="cdek-login" class="form-control" name="cdek_login" value="<?php echo $cdek_login; ?>" >
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="cdek-password"><?php echo $entry_password; ?></label>
								<div class="col-sm-3">
									<input type="text" id="cdek-password" class="form-control" name="cdek_password" value="<?php echo $cdek_password; ?>" >
								</div>
							</div>
						</div>
						<div class="tab-pane" id="tab-tariff">
							<div class="form-group required">
								<label class="col-sm-2 control-label" for="cdek-work-mode"><span data-toggle="tooltip" title="<?php echo $help_work_mode; ?>"><?php echo $entry_work_mode; ?></span></label>
								<div class="col-sm-2">
									<select id="cdek-work-mode" name="cdek_work_mode" class="form-control work-mode">
										<?php foreach ($work_mode as $mode_id => $mode_name) { ?>
										<option <?php if ($mode_id == $cdek_work_mode) echo 'selected="selected"'; ?> value="<?php echo $mode_id; ?>"><?php echo $mode_name; ?></option>
										<?php } ?>
									</select>
									<div class="help text-warning attention"<?php if ($cdek_work_mode != 'more') echo ' style="display:none"' ?>><?php echo $text_more_attention; ?></div>
								</div>
							</div>
							<div class="form-group parent">
								<label class="col-sm-2 control-label" for="cdek-show-pvz"><span data-toggle="tooltip" title="<?php echo $help_show_pvz; ?>"><?php echo $entry_show_pvz; ?></span></label>
								<div class="col-sm-1">
									<select id="cdek-show-pvz" name="cdek_show_pvz" class="form-control slider">
										<?php foreach($boolean_variables as $key => $variable) { ?>
										<option <?php if ($cdek_show_pvz == $key) echo 'selected="selected"'; ?> value="<?php echo $key; ?>"><?php echo $variable; ?></option>
										<?php } ?>
									</select>
								</div>
							</div>
							<div class="children"<?php if (!$cdek_show_pvz) echo ' style="display:none"'; ?>>
								<div class="form-group parent">
									<label class="col-sm-2 control-label" for="cdek-view-type"><?php echo $entry_view_type; ?></label>
									<div class="col-sm-2">
										<select name="cdek_view_type" id="cdek-view-type" class="form-control">
											<?php foreach($view_types as $key => $value) { ?>
											<option <?php if ($cdek_view_type == $key) echo 'selected="selected"'; ?> value="<?php echo $key; ?>"><?php echo $value; ?></option>
											<?php } ?>
										</select>
										<div class="help text-warning attention"<?php if ($cdek_view_type == 'default') echo ' style="display:none"' ?>><?php echo $text_view_type_attention; ?></div>
									</div>
								</div>
								<div class="children"<?php if ($cdek_view_type != 'default') echo ' style="display:none"'; ?>>
									<div class="form-group">
										<label class="col-sm-2 control-label" for="cdek-pvz-more-one"><span data-toggle="tooltip" title="<?php echo $help_pvz_more_one; ?>"><?php echo $entry_pvz_more_one; ?></span></label>
										<div class="col-sm-2">
											<select class="form-control" id="cdek-pvz-more-one" name="cdek_pvz_more_one">
												<?php foreach($pvz_more_one_action as $pkey => $variable) { ?>
												<option <?php if ($cdek_pvz_more_one == $pkey) echo 'selected="selected"'; ?> value="<?php echo $pkey; ?>"><?php echo $variable; ?></option>
												<?php } ?>
											</select>
										</div>
									</div>
								</div>
							</div>
							<?php if (isset($error['tariff_list'])) { ?>
							<p class="text-danger tariff_list"><?php echo $error['tariff_list']; ?></p>
							<?php } ?>
							<table class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<td class="text-left" colspan="2"><?php echo $column_tariff; ?></td>
										<td class="text-left"><label class="control-label"><span data-toggle="tooltip" title="<?php echo $help_column_title; ?>"><?php echo $column_title; ?></span></label></td>
										<td class="text-left"><?php echo $column_customer_group; ?></td>
										<td class="text-left"><label class="control-label"><span data-toggle="tooltip" title="<?php echo $help_column_geo_zone; ?>"><?php echo $column_geo_zone; ?></span></label></td>
										<td class="text-left"><?php echo $column_limit; ?></td>
										<td></td>
									</tr>
								</thead>
								<tbody>
									<?php $tariff_row = 0; ?>
									<?php foreach ($cdek_custmer_tariff_list as $tariff_row => $tariff_info) { ?>
									<tr id="tariff-<?php echo $tariff_row; ?>">
										<td class="text-left drag" width="1"><a title="<?php echo $text_drag; ?>">&nbsp;</a></td>
										<td class="text-left">
											<div class="tariff-info">
												<div class="tariff-info__title"><nobr><?php echo $tariff_info['tariff_name']; ?></nobr></div>
												<?php if ($tariff_info['im']) { ?>
												<div class="tariff-info__im help text-warning attention"><?php echo $text_tariff_auth; ?></div>
												<?php } ?>
												<ul class="tariff-info__prop">
													<li><span><?php echo $column_mode; ?></span>: <?php echo $tariff_info['mode']['title']; ?></li>
													<?php if ($tariff_info['weight']) { ?>
													<li><span><?php echo $text_weight; ?></span>: <?php echo $tariff_info['weight']; ?></li>
													<?php } ?>
												</ul>
												<?php if ($tariff_info['note']) { ?>
												<div class="note"><?php echo $tariff_info['note']; ?></div>
												<?php } ?>
											</div>
											<?php if (isset($error['tariff_list_item'][$tariff_row]['exists'])) { ?>
											<span class="error"><?php echo $error['tariff_list_item'][$tariff_row]['exists']; ?></span>
											<?php } ?>
											<input type="hidden" name="cdek_custmer_tariff_list[<?php echo $tariff_row; ?>][sort_order]" value="<?php echo $tariff_info['sort_order']; ?>" class="sort_order" />
											<input type="hidden" name="cdek_custmer_tariff_list[<?php echo $tariff_row; ?>][tariff_id]" value="<?php echo $tariff_info['tariff_id']; ?>" />
											<input type="hidden" name="cdek_custmer_tariff_list[<?php echo $tariff_row; ?>][mode_id]" value="<?php echo $tariff_info['mode_id']; ?>" />
										</td>
										<td class="text-left col-sm-2">
											<?php foreach ($languages as $language) { ?>
												<div class="input-group">
													<span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
													<input type="text" name="cdek_custmer_tariff_list[<?php echo $tariff_row; ?>][title][<?php echo $language['language_id']; ?>]" value="<?php echo (isset($tariff_info['title'][$language['language_id']]) && is_array($tariff_info['title'])) ? $tariff_info['title'][$language['language_id']] : (($language['language_id'] == 1 && is_scalar($tariff_info['title'])) ? $tariff_info['title'] : ''); ?>" class="form-control auto" />
												</div>
											<?php } ?>
										</td>
										<td class="text-left">
											<div class="well well-sm" style="height: 100px; overflow: auto;">
												<?php foreach ($customer_groups as $customer_group) { ?>
												<div class="checkbox">
													<label>
														<input type="checkbox" <?php if (!empty($tariff_info['customer_group_id']) && in_array($customer_group['customer_group_id'], $tariff_info['customer_group_id'])) echo 'checked="checked"'; ?> name="cdek_custmer_tariff_list[<?php echo $tariff_row; ?>][customer_group_id][]" value="<?php echo $customer_group['customer_group_id']; ?>" />
														<?php echo $customer_group['name']; ?>
													</label>
												</div>
												<?php } ?>
											</div>
											<a onclick="$(this).parent().find(':checkbox').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a>
										</td>
										<td class="text-left">
											<div class="well well-sm" style="height: 100px; overflow: auto;">
												<?php foreach ($geo_zones as $geo_zone) { ?>
												<div class="checkbox">
													<label>
														<input type="checkbox" name="cdek_custmer_tariff_list[<?php echo $tariff_row; ?>][geo_zone][]" value="<?php echo $geo_zone['geo_zone_id']; ?>" <?php  if (isset($tariff_info['geo_zone']) && in_array($geo_zone['geo_zone_id'], $tariff_info['geo_zone'])) echo 'checked="checked"'; ?> />
														<?php echo $geo_zone['name']; ?>
													</label>
												</div>
												<?php } ?>
											</div>
											<a onclick="$(this).parent().find(':checkbox').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a>
										</td>
										<td class="text-left">
											<table class="form limit">
												<tbody>
													<tr>
														<td><label for="cdek-custmer-tariff-list-<?php echo $tariff_row; ?>-min-weight"><?php echo $entry_min_weight; ?></label></td>
														<td>
															<input id="cdek-custmer-tariff-list-<?php echo $tariff_row; ?>-min-weight" type="text" name="cdek_custmer_tariff_list[<?php echo $tariff_row; ?>][min_weight]" value="<?php if (isset($tariff_info['min_weight'])) echo $tariff_info['min_weight']; ?>" size="3" class="form-control" />
															<?php if (isset($error['tariff_list_item'][$tariff_row]['min_weight'])) { ?>
															<span class="error"><?php echo $error['tariff_list_item'][$tariff_row]['min_weight']; ?></span>
															<?php } ?>
														</td>
													</tr>
													<tr>
														<td><label for="cdek-custmer-tariff-list-<?php echo $tariff_row; ?>-max-weight"><?php echo $entry_max_weight; ?></label></td>
														<td>
															<input id="cdek-custmer-tariff-list-<?php echo $tariff_row; ?>-max-weight" type="text" name="cdek_custmer_tariff_list[<?php echo $tariff_row; ?>][max_weight]" value="<?php if (isset($tariff_info['max_weight'])) echo $tariff_info['max_weight']; ?>" size="3" class="form-control" />
															<?php if (isset($error['tariff_list_item'][$tariff_row]['max_weight'])) { ?>
															<span class="error"><?php echo $error['tariff_list_item'][$tariff_row]['max_weight']; ?></span>
															<?php } ?>
														</td>
													</tr>
													<tr>
														<td><label for="cdek-custmer-tariff-list-<?php echo $tariff_row; ?>-min-total"><?php echo $entry_min_total; ?></label></td>
														<td>
															<input id="cdek-custmer-tariff-list-<?php echo $tariff_row; ?>-min-total" type="text" name="cdek_custmer_tariff_list[<?php echo $tariff_row; ?>][min_total]" value="<?php if (isset($tariff_info['min_total'])) echo $tariff_info['min_total']; ?>" size="3" class="form-control" />
															<?php if (isset($error['tariff_list_item'][$tariff_row]['min_total'])) { ?>
															<span class="error"><?php echo $error['tariff_list_item'][$tariff_row]['min_total']; ?></span>
															<?php } ?>
														</td>
													</tr>
													<tr class="last">
														<td><label for="cdek-custmer-tariff-list-<?php echo $tariff_row; ?>-max-total"><?php echo $entry_max_total; ?></label></td>
														<td>
															<input id="cdek-custmer-tariff-list-<?php echo $tariff_row; ?>-max-total" type="text" name="cdek_custmer_tariff_list[<?php echo $tariff_row; ?>][max_total]" value="<?php if (isset($tariff_info['max_total'])) echo $tariff_info['max_total']; ?>" size="3" class="form-control" />
															<?php if (isset($error['tariff_list_item'][$tariff_row]['max_total'])) { ?>
															<span class="error"><?php echo $error['tariff_list_item'][$tariff_row]['max_total']; ?></span>
															<?php } ?>
														</td>
													</tr>
												</tbody>
											</table>
										</td>
										<td class="text-left">
											<button type="button" data-toggle="tooltip" class="btn btn-danger" onclick="removeTariff(<?php echo $tariff_row; ?>);" title="<?php echo $button_remove; ?>"><i class="fa fa-trash-o"></i></button>
										</td>
									</tr>
									<?php $tariff_row++; ?>
									<?php } ?>
								</tbody>
								<tfoot>
									<tr>
										<td colspan="7" class="text-left">
											<div class="form-group">
												<div class="col-sm-4">
													<?php echo $text_tariff; ?> 
													<select class="cdek-tariff form-control auto">
														<option value="0"><?php echo $text_select; ?></option>
														<?php foreach ($tariff_list as $group_info) { ?>
														<optgroup label="<?php echo $group_info['title']; ?>">
															<?php foreach ($group_info['list'] as $tariff_id => $tariff_info) { ?>
															<option data-mode="<?php echo $tariff_info['mode_id']; ?>" value="<?php echo $tariff_id; ?>"><?php echo $tariff_info['title_full'] . (isset($tariff_info['im']) ? ' ***' : ''); ?></option>
															<?php } ?>
														</optgroup>
														<?php } ?>
													</select>
												</div>
											</div>
											<p class="help-block"><?php echo $text_help_im; ?></p>
										</td>
									</tr>
								</tfoot>
							</table>
						</div>
						<div class="tab-pane" id="tab-discount">
							<p class="help"><?php echo $text_discount_help; ?></p>
							<table class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<td class="text-left required"><label class="control-label""><span data-toggle="tooltip" title="<?php echo $help_column_total; ?>"><?php echo $column_total; ?></span></label></td>
										<td class="text-left"><?php echo $column_tariff; ?></td>	
										<td class="text-left"><?php echo $column_tax_class; ?></td>
										<td class="text-left"><?php echo $column_customer_group; ?></td>
										<td class="text-left"><label class="control-label"><span data-toggle="tooltip" title="<?php echo $help_discount_column_geo_zone; ?>"><?php echo $column_geo_zone; ?></span></label></td>
										<td class="text-left"><?php echo $column_discount_value; ?></td>
										<td></td>
									</tr>
								</thead>
								<tbody>
									<?php $discount_row = 0; ?>
									<?php if ($cdek_discounts) { ?>
									<?php foreach ($cdek_discounts as $discount_row => $discount) { ?>
									<tr id="discount-row<?php echo $discount_row; ?>">
										<td class="text-left">
											<input type="text" name="cdek_discounts[<?php echo $discount_row; ?>][total]" value="<?php echo $discount['total']; ?>" class="form-control auto"/>
											<?php if (isset($error['cdek_discounts'][$discount_row]['total'])) { ?>
											<div class="text-danger"><?php echo $error['cdek_discounts'][$discount_row]['total']; ?></div>
											<?php } ?>
										</td>
										<td class="text-left">
											<div class="well well-sm" style="height: 100px; overflow: auto;">
												<?php foreach ($tariff_list as $group_info) { ?>
												<div class="checkbox">
													<label><?php echo $group_info['title']; ?></label>
												</div>
												<?php foreach ($group_info['list'] as $tariff_id => $tariff_info) { ?>
												<div class="checkbox">
													<label>
														<input type="checkbox" <?php if (!empty($discount['tariff_id']) && is_array($discount['tariff_id']) && in_array($tariff_id, $discount['tariff_id'])) echo 'checked="checked"'; ?> name="cdek_discounts[<?php echo $discount_row; ?>][tariff_id][]" value="<?php echo $tariff_id; ?>" />
														<?php echo $tariff_info['title_full']; ?>
													</label>
												</div>
												<?php } ?>
												<?php } ?>
											</div>
											<a onclick="$(this).parent().find(':checkbox').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a>
										</td>
										<td class="text-left">
											<select name="cdek_discounts[<?php echo $discount_row; ?>][tax_class_id]" class="form-control">
												<option value="0"><?php echo $text_none; ?></option>
												<?php foreach ($tax_classes as $tax_class) { ?>
												<option <?php if ($tax_class['tax_class_id'] == $discount['tax_class_id']) echo 'selected="selected"'; ?> value="<?php echo $tax_class['tax_class_id']; ?>"><?php echo $tax_class['title']; ?></option>
												<?php } ?>
											</select>
										</td>
										<td class="text-left">
											<div class="well well-sm" style="height: 100px; overflow: auto;">
												<?php foreach ($customer_groups as $customer_group) { ?>
												<div class="checkbox">
													<label>
														<input type="checkbox" <?php if (!empty($discount['customer_group_id']) && in_array($customer_group['customer_group_id'], $discount['customer_group_id'])) echo 'checked="checked"'; ?> name="cdek_discounts[<?php echo $discount_row; ?>][customer_group_id][]" value="<?php echo $customer_group['customer_group_id']; ?>" />
														<?php echo $customer_group['name']; ?>
													</label>
												</div>
												<?php } ?>
											</div>
											<a onclick="$(this).parent().find(':checkbox').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a>
										</td>
										<td class="text-left">
											<div class="well well-sm" style="height: 100px; overflow: auto;">
												<?php foreach ($geo_zones as $geo_zone) { ?>
												<div class="checkbox">
													<label>
														<input type="checkbox" name="cdek_discounts[<?php echo $discount_row; ?>][geo_zone][]" value="<?php echo $geo_zone['geo_zone_id']; ?>" <?php  if (!empty($discount['geo_zone']) && in_array($geo_zone['geo_zone_id'], $discount['geo_zone'])) echo 'checked="checked"'; ?> />
														<?php echo $geo_zone['name']; ?>
													</label>
												</div>
												<?php } ?>
											</div>
											<a onclick="$(this).parent().find(':checkbox').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a>
										</td>
										<td class="text-left">
											<nobr>
												<select name="cdek_discounts[<?php echo $discount_row; ?>][prefix]" class="form-control auto m">
													<?php foreach (array('-', '+') as $prefix) { ?>
													<option <?php if ($prefix == $discount['prefix']) echo 'selected="selected"'; ?> value="<?php echo $prefix; ?>"><?php echo $prefix; ?></option>
													<?php } ?>
												</select>
												<input type="text" name="cdek_discounts[<?php echo $discount_row; ?>][value]" value="<?php echo $discount['value']; ?>" class="form-control auto m w40" />
												<select name="cdek_discounts[<?php echo $discount_row; ?>][mode]" class="form-control auto">
													<?php foreach ($discount_type as $type => $name) { ?>
													<option <?php if ($type == $discount['mode']) echo 'selected="selected"'; ?> value="<?php echo $type; ?>"><?php echo $name; ?></option>
													<?php } ?>
												</select>
											</nobr>
											<?php if (isset($error['cdek_discounts'][$discount_row]['value'])) { ?>
											<div class="text-danger"><?php echo $error['cdek_discounts'][$discount_row]['value']; ?></div>
											<?php } ?>
										</td>
										<td class="text-left">
											<button type="button" onclick="$('#discount-row<?php echo $discount_row; ?>').remove();return FALSE;" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button>
										</td>
									</tr>
									<?php } ?>
									<?php $discount_row++; ?>
									<?php } ?>
								</tbody>
								<tfoot>
									<tr>
										<td colspan="6"></td>
										<td class="text-left">
											<button type="button" onclick="addDiscount();" data-toggle="tooltip" title="<?php echo $button_add_discount; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button>
										</td>
									</tr>
								</tfoot>
							</table>
						</div>
						<div class="tab-pane" id="tab-package">
							<div class="form-group">
								<label class="col-sm-2 control-label" for="cdek-packing-min-weight"><?php echo $entry_packing_min_weight; ?></label>
								<div class="col-sm-3">
									<input id="cdek-packing-min-weight" type="text" name="cdek_packing_min_weight" value="<?php echo $cdek_packing_min_weight; ?>" class="form-control auto m w40" />
									<select name="cdek_packing_weight_class_id" class="form-control auto">
										<?php foreach ($weight_classes as $weight_class) { ?>
										<option value="<?php echo $weight_class['weight_class_id']; ?>" <?php if ($weight_class['weight_class_id'] == $cdek_packing_weight_class_id) echo 'selected="selected"'; ?>><?php echo $weight_class['title']; ?></option>
										<?php } ?>
									</select>
									<?php if (isset($error['cdek_packing_min_weight'])) { ?>
									<div class="text-danger"><?php echo $error['cdek_packing_min_weight']; ?></div>
									<?php } ?>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="cdek-packing-value"><span data-toggle="tooltip" title="<?php echo $help_packing_additional_weight; ?>"><?php echo $entry_packing_additional_weight; ?></span></label>
								<div class="col-sm-3">
									<select name="cdek_packing_prefix" class="form-control auto m">
										<?php foreach (array('+', '-') as $prefix) { ?>
										<option <?php if ($prefix == $cdek_packing_prefix) echo 'selected="selected"'; ?> value="<?php echo $prefix; ?>"><?php echo $prefix; ?></option>
										<?php } ?>
									</select>
									<input id="cdek-packing-value" type="text" name="cdek_packing_value" value="<?php echo $cdek_packing_value; ?>" class="form-control auto m w40" />
									<select name="cdek_packing_mode" class="form-control auto">
										<?php foreach($additional_weight_mode as $key => $value) { ?>
										<option <?php if ($cdek_packing_mode == $key) echo 'selected="selected"'; ?> value="<?php echo $key; ?>"><?php echo $value; ?></option>
										<?php } ?>
									</select>
									<?php if (isset($error['cdek_packing_value'])) { ?>
									<div class="text-danger"><?php echo $error['cdek_packing_value']; ?></div>
									<?php } ?>
								</div>
							</div>
						</div>
						<div class="tab-pane" id="tab-additional">
							<div class="form-group">
								<label class="col-sm-2 control-label" for="cdek-more-days"><?php echo $entry_more_days; ?></label>
								<div class="col-sm-3">
									 + <input id="cdek-more-days" type="text" name="cdek_more_days" value="<?php echo $cdek_more_days; ?>" class="form-control auto m w40" /> <?php echo $text_day; ?>
									<?php if (isset($error['cdek_more_days'])) { ?>
									<div class="text-danger"><?php echo $error['cdek_more_days']; ?></div>
									<?php } ?>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="cdek-period"><?php echo $entry_period; ?></label>
								<div class="col-sm-1">
									<select id="cdek-period" name="cdek_period" class="form-control">
										<?php foreach($boolean_variables as $key => $variable) { ?>
										<option <?php if ($cdek_period == $key) echo 'selected="selected"'; ?> value="<?php echo $key; ?>"><?php echo $variable; ?></option>
										<?php } ?>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="cdek-delivery-data"><?php echo $entry_delivery_data; ?></label>
								<div class="col-sm-1">
									<select id="cdek-delivery-data" name="cdek_delivery_data" class="form-control">
										<?php foreach($boolean_variables as $key => $variable) { ?>
										<option <?php if ($cdek_delivery_data == $key) echo 'selected="selected"'; ?> value="<?php echo $key; ?>"><?php echo $variable; ?></option>
										<?php } ?>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="cdek-insurance"><span data-toggle="tooltip" title="<?php echo $help_insurance; ?>"><?php echo $entry_insurance; ?></span></label>
								<div class="col-sm-1">
									<select id="cdek-insurance" name="cdek_insurance" class="form-control">
										<?php foreach($boolean_variables as $key => $variable) { ?>
										<option <?php if ($cdek_insurance == $key) echo 'selected="selected"'; ?> value="<?php echo $key; ?>"><?php echo $variable; ?></option>
										<?php } ?>
									</select>
								</div>
							</div>


							<div class="form-group parent">
								<label class="col-sm-2 control-label" for="cdek-rounding"><?php echo $entry_rounding; ?></label>
								<div class="col-sm-1">
									<select id="cdek-rounding" name="cdek_rounding" class="form-control slider">
										<?php foreach($boolean_variables as $key => $variable) { ?>
										<option <?php if ($cdek_rounding == $key) echo 'selected="selected"'; ?> value="<?php echo $key; ?>"><?php echo $variable; ?></option>
										<?php } ?>
									</select>
								</div>
							</div>
							<div class="children"<?php if (!$cdek_rounding) echo ' style="display:none;"'; ?>>
								<div class="form-group">
									<label class="col-sm-2 control-label" for="cdek-rounding-type"><?php echo $entry_rounding_type; ?></label>
									<div class="col-sm-2">
										<select id="cdek-rounding-type" class="form-control" name="cdek_rounding_type">
											<?php foreach($rounding_types as $key => $value) { ?>
											<option <?php if ($cdek_rounding_type == $key) echo 'selected="selected"'; ?> value="<?php echo $key; ?>"><?php echo $value; ?></option>
											<?php } ?>
										</select>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="cdek-min-weight"><span data-toggle="tooltip" title="<?php echo $help_min_weight; ?>"><?php echo $entry_min_weight; ?></span></label>
								<div class="col-sm-1">
									<input id="cdek-min-weight" type="text" name="cdek_min_weight" value="<?php echo $cdek_min_weight; ?>" class="form-control" />
									<?php if (!empty($error['cdek_min_weight'])) { ?>
									<div class="text-danger"><?php echo $error['cdek_min_weight']; ?></div>
									<?php } ?>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="cdek-max-weight"><span data-toggle="tooltip" title="<?php echo $help_max_weight; ?>"><?php echo $entry_max_weight; ?></span></label>
								<div class="col-sm-1">
									<input id="cdek-max-weight" type="text" name="cdek_max_weight" value="<?php echo $cdek_max_weight; ?>" class="form-control" />
									<?php if (!empty($error['cdek_max_weight'])) { ?>
									<div class="text-danger"><?php echo $error['cdek_max_weight']; ?></div>
									<?php } ?>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="cdek-min-total"><span data-toggle="tooltip" title="<?php echo $help_min_total; ?>"><?php echo $entry_min_total; ?></span></label>
								<div class="col-sm-1">
									<input id="cdek-min-total" type="text" name="cdek_min_total" value="<?php echo $cdek_min_total; ?>" class="form-control" />
									<?php if (!empty($error['cdek_min_total'])) { ?>
									<div class="text-danger"><?php echo $error['cdek_min_total']; ?></div>
									<?php } ?>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="cdek-max-total"><span data-toggle="tooltip" title="<?php echo $help_max_total; ?>"><?php echo $entry_max_total; ?></span></label>
								<div class="col-sm-1">
									<input id="cdek-max-total" type="text" name="cdek_max_total" value="<?php echo $cdek_max_total; ?>" class="form-control" />
									<?php if (!empty($error['cdek_max_total'])) { ?>
									<div class="text-danger"><?php echo $error['cdek_max_total']; ?></div>
									<?php } ?>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="cdek-city-ignore"><span data-toggle="tooltip" title="<?php echo $help_city_ignore; ?>"><?php echo $entry_city_ignore; ?></span></label>
								<div class="col-sm-3">
									<textarea id="cdek-city-ignore" name="cdek_city_ignore" rows="4" cols="50" class="form-control"><?php echo $cdek_city_ignore; ?></textarea>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="cdek-pvz-ignore"><span data-toggle="tooltip" title="<?php echo $help_pvz_ignore; ?>"><?php echo $entry_pvz_ignore; ?></span></label>
								<div class="col-sm-3">
									<textarea id="cdek-pvz-ignore" name="cdek_pvz_ignore" rows="4" cols="50" class="form-control"><?php echo $cdek_pvz_ignore; ?></textarea>
								</div>
							</div>
						</div>
						<div class="tab-pane" id="tab-empty">
							<div class="form-group parent">
								<label class="col-sm-2 control-label" for="cdek-empty"><?php echo $entry_empty; ?></label>
								<div class="col-sm-1">
									<select id="cdek-empty" name="cdek_empty[use]" class="form-control slider">
										<?php foreach($boolean_variables as $key => $variable) { ?>
										<option <?php if (!empty($cdek_empty['use']) && $cdek_empty['use'] == $key) echo 'selected="selected"'; ?> value="<?php echo $key; ?>"><?php echo $variable; ?></option>
										<?php } ?>
									</select>
								</div>
							</div>
							<div class="children"<?php if (empty($cdek_empty['use']) || !$cdek_empty['use']) echo ' style="display:none;"'; ?>>
								<div class="form-group">
									<label class="col-sm-2 control-label"><?php echo $entry_title; ?></label>
									<div class="col-sm-2">
										<?php foreach ($languages as $language) { ?>
										<div class="input-group"><span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
											<input type="text" name="cdek_empty[title][<?php echo $language['language_id']; ?>]" value="<?php echo isset($cdek_empty['title'][$language['language_id']]) ? $cdek_empty['title'][$language['language_id']] : ''; ?>"	class="form-control" />
										</div>
										<?php } ?>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label" for="cdek-empty-cost"><span data-toggle="tooltip" title="<?php echo $help_empty_cost; ?>"><?php echo $entry_empty_cost; ?></span></label>
									<div class="col-sm-1">
										<input type="text" name="cdek_empty[cost]" value="<?php if (!empty($cdek_empty['cost'])) echo $cdek_empty['cost']; ?>" id="cdek-empty-cost" class="form-control" />
										<?php if (!empty($error['cdek_empty']['cost'])) { ?>
										<div class="text-danger"><?php echo $error['cdek_empty']['cost']; ?></div>
										<?php } ?>
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript"><!--

$('.btn-primary.apple').click(function(){
	$('#form-cdek').attr('action', $('#form-cdek').attr('action') + '&redirect=false');
});

$("#cdek-city-from").autocomplete({
	source: function(request,response) {
	  $.ajax({
		url: "//api.cdek.ru/city/getListByTerm/jsonp.php?callback=?",
		dataType: "jsonp",
		data: {
			q: function () { return $("#cdek-city-from").val() },
			name_startsWith: function () { return $("#cdek-city-from").val() }
		},
		success: function(data) {
		  response($.map(data.geonames, function(item) {
			return {
			  label: item.name,
			  value: item.name,
			  id: item.id
			}
		  }));
		}
	  });
	},
	minLength: 1,
	select: function(ui) {
		
		$('#cdek-city-from-id').parent().find('.error').remove();
		$('#cdek-city-from-id').val(ui.id);
		$("#cdek-city-from").val(ui.label);
		$('.js.city-from').text(ui.label).show();
		$("#cdek-city-from").hide();
	}
});

$('.js.city-from').click(function(){
	 $("#cdek-city-from").show().focus().trigger('keydown');
	 $(this).hide();
});

$("#cdek-city-from").blur(function(){
	if ($('#cdek-city-from-id').val() != '') {
		$('.js.city-from').show();
		$(this).hide();
	}
});

$("#cdek-city-from").change(function(){
	$('#cdek-city-from-id').val('');
});

$('.slider').change(function(event){
	$(this).closest('.form-group.parent').next('.children').slideToggle('fast');
});

$('#cdek-default-size-type').change(function(event){
	
	var type = $(this).val();
	
	$('.cdek-default-size').hide();
	
	if (type == 'volume') {
		$('.cdek-default-size.volume').show();
	} else {
		$('.cdek-default-size.size').show();
	}
	
});

$('#cdek-view-type').change(function(){

	if ('default' == $(this).val()) {
		$(this).next('.attention').hide();
		$(this).closest('.form-group.parent').next('.children').show('fast');
	} else {
		$(this).next('.attention').show();
		$(this).closest('.form-group.parent').next('.children').hide('fast');
	}

});

$('select.work-mode').change(function(){
	$(this).next('.attention').toggle();
});

var tariff_list = [];

<?php foreach ($tariff_list as $group_info) { ?>
<?php foreach ($group_info['list'] as $tariff_id => $tariff_info) { ?>
tariff_list[<?php echo $tariff_id ?>] = {
	'tariff_id': <?php echo $tariff_id ?>,
	'title': '<?php echo $tariff_info['title'] . (isset($tariff_info['im']) ? ' ***' : ''); ?>',
	'im': <?php echo (int)isset($tariff_info['im']); ?>,
	'mode_id': <?php echo $tariff_info['mode_id']; ?>,
	'mode': '<?php echo $tariff_info['mode']['title']; ?>',
	'weight': '<?php if ($tariff_info['weight']) echo $tariff_info['weight']; ?>',
	'note': '<?php echo $tariff_info['note']; ?>'
};
<?php } ?>
<?php } ?>

addTableDnD($('#tab-tariff .table'));

var tariff_row = <?php echo (int)$tariff_row; ?>;

$('.cdek-tariff').change(function(event){

	event.preventDefault();

	var tariff_id = $(this).val();
	var tariff_info = tariff_list[tariff_id];

	if (tariff_id == 0) return;

	var parent = $('#tab-tariff');

	var option = $('select.cdek-tariff option[value=' + tariff_id + ']', parent);

	var sort_order = 0;

	$('table.list tr', parent).each(function(){

		var order = $('input.sort_order', this).val();

		if (order > sort_order) {
			sort_order = order;
		}

	});

	sort_order++;
	
	var html = '<tr id="tariff-' + tariff_row + '">';
	html += '		<td class="text-left drag" width="1"><a title="<?php echo $text_drag; ?>">&nbsp;</a></td>';
	html += '		<td class="text-left">';
	html += '			<div class="tariff-info">';
	html += '				<div class="tariff-info__title"><nobr>' + tariff_info.title + '</nobr></div>';

	if (tariff_info.im) {
		html += '				<div class="tariff-info__im help text-warning attention"><?php echo $text_tariff_auth; ?></div>';
	}

	html += '				<ul class="tariff-info__prop">';
	html += '					<li><span><?php echo $column_mode; ?></span>: ' + tariff_info.mode + '</li>';

	if (tariff_info.weight) {
		html += '				<li><span><?php echo $text_weight; ?></span>: ' + tariff_info.weight + '</li>';
	}

	html += '				</ul>';

	if (tariff_info.note != '') {
		html += '<div class="note">' + tariff_info.note + '</div>';
	}

	html += '			</div>';
	html += '			<input class="sort_order" type="hidden" name="cdek_custmer_tariff_list[' + tariff_row + '][sort_order]" value="' + sort_order + '" />';
	html += '			<input type="hidden" name="cdek_custmer_tariff_list[' + tariff_row + '][tariff_id]" value="' + tariff_id + '" />';
	html += '			<input type="hidden" name="cdek_custmer_tariff_list[' + tariff_row + '][mode_id]" value="' + tariff_info.mode_id + '" />';
	'</td>';
	html += '		<td class="text-left col-sm-2">';
	<?php foreach ($languages as $language) { ?>
	html += '			<div class="input-group"><span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>';
	html += '			<input type="text" name="cdek_custmer_tariff_list[' + tariff_row + '][title][<?php echo $language['language_id']; ?>]" value="" class="form-control auto" /></div>';
	<?php } ?>
	html += '		</td>';
	html += '		<td class="text-left">';
	html += '			<div class="well well-sm" style="height: 100px; overflow: auto;">';
	<?php foreach ($customer_groups as $customer_group) { ?>
	html += '				<div class="checkbox">';
	html += '					<label>';
	html += '						<input type="checkbox" name="cdek_custmer_tariff_list[' + tariff_row + '][customer_group_id][]" value="<?php echo $customer_group['customer_group_id']; ?>" />';
	html += '						<?php echo $customer_group['name']; ?>';
	html += '					</label>';
	html += '				</div>';
	<?php } ?>
	html += '			</div>';
	html += '			<a onclick="$(this).parent().find(\':checkbox\').prop(\'checked\', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(\':checkbox\').prop(\'checked\', false);"><?php echo $text_unselect_all; ?></a>';
	html += '		</td>';
	html += '		<td class="text-left">';
	html += '			<div class="well well-sm" style="height: 100px; overflow: auto;">';
	<?php foreach ($geo_zones as $geo_zone) { ?>
	html += '				<div class="checkbox">';
	html += '					<label>';
	html += '						<input type="checkbox" name="cdek_custmer_tariff_list[' + tariff_row + '][geo_zone][]" value="<?php echo $geo_zone['geo_zone_id']; ?>" />';
	html += '						<?php echo $geo_zone['name']; ?>';
	html += '					</label>';
	html += '				</div>';
	<?php } ?>
	html += '			</div>';
	html += '			<a onclick="$(this).parent().find(\':checkbox\').prop(\'checked\', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(\':checkbox\').prop(\'checked\', false);"><?php echo $text_unselect_all; ?></a>';
	html += '		</td>';
	html += '		<td class="text-left">';
	html += '			<table class="form limit">';
	html += '				<tbody>';
	html += '					<tr>';
	html += '						<td><label for="cdek-custmer-tariff-list-' + tariff_row + '-min-weight"><?php echo $entry_min_weight; ?></label></td>';
	html += '						<td><input id="cdek-custmer-tariff-list-' + tariff_row + '-min-weight" type="text" name="cdek_custmer_tariff_list[' + tariff_row + '][min_weight]" value="" size="3" class="form-control" /></td>';
	html += '					</tr>';
	html += '					<tr>';
	html += '						<td><label for="cdek-custmer-tariff-list-' + tariff_row + '-max-weight"><?php echo $entry_max_weight; ?></label></td>';
	html += '						<td><input id="cdek-custmer-tariff-list-' + tariff_row + '-max-weight" type="text" name="cdek_custmer_tariff_list[' + tariff_row + '][max_weight]" value="" size="3" class="form-control" /></td>';
	html += '					</tr>';
	html += '					<tr>';
	html += '						<td><label for="cdek-custmer-tariff-list-' + tariff_row + '-min-total"><?php echo $entry_min_total; ?></label></td>';
	html += '						<td><input id="cdek-custmer-tariff-list-' + tariff_row + '-min-total" type="text" name="cdek_custmer_tariff_list[' + tariff_row + '][min_total]" value="" size="3" class="form-control" /></td>';
	html += '					</tr>';
	html += '					<tr class="last">';
	html += '						<td><label for="cdek-custmer-tariff-list-' + tariff_row + '-max-total"><?php echo $entry_max_total; ?></label></td>';
	html += '						<td><input id="cdek-custmer-tariff-list-' + tariff_row + '-max-total" type="text" name="cdek_custmer_tariff_list[' + tariff_row + '][max_total]" value="" size="3" class="form-control" /></td>';
	html += '					</tr>';
	html += '				</tbody>';
	html += '			</table>';
	html += '		</td>';
	html += '		<td class="text-left"><button type="button" data-toggle="tooltip" title="" class="btn btn-danger" onclick="removeTariff(' + tariff_row + ');" title="<?php echo $button_remove; ?>"><i class="fa fa-trash-o"></i></button></td>';
	html += '</tr>';
	
	$('table.table tbody:first', parent).append(html);
	
	$('select.cdek-tariff option', parent).removeAttr('selected');
	
	addTableDnD($('.table', parent));
	
	tariff_row++;
});

function removeTariff(tariff_row) {
	$('#tariff-' + tariff_row).remove();
	$('select.cdek-tariff option[value=' + tariff_row + ']').show();
}

var discount_row = '<?php echo $discount_row; ?>';

function addDiscount() {
	
	var html = '<tr id="discount-row' + discount_row + '">';
	html += '		<td class="text-left">';
	html += '			<input type="text" name="cdek_discounts[' + discount_row + '][total]" value="" class="form-control auto" />';
	html += '		</td>';
	html += '		<td class="text-left">';
	html += '			<div class="well well-sm" style="height: 100px; overflow: auto;">';
	<?php foreach ($tariff_list as $group_info) { ?>
	html += '				<div class="checkbox">';
	html += '					<label><?php echo $group_info['title']; ?></label>';
	html += '				</div>';
	<?php foreach ($group_info['list'] as $tariff_id => $tariff_info) { ?>
	html += '				<div class="checkbox">';
	html += '					<label>';
	html += '						<input type="checkbox" name="cdek_discounts[' + discount_row + '][tariff_id][]" value="<?php echo $tariff_id; ?>" />';
	html += '						<?php echo $tariff_info['title_full']; ?>';
	html += '					</label>';
	html += '				</div>';
	<?php } ?>
	<?php } ?>
	html += '			</div>';
	html += '			<a onclick="$(this).parent().find(\':checkbox\').prop(\'checked\', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(\':checkbox\').prop(\'checked\', false);"><?php echo $text_unselect_all; ?></a>';
	html += '		</td>';
	html += '		<td class="text-left">';
	html += '			<select name="cdek_discounts[' + discount_row + '][tax_class_id]" class="form-control auto">';
	html += '				<option value="0"><?php echo $text_none; ?></option>';
	<?php foreach ($tax_classes as $tax_class) { ?>
	html += '				<option value="<?php echo $tax_class['tax_class_id']; ?>"><?php echo $tax_class['title']; ?></option>';
	<?php } ?>
	html += '			</select>';
	html += '		</td>';
	html += '		<td class="text-left">';
	html += '			<div class="well well-sm" style="height: 100px; overflow: auto;">';
	<?php foreach ($customer_groups as $customer_group) { ?>
	html += '				<div class="checkbox">';
	html += '					<label>';
	html += '						<input type="checkbox" name="cdek_discounts[' + discount_row + '][customer_group_id][]" value="<?php echo $customer_group['customer_group_id']; ?>" />';
	html += '						<?php echo $customer_group['name']; ?>';
	html += '					</label>';
	html += '				</div>';
	<?php } ?>
	html += '			</div>';
	html += '			<a onclick="$(this).parent().find(\':checkbox\').prop(\'checked\', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(\':checkbox\').prop(\'checked\', false);"><?php echo $text_unselect_all; ?></a>';
	html += '		</td>';
	html += '		<td class="text-left">';
	html += '			<div class="well well-sm" style="height: 100px; overflow: auto;">';
	<?php foreach ($geo_zones as $geo_zone) { ?>
	html += '				<div class="checkbox">';
	html += '					<label>';
	html += '						<input type="checkbox" name="cdek_discounts[' + discount_row + '][geo_zone][]" value="<?php echo $geo_zone['geo_zone_id']; ?>" />';
	html += '						<?php echo $geo_zone['name']; ?>';
	html += '					</label>';
	html += '				</div>';
	<?php } ?>
	html += '			</div>';
	html += '			<a onclick="$(this).parent().find(\':checkbox\').prop(\'checked\', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(\':checkbox\').prop(\'checked\', false);"><?php echo $text_unselect_all; ?></a>';
	html += '		</td>';
	html += '		<td class="text-left">';
	html += '			<select name="cdek_discounts[' + discount_row + '][prefix]" class="form-control auto m">';
	<?php foreach (array('-', '+') as $prefix) { ?>
	html += '				<option value="<?php echo $prefix; ?>"><?php echo $prefix; ?></option>';
	<?php } ?>
	html += '			</select>';
	html += '			<input type="text" name="cdek_discounts[' + discount_row + '][value]" value="" class="form-control auto m w40" />';
	html += '			<select name="cdek_discounts[' + discount_row + '][mode]" class="form-control auto">';
	<?php foreach ($discount_type as $type => $name) { ?>
	html += '				<option value="<?php echo $type; ?>"><?php echo $name; ?></option>';
	<?php } ?>
	html += '			</select>';
	html += '		</td>';
	html += '		<td class="text-left"><button type="button" onclick="$(\'#discount-row' + discount_row + '\').remove();return FALSE;" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
	html += '</tr>';
	
	$('#tab-discount table tbody').append(html);
	
	discount_row++;
}

function addTableDnD(el) {
	$(el).tableDnD({
		onDrop: function(table, row) {
			
			$('tbody tr', table).each(function(){
				$('td input.sort_order', this).val($(this).index());
			});
			
			$(row).addClass('changed').find('td:eq(1)');
			
			var change = $(row).find('td:eq(1)');
			
			if (!$('span.required', change).length) {
				$(change).append(' <span class="required">*</span>');
			}
			
		},
		onDragClass: 'draggable',
		dragHandle: ".drag"
	}).addClass('table-dnd');
}
//--></script> 
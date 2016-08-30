<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<button type="submit" form="form-cod" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
			</div>
			<div class="panel-body">
				<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-cod" class="form-horizontal">
					<ul class="nav nav-tabs">
						<li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
						<li><a href="#tab-additional" data-toggle="tab"><?php echo $tab_additional; ?></a></li>
					</ul>
					<div class="tab-content">
						<div class="tab-pane active" id="tab-general">
							<div class="form-group">
								<label class="col-sm-2 control-label"><?php echo $entry_title; ?></label>
								<div class="col-sm-2">
									<?php foreach ($languages as $language) { ?>
									<div class="input-group"><span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
										<input type="text" name="cod_cdek_title[<?php echo $language['language_id']; ?>]" value="<?php echo isset($cod_cdek_title[$language['language_id']]) ? $cod_cdek_title[$language['language_id']] : ''; ?>"	class="form-control" />
									</div>
									<?php } ?>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="cdek-cache-on-delivery"><span data-toggle="tooltip" title="<?php echo $help_cache_on_delivery; ?>"><?php echo $entry_cache_on_delivery; ?></span></label>
								<div class="col-sm-1">
									<select id="cdek-cache-on-delivery" name="cod_cdek_cache_on_delivery" class="form-control">
										<?php foreach ($boolean_variables as $key => $text) { ?>
										<option value="<?php echo $key; ?>" <?php if ($cod_cdek_cache_on_delivery == $key) echo 'selected="selected"'; ?>><?php echo $text; ?></option>
										<?php } ?>
									</select>
								</div>
							</div>
							<div class="form-group parent">
								<label class="col-sm-2 control-label" for="cod-cdek-view-mode"><?php echo $entry_view_mode; ?></label>
								<div class="col-sm-2">
									<select id="cod-cdek-view-mode" name="cod_cdek_mode" class="form-control slider">
										<?php foreach ($view_mode as $key => $value) { ?>
										<option value="<?php echo $key; ?>" <?php if ($cod_cdek_mode == $key) echo 'selected="selected"'; ?>><?php echo $value; ?></option>
										<?php } ?>
									</select>
								</div>
							</div>
							<div class="children"<?php if ($cod_cdek_mode != 'cdek') echo ' style="display:none;"'; ?>>
								<div class="form-group">
									<label class="col-sm-2 control-label" for="cod-cdek-view-mode-cdek"><?php echo $entry_view_mode_cdek; ?></label>
									<div class="col-sm-2">
										<select id="cod-cdek-view-mode-cdek" name="cod_cdek_mode_cdek" class="form-control">
											<?php foreach ($view_mode_cdek as $key => $value) { ?>
											<option value="<?php echo $key; ?>" <?php if ($cod_cdek_mode_cdek == $key) echo 'selected="selected"'; ?>><?php echo $value; ?></option>
											<?php } ?>
										</select>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-order-status"><?php echo $entry_order_status; ?></label>
								<div class="col-sm-2">
									<select name="cod_cdek_order_status_id" id="input-order-status" class="form-control">
										<?php foreach ($order_statuses as $order_status) { ?>
										<option value="<?php echo $order_status['order_status_id']; ?>" <?php if ($order_status['order_status_id'] == $cod_cdek_order_status_id) echo 'selected="selected"'; ?>><?php echo $order_status['name']; ?></option>
										<?php } ?>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
								<div class="col-sm-2">
									<select id="status" name="cod_cdek_status" class="form-control">
										<?php foreach ($status_variables as $key => $text) { ?>
										<option value="<?php echo $key; ?>" <?php if ($cod_cdek_status == $key) echo 'selected="selected"'; ?>><?php echo $text; ?></option>
										<?php } ?>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="sort-order"><?php echo $entry_sort_order; ?></label>
								<div class="col-sm-1">
									<input id="sort-order" type="text" name="cod_cdek_sort_order" value="<?php echo $cod_cdek_sort_order; ?>" class="form-control" />
									<?php if (isset($error['cod_cdek_sort_order'])) { ?>
									<div class="text-danger"><?php echo $error['cod_cdek_sort_order']; ?></div>
									<?php } ?>
								</div>
							</div>
						</div>
						<div class="tab-pane" id="tab-additional">
							<div class="form-group">
								<label class="col-sm-2 control-label" for="active"><?php echo $entry_active; ?></label>
								<div class="col-sm-2">
									<select id="active" name="cod_cdek_active" class="form-control">
										<?php foreach ($boolean_variables as $key => $text) { ?>
										<option value="<?php echo $key; ?>" <?php if ($cod_cdek_active == $key) echo 'selected="selected"'; ?>><?php echo $text; ?></option>
										<?php } ?>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="cod-cdek-min-total"><span data-toggle="tooltip" title="<?php echo $help_min_total; ?>"><?php echo $entry_min_total; ?></span></label>
								<div class="col-sm-1">
									<input id="cod-cdek-min-total" type="text" name="cod_cdek_min_total" value="<?php echo $cod_cdek_min_total; ?>" class="form-control" />
									<?php if (!empty($error['cod_cdek_min_total'])) { ?>
									<div class="text-danger"><?php echo $error['cod_cdek_min_total']; ?></div>
									<?php } ?>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="cod-cdek-max-total"><span data-toggle="tooltip" title="<?php echo $help_max_total; ?>"><?php echo $entry_max_total; ?></span></label>
								<div class="col-sm-1">
									<input id="cod-cdek-max-total" type="text" name="cod_cdek_max_total" value="<?php echo $cod_cdek_max_total; ?>" class="form-control" />
									<?php if (!empty($error['cod_cdek_max_total'])) { ?>
									<div class="text-danger"><?php echo $error['cod_cdek_max_total']; ?></div>
									<?php } ?>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="cdek-cdek-price-value"><?php echo $entry_price; ?></label>
								<div class="col-sm-3">
									<select name="cod_cdek_price[prefix]" class="form-control auto m">
										<?php foreach (array('-', '+') as $prefix) { ?>
										<option <?php if (!empty($cod_cdek_price) && $cod_cdek_price['prefix'] == $prefix) echo 'selected="selected"'; ?> value="<?php echo $prefix; ?>"><?php echo $prefix; ?></option>
										<?php } ?>
									</select>
									<input id="cdek-cdek-price-value" type="text" name="cod_cdek_price[value]" value="<?php if (!empty($cod_cdek_price)) echo $cod_cdek_price['value']; ?>" class="form-control auto m w40">
									<select name="cod_cdek_price[mode]" class="form-control auto">
										<?php foreach ($discount_type as $type => $name) { ?>
										<option <?php if (!empty($cod_cdek_price) && $cod_cdek_price['mode'] == $type) echo 'selected="selected"'; ?> value="<?php echo $type; ?>"><?php echo $name; ?></option>
										<?php } ?>
									</select>
									<?php if (isset($error['cod_cdek_price']['value'])) { ?>
									<div class="text-danger"><?php echo $error['cod_cdek_price']['value']; ?></div>
									<?php } ?>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"><?php echo $entry_geo_zone; ?></label>
								<div class="col-sm-3">
									<div class="well well-sm" style="height: 100px; overflow: auto;">
										<?php foreach ($geo_zones as $geo_zone) { ?>
										<div class="checkbox">
											<label>
												<input type="checkbox" name="cod_cdek_geo_zone_id[]" value="<?php echo $geo_zone['geo_zone_id']; ?>" <?php if (!empty($cod_cdek_geo_zone_id) && in_array($geo_zone['geo_zone_id'], $cod_cdek_geo_zone_id)) echo 'checked="checked"'; ?> />
												<?php echo $geo_zone['name']; ?>
											</label>
										</div>
										<?php } ?>
									</div>
									<a onclick="$(this).parent().find(':checkbox').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"><?php echo $entry_store; ?></label>
								<div class="col-sm-3">
									<div class="well well-sm" style="height: 100px; overflow: auto;">
										<?php foreach ($stores as $store) { ?>
										<div class="checkbox">
											<label>
												<input type="checkbox" name="cod_cdek_store[]" value="<?php echo $store['store_id']; ?>" <?php if (isset($cod_cdek_store) && in_array($store['store_id'], $cod_cdek_store)) echo 'checked="checked"'; ?> />
												<?php echo $store['name']; ?>
											</label>
										</div>
										<?php } ?>
									</div>
									<a onclick="$(this).parent().find(':checkbox').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label"><?php echo $entry_customer_group; ?></label>
								<div class="col-sm-3">
									<div class="well well-sm" style="height: 100px; overflow: auto;">
										<?php foreach ($customer_groups as $customer_group) { ?>
										<div class="checkbox">
											<label>
												<input type="checkbox" name="cod_cdek_customer_group_id[]" value="<?php echo $customer_group['customer_group_id']; ?>" <?php if (!empty($cod_cdek_customer_group_id) && in_array($customer_group['customer_group_id'], $cod_cdek_customer_group_id)) echo 'checked="checked"'; ?> />
										<?php echo $customer_group['name']; ?>
											</label>
										</div>
										<?php } ?>
									</div>
									<a onclick="$(this).parent().find(':checkbox').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="cod-cdek-city-ignore"><span data-toggle="tooltip" title="<?php echo $help_city_ignore; ?>"><?php echo $entry_city_ignore; ?></span></label>
								<div class="col-sm-3">
									<textarea id="cod-cdek-city-ignore" name="cod_cdek_city_ignore" rows="4" cols="50" class="form-control"><?php echo $cod_cdek_city_ignore; ?></textarea>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	$('.slider').change(function(event){
		$(this).closest('.form-group.parent').next('.children').slideToggle('fast');
	});
</script>
<?php echo $footer; ?> 
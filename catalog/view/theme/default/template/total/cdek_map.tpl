<style type="text/css">
	.cdek-placemark {
		color: #666;
	}
	.cdek-placemark .title {
		font-size: 14px;
		font-weight: 500;
		margin-bottom: 10px;
	}
	.cdek-placemark .popover {
		display: block;
	}
	.cdek-placemark .close {
		position: absolute;
		right: 20px;
		top: 14px;
		font-size: 31px;
		height: 26px;
		text-decoration: none;
		z-index: 999;
	}
	.cdek-placemark .map-info {
		position: absolute;
		box-shadow: 0 5px 15px rgba(0,0,0,.5);
		-webkit-box-shadow: 0 5px 15px rgba(0,0,0,.5);
		border-radius: 6px;
		outline: 0;
		background-color: #fff;
		-webkit-background-clip: padding-box;
	}
	.cdek-placemark .map-info:after {
		content: "";
		position: absolute;
		bottom: -17px;
		left: 28px;
		width: 0;
		height: 0;
		border-left: 12px solid transparent;
		border-right: 12px solid transparent;
		border-top: 18px solid #fff;
	}
	.map-info--body {
		position: relative;
		padding: 20px 35px 15px 15px;
		font-size: 11px;
	}
	.map-info--body__row {
		margin-bottom: 2px;
	}
	.map-info--body__label {
		font-weight: bold;
	}
	.map-info--footer {
		padding: 15px;
		border-top: 1px solid #e5e5e5;
	}
	.cdek-map-container {
		max-width: 600px;
		margin-bottom: 20px;
	}

	.cdek-map-container .col-md-8 {
		height: 100%;
	}
	.list-group-item {
		width: 100% !important;
	}
	.list-group-item.selected {
		font-weight: bold;
	}
	.list-group-item.first {
		border-top-left-radius: 4px;
		border-top-right-radius: 4px;
	}
	.list-group-item.last {
		margin-bottom: 0;
		border-bottom-right-radius: 4px;
		border-bottom-left-radius: 4px;
	}
	.list-group-item span {
		display: none;
	}
	.modal-header .close {
		margin-top: -18px;
	}
	.cdek-map-container .row {
		height: 500px;
	}
	#cdek-map {
		width:100%;
		height:100%;
	}
	.pvz-list .js-link {
		margin-left: 10px;
	}
	.pvz-list .list-group {
		max-height: 415px;
		overflow-y: auto;
	}
	.list-type__main,
	.cdek-search {
		display: none;
	}
	.list-type__mobile {
		display: block;
		margin-bottom: 20px;
	}
	.list-type__mobile .dropdown-menu {
		width: 100%;
	}
	.list-type__mobile .dropdown-menu li a {
		border: 1px solid #DDDDDD;
		padding: 10px 20px;
		margin-bottom: -1px;
		font-size: 12px;
	}
	.list-type__mobile .dropdown-menu li a span.text {
		white-space: initial;
	}
	@media (min-width: 992px) {
		.list-type__main,
		.cdek-search {
			display: block;
		}
		.list-type__mobile {
			display: none !important;
		}
		.cdek-map-container {
			margin-bottom: 0px;
		}
		.cdek-map-container .pvz-list {
			padding-right: 0;
		}
	}
</style>
<div class="cdek-map-container">
	<div class="row">
		<div class="col-md-4 pvz-list">
			<div class="cdek-search">
				<div class="form-group">
					<input type="search" class="cdek-pvz-search form-control" value="" placeholder="Введите адрес..." />
				</div>
			</div>
			<a href="#" data-code="all" class="js-link">Все адреса</a>
			<div class="list-types">
				<div class="list-type__main">
					<div class="list-group">
						<?php foreach ($pvz_list as $pvz_item) { ?>
						<a href="#" data-code="<?php echo $pvz_item['code']; ?>" class="<?php if ($active == $pvz_item['code']) echo 'selected '; ?>list-group-item"><?php echo $pvz_item['name']; ?><span><?php echo $pvz_item['address']; ?></span></a>
						<?php } ?>
					</div>
				</div>
				<div class="list-type__mobile">
					<select name="list_pvz_mobile" data-live-search="true" data-width="100%" class="selectpicker" data-mobile="true">
						<?php foreach ($pvz_list as $pvz_item) { ?>
						<option value="<?php echo $pvz_item['code']; ?>" class="1list-group-item" <?php if ($active == $pvz_item['code']) echo 'selected="selected" '; ?>><?php echo $pvz_item['address']; ?></option>
						<?php } ?>
					</select>
				</div>
			</div>
		</div>
		<div class="col-md-8">
			<div id="cdek-map"></div>
		</div>
	</div>
</div>
<script type="text/javascript">

	$('.cdek-map-container .pvz-list').btsListFilter('.cdek-pvz-search', {
		initial: false,
		resetOnBlur: false,
		cancelNode: function() {
			return '<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>';
		},
		emptyNode: function(data) {
			return '<span class="list-group-item first last">Нет совпадений</span>';
		}
	});

	var markers = [];

	<?php foreach ($pvz_list as $pvz_item) { ?>
		markers.push({
			center: [<?php echo $pvz_item['y']; ?>, <?php echo $pvz_item['x']; ?>],
			name: '<?php echo $pvz_item['name']; ?>',
			address: '<?php echo $pvz_item['address']; ?>',
			code: '<?php echo $pvz_item['code']; ?>',
			active: <?php echo (int)($pvz_item['code'] == $active); ?>,
			phone: '<?php echo $pvz_item['phone']; ?>',
			work_time: '<?php echo $pvz_item['work_time']; ?>',
			tariff_id: <?php echo $tariff_id; ?>
		});
	<?php } ?>
</script>
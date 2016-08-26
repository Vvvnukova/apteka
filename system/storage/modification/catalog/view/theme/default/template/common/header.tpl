<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie8"><![endif]-->
<!--[if IE 9 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<!--<![endif]-->
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title><?php echo $title; if (isset($_GET['page'])) { echo " - ". ((int) $_GET['page'])." ".$text_page;} ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; if (isset($_GET['page'])) { echo " - ". ((int) $_GET['page'])." ".$text_page;} ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content= "<?php echo $keywords; ?>" />
<?php } ?>
<meta property="og:title" content="<?php echo $title; if (isset($_GET['page'])) { echo " - ". ((int) $_GET['page'])." ".$text_page;} ?>" />
<meta property="og:type" content="website" />
<meta property="og:url" content="<?php echo $og_url; ?>" />
<?php if ($og_image) { ?>
<meta property="og:image" content="<?php echo $og_image; ?>" />
<?php } else { ?>
<meta property="og:image" content="<?php echo $logo; ?>" />
<?php } ?>
<meta property="og:site_name" content="<?php echo $name; ?>" />
<script src="catalog/view/javascript/jquery/jquery-2.1.1.min.js" type="text/javascript"></script>
<link href="catalog/view/javascript/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen" />
<script src="catalog/view/javascript/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<link href="catalog/view/javascript/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
<link href="//fonts.googleapis.com/css?family=Open+Sans:400,400i,300,700" rel="stylesheet" type="text/css" />
<link href="catalog/view/theme/default/stylesheet/stylesheet.css" rel="stylesheet">
<?php foreach ($styles as $style) { ?>
<link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<script src="catalog/view/javascript/common.js" type="text/javascript"></script>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<?php foreach ($scripts as $script) { ?>
<script src="<?php echo $script; ?>" type="text/javascript"></script>
<?php } ?>
<?php foreach ($analytics as $analytic) { ?>
<?php echo $analytic; ?>
<?php } ?>
<!--<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<?php include "catalog/view/coloring/coloringpassword.php"; ?>
-->

</head>
<body class="<?php echo $class; ?>">
<nav id="top">
  <div class="container">
    <!--<div class="col-sm-1"><?php echo $currency; ?> </div> -->
    <div class="col-sm-2 col-xs-2">
        <div align="left">
              <script type="text/javascript" src="http://cdn.dev.skype.com/uri/skype-uri.js"></script>
              <a onclick="Skype.tryAnalyzeSkypeUri('call', '0');" href="skype:i.pharmacy?call">
                  <img src="image/catalog/technical/skype.png" height="25" vspace="7" align="absmiddle">
              </a>
        </div>
    </div>
   <!-- <?php echo $language; ?> -->
   <div class="col-sm-10">
    <div id="top-links" class="nav pull-right">
      <ul class="list-inline">
        <li><a href="<?php echo $contact; ?>"><i class="fa fa-phone"></i></a> <span class="hidden-xs hidden-sm hidden-md"><?php echo $telephone; ?></span></li>
        <li class="dropdown"><a href="<?php echo $account; ?>" title="<?php echo $text_account; ?>" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> <span class="hidden-xs hidden-sm hidden-md"><?php echo $text_account; ?></span> <span class="caret"></span></a>
          <ul class="dropdown-menu dropdown-menu-right">
            <?php if ($logged) { ?>
            <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
            <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
            <li><a href="<?php echo $transaction; ?>"><?php echo $text_transaction; ?></a></li>
            <li><a href="<?php echo $download; ?>"><?php echo $text_download; ?></a></li>
            <li><a href="<?php echo $logout; ?>"><?php echo $text_logout; ?></a></li>
            <?php } else { ?>
            <li><a href="<?php echo $register; ?>"><?php echo $text_register; ?></a></li>
            <li><a href="<?php echo $login; ?>"><?php echo $text_login; ?></a></li>
            <?php } ?>
          </ul>
        </li>
        <li><a href="<?php echo $wishlist; ?>" id="wishlist-total" title="<?php echo $text_wishlist; ?>"><i class="fa fa-heart"></i> <span class="hidden-xs hidden-sm hidden-md"><?php echo $text_wishlist; ?></span></a></li>
        <li><a href="<?php echo $shopping_cart; ?>" title="<?php echo $text_shopping_cart; ?>"><i class="fa fa-shopping-cart"></i> <span class="hidden-xs hidden-sm hidden-md"><?php echo $text_shopping_cart; ?></span></a></li>
        <li><a href="<?php echo $checkout; ?>" title="<?php echo $text_checkout; ?>"><i class="fa fa-share"></i> <span class="hidden-xs hidden-sm hidden-md"><?php echo $text_checkout; ?></span></a></li>
      </ul>
    </div>
    </div>
  </div>
</nav>
<header>
<div class = "header-cont">
  <div class="container">
    <div class="row">
      <div class="col-sm-3">
        <div id="logo">
          <?php if ($logo) { ?>
            <?php if ($home == $og_url) { ?>
              <img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" />
            <?php } else { ?>
              <a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" /></a>
            <?php } ?>
          <?php } else { ?>
            <h1><a href="<?php echo $home; ?>"><?php echo $name; ?></a></h1>
          <?php } ?>
        </div>
      </div> 
            <ul class="list-unstyled">
              <li> 
                  <div class="col-sm-4 col-sm-offset-5">
                  <h3 style="margin-top: 0;"><p class="text-right" > 
                   <font color=#31708f>
                    <span class="glyphicon glyphicon glyphicon-phone-alt" aria-hidden="true">
                    </span>
                  </font>
                 <font color=#d43807>
                  <strong>
                      +7(495) 223 8-9-10
                  </strong>
                  </font>
                  </p></h3>
                  </div>
              </li>
              <li>
                    <div class="col-sm-6 col-sm-offset-0">
                    <?php echo $search; ?>
                    </div> 
                    <div class="col-sm-3">
                        <?php echo $cart; ?> 
                    </div>
              </li>
            </ul>  
        
    </div>
    </div>
  </div>

   
</header>

				<?php if($ajaxadvancesearch_status){ ?>
				<!--
				/**
					*Ajax advanced search starts
					*/
				-->
				<script type="text/javascript" language="javascript"><!--
					// Ajax advanced search starts						
					$(document).ready(function(){
					var afaxAdvancedSearch = $('input[name="search"]');
						var customAutocomplete = null;
						afaxAdvancedSearch.autocomplete({
							delay: 500,
							responsea : function (items){
								if (items.length) {
									for (i = 0; i < items.length; i++) {
										this.items[items[i]['value']] = items[i];
									}
								}
								var html='';
								if(items.length){
									$.each(items,function(key,item){
										if(item.product_id!=0){
										html += '<li data-value="' + item['value'] + '"><a href="#">';
										html += '<div class="ajaxadvance">';
										html += '<div class="image">';
											if(item.image){
											html += '<img title="'+item.name+'" src="'+item.image+'"/>';
											}
											html += '</div>';
											html += '<div class="content">';
											html += 	'<h3 class="name">'+item.label+'</h3>';
											if(item.model){
											html += 	'<div class="model">';
											html +=		'<?php echo $ajaxadvancedsearch_model; ?> '+ item.model;
											html +=		'</div>';
											}
											if(item.manufacturer){
											html += 	'<div class="manufacturer">';
											html +=		'<?php echo $ajaxadvancedsearch_manufacturer; ?> '+ item.manufacturer;			
											html +=		'</div>';		
											}
											if(item.price){
											html += 	'<div class="price"> <?php echo $ajaxadvancedsearch_price; ?> ';
												if (!item.special) { 
											html +=			 item.price;
												} else {	
											html +=			'<span class="price-old">'+ item.price +'</span> <span class="price-new">'+ item.special +'</span>';
												}	
											html +=		'</div>';
											}
											if(item.stock_status){
											html += 	'<div class="stock_status">';
											html +=		'<?php echo $ajaxadvancedsearch_stock; ?> '+ item.stock_status;			
											html +=		'</div>';
											}
											if (item.rating) {
											html +=		'<div class="ratings"> <?php echo $ajaxadvancedsearch_rating; ?>';
											for (var i = 1; i <= 5; i++) {
											if (item.rating < i) { 
												html +=		'<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>';
											} else {	
												html +=		'<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>';
											} 
											}
											html +=		'</div>';
											}
											html +='</div>';
											html += '</div></a></li>'
										}
									});
								}	
								if (html) {
									afaxAdvancedSearch.siblings('ul.dropdown-menu').show();
								} else {
									afaxAdvancedSearch.siblings('ul.dropdown-menu').hide();
								}

								$(afaxAdvancedSearch).siblings('ul.dropdown-menu').html(html);
							},
							source: function(request, response) {
							customAutocomplete = this;
								$.ajax({
									url: 'index.php?route=common/header/ajaxLiveSearch&filter_name=' +  encodeURIComponent(request),
									dataType : 'json',
									success : function(json) {
										customAutocomplete.responsea($.map(json, function(item) {
											return {
												label: item.name,
												name: item.name1,
												value: item.product_id,
												model: item.model,
												stock_status: item.stock_status,
												image: item.image,
												manufacturer: item.manufacturer,
												price: item.price,
												special: item.special,
												category: item.category,
												rating: item.rating,
												reviews: item.reviews,
											}
										}));
									}
								});
							},
							select : function (ui){
								return false;
							},
							selecta: function(ui) {
								if(ui.value){
									location = 'index.php?route=product/product/&product_id='+ui.value;
								}else{
								$('#search input[name=\'search\']').parent().find('button').trigger('click');
								}
								return false;
							},
							focus: function(event, ui) {
								return false;
							}
						});
						
						afaxAdvancedSearch.siblings('ul.dropdown-menu').delegate('a', 'click', function(){
							value = $(this).parent().attr('data-value');
							if (value && customAutocomplete.items[value]) {
								customAutocomplete.selecta(customAutocomplete.items[value]);
							}
						});					
					});
					//Ajax advanced search ends
				//--></script>
				<style>
				#search .dropdown-menu {z-index: 666 !important; background: #fff; width: 100%;}
				#search .dropdown-menu li:nth-child(even){background: #FFFFFF;  border: 1px solid #dbdee1;}
				#search .dropdown-menu li:nth-child(odd){background: #E4EEF7;  border: 1px solid #fff;}
				#search .dropdown-menu li, .ui-menu .ui-menu-item { margin-bottom: 10px;}
				#search .dropdown-menu a {border-radius: 0; white-space: normal; }
				#search .ajaxadvance { width: 100%; min-height: <?php echo (int)$ajaxadvancesearch_imageheight+ (int)$ajaxadvancesearch_imageheight*20/100;?>px; }
				#search .ajaxadvance .name { margin:0; }
				#search .ajaxadvance .image { display:inline-flex; float: left; margin-right:10px; width: <?php echo (int)$ajaxadvancesearch_imagewidth;?>px; }
				#search .ajaxadvance .content { display:inline-block;	max-width: 300px;}
				#search .ajaxadvance .content > div { margin-top:5px;	}
				#search .ajaxadvance .price-old {color: #ff0000; text-decoration: line-through; }
				#search .ajaxadvance .highlight {color: #38b0e3; }
				</style>
				<!--
				/**
					*Ajax advanced search ends
					*/
				-->
				<?php } ?>
			
<?php if ($categories) { ?>
<div class="container">
  <nav id="menu" class="navbar">
    <div class="navbar-header"><span id="category" class="visible-xs"><?php echo $text_category; ?></span>
      <button type="button" class="btn btn-navbar navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse"><i class="fa fa-bars"></i></button>
    </div>
    <div class="collapse navbar-collapse navbar-ex1-collapse">
      <ul class="nav navbar-nav">
        <?php foreach ($categories as $category) { ?>
        <?php if ($category['children']) { ?>
        <li class="dropdown"><a href="<?php echo $category['href']; ?>" class="dropdown-toggle" data-toggle="dropdown"><?php echo $category['name']; ?></a>
          <div class="dropdown-menu">
            <div class="dropdown-inner">
              <?php foreach (array_chunk($category['children'], ceil(count($category['children']) / $category['column'])) as $children) { ?>
              <ul class="list-unstyled">
                <?php foreach ($children as $child) { ?>
                <li><a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a></li>
                <?php } ?>
              </ul>
              <?php } ?>
            </div>
            <a href="<?php echo $category['href']; ?>" class="see-all"><?php echo $text_all; ?> <?php echo $category['name']; ?></a> </div>
        </li>
        <?php } else { ?>
        <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
        <?php } ?>
        <?php } ?>
      </ul>
    </div>
  </nav>
</div>
<?php } ?>

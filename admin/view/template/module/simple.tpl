<?php echo $header; ?><?php echo $column_left ?><?php include 'simple_header.tpl' ?>
<link type="text/css" href="/admin/view/stylesheet/simple.css" rel="stylesheet" media="screen" />
<!--[if lte IE 8]>
<script src="view/javascript/json3.min.js" type="text/javascript"></script>
<![endif]-->
<div ng-app="Simple" id="ng-app" ng-controller="simpleMainController">
    <script type="text/javascript">
        var simple = {
          language: {
            list: <?php echo json_encode($languages) ?>,
            current: '<?php echo $current_language ?>',
            helperUrl: '<?php echo $action_language_helper ?>'
          }
        };

        simpleModule.run(
            function($rootScope) {
                $rootScope.actionMain = '<?php echo $action_main ?>';
                $rootScope.token = "<?php echo $token ?>";
                $rootScope.storeUrl = "<?php echo $store_url ?>";
                $rootScope.settings = <?php echo $simple_settings ?>;
                $rootScope.opencartFields = <?php echo $opencart_fields ?>;
                $rootScope.customFields = <?php echo $simple_custom_fields ?>;
                $rootScope.settingsId = 0;
                $rootScope.layouts = <?php echo $layouts ?>;
                $rootScope.paymentMethods = <?php echo empty($payment_methods) ? '{}' : json_encode($payment_methods, JSON_FORCE_OBJECT) ?>;
                $rootScope.shippingMethods = <?php echo empty($shipping_methods) ? '{}' : json_encode($shipping_methods, JSON_FORCE_OBJECT) ?>;
                $rootScope.informationPages = <?php echo empty($information_pages) ? '{}' : json_encode($information_pages) ?>;
                $rootScope.languages = <?php echo json_encode($languages) ?>;
                $rootScope.currentLanguage = "<?php echo $current_language ?>";
                $rootScope.groups = <?php echo json_encode($groups) ?>;
                $rootScope.types = ["text","email","tel","password","textarea","date","time","select","checkbox","radio","captcha","file"];
                $rootScope.textTypes = ["text","email","tel","password","textarea","date","time","captcha"];
                $rootScope.listTypes = ["select","checkbox","radio"];
                $rootScope.typesWithMask = ["text","tel"];
                $rootScope.typesWithValues = ["select","checkbox","radio"];
                $rootScope.typesWithPlaceholder = ["text","email","tel","password","textarea","date","time","captcha"];
                $rootScope.opencartObjects = [
                    {id:"order", label: "<?php echo $l->get('text_object_order'); ?>"},
                    {id:"customer", label: "<?php echo $l->get('text_object_customer'); ?>"},
                    {id:"address", label: "<?php echo $l->get('text_object_address'); ?>"}
                ];
                $rootScope.rulesForTypes = {
                    "notEmpty": $rootScope.types,
                    "byLength": $rootScope.textTypes,
                    "regexp": $rootScope.textTypes,
                    "api": $rootScope.types,
                    "equal": $rootScope.types
                };
                $rootScope.saving = false;
                $rootScope.alerts = [];
                $rootScope.blocks = {
                  "cart": {
                    id: "cart",
                    label: "<?php echo $l->get('text_block_cart') ?>",
                    used: {"0":false},
                    required: false,
                    useHideOptions: true,
                    hasOwnHeader: true
                  },
                  "customer": {
                    id: "customer",
                    label: "<?php echo $l->get('text_block_customer') ?>",
                    used: {"0":false},
                    required: false,
                    useHideOptions: true,
                    hasOwnHeader: true
                  },
                  "payment_address": {
                    id: "payment_address",
                    label: "<?php echo $l->get('text_block_payment_address') ?>",
                    used: {"0":false},
                    required: false,
                    useHideOptions: true,
                    hasOwnHeader: true
                  },
                  "shipping_address": {
                    id: "shipping_address",
                    label: "<?php echo $l->get('text_block_shipping_address') ?>",
                    used: {"0":false},
                    required: false,
                    useHideOptions: true,
                    hasOwnHeader: true
                  },
                  "payment": {
                    id: "payment",
                    label: "<?php echo $l->get('text_block_payment') ?>",
                    used: {"0":false},
                    required: false,
                    useHideOptions: true,
                    hasOwnHeader: true
                  },
                  "shipping": {
                    id: "shipping",
                    label: "<?php echo $l->get('text_block_shipping') ?>",
                    used: {"0":false},
                    required: false,
                    useHideOptions: true,
                    hasOwnHeader: true
                  },
                  "help": {
                    id: "help",
                    label: "<?php echo $l->get('text_block_help') ?>",
                    used: {"0":false},
                    required: false,
                    useHideOptions: false,
                    hasOwnHeader: true
                  },
                  "agreement": {
                    id: "agreement",
                    label: "<?php echo $l->get('text_block_agreement') ?>",
                    used: {"0":false},
                    required: false,
                    useHideOptions: false,
                    hasOwnHeader: true
                  },
                  "comment": {
                    id: "comment",
                    label: "<?php echo $l->get('text_block_comment') ?>",
                    used: {"0":false},
                    required: false,
                    useHideOptions: false,
                    hasOwnHeader: true
                  },
                  "summary": {
                    id: "summary",
                    label: "<?php echo $l->get('text_block_summary')  ?>",
                    used: {"0":false},
                    required: false,
                    useHideOptions: false,
                    hasOwnHeader: true
                  },
                  "payment_form": {
                    id: "payment_form",
                    label: "<?php echo $l->get('text_block_payment_form') ?>",
                    used: {"0":false},
                    required: true,
                    useHideOptions: false,
                    hasOwnHeader: false
                  }
                };
                $rootScope.columns = {
                  "two": {
                    id: "two",
                    label: "<?php echo $l->get('text_two_columns') ?>"
                  },
                  "three": {
                    id: "three",
                    label: "<?php echo $l->get('text_three_columns') ?>"
                  }
                };
                $rootScope.errors = {
                  "blocksRequired": "<?php echo $l->get('error_blocks_required') ?>",
                  "incorrectId": "<?php echo $l->get('error_incorrect_id') ?>",
                  "usedId": "<?php echo $l->get('error_used_id') ?>"
                };
                $rootScope.texts = {
                  "hideForLogged": "<?php echo $l->get('entry_hide_for_logged') ?>",
                  "hideForGuest": "<?php echo $l->get('entry_hide_for_guest') ?>",
                  "displayHeader": "<?php echo $l->get('entry_display_header') ?>",
                  "combineWithCustomer": "<?php echo $l->get('entry_combine_with_customer') ?>",
                  "alertDefaultValue": "<?php echo $l->get('text_default_value_for_removed') ?>",
                  "saved": "<?php echo $text_success; ?>"
                };
            }
        );
    </script>
    <?php if ($error_warning) { ?>
    <div class="warning"><?php echo $error_warning; ?></div>
    <?php } ?>
    <div class="box">
      <div class="heading">
        <a ng-click="openFaq('//simpleopencart.com/info/4.x/faq_ru.html')" class="btn btn-primary button link-help"><?php echo $l->get('text_open_faq') ?></a>
        <a ng-click="openNews('//simpleopencart.com/info/4.x/news_ru.html')" class="btn btn-primary button"><?php echo $l->get('text_open_news') ?></a>
        <a href="http://simpleopencart.com" class="btn btn-primary button" target="_blank"><?php echo $l->get('text_author_site') ?></a>
        <div class="buttons">
          <?php if (count($stores) > 1) { ?>
          <div class="stores">
            <?php echo $l->get('text_store') ?>:&nbsp;
            <select name="store_id" id="store_id" onchange="location='<?php echo str_replace("'", "\\'", $action_without_store); ?>'+'&store_id='+jQuery(this).val()+'&settings_group_id='+jQuery('#settings_group_id').val()">
              <?php foreach ($stores as $key => $value) { ?>
                <option value="<?php echo $value['store_id'] ?>" <?php echo $store_id == $value['store_id'] ? 'selected="selected"' : '' ?>><?php echo $value['store_id'] ?> - <?php echo $value['name'] ?></option>
              <?php } ?>
            </select>
          </div>
          <?php } ?>
          <a ng-click="save()" class="button btn btn-primary"><?php echo $l->get('button_save'); ?></a>
          <img src="view/image/loading.gif" id="saving" style="display: none">
          <a onclick="location = '<?php echo str_replace("'", "\\'", $action_cancel); ?>';" class="button btn btn-primary"><?php echo $l->get('button_cancel'); ?></a>
        </div>
      </div>
    </div>
    <div class="content">
        <form action="<?php echo $action_main; ?>" method="post" enctype="multipart/form-data" id="form">
          <htabs>
            <htab title="<?php echo $l->get('tab_pages') ?>" title-lang-id="tab_pages">
              <?php echo $simple_tab_pages ?>
            </htab>
            <htab title="<?php echo $l->get('tab_fields') ?>" title-lang-id="tab_fields">
              <?php echo $simple_tab_fields ?>
            </htab>
            <htab title="<?php echo $l->get('tab_headers') ?>" title-lang-id="tab_headers">
              <?php echo $simple_tab_headers ?>
            </htab>
            <htab title="<?php echo $l->get('tab_integration') ?>" title-lang-id="tab_integration">
              <?php echo $simple_tab_integration ?>
            </htab>
            <htab title="<?php echo $l->get('tab_backup') ?>" title-lang-id="tab_backup">
              <?php echo $simple_tab_backup ?>
            </htab>
            <htab title="<?php echo $l->get('tab_modules') ?>" title-lang-id="tab_modules">
              <?php echo $simple_tab_modules ?>
            </htab>
            <htab title="<?php echo $l->get('tab_address_formats') ?>" title-lang-id="tab_address_formats">
              <?php echo $simple_tab_address_formats ?>
            </htab>
          </htabs>
        </form>
    </div>
    <modal title="<?php echo $l->get('text_open_faq') ?>" close-text="<?php echo $l->get('button_close') ?>" ng-show="isFaqOpened" src="faqSrc" on-close="closeFaq()">
    </modal>
    <modal title="<?php echo $l->get('text_open_news') ?>" close-text="<?php echo $l->get('button_close') ?>" ng-show="isNewsOpened" src="newsSrc" on-close="closeNews()">
    </modal>
    <alerts></alerts>
</div>
<?php include 'simple_footer.tpl' ?>
<?php echo $footer; ?>
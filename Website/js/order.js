var restaurant = 0;

/* When the doc is ready fade out the loading screen after 1s */
$(document).ready(function() {
  /* Get restaurant id from url */
  restaurant = getUrlParam('restaurant');

  /* Init shopping cart */
  cart.initCart();

  /* Load necessary information */
  $.rest.get('api/1.0/customer/order_info.php?', {restaurant: restaurant}, function(data) {
    /* Handle errors */
    if(!data.success) {
      showErrorOverlay('Network Error', 
                       '无法从服务器得到返回值，请检查网络连接，咨询本站的程序猿。', 
                       undefined);
      console.error('An error occured while requesting data from the server:')
      console.error(data);
      leaveTo('meals.php?restaurant=' + restaurant);
      return;
    }

    /* Display information */
    $('.restaurant-name').html(data.data.name);
    $('.restaurant-eta').html(data.data.eta);
    $('.restaurant-phone').html(data.data.phone);
    $('.restaurant-shipping-cost').html(data.data.shipping_cost);
    
    /* Calculate order value */
    var cartContent = cart.getCartValue(restaurant, function(value) {
      /* Add shipping costs */
      value += data.data.shipping_cost;
      
      /* Set value */
      $('.order-value').html(value);

    });

    /* Hide loading overlay */
    hideLoadingOverlay();
      
  });
  
  /* Display delivery address */
  var address = getCurrentDeliveryAddress();
  $('.address-street').html(address['0'].simple.road);
  $('.address-city').html(address['0'].simple.city);
  $('.address-postal-code').html(address['0'].simple.adcode);
  $('.address-country').html(address['0'].simple.country);
    
  /* Load shopping cart */
  var cartContent = cart.getOverview(restaurant, function(cartContent) {
    /* Load template */
    var template = $('.table-order tbody template').html().trim();
    
    /* Iterate over cart items */
    $(cartContent.rows).each(function(i, d) {
      /* Duplicate template */
      var e = $(template);
      
      /* Extract data */
      var data = JSON.parse(d.data);
            
      /* Set information */
      e.find('.item-name').html(data.name);
      e.find('.item-price').html(d.price);
      e.find('.item-amount').html(d.amount);
      e.find('.item-total-price').html(d.amount * d.price);
      
      /* Append to table */
      $('.table-order tbody').prepend(e);
      
    });
  });
});

/* Click handler for complete order button */
$('.btn-complete-order').click(function() {
  /* Check if the user is logged in */
  if(getSession() == null) {
    showErrorOverlay('Haven\'t Logged In', '亲，请先登录再下单哦！', null, 'showOverlay($("#login-overlay"))');
    return;
  }
  
  /* show loading overlay*/
  showLoadingOverlay(function() {
    /* Load session */
    var session = getSession();

    /* Create put data */
    var put = new Object();
    put.restaurant = restaurant;

    /* Copy address */
    var address = getCurrentDeliveryAddress();
    put.address = address['0'].simple;
    put.address.lat = address['0'].position.lat;
    put.address.lng = address['0'].position.long;

    /* Copy shopping cart */
    put.dishes = new Array();
    var cartContent = cart.getOverview(restaurant, function(cartContent) {
      /* Iterate over cart items */
      $(cartContent.rows).each(function(i, d) {
        /* Push item to array */
        put.dishes.push({id: d.id, quantity : d.amount});

      });

      /* Place the order */
      $.rest.put('api/1.0/customer/delivery.php', session, function(data) {
        /* Handle errors */
        if(handleError(data)) {
          return;
        }
        
        /* Delete cart */
        cart.deleteRestaurant(restaurant);

        /* Show confirmation, will forward user to profile */
        showOverlay($('#success-overlay'), hideLoadingOverlay);
        
      }, put);
    });
  });
});
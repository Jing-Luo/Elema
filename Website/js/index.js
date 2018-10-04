$(function() {
  /* Load last search */
  var delivery = getCurrentDeliveryAddress();
  if(delivery != null) {
    $('.search-box input').val(delivery.formatted_address);
  }
});

/* Click handler for search box */
$('#splash-screen-index .search-box .btn').click(function() {
  searchAddress();
});

/* Enter handler for search box */
$('#splash-screen-index .search-box input').keypress(function(e) {
  if(e.which == 13) {
    searchAddress();
    return false;
  }
});


function searchAddress() {
  /* Show laoding overlay */
  showLoadingOverlay(function() {
     var delivery = getCurrentDeliveryAddress();

    /* If the query was not changed, use the last result */
     if(delivery != null && $('.search-box input').val() == delivery.formatted_address) {
       showRestaurantsForAddress(localStorage.getItem(localStorageDeliveryAddress));
     }
    
    console.log('start query');
    /* Query data */
    $.rest.get('api/1.0/customer/geo.php', {address: $('.search-box input').val()}, function(data) {
      console.log('end query');
      /* Handle errors */
      if(!data.success || data.data.status !== "1") {
        showErrorOverlay('Network Error', 
                         '没有得到返回值，请检查网络连接是否正常，并确保输入的地址是正确的。', 
                         function() {
          hideLoadingOverlay();
          console.log(data);
        });

        return;
      }

      showRestaurantsForAddress(data.data.geocodes);

    });
  });
}

function showRestaurantsForAddress(address) {
  /* Save search and found address */
  console.log(address);
  setCurrentDeliveryAddress(address);
  /* Leave */
  hideOverlay($('#address-picker'), function() {
    leaveTo('restaurants.php');
  });
}

/* Click handler for cancel button in address picker */
$('#address-picker .btn-cancel').click(function() {
  console.log('cancel');
  hideOverlay($('#address-picker'));
  hideLoadingOverlay();
});

/* When the doc is ready fade out the loading screen after 1s */
$(document).ready(function() {
  window.setTimeout(hideLoadingOverlay, 250);

});
<?php
  //Dong Chuan Lu, Minhang Qu, Shanghai Shi
  // include main database script
  include_once("../db.php");
  
  // db_open();
  // assure all required parameters are available
  // if($err = check_parms_available(array("address"))) {
  //   // set fields for array
  //   $answer['success'] = false;
  //   $answer['err_no'] = ERROR_MISSING_PARAM;
  //   $answer['err_msg'] = $err;
    
  // } else {
    // Get the address
    $address = urlencode($_GET['address']);
     
    // google map geocode api url
     $key = "8a8265a039bc0379bbfa2a44d5f1b5cf";
     $url = "http://restapi.amap.com/v3/geocode/geo?key={$key}&address={$address}";

     // $key = "8a8265a039bc0379bbfa2a44d5f1b5cf";
     // $url = "https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyAh6LpxQ7r57I05QKCeHZIupoAIt5UMLEE&address={$address}";
    try {
      // get the json response
      $ch = curl_init();
      curl_setopt($ch, CURLOPT_URL, $url);
      curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
      $resp_json = curl_exec($ch);
                  
      // decode the json
      $resp = json_decode($resp_json, true);

      // generate answer
      $answer['success'] = true;
      $answer['data'] = $resp;
      
      // generate a simple version of the adress
      // foreach($answer['data']['geocodes'] as $k => $v) {
      //   $address_simple = explode(", ", $v['formatted_address']);
      //   $answer['data']['geocodes'][$k]['simple'] = array();
      //   $answer['data']['geocodes'][$k]['simple']['road'] = $address_simple[0];
      //   $answer['data']['geocodes'][$k]['simple']['city'] = $address_simple[1];
		    // $answer['data']['geocodes'][$k]['simple']['state'] = $address_simple[2];
      //   $answer['data']['geocodes'][$k]['simple']['country'] = $address_simple[3];
      //   $answer['data']['geocodes'][$k]['simple']['postal_code'] = $address_simple[4];
      // }

      $answer['data']['geocodes']['0']['simple'] = array();
      $answer['data']['geocodes']['0']['simple']['road'] = $answer['data']['geocodes']['0']['formatted_address'];
      $answer['data']['geocodes']['0']['simple']['city'] = $answer['data']['geocodes']['0']['city'];
      $answer['data']['geocodes']['0']['simple']['state'] = $answer['data']['geocodes']['0']['province'];
      $answer['data']['geocodes']['0']['simple']['country'] = "中国";
      $answer['data']['geocodes']['0']['simple']['postal_code'] = $answer['data']['geocodes']['0']['adcode'];


      $address_location = explode(',', $answer['data']['geocodes']['0']['location']); 
      $answer['data']['geocodes']['0']['position'] = array();
      $answer['data']['geocodes']['0']['position']['long'] = $address_location[0];
      $answer['data']['geocodes']['0']['position']['lat'] = $address_location[1];

      
      } catch(Exception $e) {
      // set fields for array
      $answer['success'] = false;
      $answer['err_no'] = ERROR_GENERAL;
      $answer['err_msg'] = $e;
    }


  // Encode answer as json and print aka send
   echo json_encode($answer);

  //db_close();

?>
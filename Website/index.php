<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0"/> <!--320-->
  <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="icon" href="imgs/favicon.ico">

  <title>饿了吗 | 饿了别叫妈，就叫饿了吗</title>

  <!-- Bootstrap core CSS -->
  <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
  <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
 <!--  <script src="assets/js/ie-emulation-modes-warning.js"></script> -->

  <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
  <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->

  <!-- Custom styles for this template -->
  <link href="css/main.css" rel="stylesheet">
  <link href="css/index.css" rel="stylesheet">
      <style>
          ul
            {
              list-style-type:none;
              margin:0;
              padding:0;
              text-align: center;
            }
          li
            { 
              display:inline;
              text-align: center;
            }
        </style>
</head>
<body>
  
  <!-- Header -->
  <?php include('shared/sidebar.html'); ?>
  
  <!-- Additional Overlays -->
  <div id="address-picker" class="overlay">
    <div class="overlay-content">
      <div class="scroll">
        <h4>Undefined</h4>
        <div id="address-list" class="narrow">
          <template>
            <address class="address btn btn-default btn-block">
              <p class="road">Undefined</p>
              <p><span class="postal_code"></span> <span class="city"></span></p>
              <p class="state"></p>
              <p class="country"></p>
            </address>
          </template>
          <button class="btn btn-danger btn-cancel btn-block">Cancel</button>
        </div>
      </div>
    </div>
  </div>
  
  <div id="main-content">
    <!-- Splash screen and search bar -->
    <section id="splash-screen-index">
      <div class="splash-center">
        <div class="input-group search-box">
          <input type="text" class="form-control" placeholder="请输入您的城市和具体地址">
          <span class="input-group-btn">
            <button class="btn btn-default" type="button"></button>
          </span>
        </div>

        
        <ul>
        <li>快速定位：</li>
        <li><a href="restaurants.php" style="color: red;">历史位置</a></li>
        </ul>
      </div>
  </div>

    </section>
    <?php include('shared/footer.html'); ?>
    
  </div>
  
  <!-- Load Scripts at the end to optimize site loading time -->
  <script src="js/jquery-2.1.0.min.js"></script>
  <script src="bootstrap/js/bootstrap.min.js"></script>
  <script src="js/main.js"></script>
  <script src="js/api.js"></script>
  <script src="js/index.js"></script>
</body>
</html>
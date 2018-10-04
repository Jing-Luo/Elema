-- phpMyAdmin SQL Dump
-- version 4.4.15.9
-- https://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 20, 2017 at 07:59 PM
-- Server version: 5.6.35
-- PHP Version: 5.5.38

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `elema`
--

DELIMITER $$
--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `DISTANCE`(lat1 DOUBLE, long1 DOUBLE, lat2 DOUBLE, long2 DOUBLE) RETURNS float
BEGIN

  DECLARE R, phi1, phi2, dphi, dlam, a, c, d FLOAT;

  SET R = 6371000; -- metres

  SET phi1 = RADIANS(lat1);

  SET phi2 = RADIANS(lat2);

  SET dphi = RADIANS(lat2-lat1);

  SET dlam = RADIANS(long2-long1);

    

  SET a = SIN(dphi/2) * SIN(dphi/2) +

         COS(phi1) * COS(phi2) *

         SIN(dlam/2) * SIN(dlam/2);

  SET c = 2 * ATAN2(SQRT(a), SQRT(1-a));

  

  SET d = R * c;

  RETURN d;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Customer`
--

CREATE TABLE IF NOT EXISTS `Customer` (
  `customer_id_pk` int(11) NOT NULL COMMENT 'used as identifer.\nthere may be no two users with the same number\nhas to be double because with in we just can represent 10 digits, but chinese phone numbers have 11 digits\na list as representation would take more space',
  `region_code` varchar(3) NOT NULL COMMENT 'the region code of the phone number',
  `national_number` varchar(15) NOT NULL,
  `last_name` varchar(256) NOT NULL,
  `first_name` varchar(256) NOT NULL,
  `nick` varchar(45) NOT NULL COMMENT 'the nickname of the user\ndefault is combination of name',
  `password` varchar(256) NOT NULL,
  `session_id` varchar(64) DEFAULT NULL COMMENT 'unique and truly random 256 key',
  `email` varchar(256) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Customer`
--

INSERT INTO `Customer` (`customer_id_pk`, `region_code`, `national_number`, `last_name`, `first_name`, `nick`, `password`, `session_id`, `email`) VALUES
(1, '86', '15147456626', '赵', '一', 'apple', '6787017c44f171579326c2207f82a3da', NULL, 'flappybird@gmail.com'),
(2, '86', '17895369752', '钱', '一', 'boy', '7c4a8d09ca3762af61e59520943dc26494f8941b', NULL, 'flappybird@gmail.com'),
(3, '86', '11347892971', '孙', '一', 'cat', '7c4a8d09ca3762af61e59520943dc26494f8941b', NULL, 'flappybird@gmail.com'),
(4, '86', '15045255159', '李', '一', 'dog', '7c4a8d09ca3762af61e59520943dc26494f8941b', NULL, 'flappybird@gmail.com'),
(5, '86', '17107813284', '周', '一', 'elephant', '7c4a8d09ca3762af61e59520943dc26494f8941b', NULL, 'flappybird@gmail.com'),
(6, '86', '10254181108', '吴', '一', 'frog', '7c4a8d09ca3762af61e59520943dc26494f8941b', NULL, 'flappybird@gmail.com'),
(7, '86', '15065990659', '郑', '一', 'glove', '2acf35c77fff945a69c2d79a2f8713fd', NULL, 'flappybird@gmail.com'),
(8, '86', '17191424892', '王', '一', 'hello', '7c4a8d09ca3762af61e59520943dc26494f8941b', NULL, 'flappybird@gmail.com'),
(9, '86', '14751423622', '冯', '一', 'ivan', '42a6b10b2c1daa800a25f3e740edb2b3', NULL, 'flappybird@gmail.com'),
(10, '86', '19244674518', '陈', '一', 'joey', '7c4a8d09ca3762af61e59520943dc26494f8941b', NULL, 'flappybird@gmail.com'),
(11, '86', '18657184369', '褚', '一', 'katty', '229657d8b627ffd14a3bccca1a0f9b6e', NULL, 'flappybird@gmail.com'),
(12, '86', '13378206671', '卫', '一', 'lobby', '7c4a8d09ca3762af61e59520943dc26494f8941b', NULL, 'flappybird@gmail.com'),
(13, '86', '12717230637', '蒋', '一', 'monica', '2dbbd680949db33f7912382d10459dd0c28c37e5', NULL, 'flappybird@gmail.com'),
(14, '86', '12512521362', '沈', '一', 'noone', '7c4a8d09ca3762af61e59520943dc26494f8941b', NULL, 'flappybird@gmail.com'),
(15, '86', '11389504799', '韩', '一', 'oppo', '7c4a8d09ca3762af61e59520943dc26494f8941b', NULL, 'flappybird@gmail.com'),
(16, '86', '17546884930', '杨', '一', 'poly', '7c4a8d09ca3762af61e59520943dc26494f8941b', NULL, 'flappybird@gmail.com'),
(17, '86', '15096426960', '朱', '一', 'quentain', '7c4a8d09ca3762af61e59520943dc26494f8941b', NULL, 'flappybird@gmail.com'),
(18, '86', '14834393485', '秦', '一', 'ross', '7c4a8d09ca3762af61e59520943dc26494f8941b', NULL, 'flappybird@gmail.com'),
(19, '86', '14187985518', '尤', '一', 'taylor', '7c4a8d09ca3762af61e59520943dc26494f8941b', NULL, 'flappybird@gmail.com'),
(20, '86', '12754556820', '许', '一', 'ulla', '7c4a8d09ca3762af61e59520943dc26494f8941b', NULL, 'flappybird@gmail.com'),
(21, '86', '19780774403', '何', '一', 'vivian', '7c4a8d09ca3762af61e59520943dc26494f8941b', NULL, 'flappybird@gmail.com'),
(22, '86', '17503775795', '吕', '一', 'woodunder', '7c4a8d09ca3762af61e59520943dc26494f8941b', NULL, 'flappybird@gmail.com'),
(23, '86', '10110154487', '施', '一', 'xmen', '7c4a8d09ca3762af61e59520943dc26494f8941b', NULL, 'flappybird@gmail.com'),
(24, '86', '14872220524', '张', '一', 'zippo', '7c4a8d09ca3762af61e59520943dc26494f8941b', NULL, 'flappybird@gmail.com'),
(25, '86', '19512897003', '孔', '一', 'amazon', '7c4a8d09ca3762af61e59520943dc26494f8941b', NULL, 'flappybird@gmail.com'),
(26, '86', '18500716426', '曹', '一', 'google', '7c4a8d09ca3762af61e59520943dc26494f8941b', NULL, 'flappybird@gmail.com'),
(27, '86', '16659311608', '严', '一', 'linkedin', '7c4a8d09ca3762af61e59520943dc26494f8941b', NULL, 'flappybird@gmail.com'),
(28, '86', '16326631665', '华', '一', 'twitter', '7c4a8d09ca3762af61e59520943dc26494f8941b', NULL, 'flappybird@gmail.com'),
(29, '86', '15945061767', '金', '一', 'alibaba', '7c4a8d09ca3762af61e59520943dc26494f8941b', NULL, 'flappybird@gmail.com'),
(30, '86', '12108978467', '魏', '一', 'tencent', '7c4a8d09ca3762af61e59520943dc26494f8941b', NULL, 'flappybird@gmail.com'),
(31, '86', '15800789603', 'Luo', 'Jing', 'Jing', '7c4a8d09ca3762af61e59520943dc26494f8941b', 'ad38003bc75549ece7af08aeae47e6c322872d88a08fb8a3f5402530cce19fd0', 'email@email.com'),
(32, '86', '15800779999', 'Luo', 'Jing', 'haha', '7c4a8d09ca3762af61e59520943dc26494f8941b', '3997e399ab1330fcb71f15cedbfd3140af88484d12912d94a87d0e37903e3073', '123@qq.com'),
(33, '86', '13455555678', 'Jing', 'Luo', 'vvv', '7c4a8d09ca3762af61e59520943dc26494f8941b', '40f6aa95f1345c749045d81dbfabae016f32653a5a4e6c4239dc28c891a1b7d0', '1@qq.com');

-- --------------------------------------------------------

--
-- Table structure for table `Delivery`
--

CREATE TABLE IF NOT EXISTS `Delivery` (
  `delivery_id_pk` int(11) NOT NULL,
  `Customer_customer_id` int(11) NOT NULL,
  `Restaurant_restaurant_id` int(11) NOT NULL,
  `country` varchar(256) NOT NULL,
  `postcode` varchar(45) NOT NULL,
  `city` varchar(256) DEFAULT NULL,
  `district` varchar(45) DEFAULT NULL,
  `street_name` varchar(256) NOT NULL,
  `street_number` varchar(45) DEFAULT NULL,
  `add_info` varchar(256) DEFAULT NULL,
  `comment` varchar(256) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Delivery`
--

INSERT INTO `Delivery` (`delivery_id_pk`, `Customer_customer_id`, `Restaurant_restaurant_id`, `country`, `postcode`, `city`, `district`, `street_name`, `street_number`, `add_info`, `comment`) VALUES
(1, 2, 1, '中国', '200240', '上海市', '闵行区', '东川路', '723', NULL, NULL),
(2, 3, 2, '中国', '200240', '上海市', '闵行区', '东川路', '654', NULL, NULL),
(3, 2, 2, '中国', '200240', '上海市', '闵行区', '东川路', '723', NULL, NULL),
(4, 7, 4, '中国', '200240', '上海市', '闵行区', '东川路', '724', NULL, NULL),
(5, 8, 5, '中国', '200240', '上海市', '闵行区', '东川路', '725', NULL, NULL),
(6, 9, 6, '中国', '200240', '上海市', '闵行区', '东川路', '726', NULL, NULL),
(7, 10, 7, '中国', '200240', '上海市', '闵行区', '东川路', '727', NULL, NULL),
(8, 11, 8, '中国', '200240', '上海市', '闵行区', '东川路', '728', NULL, NULL),
(9, 12, 9, '中国', '200240', '上海市', '闵行区', '东川路', '729', NULL, NULL),
(10, 13, 10, '中国', '200240', '上海市', '闵行区', '东川路', '730', NULL, NULL),
(11, 14, 11, '中国', '200240', '上海市', '闵行区', '东川路', '731', NULL, NULL),
(12, 7, 12, '中国', '200240', '上海市', '闵行区', '东川路', '724', NULL, NULL),
(13, 8, 13, '中国', '200240', '上海市', '闵行区', '东川路', '725', NULL, NULL),
(14, 9, 14, '中国', '200240', '上海市', '闵行区', '东川路', '726', NULL, NULL),
(15, 10, 4, '中国', '200240', '上海市', '闵行区', '东川路', '727', NULL, NULL),
(16, 11, 8, '中国', '200240', '上海市', '闵行区', '东川路', '728', NULL, NULL),
(17, 31, 1, 'ä¸­å›½', '310112', 'ä¸Šæµ·å¸‚', NULL, 'ä¸Šæµ·å¸‚é—µè¡ŒåŒºä¸œå·è·¯|800å·', '', NULL, NULL),
(18, 31, 2, 'ä¸­å›½', '310112', 'ä¸Šæµ·å¸‚', NULL, 'ä¸Šæµ·å¸‚é—µè¡ŒåŒºä¸œå·è·¯|800å·', '', NULL, NULL),
(19, 31, 4, 'ä¸­å›½', '310112', 'ä¸Šæµ·å¸‚', NULL, 'ä¸Šæµ·å¸‚é—µè¡ŒåŒºä¸œå·è·¯|800å·', '', NULL, NULL),
(20, 31, 18, 'ä¸­å›½', '310112', 'ä¸Šæµ·å¸‚', NULL, 'ä¸Šæµ·å¸‚é—µè¡ŒåŒºä¸œå·è·¯|800å·', '', NULL, NULL),
(21, 33, 18, 'ä¸­å›½', '310112', 'ä¸Šæµ·å¸‚', NULL, 'ä¸Šæµ·å¸‚é—µè¡ŒåŒºä¸œå·è·¯', '', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `Delivery_Meal_Map`
--

CREATE TABLE IF NOT EXISTS `Delivery_Meal_Map` (
  `Delivery_delivery_id_pk` int(11) NOT NULL,
  `Meal_meal_id_pk` int(11) NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Delivery_Meal_Map`
--

INSERT INTO `Delivery_Meal_Map` (`Delivery_delivery_id_pk`, `Meal_meal_id_pk`, `amount`) VALUES
(1, 1, 1),
(1, 2, 2),
(1, 3, 2),
(2, 5, 1),
(2, 6, 2),
(3, 5, 3),
(4, 71, 1),
(5, 78, 1),
(5, 79, 2),
(5, 80, 2),
(6, 13, 1),
(6, 14, 1),
(7, 16, 1),
(7, 21, 2),
(8, 22, 5),
(8, 24, 3),
(9, 30, 2),
(9, 31, 2),
(9, 33, 2),
(10, 38, 1),
(11, 47, 10),
(12, 53, 1),
(13, 60, 2),
(14, 65, 7),
(15, 73, 1),
(15, 74, 1),
(15, 75, 1),
(16, 28, 100),
(17, 5, 1),
(17, 6, 1),
(18, 13, 1),
(18, 17, 1),
(19, 1, 1),
(19, 3, 1),
(19, 4, 1),
(20, 105, 1),
(21, 105, 1);

--
-- Triggers `Delivery_Meal_Map`
--
DELIMITER $$
CREATE TRIGGER `delivery_meal_map_constraints` BEFORE INSERT ON `delivery_meal_map`
 FOR EACH ROW BEGIN

    DECLARE msg VARCHAR(255);

    IF !(NEW.amount > 0) THEN

        SET msg = "DIE: You inserted a resctricted VALUE";

        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;

    END IF;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Delivery_State`
--

CREATE TABLE IF NOT EXISTS `Delivery_State` (
  `Delivery_delivery_id_pk` int(11) NOT NULL,
  `date_pk` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Delivery_State_Type_delivery_status_type` int(11) NOT NULL,
  `comment` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Delivery_State`
--

INSERT INTO `Delivery_State` (`Delivery_delivery_id_pk`, `date_pk`, `Delivery_State_Type_delivery_status_type`, `comment`) VALUES
(1, '2017-06-01 18:08:10', 1, NULL),
(1, '2017-06-01 18:10:12', 2, NULL),
(1, '2017-06-01 18:25:44', 3, NULL),
(1, '2017-06-01 18:43:38', 4, NULL),
(2, '2017-06-14 12:08:10', 1, NULL),
(2, '2017-06-14 13:10:21', 2, NULL),
(2, '2017-06-14 13:45:56', 3, NULL),
(2, '2017-06-14 14:20:43', 4, NULL),
(3, '2017-06-15 17:08:42', 1, NULL),
(3, '2017-06-15 18:10:23', 2, NULL),
(3, '2017-06-15 18:55:44', 3, NULL),
(4, '2017-06-17 16:12:02', 1, NULL),
(4, '2017-06-17 16:42:02', 2, NULL),
(4, '2017-06-17 17:12:02', 3, NULL),
(4, '2017-06-17 17:32:02', 4, NULL),
(5, '2017-06-17 16:12:02', 1, NULL),
(5, '2017-06-17 16:42:02', 2, NULL),
(5, '2017-06-17 17:12:02', 3, NULL),
(5, '2017-06-17 17:32:02', 4, NULL),
(6, '2017-06-17 16:12:02', 1, NULL),
(6, '2017-06-17 16:42:02', 2, NULL),
(6, '2017-06-17 17:12:02', 3, NULL),
(6, '2017-06-17 17:32:02', 4, NULL),
(7, '2017-06-17 16:12:02', 1, NULL),
(7, '2017-06-17 16:42:02', 2, NULL),
(7, '2017-06-17 17:12:02', 3, NULL),
(7, '2017-06-17 17:32:02', 4, NULL),
(8, '2017-06-17 16:12:02', 1, NULL),
(8, '2017-06-17 16:42:02', 2, NULL),
(8, '2017-06-17 17:12:02', 3, NULL),
(8, '2017-06-17 17:32:02', 4, NULL),
(9, '2017-06-17 16:12:02', 1, NULL),
(9, '2017-06-17 16:42:02', 2, NULL),
(9, '2017-06-17 17:12:02', 3, NULL),
(9, '2017-06-17 17:32:02', 4, NULL),
(10, '2017-06-17 16:12:02', 1, NULL),
(10, '2017-06-17 16:42:02', 2, NULL),
(10, '2017-06-17 17:12:02', 3, NULL),
(10, '2017-06-17 17:32:02', 4, NULL),
(11, '2017-06-17 16:12:02', 1, NULL),
(11, '2017-06-17 16:42:02', 2, NULL),
(11, '2017-06-17 17:12:02', 3, NULL),
(11, '2017-06-17 17:32:02', 4, NULL),
(12, '2017-06-15 11:12:02', 1, NULL),
(12, '2017-06-15 11:42:02', 2, NULL),
(12, '2017-06-15 12:12:02', 3, NULL),
(12, '2017-06-15 12:32:02', 4, NULL),
(13, '2017-06-15 16:12:02', 1, NULL),
(13, '2017-06-15 16:42:02', 2, NULL),
(14, '2017-06-15 16:12:02', 1, NULL),
(14, '2017-06-15 16:42:02', 2, NULL),
(14, '2017-06-15 17:12:02', 3, NULL),
(15, '2017-06-15 16:12:02', 1, NULL),
(16, '2017-06-15 16:12:02', 1, NULL),
(16, '2017-06-15 16:42:02', 2, NULL),
(16, '2017-06-15 17:12:02', 3, NULL),
(16, '2017-06-15 17:15:03', 4, NULL),
(17, '2017-06-20 13:19:18', 1, NULL),
(17, '2017-06-20 13:21:49', 2, ''),
(17, '2017-06-20 13:21:56', 3, ''),
(17, '2017-06-20 13:22:00', 4, ''),
(18, '2017-06-20 13:22:50', 1, NULL),
(18, '2017-06-20 13:23:15', 2, ''),
(18, '2017-06-20 13:23:16', 3, ''),
(18, '2017-06-20 13:23:22', 4, ''),
(19, '2017-06-20 15:01:19', 1, NULL),
(20, '2017-06-20 17:43:40', 1, NULL),
(20, '2017-06-20 17:43:46', 2, ''),
(20, '2017-06-20 17:43:55', 3, ''),
(20, '2017-06-20 17:44:01', 4, ''),
(21, '2017-06-20 19:51:46', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `Delivery_State_Type`
--

CREATE TABLE IF NOT EXISTS `Delivery_State_Type` (
  `delivery_status_type_id_pk` int(11) NOT NULL,
  `name` varchar(256) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Delivery_State_Type`
--

INSERT INTO `Delivery_State_Type` (`delivery_status_type_id_pk`, `name`) VALUES
(1, '待接单'),
(2, '制作中'),
(3, '配送中'),
(4, '已完成');

-- --------------------------------------------------------

--
-- Stand-in structure for view `delivery_state_view`
--
CREATE TABLE IF NOT EXISTS `delivery_state_view` (
`Delivery_delivery_id_pk` int(11)
,`date_pk` timestamp
,`delivery_status_type` varchar(256)
,`comment` varchar(256)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `delivery_view`
--
CREATE TABLE IF NOT EXISTS `delivery_view` (
`delivery_id_pk` int(11)
,`Customer_customer_id` int(11)
,`Restaurant_restaurant_id` int(11)
,`country` varchar(256)
,`postcode` varchar(45)
,`city` varchar(256)
,`district` varchar(45)
,`street_name` varchar(256)
,`street_number` varchar(45)
,`add_info` varchar(256)
,`comment` varchar(256)
,`date_pk` timestamp
,`delivery_status_type_number` int(11)
,`delivery_status_type` varchar(256)
,`delivery_state_comment` varchar(256)
);

-- --------------------------------------------------------

--
-- Table structure for table `Meal`
--

CREATE TABLE IF NOT EXISTS `Meal` (
  `meal_id_pk` int(11) NOT NULL,
  `Restaurant_restaurant_id` int(11) NOT NULL,
  `name` varchar(256) NOT NULL,
  `price` varchar(45) NOT NULL,
  `description` text COMMENT 'optional',
  `spiciness` tinyint(3) unsigned DEFAULT NULL COMMENT 'Range 0-3',
  `offered` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Meal`
--

INSERT INTO `Meal` (`meal_id_pk`, `Restaurant_restaurant_id`, `name`, `price`, `description`, `spiciness`, `offered`) VALUES
(1, 4, '薯条', '9', '油炸薯条', 0, 1),
(2, 4, '香辣鸡腿堡', '8', '辣的汉堡', 2, 1),
(3, 4, '无骨香酥腿排', '9', '没有骨头', 0, 1),
(4, 4, '霸王鸡腿', '9', '项羽之腿', 0, 1),
(5, 2, '百事可乐', '6', '可乐不加冰', 0, 1),
(6, 2, '玉米香肠', '4', '正宗双汇玉米肠', 0, 1),
(7, 2, '墨西哥鸡肉卷', '9', '据说去不了美国就只能来中国', 1, 1),
(8, 2, '手抓饼', '6', '华联之后', 0, 1),
(9, 2, '里脊肉', '5', '3串1份', 0, 1),
(10, 2, '双皮奶', '8', '不是双皮不要钱', 0, 1),
(11, 19, '非常咸的麻辣香锅', '14', NULL, 0, 1),
(12, 19, '非常油的盖饭', '12', NULL, 0, 1),
(13, 19, '非常奇怪的米线', '14', NULL, 0, 1),
(14, 19, '非常稀的粥', '12', NULL, 0, 1),
(15, 19, '非常重口的锅仔', '14', NULL, 0, 1),
(16, 19, '非常软的面条', '11', NULL, 0, 1),
(17, 19, '非常冷的毛豆', '11', NULL, 0, 1),
(18, 3, '米饭', '1', NULL, 0, 1),
(19, 3, '面条', '4', NULL, 0, 1),
(20, 3, '青菜', '2', NULL, 0, 1),
(21, 3, '红烧肉', '8', NULL, 0, 1),
(22, 3, '鸡排', '8', NULL, 0, 1),
(23, 3, '西红柿鸡蛋', '5', NULL, 0, 1),
(24, 3, '咖喱', '8', NULL, 0, 1),
(25, 4, '米饭', '1', NULL, 0, 1),
(26, 4, '面条', '4', NULL, 0, 1),
(27, 4, '青菜', '2', NULL, 0, 1),
(28, 4, '红烧肉', '8', NULL, 0, 1),
(29, 4, '鸡排', '8', NULL, 0, 1),
(30, 4, '西红柿鸡蛋', '5', NULL, 0, 1),
(31, 4, '咖喱', '8', NULL, 0, 1),
(32, 5, '米饭', '1', NULL, 0, 1),
(33, 5, '面条', '4', NULL, 0, 1),
(34, 5, '青菜', '2', NULL, 0, 1),
(35, 5, '红烧肉', '8', NULL, 0, 1),
(36, 5, '鸡排', '8', NULL, 0, 1),
(37, 5, '西红柿鸡蛋', '5', NULL, 0, 1),
(38, 5, '咖喱', '8', NULL, 0, 1),
(39, 6, '米饭', '1', NULL, 0, 1),
(40, 6, '面条', '4', NULL, 0, 1),
(41, 6, '青菜', '2', NULL, 0, 1),
(42, 6, '红烧肉', '8', NULL, 0, 1),
(43, 6, '鸡排', '8', NULL, 0, 1),
(44, 6, '西红柿鸡蛋', '5', NULL, 0, 1),
(45, 6, '咖喱', '8', NULL, 0, 1),
(46, 7, '米饭', '1', NULL, 0, 1),
(47, 7, '面条', '4', NULL, 0, 1),
(48, 7, '青菜', '2', NULL, 0, 1),
(49, 7, '红烧肉', '8', NULL, 0, 1),
(50, 7, '鸡排', '8', NULL, 0, 1),
(51, 7, '西红柿鸡蛋', '5', NULL, 0, 1),
(52, 7, '咖喱', '8', NULL, 0, 1),
(53, 8, '米饭', '1', NULL, 0, 1),
(54, 8, '面条', '4', NULL, 0, 1),
(55, 8, '青菜', '2', NULL, 0, 1),
(56, 8, '红烧肉', '8', NULL, 0, 1),
(57, 8, '鸡排', '8', NULL, 0, 1),
(58, 8, '西红柿鸡蛋', '5', NULL, 0, 1),
(59, 8, '咖喱', '8', NULL, 0, 1),
(60, 9, '米饭', '1', NULL, 0, 1),
(61, 9, '面条', '4', NULL, 0, 1),
(62, 9, '青菜', '2', NULL, 0, 1),
(63, 9, '红烧肉', '8', NULL, 0, 1),
(64, 9, '鸡排', '8', NULL, 0, 1),
(65, 9, '西红柿鸡蛋', '5', NULL, 0, 1),
(66, 9, '咖喱', '8', NULL, 0, 1),
(67, 10, '米饭', '1', NULL, 0, 1),
(68, 10, '面条', '4', NULL, 0, 1),
(69, 10, '青菜', '2', NULL, 0, 1),
(70, 10, '红烧肉', '8', NULL, 0, 1),
(71, 10, '鸡排', '8', NULL, 0, 1),
(72, 10, '西红柿鸡蛋', '5', NULL, 0, 1),
(73, 10, '咖喱', '8', NULL, 0, 1),
(74, 11, '米饭', '1', NULL, 0, 1),
(75, 11, '面条', '4', NULL, 0, 1),
(76, 11, '青菜', '2', NULL, 0, 1),
(77, 11, '红烧肉', '8', NULL, 0, 1),
(78, 11, '鸡排', '8', NULL, 0, 1),
(79, 11, '西红柿鸡蛋', '5', NULL, 0, 1),
(80, 11, '咖喱', '8', NULL, 0, 1),
(81, 12, '米饭', '1', NULL, 0, 1),
(82, 12, '面条', '4', NULL, 0, 1),
(83, 12, '青菜', '2', NULL, 0, 1),
(84, 12, '红烧肉', '8', NULL, 0, 1),
(85, 12, '鸡排', '8', NULL, 0, 1),
(86, 12, '西红柿鸡蛋', '5', NULL, 0, 1),
(87, 12, '咖喱', '8', NULL, 0, 1),
(88, 13, '米饭', '1', NULL, 0, 1),
(89, 13, '面条', '4', NULL, 0, 1),
(90, 13, '青菜', '2', NULL, 0, 1),
(91, 13, '红烧肉', '8', NULL, 0, 1),
(92, 13, '鸡排', '8', NULL, 0, 1),
(93, 13, '西红柿鸡蛋', '5', NULL, 0, 1),
(94, 13, '咖喱', '8', NULL, 0, 1),
(95, 14, '米饭', '1', NULL, 0, 1),
(96, 14, '面条', '4', NULL, 0, 1),
(97, 14, '青菜', '2', NULL, 0, 1),
(98, 14, '红烧肉', '8', NULL, 0, 1),
(99, 14, '鸡排', '8', NULL, 0, 1),
(100, 14, '西红柿鸡蛋', '5', NULL, 0, 1),
(101, 14, '咖喱', '8', NULL, 0, 1),
(102, 17, '薯条', '9', '油炸薯条', 0, 1),
(103, 17, '香辣鸡腿堡', '8', '辣的汉堡', 0, 1),
(104, 18, 'é¸¡è…¿æŠ«è¨', '20', 'äº”æ˜ŸæŽ¨è', 1, 0),
(105, 18, 'French Pizza', '20', 'Decilious', 1, 1);

--
-- Triggers `Meal`
--
DELIMITER $$
CREATE TRIGGER `meal_constraints` BEFORE INSERT ON `meal`
 FOR EACH ROW BEGIN

    DECLARE msg VARCHAR(255);

    IF !(NEW.price >= 0 &&

        NEW.spiciness <= 3 &&

        NEW.spiciness >= 0)

    THEN

        SET msg = "DIE: You inserted a resctricted VALUE";

        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;

    END IF;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Meal_Tag_Map`
--

CREATE TABLE IF NOT EXISTS `Meal_Tag_Map` (
  `Meal_meal_id_pk` int(11) NOT NULL,
  `Tag_tag_id_pk` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A dish is never tagged twice with the same tag';

--
-- Dumping data for table `Meal_Tag_Map`
--

INSERT INTO `Meal_Tag_Map` (`Meal_meal_id_pk`, `Tag_tag_id_pk`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(11, 1),
(12, 1),
(15, 1),
(21, 1),
(22, 1),
(104, 1),
(105, 1),
(13, 2),
(14, 2),
(16, 2),
(20, 2),
(10, 3),
(17, 4),
(5, 5);

-- --------------------------------------------------------

--
-- Table structure for table `Rating`
--

CREATE TABLE IF NOT EXISTS `Rating` (
  `Meal_meal_id_pk` int(11) NOT NULL,
  `Customer_customer_id_pk` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `rating` tinyint(4) NOT NULL COMMENT 'not be bigger than 5',
  `comment` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Every user can rate a dish just once';

--
-- Dumping data for table `Rating`
--

INSERT INTO `Rating` (`Meal_meal_id_pk`, `Customer_customer_id_pk`, `date`, `rating`, `comment`) VALUES
(1, 2, '2017-06-01 18:43:22', 4, '还不错'),
(3, 2, '2017-06-05 12:14:54', 3, '一般吧'),
(5, 3, '2017-06-13 17:00:00', 5, '太油了'),
(6, 3, '2017-06-14 17:00:04', 5, '很好次'),
(13, 31, '2017-06-20 19:46:36', 4, ''),
(17, 31, '2017-06-20 19:46:40', 5, ''),
(105, 31, '2017-06-20 17:44:14', 5, 'Great!');

--
-- Triggers `Rating`
--
DELIMITER $$
CREATE TRIGGER `rating_constraints` BEFORE INSERT ON `rating`
 FOR EACH ROW BEGIN

    DECLARE msg VARCHAR(255);



    -- Gets a Table with all the Meals from the customer and checks if the one which is needed for the rating is presente

    SELECT COUNT( * ) INTO @o_existent

    FROM (



        SELECT dmm.Meal_meal_id_pk

        FROM Delivery_Meal_Map dmm

        INNER JOIN (



            SELECT * 

            FROM Delivery_View

            WHERE Customer_customer_id = NEW.Customer_customer_id_pk && delivery_status_type_number = 4

        )d ON d.delivery_id_pk = dmm.Delivery_delivery_id_pk

    )ddmm

    WHERE ddmm.Meal_meal_id_pk = NEW.Meal_meal_id_pk;



    IF !(NEW.rating >= 0 &&

        NEW.rating <= 5 &&

        @o_existent >= 1)

    THEN

        SET msg = "DIE: You inserted a resctricted VALUE";

        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;

    END IF;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Restaurant`
--

CREATE TABLE IF NOT EXISTS `Restaurant` (
  `restaurant_id_pk` int(11) NOT NULL,
  `name` varchar(256) NOT NULL,
  `min_order_value` float unsigned NOT NULL,
  `shipping_cost` float unsigned NOT NULL COMMENT 'must be >= 0\n',
  `max_delivery_range` int(11) NOT NULL COMMENT 'in kilometers, \nadditional enums like:\ncitys, districts\nin 100 meter steps',
  `description` text,
  `country` varchar(256) NOT NULL,
  `postcode` varchar(45) NOT NULL,
  `city` varchar(256) DEFAULT NULL,
  `district` varchar(45) DEFAULT NULL,
  `street_name` varchar(256) NOT NULL,
  `street_number` varchar(45) DEFAULT NULL,
  `add_info` varchar(256) DEFAULT NULL,
  `position_lat` double DEFAULT NULL,
  `position_long` double DEFAULT NULL,
  `offered` tinyint(1) DEFAULT '1' COMMENT 'Describes if a current restaurant an',
  `password` varchar(256) NOT NULL,
  `session_id` varchar(64) DEFAULT NULL COMMENT 'unique and truly random 256 key',
  `region_code` varchar(3) NOT NULL,
  `national_number` varchar(15) NOT NULL,
  `email` varchar(256) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Restaurant`
--

INSERT INTO `Restaurant` (`restaurant_id_pk`, `name`, `min_order_value`, `shipping_cost`, `max_delivery_range`, `description`, `country`, `postcode`, `city`, `district`, `street_name`, `street_number`, `add_info`, `position_lat`, `position_long`, `offered`, `password`, `session_id`, `region_code`, `national_number`, `email`) VALUES
(1, '鸡排主义', 10, 0, 10000, '奶茶汉堡份量大', '中国', '200240', '上海市', '闵行区', '东川路', '800', NULL, 31.02188, 121.46097, 1, '7c4a8d09ca3762af61e59520943dc26494f8941b', '97053c26f6eb027a0430edc81aa6f6bd8568b126594a4b438a21c69ea3ed24ca', '86', '17336010252', NULL),
(2, '华联生活中心', 25, 10, 20000, '一去不复返的华联', '中国', '', '上海', '闵行区', '东川路', '800', NULL, 31.024933, 121.429943, 1, '7c4a8d09ca3762af61e59520943dc26494f8941b', '43497a7ac44f5a59f367e07039fc791a3a85210bf53a9f5ccf3e9d8d81d44b41', '86', '15800789998', NULL),
(3, '徐汇餐厅', 0, 5, 5000, '吃多了就腻', '中国', '200240', '上海市', '闵行区', '东川路', '800', NULL, 31.19075, 121.4364, 1, '5f4dcc3b5aa765d61d8327deb882cf99', '75a2b6313ea2d41950160cc12678cf12ec461b79', '86', '14893035276', NULL),
(4, '成都饭店', 25, 0, 10000, '欢迎光临', '中国', '200240', '上海', '闵行区', '东川路', '800', NULL, 31.012494, 121.410644, 1, '7c4a8d09ca3762af61e59520943dc26494f8941b', 'fb8d48470302ebde604295b1ffcfcfe5cc8214f3a59cd0ce82f4f742ca20c1ad', '86', '13096883169', NULL),
(5, ' 张姐厨房', 25, 5, 10000, '', '中国', '200240', '上海', '闵行区', '东川路', '800', NULL, 31.007075, 121.420572, 1, '7c4a8d09ca3762af61e59520943dc26494f8941b', '1cad28afade46ee37243892985c934ef4d443384974724f6a582947f22eb82cd', '86', '13096883169', NULL),
(6, '阿康烧烤', 10, 0, 10000, '欢迎光临', '中国', '200240', '上海', '闵行区', '东川路', '800', NULL, 31.0218816, 121.4309663, 1, '7c4a8d09ca3762af61e59520943dc26494f8941b', 'cfa9f76e9a2ee8fce830bec10a807efca0ce5c77c95635322ba7c59052a194e4', '86', '13096883169', NULL),
(7, '家常饭', 10, 1, 10000, '', '中国', '', '上海', '闵行区', '东川路', '800', NULL, 31.024933, 121.429943, 1, '7c4a8d09ca3762af61e59520943dc26494f8941b', '2552f1120019fefe5a4db04c945eb781c810af896d37f03b6e3a408edd88410d', '86', '13096883169', NULL),
(8, '鲜果送', 50, 0, 10000, '美味！', '中国', '', '上海', '闵行区', '东川路', '800', NULL, 31.027474, 121.426087, 1, '7c4a8d09ca3762af61e59520943dc26494f8941b', '6fc001f6202fde707d041aaf48c2b732c8d16fdcdbb35a30f1fecd370fe8d7ab', '86', '13096883169', NULL),
(9, '麦利德', 15, 0, 10000, '', '中国', '200240', '上海', '闵行区', '东川路', '800', NULL, 31.016787, 121.429583, 1, '7c4a8d09ca3762af61e59520943dc26494f8941b', '3b03000402316db7dfb854a9f0abb8d3b85bd893de02bcb3283382eb6275052a', '86', '13096883169', NULL),
(10, '有家饭', 20, 5, 10000, '', '中国', '200240', '上海', '闵行区', '东川路', '800', NULL, 31.0177304, 121.4322453, 1, '7c4a8d09ca3762af61e59520943dc26494f8941b', '8a651e4d8263465e61fc4cd597afb3107a3b6fd5ef594463fba1d4f04b1eb912', '86', '13096883169', NULL),
(11, '百姓人家', 30, 10, 10000, '', '中国', '200240', '上海', '闵行区', '东川路', '800', NULL, 31.0180851, 121.4336476, 1, '7c4a8d09ca3762af61e59520943dc26494f8941b', '765288c09ed134d5ef7780972835c4c6025b3ccac9e516cb924c7bf9ae85f1b0', '86', '13096883169', NULL),
(12, '稻花香', 10, 0, 10000, '', 'ä¸­å›½', '200240', '上海', '闵行区', '东川路', '800', NULL, 31.0171109, 121.4198246, 1, '7c4a8d09ca3762af61e59520943dc26494f8941b', 'ca724b49b9869f521d41cbbf555a8d1b783918c6818e3a91722a28c2807c1492', '86', '13096883169', NULL),
(13, '外婆家', 10, 4, 10000, '', '中国', '200240', '上海', '闵行区', '东川路', '800', NULL, 31.0180851, 121.4336476, 1, '7c4a8d09ca3762af61e59520943dc26494f8941b', '0130dce76ce634209761a5f5501ba3bb64fc861b5fdc177ff8639ff08758fb6d', '86', '13096883169', NULL),
(14, '家门口', 10, 2, 10000, '', '中国', '200240', '上海', '闵行区', '东川路', '800', NULL, 31.0182305, 121.4341035, 1, '7c4a8d09ca3762af61e59520943dc26494f8941b', '16a85eb0cb7eee6fd6632e826069d0452b092fadcd153b68f022d2aacdb63759', '86', '13096883169', NULL),
(17, '豪大大', 15, 0, 10000, '豪大大鸡排', '中国', '200240', '上海', '闵行区', '东川路', '800', NULL, 31.02189, 121.43095, 1, '7c4a8d09ca3762af61e59520943dc26494f8941b', 'e536a7b8e1f16b13cf9347de4486e973186c1e40d638a497f3dd72639cd1da8b', '86', '13567832999', NULL),
(18, 'PIZZAHUT', 20, 20, 5000, 'PIZZAHUT', '&amp;auml;&amp;cedil;&amp;shy;&amp;aring;&amp;rsaquo;&amp;frac12;', '', '&amp;auml;&amp;cedil;&amp;Scaron;&amp;aelig;&amp;micro;&amp;middot;&amp;aring;&amp;cedil;&amp;sbquo;', NULL, '&amp;auml;&amp;cedil;&amp;Scaron;&amp;aelig;&amp;micro;&amp;middot;&amp;aring;&amp;cedil;&amp;sbquo;&amp;eacute;&amp;mdash;&amp;micro;&amp;egrave;&amp;iexcl;&amp;OElig;&amp;aring;&amp;OElig;&amp;ordm;&amp;auml;&amp;cedil;&amp;oelig;&amp;aring;&amp;middot;&', NULL, NULL, 31.018197, 121.419901, 1, '7c4a8d09ca3762af61e59520943dc26494f8941b', 'e02486a4c904e0ba3141faa4ed947a97a9b4cd25ad84d1e474eaf7bf837522d5', '86', '15800789900', NULL),
(19, 'Campus Caffe', 5, 5, 5000, '', 'ä¸­å›½', '', 'åŒ—äº¬å¸‚', NULL, 'åŒ—äº¬å¸‚æµ·æ·€åŒºåŒ—äº¬å¤§å­¦', NULL, NULL, 39.99281, 116.31088, 1, '7c4a8d09ca3762af61e59520943dc26494f8941b', '1479301ff42e3919ca75215c6a82da5353ad5e19ddb706d1ba6b1b3c60efd0c0', '86', '13419900978', NULL);

--
-- Triggers `Restaurant`
--
DELIMITER $$
CREATE TRIGGER `restaurant_constraints` BEFORE INSERT ON `restaurant`
 FOR EACH ROW BEGIN

    DECLARE msg VARCHAR(255);

    IF !(NEW.shipping_cost >= 0 &&

        NEW.min_order_value >= 0 &&

        NEW.max_delivery_range >= 0 &&

        NEW.position_lat >= 0 &&

        NEW.position_long >= 0)

    THEN

        SET msg = "DIE: You inserted a resctricted VALUE";

        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;

    END IF;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Tag`
--

CREATE TABLE IF NOT EXISTS `Tag` (
  `tag_id_pk` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `color` varchar(6) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Tag`
--

INSERT INTO `Tag` (`tag_id_pk`, `name`, `color`) VALUES
(1, '高能高脂', 'FF4040'),
(2, '健康素食', '9AFF9A'),
(3, '甜品', 'FFAEB9'),
(4, '凉菜', '9AC0CD'),
(5, '饮料', '00B2EE');

-- --------------------------------------------------------

--
-- Structure for view `delivery_state_view`
--
DROP TABLE IF EXISTS `delivery_state_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `delivery_state_view` AS select `ds`.`Delivery_delivery_id_pk` AS `Delivery_delivery_id_pk`,`ds`.`date_pk` AS `date_pk`,`dst`.`name` AS `delivery_status_type`,`ds`.`comment` AS `comment` from (`delivery_state` `ds` join `delivery_state_type` `dst` on((`ds`.`Delivery_State_Type_delivery_status_type` = `dst`.`delivery_status_type_id_pk`)));

-- --------------------------------------------------------

--
-- Structure for view `delivery_view`
--
DROP TABLE IF EXISTS `delivery_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `delivery_view` AS select `d`.`delivery_id_pk` AS `delivery_id_pk`,`d`.`Customer_customer_id` AS `Customer_customer_id`,`d`.`Restaurant_restaurant_id` AS `Restaurant_restaurant_id`,`d`.`country` AS `country`,`d`.`postcode` AS `postcode`,`d`.`city` AS `city`,`d`.`district` AS `district`,`d`.`street_name` AS `street_name`,`d`.`street_number` AS `street_number`,`d`.`add_info` AS `add_info`,`d`.`comment` AS `comment`,`ds`.`date_pk` AS `date_pk`,`ds`.`Delivery_State_Type_delivery_status_type` AS `delivery_status_type_number`,`dst`.`name` AS `delivery_status_type`,`ds`.`comment` AS `delivery_state_comment` from ((`delivery_state` `ds` join `delivery_state_type` `dst` on((`ds`.`Delivery_State_Type_delivery_status_type` = `dst`.`delivery_status_type_id_pk`))) join `delivery` `d` on((`d`.`delivery_id_pk` = `ds`.`Delivery_delivery_id_pk`)));

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Customer`
--
ALTER TABLE `Customer`
  ADD PRIMARY KEY (`customer_id_pk`),
  ADD UNIQUE KEY `nick_UNIQUE` (`nick`);

--
-- Indexes for table `Delivery`
--
ALTER TABLE `Delivery`
  ADD PRIMARY KEY (`delivery_id_pk`),
  ADD KEY `fk_User_has_Restaurant_Restaurant1_idx` (`Restaurant_restaurant_id`),
  ADD KEY `fk_delivery_users1_idx` (`Customer_customer_id`);

--
-- Indexes for table `Delivery_Meal_Map`
--
ALTER TABLE `Delivery_Meal_Map`
  ADD PRIMARY KEY (`Delivery_delivery_id_pk`,`Meal_meal_id_pk`),
  ADD KEY `fk_delivery_has_dish_dish1_idx` (`Meal_meal_id_pk`),
  ADD KEY `fk_delivery_has_dish_delivery1_idx` (`Delivery_delivery_id_pk`);

--
-- Indexes for table `Delivery_State`
--
ALTER TABLE `Delivery_State`
  ADD PRIMARY KEY (`Delivery_delivery_id_pk`,`date_pk`),
  ADD KEY `fk_DeliveryState_delivery1_idx` (`Delivery_delivery_id_pk`),
  ADD KEY `fk_delivery_state_delivery_state_type1_idx` (`Delivery_State_Type_delivery_status_type`);

--
-- Indexes for table `Delivery_State_Type`
--
ALTER TABLE `Delivery_State_Type`
  ADD PRIMARY KEY (`delivery_status_type_id_pk`);

--
-- Indexes for table `Meal`
--
ALTER TABLE `Meal`
  ADD PRIMARY KEY (`meal_id_pk`),
  ADD KEY `fk_Menu_Restaurant1_idx` (`Restaurant_restaurant_id`);

--
-- Indexes for table `Meal_Tag_Map`
--
ALTER TABLE `Meal_Tag_Map`
  ADD PRIMARY KEY (`Meal_meal_id_pk`,`Tag_tag_id_pk`),
  ADD KEY `fk_dish_has_tag_tag1_idx` (`Tag_tag_id_pk`),
  ADD KEY `fk_dish_has_tag_dish1_idx` (`Meal_meal_id_pk`);

--
-- Indexes for table `Rating`
--
ALTER TABLE `Rating`
  ADD PRIMARY KEY (`Customer_customer_id_pk`,`Meal_meal_id_pk`),
  ADD KEY `fk_Rating_dish1_idx` (`Meal_meal_id_pk`),
  ADD KEY `fk_Rating_user1_idx` (`Customer_customer_id_pk`);

--
-- Indexes for table `Restaurant`
--
ALTER TABLE `Restaurant`
  ADD PRIMARY KEY (`restaurant_id_pk`);

--
-- Indexes for table `Tag`
--
ALTER TABLE `Tag`
  ADD PRIMARY KEY (`tag_id_pk`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Customer`
--
ALTER TABLE `Customer`
  MODIFY `customer_id_pk` int(11) NOT NULL AUTO_INCREMENT COMMENT 'used as identifer.\nthere may be no two users with the same number\nhas to be double because with in we just can represent 10 digits, but chinese phone numbers have 11 digits\na list as representation would take more space',AUTO_INCREMENT=34;
--
-- AUTO_INCREMENT for table `Delivery`
--
ALTER TABLE `Delivery`
  MODIFY `delivery_id_pk` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT for table `Delivery_State_Type`
--
ALTER TABLE `Delivery_State_Type`
  MODIFY `delivery_status_type_id_pk` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `Meal`
--
ALTER TABLE `Meal`
  MODIFY `meal_id_pk` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=106;
--
-- AUTO_INCREMENT for table `Restaurant`
--
ALTER TABLE `Restaurant`
  MODIFY `restaurant_id_pk` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT for table `Tag`
--
ALTER TABLE `Tag`
  MODIFY `tag_id_pk` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `Delivery`
--
ALTER TABLE `Delivery`
  ADD CONSTRAINT `fk_User_has_Restaurant_Restaurant1` FOREIGN KEY (`Restaurant_restaurant_id`) REFERENCES `Restaurant` (`restaurant_id_pk`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_delivery_users1` FOREIGN KEY (`Customer_customer_id`) REFERENCES `Customer` (`customer_id_pk`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Delivery_Meal_Map`
--
ALTER TABLE `Delivery_Meal_Map`
  ADD CONSTRAINT `fk_delivery_has_dish_delivery1` FOREIGN KEY (`Delivery_delivery_id_pk`) REFERENCES `Delivery` (`delivery_id_pk`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_delivery_has_dish_dish1` FOREIGN KEY (`Meal_meal_id_pk`) REFERENCES `Meal` (`meal_id_pk`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Delivery_State`
--
ALTER TABLE `Delivery_State`
  ADD CONSTRAINT `fk_DeliveryState_delivery1` FOREIGN KEY (`Delivery_delivery_id_pk`) REFERENCES `Delivery` (`delivery_id_pk`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_delivery_state_delivery_state_type1` FOREIGN KEY (`Delivery_State_Type_delivery_status_type`) REFERENCES `Delivery_State_Type` (`delivery_status_type_id_pk`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Meal`
--
ALTER TABLE `Meal`
  ADD CONSTRAINT `fk_Menu_Restaurant1` FOREIGN KEY (`Restaurant_restaurant_id`) REFERENCES `Restaurant` (`restaurant_id_pk`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Meal_Tag_Map`
--
ALTER TABLE `Meal_Tag_Map`
  ADD CONSTRAINT `fk_dish_has_tag_dish1` FOREIGN KEY (`Meal_meal_id_pk`) REFERENCES `Meal` (`meal_id_pk`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_dish_has_tag_tag1` FOREIGN KEY (`Tag_tag_id_pk`) REFERENCES `Tag` (`tag_id_pk`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `Rating`
--
ALTER TABLE `Rating`
  ADD CONSTRAINT `fk_Rating_dish1` FOREIGN KEY (`Meal_meal_id_pk`) REFERENCES `Meal` (`meal_id_pk`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Rating_user1` FOREIGN KEY (`Customer_customer_id_pk`) REFERENCES `Customer` (`customer_id_pk`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

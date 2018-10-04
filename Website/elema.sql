

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;

SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;

SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';



CREATE SCHEMA IF NOT EXISTS `elema` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;

USE `elema` ;



-- -----------------------------------------------------

-- Table `elema`.`Restaurant`

-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `elema`.`Restaurant` (

  `restaurant_id_pk` INT NOT NULL AUTO_INCREMENT,

  `name` VARCHAR(256) NOT NULL,

  `min_order_value` FLOAT UNSIGNED NOT NULL,

  `shipping_cost` FLOAT UNSIGNED NOT NULL COMMENT 'must be >= 0\n',

  `max_delivery_range` INT NOT NULL COMMENT 'in kilometers, \nadditional enums like:\ncitys, districts\nin 100 meter steps',

  `description` TEXT NULL,

  `country` VARCHAR(256) NOT NULL,

  `postcode` VARCHAR(45) NOT NULL,

  `city` VARCHAR(256) NULL,

  `district` VARCHAR(45) NULL,

  `street_name` VARCHAR(256) NOT NULL,

  `street_number` VARCHAR(45) NULL,

  `add_info` VARCHAR(256) NULL,

  `position_lat` DOUBLE NULL,

  `position_long` DOUBLE NULL,

  `offered` TINYINT(1) NULL DEFAULT 1 COMMENT 'Describes if a current restaurant an',

  `password` VARCHAR(256) NOT NULL,

  `session_id` VARCHAR(64) NULL COMMENT 'unique and truly random 256 key',

  `region_code` VARCHAR(3) NOT NULL,

  `national_number` VARCHAR(15) NOT NULL,

  `email` VARCHAR(256) NULL,

  PRIMARY KEY (`restaurant_id_pk`))

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `elema`.`Customer`

-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `elema`.`Customer` (

  `customer_id_pk` INT NOT NULL AUTO_INCREMENT COMMENT 'used as identifer.\nthere may be no two users with the same number\nhas to be double because with in we just can represent 10 digits, but chinese phone numbers have 11 digits\na list as representation would take more space',

  `region_code` VARCHAR(3) NOT NULL COMMENT 'the region code of the phone number',

  `national_number` VARCHAR(15) NOT NULL,

  `last_name` VARCHAR(256) NOT NULL,

  `first_name` VARCHAR(256) NOT NULL,

  `nick` VARCHAR(45) NOT NULL COMMENT 'the nickname of the user\ndefault is combination of name',

  `password` VARCHAR(256) NOT NULL,

  `session_id` VARCHAR(64) NULL COMMENT 'unique and truly random 256 key',

  `email` VARCHAR(256) NULL,

  PRIMARY KEY (`customer_id_pk`),

  UNIQUE INDEX `nick_UNIQUE` (`nick` ASC))

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `elema`.`Meal`

-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `elema`.`Meal` (

  `meal_id_pk` INT NOT NULL AUTO_INCREMENT,

  `Restaurant_restaurant_id` INT NOT NULL,

  `name` VARCHAR(256) NOT NULL,

  `price` VARCHAR(45) NOT NULL,

  `description` TEXT NULL DEFAULT NULL COMMENT 'optional',

  `spiciness` TINYINT UNSIGNED NULL COMMENT 'Range 0-3',

  `offered` TINYINT(1) NULL DEFAULT 1,

  PRIMARY KEY (`meal_id_pk`),

  INDEX `fk_Menu_Restaurant1_idx` (`Restaurant_restaurant_id` ASC),

  CONSTRAINT `fk_Menu_Restaurant1`

    FOREIGN KEY (`Restaurant_restaurant_id`)

    REFERENCES `elema`.`Restaurant` (`restaurant_id_pk`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `elema`.`Delivery`

-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `elema`.`Delivery` (

  `delivery_id_pk` INT NOT NULL AUTO_INCREMENT,

  `Customer_customer_id` INT NOT NULL,

  `Restaurant_restaurant_id` INT NOT NULL,

  `country` VARCHAR(256) NOT NULL,

  `postcode` VARCHAR(45) NOT NULL,

  `city` VARCHAR(256) NULL,

  `district` VARCHAR(45) NULL,

  `street_name` VARCHAR(256) NOT NULL,

  `street_number` VARCHAR(45) NULL,

  `add_info` VARCHAR(256) NULL,

  `comment` VARCHAR(256) NULL,

  PRIMARY KEY (`delivery_id_pk`),

  INDEX `fk_User_has_Restaurant_Restaurant1_idx` (`Restaurant_restaurant_id` ASC),

  INDEX `fk_delivery_users1_idx` (`Customer_customer_id` ASC),

  CONSTRAINT `fk_User_has_Restaurant_Restaurant1`

    FOREIGN KEY (`Restaurant_restaurant_id`)

    REFERENCES `elema`.`Restaurant` (`restaurant_id_pk`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_delivery_users1`

    FOREIGN KEY (`Customer_customer_id`)

    REFERENCES `elema`.`Customer` (`customer_id_pk`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `elema`.`Rating`

-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `elema`.`Rating` (

  `Meal_meal_id_pk` INT NOT NULL,

  `Customer_customer_id_pk` INT NOT NULL,

  `date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

  `rating` TINYINT NOT NULL COMMENT 'not be bigger than 5',

  `comment` TEXT NULL,

  PRIMARY KEY (`Customer_customer_id_pk`, `Meal_meal_id_pk`),

  INDEX `fk_Rating_dish1_idx` (`Meal_meal_id_pk` ASC),

  INDEX `fk_Rating_user1_idx` (`Customer_customer_id_pk` ASC),

  CONSTRAINT `fk_Rating_dish1`

    FOREIGN KEY (`Meal_meal_id_pk`)

    REFERENCES `elema`.`Meal` (`meal_id_pk`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_Rating_user1`

    FOREIGN KEY (`Customer_customer_id_pk`)

    REFERENCES `elema`.`Customer` (`customer_id_pk`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB

COMMENT = 'Every user can rate a dish just once';





-- -----------------------------------------------------

-- Table `elema`.`Delivery_State_Type`

-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `elema`.`Delivery_State_Type` (

  `delivery_status_type_id_pk` INT NOT NULL AUTO_INCREMENT,

  `name` VARCHAR(256) NULL,

  PRIMARY KEY (`delivery_status_type_id_pk`))

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `elema`.`Delivery_State`

-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `elema`.`Delivery_State` (

  `Delivery_delivery_id_pk` INT NOT NULL,

  `date_pk` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

  `Delivery_State_Type_delivery_status_type` INT NOT NULL,

  `comment` VARCHAR(256) NULL,

  PRIMARY KEY (`Delivery_delivery_id_pk`, `date_pk`),

  INDEX `fk_DeliveryState_delivery1_idx` (`Delivery_delivery_id_pk` ASC),

  INDEX `fk_delivery_state_delivery_state_type1_idx` (`Delivery_State_Type_delivery_status_type` ASC),

  CONSTRAINT `fk_DeliveryState_delivery1`

    FOREIGN KEY (`Delivery_delivery_id_pk`)

    REFERENCES `elema`.`Delivery` (`delivery_id_pk`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_delivery_state_delivery_state_type1`

    FOREIGN KEY (`Delivery_State_Type_delivery_status_type`)

    REFERENCES `elema`.`Delivery_State_Type` (`delivery_status_type_id_pk`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `elema`.`Delivery_Meal_Map`

-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `elema`.`Delivery_Meal_Map` (

  `Delivery_delivery_id_pk` INT NOT NULL,

  `Meal_meal_id_pk` INT NOT NULL,

  `amount` INT NOT NULL,

  PRIMARY KEY (`Delivery_delivery_id_pk`, `Meal_meal_id_pk`),

  INDEX `fk_delivery_has_dish_dish1_idx` (`Meal_meal_id_pk` ASC),

  INDEX `fk_delivery_has_dish_delivery1_idx` (`Delivery_delivery_id_pk` ASC),

  CONSTRAINT `fk_delivery_has_dish_delivery1`

    FOREIGN KEY (`Delivery_delivery_id_pk`)

    REFERENCES `elema`.`Delivery` (`delivery_id_pk`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_delivery_has_dish_dish1`

    FOREIGN KEY (`Meal_meal_id_pk`)

    REFERENCES `elema`.`Meal` (`meal_id_pk`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `elema`.`Tag`

-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `elema`.`Tag` (

  `tag_id_pk` INT NOT NULL AUTO_INCREMENT,

  `name` VARCHAR(45) NULL,

  `color` VARCHAR(6) NULL,

  PRIMARY KEY (`tag_id_pk`))

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `elema`.`Meal_Tag_Map`

-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `elema`.`Meal_Tag_Map` (

  `Meal_meal_id_pk` INT NOT NULL,

  `Tag_tag_id_pk` INT NOT NULL,

  PRIMARY KEY (`Meal_meal_id_pk`, `Tag_tag_id_pk`),

  INDEX `fk_dish_has_tag_tag1_idx` (`Tag_tag_id_pk` ASC),

  INDEX `fk_dish_has_tag_dish1_idx` (`Meal_meal_id_pk` ASC),

  CONSTRAINT `fk_dish_has_tag_dish1`

    FOREIGN KEY (`Meal_meal_id_pk`)

    REFERENCES `elema`.`Meal` (`meal_id_pk`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_dish_has_tag_tag1`

    FOREIGN KEY (`Tag_tag_id_pk`)

    REFERENCES `elema`.`Tag` (`tag_id_pk`)

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB

COMMENT = 'A dish is never tagged twice with the same tag';





SET SQL_MODE=@OLD_SQL_MODE;

SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;

SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

CREATE USER 'elema_admin'@'localhost' IDENTIFIED BY 'u9wZpVbs7xbD45JR';

GRANT USAGE ON *.* TO 'elema_admin'@'localhost' IDENTIFIED BY 'u9wZpVbs7xbD45JR';

GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER, CREATE TEMPORARY TABLES, EXECUTE, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, EVENT, TRIGGER ON `elema`.* TO 'elema_admin'@'localhost';

CREATE USER 'elema_user'@'localhost' IDENTIFIED BY 'rNMe3c8NtWSAdh40';

GRANT SELECT, INSERT, DELETE, UPDATE, EXECUTE ON elema.* TO 'elema_user'@'localhost';



USE `elema` ;



-- created after http://www.movable-type.co.uk/scripts/latlong.html

DROP FUNCTION IF EXISTS DISTANCE;

DELIMITER $$

CREATE FUNCTION DISTANCE(lat1 DOUBLE, long1 DOUBLE, lat2 DOUBLE, long2 DOUBLE)

  RETURNS FLOAT

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

END;

$$

DELIMITER ;

-- phpMyAdmin SQL Dump

-- version 4.0.10deb1

-- http://www.phpmyadmin.net

--

-- Host: localhost

-- Generation Time: May 30, 2017 at 04:22 PM

-- Server version: 5.5.43-0ubuntu0.14.04.1

-- PHP Version: 5.5.9-1ubuntu4.9



SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";

SET time_zone = "+00:00";





/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;

/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;

/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;

/*!40101 SET NAMES utf8 */;



--

-- Database: `elema`

--



--

-- Dumping data for table `Tag`

--



INSERT INTO `Tag` (`tag_id_pk`, `name`, `color`) VALUES

(1, '高能高脂', 'cc7a00'),

(2, '健康素食', '009900'),

(3, '甜品', 'ff8080'),

(4, '凉菜', '668cff'),

(5, '饮料', 'ff3333');



/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;

/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump

-- version 4.0.10deb1

-- http://www.phpmyadmin.net

--

-- Host: localhost

-- Generation Time: Jun 02, 2017 at 03:14 PM

-- Server version: 5.5.43-0ubuntu0.14.04.1

-- PHP Version: 5.5.9-1ubuntu4.9



SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";

SET time_zone = "+00:00";





/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;

/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;

/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;

/*!40101 SET NAMES utf8 */;



--

-- Database: `elema`

--



--

-- Dumping data for table `Delivery_State_Type`

--



INSERT INTO `Delivery_State_Type` (`delivery_status_type_id_pk`, `name`) VALUES

(1, '待接单'),

(2, '制作中'),

(3, '配送中'),

(4, '已完成');



/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;

/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump

-- version 4.2.11

-- http://www.phpmyadmin.net

--

-- Host: localhost

-- Generation Time: Jul 02, 2017 at 08:50 AM

-- Server version: 5.6.21

-- PHP Version: 5.6.3



SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";

SET time_zone = "+00:00";





/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;

/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;

/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;

/*!40101 SET NAMES utf8 */;



--

-- Database: `elema`

--



-- --------------------------------------------------------



--

-- Dumping data for table `Restaurant`

--



INSERT INTO `Restaurant` (`restaurant_id_pk`, `name`, `min_order_value`, `shipping_cost`, `max_delivery_range`, `description`, `country`, `postcode`, `city`, `district`, `street_name`, `street_number`, `add_info`, `position_lat`, `position_long`, `offered`, `password`, `session_id`, `region_code`, `national_number`, `email`) VALUES

(1, '华联', 10, 0, 10000, '奶茶汉堡份量大', '中国', '200240', '上海市', '闵行区', '东川路', '800', NULL, 31.02188, 121.43097, 1, '098f6bcd4621d373cade4e832627b4f6', '26dfe8116b93ced6cfca858f375d23f1489d3207', '86', '17336010252', NULL),

(2, '一餐', 25, 10, 20000, '又贵又难吃', '中国', '200240', '上海市', '闵行区', '东川路', '800', NULL, 31.19875, 121.4364, 1, 'bdc87b9c894da5168059e00ebffb9077', '4570258f13c64eefb56a26bac08093636f0fc102', '86', '17455250768', NULL),

(3, '二餐', 0, 5, 5000, '吃多了就腻', '中国', '200240', '上海市', '闵行区', '东川路', '800', NULL, 31.19075, 121.4364, 1, '5f4dcc3b5aa765d61d8327deb882cf99', '75a2b6313ea2d41950160cc12678cf12ec461b79', '86', '14893035276', NULL),

(4, '三餐', 25, 0, 10000, '一言难尽', '中国', '200240', '上海市', '闵行区', '东川路', '800', NULL, 31.012494, 121.410644, 1, '7c4a8d09ca3762af61e59520943dc26494f8941b', 'bcc87b640667c0ca1a2d998ccd07fb1cb91821ef84031084fbb3ff45613a8cc5', '86', '13096883169', NULL),

(5, '四餐', 25, 5, 10000, '交大餐饮领导者', '中国', '200240', '上海市', '闵行区', '东川路', '800', NULL, 31.007075, 121.420572, 1, '7c4a8d09ca3762af61e59520943dc26494f8941b', 'aee0384e9238d080309c28a01aa3c9a9e0c148edbb279567208fcab37bae7275', '86', '13096883169', NULL),

(6, '五餐', 10, 0, 10000, '交大餐饮界良心', '中国', '200240', '上海市', '闵行区', '东川路', '800', NULL, 31.0218816, 121.4309663, 1, '0', '884006e0cb074556c26c22e0aee3c6b7b5307adf192cb1775b4bef6303486c61', '86', '13096883169', NULL),

(7, '六餐', 10, 0, 10000, '喵喵喵', '中国', '200240', '上海市', '闵行区', '东川路', '800', NULL, 31.0218816, 121.4309663, 1, '7c4a8d09ca3762af61e59520943dc26494f8941b', '247ccce33e9558df4666b2f8ebdcf31f8acfa47fbb79d1a91343f02283f8f388', '86', '13096883169', NULL),

(8, '哈乐餐厅', 50, 0, 10000, '什么都好除了排队', '中国', '200240', '上海市', '闵行区', '东川路', '800', NULL, 31.0218816, 121.4309663, 1, '7c4a8d09ca3762af61e59520943dc26494f8941b', '6ce9700bba683d8ef6c10731dfa64242dbcf9f006ef4cd42cefc195630dd3e4b', '86', '13096883169', NULL),

(9, '吉姆利得', 15, 0, 10000, '我发誓我和必胜客没关系', '中国', '200240', '上海市', '闵行区', '东川路', '800', NULL, 31.016787, 121.429583, 1, '7c4a8d09ca3762af61e59520943dc26494f8941b', '7bfeff713839c3dd5472677c6fc75024ae75724ab16ec59cf9cd58fc913dd4fc', '86', '13096883169', NULL),

(10, '华莱士', 20, 5, 10000, '比你们不知道高到哪里去了', '中国', '200240', '上海市', '闵行区', '东川路', '800', NULL, 31.0177304, 121.4322453, 1, '7c4a8d09ca3762af61e59520943dc26494f8941b', 'd291bdac0b2b2693e97efa6d00bef2b7bfe8858f0d1ad95212594c241ff74ed3', '86', '13096883169', NULL),

(11, '川菜馆', 30, 10, 10000, '四川唯一指定供菜商', '中国', '200240', '上海市', '闵行区', '东川路', '800', NULL, 31.0180851, 121.4336476, 1, '7c4a8d09ca3762af61e59520943dc26494f8941b', '16eb04e6f154843bef1dfffcb42e734b8bafc91d4eb62a4506fd4613247f390f', '86', '13096883169', NULL),

(12, '粤菜馆', 10, 0, 10000, '福建人真好吃', '中国', '200240', '上海市', '闵行区', '东川路', '800', NULL, 31.0171109, 121.4198246, 1, '7c4a8d09ca3762af61e59520943dc26494f8941b', '206379db4227f79e2faa00fbc6fbb32ffdd7b4244b56d83af88ca29e9976182b', '86', '13096883169', NULL),

(13, '湘菜馆', 10, 4, 10000, '毛氏臭豆腐行业领导者', '中国', '200240', '上海市', '闵行区', '东川路', '800', NULL, 31.0180851, 121.4336476, 1, '7c4a8d09ca3762af61e59520943dc26494f8941b', '6f23f21851d85f949387fefcc40521c7209f54f2e25b90b124185c1e9a19f37b', '86', '13096883169', NULL),

(14, '杭帮菜', 10, 2, 10000, '其实我叫外婆家', '中国', '200240', '上海市', '闵行区', '东川路', '800', NULL, 31.0182305, 121.4341035, 1, '7c4a8d09ca3762af61e59520943dc26494f8941b', '1c8f85a0eb09a5dc493e69deb6794dd832fcae282c848d7efc8ba5c87df337bd', '86', '13096883169', NULL);



/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;

/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump

-- version 4.0.10deb1

-- http://www.phpmyadmin.net

--

-- Host: localhost

-- Generation Time: Jul 02, 2017 at 02:02 PM

-- Server version: 5.5.43-0ubuntu0.14.04.1-log

-- PHP Version: 5.5.9-1ubuntu4.9



SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";

SET time_zone = "+00:00";





/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;

/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;

/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;

/*!40101 SET NAMES utf8 */;



--

-- Database: `elema`

--



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

(30, '86', '12108978467', '魏', '一', 'tencent', '7c4a8d09ca3762af61e59520943dc26494f8941b', NULL, 'flappybird@gmail.com');



-- phpMyAdmin SQL Dump

-- version 4.0.10deb1

-- http://www.phpmyadmin.net

--

-- Host: localhost

-- Generation Time: Jul 02, 2017 at 02:49 PM

-- Server version: 5.5.43-0ubuntu0.14.04.1-log

-- PHP Version: 5.5.9-1ubuntu4.9



SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";

SET time_zone = "+00:00";





/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;

/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;

/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;

/*!40101 SET NAMES utf8 */;



--

-- Database: `elema`

--



--

-- Dumping data for table `Meal`

--



INSERT INTO `Meal` (`meal_id_pk`, `Restaurant_restaurant_id`, `name`, `price`, `description`, `spiciness`, `offered`) VALUES

(1, 1, '薯条', '9', '油炸薯条', 0, 1),

(2, 1, '香辣鸡腿堡', '8', '辣的汉堡', 0, 1),

(3, 1, '无骨香酥腿排', '9', '没有骨头', 0, 1),

(4, 1, '霸王鸡腿', '9', '项羽之腿', 0, 1),

(5, 1, '百事可乐', '6', '可乐不加冰', 0, 1),

(6, 1, '玉米香肠', '4', '正宗双汇玉米肠', 0, 1),

(7, 1, '墨西哥鸡肉卷', '9', '据说去不了美国就只能来中国', 0, 1),

(8, 1, '手抓饼', '6', '华联之后', 0, 1),

(9, 1, '里脊肉', '5', '3串1份', 0, 1),

(10, 1, '双皮奶', '8', '不是双皮不要钱', 0, 1),



(11, 2, '非常咸的麻辣香锅', '14', NULL , 0, 1),

(12, 2, '非常油的盖饭', '12', NULL , 0, 1),

(13, 2, '非常奇怪的米线', '14', NULL , 0, 1),

(14, 2, '非常稀的粥', '12', NULL , 0, 1),

(15, 2, '非常重口的锅仔', '14', NULL , 0, 1),

(16, 2, '非常软的面条', '11', NULL , 0, 1),

(17, 2, '非常冷的毛豆', '11', NULL , 0, 1),



(18, 3, '米饭', '1', NULL , 0, 1),

(19, 3, '面条', '4', NULL , 0, 1),

(20, 3, '青菜', '2', NULL , 0, 1),

(21, 3, '红烧肉', '8', NULL , 0, 1),

(22, 3, '鸡排', '8', NULL , 0, 1),

(23, 3, '西红柿鸡蛋', '5', NULL , 0, 1),

(24, 3, '咖喱', '8', NULL , 0, 1),



(25, 4, '米饭', '1', NULL , 0, 1),

(26, 4, '面条', '4', NULL , 0, 1),

(27, 4, '青菜', '2', NULL , 0, 1),

(28, 4, '红烧肉', '8', NULL , 0, 1),

(29, 4, '鸡排', '8', NULL , 0, 1),

(30, 4, '西红柿鸡蛋', '5', NULL , 0, 1),

(31, 4, '咖喱', '8', NULL , 0, 1),



(32, 5, '米饭', '1', NULL , 0, 1),

(33, 5, '面条', '4', NULL , 0, 1),

(34, 5, '青菜', '2', NULL , 0, 1),

(35, 5, '红烧肉', '8', NULL , 0, 1),

(36, 5, '鸡排', '8', NULL , 0, 1),

(37, 5, '西红柿鸡蛋', '5', NULL , 0, 1),

(38, 5, '咖喱', '8', NULL , 0, 1),



(39, 6, '米饭', '1', NULL , 0, 1),

(40, 6, '面条', '4', NULL , 0, 1),

(41, 6, '青菜', '2', NULL , 0, 1),

(42, 6, '红烧肉', '8', NULL , 0, 1),

(43, 6, '鸡排', '8', NULL , 0, 1),

(44, 6, '西红柿鸡蛋', '5', NULL , 0, 1),

(45, 6, '咖喱', '8', NULL , 0, 1),



(46, 7, '米饭', '1', NULL , 0, 1),

(47, 7, '面条', '4', NULL , 0, 1),

(48, 7, '青菜', '2', NULL , 0, 1),

(49, 7, '红烧肉', '8', NULL , 0, 1),

(50, 7, '鸡排', '8', NULL , 0, 1),

(51, 7, '西红柿鸡蛋', '5', NULL , 0, 1),

(52, 7, '咖喱', '8', NULL , 0, 1),



(53, 8, '米饭', '1', NULL , 0, 1),

(54, 8, '面条', '4', NULL , 0, 1),

(55, 8, '青菜', '2', NULL , 0, 1),

(56, 8, '红烧肉', '8', NULL , 0, 1),

(57, 8, '鸡排', '8', NULL , 0, 1),

(58, 8, '西红柿鸡蛋', '5', NULL , 0, 1),

(59, 8, '咖喱', '8', NULL , 0, 1),



(60, 9, '米饭', '1', NULL , 0, 1),

(61, 9, '面条', '4', NULL , 0, 1),

(62, 9, '青菜', '2', NULL , 0, 1),

(63, 9, '红烧肉', '8', NULL , 0, 1),

(64, 9, '鸡排', '8', NULL , 0, 1),

(65, 9, '西红柿鸡蛋', '5', NULL , 0, 1),

(66, 9, '咖喱', '8', NULL , 0, 1),



(67, 10, '米饭', '1', NULL , 0, 1),

(68, 10, '面条', '4', NULL , 0, 1),

(69, 10, '青菜', '2', NULL , 0, 1),

(70, 10, '红烧肉', '8', NULL , 0, 1),

(71, 10, '鸡排', '8', NULL , 0, 1),

(72, 10, '西红柿鸡蛋', '5', NULL , 0, 1),

(73, 10, '咖喱', '8', NULL , 0, 1),



(74, 11, '米饭', '1', NULL , 0, 1),

(75, 11, '面条', '4', NULL , 0, 1),

(76, 11, '青菜', '2', NULL , 0, 1),

(77, 11, '红烧肉', '8', NULL , 0, 1),

(78, 11, '鸡排', '8', NULL , 0, 1),

(79, 11, '西红柿鸡蛋', '5', NULL , 0, 1),

(80, 11, '咖喱', '8', NULL , 0, 1),



(81, 12, '米饭', '1', NULL , 0, 1),

(82, 12, '面条', '4', NULL , 0, 1),

(83, 12, '青菜', '2', NULL , 0, 1),

(84, 12, '红烧肉', '8', NULL , 0, 1),

(85, 12, '鸡排', '8', NULL , 0, 1),

(86, 12, '西红柿鸡蛋', '5', NULL , 0, 1),

(87, 12, '咖喱', '8', NULL , 0, 1),



(88, 13, '米饭', '1', NULL , 0, 1),

(89, 13, '面条', '4', NULL , 0, 1),

(90, 13, '青菜', '2', NULL , 0, 1),

(91, 13, '红烧肉', '8', NULL , 0, 1),

(92, 13, '鸡排', '8', NULL , 0, 1),

(93, 13, '西红柿鸡蛋', '5', NULL , 0, 1),

(94, 13, '咖喱', '8', NULL , 0, 1),



(95, 14, '米饭', '1', NULL , 0, 1),

(96, 14, '面条', '4', NULL , 0, 1),

(97, 14, '青菜', '2', NULL , 0, 1),

(98, 14, '红烧肉', '8', NULL , 0, 1),

(99, 14, '鸡排', '8', NULL , 0, 1),

(100, 14, '西红柿鸡蛋', '5', NULL , 0, 1),

(101, 14, '咖喱', '8', NULL , 0, 1);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;

/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump

-- version 4.0.10deb1

-- http://www.phpmyadmin.net

--

-- Host: localhost

-- Generation Time: Jun 02, 2017 at 04:22 PM

-- Server version: 5.5.43-0ubuntu0.14.04.1

-- PHP Version: 5.5.9-1ubuntu4.9



SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";

SET time_zone = "+00:00";





/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;

/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;

/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;

/*!40101 SET NAMES utf8 */;



--

-- Database: `elema`

--



--

-- Dumping data for table `Meal_Tag_Map`

--



INSERT INTO `Meal_Tag_Map` (`Meal_meal_id_pk`, `Tag_tag_id_pk`) VALUES

(1, 1),

(2, 1),

(3, 1),

(4, 1),

(5, 5),

(6, 1),

(7, 1),

(8, 1),

(9, 1),

(10, 3),

(11, 1),

(12, 1),

(13, 2),

(14, 2),

(15, 1),

(16, 2),

(17, 4),

(20, 2),

(21, 1),

(22, 1);


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;

/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump

-- version 4.0.10deb1

-- http://www.phpmyadmin.net

--

-- Host: localhost

-- Generation Time: Jun 02, 2017 at 08:16 PM

-- Server version: 5.5.43-0ubuntu0.14.04.1

-- PHP Version: 5.5.9-1ubuntu4.9



SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";

SET time_zone = "+00:00";





/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;

/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;

/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;

/*!40101 SET NAMES utf8 */;



--

-- Database: `elema`

--



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

(16, 11, 8, '中国', '200240', '上海市', '闵行区', '东川路', '728', NULL, NULL);



/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;

/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump

-- version 4.0.10deb1

-- http://www.phpmyadmin.net

--

-- Host: localhost

-- Generation Time: Jun 02, 2017 at 08:30 PM

-- Server version: 5.5.43-0ubuntu0.14.04.1

-- PHP Version: 5.5.9-1ubuntu4.9



SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";

SET time_zone = "+00:00";





/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;

/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;

/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;

/*!40101 SET NAMES utf8 */;



--

-- Database: `elema`

--



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

(16, '2017-06-15 17:15:03', 4, NULL);





/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;

/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump

-- version 4.0.10deb1

-- http://www.phpmyadmin.net

--

-- Host: localhost

-- Generation Time: Jun 02, 2017 at 08:31 PM

-- Server version: 5.5.43-0ubuntu0.14.04.1

-- PHP Version: 5.5.9-1ubuntu4.9



SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";

SET time_zone = "+00:00";





/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;

/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;

/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;

/*!40101 SET NAMES utf8 */;



--

-- Database: `elema`

--



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



(4,71,1),



(5,78,1),

(5,79,2),

(5,80,2),



(6,14,1),

(6,13,1),



(7,16,1),

(7,21,2),



(8,22,5),

(8,24,3),



(9,30,2),

(9,31,2),

(9,33,2),



(10,38,1),



(11,47,10),



(12,53,1),



(13,60,2),



(14,65,7),



(15,73,1),

(15,74,1),

(15,75,1),



(16,28,100);



/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;

/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump

-- version 4.0.10deb1

-- http://www.phpmyadmin.net

--

-- Host: localhost

-- Generation Time: May 31, 2017 at 04:25 PM

-- Server version: 5.5.43-0ubuntu0.14.04.1

-- PHP Version: 5.5.9-1ubuntu4.9



SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";

SET time_zone = "+00:00";





/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;

/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;

/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;

/*!40101 SET NAMES utf8 */;



--

-- Database: `elema`

--



-- --------------------------------------------------------



--

-- Dumping data for table `Rating`

--



INSERT INTO `Rating` (`Meal_meal_id_pk`, `Customer_customer_id_pk`, `date`, `rating`, `comment`) VALUES

(1, 2, '2017-06-01 18:43:22', 4, '还不错'),

(3, 2, '2017-06-05 12:14:54', 3, '一般吧'),

(5, 3, '2017-06-13 17:00:00', 5, '太油了'),

(6, 3, '2017-06-14 17:00:04', 5, '很好次');



/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;

/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- joins the Delivery_State with Delivery_State_Type together



CREATE VIEW Delivery_State_View AS 

SELECT Delivery_delivery_id_pk, date_pk, name as delivery_status_type, comment

FROM Delivery_State ds

INNER JOIN Delivery_State_Type dst ON ds.Delivery_State_Type_delivery_status_type = dst.delivery_status_type_id_pk;



-- joins the Delivery with Delivery_State together



CREATE VIEW Delivery_View AS 

SELECT d . * , ds.date_pk, Delivery_State_Type_delivery_status_type AS delivery_status_type_number, name AS delivery_status_type, ds.comment AS delivery_state_comment

FROM Delivery_State ds

INNER JOIN Delivery_State_Type dst ON ds.Delivery_State_Type_delivery_status_type = dst.delivery_status_type_id_pk

INNER JOIN Delivery d ON d.delivery_id_pk = ds.Delivery_delivery_id_pk;

-- Constraints Delivery_Meal_Map

DELIMITER $$

CREATE TRIGGER delivery_meal_map_constraints BEFORE INSERT ON Delivery_Meal_Map FOR EACH ROW

BEGIN

    DECLARE msg VARCHAR(255);

    IF !(NEW.amount > 0) THEN

        SET msg = "DIE: You inserted a resctricted VALUE";

        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;

    END IF;

END;

$$

DELIMITER ;

-- Constraints for restaurant



DELIMITER $$

CREATE TRIGGER restaurant_constraints BEFORE INSERT ON Restaurant FOR EACH ROW

BEGIN

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

END;

$$

DELIMITER ;

-- Constraints for Meal

DELIMITER $$

CREATE TRIGGER meal_constraints BEFORE INSERT ON Meal FOR EACH ROW

BEGIN

    DECLARE msg VARCHAR(255);

    IF !(NEW.price >= 0 &&

        NEW.spiciness <= 3 &&

        NEW.spiciness >= 0)

    THEN

        SET msg = "DIE: You inserted a resctricted VALUE";

        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;

    END IF;

END;

$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER rating_constraints BEFORE INSERT ON Rating FOR EACH ROW

BEGIN

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

END;

$$

DELIMITER ;


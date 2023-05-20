-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 20, 2023 at 03:49 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_book`
--
CREATE DATABASE IF NOT EXISTS `db_book` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `db_book`;

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
CREATE TABLE `books` (
  `id` int(11) NOT NULL,
  `cate_id` int(11) NOT NULL COMMENT 'category id',
  `sub_cate_id` int(11) NOT NULL COMMENT 'sub category id',
  `book_sn` varchar(100) DEFAULT NULL COMMENT 'ซีเรียลนัมเบอร์',
  `book_no` varchar(10) DEFAULT '000' COMMENT 'เลขหนังสือ',
  `book_name` varchar(200) NOT NULL,
  `book_price` decimal(10,2) NOT NULL COMMENT 'ราคา',
  `book_vat` enum('3','5','7','') NOT NULL COMMENT 'ภาษีมูลค่าเพิ่ม',
  `promotion_id` int(11) NOT NULL COMMENT 'โปรโมชั่น',
  `book_stock` int(11) NOT NULL COMMENT 'จำนวนคงเหลือของหนังสือ',
  `is_active` enum('active','inactive') NOT NULL DEFAULT 'active',
  `create_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `cate_name` varchar(200) DEFAULT NULL COMMENT 'ชื่อหวมดหมู่',
  `cate_no` varchar(50) DEFAULT NULL COMMENT 'รหัสมหมวดหมู่',
  `cate_name_en` varchar(200) DEFAULT NULL,
  `is_active` enum('active','inactive') NOT NULL DEFAULT 'active',
  `create_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `cate_name`, `cate_no`, `cate_name_en`, `is_active`, `create_at`) VALUES
(1, 'เบ็ตเตล็ดหรือความรู้ทั่วไป', '000', 'Generalities', 'active', '2023-05-20 01:38:34'),
(2, 'ปรัชญา', '100', 'Philosophy', 'active', '2023-05-20 01:38:34'),
(3, 'ศาสนา', '200', 'Religion', 'active', '2023-05-20 01:38:34'),
(4, 'สังคมศาสตร์', '300', 'Social sciences', 'active', '2023-05-20 01:38:34'),
(5, 'ภาษาศาสตร์', '400', 'Language', 'active', '2023-05-20 01:38:34'),
(6, 'วิทยาศาสตร์', '500', 'Science', 'active', '2023-05-20 01:38:34'),
(7, 'วิทยาศาสตร์ประยุกต์', '600', 'หรือเทคโนโลยี Technology', 'active', '2023-05-20 01:38:34'),
(8, 'ศิลปกรรมและการบันเทิง', '700', 'Arts and recreation', 'active', '2023-05-20 01:38:34'),
(9, 'วรรณคดี', '800', 'Literature', 'active', '2023-05-20 01:38:34'),
(10, 'ประวัติศาสตร์และภูมิศาสตร์', '900', 'History and geography', 'active', '2023-05-20 01:38:34');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `pd_id` int(11) NOT NULL,
  `order_no` varchar(100) NOT NULL COMMENT 'เลขที่ออเดอร์',
  `order_price` decimal(5,2) DEFAULT NULL COMMENT 'ราคา',
  `order_vat` decimal(5,2) DEFAULT NULL COMMENT 'ราคา vat',
  `sum_amount` decimal(5,2) DEFAULT NULL COMMENT 'ราคารวม ราคา+vat',
  `order_total` int(11) NOT NULL COMMENT 'จำนวนที่ซื้อ',
  `order_status` enum('pending','success','cancel','') NOT NULL DEFAULT 'pending' COMMENT 'สถานะการชำระเงิน',
  `create_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `orders_detail`
--

DROP TABLE IF EXISTS `orders_detail`;
CREATE TABLE `orders_detail` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `price` decimal(5,2) NOT NULL COMMENT 'ราคารวมของหนังสือตาม book_id',
  `amount` int(11) NOT NULL COMMENT 'จำนวนหนังสือ',
  `create_at` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `personal_data`
--

DROP TABLE IF EXISTS `personal_data`;
CREATE TABLE `personal_data` (
  `pd_id` int(11) NOT NULL,
  `username` varchar(200) NOT NULL,
  `password` varchar(300) NOT NULL,
  `firstname` varchar(200) DEFAULT NULL,
  `lastname` varchar(200) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `is_active` enum('active','inactive') NOT NULL DEFAULT 'active',
  `create_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `promotion`
--

DROP TABLE IF EXISTS `promotion`;
CREATE TABLE `promotion` (
  `id` int(11) NOT NULL,
  `promotionname` varchar(200) NOT NULL,
  `date_start` datetime DEFAULT NULL COMMENT 'เริ่มโปร',
  `date_end` datetime DEFAULT NULL COMMENT 'สิ้นสุดโปร',
  `detail` varchar(200) NOT NULL COMMENT 'รายละเอียด',
  `is_active` enum('active','inactive') NOT NULL DEFAULT 'active' COMMENT 'สถานะ การเปิดใช้งาน',
  `create_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `sub_category`
--

DROP TABLE IF EXISTS `sub_category`;
CREATE TABLE `sub_category` (
  `id` int(11) NOT NULL,
  `cate_id` int(11) NOT NULL COMMENT 'category id',
  `sub_no` varchar(10) NOT NULL,
  `sub_name` varchar(200) DEFAULT NULL,
  `is_active` enum('active','inactive') NOT NULL DEFAULT 'active' COMMENT 'สถานะการใช้งาน active = เปิด',
  `create_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sub_category`
--

INSERT INTO `sub_category` (`id`, `cate_id`, `sub_no`, `sub_name`, `is_active`, `create_at`) VALUES
(1, 1, '100', 'ปรัชญา', 'active', '2023-05-20 01:48:53'),
(2, 1, '110', 'อภิปรัชญา', 'active', '2023-05-20 01:48:53'),
(3, 1, '120', 'ญาณวิทยา ความเป็นเหตุผล ความเป็นมนุษย์', 'active', '2023-05-20 01:48:53'),
(4, 1, '130', 'จิตวิทยานามธรรม', 'active', '2023-05-20 01:48:53'),
(5, 1, '140', 'แนวความคิดปรัชญาเฉพาะกลุ่ม', 'active', '2023-05-20 01:48:53'),
(6, 1, '150', 'จิตวิทยา', 'active', '2023-05-20 01:48:53'),
(7, 1, '160', 'ตรรกศาสตร์ ตรรกวิทยา', 'active', '2023-05-20 01:48:53'),
(8, 1, '170', 'จริยศาสตร์ ศีลธรรม', 'active', '2023-05-20 01:48:53'),
(9, 1, '180', 'ปรัชญาสมัยโบราณ สมัยกลาง ตะวันออก', 'active', '2023-05-20 01:48:53'),
(10, 1, '190', 'ปรัชญาตะวันตกสมัยใหม่', 'active', '2023-05-20 01:48:53'),
(11, 2, '200', 'ศาสนา', 'active', '2023-05-20 01:48:53'),
(12, 2, '210', 'ศาสนาธรรมชาติ', 'active', '2023-05-20 01:48:53'),
(13, 2, '220', 'ไบเบิล', 'active', '2023-05-20 01:48:53'),
(14, 2, '230', 'เทววิทยาตามแนวคริสต์ศาสนา', 'active', '2023-05-20 01:48:53'),
(15, 2, '240', ' ศีลธรรมชาวคริสต์ การอุทิศเพื่อศาสนา', 'active', '2023-05-20 01:48:53'),
(16, 2, '250', 'คริสต์ศาสนาในท้องถิ่นและระเบียบแบบแผนปฏิบัติ', 'active', '2023-05-20 01:48:53'),
(17, 2, '260', 'สังคมชาวคริสต์ เทววิทยาทางศาสนา', 'active', '2023-05-20 01:48:53'),
(18, 2, '270', 'ประวัติคริสต์ศาสนา', 'active', '2023-05-20 01:48:53'),
(19, 2, '280', 'นิกายต่างๆ ในคริสต์ศาสนา', 'active', '2023-05-20 01:48:53'),
(20, 2, '290', 'ศาสนาเปรียบเทียบและศาสนาอื่นๆ', 'active', '2023-05-20 01:48:53'),
(21, 3, '300', 'สังคมศาสตร์', 'active', '2023-05-20 01:48:53'),
(22, 3, '310', 'สถิติศาสตร์', 'active', '2023-05-20 01:48:53'),
(23, 3, '320', 'รัฐศาสตร์ การเมือง การปกครอง', 'active', '2023-05-20 01:48:53'),
(24, 3, '330', 'เศรษฐศาสตร์', 'active', '2023-05-20 01:48:53'),
(25, 3, '340', 'กฎหมาย', 'active', '2023-05-20 01:48:53'),
(26, 3, '350', 'รัฐประศาสนศาสตร์ การบริหารรัฐกิจ กองทัพ', 'active', '2023-05-20 01:48:53'),
(27, 3, '360', 'ปัญหาสังคม การบริหารสังคม สมาคม', 'active', '2023-05-20 01:48:53'),
(28, 3, '370', 'การศึกษา', 'active', '2023-05-20 01:48:53'),
(29, 3, '380', 'การพาณิชย์ การสื่อสาร การขนส่ง', 'active', '2023-05-20 01:48:53'),
(30, 3, '390', 'ประเพณี ขนบธรรมเนียม คติชนวิทยา', 'active', '2023-05-20 01:48:53'),
(31, 4, '400', 'ภาษา', 'active', '2023-05-20 01:48:53'),
(32, 4, '410', 'ภาษาศาสตร์', 'active', '2023-05-20 01:48:53'),
(33, 4, '420', 'ภาษาอังกฤษ', 'active', '2023-05-20 01:48:53'),
(34, 4, '430', 'ภาษาเยอรมัน', 'active', '2023-05-20 01:48:53'),
(35, 4, '440', 'ภาษาฝรั่งเศส ภาษาโรมานซ์', 'active', '2023-05-20 01:48:53'),
(36, 4, '450', 'ภาษาอิตาลี ภาษาโรมัน', 'active', '2023-05-20 01:48:53'),
(37, 4, '460', 'ภาษาสเปน ภาษาโปรตุเกส', 'active', '2023-05-20 01:48:53'),
(38, 4, '470', 'ภาษาละติน', 'active', '2023-05-20 01:48:53'),
(39, 4, '480', 'ภาษากรีก', 'active', '2023-05-20 01:48:53'),
(40, 4, '490', 'ภาษาอื่นๆ', 'active', '2023-05-20 01:48:53'),
(41, 5, '500', 'วิทยาศาสตร์', 'active', '2023-05-20 01:48:53'),
(42, 5, '510', 'คณิตศาสตร์', 'active', '2023-05-20 01:48:53'),
(43, 5, '520', 'ดาราศาสตร์', 'active', '2023-05-20 01:48:53'),
(44, 5, '530', 'ฟิสิกส์', 'active', '2023-05-20 01:48:53'),
(45, 5, '540', 'เคมี', 'active', '2023-05-20 01:48:53'),
(46, 5, '550', 'วิทยาศาสตร์โลก', 'active', '2023-05-20 01:48:53'),
(47, 5, '560', 'บรรพชีวินวิทยา', 'active', '2023-05-20 01:48:53'),
(48, 5, '570', 'ชีววิทยา', 'active', '2023-05-20 01:48:53'),
(49, 5, '580', 'พฤกษศาสตร์', 'active', '2023-05-20 01:48:53'),
(50, 5, '590', 'สัตววิทยา', 'active', '2023-05-20 01:48:53'),
(51, 6, '600', 'วิทยาศาสตร์ประยุกต์ เทคโนโลยี', 'active', '2023-05-20 01:48:53'),
(52, 6, '610', 'แพทยศาสตร์', 'active', '2023-05-20 01:48:53'),
(53, 6, '620', 'วิศวกรรมศาสตร์', 'active', '2023-05-20 01:48:53'),
(54, 6, '630', 'เกษตรศาสตร์', 'active', '2023-05-20 01:48:53'),
(55, 6, '640', 'คหกรรมศาสตร์ ชีวิตครอบครัว', 'active', '2023-05-20 01:48:53'),
(56, 6, '650', 'การจัดการธุรกิจ', 'active', '2023-05-20 01:48:53'),
(57, 6, '660', 'วิศวกรรมเคมี', 'active', '2023-05-20 01:48:53'),
(58, 6, '670', 'โรงงานอุตสาหกรรม', 'active', '2023-05-20 01:48:53'),
(59, 6, '680', 'สินค้าที่ผลิตจากเครื่องจักร', 'active', '2023-05-20 01:48:53'),
(60, 6, '690', 'การก่อสร้าง', 'active', '2023-05-20 01:48:53'),
(61, 7, '700', 'ศิลปกรรม การบันเทิง', 'active', '2023-05-20 01:48:53'),
(62, 7, '710', 'ภูมิสถาปัตย์', 'active', '2023-05-20 01:48:53'),
(63, 7, '720', 'สถาปัตยกรรม', 'active', '2023-05-20 01:48:53'),
(64, 7, '730', 'ประติมากรรม', 'active', '2023-05-20 01:48:53'),
(65, 7, '740', 'การวาดเขียน มัณฑนศิลป์', 'active', '2023-05-20 01:48:53'),
(66, 7, '750', 'จิตรกรรม ภาพเขียน', 'active', '2023-05-20 01:48:53'),
(67, 7, '760', 'ศิลปะการพิมพ์ ศิลปะกราฟิก', 'active', '2023-05-20 01:48:53'),
(68, 7, '770', 'การถ่ายรูป ภาพถ่าย', 'active', '2023-05-20 01:48:53'),
(69, 7, '780', 'ดนตรี', 'active', '2023-05-20 01:48:53'),
(70, 7, '790', 'การบันเทิง นันทนาการ กีฬา', 'active', '2023-05-20 01:48:53'),
(71, 8, '800', ' วรรณกรรม วรรณคดี', 'active', '2023-05-20 01:48:53'),
(72, 8, '810', 'วรรณคดีอเมริกันในภาษาอังกฤษ', 'active', '2023-05-20 01:48:53'),
(73, 8, '820', 'วรรณคดีภาษาอังกฤษ ภาษาอังกฤษโบราณ', 'active', '2023-05-20 01:48:53'),
(74, 8, '830', 'วรรณคดีภาษาเยอรมัน', 'active', '2023-05-20 01:48:53'),
(75, 8, '840', 'วรรณคดีภาษาฝรั่งเศส ภาษาโรมานซ์', 'active', '2023-05-20 01:48:53'),
(76, 8, '850', 'วรรณคดีภาษาอิตาลี ภาษาโรมัน', 'active', '2023-05-20 01:48:53'),
(77, 8, '870', 'วรรณคดีภาษาละติน', 'active', '2023-05-20 01:48:53'),
(78, 8, '860', 'วรรณคดีภาษาสเปน ภาษาโปรตุเกส', 'active', '2023-05-20 01:48:53'),
(79, 8, '880', 'วรรณคดีภาษากรีก', 'active', '2023-05-20 01:48:53'),
(80, 8, '890', 'วรรณคดีภาษาอื่นๆ', 'active', '2023-05-20 01:48:53'),
(81, 9, '900', 'ประวัติศาสตร์ ภูมิศาสตร์', 'active', '2023-05-20 01:48:53'),
(82, 9, '910', 'ภูมิศาสตร์ การท่องเที่ยว', 'active', '2023-05-20 01:48:53'),
(83, 9, '920', 'ชีวประวัติ เครื่องราชอิสริยาภรณ์', 'active', '2023-05-20 01:48:53'),
(84, 9, '930', 'ประวัติศาสตร์ยุคโบราณ', 'active', '2023-05-20 01:48:53'),
(85, 9, '940', 'ประวัติศาสตร์ยุโรป โลกตะวันตก', 'active', '2023-05-20 01:48:53'),
(86, 9, '950', 'ประวัติศาสตร์เอเชีย โลกตะวันออก', 'active', '2023-05-20 01:48:53'),
(87, 9, '960', 'ประวัติศาสตร์แอฟริกา', 'active', '2023-05-20 01:48:53'),
(88, 9, '970', 'ประวัติศาสตร์อเมริกาเหนือ', 'active', '2023-05-20 01:48:53'),
(89, 9, '980', 'ประวัติศาสตร์อเมริกาใต้', 'active', '2023-05-20 01:48:53'),
(90, 9, '990', 'ประวัติศาสตร์ส่วนอื่นๆ ของโลก', 'active', '2023-05-20 01:48:53');

-- --------------------------------------------------------

--
-- Table structure for table `temp_order_book`
--

DROP TABLE IF EXISTS `temp_order_book`;
CREATE TABLE `temp_order_book` (
  `id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `pd_id` int(11) NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`);

--
-- Indexes for table `orders_detail`
--
ALTER TABLE `orders_detail`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `personal_data`
--
ALTER TABLE `personal_data`
  ADD PRIMARY KEY (`pd_id`);

--
-- Indexes for table `promotion`
--
ALTER TABLE `promotion`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sub_category`
--
ALTER TABLE `sub_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `temp_order_book`
--
ALTER TABLE `temp_order_book`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders_detail`
--
ALTER TABLE `orders_detail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_data`
--
ALTER TABLE `personal_data`
  MODIFY `pd_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `promotion`
--
ALTER TABLE `promotion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sub_category`
--
ALTER TABLE `sub_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- AUTO_INCREMENT for table `temp_order_book`
--
ALTER TABLE `temp_order_book`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

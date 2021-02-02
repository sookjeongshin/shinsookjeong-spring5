-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- 생성 시간: 21-02-01 02:43
-- 서버 버전: 10.4.13-MariaDB
-- PHP 버전: 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 데이터베이스: `edu`
--

DELIMITER $$
--
-- 프로시저
--
DROP PROCEDURE IF EXISTS `PROC_BOARD_INSERT`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROC_BOARD_INSERT` (IN `p_loop` INT)  BEGIN
	declare cnt int default 1;
    -- delete from tbl_board where bno > 1;
    while cnt <= p_loop do
    if cnt <= (p_loop/2) then
		INSERT INTO tbl_board(board_type,title,content,writer,reg_date)
		VALUES
		('notice',concat(cnt,'번째 게시물 입니다.'), '게시물 내용 입니다.', 'admin',DATE_ADD(NOW(), INTERVAL cnt SECOND));
    else
		INSERT INTO tbl_board(board_type,title,content,writer,reg_date)
		VALUES
		('gallery',concat(cnt,'번째 게시물 입니다.'), '게시물 내용 입니다.', 'admin',DATE_ADD(NOW(), INTERVAL cnt SECOND));
    end if;
    set cnt = cnt + 1;
    end while;
    #실행전
	#truncate table tbl_attach;
	#truncate table tbl_reply;
    #SET FOREIGN_KEY_CHECKS = 0; -- 제약조건 Constraint 에러 발생시 비활성화
	#truncate table tbl_board;
	#SET FOREIGN_KEY_CHECKS = 1; -- 제약조건 다시 활성화
	#call PROC_BOARD_INSERT(100);
END$$

DROP PROCEDURE IF EXISTS `PROC_MEMBER_INSERT`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `PROC_MEMBER_INSERT` (IN `p_loop` INT)  BEGIN
	declare cnt int default 1;#반복문 변수선언
    while cnt <= p_loop do
    if cnt = p_loop then
		INSERT INTO tbl_member(user_id,user_pw,user_name,email,point,enabled,levels,reg_date) 
		VALUES 
		('admin','$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '관리자', 'admin@abc.com', '0', '1', 'ROLE_ADMIN',DATE_ADD(NOW(), INTERVAL cnt SECOND));
	else
		INSERT INTO tbl_member(user_id,user_pw,user_name,email,point,enabled,levels,reg_date) 
		VALUES 
		(concat('user',cnt),'$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', '0', '1', 'ROLE_USER',DATE_ADD(NOW(), INTERVAL cnt SECOND));
    end if;
        set cnt = cnt + 1;
    end while;
    #실행 전 처리
	#truncate table tbl_member;
	#call PROC_MEMBER_INSERT(100);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- 테이블 구조 `tbl_attach`
--

DROP TABLE IF EXISTS `tbl_attach`;
CREATE TABLE IF NOT EXISTS `tbl_attach` (
  `save_file_name` varchar(255) NOT NULL COMMENT '서버에 저잗되는 한글명이 아닌 파일명',
  `real_file_name` varchar(255) DEFAULT NULL COMMENT '여러분 PC에서 한글로된 진짜 파일명',
  `bno` int(11) NOT NULL COMMENT '부모게시물의 일련번호',
  `reg_date` timestamp NULL DEFAULT current_timestamp() COMMENT '등록일시',
  PRIMARY KEY (`save_file_name`),
  KEY `fk_tbl_attach_tbl_board_idx` (`bno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='게시물첨부파일';

-- --------------------------------------------------------

--
-- 테이블 구조 `tbl_board`
--

DROP TABLE IF EXISTS `tbl_board`;
CREATE TABLE IF NOT EXISTS `tbl_board` (
  `bno` int(11) NOT NULL AUTO_INCREMENT COMMENT '게시물일련번호, AI(Auto Increament)일련번호를 자동증가기능',
  `board_type` varchar(45) DEFAULT NULL COMMENT '게시판타입:tbl_board_type테이블의 값을 가져다 사용\n',
  `title` varchar(255) DEFAULT NULL COMMENT '게시물제목',
  `content` text DEFAULT NULL COMMENT '게시물내용',
  `writer` varchar(45) DEFAULT NULL COMMENT '작성자',
  `view_count` int(11) DEFAULT 0 COMMENT '게시글조회수',
  `reply_count` int(11) DEFAULT 0 COMMENT '댓글개수',
  `reg_date` timestamp NULL DEFAULT current_timestamp() COMMENT '등록일시',
  `update_date` timestamp NULL DEFAULT current_timestamp() COMMENT '수정일시',
  PRIMARY KEY (`bno`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COMMENT='게시물관리';

--
-- 테이블의 덤프 데이터 `tbl_board`
--

INSERT INTO `tbl_board` (`bno`, `board_type`, `title`, `content`, `writer`, `view_count`, `reply_count`, `reg_date`, `update_date`) VALUES
(1, 'notice', '1번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:33:43', '2021-02-01 02:33:42'),
(2, 'notice', '2번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:33:44', '2021-02-01 02:33:42'),
(3, 'notice', '3번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:33:45', '2021-02-01 02:33:42'),
(4, 'notice', '4번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:33:46', '2021-02-01 02:33:42'),
(5, 'notice', '5번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:33:47', '2021-02-01 02:33:42'),
(6, 'notice', '6번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:33:48', '2021-02-01 02:33:42'),
(7, 'notice', '7번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:33:49', '2021-02-01 02:33:42'),
(8, 'notice', '8번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:33:50', '2021-02-01 02:33:42'),
(9, 'notice', '9번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:33:51', '2021-02-01 02:33:42'),
(10, 'notice', '10번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:33:52', '2021-02-01 02:33:42'),
(11, 'notice', '11번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:33:53', '2021-02-01 02:33:42'),
(12, 'notice', '12번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:33:54', '2021-02-01 02:33:42'),
(13, 'notice', '13번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:33:55', '2021-02-01 02:33:42'),
(14, 'notice', '14번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:33:56', '2021-02-01 02:33:42'),
(15, 'notice', '15번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:33:57', '2021-02-01 02:33:42'),
(16, 'notice', '16번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:33:58', '2021-02-01 02:33:42'),
(17, 'notice', '17번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:33:59', '2021-02-01 02:33:42'),
(18, 'notice', '18번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:00', '2021-02-01 02:33:42'),
(19, 'notice', '19번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:01', '2021-02-01 02:33:42'),
(20, 'notice', '20번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:02', '2021-02-01 02:33:42'),
(21, 'notice', '21번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:03', '2021-02-01 02:33:42'),
(22, 'notice', '22번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:04', '2021-02-01 02:33:42'),
(23, 'notice', '23번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:05', '2021-02-01 02:33:42'),
(24, 'notice', '24번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:06', '2021-02-01 02:33:42'),
(25, 'notice', '25번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:07', '2021-02-01 02:33:42'),
(26, 'notice', '26번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:08', '2021-02-01 02:33:42'),
(27, 'notice', '27번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:09', '2021-02-01 02:33:42'),
(28, 'notice', '28번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:10', '2021-02-01 02:33:42'),
(29, 'notice', '29번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:11', '2021-02-01 02:33:42'),
(30, 'notice', '30번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:12', '2021-02-01 02:33:42'),
(31, 'notice', '31번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:13', '2021-02-01 02:33:42'),
(32, 'notice', '32번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:14', '2021-02-01 02:33:42'),
(33, 'notice', '33번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:15', '2021-02-01 02:33:42'),
(34, 'notice', '34번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:16', '2021-02-01 02:33:42'),
(35, 'notice', '35번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:17', '2021-02-01 02:33:42'),
(36, 'notice', '36번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:18', '2021-02-01 02:33:42'),
(37, 'notice', '37번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:19', '2021-02-01 02:33:42'),
(38, 'notice', '38번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:20', '2021-02-01 02:33:42'),
(39, 'notice', '39번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:21', '2021-02-01 02:33:42'),
(40, 'notice', '40번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:22', '2021-02-01 02:33:42'),
(41, 'notice', '41번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:23', '2021-02-01 02:33:42'),
(42, 'notice', '42번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:24', '2021-02-01 02:33:42'),
(43, 'notice', '43번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:25', '2021-02-01 02:33:42'),
(44, 'notice', '44번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:26', '2021-02-01 02:33:42'),
(45, 'notice', '45번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:27', '2021-02-01 02:33:42'),
(46, 'notice', '46번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:28', '2021-02-01 02:33:42'),
(47, 'notice', '47번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:29', '2021-02-01 02:33:42'),
(48, 'notice', '48번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:30', '2021-02-01 02:33:42'),
(49, 'notice', '49번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:31', '2021-02-01 02:33:42'),
(50, 'notice', '50번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:32', '2021-02-01 02:33:42'),
(51, 'gallery', '51번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:33', '2021-02-01 02:33:42'),
(52, 'gallery', '52번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:34', '2021-02-01 02:33:42'),
(53, 'gallery', '53번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:35', '2021-02-01 02:33:42'),
(54, 'gallery', '54번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:36', '2021-02-01 02:33:42'),
(55, 'gallery', '55번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:37', '2021-02-01 02:33:42'),
(56, 'gallery', '56번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:38', '2021-02-01 02:33:42'),
(57, 'gallery', '57번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:39', '2021-02-01 02:33:42'),
(58, 'gallery', '58번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:40', '2021-02-01 02:33:42'),
(59, 'gallery', '59번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:41', '2021-02-01 02:33:42'),
(60, 'gallery', '60번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:42', '2021-02-01 02:33:42'),
(61, 'gallery', '61번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:43', '2021-02-01 02:33:42'),
(62, 'gallery', '62번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:44', '2021-02-01 02:33:42'),
(63, 'gallery', '63번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:45', '2021-02-01 02:33:42'),
(64, 'gallery', '64번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:46', '2021-02-01 02:33:42'),
(65, 'gallery', '65번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:47', '2021-02-01 02:33:42'),
(66, 'gallery', '66번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:48', '2021-02-01 02:33:42'),
(67, 'gallery', '67번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:49', '2021-02-01 02:33:42'),
(68, 'gallery', '68번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:50', '2021-02-01 02:33:42'),
(69, 'gallery', '69번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:51', '2021-02-01 02:33:42'),
(70, 'gallery', '70번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:52', '2021-02-01 02:33:42'),
(71, 'gallery', '71번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:53', '2021-02-01 02:33:42'),
(72, 'gallery', '72번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:54', '2021-02-01 02:33:42'),
(73, 'gallery', '73번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:55', '2021-02-01 02:33:42'),
(74, 'gallery', '74번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:56', '2021-02-01 02:33:42'),
(75, 'gallery', '75번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:57', '2021-02-01 02:33:42'),
(76, 'gallery', '76번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:58', '2021-02-01 02:33:42'),
(77, 'gallery', '77번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:34:59', '2021-02-01 02:33:42'),
(78, 'gallery', '78번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:35:00', '2021-02-01 02:33:42'),
(79, 'gallery', '79번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:35:01', '2021-02-01 02:33:42'),
(80, 'gallery', '80번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:35:02', '2021-02-01 02:33:42'),
(81, 'gallery', '81번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:35:03', '2021-02-01 02:33:42'),
(82, 'gallery', '82번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:35:04', '2021-02-01 02:33:42'),
(83, 'gallery', '83번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:35:05', '2021-02-01 02:33:42'),
(84, 'gallery', '84번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:35:06', '2021-02-01 02:33:42'),
(85, 'gallery', '85번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:35:07', '2021-02-01 02:33:42'),
(86, 'gallery', '86번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:35:08', '2021-02-01 02:33:42'),
(87, 'gallery', '87번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:35:09', '2021-02-01 02:33:42'),
(88, 'gallery', '88번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:35:10', '2021-02-01 02:33:42'),
(89, 'gallery', '89번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:35:11', '2021-02-01 02:33:42'),
(90, 'gallery', '90번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:35:12', '2021-02-01 02:33:42'),
(91, 'gallery', '91번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:35:13', '2021-02-01 02:33:42'),
(92, 'gallery', '92번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:35:14', '2021-02-01 02:33:42'),
(93, 'gallery', '93번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:35:15', '2021-02-01 02:33:42'),
(94, 'gallery', '94번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:35:16', '2021-02-01 02:33:42'),
(95, 'gallery', '95번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:35:17', '2021-02-01 02:33:42'),
(96, 'gallery', '96번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:35:18', '2021-02-01 02:33:42'),
(97, 'gallery', '97번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:35:19', '2021-02-01 02:33:42'),
(98, 'gallery', '98번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:35:20', '2021-02-01 02:33:42'),
(99, 'gallery', '99번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:35:21', '2021-02-01 02:33:42'),
(100, 'gallery', '100번째 게시물 입니다.', '게시물 내용 입니다.', 'admin', 0, 0, '2021-02-01 02:35:22', '2021-02-01 02:33:42');

-- --------------------------------------------------------

--
-- 테이블 구조 `tbl_board_type`
--

DROP TABLE IF EXISTS `tbl_board_type`;
CREATE TABLE IF NOT EXISTS `tbl_board_type` (
  `board_type` varchar(45) NOT NULL COMMENT '게시판타입: notice, gallery, qna',
  `board_name` varchar(45) DEFAULT NULL COMMENT '게시판 이름',
  `board_sun` int(11) DEFAULT NULL COMMENT '게시판 출력 순서',
  PRIMARY KEY (`board_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='게시판생성:게시판종류생성 갤러리, 공지사항, 묻고답하기';

--
-- 테이블의 덤프 데이터 `tbl_board_type`
--

INSERT INTO `tbl_board_type` (`board_type`, `board_name`, `board_sun`) VALUES
('gallery', '겔러리', 2),
('notice', '공지사항', 1),
('test', '테스트', 3);

-- --------------------------------------------------------

--
-- 테이블 구조 `tbl_member`
--

DROP TABLE IF EXISTS `tbl_member`;
CREATE TABLE IF NOT EXISTS `tbl_member` (
  `user_id` varchar(45) NOT NULL COMMENT '회원아이디',
  `user_pw` varchar(255) DEFAULT NULL COMMENT '회원 로그인 암호',
  `user_name` varchar(255) DEFAULT NULL COMMENT '회원 이름',
  `email` varchar(255) DEFAULT NULL COMMENT '회원 이메일',
  `point` int(11) DEFAULT 0 COMMENT '회원 적립포인트',
  `enabled` int(1) DEFAULT 1 COMMENT '인증값(Authentication),활동 가능한 회원 여부, 0 로그인불가능, 1 로그인가능',
  `levels` varchar(45) DEFAULT 'ROLE_USER' COMMENT '권한값(Authority),2가지 레벨, ROLE_ADMIN(관리자), ROLE_USER(사용자)',
  `reg_date` timestamp NULL DEFAULT current_timestamp() COMMENT '등록일자,1970부터 초단위로 현재까지 계산한 값',
  `update_date` timestamp NULL DEFAULT current_timestamp() COMMENT '수정일자',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='회원관리';

--
-- 테이블의 덤프 데이터 `tbl_member`
--

INSERT INTO `tbl_member` (`user_id`, `user_pw`, `user_name`, `email`, `point`, `enabled`, `levels`, `reg_date`, `update_date`) VALUES
('admin', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '관리자', 'admin@abc.com', 0, 1, 'ROLE_ADMIN', '2021-02-01 02:35:22', '2021-02-01 02:33:42'),
('user1', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:33:43', '2021-02-01 02:33:42'),
('user10', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:33:52', '2021-02-01 02:33:42'),
('user11', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:33:53', '2021-02-01 02:33:42'),
('user12', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:33:54', '2021-02-01 02:33:42'),
('user13', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:33:55', '2021-02-01 02:33:42'),
('user14', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:33:56', '2021-02-01 02:33:42'),
('user15', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:33:57', '2021-02-01 02:33:42'),
('user16', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:33:58', '2021-02-01 02:33:42'),
('user17', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:33:59', '2021-02-01 02:33:42'),
('user18', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:00', '2021-02-01 02:33:42'),
('user19', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:01', '2021-02-01 02:33:42'),
('user2', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:33:44', '2021-02-01 02:33:42'),
('user20', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:02', '2021-02-01 02:33:42'),
('user21', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:03', '2021-02-01 02:33:42'),
('user22', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:04', '2021-02-01 02:33:42'),
('user23', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:05', '2021-02-01 02:33:42'),
('user24', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:06', '2021-02-01 02:33:42'),
('user25', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:07', '2021-02-01 02:33:42'),
('user26', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:08', '2021-02-01 02:33:42'),
('user27', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:09', '2021-02-01 02:33:42'),
('user28', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:10', '2021-02-01 02:33:42'),
('user29', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:11', '2021-02-01 02:33:42'),
('user3', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:33:45', '2021-02-01 02:33:42'),
('user30', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:12', '2021-02-01 02:33:42'),
('user31', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:13', '2021-02-01 02:33:42'),
('user32', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:14', '2021-02-01 02:33:42'),
('user33', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:15', '2021-02-01 02:33:42'),
('user34', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:16', '2021-02-01 02:33:42'),
('user35', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:17', '2021-02-01 02:33:42'),
('user36', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:18', '2021-02-01 02:33:42'),
('user37', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:19', '2021-02-01 02:33:42'),
('user38', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:20', '2021-02-01 02:33:42'),
('user39', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:21', '2021-02-01 02:33:42'),
('user4', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:33:46', '2021-02-01 02:33:42'),
('user40', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:22', '2021-02-01 02:33:42'),
('user41', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:23', '2021-02-01 02:33:42'),
('user42', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:24', '2021-02-01 02:33:42'),
('user43', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:25', '2021-02-01 02:33:42'),
('user44', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:26', '2021-02-01 02:33:42'),
('user45', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:27', '2021-02-01 02:33:42'),
('user46', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:28', '2021-02-01 02:33:42'),
('user47', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:29', '2021-02-01 02:33:42'),
('user48', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:30', '2021-02-01 02:33:42'),
('user49', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:31', '2021-02-01 02:33:42'),
('user5', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:33:47', '2021-02-01 02:33:42'),
('user50', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:32', '2021-02-01 02:33:42'),
('user51', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:33', '2021-02-01 02:33:42'),
('user52', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:34', '2021-02-01 02:33:42'),
('user53', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:35', '2021-02-01 02:33:42'),
('user54', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:36', '2021-02-01 02:33:42'),
('user55', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:37', '2021-02-01 02:33:42'),
('user56', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:38', '2021-02-01 02:33:42'),
('user57', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:39', '2021-02-01 02:33:42'),
('user58', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:40', '2021-02-01 02:33:42'),
('user59', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:41', '2021-02-01 02:33:42'),
('user6', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:33:48', '2021-02-01 02:33:42'),
('user60', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:42', '2021-02-01 02:33:42'),
('user61', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:43', '2021-02-01 02:33:42'),
('user62', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:44', '2021-02-01 02:33:42'),
('user63', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:45', '2021-02-01 02:33:42'),
('user64', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:46', '2021-02-01 02:33:42'),
('user65', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:47', '2021-02-01 02:33:42'),
('user66', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:48', '2021-02-01 02:33:42'),
('user67', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:49', '2021-02-01 02:33:42'),
('user68', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:50', '2021-02-01 02:33:42'),
('user69', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:51', '2021-02-01 02:33:42'),
('user7', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:33:49', '2021-02-01 02:33:42'),
('user70', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:52', '2021-02-01 02:33:42'),
('user71', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:53', '2021-02-01 02:33:42'),
('user72', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:54', '2021-02-01 02:33:42'),
('user73', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:55', '2021-02-01 02:33:42'),
('user74', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:56', '2021-02-01 02:33:42'),
('user75', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:57', '2021-02-01 02:33:42'),
('user76', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:58', '2021-02-01 02:33:42'),
('user77', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:34:59', '2021-02-01 02:33:42'),
('user78', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:35:00', '2021-02-01 02:33:42'),
('user79', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:35:01', '2021-02-01 02:33:42'),
('user8', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:33:50', '2021-02-01 02:33:42'),
('user80', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:35:02', '2021-02-01 02:33:42'),
('user81', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:35:03', '2021-02-01 02:33:42'),
('user82', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:35:04', '2021-02-01 02:33:42'),
('user83', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:35:05', '2021-02-01 02:33:42'),
('user84', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:35:06', '2021-02-01 02:33:42'),
('user85', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:35:07', '2021-02-01 02:33:42'),
('user86', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:35:08', '2021-02-01 02:33:42'),
('user87', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:35:09', '2021-02-01 02:33:42'),
('user88', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:35:10', '2021-02-01 02:33:42'),
('user89', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:35:11', '2021-02-01 02:33:42'),
('user9', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:33:51', '2021-02-01 02:33:42'),
('user90', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:35:12', '2021-02-01 02:33:42'),
('user91', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:35:13', '2021-02-01 02:33:42'),
('user92', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:35:14', '2021-02-01 02:33:42'),
('user93', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:35:15', '2021-02-01 02:33:42'),
('user94', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:35:16', '2021-02-01 02:33:42'),
('user95', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:35:17', '2021-02-01 02:33:42'),
('user96', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:35:18', '2021-02-01 02:33:42'),
('user97', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:35:19', '2021-02-01 02:33:42'),
('user98', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:35:20', '2021-02-01 02:33:42'),
('user99', '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO', '사용자', 'admin@abc.com', 0, 1, 'ROLE_USER', '2021-02-01 02:35:21', '2021-02-01 02:33:42');

-- --------------------------------------------------------

--
-- 테이블 구조 `tbl_reply`
--

DROP TABLE IF EXISTS `tbl_reply`;
CREATE TABLE IF NOT EXISTS `tbl_reply` (
  `rno` int(11) NOT NULL AUTO_INCREMENT COMMENT '댓글의 일련번호',
  `bno` int(11) NOT NULL COMMENT '부모게시물의 일련번호',
  `reply_text` varchar(1000) DEFAULT NULL COMMENT '댓글내용',
  `replyer` varchar(45) DEFAULT NULL COMMENT '작성자',
  `reg_date` timestamp NULL DEFAULT current_timestamp() COMMENT '등록일시',
  `update_date` timestamp NULL DEFAULT current_timestamp() COMMENT '수정일시',
  PRIMARY KEY (`rno`),
  KEY `fk_tbl_reply_tbl_board1_idx` (`bno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='댓글관리';

--
-- 덤프된 테이블의 제약사항
--

--
-- 테이블의 제약사항 `tbl_attach`
--
ALTER TABLE `tbl_attach`
  ADD CONSTRAINT `fk_tbl_attach_tbl_board` FOREIGN KEY (`bno`) REFERENCES `tbl_board` (`bno`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- 테이블의 제약사항 `tbl_reply`
--
ALTER TABLE `tbl_reply`
  ADD CONSTRAINT `fk_tbl_reply_tbl_board1` FOREIGN KEY (`bno`) REFERENCES `tbl_board` (`bno`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

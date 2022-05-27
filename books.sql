-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 29, 2021 at 10:43 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `books`
--

-- --------------------------------------------------------

--
-- Table structure for table `book_categories`
--

CREATE TABLE `book_categories` (
  `catID` int(11) NOT NULL,
  `catName` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `book_categories`
--

INSERT INTO `book_categories` (`catID`, `catName`) VALUES
(1, 'Action and Adventure'),
(2, 'History'),
(3, 'Science fiction'),
(4, 'Health and fitness'),
(5, 'Academic General'),
(6, 'Academic Engg'),
(7, 'Academic Non-Science');

-- --------------------------------------------------------

--
-- Table structure for table `book_post`
--

CREATE TABLE `book_post` (
  `postID` int(11) NOT NULL,
  `bookName` varchar(200) NOT NULL,
  `bookPhoto` text NOT NULL,
  `authorName` varchar(100) NOT NULL,
  `bookPrice` varchar(100) NOT NULL,
  `bookCond` varchar(50) NOT NULL,
  `postCond` varchar(50) NOT NULL,
  `postDes` varchar(200) NOT NULL,
  `meetLoc` varchar(100) NOT NULL,
  `userID` int(11) NOT NULL,
  `catID` int(11) NOT NULL,
  `bookLang` varchar(20) NOT NULL,
  `postCreated` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `book_post`
--

INSERT INTO `book_post` (`postID`, `bookName`, `bookPhoto`, `authorName`, `bookPrice`, `bookCond`, `postCond`, `postDes`, `meetLoc`, `userID`, `catID`, `bookLang`, `postCreated`) VALUES
(5, 'Teach Yourself', 'images/t.jpg', 'Schild', '150', 'Used', 'Fixed', 'just dummy contet.just dummy contet.just dummy contet.just dummy contet.just dummy contet.just dummy contet.just dummy contet.just dummy contet.just dummy contet.', 'Mirpur', 1, 6, 'English', '2021-02-08'),
(6, 'Algorithms', 'images/algorithms.jpg', 'Cormen', '200', 'Used', 'Fixed', 'asfasfv afaf afsafasf dfsdfs', 'Mirpur', 1, 6, 'English', '0000-00-00'),
(8, 'Engling Grammer', 'images/9780132333306.jpg', 'Azhar and Hagen', '150', 'Used', 'Fixed', 'fafaef aefafaf', 'Mirpur', 1, 5, 'English', '2021-02-23'),
(9, 'Database System Concepts', 'images/0073523321.jpeg', 'ABraham, Hanry, Sudarshan', '400', 'New', 'gsgsgFixed', 'srgasgrsv sgvasg', 'CSE DEPT Floor, BUBT', 1, 5, 'bangla', '2021-02-26'),
(10, 'Microprocessor: Programming and Interfacing', 'images/9780672216107-us.jpg', 'Joseph, Elizabeth, Peter\r\n', '', 'Used', 'Used', 'dadad', 'Canteen, NSU', 1, 5, 'afadad', '2021-02-26'),
(13, 'Computer Programming', 'images/cmp.jpg', 'Subin', '200', 'Used', 'Fixed', 'Boiti new er moto e ache', 'Mirpur', 11, 5, 'Bangla', '2021-03-01'),
(21, 'sagf ', '', 'dsfsgf ', '123', 'Used', 'Fixed', 'fadf afafd', 'mirpur', 6, 6, 'English', '0000-00-00');

-- --------------------------------------------------------

--
-- Table structure for table `images`
--

CREATE TABLE `images` (
  `imgID` int(11) NOT NULL,
  `bookName` varchar(100) NOT NULL,
  `category` varchar(20) NOT NULL,
  `bookPhoto` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `images`
--

INSERT INTO `images` (`imgID`, `bookName`, `category`, `bookPhoto`) VALUES
(37, 'gagrag', '', 'images/60338e9b139d5.png'),
(38, 'zzzzzzzzzzzz', '', 'images/60338ec206bb0.png'),
(39, 'afaffaf', '', 'images/6033d3a60293d.png'),
(40, '', '', 'images/6033ea9d87378.png'),
(41, '', '', 'images/6033eaa33b1fd.png'),
(42, 'afafaf', '', 'images/6033eae559d53.png'),
(43, 'afafaf', 'Item 2', 'images/6033eb254155a.png'),
(44, 'afafaf', '2', 'images/6033eb65b6b0a.png');

-- --------------------------------------------------------

--
-- Table structure for table `message`
--

CREATE TABLE `message` (
  `mID` int(11) NOT NULL,
  `senderID` int(11) NOT NULL,
  `recvID` int(11) NOT NULL,
  `msg` varchar(300) NOT NULL,
  `msgType` varchar(20) NOT NULL,
  `connected` varchar(10) NOT NULL,
  `timez` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `message`
--

INSERT INTO `message` (`mID`, `senderID`, `recvID`, `msg`, `msgType`, `connected`, `timez`) VALUES
(1, 11, 1, 'i want to buy your books', 'sender', 'yes', '2021-03-18'),
(2, 11, 1, 'sdfdafaf', 'sender', 'yes', '2021-03-18'),
(3, 11, 8, 'adDF', 'sender', 'yes', '2021-03-18'),
(4, 11, 8, 'FdVc edfa', 'receiver', 'yes', '2021-03-18'),
(6, 11, 1, 'dafasf', 'receiver', 'yes', '2021-03-18'),
(9, 6, 1, 'dsgagasgasg', 'receiver', 'yes', '2021-03-18'),
(10, 11, 1, 'this is a new look of chat system. Alhamdulillah', 'receiver', 'yes', '2021-03-18'),
(82, 1, 11, 'i m new', 'sender', 'yes', '2021-03-20'),
(83, 11, 1, 'ok bro', 'sender', 'yes', '2021-03-20'),
(86, 1, 6, 'oi arafat', 'sender', 'yes', '2021-03-20'),
(87, 1, 6, 'kire', 'sender', 'yes', '2021-03-20'),
(146, 1, 2, 'Hello Sima', 'sender', 'yes', '0000-00-00'),
(147, 1, 8, 'Hello Rabbi', 'sender', 'yes', '0000-00-00'),
(148, 1, 3, 'Hello Srabonti', 'sender', 'yes', '0000-00-00'),
(149, 1, 8, 'I want to buy a book which one u listed to sell', 'sender', 'yes', '2021-03-29'),
(150, 1, 8, 'r u there', 'sender', 'yes', '2021-03-29'),
(151, 8, 1, 'ok bro meet me @Library Floor at 2.30PM', 'sender', 'yes', '2021-03-29');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `pro_pic` text NOT NULL,
  `username` varchar(100) NOT NULL,
  `usermail` varchar(50) NOT NULL,
  `password` varchar(200) NOT NULL,
  `university` varchar(200) NOT NULL,
  `user_mobile` varchar(15) NOT NULL,
  `registrationdate` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `pro_pic`, `username`, `usermail`, `password`, `university`, `user_mobile`, `registrationdate`) VALUES
(1, 'images/moinul.jpg', 'ami', 'abc@gmail.com', '12345', 'BUBT', '01673303919', '2021-01-25'),
(2, 'images/sima2.jpg', 'Sima', '', '1234', '', '', '2021-01-25'),
(3, 'images/srabonti.jpg', 'Srabonti', 'afafgfdfga', '1234', '', '', '2021-01-25'),
(4, '', 'afazz', 'afafgfdfga', '1231', '', '', '2021-01-25'),
(5, '', 'fdafaf', 'afrswgasgags', '1213', 'BUBT', '121435', '2021-01-25'),
(6, 'images/arafat.jpg', 'Arafat', 'ulta@gmail.com', '12345', 'BUET', '`12345', '2021-01-25'),
(8, 'images/rabbi.jpg', 'Rabbi', 'rabbi@gmail.com', '12345', 'Bubt', '12141', '2021-01-26'),
(9, '', 'Rabbiz', 'rabbi@gmail.com', '12345', 'Bubt', '12141', '2021-01-26'),
(11, 'images/moinul_islam.jpg', 'moinul', 'abc@gmail.com', '12345', 'BUBT', '12345', '2021-01-26'),
(12, '', '', '', '', '', '', '2021-02-23');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `book_categories`
--
ALTER TABLE `book_categories`
  ADD PRIMARY KEY (`catID`);

--
-- Indexes for table `book_post`
--
ALTER TABLE `book_post`
  ADD PRIMARY KEY (`postID`),
  ADD KEY `catID` (`catID`),
  ADD KEY `userID` (`userID`);

--
-- Indexes for table `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`imgID`);

--
-- Indexes for table `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`mID`),
  ADD KEY `recvID` (`recvID`),
  ADD KEY `message_ibfk_1` (`senderID`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `book_categories`
--
ALTER TABLE `book_categories`
  MODIFY `catID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `book_post`
--
ALTER TABLE `book_post`
  MODIFY `postID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `images`
--
ALTER TABLE `images`
  MODIFY `imgID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `message`
--
ALTER TABLE `message`
  MODIFY `mID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=152;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `book_post`
--
ALTER TABLE `book_post`
  ADD CONSTRAINT `book_post_ibfk_1` FOREIGN KEY (`catID`) REFERENCES `book_categories` (`catID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `book_post_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `message`
--
ALTER TABLE `message`
  ADD CONSTRAINT `message_ibfk_1` FOREIGN KEY (`senderID`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `message_ibfk_2` FOREIGN KEY (`recvID`) REFERENCES `user` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

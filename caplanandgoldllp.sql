-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 24, 2025 at 06:22 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `caplanandgoldllp`
--

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `attendanceId` char(5) NOT NULL,
  `employeeId` char(5) NOT NULL,
  `attendanceDate` date NOT NULL,
  `checkInTime` time NOT NULL,
  `checkOutTime` time NOT NULL,
  `overTimeHours` int(11) DEFAULT NULL,
  `status` varchar(15) NOT NULL,
  `leaveType` varchar(8) NOT NULL,
  `shiftType` varchar(9) NOT NULL,
  `totalHours` decimal(10,2) GENERATED ALWAYS AS (timestampdiff(SECOND,`checkInTime`,`checkOutTime`) / 3600) VIRTUAL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `benefit`
--

CREATE TABLE `benefit` (
  `benefitId` char(5) NOT NULL,
  `benefitName` varchar(25) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `benefitEligibilityCriteria` varchar(500) NOT NULL,
  `provider` varchar(25) NOT NULL,
  `effectiveDate` date NOT NULL,
  `state` varchar(15) NOT NULL,
  `value` varchar(50) NOT NULL,
  `typeOfBenefit` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contract`
--

CREATE TABLE `contract` (
  `contractId` char(5) NOT NULL,
  `employeeId` char(5) NOT NULL,
  `supervisorId` char(5) NOT NULL,
  `departmentId` char(5) NOT NULL,
  `shiftId` char(5) NOT NULL,
  `contractDescription` varchar(500) DEFAULT NULL,
  `startDate` date NOT NULL,
  `endDate` date NOT NULL,
  `probationPeriod` int(11) NOT NULL,
  `compensation` varchar(500) NOT NULL,
  `standards` varchar(500) NOT NULL,
  `typeOfContract` varchar(100) NOT NULL,
  `duration` int(11) GENERATED ALWAYS AS (to_days(`endDate`) - to_days(`startDate`)) VIRTUAL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `departmentId` char(5) NOT NULL,
  `name` varchar(25) NOT NULL,
  `departmentHead` varchar(25) NOT NULL,
  `location` varchar(35) NOT NULL,
  `buildingNumber` int(11) NOT NULL,
  `Street` varchar(35) DEFAULT NULL,
  `city` varchar(35) NOT NULL,
  `postalCode` varchar(10) NOT NULL,
  `address` varchar(81) GENERATED ALWAYS AS (concat_ws(', ',`buildingNumber`,`Street`,`city`,`postalCode`)) STORED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `employeeId` char(5) NOT NULL,
  `firstName` varchar(25) NOT NULL,
  `middleName` varchar(25) DEFAULT NULL,
  `familyName` varchar(25) DEFAULT NULL,
  `ssn` char(9) NOT NULL,
  `houseId` int(11) DEFAULT NULL,
  `street` varchar(25) DEFAULT NULL,
  `city` varchar(15) NOT NULL,
  `postalCode` varchar(10) NOT NULL,
  `contactNumber1` varchar(11) NOT NULL,
  `contactNumber2` varchar(11) DEFAULT NULL,
  `contactNumber3` varchar(11) DEFAULT NULL,
  `emailAddress1` varchar(320) NOT NULL,
  `emailAddress2` varchar(320) DEFAULT NULL,
  `emailAddress3` varchar(320) DEFAULT NULL,
  `dob` date NOT NULL,
  `hireDate` date NOT NULL,
  `educationQualifications` varchar(100) NOT NULL,
  `rank` int(11) DEFAULT NULL,
  `emergencyContact` varchar(11) NOT NULL,
  `salary` float(12,2) DEFAULT NULL,
  `departmentWorking` varchar(25) NOT NULL,
  `age` int(11) GENERATED ALWAYS AS (floor((to_days(curdate()) - to_days(`dob`)) / 365)) VIRTUAL,
  `servicePeriod` int(11) GENERATED ALWAYS AS (year(curdate()) - year(`hireDate`)) VIRTUAL,
  `name` varchar(77) GENERATED ALWAYS AS (concat_ws(' ',`firstName`,`middleName`,`familyName`)) STORED,
  `address` varchar(81) GENERATED ALWAYS AS (concat_ws(', ',`houseId`,`street`,`city`,`postalCode`)) STORED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employeeenrolment`
--

CREATE TABLE `employeeenrolment` (
  `enrolmentId` char(5) NOT NULL,
  `trainingId` char(5) NOT NULL,
  `enrollmentDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employeeevaluation`
--

CREATE TABLE `employeeevaluation` (
  `employeeId` char(5) NOT NULL,
  `evaluationId` char(5) NOT NULL,
  `employeeEvaluationScore` float(5,2) DEFAULT NULL,
  `evaluationDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `evaluation`
--

CREATE TABLE `evaluation` (
  `evaluationId` char(5) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `evaluator` varchar(25) NOT NULL,
  `evaluatee` varchar(25) NOT NULL,
  `evaluationDate` date NOT NULL,
  `evaluationPeriod` int(11) DEFAULT NULL,
  `evaluationCriteria` varchar(35) NOT NULL,
  `evaluationScore` float(5,2) DEFAULT NULL,
  `feedback` varchar(500) DEFAULT NULL,
  `strengths` varchar(500) DEFAULT NULL,
  `approvedDate` date NOT NULL,
  `approvalStatus` varchar(15) NOT NULL,
  `trainingRecommendations` varchar(500) DEFAULT NULL,
  `followUpDate` date NOT NULL,
  `confidentiality` varchar(10) NOT NULL,
  `evaluationType` varchar(35) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gameplay`
--

CREATE TABLE `gameplay` (
  `gameplay_id` int(11) NOT NULL,
  `session_id` int(11) NOT NULL,
  `mode_id` int(11) NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `duration` int(11) GENERATED ALWAYS AS (timestampdiff(SECOND,`start_time`,`end_time`)) STORED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `leave`
--

CREATE TABLE `leave` (
  `leaveId` char(5) NOT NULL,
  `employeeId` char(5) NOT NULL,
  `leaveType` varchar(15) NOT NULL,
  `leaveStartDate` date NOT NULL,
  `leaveEndDate` date NOT NULL,
  `leaveStatus` varchar(15) NOT NULL,
  `reasonForLeave` varchar(500) DEFAULT NULL,
  `leaveBalance` int(11) NOT NULL,
  `requestDate` date NOT NULL,
  `approvalDate` date NOT NULL,
  `approverDetails` varchar(500) NOT NULL,
  `supportingDocuments` varchar(500) DEFAULT NULL,
  `leaveDuration` int(11) NOT NULL,
  `returnDate` date NOT NULL,
  `comment` varchar(500) DEFAULT NULL,
  `leavePaymentsDetails` varchar(500) NOT NULL,
  `totalLeaveDate` int(11) GENERATED ALWAYS AS (to_days(`leaveEndDate`) - to_days(`leaveStartDate`) + 1) VIRTUAL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mode`
--

CREATE TABLE `mode` (
  `mode_id` int(11) NOT NULL,
  `modeKey` varchar(5) NOT NULL,
  `modeName` varchar(100) NOT NULL,
  `numRangeMax` int(11) NOT NULL,
  `maxNoOfNums` int(11) NOT NULL,
  `noOfQs` int(11) NOT NULL,
  `arithOperands` varchar(300) NOT NULL,
  `numRangeMin` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mode`
--

INSERT INTO `mode` (`mode_id`, `modeKey`, `modeName`, `numRangeMax`, `maxNoOfNums`, `noOfQs`, `arithOperands`, `numRangeMin`) VALUES
(1, '', 'demo', 5, 2, 3, ' + ', 1),
(2, '-e', 'easy', 10, 5, 5, ' + , - ', 1),
(3, '-m', 'medium', 10, 10, 10, ' + , - ', 1),
(4, '-h', 'hard', 10, 10, 10, ' + , - , * ', 1);

-- --------------------------------------------------------

--
-- Table structure for table `position`
--

CREATE TABLE `position` (
  `positionId` char(5) NOT NULL,
  `name` varchar(25) NOT NULL,
  `departmentId` char(5) NOT NULL,
  `jobDescription` varchar(500) NOT NULL,
  `positionLevel` varchar(20) NOT NULL,
  `salaryGrade` varchar(10) DEFAULT NULL,
  `reportsTo` varchar(25) NOT NULL,
  `requiredQualifications` varchar(500) NOT NULL,
  `location` varchar(35) NOT NULL,
  `jobType` varchar(35) DEFAULT NULL,
  `hiringDate` date NOT NULL,
  `workHours` int(11) NOT NULL,
  `responsibilities` varchar(500) NOT NULL,
  `benefits` varchar(500) NOT NULL,
  `promotionEligibilityCriteria` varchar(500) NOT NULL,
  `positionDetails` varchar(500) DEFAULT NULL,
  `positionStatus` enum('active','open','filled','archived') NOT NULL,
  `typeOfPosition` enum('managerial position','nonmanagerial post') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project`
--

CREATE TABLE `project` (
  `projectId` char(5) NOT NULL,
  `projectName` varchar(25) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `startDate` date NOT NULL,
  `endDate` date NOT NULL,
  `actualEndDate` date DEFAULT NULL,
  `manager` varchar(25) NOT NULL,
  `clientName` varchar(25) NOT NULL,
  `budget` float(12,2) NOT NULL,
  `numberOfMilestones` int(11) NOT NULL,
  `priority` varchar(10) NOT NULL,
  `completionPercentage` float(5,2) NOT NULL,
  `resources` varchar(500) DEFAULT NULL,
  `riskLevel` varchar(10) DEFAULT NULL,
  `timeTracking` time NOT NULL,
  `clientContact` varchar(400) NOT NULL,
  `documents` varchar(500) DEFAULT NULL,
  `createdBy` varchar(25) DEFAULT NULL,
  `lastUpdated` date DEFAULT NULL,
  `comments` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `question`
--

CREATE TABLE `question` (
  `question_id` int(11) NOT NULL,
  `gameplay_id` int(11) NOT NULL,
  `question_text` varchar(500) NOT NULL,
  `user_answer` int(11) NOT NULL,
  `correct_answer` int(11) NOT NULL,
  `is_correct` tinyint(1) GENERATED ALWAYS AS (`user_answer` = `correct_answer`) STORED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `salary`
--

CREATE TABLE `salary` (
  `salaryId` char(5) NOT NULL,
  `employeeId` char(5) NOT NULL,
  `basicSalary` float(12,2) NOT NULL,
  `allowances` varchar(500) DEFAULT NULL,
  `bonuses` varchar(500) DEFAULT NULL,
  `deductions` varchar(500) DEFAULT NULL,
  `netWage` float(12,2) NOT NULL,
  `payDate` date NOT NULL,
  `payPeriod` time NOT NULL,
  `overtimePayment` float(12,2) DEFAULT NULL,
  `taxRate` float(5,2) NOT NULL,
  `paymentMode` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `session`
--

CREATE TABLE `session` (
  `session_id` int(11) NOT NULL,
  `startTime` datetime NOT NULL,
  `endTime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `supervisor`
--

CREATE TABLE `supervisor` (
  `supervisorId` char(5) NOT NULL,
  `employeeId` char(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `task`
--

CREATE TABLE `task` (
  `taskId` char(5) NOT NULL,
  `taskTitle` varchar(35) NOT NULL,
  `taskDescription` varchar(500) DEFAULT NULL,
  `employeeId` char(5) NOT NULL,
  `projectId` char(5) NOT NULL,
  `departmentId` char(5) NOT NULL,
  `priorityLevel` varchar(10) NOT NULL,
  `taskType` varchar(15) NOT NULL,
  `startDate` date NOT NULL,
  `endDate` date NOT NULL,
  `actualCompletionDate` date DEFAULT NULL,
  `estimatedHours` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `training`
--

CREATE TABLE `training` (
  `trainingId` char(5) NOT NULL,
  `title` varchar(35) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `learningObjectives` varchar(500) NOT NULL,
  `deliveryMethod` varchar(15) NOT NULL,
  `startDate` date NOT NULL,
  `endDate` date NOT NULL,
  `preRequisites` varchar(500) NOT NULL,
  `cost` float(8,2) NOT NULL,
  `trainingDetails` varchar(500) NOT NULL,
  `trainingType` varchar(18) NOT NULL,
  `duration` int(11) GENERATED ALWAYS AS (to_days(`endDate`) - to_days(`startDate`)) VIRTUAL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `workshift`
--

CREATE TABLE `workshift` (
  `shiftId` char(5) NOT NULL,
  `name` varchar(25) NOT NULL,
  `startTime` time NOT NULL,
  `endTime` time NOT NULL,
  `workdays` varchar(35) NOT NULL,
  `departmentId` varchar(15) NOT NULL,
  `duration` decimal(10,2) GENERATED ALWAYS AS (timestampdiff(MINUTE,`startTime`,`endTime`) / 60) VIRTUAL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `workstation`
--

CREATE TABLE `workstation` (
  `workstationId` char(5) NOT NULL,
  `EmployeeId` char(5) NOT NULL,
  `location` varchar(35) NOT NULL,
  `workstationType` varchar(35) NOT NULL,
  `assignedEquipment` varchar(100) DEFAULT NULL,
  `hardwareSpecification` varchar(500) NOT NULL,
  `networkAccessPointDetails` varchar(500) NOT NULL,
  `softwareLicensesAllocated` varchar(300) NOT NULL,
  `status` varchar(15) NOT NULL,
  `assignedDate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`attendanceId`);

--
-- Indexes for table `benefit`
--
ALTER TABLE `benefit`
  ADD PRIMARY KEY (`benefitId`);

--
-- Indexes for table `contract`
--
ALTER TABLE `contract`
  ADD PRIMARY KEY (`contractId`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`departmentId`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`employeeId`);

--
-- Indexes for table `employeeenrolment`
--
ALTER TABLE `employeeenrolment`
  ADD PRIMARY KEY (`enrolmentId`);

--
-- Indexes for table `employeeevaluation`
--
ALTER TABLE `employeeevaluation`
  ADD PRIMARY KEY (`employeeId`,`evaluationId`);

--
-- Indexes for table `evaluation`
--
ALTER TABLE `evaluation`
  ADD PRIMARY KEY (`evaluationId`);

--
-- Indexes for table `gameplay`
--
ALTER TABLE `gameplay`
  ADD PRIMARY KEY (`gameplay_id`),
  ADD KEY `session_id` (`session_id`),
  ADD KEY `mode_id` (`mode_id`);

--
-- Indexes for table `leave`
--
ALTER TABLE `leave`
  ADD PRIMARY KEY (`leaveId`);

--
-- Indexes for table `mode`
--
ALTER TABLE `mode`
  ADD PRIMARY KEY (`mode_id`);

--
-- Indexes for table `position`
--
ALTER TABLE `position`
  ADD PRIMARY KEY (`positionId`);

--
-- Indexes for table `project`
--
ALTER TABLE `project`
  ADD PRIMARY KEY (`projectId`);

--
-- Indexes for table `question`
--
ALTER TABLE `question`
  ADD PRIMARY KEY (`question_id`),
  ADD KEY `gameplay_id` (`gameplay_id`);

--
-- Indexes for table `salary`
--
ALTER TABLE `salary`
  ADD PRIMARY KEY (`salaryId`);

--
-- Indexes for table `session`
--
ALTER TABLE `session`
  ADD PRIMARY KEY (`session_id`);

--
-- Indexes for table `supervisor`
--
ALTER TABLE `supervisor`
  ADD PRIMARY KEY (`supervisorId`);

--
-- Indexes for table `task`
--
ALTER TABLE `task`
  ADD PRIMARY KEY (`taskId`);

--
-- Indexes for table `training`
--
ALTER TABLE `training`
  ADD PRIMARY KEY (`trainingId`);

--
-- Indexes for table `workshift`
--
ALTER TABLE `workshift`
  ADD PRIMARY KEY (`shiftId`);

--
-- Indexes for table `workstation`
--
ALTER TABLE `workstation`
  ADD PRIMARY KEY (`workstationId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `gameplay`
--
ALTER TABLE `gameplay`
  MODIFY `gameplay_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mode`
--
ALTER TABLE `mode`
  MODIFY `mode_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `question`
--
ALTER TABLE `question`
  MODIFY `question_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `session`
--
ALTER TABLE `session`
  MODIFY `session_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `gameplay`
--
ALTER TABLE `gameplay`
  ADD CONSTRAINT `gameplay_ibfk_1` FOREIGN KEY (`session_id`) REFERENCES `session` (`session_id`),
  ADD CONSTRAINT `gameplay_ibfk_2` FOREIGN KEY (`mode_id`) REFERENCES `mode` (`mode_id`);

--
-- Constraints for table `question`
--
ALTER TABLE `question`
  ADD CONSTRAINT `question_ibfk_1` FOREIGN KEY (`gameplay_id`) REFERENCES `gameplay` (`gameplay_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

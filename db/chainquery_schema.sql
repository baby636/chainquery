-- Generated with mysqldump -u root -p --no-data chainquery > schema.sql
-- MySQL dump 10.13  Distrib 5.7.25, for osx10.14 (x86_64)
--
-- Host: localhost    Database: chainquery_e2e_test
-- ------------------------------------------------------
-- Server version	5.7.25

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `abnormal_claim`
--

DROP TABLE IF EXISTS `abnormal_claim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `abnormal_claim` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL,
  `claim_id` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_update` tinyint(1) NOT NULL DEFAULT '0',
  `block_hash` varchar(70) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `transaction_hash` varchar(70) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `vout` int(10) unsigned NOT NULL,
  `output_id` bigint(20) unsigned NOT NULL,
  `value_as_hex` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `value_as_json` mediumtext COLLATE utf8mb4_unicode_ci,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `Idx_UnknowClaimBlockHash` (`block_hash`),
  KEY `Idx_UnknowClaimOutput` (`output_id`),
  KEY `Idx_UnknowClaimTxHash` (`transaction_hash`),
  CONSTRAINT `abnormal_claim_ibfk_1` FOREIGN KEY (`output_id`) REFERENCES `output` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5209 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `address` varchar(40) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `first_seen` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `balance` double(58,8) NOT NULL DEFAULT '0.00000000',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `address` (`address`),
  UNIQUE KEY `Idx_AddressAddress` (`address`),
  KEY `Idx_AddressCreated` (`created_at`),
  KEY `Idx_AddressModified` (`modified_at`),
  KEY `balance` (`balance`)
) ENGINE=InnoDB AUTO_INCREMENT=2977769 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `application_status`
--

DROP TABLE IF EXISTS `application_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `application_status` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `app_version` int(11) NOT NULL,
  `data_version` int(11) NOT NULL,
  `api_version` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `block`
--

DROP TABLE IF EXISTS `block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `bits` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `chainwork` varchar(70) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `confirmations` int(10) unsigned NOT NULL,
  `difficulty` double(50,8) NOT NULL,
  `hash` varchar(70) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `height` bigint(20) unsigned NOT NULL,
  `merkle_root` varchar(70) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `name_claim_root` varchar(70) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `nonce` bigint(20) unsigned NOT NULL,
  `previous_block_hash` varchar(70) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `next_block_hash` varchar(70) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `block_size` bigint(20) unsigned NOT NULL,
  `block_time` bigint(20) unsigned NOT NULL,
  `version` bigint(20) unsigned NOT NULL,
  `version_hex` varchar(10) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `transaction_hashes` text COLLATE utf8mb4_unicode_ci,
  `transactions_processed` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `Idx_BlockHash` (`hash`),
  KEY `Idx_BlockHeight` (`height`),
  KEY `Idx_BlockTime` (`block_time`),
  KEY `Idx_PreviousBlockHash` (`previous_block_hash`),
  KEY `Idx_BlockCreated` (`created_at`),
  KEY `Idx_BlockModified` (`modified_at`)
) ENGINE=InnoDB AUTO_INCREMENT=425342 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `claim`
--

DROP TABLE IF EXISTS `claim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `claim` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `transaction_hash_id` varchar(70) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `vout` int(10) unsigned NOT NULL,
  `name` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL,
  `claim_id` char(40) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `claim_type` tinyint(2) NOT NULL,
  `publisher_id` char(40) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL COMMENT 'references a ClaimId with CertificateType',
  `publisher_sig` varchar(200) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `certificate` text COLLATE utf8mb4_unicode_ci,
  `sd_hash` varchar(120) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `transaction_time` bigint(20) unsigned DEFAULT NULL,
  `version` varchar(10) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `value_as_hex` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `value_as_json` mediumtext COLLATE utf8mb4_unicode_ci,
  `valid_at_height` int(10) unsigned NOT NULL,
  `height` int(10) unsigned NOT NULL,
  `effective_amount` bigint(20) unsigned NOT NULL DEFAULT '0',
  `author` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` mediumtext COLLATE utf8mb4_unicode_ci,
  `content_type` varchar(162) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `is_nsfw` tinyint(1) NOT NULL DEFAULT '0',
  `language` varchar(20) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `thumbnail_url` text COLLATE utf8mb4_unicode_ci,
  `title` text COLLATE utf8mb4_unicode_ci,
  `fee` double(58,8) NOT NULL DEFAULT '0.00000000',
  `fee_currency` char(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fee_address` varchar(40) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `is_filtered` tinyint(1) NOT NULL DEFAULT '0',
  `bid_state` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Accepted',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `claim_address` varchar(40) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `is_cert_valid` tinyint(1) NOT NULL,
  `is_cert_processed` tinyint(1) NOT NULL,
  `license` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `license_url` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `preview` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `type` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `release_time` bigint(20) unsigned DEFAULT NULL,
  `source_hash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source_size` bigint(20) unsigned DEFAULT NULL,
  `source_media_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `frame_width` bigint(20) unsigned DEFAULT NULL,
  `frame_height` bigint(20) unsigned DEFAULT NULL,
  `duration` bigint(20) unsigned DEFAULT NULL,
  `audio_duration` bigint(20) unsigned DEFAULT NULL,
  `os` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `has_claim_list` tinyint(1) DEFAULT NULL,
  `claim_reference` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `list_type` smallint(6) DEFAULT NULL,
  `claim_id_list` json DEFAULT NULL,
  `country` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` bigint(20) DEFAULT NULL,
  `longitude` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `Idx_ClaimUnique` (`transaction_hash_id`,`vout`,`claim_id`),
  KEY `FK_ClaimPublisher` (`publisher_id`),
  KEY `Idx_Claim` (`claim_id`),
  KEY `Idx_ClaimTransactionTime` (`transaction_time`),
  KEY `Idx_ClaimCreated` (`created_at`),
  KEY `Idx_ClaimModified` (`modified_at`),
  KEY `Idx_ClaimValidAtHeight` (`valid_at_height`),
  KEY `Idx_ClaimBidState` (`bid_state`),
  KEY `Idx_ClaimName` (`name`(255)),
  KEY `Idx_ClaimAuthor` (`author`(191)),
  KEY `Idx_ClaimContentType` (`content_type`),
  KEY `Idx_ClaimLanguage` (`language`),
  KEY `Idx_ClaimTitle` (`title`(191)),
  KEY `Idx_FeeAddress` (`fee_address`),
  KEY `Idx_ClaimOutpoint` (`transaction_hash_id`,`vout`) COMMENT 'used for match claim to output with joins',
  KEY `Idx_ClaimAddress` (`claim_address`),
  KEY `Idx_Height` (`height`),
  KEY `idx_cert_valid` (`is_cert_valid`),
  KEY `idx_cert_processed` (`is_cert_processed`),
  KEY `Idx_License` (`license`),
  KEY `Idx_LicenseURL` (`license_url`),
  KEY `Idx_Preview` (`preview`),
  KEY `Idx_type` (`type`),
  KEY `Idx_release_time` (`release_time`),
  KEY `Idx_source_hash` (`source_hash`),
  KEY `Idx_source_name` (`source_name`),
  KEY `Idx_source_size` (`source_size`),
  KEY `Idx_source_media_type` (`source_media_type`),
  KEY `Idx_source_url` (`source_url`),
  KEY `Idx_frame_width` (`frame_width`),
  KEY `Idx_frame_height` (`frame_height`),
  KEY `Idx_duration` (`duration`),
  KEY `Idx_audio_duration` (`audio_duration`),
  KEY `Idx_os` (`os`),
  KEY `Idx_email` (`email`),
  KEY `Idx_website_url` (`website_url`),
  KEY `Idx_has_claim_list` (`has_claim_list`),
  KEY `Idx_claim_reference` (`claim_reference`),
  KEY `Idx_list_type` (`list_type`),
  KEY `Idx_country` (`country`),
  KEY `Idx_state` (`state`),
  KEY `Idx_city` (`city`),
  KEY `Idx_latitude` (`latitude`),
  KEY `Idx_longitude` (`longitude`),
  CONSTRAINT `claim_ibfk_1` FOREIGN KEY (`transaction_hash_id`) REFERENCES `transaction` (`hash`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `claim_in_list`
--

DROP TABLE IF EXISTS `claim_in_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `claim_in_list` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `list_claim_id` char(40) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `claim_id` char(40) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `Idx_claim_tag` (`list_claim_id`,`claim_id`),
  KEY `Idx_OuptutCreated` (`created_at`),
  KEY `Idx_OutputModified` (`modified_at`),
  CONSTRAINT `claim_in_list_ibfk_1` FOREIGN KEY (`list_claim_id`) REFERENCES `claim` (`claim_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `claim_tag`
--

DROP TABLE IF EXISTS `claim_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `claim_tag` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tag_id` bigint(20) unsigned DEFAULT NULL,
  `claim_id` char(40) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `Idx_claim_tag` (`tag_id`,`claim_id`),
  KEY `FK_claim` (`claim_id`),
  KEY `Idx_OuptutCreated` (`created_at`),
  KEY `Idx_OutputModified` (`modified_at`),
  CONSTRAINT `claim_tag_ibfk_1` FOREIGN KEY (`claim_id`) REFERENCES `claim` (`claim_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `claim_tag_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gorp_migrations`
--

DROP TABLE IF EXISTS `gorp_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gorp_migrations` (
  `id` varchar(255) NOT NULL,
  `applied_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `input`
--

DROP TABLE IF EXISTS `input`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `input` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `transaction_id` bigint(20) unsigned NOT NULL,
  `transaction_hash` varchar(70) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `input_address_id` bigint(20) unsigned DEFAULT NULL,
  `is_coinbase` tinyint(1) NOT NULL DEFAULT '0',
  `coinbase` varchar(255) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `prevout_hash` varchar(70) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `prevout_n` int(10) unsigned DEFAULT NULL,
  `prevout_spend_updated` tinyint(1) NOT NULL DEFAULT '0',
  `sequence` int(10) unsigned NOT NULL,
  `value` double(18,8) DEFAULT NULL,
  `script_sig_asm` text CHARACTER SET latin1 COLLATE latin1_general_ci,
  `script_sig_hex` text CHARACTER SET latin1 COLLATE latin1_general_ci,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `vin` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `FK_InputAddress` (`input_address_id`),
  KEY `FK_InputTransaction` (`transaction_id`),
  KEY `Idx_InputValue` (`value`),
  KEY `Idx_PrevoutHash` (`prevout_hash`),
  KEY `Idx_InputCreated` (`created`),
  KEY `Idx_InputModified` (`modified`),
  KEY `Idx_InputTransactionHash` (`transaction_hash`),
  CONSTRAINT `input_ibfk_2` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7028292 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `job_status`
--

DROP TABLE IF EXISTS `job_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job_status` (
  `job_name` varchar(40) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `last_sync` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `is_success` tinyint(1) NOT NULL DEFAULT '0',
  `error_message` text COLLATE utf8mb4_unicode_ci,
  `state` json DEFAULT NULL,
  PRIMARY KEY (`job_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `output`
--

DROP TABLE IF EXISTS `output`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `output` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `transaction_id` bigint(20) unsigned NOT NULL,
  `transaction_hash` varchar(70) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `value` double(18,8) DEFAULT NULL,
  `vout` int(10) unsigned NOT NULL,
  `type` varchar(20) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `script_pub_key_asm` text CHARACTER SET latin1 COLLATE latin1_general_ci,
  `script_pub_key_hex` text CHARACTER SET latin1 COLLATE latin1_general_ci,
  `required_signatures` int(10) unsigned DEFAULT NULL,
  `address_list` text CHARACTER SET latin1 COLLATE latin1_general_ci,
  `is_spent` tinyint(1) NOT NULL DEFAULT '0',
  `spent_by_input_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `claim_id` char(40) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `UK_Output` (`transaction_hash`,`vout`),
  KEY `FK_OutputTransaction` (`transaction_id`),
  KEY `FK_OutputSpentByInput` (`spent_by_input_id`),
  KEY `Idx_OutputValue` (`value`),
  KEY `Idx_Oupoint` (`vout`,`transaction_hash`) COMMENT 'needed for references in this column order',
  KEY `Idx_ASM` (`script_pub_key_asm`(255)) COMMENT 'needed in cases where the ASM needs to be parsed with speed',
  KEY `Idx_OuptutCreated` (`created_at`),
  KEY `Idx_OutputModified` (`modified_at`),
  KEY `fk_claim` (`claim_id`),
  KEY `Idx_IsSpent` (`is_spent`),
  KEY `Idx_SpentOutput` (`transaction_hash`,`vout`,`is_spent`) COMMENT 'used for grabbing spent outputs with joins',
  CONSTRAINT `output_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9002036 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `support`
--

DROP TABLE IF EXISTS `support`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `support` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `supported_claim_id` char(40) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `support_amount` double(18,8) NOT NULL DEFAULT '0.00000000',
  `bid_state` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Accepted',
  `transaction_hash_id` varchar(70) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `vout` int(10) unsigned NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `Idx_state` (`bid_state`),
  KEY `Idx_supportedclaimid` (`supported_claim_id`),
  KEY `Idx_transaction` (`transaction_hash_id`),
  KEY `Idx_vout` (`vout`),
  KEY `Idx_outpoint` (`transaction_hash_id`,`vout`),
  CONSTRAINT `fk_transaction` FOREIGN KEY (`transaction_hash_id`) REFERENCES `transaction` (`hash`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tag` varchar(255) CHARACTER SET utf8 NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `Idx_tag` (`tag`),
  KEY `Idx_OuptutCreated` (`created_at`),
  KEY `Idx_OutputModified` (`modified_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `block_hash_id` varchar(70) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `input_count` int(10) unsigned NOT NULL,
  `output_count` int(10) unsigned NOT NULL,
  `fee` double(18,8) NOT NULL DEFAULT '0.00000000',
  `transaction_time` bigint(20) unsigned DEFAULT NULL,
  `transaction_size` bigint(20) unsigned NOT NULL,
  `hash` varchar(70) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `version` int(11) NOT NULL,
  `lock_time` int(10) unsigned NOT NULL,
  `raw` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `value` double(58,8) NOT NULL DEFAULT '0.00000000',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `Idx_TransactionHash` (`hash`),
  KEY `Idx_TransactionTime` (`transaction_time`),
  KEY `Idx_TransactionCreatedTime` (`created_time`),
  KEY `Idx_TransactionCreated` (`created_at`),
  KEY `Idx_TransactionModified` (`modified_at`),
  KEY `transaction_ibfk_1` (`block_hash_id`),
  KEY `value` (`value`),
  CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`block_hash_id`) REFERENCES `block` (`hash`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3115133 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transaction_address`
--

DROP TABLE IF EXISTS `transaction_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction_address` (
  `transaction_id` bigint(20) unsigned NOT NULL,
  `address_id` bigint(20) unsigned NOT NULL,
  `debit_amount` double(18,8) NOT NULL DEFAULT '0.00000000' COMMENT 'Sum of the inputs to this address for the tx',
  `credit_amount` double(18,8) NOT NULL DEFAULT '0.00000000' COMMENT 'Sum of the outputs to this address for the tx',
  PRIMARY KEY (`transaction_id`,`address_id`),
  KEY `Idx_TransactionsAddressesAddress` (`address_id`),
  KEY `Idx_TransactionsAddressesDebit` (`debit_amount`),
  KEY `Idx_TransactionsAddressesCredit` (`credit_amount`),
  CONSTRAINT `transaction_address_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `transaction_address_ibfk_2` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`lbry`@`localhost`*/ /*!50003 TRIGGER tg_insert_value AFTER INSERT ON transaction_address
  FOR EACH ROW
  UPDATE transaction
  SET transaction.value = transaction.value + NEW.credit_amount
  WHERE transaction.id = NEW.transaction_id; */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`lbry`@`localhost`*/ /*!50003 TRIGGER tg_insert_balance AFTER INSERT ON transaction_address
  FOR EACH ROW
  UPDATE address
  SET address.balance = address.balance + (NEW.credit_amount - NEW.debit_amount)
  WHERE address.id = NEW.address_id; */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`lbry`@`localhost`*/ /*!50003 TRIGGER tg_update_value AFTER UPDATE ON transaction_address
  FOR EACH ROW
  UPDATE transaction
  SET transaction.value = transaction.value - OLD.credit_amount + NEW.credit_amount
  WHERE transaction.id = NEW.transaction_id; */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`lbry`@`localhost`*/ /*!50003 TRIGGER tg_update_balance AFTER UPDATE ON transaction_address
  FOR EACH ROW
  UPDATE address
  SET address.balance = address.balance - (OLD.credit_amount - OLD.debit_amount) + (NEW.credit_amount - NEW.debit_amount)
  WHERE address.id = NEW.address_id; */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`lbry`@`localhost`*/ /*!50003 TRIGGER tg_delete_balance AFTER DELETE ON transaction_address
  FOR EACH ROW
  UPDATE address
  SET address.balance = address.balance - (OLD.credit_amount - OLD.debit_amount)
  WHERE address.id = OLD.address_id; */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-04-28 23:35:14

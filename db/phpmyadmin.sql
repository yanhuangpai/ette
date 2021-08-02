-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- 主机： localhost
-- 生成日期： 2021-08-02 14:31:34
-- 服务器版本： 5.7.34
-- PHP 版本： 7.3.24-(to be removed in future macOS)

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

--
-- 数据库： `ette`
--

-- --------------------------------------------------------

--
-- 表的结构 `blocks`
--

CREATE TABLE `blocks` (
  `hash` char(66) NOT NULL,
  `number` bigint(20) NOT NULL,
  `time` bigint(20) NOT NULL,
  `parenthash` char(66) NOT NULL,
  `difficulty` varchar(255) NOT NULL,
  `gasused` bigint(20) NOT NULL,
  `gaslimit` bigint(20) NOT NULL,
  `nonce` varchar(255) NOT NULL,
  `miner` char(42) NOT NULL,
  `size` float NOT NULL,
  `stateroothash` char(66) NOT NULL,
  `unclehash` char(66) NOT NULL,
  `txroothash` char(66) NOT NULL,
  `receiptroothash` char(66) NOT NULL,
  `extradata` blob
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `delivery_history`
--

CREATE TABLE `delivery_history` (
  `id` char(36) DEFAULT NULL,
  `client` char(42) NOT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `endpoint` varchar(255) NOT NULL,
  `datalength` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `events`
--

CREATE TABLE `events` (
  `origin` char(42) NOT NULL,
  `index` bigint(20) NOT NULL,
  `topics` tinytext NOT NULL,
  `data` blob,
  `txhash` char(66) NOT NULL,
  `blockhash` char(66) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `subscription_details`
--

CREATE TABLE `subscription_details` (
  `address` char(42) NOT NULL,
  `subscriptionplan` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `subscription_plans`
--

CREATE TABLE `subscription_plans` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `deliverycount` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `transactions`
--

CREATE TABLE `transactions` (
  `hash` char(66) NOT NULL,
  `from` char(42) NOT NULL,
  `to` char(42) DEFAULT NULL,
  `contract` char(42) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `data` blob,
  `gas` bigint(20) NOT NULL,
  `gasprice` varchar(255) NOT NULL,
  `cost` varchar(255) NOT NULL,
  `nonce` bigint(20) NOT NULL,
  `state` smallint(6) NOT NULL,
  `blockhash` char(66) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `users`
--

CREATE TABLE `users` (
  `address` char(42) NOT NULL,
  `apikey` char(66) NOT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `enabled` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转储表的索引
--

--
-- 表的索引 `blocks`
--
ALTER TABLE `blocks`
  ADD PRIMARY KEY (`hash`),
  ADD UNIQUE KEY `number` (`number`),
  ADD UNIQUE KEY `number_2` (`number`),
  ADD KEY `idx_blocks_number` (`number`),
  ADD KEY `idx_blocks_time` (`time`);

--
-- 表的索引 `events`
--
ALTER TABLE `events`
  ADD KEY `idx_events_origin` (`origin`),
  ADD KEY `idx_events_transaction_hash` (`txhash`);

--
-- 表的索引 `subscription_details`
--
ALTER TABLE `subscription_details`
  ADD PRIMARY KEY (`address`);

--
-- 表的索引 `subscription_plans`
--
ALTER TABLE `subscription_plans`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `deliverycount` (`deliverycount`);

--
-- 表的索引 `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`hash`),
  ADD KEY `idx_transactions_from` (`from`),
  ADD KEY `idx_transactions_to` (`to`),
  ADD KEY `idx_transactions_contract` (`contract`),
  ADD KEY `idx_transactions_nonce` (`nonce`),
  ADD KEY `idx_transactions_block_hash` (`blockhash`);

--
-- 表的索引 `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`apikey`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `subscription_plans`
--
ALTER TABLE `subscription_plans`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;
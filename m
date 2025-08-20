Return-Path: <linux-kernel+bounces-778040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC14AB2E0A4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 696B5188E32B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833B4322755;
	Wed, 20 Aug 2025 15:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GF1J7UXY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rWgccHOt"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472C328D83D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755702197; cv=fail; b=nzzvnVmuWubiGnw7Vcr0vkAnNuENxkj00sQu+2FenMGvkPkn/OSitoHkUZtO8qT7V2W9bRdn/Eaneu0/CtmyhNpq0GsSrzTt4lSLILoTSkv71EXldX5MYAcWwhupbD0a4PlK4f1q9epqyPs7VNFlWP9bBkrh5XYTkevXi+tUgX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755702197; c=relaxed/simple;
	bh=/hNhHpnKhXvjWCastSoJz+f+5T7L/KEojet90rtj6yY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gngonZwAw69W+jGbm9FLWOSksujImxUGnPC6uot8nWvFxaqBuD1xyzKvDIe6TXTIAOi4ZLxikBp5LFaoqFImK6WygwGA4BlZcKkFYJviKAH3lprA2v1HJuskaIIMt/cTrkgzt1yrP8zZWFR21SNbVmtfjS9dWJS6SGWBSLhAHSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GF1J7UXY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rWgccHOt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KEQx02010061;
	Wed, 20 Aug 2025 15:02:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=7iR7CjT4IEtgN7GQ
	Ae0USLIu8n+UfiqSpuiN6Dj1tL0=; b=GF1J7UXY7yavG68P9axcMDFmvNmnNIWB
	3yc/kvpsKkZhI18i3dnGPPdCyTu9Rl9yU57P89msYs/U90qsKtrosI92/sCrg3m3
	kwD7KIdeInpKGTz7slSvlfvTC04NLK/LCnuIUPurGXSv2mFpZlGPzeMQ2CPmZlKw
	Juxy6A1QpQKK0jrI78zKSXjLmGd4MoeGAJ58hIZvBHEnExfajlistqsU3/Yfy0Ii
	1CMm6kJ14lOsCSXao4lHwhEWFjWPnMZbYbrZwAD/nW4wekIeX53p3XIY6K6a4JNp
	17uhgajgcIdAN8BCkG9g8yqLMSUoGxtMxZh9M6LtNtJ/lVCPjwLgpg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tssgn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 15:02:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57KEAuhT039529;
	Wed, 20 Aug 2025 15:02:36 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3qvrnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 15:02:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7MZ2MMg+1EfbZrEImkJpCv7ULz2hR4YIg/A/hk/rNgY6/4ojZzXqiHGPw2l3MomC4ADDzC+u3i5R5ISrz+GxlWOiI2sUnRvVRMZU0P0hznv3M2yeFnrArZ41iyuQt8qDM+R7f5FOzaKLU5Z8PGJszWjB5w0hu1m2M0oGwLkxkYAP7SNP3PCwODo7iZvEmj8S/xdsvDl6Uo2wbBtz2lW6U5cGiMG0Rc94Ayw3WipaMYDKEG6OvKSArBJHfGIDf1XFqvIsFRLcOYxdxKJXn9pBrefEsO6MLe3gbLt4+gh1Kdz6E7tyE4zyI1n0Id9Pxzs4YNkmJpsR0wZvFzzMo5Y7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7iR7CjT4IEtgN7GQAe0USLIu8n+UfiqSpuiN6Dj1tL0=;
 b=mO4oxQmzPjSPFY45B9ezap3hpOuMWSSdkj8ArXjGmEn3YCM5xGmrZrVkspgx2sQiBtyWu7skc4bEAWZwQn5qqOuw9b2husy4IwqMswJYDw9QpmVzoVkwefuugu8ddwF1Nf3MicBLpuqmAmpRMZ7+BDVznFYJgTOTvzSSJ8ivzjzvHYM82r9xSQ7+9xPCuYfQryMkq1AUpIuyJnD1hlLPdN/y72s2oSxYQtFpp/UW6Rsdb8HIhFVdSfPgac7hFxo7CZ3i7d7SjS2NNZZKJ+IQ/XOauQyYfP0GGVkQjzr0dKAs9Dqup0YgzWPEG2cf6UlQ3UzhvltK4bSN9L26oNYRBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iR7CjT4IEtgN7GQAe0USLIu8n+UfiqSpuiN6Dj1tL0=;
 b=rWgccHOthmpQjeZmWcABCf0OnOfuHlpnyPVtYLLdKpLhJGoFV2e8+6xwIUPgXeOCKIF0KW9RmCpVv29BeEJ4tt2+CtJHesRJZ7K8lzqgREkbtLuL0eaEIERHdOv//oJiqz6ro+iu2g/Y8PQ29UbeuZkl8ez3dUPj5C2yqj1xiOI=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by SJ0PR10MB4751.namprd10.prod.outlook.com (2603:10b6:a03:2db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 15:02:31 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 15:02:31 +0000
From: John Garry <john.g.garry@oracle.com>
To: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        tytso@mit.edu, nilay@linux.ibm.com, martin.petersen@oracle.com,
        djwong@kernel.org, mcgrof@infradead.org,
        John Garry <john.g.garry@oracle.com>
Subject: [RFC PATCH] nvme: add an opt-in to use AWUPF
Date: Wed, 20 Aug 2025 15:02:20 +0000
Message-ID: <20250820150220.1923826-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P222CA0002.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::31) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|SJ0PR10MB4751:EE_
X-MS-Office365-Filtering-Correlation-Id: fcc5aa08-4afa-4da0-47ed-08dddffa966b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fxyBYzHtbOtg2DVLHe186ASufp80H/kcu5QzLJkhlmreETULrvg5EBqwLV3I?=
 =?us-ascii?Q?5LyLXxg5so4jVd2XpHMi+Qtl3J89if7wZmgq3JQr0NyphY6aC2hKF6GOTpp+?=
 =?us-ascii?Q?RoRh++rk6ZkdBWFcNnKB9a3c5HcSYrk4gNBciUHW8e+y/5pOxDF04AsM8K3D?=
 =?us-ascii?Q?/53K0S05MqLNbkooNZI3edFkrgDIdRYqI1d/rnJ9DIoimbGkLkllKeboGmSA?=
 =?us-ascii?Q?UukpvVV/GmK6z0yLMgCrb7EPgnNUAF07VM6qA7NhE/xgf858yjpjhGTHbOlO?=
 =?us-ascii?Q?6SzrSR1QbpfPvsGojzor0Nyoqpl7La2FAmQh9HiGnaEVA51I3ftZZgmnleqQ?=
 =?us-ascii?Q?X+ZZrYWPweLQJmDyCzhS5Wh664W3VqJ7jgqQvk/bIziyD+KOy8PNzDekIdtb?=
 =?us-ascii?Q?1e03+WDGCEna1LHEA4GD7bC3NM1QAqxrvn+PeQ9IUK9K7vfuHeKA+oUBtGSB?=
 =?us-ascii?Q?KhinsAtv7uObfuF6JElMMxG5Imm4L6xX/z4qb8Q1nlq1a0NZ3FpnqN7iCX6T?=
 =?us-ascii?Q?HhGe5bozCbs4yXfm/nOhzeVvXX/UG+ceCdsj2sywkVGckdaQqou/aK+B0+YM?=
 =?us-ascii?Q?9Mv9K0CoTVLrcz3XN6wW4DX2PbDDDOGIMc0e3+Pa5R6vUIUfHW3qDsKcZcp7?=
 =?us-ascii?Q?5TyEgcDCCGajarQyWwL8ij82SsluJpdzGDkP3jGJzxuGWEcqUE1kUr6rYQC+?=
 =?us-ascii?Q?E80NLgvIDlovfeU9ZpPNr+SWfsTtFcErqXED8/XbaK3aMR6cRtUDZGBaiYZ3?=
 =?us-ascii?Q?LzyfRDzOq621rME1XWf3U0HPUDQhFGoSN3Jik9SbDGU9Z6tzd+PFrw5oYVni?=
 =?us-ascii?Q?fGafiZp3zj3eWnCucI6IACPRd3fT+BFaGc2uDO3JKVuiKL71ufre8IzQjaYB?=
 =?us-ascii?Q?WRI8Yve6eJnZlYyzW0gQ/P8BcM3thZUx1YHuQ9znvut6SjWMcAhxPdTdKRi/?=
 =?us-ascii?Q?N8TgqN7ZohiSkcfJG6jKagkxwKhQkU5ba9vzqP3sPPo7psVZi3TTf0Idhh8b?=
 =?us-ascii?Q?SQ3r4cGId2CgSgQFmsoPZiuQ46dKCi9vEyi/dOTL3KVgx84FIdxb2yzDK85w?=
 =?us-ascii?Q?cppuafcTf3X2nmKoLcxhn+FkSyygQZLK0JAckvFGEosz3dpzzzCOUFI/QqU4?=
 =?us-ascii?Q?5ELWxKiLTFzgPNZmYeVqxK3S8Iq7OeAFlpA5PChJ9mvXk6SxvrATPmUVaqhI?=
 =?us-ascii?Q?VB7BYyeH4VAAz7Idave41EjToZxOvT4W9JCRzhDcBclTGfrpRlBuV0Vhq+vR?=
 =?us-ascii?Q?wDvheqP3oSwWaTu0fwzmAFvErpeWs1FB1hdCSLMvbGS+Zk7EunttWkoTFHIr?=
 =?us-ascii?Q?8ojxamaX3sMT0Zdmat/3z/AHIXrQp3PYUxmKypQvlTUmtzwTSWSweAdkPBn2?=
 =?us-ascii?Q?3UGMWmtcwHILS63QNPV5GfQYlZ7ZwQ6cAJKW8Fwmed7UG+niDC6vNxAO9ee2?=
 =?us-ascii?Q?iaeaEBXrmvc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dcyYjgSWCNdFDGOv1kVjpsjIEuXazu2mUOESErvJP9vC5x9njhBwgBMqLAIC?=
 =?us-ascii?Q?+40RAD/0Nq6eh/EACejRrGrBkYxmDvEmHNET5jKigjAyj02nDn6jw8MPZBf5?=
 =?us-ascii?Q?5X9jxPwvIWLdNpm9rfqdWtg35nvd0ff9Yj2mRm8L0kiCBNSALVdKDRhwkuoC?=
 =?us-ascii?Q?Zx63/mBi2yCUlLpBQ0AIpIOjXpsxEaxgyFMDX6kWM6A8kzkmZGLFRhM1Rg1d?=
 =?us-ascii?Q?XVpw0gp0c1BqXIefw/fDkOUVbveG92xj/mh8adBrztZpCOzrz3cX7r7QBS76?=
 =?us-ascii?Q?QM6kcLme3MBjfgaUwZO/YYoKNLJJlq9hGF9HwEDuuPS+tL4acoZFyPJFbJ0x?=
 =?us-ascii?Q?g0AMu5WCAbMmm6aTlyUVeqJUFcBbZeZFnY6bz4+m9lFiYZVuTojRvHNBKtJb?=
 =?us-ascii?Q?EgsPNJdgQV9T3Ns4txkvzyYc+EBVH8sSLmy3hGpET9MJdbSSF1876h1YwyZ6?=
 =?us-ascii?Q?iWLnmK89Hl/1C4zDPn7UAfZVRVcJYhpQJ4gIOvzXy9PACJSMhXHxuES1TgEp?=
 =?us-ascii?Q?G43D7M1vq+rBRp1+R8KGrEdsuaLGgSrCXSCjpMLOSd87loVJ0Hz43rq+COXw?=
 =?us-ascii?Q?0G3h2dE+fWW5EstkBR9cLiU0lbA4hIBhv6Jn0O2mjhZhGvRbFvSE16/hQEHk?=
 =?us-ascii?Q?9iwhQKWa6akzoctqniAB2pKDM9NWkjIN4T/ovT1RZmfYirYRC0mf0kt6ga71?=
 =?us-ascii?Q?bTR/neGRVkBaUNmDimbsI0ZbFEF39I8FD0Kukkz9ZWq5fqjY9KGOAHng4s8g?=
 =?us-ascii?Q?BVqBPxHERPRDt8Kske0UGAu5fiCBzWRK6LG0O57D9hmCho0DS6holSwzXjGT?=
 =?us-ascii?Q?VPVVvT1DTPAnSExGYq4CqFuaUZcTrm7Wt2YKfscXg10uAr8WjyvlmAPsCGv1?=
 =?us-ascii?Q?yc+dnaxrf8sJV/xYocwy5PvHZwKHkod9P/RV8Cyd92IAg6gAfjic6z5cdk+P?=
 =?us-ascii?Q?g9EhEDTEMlImLmaLrOIOeI1yGhPWVhAONPIxPKDt0hz68F38PLzKgD8PdcQg?=
 =?us-ascii?Q?YLyWZSFJ2WJjvkch2RG/zYSUXvNn7Qp0M9VbkYM04gvMsr1SVMKNgwzN+cyN?=
 =?us-ascii?Q?uS3yuceYadw+Od94B4sothe0LqJ8V07E8y7QSMa2xW5Q4E9Qk/PrWM3glN8L?=
 =?us-ascii?Q?uC6M092FgsOhRmsauYxA8w56dIH7KyhTyKBYmNjQRCMJHoSyzccEvrnJZUi3?=
 =?us-ascii?Q?sHYzwhKyuf934Lw3x8gbxeO9TIU/24HVgTAo0lECK+R+P9+didn4Rp+jC83j?=
 =?us-ascii?Q?aKXbz3gtK9g1jKT1xGs1mQdud6SxDgrcM1h0XddZvhaRHvAA7SN5cQx9Tnyl?=
 =?us-ascii?Q?dR/QApKuBTO3XJ+vmzfYU5t29EbRg1LWMYXBSuvibcFvUW0hWB/QWUV5YEu1?=
 =?us-ascii?Q?iEGhU7ButOckIGMB/2ooOWAoVK3FDlFcyXcuK2NJ4a2ZW/0pU6ko6PZXFefF?=
 =?us-ascii?Q?oehqgASCSoNfmOiYOer//fQmbv1OaSQh87CoEdcWODzhyRIfmWD5qAMgGEWw?=
 =?us-ascii?Q?YC+3WIPbN8MLTKdO7sAaPzDcp2Vwtzda0QGuXOfB2JUkH4aI7gbs3ds75K2T?=
 =?us-ascii?Q?Z6VglndfnKruBEkBryo4PfH7Jy7zopOGp3jSZMnJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EWbKzvS2chR4roIGoR0w7l7o93nN0AsS4l8lx99Qxe+D4r9mEyNzaVjDpDk/PQbClXWenfmtUczPH0rEoenwIHnB6BaXmssMQBSkemr/S9ClvdvTyXE0kOE+QQkKDCrEVfS+6YLhC7XwsbJG2Ogku1NP7fL/jnKLWChjbncHvJO9hv2fLpfg++88F3iK9EcDDXeaxXcelyA+WrCPWURxJ0TFZZATDiahwVXAeIfPnsS6uNN9/D/zJihvTqMBSUGktWK9ro4xBk7evfhxZGj3uJKwbvfxmDKDr9IBHaFO8iHq4tFkVmLqoH8TCiWAo7jFmtOAaJsuHRc0V20rnq0QgCDr9zlOuSVvYhfcXRo+RjQpse8VRTEWjrJ4dlRN0cWyoP5Dv2FyquJTRKluOcWejeAdj0utI2a5d78yKZU7JbXMLg4RNL83lre8dYZDGs8pFFEgTM5Ex5OqZ5B96WhfFFHi80raFM5jauctJbVyWEw0RiLYbIozqoCrMTD/fOKzeRLGfMFlPDID+SikCKaCEsfduReO88WMrTLE1Osh4/ZCnb48leyQHZEXk2rexlIVMo+tg/QWUQRK/mF9a54QLo3ERLQJ97j5gXR5u4CgVww=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc5aa08-4afa-4da0-47ed-08dddffa966b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 15:02:31.7588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eKb0DyJ53+828MHI1uGIKyy2pystlSA1qRumwCfP1UpOzAYB2LNuYjYgfpMDyCfv5PGLIiHKBbZrU2k76eqyLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4751
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_04,2025-08-20_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508200133
X-Proofpoint-GUID: JpHIeUgQGpqPWkG7MZI_x_HtQVx_vsQm
X-Authority-Analysis: v=2.4 cv=S6eAAIsP c=1 sm=1 tr=0 ts=68a5e38d b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=fHCDSAZKjT4M3_Vp8fUA:9
X-Proofpoint-ORIG-GUID: JpHIeUgQGpqPWkG7MZI_x_HtQVx_vsQm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX3oKDYBlgj2Rx
 vJ+pSzc3tIDQUVnCuFBNdHXJj7ZyrfzWvdM+EsEOOmAOuGCN97fpUrC9cAbA1NaBfpPfrhY1pmC
 3ma/ZoweeDTkx6t4l5ycKR3XycREgcpA7zpIjXv5FhMz8eC6Z+j6QB3DjntrkN6tptR94ib/M42
 bjQgqWxcJGwO3fXcyhg22wKSWCWgyPLmuzQqxFRLMhTF0sMTmUSC9X0e4UfqSJrMW8iCDgU7g6+
 vQIVwtExcrrys0FkuDxiVBdrZZvDSIIAaR47m1PEpCU6IW0YTZjDun1Eg0MagLMp9508X0Bwejo
 WIbA3opdzi+BDXyo6cYjdLlanVuAB/eW9bRGDrClHoSkvFBOyPcXScAiebaNxt46FEZXjA3RP+V
 zbw/DK5V1ktyMzczPCn2sfZ1lSiQfQ==

As described at [0], many parts of the atomic write specification are
lacking.

For now, there is nothing which we can do in software about the lack of
a dedicated NVMe write atomic command.

As for reading the atomic write limits, it is felt that the per-namespace
values are mostly properly specified and it is assumed that they are
properly implemented.

The specification of NAWUPF is quite clear. However the specification of
NABSPF is less clear. The lack of clarity in NABSPF comes from deciding
whether NABSPF applies when NSABP is 0 - it is assumed that NSABPF does
not apply when NSABP is 0.

As for the per-controller AWUPF, how this value applies to shared
namespaces is missing in the specification. Furthermore, the value is in
terms of logical blocks, which is an NS entity.

It would be preferred to stop honouring AWUPF altogether, but this may
needlessly disable atomic write support for many "good" devices which
only specify AWUPF. Currently all validation of controller-related
atomics limits is dropped.

As a compromise, allow users of such devices to use atomic writes at
their own risk by adding a per-subsystem sysfs file to enable reading of
AWUPF.

A udev rule like the following could be used to auto-enable:
SUBSYSTEM=="nvme-subsystem", ACTION=="add", RUN+="/bin/sh -c 'echo 1 > /sys/$devpath/use_awupf'"

Such a rule would need to run before any filesystem is mounted on the
device.

Having a per-controller file could also work as an alternative, but it
is unlikely that a system will have a mix of controllers which we would
want to selectively enable reading AWUPF.

Note that AWUPF not only effects atomic write support, but also the
physical block size reported for the device.

[0] https://lore.kernel.org/linux-nvme/20250707141834.GA30198@lst.de/

Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 812c1565114fd..e8c78e000d9d7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2040,7 +2040,7 @@ static u32 nvme_configure_atomic_write(struct nvme_ns *ns,
 		atomic_bs = (1 + le16_to_cpu(id->nawupf)) * bs;
 		if (id->nabspf)
 			boundary = (le16_to_cpu(id->nabspf) + 1) * bs;
-	} else {
+	} else if (ns->ctrl->subsys->use_awupf) {
 		/*
 		 * Use the controller wide atomic write unit.  This sucks
 		 * because the limit is defined in terms of logical blocks while
@@ -2049,6 +2049,8 @@ static u32 nvme_configure_atomic_write(struct nvme_ns *ns,
 		 * values for different controllers in the subsystem.
 		 */
 		atomic_bs = (1 + ns->ctrl->subsys->awupf) * bs;
+	} else {
+		atomic_bs = bs;
 	}
 
 	lim->atomic_write_hw_max = atomic_bs;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index cfd2b5b90b915..d75a82851b684 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -447,6 +447,7 @@ struct nvme_subsystem {
 #ifdef CONFIG_NVME_MULTIPATH
 	enum nvme_iopolicy	iopolicy;
 #endif
+	bool			use_awupf;
 };
 
 /*
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 29430949ce2f0..ca2e4b5937289 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -894,6 +894,75 @@ static ssize_t nvme_subsys_show_type(struct device *dev,
 }
 static SUBSYS_ATTR_RO(subsystype, S_IRUGO, nvme_subsys_show_type);
 
+static ssize_t nvme_subsys_use_awupf_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct nvme_subsystem *subsys =
+		container_of(dev, struct nvme_subsystem, dev);
+
+	return sysfs_emit(buf, "%d\n", subsys->use_awupf);
+}
+
+static ssize_t nvme_subsys_use_awupf_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct nvme_subsystem *subsys =
+		container_of(dev, struct nvme_subsystem, dev);
+	struct nvme_ns_head *h;
+	struct nvme_ctrl *tmp;
+	bool enabled;
+	int err;
+
+	err = kstrtobool(buf, &enabled);
+	if (err)
+		return -EINVAL;
+
+	mutex_lock(&nvme_subsystems_lock);
+	if (subsys->use_awupf == enabled)
+		goto out_unlock;
+
+	list_for_each_entry(h, &subsys->nsheads, entry) {
+		struct queue_limits lim;
+		unsigned int memflags;
+
+		if (!nvme_ns_head_multipath(h))
+			continue;
+
+		/*
+		 * The head NS queue atomic limits are stacked. We need to zero
+		 * to stack all the limits per-controller afresh.
+		 */
+		lim = queue_limits_start_update(h->disk->queue);
+		memflags = blk_mq_freeze_queue(h->disk->queue);
+
+		lim.atomic_write_hw_max = 0;
+		lim.atomic_write_hw_unit_min = 0;
+		lim.atomic_write_hw_unit_max = 0;
+		lim.atomic_write_hw_boundary = 0;
+
+		err = queue_limits_commit_update(h->disk->queue, &lim);
+		blk_mq_unfreeze_queue(h->disk->queue, memflags);
+		if (err) {
+			count = err;
+			goto out_unlock;
+		}
+	}
+
+	list_for_each_entry(tmp, &subsys->ctrls, subsys_entry)
+		nvme_queue_scan(tmp);
+
+	subsys->use_awupf = enabled;
+out_unlock:
+	mutex_unlock(&nvme_subsystems_lock);
+
+	return count;
+}
+
+static struct device_attribute subsys_attr_use_awupf = \
+	__ATTR(use_awupf, S_IRUGO | S_IWUSR, \
+	nvme_subsys_use_awupf_show, nvme_subsys_use_awupf_store);
+
 #define nvme_subsys_show_str_function(field)				\
 static ssize_t subsys_##field##_show(struct device *dev,		\
 			    struct device_attribute *attr, char *buf)	\
@@ -918,6 +987,7 @@ static struct attribute *nvme_subsys_attrs[] = {
 #ifdef CONFIG_NVME_MULTIPATH
 	&subsys_attr_iopolicy.attr,
 #endif
+	&subsys_attr_use_awupf.attr,
 	NULL,
 };
 
-- 
2.43.5



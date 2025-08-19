Return-Path: <linux-kernel+bounces-775907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A52B2C647
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA341624AE9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA3A340D9B;
	Tue, 19 Aug 2025 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="oT+rlwhX"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012057.outbound.protection.outlook.com [40.107.75.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DC12EB840;
	Tue, 19 Aug 2025 13:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755611530; cv=fail; b=fQIEROV1JQor2k3YytmNzf1qj+NXMffNVRwqBWslMSKgNCeGHmCacDwi3qIzJa49aEg5Pkuju6YcEgpWPs6QSAO8OImVTUE8sMcs2c7hjt/IOS+SD8EgEmu+rCeaKFONJ7UesrtOH1IezXc4NKGKdBHhgW4P1qHnyNDg5RGpW9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755611530; c=relaxed/simple;
	bh=BHs11Sao1h1A6BaV/oDInOP+qhKTviZkfcNYksIGOMU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Ce15Wr3PzfIePK2EAR/55nqRjcnQPZfLoA/4fbSRrpfDB5+sKFR6g+Nc0Two5/yPxrGhFLHxKxhT9ZfE+DPgEE4/rUxWuUorBD4Jz1QyWwPyfxfONoaEKTMTsRz39JcpQt4DhoUvCUgsVdzVoMstBQvtv3+YYGszVnsl/sxIk4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=oT+rlwhX; arc=fail smtp.client-ip=40.107.75.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vv7Li5QRvH1ZEY0dhcOWC8wDk17YVL2a5PCpVV+192QeR3KjxTmps846fDU4CB6UAxoJ9knJ1suOVcDAPENo770owhRnyHDf3LQBemqd03+coIzH4D6U0KgUvPq9K6bCwz1pCxJw4dbHBjCtqXKSmDWB3NpJlnqG+TGdYEt4+MiiP5UXapz7ULQnfntj7jm+u9eJCKOniVYWMFQmbs3YjGhtDdKKpjvJkfRFIN+xj598cW/vhFywOxfLxdYNbC+biHGqC9tZL712sls9KtnhMSkpFheN6UPDjNvrlmwfUPhVueHszfGFesK0euwDKL18YJJJqqQG8JTL/RUdMtQyJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTd7R9mJBHAu5YOm+eUap//mpv8wzUIPzne4tNnfU+s=;
 b=ugp1GTSf+Dtrdb/OGTSZg/PL8J3Pw4NmCSJ4nS0v+fijjch3T9gD6jDZhGY8FRg4/VJ/A1OIIJXTX5GVF5H9wLd6yVpLeoZXI/pZttl1u7ZjbtTv14BHhyfzd9hm2Hu8joGFd2UtfgdVinWZMXohunTpiCt0GKAjUGJyTTtMxccUbDOXpRhB+pNS/FxjicQpgkdaoFIw+4dTAC0YzWu5REXB6okP5NZcWLQ3Dw0wLLM2wwT1USUYrj9K33+Lwl9mVRVsGAdM+IlXBhi93F6hEcVrjtWPxXlLM4nAyz852Pi4T0BEjxxmgpJPMZ5CidVRzNRD/FhEhCGC6Xpxlkfw7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTd7R9mJBHAu5YOm+eUap//mpv8wzUIPzne4tNnfU+s=;
 b=oT+rlwhXVM6u9gsN53jbql3vcWAXR1n2F30Auu8VW/fKCMgzx6hH+WJIgkOOpdtrcK87rG7jdq6eaBRD9EPOgoS3Po9GVZcy0w19p6nr+VqI/g8I2D3IAZ0FPz4dkJ3IbKPC5CNZSyfQeX4QCdpr02uZJibngQeAdh4vzPjtl3it9+iSlySRAdW8SPGLhIGPf6BSXJYapn53b6Q1p2Dx/hnwsNpjmqLUImgsn2P1MN83tqaUD8w2qZUs/ha8y7G7cg0dRSHq7li5l16HklqFuEn9LLwPD1GZHjJJdtg1BhTwBBnhI2nfWQmG5T92+bW2g7F7bv+pmbWuLYUiDFrCLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SG2PR06MB5262.apcprd06.prod.outlook.com (2603:1096:4:1d9::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Tue, 19 Aug 2025 13:52:05 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 13:52:05 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@intel.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] platform/x86/intel/pmc: use kcalloc() instead of kzalloc()
Date: Tue, 19 Aug 2025 21:51:55 +0800
Message-Id: <20250819135155.338380-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:194::21) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SG2PR06MB5262:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d0e455c-3bf8-46f8-c4a9-08dddf27950e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HQLE3maYccmFLpFcEXLzrfiGzvj5lA2rtiEQ/3cwJwhdnajoHyHLGk8zGzxl?=
 =?us-ascii?Q?l0jSEEvQICYr7xSMD73XCj3kHvyCVsG3bZDkNs9tM3kc6IAIY0SXwmrBXkp+?=
 =?us-ascii?Q?YnUFjzn5iUx3/RteZx3QcAYF9/mxc2Hvqi433leOb8N5Ue7dtuxowTRCYMGk?=
 =?us-ascii?Q?swO+ClZNSaMmUTmwCfe8uH2SB8RiPClsElb3dSSI57BSHgnS4apw4YHnvgc7?=
 =?us-ascii?Q?GJNc3+G0rvqFGz4Ie27loAPY3BwVqb8yr8v5oaKVMOFJ2ixpH5YsBJo+ndZM?=
 =?us-ascii?Q?EvqANcG+uss3TJwMKo/G7VZ6bNfNT8Ey5o1ysWrw4HjnLNVtb4TGMSUMIPnG?=
 =?us-ascii?Q?wHWTk/Hb+bH15jhT/535T2DUmyBlu7DhBgDp2LOA9xfh3B6/hIkG9ryRLmh4?=
 =?us-ascii?Q?igcqvIrOqldQA54SONlep8hPUY8DT/R339q7I4DvAoqJ8pRQspBNPZMwO8T+?=
 =?us-ascii?Q?T1XjjvbYIjHwJ0EODHEgN+kzb7jd17ttnKH4K9NBZeUVe0A3WFbDdUr/xUSV?=
 =?us-ascii?Q?cI1kex/wUkA48C7n3Y8qLogeVwl63liMWc62lf1hsAvBTyTLAM2/+U4y9FwG?=
 =?us-ascii?Q?6J8Ru2dXWw7c1lzBE7SvvTg1SnkGw5sVPj2Z0J99coywUx6vzRn1EVzGPjOd?=
 =?us-ascii?Q?3vaPgOEbjRaQeUfAGqeL5eUoEEfGjqoyHO1nLhhfh0nZ41owRDW1DiteJPOj?=
 =?us-ascii?Q?oJRMu3BF1gh0/AfaVcmlk1ZKL4OGlCBXa+uBMC1Lh1oOo56Olv7hVrS/qK2k?=
 =?us-ascii?Q?pFlJjdOFu6g+TvxVvNwHRMpk9DkiCJkFHfTCPjosklXCsXqx8YBDc53kkAYs?=
 =?us-ascii?Q?o+MeFd5ByGtwPdL6EmtTDlYbxACuN9lp47J0B+rF2vaR3hGlXRJxauDC+Qld?=
 =?us-ascii?Q?sH2qPdAUGAiCyYwgaMlza/ltfSGjrR+YSxueEUXpryXXGlKnmj/k5JtM2Ywy?=
 =?us-ascii?Q?YD5cG6Iq68gNan5y4Vgh2BXTW0c+k54oiuPjtz0eKgbFN9W6PdPe0+twQtF/?=
 =?us-ascii?Q?EqhNBsZUWK7DM6UDgGHnmSuqqr2r7F8cPgPzi91ZBYUX1KxpCAyDz3UjR21j?=
 =?us-ascii?Q?Kl+3wApcK30jibsE8Y9Y1XgrukoEGxv9f8WbUs33rQWSsQPMY30xiVC6QxEL?=
 =?us-ascii?Q?DgH2TliCPR+6xL0GT5bF4AqwZXoQWm7uf1VtenLHx22JejaVpqqB8GWaDbNf?=
 =?us-ascii?Q?dPcrbtxiBmf9m4Ovm9rJuy7OuzzYUYYA6eKNv8mxj0kLaZkczuUEfMtiSqLI?=
 =?us-ascii?Q?mMCUZN0HZ3r0xbM+COHJQ/8GyAO9+lNFbBH1hF/f9LxqwxXhaGmnRbWkaPNC?=
 =?us-ascii?Q?pYC/8uXfa8gwFaQLrz64Xh+ZFi9HStWgv7iaqr6iLnZgN+diYA4uX1Fpp6GQ?=
 =?us-ascii?Q?+jyY1SM5HZMAI5WZWa1iI/bhvkQZyOKk7ARd39qPOZX8ZLs95K+lUPe16E4q?=
 =?us-ascii?Q?bOgrSs9w644=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iztb6AHCy2AZsZekG6ueqooLQ67iuzBNz9ARB21QbuFq5h3jbBMQ9yvhSDfR?=
 =?us-ascii?Q?m8aFWwfZFnsIc3a/IXCzvoiOPvpVgPlBcTswy0KVTpST27QBCemkaYhMNs7M?=
 =?us-ascii?Q?t/qKkfBJI6p+5yg0LkTpu0TzH0IpGaqgFwLIwbd5/elQhxAwy7hYy/RIwjD0?=
 =?us-ascii?Q?N8f7hagN4Po4+Jky0BLW8IAWrwNj3U/M1e/GZ5zU+NJjNu4gf4tfMO0y3IMv?=
 =?us-ascii?Q?hwm8fpiNVXeq8SMOWqrDB8prwQiRl+/gNo402LadW1k0k97BZT5r9e61NmOK?=
 =?us-ascii?Q?4ApusfThPqVI3nd9SG8qAXPRZRF1xqGBC9UriexZMOIo7YdlIgDjzmD/W34k?=
 =?us-ascii?Q?+BARJ1RKRNC/OphBUWJ86+AgdKjeEL+WSMH6pTeifMeeIy3kY+nEf0m/TKLr?=
 =?us-ascii?Q?0Mb4noB02rDTLC2i5WgqOO4PK78pa6rzyzyjZLUGhsSNMebd2v+BcAEyMLS2?=
 =?us-ascii?Q?FzZQTOwxMqyVdu73oCIeigPvIVAPfhD5pj4uiYJgiNkWYs4z8mWW3+dpla65?=
 =?us-ascii?Q?omLaIMtJ4vKZGiSyJYfuykp+JFC56z5H1k2Zy1bIRFJ46iOABHCmMNiMX9n2?=
 =?us-ascii?Q?zr2xwE4ee5/K9b1KeaK3W4o4dzDEqtc+RnneqPLtcOUJJLZkCnNZfa8YXRwM?=
 =?us-ascii?Q?hYbkfRaetOpDMec1oLDQ1wnzCSZqgqao+QLTKcca8YFpfpns94UdqzunCYq0?=
 =?us-ascii?Q?NzMvk6NVBg5Sf4F9qziph/L0MZu5D3jylZZdFstlt/dXPKDHBo4x/xs/Y1zB?=
 =?us-ascii?Q?3va8GlEzsuqrTGHeEzwBdGx82LHp4dFVpWA8tExy0oTe/ytkp+HDBMCLBoSu?=
 =?us-ascii?Q?6Pd/VJp4kkBYXYf+l6xFu1zYmeHfpNwooKyxQSxuA2pjaptd5ZbeytvHdVNO?=
 =?us-ascii?Q?WngXiQFD6W2OKRV3NJp/BswCP6T6VZtJwvAA3UlnIXFSRxRZUUO1F9Y0A7jo?=
 =?us-ascii?Q?iZTULuLK4MI8ZH6qaN4p0bzhhd4UncXq2mpizYTN3ZDa+jjvwLDy3rX/CwNK?=
 =?us-ascii?Q?1xZ4xIfKBvbNjjrXq9Bu+RnCIj80cD496NXXBDoFFaXGtW1FmdXX9O9bbqj3?=
 =?us-ascii?Q?yObhUH2trppmmV782GVrb6H8/3oBl4QBTfJLM5MBJEMqtZy9LDup3CzKWeRv?=
 =?us-ascii?Q?ygjQauSJB9iKQyHwFuz1lCUSaYwoyJHdzpaVdTs/DYHtG7QptW4JTyfyjPNH?=
 =?us-ascii?Q?TWIOhv7aK48WaWOmuG+s5JBh6rv8CKUXIglvWN62h3KUHf2ZVbo9ID33cipi?=
 =?us-ascii?Q?9Pd0m3akLIQYB3KtcJ3upNbMJgBdmmhV5JWwbyt1C/Jw+4uWuRBjJle6+0Wj?=
 =?us-ascii?Q?/cJo2fY+qUVBbtMdIjMwW/AQ5vjoArIUrETxxT/d/lKlOxpiH0akKS9VnfQ3?=
 =?us-ascii?Q?JkcXe+BtKPlVD51+aTkviZ+EwKiGPm7y+Faeq5KKzUwcBbkfmKRj23K/l1HG?=
 =?us-ascii?Q?uW5W0utDjjuBfKCGqz/5QQMZ8ys58WBchbTqgaikL1Y+lUi7qV1uoRkl1nbx?=
 =?us-ascii?Q?KkqDQpPfJzVIWOcrVRN9N+3lUphjk/b/6w6ESgXOvZDfBihBHYhMfbsbflgd?=
 =?us-ascii?Q?t5urJsH/a5DcmPJNL/7ZusDxqw8FYn1OOTgZP73u?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0e455c-3bf8-46f8-c4a9-08dddf27950e
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 13:52:05.5617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQWT4WMl150kYLlG6nBUUiKnsj0QUOeOndxAJ0dKUrp1BWb85hou0r7CkyGuHO25xr5gKCdhzwxD9/8p8mhyBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5262

Replace devm_kzalloc() with devm_kcalloc() in pmc_core_get_tgl_lpm_reqs().
As noted in the kernel documentation [1], open-coded multiplication in
allocator arguments is discouraged because it can lead to integer
overflow.

Using devm_kcalloc() provides built-in overflow protection, making the
memory allocation safer when calculating the allocation size compared
to explicit multiplication.

[1]: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/platform/x86/intel/pmc/tgl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/tgl.c b/drivers/platform/x86/intel/pmc/tgl.c
index 02e731ed3391..fc5b4cacc1c6 100644
--- a/drivers/platform/x86/intel/pmc/tgl.c
+++ b/drivers/platform/x86/intel/pmc/tgl.c
@@ -273,8 +273,8 @@ void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev)
 
 	addr = (u32 *)out_obj->buffer.pointer;
 
-	lpm_req_regs = devm_kzalloc(&pdev->dev, lpm_size * sizeof(u32),
-				     GFP_KERNEL);
+	lpm_req_regs = devm_kcalloc(&pdev->dev, lpm_size, sizeof(u32),
+				    GFP_KERNEL);
 	if (!lpm_req_regs)
 		goto free_acpi_obj;
 
-- 
2.34.1



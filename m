Return-Path: <linux-kernel+bounces-775675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4547DB2C37C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 830B5623D32
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF963043AF;
	Tue, 19 Aug 2025 12:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="mVF8K9u1"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013051.outbound.protection.outlook.com [40.107.44.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD43305076
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755605885; cv=fail; b=khjbj9+qraRoLQl1vVJuYEcy96ordcJRThCRIw6KRBmYRm996neQiXcB31Hc/XxCR5v+3DD9azoJuBae0WdHMOi8vDEWPGDTRo4UFcMP49B596iLJqwl74t2IQv24gYTgmI92p2kPzVfLKiBMXAKjAfuVf+UszwUYPGejoOaf2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755605885; c=relaxed/simple;
	bh=fWEWI9hCDjI56YWZj0h1riJ/FNZPDe8bkIC2BGlRZhc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qMoATgOWRNThymWCTu+PjwzUommylwBU+vbaqHjMGXldlMXHVePJQBf3dJWzybNqgvSbLCbCEx+s61nH32fCFCTYosx/dY1TbyEeUhBI6KSiQMpKvzbV0+D+aVDoOxS/M63OdybVQTC1EpGWFZPEqgVysRuX7chfIHMu8NTMiJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=mVF8K9u1; arc=fail smtp.client-ip=40.107.44.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NnQ1IZs9OQ5LW2SF4lXPCdUTrWNu9BNusy8D1N/6K5mQmOKk9Ju772Ikcdmn3h5l+Z7+vu/Co9TLZPLzTpVzOFztKdgAeB2e8eP/vaIEWIp/d7LVLrzldXPNjAtEIPrbFLDNxB5JNvBjEiKGbYVdZ7sGpi53oQa7Gmp5+zFsuFFnh+DKgdA5xCCgkEY2hGdZA1hOUA0K3dE2KyGffOxf2nIZ8YACemFndZQpo2UlSXnK7vDPl5mzmu1eQN12VRP6TP8B7JK0Ik5zMZD6KtGPsUCg7i2Orzzao+H7MnhX06Ra7GU21CGbIM94wTDWg4+0PmnkbnIM4YKNyNjyJkwj5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6K6gm58kAMg5t3JOB4UBqefK5WyYv1ZaVwdQPklAeBg=;
 b=F2VZJhbIitwJJL6jflnMnV2JTQ4Flc9GQhhMgy1n5YM0pH0t+qFnKuCBQBwFc23XVcldy9M1flJ0u3fbOMqLXaXb8DdLtakww+i5bXFCrNdmAxz/rPDgCRwGLrOiLXkDP+wPm3G8Q/ARZtfnjkU7kgVZ7TH/2Ykf0czGa7hj0KUBeOiL4pIS+uz9GguLKEhKY0EP2iAgCATCvyrp33z9iTVdkIQerkjKI8E3LsQUD0EDw2DdJZZgycAxaMn3JV6+/LeWcj3FYY77mso+ABv9tzLJpSiqbR76trc22EgazeAJ1tAYb3xvF8QqEQJH5hpoX9s4kGOvDIeaaGCjlf5ZfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6K6gm58kAMg5t3JOB4UBqefK5WyYv1ZaVwdQPklAeBg=;
 b=mVF8K9u1zlVdkLy+y2MwFcwRi9wFDRxT5PGxSqkjGcLKiKZ6mTtqsf9C1x7HjeG6qInHbgbehS57dS9euRT/Nyvrq05HbP1Yue7kQ8JwGdiRJcRXWhKecBdphIonP3NsECD+kzRkMhDkiFTq4myPJEeqXbzA4K1KwDrtuByQNYVs+OUXz64VdqhXJ03r404doVGmORUW6HxhPw/Jtqd9TSInNQqglqaQNjcS/BRhdUIBMlOZMrkyT6lsKv2X5CAuDDKcuSSZbQ69GBB//9dXUE4sbEq3RE/omcP0NYPIivfGZQ7P1ZM7Or1bjxhBv4u1fnZXyXLT1gf7OWDRtpZ2bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by SG2PR06MB5381.apcprd06.prod.outlook.com (2603:1096:4:1d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 12:18:01 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9052.012; Tue, 19 Aug 2025
 12:18:01 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: t.scherer@eckelmann.de
Cc: kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] siox: bus-gpio: Remove the use of dev_err_probe()
Date: Tue, 19 Aug 2025 20:17:49 +0800
Message-Id: <20250819121749.613584-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::31)
 To KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|SG2PR06MB5381:EE_
X-MS-Office365-Filtering-Correlation-Id: 205f7d48-8088-4b14-b8c2-08dddf1a70bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cS23K571UlVTmjD8UYptY2HpEry7ezbf3g0zR8Pw41SF4u6F0CNO20ib0r+5?=
 =?us-ascii?Q?4XtBTnFFSPmjI4WhvL9TS2rZsLSDcfKzBD2JSIA2dNQEw82a5XM5W4rsBvhW?=
 =?us-ascii?Q?DNCNaUIWVSw0IPYbsq5/CLnNEOMGN6mF1sv2gMpAhbmN+rfus/aIZJlCRA5J?=
 =?us-ascii?Q?vQagJzAu9gvehQsUgflwdmt8B3zrEboHPfxcLqBbRJfQaGRbHgVxhYae4BVB?=
 =?us-ascii?Q?eIG0V4GNHcqq4jMS5HK9zbhdU2PPr6veUKUN4rpAXHJeIOZxlk7ldleb8AN2?=
 =?us-ascii?Q?O3AirWwGesL2PiPA7fXicRZD9OuvqO5hLczbZnb33rSmEzfSeB1EWT/0Gihb?=
 =?us-ascii?Q?Erhk0eCuxJYCW0TJkBO/xRJLipUwrr0x7P32GiIv8gjw/vX+qSi6oJQjVGkR?=
 =?us-ascii?Q?wOEHntrp7oEf+IaWDmuN/BNTGP3hnzpOJzNIxeFJeUmKIdjjyyKWJkV4aL7+?=
 =?us-ascii?Q?Gru6t5aqAc0IW1dDiFMymra/8TN0JRdZ4BRPsNsgiaJ4gHFVSYfhWaZoOTFQ?=
 =?us-ascii?Q?jk6KoD6iWh4irFoHkrZezkAHpGn0ukxpjGpxVDe7BUHF9x28UnmuvIfj2GaA?=
 =?us-ascii?Q?MzCKXmczADJU8Whmss2uj0CNfEACpXtRI1QOH4x1CbTuetoUVScRj/w5I8Sv?=
 =?us-ascii?Q?YndS2poeuk7pCxJlNfUW6npL22IMffRzfdDj6Os1LQMGZqzAOARIsiv8oStk?=
 =?us-ascii?Q?TzfFA3aqSXCF0I0bBL/UkFufMsJX4ihP/dr605ieLYobVixyXyuBdEtkQhmT?=
 =?us-ascii?Q?9SvgUM1TTLNb66tXPbWxYaKAAS+smV6iHICMlzOeQK/MeRxxr08mH5n1fAxu?=
 =?us-ascii?Q?Tfrl+2RlkSSq+gk0VRT0ZQyov/af7MROQ11+fUXSPHK1YQdRuxO8mkj08G0q?=
 =?us-ascii?Q?vOYhLe8djFp3HqNEw7LSoScCtIJzYedsc25arQxt03GGxQr7DirF2Lym/Yo8?=
 =?us-ascii?Q?tJp9VHzG8NBM2fPTugxevdVSHJmvRJT8bigd4tFgCFxF+ZWvQp9LjujGukAo?=
 =?us-ascii?Q?PyZm7HiWYPAXnbCT/L/WUwF376Ebv0dpCwmxXWRckc4ciFEPwYkfh7lQqwAJ?=
 =?us-ascii?Q?6w8iUm6r8RwvEU3pC2P1RMXEddx0w7vSsdUZGn288RoJQnAtmdekoFwvK1mi?=
 =?us-ascii?Q?T9PC3KpMWhJNKmmDWUqRdLL/KbT97rHXEgIA0VkScedU7OhhA9MdVsywYN8T?=
 =?us-ascii?Q?HVhNwnz1x5meKcgy20nVBjyFu3UlpEmDY5PL3ULYU6eFV5Nk6jMlMbW8uIul?=
 =?us-ascii?Q?V7+sZ5ahlfo8oTK0JoiTKVyhsAuXgHiFwfSit2u0/73F57SSTtf7ZHWxepJG?=
 =?us-ascii?Q?xT9G42v/VFpOYw5vvAO21eMl4JL9ArBY8RQNWERa78lBX4O7OpBZ4qp8qC/j?=
 =?us-ascii?Q?UGUmSsXRg8cJTTHfchUl+CUU69qQW0MKL4XfaWUrQcuKf7uHSiS00Ebl8Qu0?=
 =?us-ascii?Q?3KzxFWTynKuQwSomCFnISuJr0k0j3ZI1Z0JFn0LDu9xrjI+f1/lsv7zz0n5O?=
 =?us-ascii?Q?2AGw0FOS6UXlzno=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8CMKScoT9KYcQlE2zjXdGmV891bX+6ewr3Zk332aOCeuqmrwzC7peCuM7D7x?=
 =?us-ascii?Q?Zh2+8xY8JGWkzyDK04H59hSUyjEr09VHEQzXdWhrb2SS4hp1G+jrnp8BTEpK?=
 =?us-ascii?Q?oKIvhpP2YhK83a+NB5J8q4JzkpNxx2uWKdE4qApjZCaK+VTtKA21hT6WGmbV?=
 =?us-ascii?Q?lhrkdX8oRkysUiGF+wLrwKFY1Vbm2uHBYt8Fpv/wNDii/A4FCHTvHZr/qRGw?=
 =?us-ascii?Q?+JoilKOtCuDDmuJ9vvxsr/WccO7/4FvrZ8DMoFmLz+rfGCTeJ5epT1cBtzi+?=
 =?us-ascii?Q?CrBpS2hylXqChhTYWfMigqrcGdO8ukNLsaAk3mxV4fVg8cCONBbIhCi25W1O?=
 =?us-ascii?Q?qWPmu7oHvBbQ6cd8b2pkL4iB5rLnbnPHHJtbrmKzwJlo+qlhXJITu5ytrXHn?=
 =?us-ascii?Q?u3ePh135oYaxe0ncXp3xQ1U2/nwXdIXdR0C5DOGLoRqNyWWqrh14VO79jsT3?=
 =?us-ascii?Q?2+/I500PrvkTTvsXsLlRDbmQxh5n5kgvqTbyr9VyFQYTE5HSxe/gZckWlFM+?=
 =?us-ascii?Q?97f2zZ2ofllGfPiP4bcs6vjPTR4pD6+RNCehwgEivBKd2xhR7S4MSAUSWcQc?=
 =?us-ascii?Q?WAldG4vHjOlgllYF9pUsYU6iBkWjtH2C+bYhydoYJ17B0e9KlxvVnCLZ0YQH?=
 =?us-ascii?Q?d6q7fKVQhKlhOUudXXmBrtgqPNcD8/ryPcKMiuNOkTo3P2MxPkEWO2DM1nZE?=
 =?us-ascii?Q?NFHSYS3RqzH5qpL8DcVAbkPEaqZpckBaqQy0JtJayKh+5EKKVyBPvMIgnj0O?=
 =?us-ascii?Q?H4B1Gd9Bj4ophxGNl3sD3uQY3z2VMsKgEE++Sci5fuNSbkHovs0ItMf0OtF3?=
 =?us-ascii?Q?7ZZIaa8Z0MvSGdKg+3PtRY3u2YBfNAfGdB1RkIkhhVu9on7n/mnGLaCPqtSB?=
 =?us-ascii?Q?DvUx5k4HmMfJQZz6ZycUowgYfIaXBMofi1T3vAdQqpEALtS9sVF2cpDaaiFd?=
 =?us-ascii?Q?QuhGrzU7JgAWlFiIRtx7mYf5lZlHTycMTiKkxSr5T8ufsqrsZQBdJZASoo0Y?=
 =?us-ascii?Q?NNqndR+cFljbe0EelEgmSH5uUM7KnTCduRNLtEGUy4VphnTxfB80N/avAhO6?=
 =?us-ascii?Q?JM/VMnLNnu0MnCGEZGlA5IHw3tanThaOg55k8upE4r8tHsRugT7XEn8u4IoY?=
 =?us-ascii?Q?ZEAcG1H49bWfWeWtb8F6KmwHAfvtQ83GX7L/vkqKX86QPhjgXw9lNDXuYT0S?=
 =?us-ascii?Q?9KG0SqewPlsm6LUMxqFQ9SLajxhGyQNDVmXdg1cFnQasUzK8uDqzlpCVHfA2?=
 =?us-ascii?Q?LPmsk9INs0/o8D43GXT0sSi44lPmzGDtvw9l237WLRVvnMW1qTStpmQVpHMR?=
 =?us-ascii?Q?Hm2mH7dwsLLKdAJ66O855wiTCz2pnL+LMp0DBqsXshe6+ewN13lPQ9kabfWj?=
 =?us-ascii?Q?HXd4UzQB/uB4EpwIZxRMcDPjqQiq68kRrrTzqHpZv7faI75KoDlWmAcDEEe/?=
 =?us-ascii?Q?qxi0Eax3VUjc03CK1sUFnEYTGc0Iisv7bKaAZ4n+lcW6E+CpfzHHqpYY5Agm?=
 =?us-ascii?Q?QRZDKWU+RR3EY229MtKm7lmButY/K81//wqU54qnuIpZ0E6zhKVzK1QgJZcG?=
 =?us-ascii?Q?A7GKAw1Dug2DKpJEifD9U9BgUbZ5lea9csMCBq1g?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 205f7d48-8088-4b14-b8c2-08dddf1a70bb
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 12:18:01.1770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dePgT4kCKTw6iV22K0fujwZGKymQM7seKtTCyJTRvmlfIUB6aT2EmEJxZnOaY808S8lCAfcBFQYZv8dFg8Ix1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5381

The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
Therefore, remove the useless call to dev_err_probe(), and just
return the value instead.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/siox/siox-bus-gpio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/siox/siox-bus-gpio.c b/drivers/siox/siox-bus-gpio.c
index d6f936464063..413d5f92311c 100644
--- a/drivers/siox/siox-bus-gpio.c
+++ b/drivers/siox/siox-bus-gpio.c
@@ -93,8 +93,7 @@ static int siox_gpio_probe(struct platform_device *pdev)
 
 	smaster = devm_siox_master_alloc(dev, sizeof(*ddata));
 	if (!smaster)
-		return dev_err_probe(dev, -ENOMEM,
-				     "failed to allocate siox master\n");
+		return -ENOMEM;
 
 	platform_set_drvdata(pdev, smaster);
 	ddata = siox_master_get_devdata(smaster);
-- 
2.34.1



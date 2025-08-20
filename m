Return-Path: <linux-kernel+bounces-777763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B67D5B2DD8B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 120F9686161
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE2531CA68;
	Wed, 20 Aug 2025 13:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="nIwenNkn"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013039.outbound.protection.outlook.com [52.101.127.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2282627BF99;
	Wed, 20 Aug 2025 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755695762; cv=fail; b=VhjEXlN/Ut36/WxxiZv49Vyd6MGHDLbYe0CbvUQSYsGcOEukDnJvZgbqWfD3JgS+rrv3kVaSkosihJfBDJH4PDcK1EwlyUHtUz9jpc9s6uvEinGQ0w3UFnFprUibDsJAfK/xvC18LXW4j1x79sb6qDt6mLKCMirjck9+9lDuVs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755695762; c=relaxed/simple;
	bh=mNeWmN0iZrO3a+01aad6GCxQK4pgXeTPHDeZiZhLuHo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=asj9Sb8J5cACCoTegNFkyFcoPy0kHN8sTbXcVjfzEYeb8nQkwVLW5Jbs0pCjS7kLHfgJJWi6+tqnxLTObmfnbmIzgUAw2qkaq9XbXiNLqI88EbWxgJMP9bPyeD1HKP/mFZ6bXTvSPjcChrGFupdZRLjXQACAhReKQ0QROvEtTzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=nIwenNkn; arc=fail smtp.client-ip=52.101.127.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLP07Ub0od/sWL0v6TOmAJoN5cnRhtTV8+WMxh2mPqa527PFansYTNLHZUe689lfZOF0jvnRFD2ScOavsdKGmhxfPTSemxuGC0uoXu4IQA8TMDVy1grzzfIkEo6h54wAaPYDyu2qki+LopDINH2By2DXZxp1/PwVji8Iqff9Ja3s1RvwTRO4CNOvab9skHdfue2NrOTMF8vSlnrRJMsqDv3G9lc01pcnM0SljQsiGd0BusWnGc9PrRBpBOi2HCvrrBL7yOlhcE/2+Sf1aMaey99+AcGCQtwvG4CccGFtkZ+TI3mVpnud3OC8T0f9EmntIft71TPWI7jC8HDkSyspuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yV9TGfKUrwpzgzQ0WZXxzRjzHqAuvVv+woQfygNjto=;
 b=ibxKFprC2+L9jbtFGCHNArWujjPiNAcvBQMTvs0tOK/1ZHNFd6M8j9tqydS5zAPaZwTPEzdgFji3sj9C7A8i98MMmKzhz/CHMzqtfzfR30mPAR+5xel55J18MGNNAPxlL19bZ8fWVmu4EjDsKKPiqxAoUd0hgctbzpkIL1y68utGUPl2Ng6dszrFwHg+ulowIeKNE4lLBdEOIXFO0Ob5eJHjPazNg0q1OCSPYSM+BQFS+TT1ub6igjHF8hcj474JzMS4WzkCP64H0j/nZtuoredXfXahqgwFEYeJgrM2S0OQD3n0kIvsxDLXhDbZVjourSG6t6rUsP/qF/u4pWoT7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yV9TGfKUrwpzgzQ0WZXxzRjzHqAuvVv+woQfygNjto=;
 b=nIwenNkn7I/UrJq7iGvYRcurqRvIwRkQ643ZWGgiA2LtikcCtS0Y9gQyOFykZD76M0gtzTQP6lihCzzXydQrTprWaqxv9JQN4dujBDMACzqyKMiEdzGDJ1sCxzCJ0pzaQLfx7Yqzl4Cac/n/W9d6wUt+i9lX/FuZ+frEMyGaW/JaA9S/PhOXRD1RjaMFLbqNEnBwE5GF1OAIbH4DiBzGpd/aXA5pxSyHdn/jHCNl69UtlRsRLYb4hpJr8GGi3dXmt68psilYbMCrkxJLbQDSQkUiTbrlna94jgrCsEqi0z4oMNvSvpXDjhCvmh9uJfdv3G4dVYcE974DA/jLqr8ySQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TY0PR06MB5306.apcprd06.prod.outlook.com (2603:1096:400:211::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 13:15:57 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 13:15:57 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Nuno Sa <nuno.sa@analog.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org (open list:LTC4282 HARDWARE MONITOR DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] hwmon: (ltc4282) remove the use of dev_err_probe()
Date: Wed, 20 Aug 2025 21:15:08 +0800
Message-Id: <20250820131509.502007-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::9)
 To SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|TY0PR06MB5306:EE_
X-MS-Office365-Filtering-Correlation-Id: 032f6f92-359a-467a-32ab-08dddfebb2d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bOrU/ytkE6C+5agfcn/VqaKETKcExOrCsGVWMuFlxlJFHLAPtjpIJ2J2QceE?=
 =?us-ascii?Q?XcXN2dBpYs0uX9TvJ5KJzB/BubfQGC3MgbozgACj9YxPultdAQu7U3iWFH72?=
 =?us-ascii?Q?BApOUyX1TSjj+1MQe+yTXy+dMK7judvGYsbRdlPUaN3BfyteFL+wT6Wf29wI?=
 =?us-ascii?Q?OrwUvzsFwStH2OeYvqYD1DsbjA1Y4lVwhaBOlZC9gdOk6zkkrFVQbUbPtRn4?=
 =?us-ascii?Q?hP+THo9pn1SDupCvr7umlkMqfeb4MjTuUhWAooza1+TWQboFV0LoZYqOGEgC?=
 =?us-ascii?Q?g8c1ENz4Z/JazKrVbL2KgewF775og34O7id380UmgSgdyiuGCWjRZ1MJ0qOb?=
 =?us-ascii?Q?5q9m2hvSrd2zelCg3O8Sg2jtnX1DtzUc13fI7f8bG9hjnIaZ3Dg5VusoqxiU?=
 =?us-ascii?Q?FoQCZOienej7wy2SUVJd2JKgG4VcYnyWJUbfxHHHHvITFzm2zUkov5JyQ+6q?=
 =?us-ascii?Q?5mmj6GXNHDTlQuT8Dqe0tLT/Z+RfeScs8TTZw4nWH4TiDXsDGtlhe+tGBy/l?=
 =?us-ascii?Q?+BX44JpKi4LGMp9WLq/KWSUHpC+s2h0ErF463nGFmUqNym997UFkw9+o3Gi/?=
 =?us-ascii?Q?+cneeT1obxqPP5J/FY5sjTuavfPD9wW/0d3ZussotCEG+VjeUz+2pnCBHkgm?=
 =?us-ascii?Q?fBEoe1+Jq1ROwoSZwSWZOhv9BX2aoliWfKlMAboML/3N7M1f6u4Vt0U7T7RU?=
 =?us-ascii?Q?og2mvIRu+VB/8+Lr8dDyr2ZZUbTZP9+bm3kaqGGoc6wEEuSJlIE0+tzWAGIB?=
 =?us-ascii?Q?d3+n7eeEjj0J1HIoEAFQTkrlsBgRaGOQhsx3m5cpxITY36s9cACZwam6LnBf?=
 =?us-ascii?Q?AEf3nLLlOZvaLvJhqqj1NYKkFe/FtnRG7d8UVrgXCn3rqRafXodU3sgClNSY?=
 =?us-ascii?Q?Jur0z+NWdbGUmz75AGVGE6Wc2+yUpfkrRkAZMMgrH2CLmmJsT6tILvn0uDY2?=
 =?us-ascii?Q?zuN1mv0FDB4jHeLhmW0rkS14PSHilYu/+N+yX8+bZggljXEdFUj80W61Fmj2?=
 =?us-ascii?Q?3qw6Z6K2WvorIuZzsCD6SZ2E9DVCO8SFjWY9a8TEUJ2kadc6Db4OiLMUOHbU?=
 =?us-ascii?Q?+Ojbkk8h970CwVzzlk6ukxGIvuR+2gUWkqlzfJ222yDuPINw+KlJvIire3pn?=
 =?us-ascii?Q?8Op25Ue2BVW50Asmp9Hh6tXTrGba8h2qCsw9xdn0YyGzyBk4mrWdNhnkaCO7?=
 =?us-ascii?Q?HYJdeA98L7r4UE0JLLH5r2dr3hzUvPrpkFAMr/A814/72/Wp/+z9Q5IkhMgt?=
 =?us-ascii?Q?KtjLR5VD4Zo8Xn6ftT/pyJgQQbcbY0fS0hLOwhZc+/F/0LLXwPtkIb2ssyut?=
 =?us-ascii?Q?2kCSHZnm0WkIAYAVXygoM6K7yd5whVcqnDk2JlkkyLiFqHpUOUauzjzSE0ye?=
 =?us-ascii?Q?R/Fis8RGauGC5PQlLDFl4oX6ZPLomY9Ls1LmAgzpqKCi3mPyRWlDVU6raUQ3?=
 =?us-ascii?Q?Nm3OrPx+aCi2RkZroNs85FjPGZ5lAo+mdd1nWKA5G+MCWGwqLcGsRr/tYYPt?=
 =?us-ascii?Q?tfFyGsQhV8A6RwA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PD12QXqgbx9SZ6w554hqGmSFuP0n62ky6sFzbrbL3C+XKqxNyhxR+TrhZjTw?=
 =?us-ascii?Q?m9hxNvIrqQIS07OAwRjCjC89Ldj+WqPGkiETBT+Sc8Uwmom//vBCZx79EFx4?=
 =?us-ascii?Q?gfd4qqrhsKZwKJTepWW/JL+P/3KR90YW47strlF1i1pwzJYe4AXT2Fr12vHp?=
 =?us-ascii?Q?9d92a3+K4OF5ltxgowoLCm+uuKMYYxO5vkQj8bPkzsXKh53DO4SJxk9FxjCo?=
 =?us-ascii?Q?DViH7O/jiteOqakUUqgaUkLAYdeLkvphLEnSPRMerrAsbcq3ioGvna58LYJL?=
 =?us-ascii?Q?HKnjYIKzvdilj2UhC0mYwT6EZHPzjvvhKhYzo1o3Y0H46itqkYGE7MY6dUib?=
 =?us-ascii?Q?Ud9j2lL8Z/bWbdDAUI1rlAe09oqk5RmMpL+O2oH6giVpmZM2+N5l0FzabvDC?=
 =?us-ascii?Q?Fk7F4Gl8l09K2gh1mNvCgWZjNukdUKNE6IHAAVEz/+1ZUMmTnih8VpR6QlIl?=
 =?us-ascii?Q?EV58nIc87Ojld3cac94Z1zt3Xl1ol3JPxBnvVEEIpGAhrlwHbm34iwIBm28z?=
 =?us-ascii?Q?HJt7thsS0VIHAYO/DY0uI48UsUS4AZMisI0NsdOCBVKZhhffVG+zHDBV4hey?=
 =?us-ascii?Q?VUq/zg4ghEir08Iq2962Mf63b7Uqi3CAfGK/K8yOD8gqn4nJwvy1jDVMmy19?=
 =?us-ascii?Q?08c+tr43EEQgggwkfh/5bUw3ZXqLzGNI+V+nbwLfJABvB1qK0f5uK2KM0ehX?=
 =?us-ascii?Q?ADkZN20cJLbghphFlmrDbzOXGcov2Mr2wdp+cDBOJALKFcfdmfIhz6N/h9Nm?=
 =?us-ascii?Q?oR5S3hMDQJTgnjK/Cec9+tgUMk2PGWoBiK51Jc+h604KxXi673lG/75rHsYA?=
 =?us-ascii?Q?SWvmTQD7ncCsTuSEDBdLWoDg5YC4Y2r0+1HEyIPR6Mq0TBn1M14KM5aDvKVx?=
 =?us-ascii?Q?sdVKa8hAyc8VIlWVYzy2VfvUmB2DGzAJ9qqpKpYXntSPI5NgqsixHIgHgvYX?=
 =?us-ascii?Q?3TbcVnPuUH37mPh5Ivw3BC8/qqQMS+J1h5C4MvY9swBeUebK5b+/aonFFz/H?=
 =?us-ascii?Q?xAxIPg00tjXbShnXmCC80pdpABnY0dJ+Kiy6x7Std5DbRC/Rvj251RyTZqdx?=
 =?us-ascii?Q?nOjS6uNLrBsrHz5y7Nb/nZi9c5jKduY+rIf5MGH49WTw6wpinAZ37VkCVeni?=
 =?us-ascii?Q?QWZ/oxLxB/dnpNkBJ8Ui9pleepDwtDaw6exUKKxJ1C+B0b+tl05kRe+BSyzo?=
 =?us-ascii?Q?UT24rYBGuW5cU3HxEB3FhRhL+r6KvhKNSXILiqQvMnZ7G4S8iuNBCC5z8z5o?=
 =?us-ascii?Q?UDmc8ZNJ7HBqrQJc9JH/hecCqZYKxhwAp1zQeIxGbY4XxD7PWnjLAJeCpLuR?=
 =?us-ascii?Q?zim6VvqRgJM9bHjjsRQoLFjjfeZfTMolBTb2ok2jRBquxWlmYKhBfUS6Y5n8?=
 =?us-ascii?Q?vKeEmb7Y5bMa1BozS9+qCgb+D6KaBghujJgo5u/2O2L9kaHNmivbd+fZcGSy?=
 =?us-ascii?Q?C212+NsoEFfa4GUWTaVHUuP2vcRxss1qVbpscJTlG0Df4iILo0KfYFGIXtX0?=
 =?us-ascii?Q?9PUIhUdY/61gPpoL2ziU9iuGe+Oyj4CiU8UikMoyIE1id7zQV9qXwzL4NVAk?=
 =?us-ascii?Q?F8RZVbGLI9m8n5GN5fg7TK3iweS62A2AeHJEajWD?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 032f6f92-359a-467a-32ab-08dddfebb2d5
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 13:15:56.9345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CUaBDWm7WLVQreOdnpW5dkkDeFW9xPPavW1ShFD9YHyxqiBlvW0T2yIogQ48R2ZD8LMIfxZq0FCg3ss4YFHlRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5306

Logging messages that show some type of "out of memory" error are generally
unnecessary as there is a generic message and a stack dump done by the
memory subsystem. These messages generally increase kernel size without
much added value[1].

The dev_err_probe() doesn't do anything when error is '-ENOMEM'. Therefore,
remove the useless call to dev_err_probe(), and just return the value
instead.

[1]: https://lore.kernel.org/lkml/1402419340.30479.18.camel@joe-AO725/

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/hwmon/ltc4282.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hwmon/ltc4282.c b/drivers/hwmon/ltc4282.c
index dbb30abcd343..1d664a2d7b3c 100644
--- a/drivers/hwmon/ltc4282.c
+++ b/drivers/hwmon/ltc4282.c
@@ -1693,8 +1693,7 @@ static int ltc4282_probe(struct i2c_client *i2c)
 
 	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
 	if (!st)
-		return dev_err_probe(dev, -ENOMEM,
-				     "Failed to allocate memory\n");
+		return -ENOMEM;
 
 	st->map = devm_regmap_init_i2c(i2c, &ltc4282_regmap_config);
 	if (IS_ERR(st->map))
-- 
2.34.1



Return-Path: <linux-kernel+bounces-834508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5113BA4D5B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC78B1BC7BA0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C726311951;
	Fri, 26 Sep 2025 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bh4JgK1D"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012003.outbound.protection.outlook.com [52.101.66.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AA82FFDDC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 18:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758909945; cv=fail; b=KBI82D7WVUL/EjojzCvV06v6R8mOfUxyv5sHbp9WNcF5WLKt1L8Ey6Gjhtf99c4tNcyGsbw2NUP1LmLI1QV9eFFsNY8XhaD74NFG2h9j8MD8IdiAvIrhee/pEFSXtvkM9jAl93LfCl5jUN2Hye5aIF4bhwe5S3sexfphMVht3vU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758909945; c=relaxed/simple;
	bh=PzRvjkrSH7OM7jYNdtPfFOGog3GU1/Dssa2WkxDDliw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l+L0wHY7KH7xL7017EBVgJqBbvFLct5GcG8mNvxfcQmvDv81LyD7MxyLQl7N4LG8tt4tfGdERQrLGfd04N9Maa/afmMM9q4U3+UC1OcaEySiwepUHM+n/4rhJ3iKDoEf2bZ/E55XHwvEAqxoNMCXN2YJ6zAgXQyS+k2HhKU660c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bh4JgK1D; arc=fail smtp.client-ip=52.101.66.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gI2cSxK+bWjvVXqZ8hOgOLvSgyhYX6tGLSUSHZGplvDu0A7CddybK51fFOEnt6nbzlUjcsmxN/zfr1dFgHwhSEQo7wzZWyySnTZc0ijh1XqBeg168qGynl/tWhw8YKkIqjvNIycC1OoDUKlAATmh0vT/YG+dzsNFO2XGhezpI06zppP5DnwlSjhCrjleLHQMl6ITqCRjvXS0GPsdKbapNrUSyF08AwUmwOxIra4xQ+bVojpcznrTHDltynyFMFdkKXYWNE8za1Z6BnVY5ip7O9/0uzamLmTWyDEdJPCtA3b208DFrIoJENzeaVLQMPeL1owzytqomBeXx0RMgeardA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9jV5nPxAdkhywNzKHtvsnXURGAuqnFqLgLsiviPdMg=;
 b=pt42k2Oh9yqUo9hSo/JogIRhz2kWMpWkoLDWUJKc2X6x5P212CzYgG8qYEeWoOgu+0rM3FcE25r+DwDhX/c8lxy3L/NUmyThrS37tkGGGwBpaCOM7jUa+ON5Q+I8HyOqHHT04rEeL31QAGr1jWJLHi6UPivl9VfKy9wXPSiI4OLc6TfXtM/KjNMtFiBLVdvCj8TfhuRa3Rl6RgGyYJWHs+Ic625CiMLq7wYRGiG0YwG8jqTd+r1v9BV1IS6KhUDkZBNV4cqJ+fUH/QecVOtRSSsZsYmFkhE40vggP0M0iWbYZuS+SbXzSUOJyGToq/Faki8MZW1hwZDKurJ12KigZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9jV5nPxAdkhywNzKHtvsnXURGAuqnFqLgLsiviPdMg=;
 b=bh4JgK1DP+XN4IfEJ5DeUshZnbOhJ/RDD9x3LZ6rlIfXbolAhvfTY0U1jONWFn435yMRLwl16MnhPCrNQVL/ll9ALqIKgvqJROEfRYKYknRkHYroYYnaDEBw47qCXIk9+fbLglmQbc0XWwtQGztSYuUx3YlvMV1M0gXphFllVf5rGWaKAbgrMSGcK6hZguR2YaWiREXI67/NBH+uAQmNa6Dj4sr/4XqGCZC663w8MULwmPY2EHPkqRzF/UPoV6MslytpN9GNecjI6YpY7V8jT4kVcIt8PAIr2GC3M0suH6hMoMkWCzeOX32tYiQdOlSh/vbla7X1bdq1P91M0E0QPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB7878.eurprd04.prod.outlook.com (2603:10a6:20b:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Fri, 26 Sep
 2025 18:05:30 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 18:05:30 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 phy 10/17] phy: lynx-28g: use "dev" argument more in lynx_28g_probe()
Date: Fri, 26 Sep 2025 21:04:58 +0300
Message-Id: <20250926180505.760089-11-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926180505.760089-1-vladimir.oltean@nxp.com>
References: <20250926180505.760089-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0008.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::9) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: e6a3009a-4f31-4f39-1e5a-08ddfd27474b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vl+z3fqVFvYzBBb/SBfJd+QfvbIXNvZhvyyy8fUdzBoH1oIBOOUPQOqh/BnT?=
 =?us-ascii?Q?xMX7aGQAeYkr77yuml+GduEaRqcSoArtRwkkcgb392MY8S+d8uSYTTelasuN?=
 =?us-ascii?Q?cDqdPOas0yp0aQZTzGuDZJzvn5vEYkAxC8jEUI/dDEeF1ndl2RRmjrjhQBQ2?=
 =?us-ascii?Q?DEd8wgJXByvZYggbRG3SXIXfJ4k5hAEqjqdYu8lY8arKtcLQ2AW6snQovoS8?=
 =?us-ascii?Q?gbNskfNyvP3FN5geSjIoJgeXX2i7G74KHaRfXrKNg+vjxXTmWikzeukEusbP?=
 =?us-ascii?Q?0alfoHlUmBbEAsGpmbKmq7qT5YqIzFqa6+joBgB/3QRgH64Ez1suOubH82gO?=
 =?us-ascii?Q?B3AD94GRusZWb2qipDkD3JTpAkj0TfjFzeCQ3QAy7liEiQyjfclcdG2Famx/?=
 =?us-ascii?Q?l/jdZGk7H7MeKKl51hjKJP3AgeLKiVnKWTzNUlZgFQUetw2wC9UweTqvdDtM?=
 =?us-ascii?Q?lafGe+WSFMtymhMZGMxeukBIJaN2qkKPcoWrpynO+KOaotqnySfBeDEaJcaw?=
 =?us-ascii?Q?uUSptG2SSZFxtJauYRvxkxzvzV45ik6mdIcOAXM/URMXFHEpXJREKGn/40Zl?=
 =?us-ascii?Q?dfACMZDbCCZU5PDKrA/V/E4L7g0pavKcIxU9OCJu7VW8swBXlpAzN36yg8H9?=
 =?us-ascii?Q?OTB2pfD6nXGO7Cd9+p6Xq9S3NLFmnqh4db+nrrnrrj4AVSJQxvIfv9uoVfph?=
 =?us-ascii?Q?Poz/W/jNtPktpf/x3d7I2p1CQCW6WCc6JVnIzO3Z/v4VjC3lJ/e1/7ve2Y4B?=
 =?us-ascii?Q?psJhk3CJE1sDna405amz6BAjeuKwCXJaHCdxptj5LVSU0yHsYRHn7PI6yJhL?=
 =?us-ascii?Q?uKa4zJdS+XzeH6FPqvxPjVJKPWkKAw5EeDd2RJqXQGAkVT2OMyvZFUdTDOCO?=
 =?us-ascii?Q?kLCzzrmi+D7DuuWMNERZRTFbuQAcYWKjP6qBB2erOdT5o9bkOPXgafRo3SC9?=
 =?us-ascii?Q?m+XuGjX08DXu8cCXqIKc7QQg2F2vC6Ap1kZHkhc1V7f/b7TjgEO+u/w74yEH?=
 =?us-ascii?Q?vU+L5yd7c56yR3Nk6u4rUL7PjT4colVpx57VZrZm0Wnjlx0emiKYL79pnYdC?=
 =?us-ascii?Q?rJwvbJoBMBa3IszzVeh5Qu/Jo3RkN+VrlewP3S83s7wpfl/SZ1l+5vHE4rfc?=
 =?us-ascii?Q?ltoxwZgrA+WzeXEvQg53Iez1qz2Sb9Wbg6OmLfYXDI7Q9zVp57+tiI8fUBhw?=
 =?us-ascii?Q?8JdiDUVzCwgtEmnYI4sKdjzlOdnUnV5Al1d4K3qFCkXHLfrUl5eJaJNs9ZLL?=
 =?us-ascii?Q?5Otm8f3qLDJmbX0zrQnFjWEp13ahjWB8ScO3DhmpbqZI5wYeAkglrLXg4wv0?=
 =?us-ascii?Q?ytdj5t9C9zyOAsCUvzdDYhz6/oX8EqeRD6lL9Wh8xDqh95U/dJrYFpVC/ZZ9?=
 =?us-ascii?Q?3tf/lJVWwfmA8V/OF8Eetu9IvjyKDJAbCkUvYqikGAxRBuJL9bkPQjH5Hai+?=
 =?us-ascii?Q?IODfzORQNQKfsDnOejD/yHycIRemXq8kcyGGt7ggsJkE+2YVsZPVY9fQgSiN?=
 =?us-ascii?Q?jSds9+M2x0GWweGhHC1noaPiz4Ppw9J7AdFB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Fs59EhbjlVM8gAIdEFo/U9LInd8CAN1JGQaIpj+WkKCSnG19cCOXXLKI1/H?=
 =?us-ascii?Q?b89iJQ0UZMsck9tpu04QWrTLLNSBIwJj3o/pzUPphBZwfjrLuYA2pJxdIsrW?=
 =?us-ascii?Q?kuwaridtTvUDIdqUtmleyNM48joV2OYpE3ZoZqFQ51kjG73SUNuc5yrN4l5j?=
 =?us-ascii?Q?gabmR02TD9twJMFKBa7elyDAl1+T2i/zHAV5thAN3gzq23OC9WiL/nb8KRoM?=
 =?us-ascii?Q?TARzgtKyuffHyatLDiO55AoHmjR6Sxwp0e7Idmj8mQ9Vd+LMAhiBx+V+e9fp?=
 =?us-ascii?Q?fmFIsaHlTwwB5HI2qQ6jU1vRvQ7CHIGtK54x6C+EaN8+UbCzQwkmiy17XeGE?=
 =?us-ascii?Q?hTEwyW0BA10z1Q5p8pKAVsC6cxjIHujNzvBw3xHbEhyTud92LUfQw5Cmom16?=
 =?us-ascii?Q?LBFp7J1ox9Bq7+Hpjz7MEWcxPL3G9WJQs4xSg5cQCSMyiOlnbQ4V3TQ4MWPR?=
 =?us-ascii?Q?e7x//nrFdWHMkRy+JuBagjFnQ0qxRLcdClIwMrtLIE169v+8QfxEmG68Nhef?=
 =?us-ascii?Q?9/Kg3AMqxV14uVQkA0rG1UsptNiD+uJOqrRBUVH8D5LyvemY/xvkurWLINzW?=
 =?us-ascii?Q?G7vzalqJaKZV4lvIiuUvb9/yfnCzyPyk2vqsE8FkQxPoHNX7DgBewyh+OOSU?=
 =?us-ascii?Q?mcJ5g3p8LJ/BtMMC6W60Oj7IwokEVMojYxKPRy316nXZYUS1j01DcncRjtd+?=
 =?us-ascii?Q?ADt7S0snfrsEDB8TyVBZtYTTb9B+fpoMhdoM9eIrqP9qXsVl2Gy2MO7Mvi3b?=
 =?us-ascii?Q?mWJCXYsGsSuw82H6nAUu01DUciiwLEXUWDLId1IcmKNFaN41/Ug+9anjHTIi?=
 =?us-ascii?Q?FWAgoL2GGAvpHnDKtQR7Rlt5nMnriPYICYsE9vCYuSLuYckuzqdJIV3aFdUO?=
 =?us-ascii?Q?dmUpSEu/VF0XUP0OyHh9VgmoTLsCileLBxBN9CneCf9TnR5HR2EyO6elqJXx?=
 =?us-ascii?Q?1ny5pSsHw6boaSqnusk3HvMgD/ZiiSsifji8aA+1C7sojjOGk7OiT1hI46AL?=
 =?us-ascii?Q?4Xfz/zETqm32oqKvLF8kM/solVe5ca8B/XcjrGiWD8jxiqS+T9PolFzBKzoj?=
 =?us-ascii?Q?YsRgeAKVjNiI2KRZF6OnfX2/kqsAilZ2pvrRSO4SvcspfoNbKYXyAe+2wu8R?=
 =?us-ascii?Q?U7IeQpr4k/fqWx5lXYOhBe2i0OSyxWFzZbqVqpssj0IA1oM8aetb1ukY+Qns?=
 =?us-ascii?Q?OuynVvW499oazK3pRdHOZx+N/v41z69PLcdQr0t6lTDs3sFgTn2EZSrX0+9K?=
 =?us-ascii?Q?A8rdKA8xqoYw1952T8Qvzppdp2kg/jXHNqZpfs0pAk5gyGAeMwJB54Z9MnQk?=
 =?us-ascii?Q?d7u/FN9HT3/VaHW9I2GgTRIttIj3/RkLqhG04o/8Tm0NqOckp2XWh2Y81d4D?=
 =?us-ascii?Q?G8r/JxSOIbn+Y3rnpEYdi5MMPB+nGK+Nk9hBArQqpSKSAp2csGPl7tHgVgxI?=
 =?us-ascii?Q?cnA256aTCdweFMbXnin9+xJWREJ6R4zteRQMlcOkwFVP7B19EbG5WhJ2PRbR?=
 =?us-ascii?Q?/tVy/BVGkALBYM/CZI17vv5SfQYUml0D9o4+L0BYB3hniiGCy6Io5jGj3eh3?=
 =?us-ascii?Q?hIEc0HC8qAEk4pf5k7Ce/QHiyualHq3woZ39FoQE4u4ym6UPvLkaTdYz9Pb1?=
 =?us-ascii?Q?AA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a3009a-4f31-4f39-1e5a-08ddfd27474b
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 18:05:29.9939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0MijRnvspAuVzRD76GuAEGfnv+BG07jXd383hBpsmU9bGddRALPPrxRpJ0J8f/ZT4vsw2hvqL1W+wKE/lS4CHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7878

We have "dev" which holds &pdev->dev, but we still dereference this
pointer 5 more times, instead of using the local variable.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v3: none
v1->v2: patch is new

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index eb2353531ef7..7800f57413ee 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -1133,10 +1133,10 @@ static int lynx_28g_probe(struct platform_device *pdev)
 	struct lynx_28g_priv *priv;
 	int i;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
-	priv->dev = &pdev->dev;
+	priv->dev = dev;
 
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
@@ -1150,7 +1150,7 @@ static int lynx_28g_probe(struct platform_device *pdev)
 
 		memset(lane, 0, sizeof(*lane));
 
-		phy = devm_phy_create(&pdev->dev, NULL, &lynx_28g_ops);
+		phy = devm_phy_create(dev, NULL, &lynx_28g_ops);
 		if (IS_ERR(phy))
 			return PTR_ERR(phy);
 
@@ -1169,8 +1169,8 @@ static int lynx_28g_probe(struct platform_device *pdev)
 	queue_delayed_work(system_power_efficient_wq, &priv->cdr_check,
 			   msecs_to_jiffies(1000));
 
-	dev_set_drvdata(&pdev->dev, priv);
-	provider = devm_of_phy_provider_register(&pdev->dev, lynx_28g_xlate);
+	dev_set_drvdata(dev, priv);
+	provider = devm_of_phy_provider_register(dev, lynx_28g_xlate);
 
 	return PTR_ERR_OR_ZERO(provider);
 }
-- 
2.34.1



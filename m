Return-Path: <linux-kernel+bounces-892690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BF9C459F7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A6444EA316
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03482FFF84;
	Mon, 10 Nov 2025 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oRMQh7+d"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011024.outbound.protection.outlook.com [52.101.65.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0BC30170C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766597; cv=fail; b=opx02ikcTCUoKRDJEWK5d53vB7lyw3UpVoNJ0iDwi+LCM9BtvHd4+iw80kCKCNv2mNz7KPA+DcVInaDXSoNByCuPLAgpYWt+VoOS2WES64vhCnm6+owD89ApvivlYdkgjOuracBRSxEb0J2HfJl/1iLZNyYPcxB9uEncuLpKySw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766597; c=relaxed/simple;
	bh=64vTrBc+LRSOcLySH2FwtGQ0lRW/XJOrr9+iJv2H0zo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DmyZ6LZb3DvZ82kMb2IQ05zYn7geqeEIFeMFlIOViznIE3rr5galzYnQR49mHLX20Cw9QokESBsD8D4lJxM7luPmILPXKUQYhuCSGxZBcyOunZKPgexc2995/Tz0XjYjVaW23YZfv2VI5Mj34fBmzckw//Zpt4xF3yQ4YMMcyMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oRMQh7+d; arc=fail smtp.client-ip=52.101.65.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GyAx1nESAFVCnmPFIb6fU5yVxfyVy79PbscSF1EyfMOI+wSBCDPCVHN55laLoDAV6eiICrWS8/mXYHYltx3Pi+JH5RFZUFScxret4ZOnmi0z5iVQTibKiDcd1la1c0exeJUAwRZ9FtpTW39UCvUB9lWJpPq5IaKKbT372N1lLDJivzIXpjDMmMdRAFrizi6SUGRV6rRHGxQedf5dOKFJKync1wXaHIvIv0pAOCAcIsqLd8tFG5ieaILvFrKmluNMRhQs1KzFxjMZlsOHddgXycYK7o6pYMhvPDXWhml7YP/dhJzZ8Grg8YPLpC68v91ASLmE5/d3goQR/cTjZa4FGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJgrZdkOhx9rlCEjoUbHhgkU7iUPtD9qLK7pw/FfM0E=;
 b=DyrqoTkcT3nDMMHRw85YcOcTMsgMDYUlfYE05tFsbU9PPkfNn8L/lWbnBqUIm6KYoy3o+URCVt5tf7nX0Gj+jlm8pJRtjpYk+41yQNf1PxflrUdVs5QGCezAdqseEl5RBRLAGZ0xXsshQ9MFHHVE1+K7Jv3wEnU+C/oOL7+2t7NU9gOC2o+b9eNClBnv2gPDtz31fFhKVt6EF2e1ixkYfbEmv7d+gdRP60Iaf3ghphDZVh6VTFaF+dc/dw9jgNEPd6NSZp4ru43a6uQtXNHs09Q2mOmfiJ8jiMh7OFX3o4IpTDV/yX+4tMruewZQdz+76XL6qj+RRcYSMV22ohojJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJgrZdkOhx9rlCEjoUbHhgkU7iUPtD9qLK7pw/FfM0E=;
 b=oRMQh7+d/MgJAaizqFEO5y6wqWThceBUY50XnvJXTGkdkGAxsGuqtYGr9k+tr+5khmKxMvuw3xGv1iy3PTx1h8d6w29RaMB0AGSSKUO5GHgckp0qV4yFH2jxu3p1/SCvtmY2Jb6lJ+x/FnOhS1lNqNkCql+NTvHl5VuftOKzRNIv5+lZ0hjT9kC54w870+7GBKvGtuPgcAU0H/+4HHu4j8Ga7l5HO4yfByQXOd/SCw6RIPcHRVboqvRdLn/aHh2SLR6yV9f2RUMQmq7xe9X5PygjxYcBG8IwcWJAt+QKEQW8n7H9DaPOHxKxQm2w3EbdOueHA6r9/TaGeu3PIp7EAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU4PR04MB10574.eurprd04.prod.outlook.com (2603:10a6:10:581::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 09:23:10 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 09:23:10 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 phy 13/16] phy: lynx-28g: use "dev" argument more in lynx_28g_probe()
Date: Mon, 10 Nov 2025 11:22:38 +0200
Message-Id: <20251110092241.1306838-14-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110092241.1306838-1-vladimir.oltean@nxp.com>
References: <20251110092241.1306838-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0026.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::31) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU4PR04MB10574:EE_
X-MS-Office365-Filtering-Correlation-Id: f0c10c49-2cb2-4c2c-89cc-08de203ac3d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4Y/y9AS2Ipp2U5nNJGoFjc+OFsPktKIS7b1IBNdTrbl7S2gkPiYsg8mLv+EZ?=
 =?us-ascii?Q?8B1dZMGvVMIUCfDiTpR/umg2yA3dFuGnSzb5N0I1j5Ibt6hllCVTpaONsND+?=
 =?us-ascii?Q?hWLvm4EZdNe88cY3AFBKjEB3vnBoBJgFFwzAOVmOjh8nBEgiZz7GpDvAc/Pr?=
 =?us-ascii?Q?NQBRsip9BSneY8JDB7K7qTiWQ8CT/vzXRYtvq85VdTol4TawqPwiS2+h68JW?=
 =?us-ascii?Q?VW+9LlX8nhOqEm0DFu4qyaO4gYbDEa/ayzZPI+jw3B4jZf19zrwgjBbcn+wM?=
 =?us-ascii?Q?rQc9CbXLPoMUkWG2xtsduXxLZd0NhAWoASeYJi8MsoJiODv52SbxsEyQRpIk?=
 =?us-ascii?Q?ec2uNJea+xu2GlIKczcN4ES+eN7b7pt+yDqDqhqn5Sxs8ky12GpuKL7j/iYO?=
 =?us-ascii?Q?zSKIuAObcS48sth3GrIOUBfyY0JjTPK8n6ii1in2A683PHKTpjMTBBNrbUlB?=
 =?us-ascii?Q?P7tngus+OBEKrWK552RgY8jKjFGZwGKPuqdIIabdOKDPdHP/d0ksQGf25vTf?=
 =?us-ascii?Q?PE9rp818oPWzNgFCBGM4q/cppR2AvQ2Ms8t7tDFnTxWmipBSUfmQW8v/Q+z8?=
 =?us-ascii?Q?Nk/+JSvn7JborXdQIgPiniLFgRZZPlAotunUntUr5garxQf0GJ3fLZE1HQsM?=
 =?us-ascii?Q?F6zuNZjE/wiKMMEOTHU2t90Vxcuw8RFOgQoOP9UGAFv7jhjBXGUcH0S33PCX?=
 =?us-ascii?Q?9yWro6RO3/aX7KpVTWHrdWEVS+BDP1SKy5/ZzkIjA3C3CJM38C35W0FiX6Rx?=
 =?us-ascii?Q?9+hA0exxPu3KBKAp6he6hL2q4EJDtOgbF51FrS68Ju9Sdr7k+VuwLSHrJe9S?=
 =?us-ascii?Q?t4EdXFTSQtgkVXPAZEEuh6CpC+0J6OQhZwtGcf3KntcjjsfEbqVBXtLnVdRV?=
 =?us-ascii?Q?BR76E6eBQd30/SBYG9Y0wjmk5/wZQdpaL0mT22yZgSNLhZ/DBXfUaPjb04Br?=
 =?us-ascii?Q?2oAwQ03d3A3syUjBbZwuADJOdTAHa+KUAxBw/9cz3C7EiXNv6py6oNGLQ3uP?=
 =?us-ascii?Q?DP2utpFLRtl/jPbSvJDpEXfsqHRxvROX7HbSUOX7DbGJbVhRYDwYJUufa5uy?=
 =?us-ascii?Q?O6+Q1sKzPLGsmmKbmOTq+Sl39Mr60XBZFh9cr/rVRzUr8OFhPHPaZx+oR+z5?=
 =?us-ascii?Q?lwGG7ziZpNZnWmixLpbTFg8iy+8ZO7sIxT6Ufmf7N2pOAbVal5/BANdmylS8?=
 =?us-ascii?Q?lbLQy0RUL3P30TUEXH8rZZQ0t5VCfUPAchAqR+IwBBz3795ZTJjuCkmGX26k?=
 =?us-ascii?Q?EGl/D8YKU0v+OOGzonsg454ARjKEC4JDSi6B4UGVZSf/Tku8QifEZYrbBmgN?=
 =?us-ascii?Q?guUvcRLfHumrOF7KGdiKZQN2styKLsQ0qmpxPPmUOXuUot7rsQ9wbDSEg7Ax?=
 =?us-ascii?Q?GTL2FDej3Wy5CxJkOszXCws6xTZCy3D8HEOPHRfgsR6VwvfX2W6+RJAQinhe?=
 =?us-ascii?Q?0JaKfZsfRSIoF9mGcS/yIQbbV5uMz3d22qbF24uF9av3DI0I63qi5MopV3nP?=
 =?us-ascii?Q?ElR2xHlrMkf5c/w9uigLMLl+DVQz3OuxTPVS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HHHdghPU1xJGVYZkw4a4Ant56ItxnMjkuFWBc5rzSpmCGE32MUjbXjC0jWQk?=
 =?us-ascii?Q?MTXj7Q1mO/aElsWeCmQJ1PFWwqaAgm+R4/0QdmVb+5jiEhmY7wJSzEycccDt?=
 =?us-ascii?Q?c4/8gbLi72Ez6HmUvp6TWdzPXGUzlk4abG9AdmdCmEJRnJY8onoHiVry6WC7?=
 =?us-ascii?Q?5hUHV3zp0WX+wj5rWeB8wbCd7xWFfNwKn/oq/df5Puzvm7KoEkG3393jY88v?=
 =?us-ascii?Q?iehTdnJhBXd9PvjpqBHNRAPdVEpZOm4yFdcUgi0aqH1At//khesOXVVJlsq8?=
 =?us-ascii?Q?8gAyn0XAER7BWy97yrB6bVNRL7/ZXJdfEXi+vjUZfCtaVCexK9V5A96L2tEU?=
 =?us-ascii?Q?+h+KXsnlZVt4JV2UytpiuYfzEyNk/wO8ys0nEPeoO2M+udYCBh94zJWJrwf8?=
 =?us-ascii?Q?Ti+MegBtfTKYNGleuDWJVdD0f2MJDhjhJiberJTEX7xIPPT45NUyJKxts3uk?=
 =?us-ascii?Q?k83RiR8g/ddQ9Kvnk7ZdF8Rd31DjCUzN2S4REg8U6RtMLaQlaayMb8TPLs7D?=
 =?us-ascii?Q?H3YevF8bHsMqSZCOxx5QjKngS9w/GpEQkpwk2HggOPG4i0DwsTdLuXJV6RQc?=
 =?us-ascii?Q?G+CenNi141U7IWsrmR0O+BAWzkr1thOWIf6sf9sphl+t0omTxFdxD60ots/Y?=
 =?us-ascii?Q?TqtRex4ai77PAMlsOTl11ZDbAdnSmpdPWgjXwTX9tooOATag1zUO8lyxcOVD?=
 =?us-ascii?Q?5FH9/2sgLrWS+56u9HNTHJrIlJzGIVhbXDrHnvDGClmzxLG70wPaQOabkzQP?=
 =?us-ascii?Q?BOh+Pxqvow1sqm21TZ94q6OaI+C/bEg3SccQjdixkHoP5yovoSBEyWDPqlEZ?=
 =?us-ascii?Q?aK/yLzjHcKwWh4WJL4Qpv2BVUq6UbWJOuFVDdn82CoabEKTnsGTBq9VXo9Jw?=
 =?us-ascii?Q?RBXB1MTYFjxIlxBM8ik4lHUjo7UerpDiN17km1WiP7JKvSsQzV/3Z7zw6M7S?=
 =?us-ascii?Q?lask65bAmY44od1xrTjhyJyk0EaNmN+2P5DUaqwRPjxxDTAkAua6QZVdmRww?=
 =?us-ascii?Q?ithOz6qiuaxmeOSuLMWTcyPdnYYVW98P0/jEmlF04zrKj8cRFdE8N7ZQAX3u?=
 =?us-ascii?Q?CeC5XBSuSdAb99dgRl4yrDFFcfg71yuBpjMXlIwaEl+xq6RomClID3SavjQP?=
 =?us-ascii?Q?xjfNcwDc84w9kGdLLnJPSawZ6EdXJedd37naDlbBFfZ9reFYXa+LV+ag6UDk?=
 =?us-ascii?Q?E/DYkyUpL5rtde5hHsvxpf1ZgsaFy8IM+VVoXmoNB2Cb/ueHuYkVw+tWrLff?=
 =?us-ascii?Q?1q8Ri87K5feIOh+9arOp8xBCxJq7uahmi2cLl9jli6usCZ8BlXs6Vowee9Dy?=
 =?us-ascii?Q?w1GlvmVCD12gXAKiGxWxuN7d/B6DDXpnkpTAi1eWONMYwfhK552To/CxhvIH?=
 =?us-ascii?Q?ROCl+iXXycbh5WoDkWKgLSkNhKaTV+jeuep0kfTP7B3Fz1G7dVLlnh4wJfvC?=
 =?us-ascii?Q?by7WsE17iVcSzYn3ibSL5K25A7grZ0gIi5GxzPnTQO0U2lUIP5S165XWMe8a?=
 =?us-ascii?Q?w7upZIURHss4sUqshvuChXog7ywziYuZmNT8losK5pgY71anUPInQ9Rs+VOD?=
 =?us-ascii?Q?PEa/f1e9AzuRxgaI569Rk+obQ729sJxKLQZbpdzBa8d5Nay5hmvfJ0lonA9s?=
 =?us-ascii?Q?/A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c10c49-2cb2-4c2c-89cc-08de203ac3d7
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 09:23:10.4907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b4AZVXaqWKg20siFM+5CNClv5J7US9nkjP89wqP15aQW/PAbwCUgXlrHp1f2+VNqkH3FJonko6b5CLBOVkpahQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10574

We have "dev" which holds &pdev->dev, but we still dereference this
pointer 4 more times, instead of using the local variable.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v3->v4: adapt to the new patch order where "[PATCH v4 phy 03/16] phy:
        lynx-28g: support individual lanes as OF PHY providers" has
        moved some priv->dev dereferences to lynx_28g_probe_lane()
v2->v3: none
v1->v2: patch is new

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 0010cfa61e07..5d5c94295726 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -1162,10 +1162,10 @@ static int lynx_28g_probe(struct platform_device *pdev)
 	struct device_node *dn;
 	int err;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
-	priv->dev = &pdev->dev;
+	priv->dev = dev;
 
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
@@ -1218,8 +1218,8 @@ static int lynx_28g_probe(struct platform_device *pdev)
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



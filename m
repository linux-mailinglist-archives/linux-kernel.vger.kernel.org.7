Return-Path: <linux-kernel+bounces-829586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97413B97658
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEF4F422DE5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA6C30AD1C;
	Tue, 23 Sep 2025 19:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="G6EpV07D"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011025.outbound.protection.outlook.com [52.101.65.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3169C309DCE
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758656730; cv=fail; b=DoiSU8IlB7FfHxRSr0rGGLRTZBVkCsGc8tRb0rsx6YWbvNVrCeZ81S8PMHs4dKoZII80WYGah0cuESrkj86c0JhU1alCBYyodggFst6Rj4ponV6t9HFOzYoDubsJFoehak5uOaviHONCMipZsyorWnCmxkXcyTIlnYtCizYuYnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758656730; c=relaxed/simple;
	bh=4rrTr0tEDaLmU0jSgZk00xHIaaE1y1yVDtvxdbFYoQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ni3S/Hwph1jiJEQ1ejahmbJXEEGliFknN9agaSO1a0H0GFvkwHO9cjxV+4ue42AWJ9cN53h36Di+uoQcAYFr2dvqth5KON5VYfS6ppFJI80bKDk9/Ec9fqqPkN3Y0yA8L8tXfujInpTQqbamvuQhNNGSRXsUvtfaFRD5SKTDNo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=G6EpV07D; arc=fail smtp.client-ip=52.101.65.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWQX8dkgmdMBD9N/quA1JnjzixMRYqCrAeeN2Jhvon4MqQbQwlItseuQB/rbXpxsEJcjUCgD47ZaatzFDDuFHlqVRdeK2jySesAQbcKWhLd4tnNXZJZSI2O6ELhQPeXCbikHl+Jmg+zy8SpMCd7kpUr5OLR39dChfm09uOoElyVDFEE0srQlURKCxD/mNe7pc/0/+O65LvK0jtDuGXVcjv9LyCWrL8iWNnWtfcZJqJl0LCONWLsZGdElCSwgcjOPcu127MOoF6LZ75PtEaIMjjPbNoMp4yDcUIUJ4Igv64hjWxPjUbKpl2uZzWXkOwCrlvY696fAWfPIswo128flqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8v5wr/NzsmQtEktyaXB5187nxwlbruh/ILW53jj8rQ=;
 b=xSSvRr1cmEKdq1swZ1dIVh0TesWj1iCi9KzzO0NQX2WT+wbkJ1otPBOEMXR43ui7ZvdxE1UjUZF79xKmwGcFm51LG9ndcvd5jotECjo2wsG4Lp6wg17wqlcSgvlotqddxJTMWQ9q++o/h6pxUrEXUiNgeoj8Riph7HGmuQi/j127YSnHRTpjFgBHIES1W5K2Jhme9pwXYfy0YlXcS0yuAi9OcziYayZPenQv4vfS17UQ9/SxIQfkX18+6hIi4tG2QxRyUlCp0U/SzyBE0JA8CwbIWYaBC9czVmqAZYDu50gIydyIgNRwhEYBRmhtIwJaLHsH2YmfM5bxyJoSzJFDPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8v5wr/NzsmQtEktyaXB5187nxwlbruh/ILW53jj8rQ=;
 b=G6EpV07DKx6rWJGjH5nMmI27mj1KFW7uGKWgkxw9RD8HtZwhZyjCOTxo37BCs6Qccd5Cl8uRRVwvONF6Fh7v1NKJb/pWLTveoJ7J1COY7KiB9HMJqzkJMMSkoMddvPhkBBnuepA5iQnI4ei5Myx1uy/QaDaD8If5oD6WLiKRX+x2QNp8EwvjDdNPVsoTHqWSZf2/SRQ70KaP4H8kZ6XFn/09YfiopR0oxch2qsXvESYgGpA6dNdfz7Si4K8GsZoqM1tDvgSCGe67py4czliYuoJr3+s/cR+FDczleGV10IvfJc1UWfVRPMxveXEH551TN5ss2LdqBNg5gW2ijbcG8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DBAPR04MB7352.eurprd04.prod.outlook.com (2603:10a6:10:1a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.8; Tue, 23 Sep
 2025 19:45:16 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 19:45:16 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 phy 10/16] phy: lynx-28g: use "dev" argument more in lynx_28g_probe()
Date: Tue, 23 Sep 2025 22:44:39 +0300
Message-Id: <20250923194445.454442-11-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250923194445.454442-1-vladimir.oltean@nxp.com>
References: <20250923194445.454442-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0028.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::33) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DBAPR04MB7352:EE_
X-MS-Office365-Filtering-Correlation-Id: 78c67676-2eaa-46e5-cb4c-08ddfad9b78c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bCtw5ZMrv6BAUCrqalcT1ck6ZcHeOJeJRQDC6HzD+qU8TOV924cBa8TrxFDS?=
 =?us-ascii?Q?bllXYxORUQGh14z5O89wooYB/fW8tvL9ZZy9xAbRRePEAlYuM97J+y9+/N2X?=
 =?us-ascii?Q?attBAf0hLZjDnQGxGPzkPApkSqw9jmVD0oXTuzJVAxXoMa2JFEM3whSZUhdO?=
 =?us-ascii?Q?PdG1J3Ftz27ATWY4+Zy9RVt5tbRqvBdCtgUC6MmwxC1C/wuRHIUXhtyeiqFK?=
 =?us-ascii?Q?+rGGQSlfDKTNgd/heuXCQMCljVe7Fs46Us+jFTDrnChGTYMe1ywlsjsYzOMq?=
 =?us-ascii?Q?ce4xzJD2CXlJJ1Gn2cM+W6yJWU4SPAY/33+xKNP5Sw+vuuw4YIrna0tvxQeS?=
 =?us-ascii?Q?uSMeME4BPYVhpbmX4sThRH+zEDqkGfZdvHd+DEgahxRI8Z6niuHUmngxIRu4?=
 =?us-ascii?Q?8NCRNK9chWJQ5UBYRHWyM0eETr795HlvxEbNsz9kOzJWpLdfi9F6YiC1C1MB?=
 =?us-ascii?Q?XrFGD0XC8nSEZoEk/xZk8SvGa9T7mR7q849uFs/0kQiFnCkeDdGRfmsSPVva?=
 =?us-ascii?Q?NrZHm0eNnBddfpCEJ4BdTHn/XyF8BnjaDMS1P7vPk9tXEiplQBKYpzfI0yqN?=
 =?us-ascii?Q?IyhFmWyAH0/iBe4T8EvanE8k92iAJ1o93KT+Z7TbTE38wXTbndUhin9giAp7?=
 =?us-ascii?Q?KY0eqzUdDJmRaOcAIrPHBnZVv52kky9hpsDN4QkGjZIhRGVYZqISEjQVH5nQ?=
 =?us-ascii?Q?9ln9GU4YuLZLTBCLGofo19VsnJw3u5M6jxnN9vWf9evHmNN3qmf9ZTglGm/S?=
 =?us-ascii?Q?4YEIZ2ux0UZ5dvE1mmjFdKogahyIAVfoDnUkVhF3bIoV3wyLih529qRLJ62g?=
 =?us-ascii?Q?KNUwFyT/K1bthVYetGZJBqyrT3yMQHotZLQta0N8E8H1QTFZ1eGtCWs82psK?=
 =?us-ascii?Q?XPGWTJUDUvgmvuwBbE2DUft5ojiwFKfiKfxUZhR5WB8PkTeI39QCi+3Js6XF?=
 =?us-ascii?Q?jOk3PiLM84t8eF/7IDTe2JrTZQjmcny4KcLiXeKk1d6nZRTX4dLv8KroCfY3?=
 =?us-ascii?Q?GG0YvQ4S/pjZNaNKDXjPWUTUr1mfADilinJPEjrDn6R55UFxx9Jl3j6vhKXk?=
 =?us-ascii?Q?DaEHu2D8+ujZy71ySYT+LUV0UaJByYqBWtEsCV4YLBHeisYH7ofuGWz+GVG2?=
 =?us-ascii?Q?gwptC7RAbKOZEG0oy0AcULWB354B3TpA2p/QqhJxnuIBSRRkyhVcMf50BLmu?=
 =?us-ascii?Q?u0B7SDirT0ALI9mUIDoweFIiGQRwpOoPIObx1RZTWRwiBKK5StEAcJpT5gPc?=
 =?us-ascii?Q?0ApTGcOltlaZLM3zStFxewdL4hdbu3TYn9nw6+CeLTcf0ym93jn8zvYr210G?=
 =?us-ascii?Q?WbYX0STVSWj7kKyV24B6NJqU+SwGTYqXetHBwkUV5G7DoKETJQkFk207zR3p?=
 =?us-ascii?Q?+Qba+9C1BYzQfgM8dYbAbRd4KCmZ6Yh/gCPmRQTYUH3ksvaowKyDsHrQiNsz?=
 =?us-ascii?Q?fi6+q+C4tD5ZeRnRrfVqXzNhi7/EvLRApQVp9jBnIk7lF2QoT/yqMg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RfHGYyQ8g5SIbdWxHcik0HtqqbvTuwonWnanZRV5V0N2QPqkYvVptx4T6z7K?=
 =?us-ascii?Q?scc8+1BLwZWYqbFRG7LIbw/2DOVdqzErT9YV7S+b0WzlG7mQZqQHj2Migu8F?=
 =?us-ascii?Q?rpxPOQCqPQBf1MWTZrcVdFCk/XyrzKW/h98nWW6LNkjxPvQQXhkMde9Hq/bb?=
 =?us-ascii?Q?3f8FI20ou7q4tZdv/AsK1lcZX6TPVtvAtc/omocwpSJmn1+QMllY7c9ID50Q?=
 =?us-ascii?Q?xQ36tnxhmysVGPcdlejIQ4uk5xdXVR+wY0LTrWIggA+9bGjb8Bt9tRXOrHFw?=
 =?us-ascii?Q?zLgDL8c9rHagh3ui7DX1fCgjMh/1id7CHv04DzyK0ZPb3GTSa3GqnI1VM+4x?=
 =?us-ascii?Q?cdMWTfsWUjpbDoyn9qlOd96Pu/GJLKW1tmBEFUWOKuq+q2pV+IOg9/BULYd4?=
 =?us-ascii?Q?rZX1B76p7Ue+o+uAfrzr9/PaYsC4WwFtchOr94rU9xq3yMfbuANcatx2mveY?=
 =?us-ascii?Q?6OCSp9sBWHIBx2KeeTT2naNqyDfYcGyVcz9a0PMHxiFdX3tMUg45EXpq+ltx?=
 =?us-ascii?Q?C1I11lj5ilR/dn0tBCdfrF6sbk8rE/ifA7G5l9qiJD3UyteyHo+J/WKqx5tC?=
 =?us-ascii?Q?fxbDb7uqJS2DUkF5RTs2l/YVU6H2yejgPrR0Gg2A6tQeQQrv09z/+oqKSeyE?=
 =?us-ascii?Q?luDeqfFO0PJ2FLUVd0myEd/yOapt6lbGvqiv5+TV5j5bkcmVan2GktHkLz01?=
 =?us-ascii?Q?c4r84zqN5qOpZiuBe8kmQYFPKTgCZxihPRVbJRUnXUFT2oKU4aKdqb0caugj?=
 =?us-ascii?Q?eM2sRBcHTBoD4a1U3YSYweHe22GhP1qpDiKyN5bYIYSlgJo78r3umxbw53zs?=
 =?us-ascii?Q?7qridUFb8/TQz8j8GUyS0yS37M/he9YzKb1WMj6w6WTXnBfmsYz5oKlRI+Af?=
 =?us-ascii?Q?kxaD10pyEd4usMtucKYBvrsgLBBy4gqAFTfc+2DPtBT+dCmt/HAELD95qok0?=
 =?us-ascii?Q?oMMgZ84mQGl6BSUVUYTG3mOwzJEA1n7m30d73Zkvs+YLsWujCGxMPLcvJ2pc?=
 =?us-ascii?Q?HoKiivPhS9YElj7szhQ+fGluHnIsJQroK2g1q1d9WdiyQm3hytzg8xFARIJW?=
 =?us-ascii?Q?N5ivrkvoG2DOEcCjOOcooRsMR4huUps+YpJACFJfGydaoyg0If4gxor2it6V?=
 =?us-ascii?Q?W574IL122b3DDUEFg7mgXgkK9vINSoIrd4Ze+Mzv02QK1BO+QgAlMBCUkn1v?=
 =?us-ascii?Q?YmMuP13MMkm6vGP6wx9CqPXTtv0ikzc/hv/xrQK/N84NgewK2i2vIOV7mkas?=
 =?us-ascii?Q?WdtOU+dbTu0JIUGntvaTHe4xjQmY0fOFwskS1p1Ai7jgeM57D2qiGYUowkjl?=
 =?us-ascii?Q?Vogztjmmv849jANHgBfC8VQf1igyS4o1W8aAGPPWrW8307hhEN1NWZ2zzQBk?=
 =?us-ascii?Q?KCn6Ul5UG4oz5S8SLM8B+DBldREyqR1Vh9Q4ZX7LKPuRSNfgy/tfI0vQSaP9?=
 =?us-ascii?Q?W12SaMU+NsND4oQtwLfSfsKDOMe7wXydN2i9VbuQvFJgLKaQfUhSUagT8ql+?=
 =?us-ascii?Q?Qgnibu/uZPpkaHlA8TjS6i5I5ZWMRvPkL57RmEfE+tDpTJZpbLebYa/9eu5P?=
 =?us-ascii?Q?/GcltanejDlL6G+HhufLEQaw6aYLG6CKt4ntMluXykHU9ccjIIWspiutTA6R?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c67676-2eaa-46e5-cb4c-08ddfad9b78c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 19:45:15.3874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XuKyiKgPGYaaR3tON2Y5Sh8MgxzGjGuq3vYfkSd8iT9NrHQn1cHlbo/L81gwZBv+hSDrKRuk3/VzrqI27mQWMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7352

We have "dev" which holds &pdev->dev, but we still dereference this
pointer 5 more times, instead of using the local variable.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: patch is new

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 1c126276394c..7a1ef35f823f 100644
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



Return-Path: <linux-kernel+bounces-800979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C73B43E71
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2197816EDC2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B585B2FF166;
	Thu,  4 Sep 2025 14:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="okW9qTY5"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023110.outbound.protection.outlook.com [52.101.72.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AFE4A3C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 14:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995501; cv=fail; b=PkQu2UQn4iHrI8/n2yqbE4oOnej7aeuK9wOPnslL9DZBqdyctwycX82q/Az2YW5xBBd0pJt5zJN/uoHxujvFecRBzyofgtSbI+zNry0EIVH3G8PSmjWIeIwZhhhBexBKJSCO/8dk/flDLxpwDrRQuPLSYu9sPI0bK/2JNnr15uQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995501; c=relaxed/simple;
	bh=sj51G5bsVftDTcJAHNPm/6Bo4WsDkMgnxhUEzU9aki8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VCp8GqpI6SL5/b2zNcbpFtMBaTFNTRiQFHSTs5qoZZfwnT3SVeXiYRPj/DVnZRA5kZDm1i02KY018zVkHfZluaIDwNuFq1rW1fdAi3bryfPs2WPfFnwyn38oI5/Tofiq09JEWrQ6oMUKm7rmFvg9jA1lvCHorzr5HYA5ILllx4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=okW9qTY5; arc=fail smtp.client-ip=52.101.72.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lrX0576ZkYZh//6eKKgBvx/ZHmSy/j7BmMkf2+R+3b63ZXHRPbYGOgkZuPPAsvgNySUfIVWNO47orj8jAEn/AYZQ9Tyoha5Qk3HXSfDapYEfxGmI+LhodPFC+WZzyUPwVc0GxXuKoo141cKP4efYXNHagsbYJtJiZy7EncoxhyLYc7aiu7SPvweLvvNjLdFvHw5ssoAUrKVfwRaWIVPVrM8GcCI8NsPg8Rn9xGgFW2YQpZSEb05bk5Gicb8M4ETLO/KsrC/JquK+GRBUZBaTSAucRe/2wrwNnyEqhAtQik4V4iQjBw2gaCsotdIvvA+YELAhibIk6mOs/Tyloek/Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/w2WIgLnuWOWmC0UgqGOLyNjwGVYChlJl+uuUstHaw=;
 b=c7wDClQqnyeQXThlrmjRqy+AwEY/gLXRsgiaE6lxFZAhEDIwkY9hwab4ugV1gEROOdCkqv+f4r/DTV0fmcSQxqWEEquxfeH+Yed4Q/eN6r7l7ThJl9GtBMG2wACrdLUANhZpBsUbNarHodPQaqMNY3c194KzSAEy9oXDAh6TBthJEkEAUmbfAQlm3w6t3RObbe3VlQ9VYe3pCXT/b/tSVIqgeR//P2FlkM7LmbTCh1aBZ9fwnv/9vb9prZzJ6JDqyTPS6CLYMxdW1BqewyWpPQt3VOHK/7r6GZG57UwGxXqdMqW0EWx3zqXMXFKu8E0X1RrtGxnXlEdvcKTKPYUy2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/w2WIgLnuWOWmC0UgqGOLyNjwGVYChlJl+uuUstHaw=;
 b=okW9qTY55YRAopKQpXnzIA0HNUmA5HI6gEqliZ1F4igT6mThZe4PjX7QIQYa3RRsSV1FhH9rpnl2PPmjY5ywWjGYTpfcQ8nSpwIqI3I0R5aww1iPnAmrYyHnYFJZEoUvtByEX54zXXujl/BLqEbttNyXeeMU4ehtWHIWHBNDXlkExtzlUay9Rdv0u8+r0M0eO1qZeIRqf/aR15tbBvPImWYB/KFlDAB2H4l6u8yDWImraRbT3cK5qDTWYGeBB6ab7gCyrJv+cGeIxzxHl7nBpoi1w6HKQeERU6nbPzsNlDrpOQOA4Fl3VRnR0H5ooop0HN8NHUOMflRlxkNxJDFyoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV1PR08MB7875.eurprd08.prod.outlook.com (2603:10a6:150:5e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 14:18:14 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 14:18:14 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Martin Kurbanov <mmkurbanov@salutedevices.com>,
	Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
	Cheng Ming Lin <chengminglin@mxic.com.tw>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND v5 1/3] mtd: spinand: fix direct mapping creation sizes
Date: Thu,  4 Sep 2025 17:18:02 +0300
Message-ID: <20250904141804.655608-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250904141804.655608-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250904141804.655608-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::13) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV1PR08MB7875:EE_
X-MS-Office365-Filtering-Correlation-Id: 2066b4f5-6068-45ab-4c34-08ddebbde2ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ze6Zj7weVjgSqLcr9yvKT+bce3iYgn6/wlOy2aT9dWLyt0XZQSwp59gufs+u?=
 =?us-ascii?Q?JVh5GpG+m1ePrIXymbHVd2DyIG4oiNLZFwkW40ryHm6K/jEvxKMWUN0fJNQH?=
 =?us-ascii?Q?z6s6pVIPMjjDfElTGHdZu+83blpYGNPAAM4lNoIz/323Lx4Zpq8U7W82XFJB?=
 =?us-ascii?Q?+39pgLB/eGt6OOc9w3+O8jM8l8+J/u9vwZtkMkvday2JJphcRqpjLNGwuNla?=
 =?us-ascii?Q?yTPm4gHqKq8zbb2ReDRLCJA7XpaDlAMSq3jO+uH3QSZc5QGbOCjLsUCKmKsT?=
 =?us-ascii?Q?fruB4NAzpbf64yFKlIFYuXuPFGv36cKnHoT4aUc6Hah8gWAatXIPoo8gkERk?=
 =?us-ascii?Q?IQyXof0WM8wVzpsqFkSCtnz7+0ovadKOUQlVHBsEtF4xMHFEMmHsJK//8uBy?=
 =?us-ascii?Q?jZwXJL3BDy8hn5FAPI2Pt4yDDe1r72NppqL0JwDHyjlOWV5q57tPwTIijoE5?=
 =?us-ascii?Q?oukcY1HeNYv4XRYVt0/EU5tPlNxdtWioj6/47bAZ6tYdxHxPlj8P4u5YBzav?=
 =?us-ascii?Q?wwQO4AtG0qlovRPqLQTFJtnjCITwNygWuMRHPKBcmdvXSWs4SdiYtLDnQMs2?=
 =?us-ascii?Q?vNyPoITIFeaJiX+LXxYJcfs9oTAyh4jtX2aPl8qr1cJQMP+llusPxnFlxsSM?=
 =?us-ascii?Q?QmBCuecvBHaqg5+Z5rgZh5UhaPmGbk9BETwugX2RfZxW9lIm/oxEOkF7V5c4?=
 =?us-ascii?Q?HC3xo07rT8IFFC9c6YHyLQCOCRrdqAMaFBzNCpOokeVfOCZi1VLldTT461lB?=
 =?us-ascii?Q?92QXWiazICnL/00dUHPkt+L0zLm1kXdNXn99JmCluUVC4cjUnTmWNXNktk/c?=
 =?us-ascii?Q?txrLzXkCYwB/3ZR0ZrCdxz/bWXFRhs9nrBZFgXcGyQnrO9e0+SGDoVwlAXrp?=
 =?us-ascii?Q?3nN/MT5EyrABXUCOxKUKIclbTpDkAgzWFN5MucUUOotIT1E8M7WFdM9eON9q?=
 =?us-ascii?Q?55Qmuo+evZ+zo3xuqEup3wiCFrQWWyv8F5dQbL8XnGl5hB32Jr182AJ6nIGb?=
 =?us-ascii?Q?PHjVEEM4Ve+Ui/9gjdGkwOed4Vlg0RBpRmdxh/ITxnT+LEydHJdK8Zy7Cp7p?=
 =?us-ascii?Q?EaY20SWQCoZudM3mCzNsiVy1PlzhpjA33oGJAXnNzc65tqtnNpcaihzfZpEW?=
 =?us-ascii?Q?0P1IOfingZoqIuJZWi2rMDufIf6jmQQYj7exBC7BnGn/bQRhtKUQffsUnw/9?=
 =?us-ascii?Q?JCA7hkBcxlwOHVoXVpYxB07XeTG839P6kTFbniMbEW8Srpca6DltanYMVeBq?=
 =?us-ascii?Q?C2nlWGw1dVwXqLcm6ZO6b0BCuvSRR+KcUYbTFmSzZvUKZuVfJd1XIb5yx/ag?=
 =?us-ascii?Q?FKRtCo+C3wvzq1R2Ns1+B62fCwcIbuuDWl5yHkU9skXthgc2rAZCYJRg1ua6?=
 =?us-ascii?Q?Wq/MzxN2Sgz7BnIVwIpeKKI5mErYfSLclJzLiQw4zl4+eZlLfVXLGA95yqb3?=
 =?us-ascii?Q?ckKsoZBo7ion8vBoX64ECyO6cdTul8krYPcm11bDPDHlf887zmgCGdtlhs4G?=
 =?us-ascii?Q?RqHMPmLeI8bwGNc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q1DZU4+n45/rHxHOH47q6Z/WBudAhLQlKvnHuzLc2sowlvkJBBbLtnBUyfcE?=
 =?us-ascii?Q?JnkQrUNrFYScvAH0L9SnuFTdvl+BzoEXZ+DyLvcxNxwSXXVWkGn4PjA0M0Z4?=
 =?us-ascii?Q?tAxECZGidEGperxzMeRoevhXxF660/5cO8n8YQgmNuZl3ETPl596XvrioFQb?=
 =?us-ascii?Q?BzfuhRCfafFpQk3q7uRahp86Tf+ADQbE70XNv6Ltui7skyZgqH1gsqRQamsb?=
 =?us-ascii?Q?7wrzZXY4lJu5PlDWrd8Y074+hGcFBuV6YAqidYoMLFFlgf8Bkv/iXih57Yvo?=
 =?us-ascii?Q?n7o9yX+aGY7GynITm50WhQOE8YaZo1uoA65coJD8xYvFoLjbKVQc4ZIXNRKF?=
 =?us-ascii?Q?Kl2GtsTeOsFG4JPQD8BnA3mOcM6VR5e3DTseXxz46Bo2KSHPDAouhxEgeTDU?=
 =?us-ascii?Q?rvZFpPs4vbW6RlnSN2Za2X3BWmajOK+fSy/1b9DTn87OwarVN7C/nkvwAf2I?=
 =?us-ascii?Q?LMI5eqE5zeUZpcuWnjQUt+LXEmUUpPISnp5XCEC5yo4i5QbJwxngjvI8ICNg?=
 =?us-ascii?Q?yWw1pb3ifeAdMthzoDpU9aRaTNzQia+w0sBsxB/04itJNyy4zATq2VbSmojA?=
 =?us-ascii?Q?jm2xssWntw0GFKvU/diwhvCDO4X/qPVYfXsn4uYoQJiWhaRbbtjA7UqAmXpc?=
 =?us-ascii?Q?MgryuULcWpRkgeOSSdvQxq3upFqVwAxA919O1gPlB+MWystSwJtp6zv97cEQ?=
 =?us-ascii?Q?a4gH5x52Z65VMeOpJ/Z3GwXpId+XxrK8EpcFJ4WhKI0anVqCNCspHPvg6GxY?=
 =?us-ascii?Q?5Ph2oZM0jqBu/TW+rxKGfaDyLJxLrbWC9KPpnmB5qAVefNKNfS07j22K5gAH?=
 =?us-ascii?Q?K11psSOo7dJFDXsMUIO63WGcyM5Hc5bhEF4+7crX9lcFh2Ptaz9Dj0JWcLmk?=
 =?us-ascii?Q?WaqdlBQYtP9GGJnA9pmP5h/AABFwOnJpx2K1LGsNJOLk3UOk9ntNh/s4Ti56?=
 =?us-ascii?Q?QYjyjV2a1hLWnYvoA9+slG6oWVsS2gAhhDFuV5kTKbw1uKorHI16dlM5njy6?=
 =?us-ascii?Q?vBpY3t4jx1+0+iP60qlYomsokithPqSI5aGyEfgoKrTWpjKAwn7RgFman/J9?=
 =?us-ascii?Q?ggcaGxEP5GLNVTUs6A8zQmAHGVrDQnhuklAjvlkoZFIkmcF74RtTntX57x7d?=
 =?us-ascii?Q?95Ry3B0afLzmainbrA65RVIe65mMavSGzNiWDz5NtfnDaF9dw32je7ua03VL?=
 =?us-ascii?Q?YD8VedhWPG/I9izC0FhnnVFh3U6qNhkfG0A6Y5amSGfX5jXbPAkG1akD3JL0?=
 =?us-ascii?Q?zQqTC1nXZWQJgBbdnZnqTUhHScXmR73pzy/YGN04aJm0PdM2KRNVBTYQBzNi?=
 =?us-ascii?Q?QJvDTsqAHwsUTLFcbgcb2fwDtphU2ti3VdYBiSWXlvl5PC+9OKhfL5kFmxmE?=
 =?us-ascii?Q?ESrOLQN+T/Po9BTFSOGY3Ws7w6+eOCB9DS7hH1P0QY/BOOFaASaHBawqTxYs?=
 =?us-ascii?Q?UCi3wTcE+Fzm7d3bRUJtU3J0//3BXk4+kmUIMm3crhR7JT8vlcAf34c1bdhF?=
 =?us-ascii?Q?iGzWk8mC2WZL9TBBl2c3TxtMVqEZN/MxRFqIuYxDMXWuH36ov+oJFfR0STVW?=
 =?us-ascii?Q?ryNraeCXsSumnNEl/nOSwWCGiJ15S/ujCSNcOV8u6faTFJD45c5TMUwtfkhu?=
 =?us-ascii?Q?AZ37MbbP066usbc9c0RxfDE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2066b4f5-6068-45ab-4c34-08ddebbde2ad
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 14:18:14.5089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mhya/EtuzmHT58QkO0Ze4/18IRjePQAekUUGTh5c7Tm4SOWqUsuKXW6FNqrhSprnNI1pVvdFh9A9KdetF4Yt1sTU6cucbdZ2R5lUQq9TqYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7875

Continuous mode is only supported for data reads, thus writing
requires only single flash page mapping.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index b0898990b2a5..09dd6e40e308 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1097,18 +1097,13 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 				 unsigned int plane)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
-	struct spi_mem_dirmap_info info = {
-		.length = nanddev_page_size(nand) +
-			  nanddev_per_page_oobsize(nand),
-	};
+	struct spi_mem_dirmap_info info = { 0 };
 	struct spi_mem_dirmap_desc *desc;
 
-	if (spinand->cont_read_possible)
-		info.length = nanddev_eraseblock_size(nand);
-
 	/* The plane number is passed in MSB just above the column address */
 	info.offset = plane << fls(nand->memorg.pagesize);
 
+	info.length = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
 	info.op_tmpl = *spinand->op_templates.update_cache;
 	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
 					  spinand->spimem, &info);
@@ -1117,6 +1112,8 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].wdesc = desc;
 
+	if (spinand->cont_read_possible)
+		info.length = nanddev_eraseblock_size(nand);
 	info.op_tmpl = *spinand->op_templates.read_cache;
 	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
 					  spinand->spimem, &info);
@@ -1132,6 +1129,7 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 		return 0;
 	}
 
+	info.length = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
 	info.op_tmpl = *spinand->op_templates.update_cache;
 	info.op_tmpl.data.ecc = true;
 	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
@@ -1141,6 +1139,8 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].wdesc_ecc = desc;
 
+	if (spinand->cont_read_possible)
+		info.length = nanddev_eraseblock_size(nand);
 	info.op_tmpl = *spinand->op_templates.read_cache;
 	info.op_tmpl.data.ecc = true;
 	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
-- 
2.50.1



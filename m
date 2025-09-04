Return-Path: <linux-kernel+bounces-800982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F29B43E76
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6DEB171837
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B703074A9;
	Thu,  4 Sep 2025 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="QXafwTan"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023110.outbound.protection.outlook.com [52.101.72.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726E4307AF7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 14:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995512; cv=fail; b=Q/Fvsc4Z9oxbYsb/bDsH69LN7fvmYosZZVGZ60T6tQwaa2gPJKJOS9ix74v6SmF8yDUayR0oxcFkZWtnbY9DMFpNF/QstH/5iZlcTjVj8I7C7tyHBr4TifIs0hznZnuiVQYtv6TyidVSRV4Wbxzo7a1kvZHrXDwjNV5YLJ9KzY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995512; c=relaxed/simple;
	bh=PCAW1rb7JPpBfSQ7+/M+otJ8trYriM8366uKvYjwgIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tacxaTLFMBi36KduamXvRlkJ5vsvVlK7CIadBmZrBkHKuCuuBc2r5PCKMw2pAN7BCrVzDC8hX2wF6Dxlkg01qWaRFC4ZwcjDx49ByXsH7w9wt1UAbQl+JPzwQLkgCXd2f/a1RD6EFyiKxAn7M3Uc9mIQeWAQklDsHfK9YtGV54Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=QXafwTan; arc=fail smtp.client-ip=52.101.72.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0czn6GFxjWyEwxBcmG5ToN3bULn3koegs7Qm03X/lmmtTay6MRzF/sEYj6QjP7nrvLX7sqhARks8NnkkPqToXzf0L1428Pp779gj5uNAl7V+bc8OLbvDE0Qyup6daBoT6qiq+MQ+SXe5mZ407301cCNQBwJuLm+AB9ugw/uXPNvcrdydePjjB23031F6cjW90twDTrxtNYUkMGkB+S6Xzyxw+mwDKFfvKbs/EQuUrrjM0iMJIQtPSKhBJn1z7C5pcM3Y7YL2ZiOK9gQpI11sVmSZU7ZfvakIp6M++T/VZwdi1pBS4ECXbudOgToO7/TTpc5HBgk6kwxySrZGdF8jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hR6JoplnyAX2vo1rvhniEmWzsZJodWPtn39FOP2MwHs=;
 b=sjvdClSihCMKb17ONDaiUNmHXTUuYoAooZjEAbzZuqZK9esnd8z1uTOmeEaJf9jQNA0IePNZrmMmROhy/5jlZStZbBI2tNET7W1vRMC+dEeB0xf7BtOK7UbJc+Xn7ReuLEr7Cjd2v7pYqAYcOcgiu3tItEsqor/BV9Fw7neFeUrVcOVq1X0m/jc8qpzc3p2SPbdfS9TicOrwsW5YhTkYrqwnOpDNBI+rbT0trTXYC3bI1KQ953cxqECZ2MFY2bY7NvmnPI6QqTHvpnGa3jfDTZk8qnG4uMPqyTWqkliB55SY/BpBg4AQnAIZi2aBfqDCsNUeCsV8f6FlJ9fJiuXWSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hR6JoplnyAX2vo1rvhniEmWzsZJodWPtn39FOP2MwHs=;
 b=QXafwTan6lTw03H2RSZUCqMkpuTLowDKSbxihQ/BF9AcsqCA5ecrgclkwtdX7lH24rnHgovMOjECgkHKmmnBeN6PWhLZ4Wk+rqyOwS4ZH43+27XUa3EIljti/3RUB3D+EKzVcsNnncYBDCohOe4HU0u0mqeNOBcz3nNlG3TiFgzBD0HiGHY+AXoW10NFsZCSDAMmH3lnmEMh07laf8ArCkf1ydj7TzSKoT/BgpIW23eETfHtyQAe233ju4wiJWxCxVODWPqJzptkyB8VjFRMo2Mr711qqYneUHqXASYIaEeyPetA6eSBWBdpO2K4njR6lYiTMfn2bLpLPe+MzjSlwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV1PR08MB7875.eurprd08.prod.outlook.com (2603:10a6:150:5e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 14:18:17 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 14:18:16 +0000
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
Subject: [PATCH RESEND v5 3/3] mtd: spinand: repeat reading in regular mode if continuous reading fails
Date: Thu,  4 Sep 2025 17:18:04 +0300
Message-ID: <20250904141804.655608-4-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 0d2fc72a-75e5-4180-7afb-08ddebbde423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9ANKe3y6UjitIb6JJmkCXmqnbs8JPHctBllfDGieofjsJELyA9wvKBFE6IZa?=
 =?us-ascii?Q?br9AAlt9hv0PNN+BI1F6OtLbARlAOtS/UHw8DzanVmbGgIIEwIkVf7cstjcR?=
 =?us-ascii?Q?P4kCxYbUj8AP/1FpQhDHbbnefTtRzYwp/uhMvh9TQ2Sn48+3tHMCQ+nM5ALS?=
 =?us-ascii?Q?9Dg4hhg9y2SqSQIkKf6k64GyhnfTtcxBBHnLDZhmCuWNT8E88IgUk8GIOcdw?=
 =?us-ascii?Q?pXiYqw3vwDIjg+XrgotH9WDKLQICxmfYd17aGwhdSp0dfdVPUPqPm5F8hwpn?=
 =?us-ascii?Q?4fCYHW04IVSWiDy1NhsFadaZQdvhzspsqdHmA5XPSc/Uq5tZ+vovpConaaX7?=
 =?us-ascii?Q?gSlcmGYvHp1lATOzjFpLlG2BDJsKAsaqwAZ1z40fBpOoOp5zXVev6D4x3iLm?=
 =?us-ascii?Q?DCkffMNJeoa+Rd+41ef9aa4pCf+xBkTqziUD6crWlG/f6RrQGNkrMQFJQ4gR?=
 =?us-ascii?Q?45C++4ZkGZpmhPMBwanOwhaswUUy9zf8Om40oOB3HEHn5hD7RgADODISpAu8?=
 =?us-ascii?Q?xoHtJ3xSA2jC2HWnEByjvtr7zCBNyjR/Cv4kLTOozDBTY49o5kuyWf6YMKLc?=
 =?us-ascii?Q?Cxlj5I3XI6WtpbHFFWoLwcBRVkK/LocR4YIrp0XhhgC9T6DqxWyc1fM4z5y4?=
 =?us-ascii?Q?zMQtlm943rmd6L6nHRNKNkAKXmK7wS9GcaG6jpg6idQVeYfWlsODoZd0fc4C?=
 =?us-ascii?Q?dbBj+Gy5gRR8kg/K9mi0VJY4DzhX6t2TBT7O8pIgQVJ2fCs7mQh5bmZ7RlXW?=
 =?us-ascii?Q?NQYXPk+5+qAk1VFG7oySn6YaaEnj1xtPiB/PzppmgS7UCaCw42FDsTAzcAz6?=
 =?us-ascii?Q?97HpBVTLO1bc/dZ5UdPRkCsqY7MCK1YkWDXm/UGjeti4Qz9OXVpF1GGVvmye?=
 =?us-ascii?Q?LjamROhx/JzA7YVHuhkzALbdmL6SZmtW7UD5MHUWEvvKZYpuVI+dcU02dNvG?=
 =?us-ascii?Q?wpp7Jp3VEWBJLr4n+CT7lvbz5s0xKtnQTFVM02b3Hvahttf1l/gEZ2MpocVl?=
 =?us-ascii?Q?g6ax4/ijwQZsGxsAH6t6FFgSGWWwk+5WEZ8e7RhPXpWUrZW/caLN8DDpYrvH?=
 =?us-ascii?Q?OJqdxUx+FhT4tN2hP219hMFqbLHhpO/mLdyZP09jrMOWwJwkvypZd5iStB7Q?=
 =?us-ascii?Q?uo2ikvCZZSb2K5HRq2GM0ySRA15JjADOFY159gZjyPSZKZ9Lx+lWNBWjn53n?=
 =?us-ascii?Q?YfIt6jAG0tWrh4RJRgotiz1MZjx+CJ84AYLRrflonM6mA+StNOWf/AT5vJCF?=
 =?us-ascii?Q?jFyPXVRjUYpZM5vnymJrdK7lJ5rqBC3CZsuOD9XEFtC7DGwf28vawxDY1MV5?=
 =?us-ascii?Q?DTcpiC/NJsovy1CNepfBtyUtycHfrrtw2RLkBqOIqnvbbkMgMlVujq7tM6So?=
 =?us-ascii?Q?RMuykEgKUKje8jbFLo+HWnUyTAcqoyJd11NZe0pQcc2915g++s3E8170HnCQ?=
 =?us-ascii?Q?lhuaV4jq+OCNMl9TTnk8hncyMwQHOjUuTV6/npSYKTEn2dW0kxg5b8XqALKa?=
 =?us-ascii?Q?3WiC+V6q1y6vEHA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cjZXMzuDKHJDzK/S2lj8ik+bRodQ4XvaYFCLFFjknWmP3a3327QGiqp8BvDX?=
 =?us-ascii?Q?LrC0j8q5T5+3oX7PVOHIrml8YdmCZdb9qM/KViQUAUSYBcq71PYFzxnKbm+N?=
 =?us-ascii?Q?p//9rrJF8Z0I1bkUKGVX+Vz4F+Vw8LYZAfJqN5/lxVz4gITTIjbGps85WoEC?=
 =?us-ascii?Q?1DlpuU9zoln3P8EAN9CXftqjSa1e74N1JaAkQpd+O31OCSO0r/d8iKLw3IaI?=
 =?us-ascii?Q?xhLHUvr1UG8/OCu+I2VoWsORRxdInuhcUndI7pwbVJFLTCUgxS9Ak5v7PznP?=
 =?us-ascii?Q?KnOe0FLpoAVqyfFPIA0gPoGLXMde7vHVf1dOe6Y+aBcgGZWTxMZY7bPZE4ZY?=
 =?us-ascii?Q?IVezqINB1cEP8LxR9zMTgAZNQ76Mc0s824LEBzon+MEY+F4O768sDWWqofHZ?=
 =?us-ascii?Q?vX2y+Gu5RIutadsmi/OGnb+XJxAryw2mWUWIVAos9E0Sjl3vNL5UXPuNOjYa?=
 =?us-ascii?Q?2xJx33sQz9W0SwLkJNPx5WNKLmE9OoJkC+CsXje1/zBOVdf7MRGIaLReBDsS?=
 =?us-ascii?Q?l92RFoJ4xnzULztiab8v6ZwhFNUixSq5jlel7jJbwZNl9TkK1USdC20CUxmv?=
 =?us-ascii?Q?8xWpPUC3MExgTkNr89fddoaLSwi7iw1nolYkdRW5n2ASZrCIVFkh5Brj34rP?=
 =?us-ascii?Q?yEq2IdzmH+5he/i9i7dk9770yaEwv5+/ljzxfm7BM9DDTitbls2nN6tThoPS?=
 =?us-ascii?Q?nIReKFH40efAR3u3BmIvsTCSVDf/AzMF4Xpq9hXLgyG9s3ik0UHEJCk/0OtW?=
 =?us-ascii?Q?YauyvZ+SSnacLdBm+BtslwJ1LdOct3HWMNl6uklYfjfdFGZGDxCfJ/VBZ9eP?=
 =?us-ascii?Q?DpGtUow/8Bh/cymWZTOkugGM++qvYbWU1NOgP7uOjXjZVqR06Edxc030DYsn?=
 =?us-ascii?Q?WaZtIma2PGJoYU/NnrqisBkRUctTg+bHZMtht0NX/mfEcN1TziOvyUbBCExL?=
 =?us-ascii?Q?ymDkc4ZMyjZzUpvDkvzEG4JzDiXu8iN9Un4kWVMD7N7epDSb8fiYBgdG6o4s?=
 =?us-ascii?Q?FNUHt+MczU2n/J6b/e8SYAoMD3xB3633Mnv9+Mii+8HOJDm7ym4+zEF4UimK?=
 =?us-ascii?Q?fnBCAAHY5QOqY+eFvyh18JGJYDQVn7R9QusfUjmRjVElb+l72W7wy8dF0Gtg?=
 =?us-ascii?Q?Km8cTM4JNnhhLouWiacnYVWI68Iy/cD8gbJHShCed3ds8A7C3eBAfuZcQ6XI?=
 =?us-ascii?Q?eOO13SrWnqQyYz+hTdCF2KAjdLL5UUBC1yeuzjY53qc/eoxgZZLF48ZVb3ms?=
 =?us-ascii?Q?ctODJSBFjnGo6AEi2pecY1LOJ/CKY4myFiUR38jTVb8JMfpySbcz4U/Pho95?=
 =?us-ascii?Q?l+PeKg8LEp9YDrR93CCz0eahc5ueBIM04MrOBpcjVRZgkiEp57omv2+Iq8fx?=
 =?us-ascii?Q?1QpMh9tyvEkfKAYSnsKkSeB56v7eMibcTak0B+dd1WP2p+YyQTHhcJxFipNl?=
 =?us-ascii?Q?D0GNEapu19DISWsWlwegj0pBaV4gSU0AuT5qF9WpZlvIRwRly/ZyeT4x83DG?=
 =?us-ascii?Q?fg+5/a7ThwwpMRWHX5TI18QfKEIRfizaFaCCFa8sRiifhWysbI9mj/X9Nk8g?=
 =?us-ascii?Q?YtUe4lQXk4k0biaHIUzSRhB9b/+Jt05enUlDMIpAiNDFW2KP6iWZTg+lifuM?=
 =?us-ascii?Q?AqiLIJd4rmJOtd17e0ETZUQ=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d2fc72a-75e5-4180-7afb-08ddebbde423
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 14:18:16.8356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+dWQIYOcd2vPbbJhAehrlmhmZbPUmQw81cEJhvRPA2vvwGvqRSTcwnSJiRkCeMIIXdbvk6c7csXkZQAm+0w0/O11X4GEgajTfzNztuigNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7875

Continuous reading may result in multiple flash pages reading in one
operation. Unfortunately, not all spinand controllers support such
large reading. They will read less data. Unfortunately, the operation
can't be continued.

In this case:
 * disable continuous reading on this (not good enough) spi controller
 * repeat reading in regular mode.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 02e322490110..8bbcc80aede0 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -430,8 +430,16 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 		 * Dirmap accesses are allowed to toggle the CS.
 		 * Toggling the CS during a continuous read is forbidden.
 		 */
-		if (nbytes && req->continuous)
-			return -EIO;
+		if (nbytes && req->continuous) {
+			/*
+			 * Spi controller with broken support of continuous
+			 * reading was detected. Disable future use of
+			 * continuous reading and return -EAGAIN to retry
+			 * reading within regular mode.
+			 */
+			spinand->cont_read_possible = false;
+			return -EAGAIN;
+		}
 	}
 
 	if (req->datalen)
@@ -899,10 +907,19 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 
 	old_stats = mtd->ecc_stats;
 
-	if (spinand_use_cont_read(mtd, from, ops))
+	if (spinand_use_cont_read(mtd, from, ops)) {
 		ret = spinand_mtd_continuous_page_read(mtd, from, ops, &max_bitflips);
-	else
+		if (ret == -EAGAIN && !spinand->cont_read_possible) {
+			/*
+			 * Spi controller with broken support of continuous
+			 * reading was detected (see spinand_read_from_cache_op()),
+			 * repeat reading in regular mode.
+			 */
+			ret = spinand_mtd_regular_page_read(mtd, from, ops, &max_bitflips);
+		}
+	} else {
 		ret = spinand_mtd_regular_page_read(mtd, from, ops, &max_bitflips);
+	}
 
 	if (ops->stats) {
 		ops->stats->uncorrectable_errors +=
-- 
2.50.1



Return-Path: <linux-kernel+bounces-834500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F4BBA4D49
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07FC2742CD1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E455E30DD16;
	Fri, 26 Sep 2025 18:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CXv6B1tI"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012044.outbound.protection.outlook.com [52.101.66.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF09530CB2A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 18:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758909937; cv=fail; b=JTFqIGc8fxl27UazuX1S+Jiau3osDUbXwJNAo4j7pPjLNp9OsRpoW9TQjaXDfh3egnnqgoDHIkQNCyZNCYbYUxFBNnnYo5rsVFRSNvpTim3f5z3wWCQizBg7hSUFYJ6BP323mGj/68ZOoooUWbj424Qu/S/qWnWiNhez63flQLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758909937; c=relaxed/simple;
	bh=kRVl6fcICpuwRks474MSYcuN6imTSUXzAuLNED7E9lo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QA+8toLue9xrWtNIc6D1ax20GTWxIVWlj4+cZeLyL0VB/ObbAIH/eJJb5eKZ4yTLoa6YDu0iaKZgB3p22qyWMi7Ipwkvd9cIkPjf0sZEh2nFOJzxQBwx7r2xjNlKicmGLvzGrRv6hKajpvxLhRyWzj6vPmEirtjgjLfO82QujG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CXv6B1tI; arc=fail smtp.client-ip=52.101.66.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+DOKB/joPI0YKxVyFlGZaZveBYGSv6uojABM4LTGKoTQQ9pZ0C7xf/bX+kNz7xGgMMAd/HfQJU44H4Qfyb8xjdovlpKVCMIJ9y84iY5hHKmTol6sn7BHYEYdWmKThV7MC/1e1QvnDUVwAcKA2cZqN0G2nZolZfqEAkwMV5SHnGxRCyvcHpIyhBm/sf5y3y00ZyiOFUIa8EdAbbnrqP7dFT5QokM4gqwrfHoPl2L9HJrEETSNzc8czjO40VvWQTe46W0obJkqT3O737srRFJtN+U6c3yDi3V5298xbbfgtuz8IsE9pZgH5UsZt+vzFetEInkA/kw27RXzk+HY9v0BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EIQibI1krwWFMFGMBFJ7EukFGFRmO9tY7jKH6ZzeSKI=;
 b=dTImpSct2yLtuvA6cdn90iAC+UXDCZf2G94Dvxq3y4rTCquotVRUxAJ3x05yAFJiMOVz2Qv3x2Bye/BViC6eZefUXaHLFO94jk6Ngad2mKPYRaEeIBzgKpaSiV3yrba3Fz6twAoiXH8ItLoiYt8Zx1s3m4Mbbj6+cfjim/oxgbMhfe8x1C/C6mejBqG6yikp6h4olwmTVBC0doCDvQ/X6bqYQMBsIFMhFxyADP4J71s6yQ05uMOJ/x+8NRI2yqMjFeBXIO5qnOHAZmwVBVPrVNOt99pOuvWweBK8io2Gd6ofYuZzr2F3wllsGuzrJevfjtUEmPFDgoHM4eKrS6bszA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIQibI1krwWFMFGMBFJ7EukFGFRmO9tY7jKH6ZzeSKI=;
 b=CXv6B1tI8duLgA0b6ixSpnJsjoOUVxWKiHYS2KCBTToECwCQMvrk8J0Cn06Y65bct3gTILkJC5N+phRmpS1ZaUbf6GpssWkZ58Ws/d5txeOSnxmhai9XOxkdovOjs2ClsBNAy17e58NLLjATc1KbibtpJUuU4bTuSUZ7jzfSmm1wf0JJZQqXKJLMOJqk4HrGCpCbKg/HxXxXE3u90yRfAMIVkS4Pf9CSbsB+YFU31PqYb9APc40Q/Ep+O+xt3NS1dRDGnvehAyEuGTUo0YfQCM4WXTuM1bzLsaHTrJGp1TKE2j/4LqYBFdlwTzVV70yTkyH2/ZKqe/hHv//WUpUuPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB7878.eurprd04.prod.outlook.com (2603:10a6:20b:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Fri, 26 Sep
 2025 18:05:27 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 18:05:27 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 phy 05/17] phy: lynx-28g: restructure protocol configuration register accesses
Date: Fri, 26 Sep 2025 21:04:53 +0300
Message-Id: <20250926180505.760089-6-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: ebacb857-eed8-465b-b3f7-08ddfd2744d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uEeUZS6qbfsq+qqbFdLjUUi1Il/IqBF8tf/4hmj9oAaAxPdmTntuvvreTEbM?=
 =?us-ascii?Q?FF3QPf+++1JMsEAE3OhMPH0RkyIceaxyox+bA9R5EaMudHX3O9xD7Ze21NQ8?=
 =?us-ascii?Q?6SfwSYDlTb5+CROuEF1+Loh+qrpLOaTCSdPp1RKRg7qw7TaECw1q5XtEtjMk?=
 =?us-ascii?Q?7kksXZK/p0hkokSK0+FI98uGXbQAkwzCguGnV1o7PTfHrItkIFKLIqqbkgIt?=
 =?us-ascii?Q?Fr6utK5tr5T2/gz+yeSFJkOBJHfXTnKvQXeJ3h207Wumyts3FYWomppCIU+E?=
 =?us-ascii?Q?Qkk2TKeAa9SA/2Cz39xTBwWYDZ8iV1t1hZHsQWpAv2uNqBDtBKZeHIerHE/m?=
 =?us-ascii?Q?J615RU+Qu9Z/lfbc0T50hUxaM3WM9UKazDFuNV1VpXJQHUcCJNnGgmQwjqZQ?=
 =?us-ascii?Q?oYkzTLDXOIoKB1Pok5YipRo7IQo/JEcBDMJY6VPLw1PvSQhcYajUTv0vlZBc?=
 =?us-ascii?Q?GcarEvoQbyTJGJr3Y3fC9UYJx90t2XAsJIucCaVW3qxxYLi0v+nCuhkEbCaO?=
 =?us-ascii?Q?k5KDIwrQLkSAudXHNqnXJWwQH3Ga/X1FuG+1TetROL52IKAw6ml1MQ1g9fu5?=
 =?us-ascii?Q?a6Yzzo7jLT2uX0eQipmFlByPTJxCvJws7fi+OVtqQ63uASAVf6QZjnbFao89?=
 =?us-ascii?Q?LnSeS7ccZS4TuVhaUmG9nSl8d5joTdPlPzR5s5W5P16DsLGEB0uw9boTwdQf?=
 =?us-ascii?Q?227oHSTz4j630hllughQ2WljTR/mpcqvTRe8XpfaCuw1r9Io8pGjfxZV3oa5?=
 =?us-ascii?Q?GaZ1xoMNVVulcMhL24juvpNHe3Dri6/ZuMdEM4Cue/6rUso2I9OMzE7CXnTu?=
 =?us-ascii?Q?8qShU7Atyhsj9FtZVWkaa20S1dJgQeL7gJQfji7LIUkXBnumEUBhVe6Y0N+9?=
 =?us-ascii?Q?xVfZbV/MQkNqbSuReMg18eXd+zlEyj5KU4CaRwjzs9mP0zuCwOZFuXGmOYvG?=
 =?us-ascii?Q?BVUfrOZqKbD1cYTaxefYqZBO2nOHxUaxLPQmrW4HXrRTsTJfrpOWIwJDI6Fq?=
 =?us-ascii?Q?f+entKdRxT+5mh6/KZ98Ta1jpe0kgZddTfcaxgqLgjDYP3JbkFSg4Bx/Y/mP?=
 =?us-ascii?Q?bICnI1i/G9JEsATukXUMDGodonk/uzqyx9R4Tw/gSm3z7VZhIUOTpmMlt3eU?=
 =?us-ascii?Q?f1OMmS8yKtzsg5lEX/YSvflvvDbXBFWjf0d/I4xdtAesNz+JKiB3xDQVjK6R?=
 =?us-ascii?Q?bTSwCRV/2pnurOZdNS1bh4eT3aoIDxTPGS3x64e8jmiwnCutJiiGofCydB2D?=
 =?us-ascii?Q?+Lu76rvsrJJQxGtxueoW/NkFQUwU8jYpiWoDajPZY1smXfm896/XoJg8/4H+?=
 =?us-ascii?Q?EOODJ1W72mvnBhVn+nCcPfgjN6i9bA7sizMCOqmUxjmvLvBo6r3nZqiaQ6dM?=
 =?us-ascii?Q?Em5sjg/Ig4G/iT9srerZF9JmlcwJ8c0Th8DlT0ojP7lq9MMjwvhfS826vWPC?=
 =?us-ascii?Q?7RTldBL2XuFW00UYrYhy3dwGL7mZwVepS35cWRleGFcz9l8l/YioJycDp/yE?=
 =?us-ascii?Q?OyJntUay6xB3lb+Eh4U8gjcyWfvJgSxx22YT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dTiWW0MeXN3Eu+FQSjvXYO0ZA5wkiQJmlp3uCDmaOke81y+fLWLmCxRRwvZa?=
 =?us-ascii?Q?2X7O9/nkZep5wExGRLc9x5aroEWEzWNde1sReT5fP/b440taSs8D3zTt3sLo?=
 =?us-ascii?Q?K8ZlUGXECodOAbqMvrP/PYggkZQ5pt7b9oSBCfT8Qa6aLcgIR8KsMhP+Zrfq?=
 =?us-ascii?Q?rWxnYqNk2rJoOvkO6miT6Y7uhRtGicqyEJTjeqg+tXIhpGSj2AwyioGYsYDK?=
 =?us-ascii?Q?k9VZCyX3O7g80I8N1grIaoz14OccyfiVStydAaNywbYnIRGNZO8RjASUrpzF?=
 =?us-ascii?Q?Fbo5O/2IKo7cu8jJgaL9Qxhc+qExNG9Nff9ZL4cRTOAfSKDxkqMFX0/LOotY?=
 =?us-ascii?Q?NjcvcLAH7MmBXoJBELTKzGNGRgaq1FyjtYL2sffUX0AgM1a3JSPdRvRx+yZa?=
 =?us-ascii?Q?8NapfCAqafr4y7pAeRSXgL8LdnIe6ohSIZLQhyY6xcPzQsB3MMaVhS8qVYmD?=
 =?us-ascii?Q?9KUWxfk3azUnH+S7oMK7b9wyDGbt4f80TDkKRHYX4DJ6ph7wGEsg8jZJnAOi?=
 =?us-ascii?Q?BDhwkawoQKOiANbYfEQtPUgFB8Nbh6DIV/oPf+LaAAucD/YvbYxSWJT5cdrH?=
 =?us-ascii?Q?vEmKmJmlRZh+R9eP5OCEz27lyOdFBK2z9z9LU3ge9AZezKgfBc470tq/77/U?=
 =?us-ascii?Q?f7bE4Byr1X0mBDW7ZLiPZYE2jXWTDwEZb2b8ldehzhsPWUznNPAP6aw1QwcB?=
 =?us-ascii?Q?ftB8xsBuU7y64VtyAPFpjWrOqWqpPTA28ROxHPjpQTZqGa5aQl4iwiBL5mJj?=
 =?us-ascii?Q?9X4e5e0vJMFzdSnnsUPfK1YRrLe+nzNZyRtkyoVbI4PFH9NFN2qbLYisRzFY?=
 =?us-ascii?Q?HtB9LXQFhKEP8STDKj5Y7vg8YU3zT1KiNBi4u3B6iYgHrq6kpE2MQhxz9qmv?=
 =?us-ascii?Q?+b8PTJws5qYWeHfoSLInm4oNohqfL/8aTPrKUrKAUWVFQmzvBYMaz8/aXaua?=
 =?us-ascii?Q?lG27TWr+f0+2vlTSWJ+1geJOmZdzfBUDOwNfgJjeiYTUUVnY5HpDTWBoSgJZ?=
 =?us-ascii?Q?i0TVSRfJLIlRJFNUgT2QaQEJRZkA555rvE5JEsgk82pemdubV3Kqz8j8qHO+?=
 =?us-ascii?Q?yp176ZDwqZuJWDiIhLLkg4Kx6sgYYRHZNinWwBAh8andNaklgYeFUXJMPMjg?=
 =?us-ascii?Q?MPvdCgBFKguycI2ipNWRoxyWsXxREyHdml1TbrPEegx92WFPlgs+jz1Ze9tF?=
 =?us-ascii?Q?pl7KlAr+S0a2+eZvxc8uQ9mUFlPAraIqcnPXnWyHkGlccE2w1RYL/O4hJKUF?=
 =?us-ascii?Q?6i2oolTjGSxrSMecIHLofCDtyKApUmnKajOitsOqpsHAb/deWPMxl58hwfzN?=
 =?us-ascii?Q?7g2QrVziQ53Ct1f9abzvkd8ICZAZ5iuBv5n/uRVjQFYGqSexG9DdWMCxAMF5?=
 =?us-ascii?Q?ZB+fDLPOI+vSh5BG5+aA4jiecd0efbc8hGTv4nUoTkYBAwPl8OTc0bpHtQ5c?=
 =?us-ascii?Q?UdCKiHrj9fI0TDSGxMPffi8FVuasSRZr0NV/2yIAK837CIrNMLyrkBGlIOpc?=
 =?us-ascii?Q?oEKsAJHfLwDFUYQSYgOqebZUKsgENPJ/okvsAp8N86+TLyTwstNUEYDJbFgj?=
 =?us-ascii?Q?Ud8TbYhA5wCMon/TSO/RgtvXymGhyKT2PwfqWBBtXC+pv+bMWRsLpjGmTxt4?=
 =?us-ascii?Q?QA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebacb857-eed8-465b-b3f7-08ddfd2744d5
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 18:05:25.9204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Avq7NesldR1RIRmAmlWY0OSGQs6T6NNnKdEpYcDVKb2jStNugKkxkMkkBByPDhB+e6sbAjj2IACV5D24emkryA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7878

Eliminate the need to calculate a lane_offset manually, and generate
some macros which access the protocol converter corresponding to the
correct lane in the PCC* registers.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v3: none

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 55 ++++++++++++++----------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 684cafb3d3e1..41a346ac38e2 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -12,17 +12,32 @@
 #define LYNX_28G_NUM_LANE			8
 #define LYNX_28G_NUM_PLL			2
 
+#define LNa_PCC_OFFSET(lane)			(4 * (LYNX_28G_NUM_LANE - (lane->id) - 1))
+
 /* General registers per SerDes block */
 #define PCC8					0x10a0
-#define PCC8_SGMII				0x1
-#define PCC8_SGMII_DIS				0x0
+#define PCC8_SGMIInCFG(lane, x)			(((x) & GENMASK(2, 0)) << LNa_PCC_OFFSET(lane))
+#define PCC8_SGMIInCFG_EN(lane)			PCC8_SGMIInCFG(lane, 1)
+#define PCC8_SGMIInCFG_MSK(lane)		PCC8_SGMIInCFG(lane, GENMASK(2, 0))
+#define PCC8_SGMIIn_KX(lane, x)			((((x) << 3) & BIT(3)) << LNa_PCC_OFFSET(lane))
+#define PCC8_SGMIIn_KX_MSK(lane)		PCC8_SGMIIn_KX(lane, 1)
+#define PCC8_MSK(lane)				PCC8_SGMIInCFG_MSK(lane) | \
+						PCC8_SGMIIn_KX_MSK(lane)
 
 #define PCCC					0x10b0
-#define PCCC_10GBASER				0x9
-#define PCCC_USXGMII				0x1
-#define PCCC_SXGMII_DIS				0x0
-
-#define LNa_PCC_OFFSET(lane)			(4 * (LYNX_28G_NUM_LANE - (lane->id) - 1))
+#define PCCC_SXGMIInCFG(lane, x)		(((x) & GENMASK(2, 0)) << LNa_PCC_OFFSET(lane))
+#define PCCC_SXGMIInCFG_EN(lane)		PCCC_SXGMIInCFG(lane, 1)
+#define PCCC_SXGMIInCFG_MSK(lane)		PCCC_SXGMIInCFG(lane, GENMASK(2, 0))
+#define PCCC_SXGMIInCFG_XFI(lane, x)		((((x) << 3) & BIT(3)) << LNa_PCC_OFFSET(lane))
+#define PCCC_SXGMIInCFG_XFI_MSK(lane)		PCCC_SXGMIInCFG_XFI(lane, 1)
+#define PCCC_MSK(lane)				PCCC_SXGMIInCFG_MSK(lane) | \
+						PCCC_SXGMIInCFG_XFI_MSK(lane)
+
+#define PCCD					0x10b4
+#define PCCD_E25GnCFG(lane, x)			(((x) & GENMASK(2, 0)) << LNa_PCCD_OFFSET(lane))
+#define PCCD_E25GnCFG_EN(lane)			PCCD_E25GnCFG(lane, 1)
+#define PCCD_E25GnCFG_MSK(lane)			PCCD_E25GnCFG(lane, GENMASK(2, 0))
+#define PCCD_MSK(lane)				PCCD_E25GnCFG_MSK(lane)
 
 /* Per PLL registers */
 #define PLLnRSTCTL(pll)				(0x400 + (pll) * 0x100 + 0x0)
@@ -314,20 +329,21 @@ static void lynx_28g_lane_set_pll(struct lynx_28g_lane *lane,
 static void lynx_28g_cleanup_lane(struct lynx_28g_lane *lane)
 {
 	struct lynx_28g_priv *priv = lane->priv;
-	u32 lane_offset = LNa_PCC_OFFSET(lane);
 
 	/* Cleanup the protocol configuration registers of the current protocol */
 	switch (lane->interface) {
 	case PHY_INTERFACE_MODE_10GBASER:
-		lynx_28g_rmw(priv, PCCC,
-			     PCCC_SXGMII_DIS << lane_offset,
-			     GENMASK(3, 0) << lane_offset);
+		/* Cleanup the protocol configuration registers */
+		lynx_28g_rmw(priv, PCCC, 0, PCCC_MSK(lane));
 		break;
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_1000BASEX:
-		lynx_28g_rmw(priv, PCC8,
-			     PCC8_SGMII_DIS << lane_offset,
-			     GENMASK(3, 0) << lane_offset);
+		/* Cleanup the protocol configuration registers */
+		lynx_28g_rmw(priv, PCC8, 0, PCC8_MSK(lane));
+
+		/* Disable the SGMII PCS */
+		lynx_28g_lane_rmw(lane, SGMIIaCR1, 0, SGMIIaCR1_SGPCS_EN);
+
 		break;
 	default:
 		break;
@@ -336,16 +352,13 @@ static void lynx_28g_cleanup_lane(struct lynx_28g_lane *lane)
 
 static void lynx_28g_lane_set_sgmii(struct lynx_28g_lane *lane)
 {
-	u32 lane_offset = LNa_PCC_OFFSET(lane);
 	struct lynx_28g_priv *priv = lane->priv;
 	struct lynx_28g_pll *pll;
 
 	lynx_28g_cleanup_lane(lane);
 
 	/* Setup the lane to run in SGMII */
-	lynx_28g_rmw(priv, PCC8,
-		     PCC8_SGMII << lane_offset,
-		     GENMASK(3, 0) << lane_offset);
+	lynx_28g_rmw(priv, PCC8, PCC8_SGMIInCFG_EN(lane), PCC8_MSK(lane));
 
 	/* Setup the protocol select and SerDes parallel interface width */
 	lynx_28g_lane_rmw(lane, LNaGCR0,
@@ -390,15 +403,13 @@ static void lynx_28g_lane_set_sgmii(struct lynx_28g_lane *lane)
 static void lynx_28g_lane_set_10gbaser(struct lynx_28g_lane *lane)
 {
 	struct lynx_28g_priv *priv = lane->priv;
-	u32 lane_offset = LNa_PCC_OFFSET(lane);
 	struct lynx_28g_pll *pll;
 
 	lynx_28g_cleanup_lane(lane);
 
 	/* Enable the SXGMII lane */
-	lynx_28g_rmw(priv, PCCC,
-		     PCCC_10GBASER << lane_offset,
-		     GENMASK(3, 0) << lane_offset);
+	lynx_28g_rmw(priv, PCCC, PCCC_SXGMIInCFG_EN(lane) |
+		     PCCC_SXGMIInCFG_XFI(lane, 1), PCCC_MSK(lane));
 
 	/* Setup the protocol select and SerDes parallel interface width */
 	lynx_28g_lane_rmw(lane, LNaGCR0,
-- 
2.34.1



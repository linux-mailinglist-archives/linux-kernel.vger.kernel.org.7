Return-Path: <linux-kernel+bounces-801174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF03B440DE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0721F5A2392
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EA22D63F8;
	Thu,  4 Sep 2025 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KYkmtSrF"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011062.outbound.protection.outlook.com [40.107.130.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691DC2882D4
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757000661; cv=fail; b=sQOLI5u2mTXpAFGkF/heR58CPeYg0Rn+aZzgpxmu69rpi77nG9fdvKXi8Z5xjKYxtGlDLibVXp1t8j2QdqtdldxlzEbFXgsJEndd1+/6wbT2jOlqwTIPSbqM1xqwv5dVr8rQtRJnwMO53qqF+xFN0mnQfOF3jPqJR5ZWfuAYy88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757000661; c=relaxed/simple;
	bh=voOHIiNyKucI4CtpYGv+LqfSFy0AeclIuO/q2+2pCoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cv4r52NlZoI/+vVxJL4H0+glyDO+t5hxlTuvublcJQg7jLvU6w0PdIBhmNVZvUNfHM8DjCgJoWyRKwjH5gd0U/q7Pbvq65D7aivb3qZDK8qZVdX/uzoulxYgnWia2EIHyCw6IzbXCKtGTH8+R/CYBqrz/W5W+kijNNU08PXqt5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KYkmtSrF; arc=fail smtp.client-ip=40.107.130.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BT3t4uqcjPhHqKJHd2cszRZQKuiqln6qPUHnHNkrqK1erRYL1A1CsSumCk+MbmxmYEDUfOBrwBv52iKr9iXJtDJVQ5nDBESLtPSz+VtlaI/tdERrfi6g9bbMzNss1kbiCyRHfEMC3tr2HV6Fy4OujSRJVsXjL+7yj3UqxKi8eMoYJFaPQuS5rOPRHPBY575svh/XwF8gsUBdi/uyucyiAalxv1Szk/ZU1xYpXP8KMc3ojS7xMrh6RhY/kBuiXvd8gQqPRI9VsTmosu032hT03oUwOV2WMPddo9ke1QZWY65+/Z+EMf9J68sQScYMDjwUoT4ciZz2a4vv5eiqpC84Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JVws+VBWfNrE/sCGYyYfVbWjC4Keg499ZyRDtLqoVs=;
 b=IIR0Toq6KEFyp5vQjV3Cgh/64FOlJYeNi/FnLTnLvWYkVoj93dOtfkDcKBmMcU+yBrCT+l6Jz/r6R0uWD3ndVOJx5ftpJ/dtp6cXnRn3QwGFIngBg9GsYOD92GY83EBHS8y7po6dg5mzXBMyEKszCZAu7czQVyxzZl7W41mAWa30uuWkO025QvoPgGC7xP79CsZy/tvaNA83Ut6cS6EXIZ2sSU/tWRuawnFO8ahPs1dOEPnkoiukhJvzOo31vtOojcTdpA2IC5yhyLUwcJUiRNPc6c5449nKEUXL8kuGj0gW0Jxv5lVLN6EPPQNDTmImjRTsSjF9C4kbu9NSNtW/8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JVws+VBWfNrE/sCGYyYfVbWjC4Keg499ZyRDtLqoVs=;
 b=KYkmtSrFMk0RnFunZUOh3SquP5laOX9WAy+/Fqf2cTKH3ELjr0ZILEr2wug04/XzvFmeIP+nwbe0onjIDpvk8jfwPzPhq55PStGUL89mwa0mZnuhvPj4FycQlKIU38YEz6ZVr3DilY25iZz92zdvA/oaHvqvT82BymKvDO+k7CnPz0x4M2RsLFVV1Zx7BBd3D4ErKNEJ0av40SeB7rTMAqlIi5aXBBUXY+nEUt253VjjOja8zadDJuMnUsKUFG3RIaAUi+7TF/EUPIdyhbl48uj+kW+6ByLlV5fvCF8SBLq/URAKFo53uIfQgwyJ+anmrObNmtqzFXPJWXcV+roLag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM8PR04MB7348.eurprd04.prod.outlook.com (2603:10a6:20b:1db::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Thu, 4 Sep
 2025 15:44:13 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 15:44:13 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH phy 02/14] phy: lynx-28g: don't concatenate lynx_28g_lane_rmw() argument "reg" with "val" and "mask"
Date: Thu,  4 Sep 2025 18:43:50 +0300
Message-Id: <20250904154402.300032-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250904154402.300032-1-vladimir.oltean@nxp.com>
References: <20250904154402.300032-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0060.eurprd03.prod.outlook.com (2603:10a6:208::37)
 To AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM8PR04MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: cacff229-58cb-463d-8960-08ddebc9e596
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tjpg+K0pTyUBFEaSvumt5Cg31YlMaPhimvKDTYZTUniu7xyzVMPbCwEQgMCZ?=
 =?us-ascii?Q?IG6rkk0wVohohrc5YK7Ia5JEZnM/W/8TDvv55HM5INwgM7G3TbwDMgntR9gy?=
 =?us-ascii?Q?a1ptTqV6YhDG86Bjjnzbvb5rNa8sjoga77H1jv1UZ8N3a/il7xo4O9wWcI6G?=
 =?us-ascii?Q?9maCZYeqDLEQ+6s6ojds/A6D5XJq83SCMcIJ5krXhZ0MKgKNbZFCksPbqn2s?=
 =?us-ascii?Q?EGHaA2XMjkmwxHT6vQFLNmv+pCMpUxcl0qB0QhM4MGg2FQ4XhZyzcwcfTEch?=
 =?us-ascii?Q?ADSEnZfD/LXmTlr8DYKD684HYAGcKvdfXiG5rgLjiXAcEaKNTiTlvmlm1+Tu?=
 =?us-ascii?Q?m2gUpPp12MBIqMgq9cuIlKqVUtrMLb6Xvu1SREyFB0KqRQmAqmBl6NG+6Ec7?=
 =?us-ascii?Q?mqL0W6yMh8jXnzY/U77E9gSJqUnMXUbtrAsN7/OiiZvwjTrWYeXBRPWgFwVB?=
 =?us-ascii?Q?0JuhtgP8TPlHRNGPJYhZa8t34hTojA1BOaBesEPWDkpNhj6b+NoDf+VY8xoH?=
 =?us-ascii?Q?QiKfXf7v9G6sEgy4lRfpFH2eDknmOX+G4N82IH27tSVX2cLT9xMEN+Q1ZEh+?=
 =?us-ascii?Q?PfVR7CTZroJrifRuBZwIx2n02XLk/19JhJooWGtfuicD5PgrGaW9YQIywiiV?=
 =?us-ascii?Q?CgGwGDrYDXJdNOXNcbel7NoS37RaVY3njPqxIjP57KjjjFS5okj7HTRCsdNF?=
 =?us-ascii?Q?516yxNIEqkS6nlBeCgwkzomkNBToOzeIkHGrtIshISEhSrzw0RFpM2S9onyF?=
 =?us-ascii?Q?jx/RQkuKnISI1+RjhJmVwvhaMUtbIyz35luZgqr7hRf5qUoM6ttIjydHmCxH?=
 =?us-ascii?Q?WQzQyFl5T4casgD6Bu5jiUYxduxE9UsVhQgGkMhhprBKdl0AQE2MxXtdKScK?=
 =?us-ascii?Q?vMvXMJBNK+SkivO+DLr9iO2WSjwREyq/am6eLFC149LQBjFJKsY2M/RlyFfQ?=
 =?us-ascii?Q?X+WiPTw06XtfqGYixJogc3SYjKy13veLIkTyY9a6DppXiDN0ZlnH2A0LvqJD?=
 =?us-ascii?Q?Tu+Foci+ttRErvqTttzoNMeMphokJjSgDIxLXwhm3BIeqRlIV/bzIbpjxhjo?=
 =?us-ascii?Q?q+t/NyYoqBpiNBfhRMmkVH6W5KWHyJPmMfzX5mLtX0WjHngAgdwSZCRkEm75?=
 =?us-ascii?Q?PaoUD4zeNOiuxt3LJLoqB6fECY8wghYSx9k67uXhwtq/FfyWMP8JkiLANx/V?=
 =?us-ascii?Q?wzS5QauHLkkWqJYN/RKbaeWtekAiwOgD0Xvk3f3j5zdsCAENB17hc1cAjNas?=
 =?us-ascii?Q?tmJ8xNT1Qtr7LFXyJZjwuC/Fr41PZwhSqBqdPLZS7T9PTiyYuRMvgP4+7sz+?=
 =?us-ascii?Q?4lEGjn8EoA50U66PYGSNdIuXdy+erFXGM2Vt9yDd5yaUZMf6a15zK9fMIce5?=
 =?us-ascii?Q?u3uOp8K5bqvsiGUDa6xMsf2Yh4WJNZNurAtbFhqaJNkybA6RuvJwU5gCc+DU?=
 =?us-ascii?Q?gYLW1eYzEN5i1JgzeiISoQzuAsM/0K8wt+T+865SIC+gOpWJL+QJhw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x2XvjZ2xWY5dtsmghaHuv5N7+m2NAZfNd4Dh7wlFwbYHhfiL+MBERg3emD1M?=
 =?us-ascii?Q?3PHlPR04eNGj18BWYLdpVPhlXqlGjEpsNj2r6hNItvTyG5fOqjHgC84LLa54?=
 =?us-ascii?Q?z4rkNZ1i0r+Xxtgam+fhoXq0H1krKqiDP6/G65eAvg3qzsdVxKbJP9gAlNHc?=
 =?us-ascii?Q?b13ELZBIF6IBnyzmouh5E+COfqUyVhMTRWzBELGeQyql44f1SKbQMlxET5WM?=
 =?us-ascii?Q?CCLzOkbplmugq//RtDd1zkYhH8scxcPke9vh5g3JCQPp/r09XtPBkR8mFoSW?=
 =?us-ascii?Q?VKt+tLmvItLwDd/kljavRauCEG2RYD1mVI/DtJPImzipWM8Xsr1+muzGPREt?=
 =?us-ascii?Q?8srpCBPkkIeKl1g/7St/+pBa/k9nua2J34amwZcW1CGuw/ph74FNWwvNyt1R?=
 =?us-ascii?Q?JPn88Ai0YLmFAhC2gIA+/DfK8A4Jm8TQHhdLouYQkr7F/FhvqVSu8ESvoeBC?=
 =?us-ascii?Q?0rSTADdgXQqFuOoOIpQB3u8ErZLHUuLKQaF/Bp28DhYtGDz6pLuLgHveoEeG?=
 =?us-ascii?Q?munwXrKlTr8/uDLwj+jvRzG0qLa7ffqMN5ExeSowU8hFfeOHmSosl9ZG8odW?=
 =?us-ascii?Q?F26ruyzlFhJnL4HIasazhdE0Rt+Qd9bIH7D4NvJxoYmo52DjNtZZ6EEBSY1P?=
 =?us-ascii?Q?89x2KCs1S2r7oQzl/okS0jz2kV2DFZ48cEIiMqe1xrsEvWGw7vIHiFK5nfVw?=
 =?us-ascii?Q?WwMA4+4I6amXf2idrWElpU5Ms2jOMRd2WteHEg/Qrt+PN3ktzkv04TjDhNDa?=
 =?us-ascii?Q?IEt1OHVA9J6bwAmAZVpjbsGVpCKWGPVxRpR1EjEvHQWlcotxQLmr69AVV7s7?=
 =?us-ascii?Q?p/IglJlkdHP6IGjyXHvx/D73EfZW2E+OTLuJmgaw1TOHuMc7M6LHVqMRM9cB?=
 =?us-ascii?Q?4AK3Tq4DCVN5ZbBWJEsysZJZ0iM4u2Bv/LsY/eGNlOnBqCY0Fask+t0z39l4?=
 =?us-ascii?Q?LhtyHZ9SSOIjzZoMAJsNrdfh4faxI3faHVrt/j59binyOxoQ5Ay5XOvHSMzU?=
 =?us-ascii?Q?yaJOcXeed4cel5XABkGVZ1MwW6emGsxArr2kRV6Nn7OMEK1b5pumxDOo6YcS?=
 =?us-ascii?Q?Wo9+od5a0AZ0cyXevODWT6JVwiRvwBx+U+W6DxMDwuXRVtMLnmlGx6ZFq00x?=
 =?us-ascii?Q?4eTjxozcmNb5ulmgtawqDEIgx7sKLKzrRuMkM1xM5QVJcFr9fdftEL8EljEw?=
 =?us-ascii?Q?XeVpG5nxCMLRKLjScc/qAFXUTuOuNnK+2ATX7wTHTNwaNjljPe/BmpSt37/K?=
 =?us-ascii?Q?plSxestZjPyvJlezUO9mq4uk28QcUhb8Xe/GjmlSRS2j4stNnbrasHni2Zvh?=
 =?us-ascii?Q?AAuDkFrRK6f+50/UtJ/g6aEXE+cEJJvWAfvwEL19q0yFdJukihJManYala6X?=
 =?us-ascii?Q?mBT9mtjCmabk7fsxdmBYFG7SwtGSZ30ClvFCl9Js34dsgAtlkzgwD0PWbUvX?=
 =?us-ascii?Q?I51KeSSFZgY0FbtgDS1bS8ei84T2jXBSmUv1RCL9K1OhQk6llwxWQOAWJEcm?=
 =?us-ascii?Q?bra8GUCodGgVxzMYVLQII5UukeDDjFohvOF8Lcq2Ap/Qp4jLD9wybQwUnT/Y?=
 =?us-ascii?Q?3xOO0P/eVa8TBVAG27A3R3TIK1JUL5aK0a+2YE5MrceC0wOtcCyGybU+wDIF?=
 =?us-ascii?Q?8Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cacff229-58cb-463d-8960-08ddebc9e596
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 15:44:13.0559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IaEn0p63CMwQF2jm0+vi5NjnumR/7POJ8WIhlyZrZNY6k+VXm9UGcnOFfCkikeQOEj+VI5Ckl0aT7J1N6RQtYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7348

The last step in having lynx_28g_lane_rmw() arguments that fully point
to their definitions is the removal of the current concatenation logic,
by which e.g. "LNaTGCR0, N_RATE_QUARTER, N_RATE_MSK" is expanded to
"LNaTGCR0, LNaTGCR0_N_RATE_QUARTER, LNaTGCR0_N_RATE_MSK".

There are pros and cons to the above. An advantage is the impossibility
to mix up fields of one register with fields of another. For example
both LNaTGCR0 and LNaRGCR0 contain an N_RATE_QUARTER field (one for the
lane RX direction, one for the lane TX).

But the two notable disadvantages are:

1. the impossibility to write expressions such as logical OR between
   multiple fields. Practically, this forces us to perform more accesses
   to hardware registers than would otherwise be needed. See the LNaGCR0
   access for example.

2. the necessity to invent fields that don't exist, like SGMIIaCR1_SGPCS_DIS,
   in order to clear SGMIIaCR1_SGPCS_EN (the real field name). This is
   confusing, because sometimes, fields that end with _DIS really exist,
   and it's best to not invent new field names.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/phy/freescale/phy-fsl-lynx-28g.c | 60 +++++++++++++++---------
 1 file changed, 38 insertions(+), 22 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 4e8d2c56d702..732ba65950f3 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -103,7 +103,6 @@
 
 #define SGMIIaCR1(lane)				(0x1804 + (lane) * 0x10)
 #define SGMIIaCR1_SGPCS_EN			BIT(11)
-#define SGMIIaCR1_SGPCS_DIS			0x0
 #define SGMIIaCR1_SGPCS_MSK			BIT(11)
 
 struct lynx_28g_priv;
@@ -150,8 +149,7 @@ static void lynx_28g_rmw(struct lynx_28g_priv *priv, unsigned long off,
 }
 
 #define lynx_28g_lane_rmw(lane, reg, val, mask)	\
-	lynx_28g_rmw((lane)->priv, reg(lane->id), \
-		     reg##_##val, reg##_##mask)
+	lynx_28g_rmw((lane)->priv, reg(lane->id), val, mask)
 #define lynx_28g_lane_read(lane, reg)			\
 	ioread32((lane)->priv->base + reg((lane)->id))
 #define lynx_28g_pll_read(pll, reg)			\
@@ -205,8 +203,12 @@ static void lynx_28g_lane_set_nrate(struct lynx_28g_lane *lane,
 		switch (intf) {
 		case PHY_INTERFACE_MODE_SGMII:
 		case PHY_INTERFACE_MODE_1000BASEX:
-			lynx_28g_lane_rmw(lane, LNaTGCR0, N_RATE_QUARTER, N_RATE_MSK);
-			lynx_28g_lane_rmw(lane, LNaRGCR0, N_RATE_QUARTER, N_RATE_MSK);
+			lynx_28g_lane_rmw(lane, LNaTGCR0,
+					  LNaTGCR0_N_RATE_QUARTER,
+					  LNaTGCR0_N_RATE_MSK);
+			lynx_28g_lane_rmw(lane, LNaRGCR0,
+					  LNaRGCR0_N_RATE_QUARTER,
+					  LNaRGCR0_N_RATE_MSK);
 			break;
 		default:
 			break;
@@ -216,8 +218,10 @@ static void lynx_28g_lane_set_nrate(struct lynx_28g_lane *lane,
 		switch (intf) {
 		case PHY_INTERFACE_MODE_10GBASER:
 		case PHY_INTERFACE_MODE_USXGMII:
-			lynx_28g_lane_rmw(lane, LNaTGCR0, N_RATE_FULL, N_RATE_MSK);
-			lynx_28g_lane_rmw(lane, LNaRGCR0, N_RATE_FULL, N_RATE_MSK);
+			lynx_28g_lane_rmw(lane, LNaTGCR0, LNaTGCR0_N_RATE_FULL,
+					  LNaTGCR0_N_RATE_MSK);
+			lynx_28g_lane_rmw(lane, LNaRGCR0, LNaRGCR0_N_RATE_FULL,
+					  LNaRGCR0_N_RATE_MSK);
 			break;
 		default:
 			break;
@@ -232,11 +236,15 @@ static void lynx_28g_lane_set_pll(struct lynx_28g_lane *lane,
 				  struct lynx_28g_pll *pll)
 {
 	if (pll->id == 0) {
-		lynx_28g_lane_rmw(lane, LNaTGCR0, USE_PLLF, USE_PLL_MSK);
-		lynx_28g_lane_rmw(lane, LNaRGCR0, USE_PLLF, USE_PLL_MSK);
+		lynx_28g_lane_rmw(lane, LNaTGCR0, LNaTGCR0_USE_PLLF,
+				  LNaTGCR0_USE_PLL_MSK);
+		lynx_28g_lane_rmw(lane, LNaRGCR0, LNaRGCR0_USE_PLLF,
+				  LNaRGCR0_USE_PLL_MSK);
 	} else {
-		lynx_28g_lane_rmw(lane, LNaTGCR0, USE_PLLS, USE_PLL_MSK);
-		lynx_28g_lane_rmw(lane, LNaRGCR0, USE_PLLS, USE_PLL_MSK);
+		lynx_28g_lane_rmw(lane, LNaTGCR0, LNaTGCR0_USE_PLLS,
+				  LNaTGCR0_USE_PLL_MSK);
+		lynx_28g_lane_rmw(lane, LNaRGCR0, LNaRGCR0_USE_PLLS,
+				  LNaRGCR0_USE_PLL_MSK);
 	}
 }
 
@@ -277,8 +285,9 @@ static void lynx_28g_lane_set_sgmii(struct lynx_28g_lane *lane)
 		     GENMASK(3, 0) << lane_offset);
 
 	/* Setup the protocol select and SerDes parallel interface width */
-	lynx_28g_lane_rmw(lane, LNaGCR0, PROTO_SEL_SGMII, PROTO_SEL_MSK);
-	lynx_28g_lane_rmw(lane, LNaGCR0, IF_WIDTH_10_BIT, IF_WIDTH_MSK);
+	lynx_28g_lane_rmw(lane, LNaGCR0,
+			  LNaGCR0_PROTO_SEL_SGMII | LNaGCR0_IF_WIDTH_10_BIT,
+			  LNaGCR0_PROTO_SEL_MSK | LNaGCR0_IF_WIDTH_MSK);
 
 	/* Find the PLL that works with this interface type */
 	pll = lynx_28g_pll_get(priv, PHY_INTERFACE_MODE_SGMII);
@@ -292,7 +301,8 @@ static void lynx_28g_lane_set_sgmii(struct lynx_28g_lane *lane)
 	lynx_28g_lane_set_nrate(lane, pll, PHY_INTERFACE_MODE_SGMII);
 
 	/* Enable the SGMII PCS */
-	lynx_28g_lane_rmw(lane, SGMIIaCR1, SGPCS_EN, SGPCS_MSK);
+	lynx_28g_lane_rmw(lane, SGMIIaCR1, SGMIIaCR1_SGPCS_EN,
+			  SGMIIaCR1_SGPCS_MSK);
 
 	/* Configure the appropriate equalization parameters for the protocol */
 	iowrite32(0x00808006, priv->base + LNaTECR0(lane->id));
@@ -317,8 +327,9 @@ static void lynx_28g_lane_set_10gbaser(struct lynx_28g_lane *lane)
 		     GENMASK(3, 0) << lane_offset);
 
 	/* Setup the protocol select and SerDes parallel interface width */
-	lynx_28g_lane_rmw(lane, LNaGCR0, PROTO_SEL_XFI, PROTO_SEL_MSK);
-	lynx_28g_lane_rmw(lane, LNaGCR0, IF_WIDTH_20_BIT, IF_WIDTH_MSK);
+	lynx_28g_lane_rmw(lane, LNaGCR0,
+			  LNaGCR0_PROTO_SEL_XFI | LNaGCR0_IF_WIDTH_20_BIT,
+			  LNaGCR0_PROTO_SEL_MSK | LNaGCR0_IF_WIDTH_MSK);
 
 	/* Find the PLL that works with this interface type */
 	pll = lynx_28g_pll_get(priv, PHY_INTERFACE_MODE_10GBASER);
@@ -332,7 +343,7 @@ static void lynx_28g_lane_set_10gbaser(struct lynx_28g_lane *lane)
 	lynx_28g_lane_set_nrate(lane, pll, PHY_INTERFACE_MODE_10GBASER);
 
 	/* Disable the SGMII PCS */
-	lynx_28g_lane_rmw(lane, SGMIIaCR1, SGPCS_DIS, SGPCS_MSK);
+	lynx_28g_lane_rmw(lane, SGMIIaCR1, 0, SGMIIaCR1_SGPCS_MSK);
 
 	/* Configure the appropriate equalization parameters for the protocol */
 	iowrite32(0x10808307, priv->base + LNaTECR0(lane->id));
@@ -352,8 +363,10 @@ static int lynx_28g_power_off(struct phy *phy)
 		return 0;
 
 	/* Issue a halt request */
-	lynx_28g_lane_rmw(lane, LNaTRSTCTL, HLT_REQ, HLT_REQ);
-	lynx_28g_lane_rmw(lane, LNaRRSTCTL, HLT_REQ, HLT_REQ);
+	lynx_28g_lane_rmw(lane, LNaTRSTCTL, LNaTRSTCTL_HLT_REQ,
+			  LNaTRSTCTL_HLT_REQ);
+	lynx_28g_lane_rmw(lane, LNaRRSTCTL, LNaRRSTCTL_HLT_REQ,
+			  LNaRRSTCTL_HLT_REQ);
 
 	/* Wait until the halting process is complete */
 	do {
@@ -376,8 +389,10 @@ static int lynx_28g_power_on(struct phy *phy)
 		return 0;
 
 	/* Issue a reset request on the lane */
-	lynx_28g_lane_rmw(lane, LNaTRSTCTL, RST_REQ, RST_REQ);
-	lynx_28g_lane_rmw(lane, LNaRRSTCTL, RST_REQ, RST_REQ);
+	lynx_28g_lane_rmw(lane, LNaTRSTCTL, LNaTRSTCTL_RST_REQ,
+			  LNaTRSTCTL_RST_REQ);
+	lynx_28g_lane_rmw(lane, LNaRRSTCTL, LNaRRSTCTL_RST_REQ,
+			  LNaRRSTCTL_RST_REQ);
 
 	/* Wait until the reset sequence is completed */
 	do {
@@ -537,7 +552,8 @@ static void lynx_28g_cdr_lock_check(struct work_struct *work)
 
 		rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
 		if (!(rrstctl & LNaRRSTCTL_CDR_LOCK)) {
-			lynx_28g_lane_rmw(lane, LNaRRSTCTL, RST_REQ, RST_REQ);
+			lynx_28g_lane_rmw(lane, LNaRRSTCTL, LNaRRSTCTL_RST_REQ,
+					  LNaRRSTCTL_RST_REQ);
 			do {
 				rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
 			} while (!(rrstctl & LNaRRSTCTL_RST_DONE));
-- 
2.34.1



Return-Path: <linux-kernel+bounces-829580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA2AB97637
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A08894E029F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73007306485;
	Tue, 23 Sep 2025 19:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UP7MkdpG"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013012.outbound.protection.outlook.com [52.101.83.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0640B30596B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758656722; cv=fail; b=Cej7sqxPAOj49nClCJme90AXl+vjOyjJflawBXNRw7SRYjagDBND9/iAC5qYbdzJP7oEc0bzGPqXh67nN9fVu7IiJ823Dq02BrS6oNlyinToaWhmdPDm7YNy52HrmofwjBq/B6VRrv2RJcHn2C7TgqcCDeAW8YI+8CBs0ca6gX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758656722; c=relaxed/simple;
	bh=+SSRO91ASkMCncMgLzMi/c6EVLLQV1ck1d6/M3TqkEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DQW5m7MGvbAEOhTK8zrTeBlc/fplO3Zi2ZOgE5l4+wVexwrg5TDqoOpWltkqbeG94+hVXoZwntxBcFCRH9LwgItyUs/XMK3HgOpjfDgt/PtYlpik7vAPAmxDkwPoNPGHSwv4ZmZIJb6ozXBJaeQ/FZJ3PcFG7blHnYJ2hrBGDjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UP7MkdpG; arc=fail smtp.client-ip=52.101.83.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rlVkdM8pXh4MIoWV1d2ZP0OEsuyvAcNfhntipLU+p6fL4qo+71F6xzq/7vkyfRus///sb+1GFMYS2IRQE9qs2kaKl8wDsytgSinpkIGAcnZJd/9jMZ+gPVf5IDhSvO3GRtpflz+s87y+znaI9YbIgcPgwTgk2ouypYP8A6Ss7t/RtIhCL4mVuP/wbWMMQUxyZTjfdVSxkxD5vA0zZbFSHIZ4CPRuUQxzWUwwQWA8jw6fcLMKVblI1s2GxoSDycqwmuycBd6oijIAvXrkfjCJ9h4u7ae52dF9BG8L5mMHvc7ORo5IrZ2ev3IpqYZaqxCci+EASomSYn+TX+ZkD90+JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/TS8tNGoLA9FbL9cJk9BUAsaWPE8N+qdILe6u3yhow=;
 b=BSeHzOguxqqCifY0Get70li6F9OlY9+Zlwz9Fo1ZfMqHlmng4uZDnKmUMm97CuKI/RT8LN16kb8Z0rZ/BYNVOJMt0YviEuI27qdHLXl3IRalqm2qrbhWb8mz6oRiX5s8DdxMT5eFrkZisrs9oGg88l0l/wlgd0kzT/3skWy099nrf1VkKMehD4E0vCqx9y3ijDX5lz1jdcmHL+vJE3As5/VPOknSlG1f8L+vPKN8VdlYxlSj7Uryks5IYfahY8RSW7XdCqm4Ayjve5QLEdvyD7tyPzyaDpgi1Ungc0UzhXsV/skZI3t0DBzw36KIgxELaXY7/X3jTDSrxncfxvU3oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/TS8tNGoLA9FbL9cJk9BUAsaWPE8N+qdILe6u3yhow=;
 b=UP7MkdpGq+5hVwMBAv1I5zw0PtFnbKpXaWokW59WBYwDDMzbOorR9GqfPBQ9IhTtWlYnMGBWEU/lZCt0WzX2rjthTzLXpNMcnTb02aPDLl522NmVE2Luk5PvCcK62Q6sTalnc1Jts0qO75uu5DVmb0e5g3GO7nks3HXDoTksdV3rWR04eGd6K4+HVKDSbdkzmYcudPf5TPjqmlWxroEdrHrnuQ9u/rgXCZxyvVj394HY6vP9SyoduU9xmjY3g8i6YpIfsgEiNQkFD6s3wqFFzieAy/uoVNkTzEpOiT3n/SThyxOPrWE5ubSxryYch+yJ1SmRV873+UkaNkdSL6fhQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DBAPR04MB7352.eurprd04.prod.outlook.com (2603:10a6:10:1a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.8; Tue, 23 Sep
 2025 19:45:12 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 19:45:12 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 phy 02/16] phy: lynx-28g: don't concatenate lynx_28g_lane_rmw() argument "reg" with "val" and "mask"
Date: Tue, 23 Sep 2025 22:44:31 +0300
Message-Id: <20250923194445.454442-3-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 14d24a78-fadb-44c2-fdef-08ddfad9b436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xHzdn8BQpjYxV+qpLUVX4lT9G9+pskqwvTxGsTcL7f3THfW8rI7XN1ACvEnI?=
 =?us-ascii?Q?oJhE+oEB8dlWamNb9NinAXAaWuWZGU0mcWAgWDgZtrNflo64fZlUJ2wacVhf?=
 =?us-ascii?Q?g3wxquev/rhtki8PbC26reqdtI0oZ9kLxZeoNpO1lVCCPgxvCXQ8PviS+smz?=
 =?us-ascii?Q?pl1UWRzMlN3Gf4azpPuXX/cHgrE7FyHgMtnKWn6s7HKEg57vdh3i4aDVR8M5?=
 =?us-ascii?Q?EPGFiDDSngG/8TP6qvS+3u90m4fl4/WvkYSZcoeOmWuKEEuO7UQp4SCrc+6b?=
 =?us-ascii?Q?x1w7Ze4GtIxMYEt2mTpVW8RlH8V9JrI1v0s4WM224tHuS9vezBeolPAIsfPB?=
 =?us-ascii?Q?ds/NsPHRgrgRZETcdNICIsgYuFIAPh4Eomg8pvFhtctFg16T8GExhRzzofk6?=
 =?us-ascii?Q?WTtIiROlqx4ifXlBVZwUfee0x7zi1aNMqyyos1zYF3W3V7VcsZnugF6tWker?=
 =?us-ascii?Q?E25f8Qour129Fg6YC6CJnvXJ611j0BWFtJgxCWj28OU2C9nN8xPLVEbKeYuY?=
 =?us-ascii?Q?ra4Xl9kLlDKAfRU+2BfCyjXD0Pysuzxaob8BsIci8Mej3+QYBsaJzbRwNHd8?=
 =?us-ascii?Q?5Ga0kNtRW9VtidVv6vV5BRAJ0xqFSVcsXivsWHVi/vzplyY9DSrQEIxfUexM?=
 =?us-ascii?Q?Mhc1JQmYUKNBH5E6iZ2Syr/hSQS+bFh47YgRMVBrPRHDtKKBDtaTr6vWArja?=
 =?us-ascii?Q?z8m3D+nMwdGr/S+kZpLNe5XaJezN6Nc77QPMPdLT3SVvE661eYRzZqQB46X0?=
 =?us-ascii?Q?6LBHvGxnKby4nSl+5q64pZFdLBdZZCIqC0vNKaSRfUUDcSOkHuQDp0J6ooJU?=
 =?us-ascii?Q?MieTAQOA9thnJnbq0yyzme5zqa3ayayOmxXqfgas1B9u/aZUR9au+JzL0iy2?=
 =?us-ascii?Q?LFWXgVDfBMpnAKyhlzzgmoM5jb9Iejv3RZW3g4iyc7tuvMWIZZ40ct7x8UP5?=
 =?us-ascii?Q?PhKpfPVoRHBCrQn6XJrPfr4pQaqk+w5Bc0wY6RBBnW1TF29bPNdrE2No4gDa?=
 =?us-ascii?Q?O31yjOHECYkwF4EsE6vIf9sZuNiYgg3GfB1UaKtSFb4XOu+Dv4a1UPLKRXgl?=
 =?us-ascii?Q?yyls0vcrMXyExfZippheLwNvO9mkE7wdfQfN1IbN2WRktGMhMGY781seLzy4?=
 =?us-ascii?Q?Skg0yhR2fLLMTHXrth3Dk+vaexW+XZ7yHkn4gMENkmVUwhQmnRm2ll5crDZR?=
 =?us-ascii?Q?bWw4OIAXirSAArzl7Qzpcl4MQQ/UXGE5uFIT10pJd0oF0m4NCRcmETQdLF47?=
 =?us-ascii?Q?hY+Y6NzwA+lUeANZsuOZ5XQFEpB2XuUO6N1c3hrh4aP9ymHvu75WrQkGltU+?=
 =?us-ascii?Q?pyzVM/a6IZQz4UO84EjmtyajJx23/vsJRYpvw8ClA5u7m0w43ggLfV+EIjoe?=
 =?us-ascii?Q?8zblBh60z8Noyyoupg79SDqOMGnHR+kOsPh4/Q2jljkSM3ZY1tSto0noUjxc?=
 =?us-ascii?Q?bDEJOydB7Zt8mUjU15ErJzyRUB0qJDjD+aDHANFCfqF5lZ82T+g7jg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5iNHZNtZso1cYbW9AAjWf1Dw54hjgRx+yu+wyzAWvfbR0yoNCsfANfuqtzqb?=
 =?us-ascii?Q?3BcXJBQKQIbKTEm4reipnzW/RQJBY5h1Goiut0oN3MLx4L3CIiuZGfu14tNQ?=
 =?us-ascii?Q?XI6eEwdGqPH74G31/y6gA1aS16HbL7jDBsJfu5qskVGWszcLGEIALnLJyRRb?=
 =?us-ascii?Q?kDDWB+rC/4wdibBllzPVUOI6hRzabiCjsYSzZlv6o8VKroW/CcNCNUO/H+NH?=
 =?us-ascii?Q?PeUDBPC6nU+0AKi/nlQWVxTU/JMklXD3ATlPLJlHwz+yjq8/1/4sGgH2Uiv0?=
 =?us-ascii?Q?GJX3sybwTDmmmCa3236ugNwYQEzjdYXBT/cxPrFT4UhSE0we47xaDdMLrKDJ?=
 =?us-ascii?Q?f9TIJW9LAyLinoH9SxN39LrAATbMJUQnHCGN/GulevihBRL0tsalPjj6DXwU?=
 =?us-ascii?Q?OrwATty6tT5Q/r0oWQChEvefYTeQHeLXLGPCDbG0VPXhh3Lfnwl3b9Q2cVuL?=
 =?us-ascii?Q?PtJTAY53S9XgJcvPBYG2BoiyoIGxNT17FQXby43tEkA361I+ZZR8XRC7QyoZ?=
 =?us-ascii?Q?7Sy4M0nuG6qGu2S+oEQVZKpsrHU2MdSyFRH55HjjhGZeGKVnJl7Lgam9NbOi?=
 =?us-ascii?Q?UtAYIp+s6xD9oGjBq3BkYWK94nwv4vRHdrkOBr8nbDUpWLvN8WFgihUm1up+?=
 =?us-ascii?Q?zAjv1OdU0XHJH9VSl9EfXCGbglVFtrrTWsaMtZ1DNurjpH6Os1ceyT8yo7LL?=
 =?us-ascii?Q?RNNEl5uJBUYMvQ1ZN1WpxpIMgW53tEEjwtOb7QTkzwpusQedT1BBN2JjkQAq?=
 =?us-ascii?Q?JXI++sNvqRlGNa0md1riHI/nlStbjrgRyYi5h7IWP6c8+uVGJYgOdVlDmT7Y?=
 =?us-ascii?Q?eWXrwx32mVlWLr2l4bB7hN35XKU+DGdWIUHXmv2YLm7mr6Vm6wD6X9jHIYQq?=
 =?us-ascii?Q?o2mgSDbIujTZCcF66YDP8nKSsremYobDqStykHSQ2KPYQTGbBRyGXP8/KzHo?=
 =?us-ascii?Q?AIVwEm57L0w5nSLmsMPVqc5OTLu3k6cXhuu0SEcnYnVwLrkP5c0ASuFNBkA9?=
 =?us-ascii?Q?ySl6GqWP2PXh7yYCpxwPDhnhP9q3N4sSsliIPyhoJ7l57GS770JVR7EsuQZD?=
 =?us-ascii?Q?o3fVKvEt8n2DXLX1AbaGBumfmlExK6O8xi4s2vY7ujCxIy4GjDDeO3orQZwO?=
 =?us-ascii?Q?vQImAgaMbhhRAJ8kM1ZKtbI5u+CVKbTOiOWxo8bjoW+wCGTcS7QR8RqWffem?=
 =?us-ascii?Q?NmUX08gSQyLwc94Uvm4n9djmM3hoMd8SjgkEeFeQjR3vJa1tDC2bBYUFp+lM?=
 =?us-ascii?Q?2Hri1fyXbhUjnv4SJDm5DmVoZJ2+vaVMeXMVyZAwitP4fHWEIw0sGP4U7UAg?=
 =?us-ascii?Q?1McCxU6U9hhzK8s5mLAHh8dqY9I5Fhwdd9O9il3p6eQZBffHvzo1Y3su7KYQ?=
 =?us-ascii?Q?Mzk5zABV8GP5j4LHO6UZCboFa+Md7d4+lvIwteuu5TR1PB8mi+WxV8AbLKri?=
 =?us-ascii?Q?kLJNZDwBWNTuOMkQ8e/KoViFJdzRpsinDbu5aFHUQevl1zZmBlCzNm1mrrLl?=
 =?us-ascii?Q?GcSVy3xZ0ywJBaUr30yA47L1/sw3MNSaOhwXlbwdJvp5fQYO5E64iszXC+pc?=
 =?us-ascii?Q?7xmE0on69rixrYNyCb/3ZqWWoSLT6WL3o9xbXRGBExDXrL9KiaBiLDmDyuoU?=
 =?us-ascii?Q?pA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d24a78-fadb-44c2-fdef-08ddfad9b436
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 19:45:09.6718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vup7HLjOJQIS8S9kca2DLetbeX/pwgrmThjNQVf9bD2oYOdVtzrDy3iFhvk4g5f+9Y5uYfjoUWZXAZhfoz/hBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7352

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
v1->v2: none

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



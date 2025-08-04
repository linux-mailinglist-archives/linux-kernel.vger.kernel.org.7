Return-Path: <linux-kernel+bounces-755209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EDFB1A305
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DBF41646E2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B805266574;
	Mon,  4 Aug 2025 13:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CgL5MVsB"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011001.outbound.protection.outlook.com [40.107.130.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567F9269CE6;
	Mon,  4 Aug 2025 13:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754313324; cv=fail; b=pkDqiiyPz6Xp5KWHgh3cK85kvJZRDd79+r8S1ATQ5S4ocM15nBK8ljStnLYWr6OFq9O9JAaeBsM/eSHXUJGrTcOQdkwizHrqc5iWkQhOqDLFuL2+5sy0epFTN0o+dwhdltI9EAJ2XI+PBme1gcZJLI3R+Z/14HhCkcf5ZAP0kKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754313324; c=relaxed/simple;
	bh=0qkW2TRkX7qcrM8+NFUnyaXxIUC+1RkO3wmBEXZRhZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UbKlBD0ll4bwg+5MrMSnBoaQNH2OmvoTBHZt0rqbNCV489h+5bPxdAlVOPLoUrcfJrpXp2cnzRc022+BM2Xo1CXKPpMCDNkJp1xOwYuBRZmSW5tG7dsEv6zevriZkhdVmC/6DWqdPJXBaH2bho2uGoWrZGIVwsS5SwM72vjFv5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=CgL5MVsB; arc=fail smtp.client-ip=40.107.130.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jipRDM7YKoA7GecyBvFSFYe7G3RMsVl2olaUYJwjVUFO9OgROukv7HU9ta4/sRQu12bDWhd3OCVfHIFKgSL2dbEzxh+pgVcm6W3eFQovCqqcLE8Rqr4/imsS+FlhbnQa5u6GiqLudJV3Dv7Zwoj3futTVe1p30PwutU8/X+r32coNc+Q5efErjqt/SrpKhDYuf8pZU49dzS0DYrkzai19jDPzwZbqx06/5FDt/gOie7MuDAEsMzlZdWOqxG6W9NT7L6F6LfkS3c7CqJE0S6v403DRZ/MztppXT5KDhqUm513KxOr4HsP7b3KffDI08wGtohN3G7hxVzdVMbGjB9mhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+wyhR3gUIQ0577MM0yHxcA3SkX+Sznh3MJHxbR1Ijc=;
 b=qRjtKbHmqAlZ1l6w8L1zZX9dFdgDE2gjICc5rzjIeGOq4PJRgVznsQEGgAW8haFVy1RLqZHIcX19YMxrFS+LTNoa8RxM/4UN47eIbgppoe6klLTeEQMwgTlst6Hnz9lWzUe7sr4M31LS4Sdh93LtL36+mw5S9n0CM3Hd2zxiGFb6PAHx6KxxOfrd69ozgMp9AGW1fRZfrW4Q4AvuDszmkM/pQXBVVb/YOWzSM1DFZy+LNVoKQXIpUbaHhfOMZdzMYHlM20jr1WrnzCSFewhPNYRAV58ey1zpVL/BopLVGpaRHUkVkFWThiNP95ivuzRQmRTUhF2nyXhdT8YZC4PU7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+wyhR3gUIQ0577MM0yHxcA3SkX+Sznh3MJHxbR1Ijc=;
 b=CgL5MVsBzweXB57GXNQps2W2Rux2mdUoN9V/Ieo/bv8uDVQ5HyAgB8RkMt2SjOqUd/7O31Jas8mpw6gP/hzWLXg+jQsVkPvP3a0vefukxF+jr+qOR3y+lyqAVRX8xjwEsvzXmjwgoAKRMres5JCBfK4NizJhuT98wZQ7k4apQgtVvoz2ZiWQIo/pMCvh52hPZH2sKB8o/iL3vylCCghhIt9eHXKGDmZyuCNikwfIpjaH4FLxcbASOhEhLIEUnXiNLsGuBAXxEX75lZiVuXNYDQVfzjpIYkPKdIMp9cKvAIuYAgKGFddPF5+npoA102+j8MB2wNqLxqEr0CrqM3+Kww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by GV1PR04MB10349.eurprd04.prod.outlook.com (2603:10a6:150:1c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 13:15:17 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::b1f6:475e:de5d:8442]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::b1f6:475e:de5d:8442%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 13:15:17 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: frank.li@nxp.com,
	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] clk: imx95-blk-ctl: Save/restore registers when RPM routines are called
Date: Mon,  4 Aug 2025 16:14:50 +0300
Message-Id: <20250804131450.3918846-3-laurentiu.palcu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804131450.3918846-1-laurentiu.palcu@oss.nxp.com>
References: <20250804131450.3918846-1-laurentiu.palcu@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0040.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::28) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|GV1PR04MB10349:EE_
X-MS-Office365-Filtering-Correlation-Id: f8ee0ac5-5387-4bee-0b05-08ddd358f47f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|19092799006|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x3IjrCG3/kQKsA8Mmjw8LSv/a89E57eOWwkIr+WR251G6O/Ks6qmbGtCKUAg?=
 =?us-ascii?Q?sRc8fDIPVyh/er9qaaszg1P8rCv8CLvHDEnE7X/toljamjNPbe1ZX3JXj8hK?=
 =?us-ascii?Q?bhtY8BXSmZzWG/8GlL2HQi4QywbA4bzf/Yxy0UGBAn6PmequMOfzsUSsV83X?=
 =?us-ascii?Q?JftjktZ10g52JdCcnL20+BkzGeSL9EOObzLnXQQGltRZ+WJWNsQIFpcP+swC?=
 =?us-ascii?Q?tXMBwl1atnwasfOa0VVsaALrn99vWIhJELR0kJ7LgVMYdXLF4DI+0hlMm2yo?=
 =?us-ascii?Q?N9RQqXOstAKrEDyTHiwuq7N4P8NH+2EFXnzUIFNKjoQed6yoNhOXIdxAORLK?=
 =?us-ascii?Q?q4ucYBEt6OzZzMOvmOvmK4x38hKjSEKHh+mmNbyqunsAnBoLqvHQg3OmaYja?=
 =?us-ascii?Q?Pm0Boq4BEjlQzL8mqG2NBfCtAZwBmFyiMoCbwSGqRv6/nMQLvfYUKx6jXABP?=
 =?us-ascii?Q?yjB8c9u26EGChiWTM1Xty2rmzf6SuBRbZbbAyj3UtEvEW4mhU0KrOY7vlhAl?=
 =?us-ascii?Q?b6GNXsNB+R1KO3BeRIQwlGPB6ptT/5DsiCQPu/Tx2jVOwyzUUhKl4yTlFaHO?=
 =?us-ascii?Q?m/n6FEvHcz0JJlDkv3rB3GAVItEnKHQYhrjKoz86M2TAFaATiaDEILbRrMnD?=
 =?us-ascii?Q?gNpruIQQEypIMevLKgsNtPpocgO6v9ceyAD2BeLPRMsx6dakshteB/jGA5ao?=
 =?us-ascii?Q?xxGRvvyzqKfUzqgUwav7exte0AY4ept+ALqKs6bn/Q1wN0Ek6qfqWfCVu017?=
 =?us-ascii?Q?0goGzTzCXHE34ICAJEKtQqiS2yMJmY0BTXOH2TkTkZZJ4+qiOpkl0VbtnJII?=
 =?us-ascii?Q?9XHbDBAfgmSE1+CT+MEv4CW65SRqhDX3K0P4/K/Al/RE3dgwxESHpW6YY8EW?=
 =?us-ascii?Q?oXO6rsOVxgDlPQydIY4R6gqjuj7x/Sycythdlwyr6qWQ6Qy/2V5+J7J4Vzet?=
 =?us-ascii?Q?EkFnPWihycKPft7rb9B414EFGK2sQkhFNF1RGPmMa7C/RfLs6Zob00tFrZG1?=
 =?us-ascii?Q?71o087lJkqRbX/wkUesvlnQGa90pdz7QJt/XZlw0troE039ziWtZgyoZ6HJU?=
 =?us-ascii?Q?ytgO7MLyf868NCfvhCrryVVGorXY26kVTlj2dtCuSB2pri9JRAH1Y4hzoDxS?=
 =?us-ascii?Q?d5QeAaTtrSFgjHbKiHAU2sw+P1OVUMZRN6YLZ+VwS8u0k+1dvgKdCmzZmZvK?=
 =?us-ascii?Q?MjV7zQNAkUNx+tu5OhY1YG9qDlDx+mr94oKMBaaii0ATlS7e5HDYN7sbJRcL?=
 =?us-ascii?Q?Dj/Ec9w2/F0d0YkK+qYglY4YwGzJBrHJI/Ivz2uRvRrCsOnOtnt1eTYbrHrj?=
 =?us-ascii?Q?tKPomnfpFU45cmNHRaKUUZ+b0HRMFhc23HGLKVx1cvWwNJre4nwwLhJlfJRl?=
 =?us-ascii?Q?F8vt8Ehb6pjv4ydUFv+4IjYhL8BYYNjsgQzuAgoziy3GYu7+Pg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9135.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S4aIr5nCqvuGrLxl0vVRUo23CaaQ1kw3JR/g1w6BWw4OWSZviMemppNGuEV8?=
 =?us-ascii?Q?XlNDWAbaDUpBZxvDkKula6f3+8pfTuip6brOOgikwom9eL0J3MS9kxQ1aInE?=
 =?us-ascii?Q?7vT0ALoz9bEf/UZH5CdZukQpfZzSLFUXzLkPTjIvBgpLGz7UiLXe0VPxER4O?=
 =?us-ascii?Q?5diB6PimbiX+AWbGUvlj1eH0bsGQgr3B5JA2jMklaY2NMf6STNbW5FshlysN?=
 =?us-ascii?Q?qCG24Fxl9h/09kP8D8RMtTnrDkLaoOM28XpxURd77RhMXQ4vZDye7u8njJZQ?=
 =?us-ascii?Q?d3RHskEi4LM5esH2ExL5ck43emPM/lDZShKLPLUF9uvkxniRAliq008LXJlh?=
 =?us-ascii?Q?iNBRZvuYvyih3S5qoR977iozU+F6cnTH86umAgM2HyJe0z5dYzZlKO3RxcS6?=
 =?us-ascii?Q?/bFbMO4X6KS+kogoOlBliQ3Tnn7H1Rg9DMcKpzI+e3HD3FUhlYumIFtFmdRU?=
 =?us-ascii?Q?LgD4MMZhtRrg1w4qye4WA7Av9VR+/K4bVhiUy06xQVJCey8tKiFFZAspd3vC?=
 =?us-ascii?Q?+6WhjzhYuIbBh3i8ATJhYEhaxmZriGxNEzKWCJaUNkASj97pYV745cH17M//?=
 =?us-ascii?Q?zt4yl0/f4YlF4BgN+U0NlUrzfLnG65IWeNYer68BntkGIyDGfCe5aikp4PGz?=
 =?us-ascii?Q?ppsACjJeRU1F5lndTPmXy0HqYF5jMc+DCCSz2BLqbeg1FWmN6459lQ4J6urJ?=
 =?us-ascii?Q?wqTIfDkO2MfZgimFnNMvmZJruUE65GMb6PHc0Etis+EoL31bu/XmGbpM0Uay?=
 =?us-ascii?Q?v/cT+1L4AVnvox5EXveB+w8kAEaptskS89yFvqnCEuRFg/LO9FHnnrcq5/DE?=
 =?us-ascii?Q?jk8sWrKw43PyEFppALEX+pkW6djca+14HNfGVLbaFCLxf0Bd2evsb8h5yLOe?=
 =?us-ascii?Q?xN467fUxvaBwRafIRVQxOQt1uISWBcqWZI/LrA9eSn1+OU+3l8QOf6RkQo4H?=
 =?us-ascii?Q?PZoTedUrtWlwt8XC7ZlOrdKkkMpR3cDQ9QP9GjvTlRZ2ZUjd8G4Ool1Gy/Rl?=
 =?us-ascii?Q?pZs1pGY3iJZ4/AzQ6v1A/1cM2WVDlVJSRKefxFbwdttdJbKsUfaKTx8Piq1S?=
 =?us-ascii?Q?GsvADA5nzeVnt/CBb0zk8GmNOlnrVCx5Gi8d7gR0lmwsrjBACNlDsmlH4Bpz?=
 =?us-ascii?Q?yR+uJ/U5AG6wEKQBLkXMzpPrPxlL3zV9XMeXZ7sDdOlZOW7hcmGItLDeJn6X?=
 =?us-ascii?Q?ovQcYi46tMAauxoJAVqFuMYlIM7GXlpkVAbpWQpJtqnYg9KpmpLwiyRfna4k?=
 =?us-ascii?Q?9PZ28GnTdwGJ2GcHoWuMmiFqOCHwt3lkPaeun79y6hs30bzOICo2fGNycwlC?=
 =?us-ascii?Q?4LgSf/a/mggp661Emv0hcZu89WgjGp+627kO133FvrIaYzBDZTRnmmcZ9vi0?=
 =?us-ascii?Q?NdE4/Brbl2dyWqzxUnxr81XBFanUMfISWS1X5S/li0D9h8vnq6nC5ELkBRMI?=
 =?us-ascii?Q?o0N31lfXjuOmAg10V7jr7JZt1tQLxYrpSl2ojWxml2qd4DiOzGMgHtAUGM1e?=
 =?us-ascii?Q?xAPhgkAEh0Y+0Ds9OH6pFoKHUWROEdQ4g1QYAA0ALoIGTSXkPwZ/xU0gTGZd?=
 =?us-ascii?Q?8J23nSBoVJnhMl1AIZOprihI5G0vBQMD60DHFeAogWz2O+xpk7WebEm5oNKQ?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ee0ac5-5387-4bee-0b05-08ddd358f47f
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 13:15:17.3271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vn31f1lUoDcMipA0OTF+bpQSg5P8Nssl16lPvNchqxKqNK89lHg5gZsq6bZ4iGnDvV9EyzFyDpC9Hu+gHpyd8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10349

When runtime PM is used for clock providers that are part of a power
domain, the power domain supply is cut off during runtime suspend. This
causes all BLK CTL registers belonging to that power domain to reset. To
prevent this, save the state of the registers before entering suspend
and restore them on resume. Additionally, disable the APB clock during
suspend to minimize power consumption.

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
---
 drivers/clk/imx/clk-imx95-blk-ctl.c | 33 ++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/imx/clk-imx95-blk-ctl.c b/drivers/clk/imx/clk-imx95-blk-ctl.c
index c72debaf3a60b..56bed44719954 100644
--- a/drivers/clk/imx/clk-imx95-blk-ctl.c
+++ b/drivers/clk/imx/clk-imx95-blk-ctl.c
@@ -453,15 +453,24 @@ static int imx95_bc_runtime_suspend(struct device *dev)
 {
 	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
 
+	bc->clk_reg_restore = readl(bc->base + bc->pdata->clk_reg_offset);
 	clk_disable_unprepare(bc->clk_apb);
+
 	return 0;
 }
 
 static int imx95_bc_runtime_resume(struct device *dev)
 {
 	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
+	int ret;
 
-	return clk_prepare_enable(bc->clk_apb);
+	ret = clk_prepare_enable(bc->clk_apb);
+	if (ret)
+		return ret;
+
+	writel(bc->clk_reg_restore, bc->base + bc->pdata->clk_reg_offset);
+
+	return 0;
 }
 #endif
 
@@ -469,17 +478,12 @@ static int imx95_bc_runtime_resume(struct device *dev)
 static int imx95_bc_suspend(struct device *dev)
 {
 	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
-	int ret;
 
-	if (bc->pdata->rpm_enabled) {
-		ret = pm_runtime_get_sync(bc->dev);
-		if (ret < 0) {
-			pm_runtime_put_noidle(bc->dev);
-			return ret;
-		}
-	}
+	if (pm_runtime_suspended(dev))
+		return 0;
 
 	bc->clk_reg_restore = readl(bc->base + bc->pdata->clk_reg_offset);
+	clk_disable_unprepare(bc->clk_apb);
 
 	return 0;
 }
@@ -487,11 +491,16 @@ static int imx95_bc_suspend(struct device *dev)
 static int imx95_bc_resume(struct device *dev)
 {
 	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
+	int ret;
 
-	writel(bc->clk_reg_restore, bc->base + bc->pdata->clk_reg_offset);
+	if (pm_runtime_suspended(dev))
+		return 0;
 
-	if (bc->pdata->rpm_enabled)
-		pm_runtime_put(bc->dev);
+	ret = clk_prepare_enable(bc->clk_apb);
+	if (ret)
+		return ret;
+
+	writel(bc->clk_reg_restore, bc->base + bc->pdata->clk_reg_offset);
 
 	return 0;
 }
-- 
2.49.0



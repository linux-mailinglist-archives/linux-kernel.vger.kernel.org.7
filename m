Return-Path: <linux-kernel+bounces-801185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D83BDB440EC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF561A43D6F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D27630DEDF;
	Thu,  4 Sep 2025 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mZvc146c"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013019.outbound.protection.outlook.com [40.107.159.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D122308F1D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757000676; cv=fail; b=JpR0Kq5i3OYlZxvmmOTiBdMOpKWBBB797zumGAzX4P38EB38el0r6L58P09nZuTzdaJiY1wBox7UgkJCjBU1VfI3aX6Fi4hFy4msGXY62lG4/KXL4Yos+vwHNre64HFQSu5xuesXYRe1daO5uWwx3RwN98V5/HByqYL+s2Y6wkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757000676; c=relaxed/simple;
	bh=n/T1R/ki8c1NVTJr7Ptw3qTJjEt5wEUDYSBZCTMX7CM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zujkqf4c6VN5CHfId3r0QmUB94zuIdU42z/pHrFCAF1OART8aI8U4WiG7KjkXFQxp899ZJrvDwL3BL2zwRGh1w143EJHUsX9VnjRo1ay0RP0ROmUtusIGaJf1+zaci1mHIRnuy3RAmqNenea/q9Kb3qmNHqQvaga5WxfcOAKwk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mZvc146c; arc=fail smtp.client-ip=40.107.159.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+ffvQ1tPVWvNGCJKGzU6CKE2aN+b71XY8rXVnY/PV3bO166jvxRqj0rR4nHK4YYCOU+B1kqqfoE50H8wEnL2rGpMNn899GbxEeBqixVfEtMrqVchXNtVgQO3H1wYNv6xUz2bTa+B40+t8UciU92TVEC4FKJuvJDNzX8ZDG63HoxmtIGS0lajpbcdlr1W0VyNUVGO5I59uEFvIs+lSUIqLkjHusQPf1eXY1DzyMLNMh/PnC+wPJhJTKv1zW68mGGXcPf+dH4/w/1Tfhk9Q/OP9vGLT6vobNxCG6dJMFyXv3BixFQgC3zCtWcXD5+Nvnv/Do3fijgH1RG4klZ3zvdjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivxRGf7bD7UlJyHIfJsTPorNuE1Mj4/1Xq5Aw+YVRT0=;
 b=X8SdhZDISIhPwR6lEZHLroc2y8wZU6Uys6eiOKIfBQG67BzNkoxtrys/Qb9DuTMcWl8oPTtwtIAiNQlIcHgQY9dmLXIj09Jsl5BHuGzldf2BUtTColWU7gudZEj+POrVcta4AQxtVOFsM6z9Aaur4hQqOkO5bSrHdCOOd3T17H1Qpi1w5Mu0SuNugr4RBhVDg9sgkRKVhWj6+nKwdnJsqPHKmAlAdNKTXbkimV+JtnSXZYtAXyP0rquI5awwPcTrUQd85K1/lyMeRhmdQ03/5kc3PD7jHsV4GYsybsLLJQwQVQI5bo1O+EpWrnQrXoc40u6hG//ubNTBwA3FzISPmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivxRGf7bD7UlJyHIfJsTPorNuE1Mj4/1Xq5Aw+YVRT0=;
 b=mZvc146cSUodTJsY1JtrntNDEjeJNO6g04/gZs6dm8ty1ShhkZ9DFJs36d0LFGfQHLF8+ByKIrCg6WLHTVPMs9CGpnlb7o0IjBBPk/XjYctUz46bUhWXsqc6QbaDl4rO4gdSo7FpAekQ3a2x/z1bCBZl+J0GiOYcNVPoduv+oXoIKg9QMyvkh+i7CSKm4MDisiINi0gGWcdh3XT0AuNufywK/p9vsq3hXgUNZCVIn0WsOxVu/ZuzCzejuXcjSuyckvvEf3qtfTS3vhIp4He3hLhfUMAISkB73tPFH1TK2zszO4aP1UGTEt+LchUuRTX3/z7tfZc4B+KFHft0ML6IwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB7635.eurprd04.prod.outlook.com (2603:10a6:20b:285::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 15:44:18 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 15:44:18 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH phy 06/14] phy: lynx-28g: make lynx_28g_set_lane_mode() more systematic
Date: Thu,  4 Sep 2025 18:43:54 +0300
Message-Id: <20250904154402.300032-7-vladimir.oltean@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM9PR04MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bbc3864-b3f8-4936-a49a-08ddebc9e721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7z4vm+w2AcYKXFz7JjnX3g6L/nayB+lq/rP6Ax63yMKIf3MWC2k42waP9i3p?=
 =?us-ascii?Q?pdNbhSqXewy/VlDhNZZb24I67eiYq4IymmPPCb/VwDxiYP9Vrry0LGMiVUFC?=
 =?us-ascii?Q?/lWeXbTPIcv7zMV4IyDH17IdSGqETNCIaabxWiJPV76I42HXwJuhyjjrnapC?=
 =?us-ascii?Q?TnKbhX5GLHYOW8nx9IDWqc3qGe1A4hwKMgTCNV/spZ8MN+X5EeAUAZhIx2/d?=
 =?us-ascii?Q?+Ajnjonq/rmhKTRNvlNyTPmM4VRpqMx9gwjMFNITDezAH0fHvskBqyBc0WSd?=
 =?us-ascii?Q?5lltguByAquKZGZII0E+llUKm2LsA9nFozkF7L1956S1EyNBkQf0V8Ug/h5T?=
 =?us-ascii?Q?YBJqbYvZHu54/HpQKQo3K+1nChLIjL+9UM7hcs3ppp7c4IpwyeCVB1HQZ8Tb?=
 =?us-ascii?Q?tDq15Oa0cMqwey8RFyMp9H5dSWuQq6byYmC3gmWYumd6+ACfXhlDgtq5j3vZ?=
 =?us-ascii?Q?gT3YPTlWf7ulTb/ECuIAoTnFCSgaABqL7l0o/jOGHMAMECWQSZ9S0eKugsgq?=
 =?us-ascii?Q?SL9H7m9MyfboEOgQsglO/oRLFzcMQ4UMT8+59lkdBa07lVMU02j1tsOvtRtx?=
 =?us-ascii?Q?KpJo/zwT3qQaycZmIXWyzZSAlxkCx+gWgzrHEc7aJA11saKDj8r+wLGGZGeQ?=
 =?us-ascii?Q?QGrIokNuUdkFyBODYD7IsuQf7LmzxK0zh8t2kHjTtD2kALtickHKHirVEO2X?=
 =?us-ascii?Q?wuZCwJYtG0NcZ/xTEHk3D1eK/dKLjjrjrcteQxXEXKRjfZRubeXwlDmTyAof?=
 =?us-ascii?Q?BWZqA163wjCyFIqjDQq0B4fau/ypdxlOw/dggIa/76S3lFhKx2YfIgjsefGf?=
 =?us-ascii?Q?vx7lt9m1la5PZH5+YslPqyJkQqnWftteUPbEvJDJz/jd3wySlu4iWRJQHxAR?=
 =?us-ascii?Q?uzWCE/r2HnV+H9mpu1yOZVFGMuAMoprCFSIZVdtAUTPofF91VxPaynh6Coj1?=
 =?us-ascii?Q?pgAzvpdlM3rEPxAFiYNLBbuZ+xDV5AeCsVyQj8N+ArJ3Ld1QgER9a4kekAXt?=
 =?us-ascii?Q?PHnUVOt8QIblTMawMkwRlauEb1osWGibMDp98tqcUhC0XRW7t0KZLkb8eafC?=
 =?us-ascii?Q?QdBKRYrlC4njV81VaHJdNJJlPT5nH4pX8aacMm2vmh7RKeZ77aQfveTlwpr7?=
 =?us-ascii?Q?Kh+uHP+0gkSgMx83bpE5pBgyfR/dYJmQcxBObF2KDevy0UJMjL2N1ow1Vsbw?=
 =?us-ascii?Q?lERganaoGFXx1n+2PF+w1p7vRHG1lnQxXjvnhuge6L23QnYb1Y//oOekxqn+?=
 =?us-ascii?Q?q9nes5RGQaC/BsEh0PCv7+JsIAzPfr5iN/Fzjzwl1ZYjSoGdlqtfDNl2ye1u?=
 =?us-ascii?Q?kc9u5YWSGVzYMTfAlbeCK46QIWjg8frMx/DR+7yGy1fsgKXadbmaYMx1LGNs?=
 =?us-ascii?Q?EsndljYpH0Pxc7e3V66jV+4O2c0k2VkDPWHT0mqQyKNXJUtMCrDCT6YDL1uO?=
 =?us-ascii?Q?lgeu/M32oc6jDrM9qZ4MG1WIOL/FmnroALWmANlETqiTE3eEUv9Uqg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m4vfScQf6P6pkQGhMuQPvVqhRowokS3hL5yzu0lgLxXKCZrVbChIbsLPSvdT?=
 =?us-ascii?Q?cA151yPy+tT1GvyaEChYTb8dZ3Ae7U8GjnSmtzTam43c19N6+4jdY10OBQzF?=
 =?us-ascii?Q?kDZY8Seh0xDZ7eJy228aphB7sa5S4LoVXektNYQQ4b1RE1rJ0MeYPqbrygbX?=
 =?us-ascii?Q?1oA5wH1txr4h80N8o3ZoZ+wsBkM0QQtprjQdQ84vuJr6Fum296T5FZzkKyvD?=
 =?us-ascii?Q?rTD5N+U10xWn5Clmmo7lZb2rBF9j+4gZOHR1vm6poiNg7O6hi5+sx5AY1uV6?=
 =?us-ascii?Q?aqOEtAXkp2PSC8BfoDkJoCXlZXp+koiaQUWJSoGIBTZfw1CqputtQf0qNLDf?=
 =?us-ascii?Q?3Ut9q9Kip/D8mXKgjFPOnH4yTJgiMp660Wzw0OPhIudxs4/RlACDyGWkMbLR?=
 =?us-ascii?Q?kzkdJXCRs119OGK+XSMk96ceyB0+IY3xXd6/m1Yk2lnu5wwXD786p8zSEM/g?=
 =?us-ascii?Q?jLpvgWY5iTM6zCPYss9hVCPiVoHICziiyJnNp1+YGJJ4kpjiEclVJkwTQ4m6?=
 =?us-ascii?Q?LT5xTyKtu0socWm35ZueoiqRc4lz1YzxhWUz9WAUzrloB2Zo2x6B1X/QmZ79?=
 =?us-ascii?Q?QxQMPzcAh9Y3+souQAGvUVel3z3uWm2+U8zoLdJ82tgNnGkN5jbDYL4gbfT1?=
 =?us-ascii?Q?w7wnNpI7OjYt1T9jmO3HPtDqQWGVgjBeJqjLusCGaPK7o8pz+dffUehbj4W5?=
 =?us-ascii?Q?dk2O1Wl/w1kXdBve/WhOXKMUGHkPHxr1CTSf6jIc/MxGJINcUzJI7wAOc1DS?=
 =?us-ascii?Q?CVBR55D5UqswEXh4pASv9ag+IaQcHCxjCTneeTs1M5VFV5k6vx6DdPlwUxqP?=
 =?us-ascii?Q?op2C2ljmfzTmj1na2XgnADugzWP9zm5kSp85Yr+ugdxgo7Kx3XJ0TPtyDta4?=
 =?us-ascii?Q?LR7rOuVQGGidk6wcJJjaeKHtewUYYcObo1GwITPVWMXKOHFGkFqQmc9Qnds1?=
 =?us-ascii?Q?RMQ0Mapi7f+R0VNmV3e60VApMDyzWtFEJe/3tmrE77emmsQnw9Fxo7vV9kQI?=
 =?us-ascii?Q?usrMFZyilIE7RAt2CaBckh5RV0n1J7Jn/EbBeStt2NmWPEEzvhiIHENbtmAC?=
 =?us-ascii?Q?0T9WlC/E0CQNdi3jq7q1hXeFpnELPiMBowtHHaCqrC+0KQ2CAS0EnmppcuFJ?=
 =?us-ascii?Q?TIRQBRFY7aePSxHtnTYTQOtvB16ysWVhC673g/jXqq7kn3qiskLsxcmvZqHU?=
 =?us-ascii?Q?muSvja8LeClIcVTIEoiS7s49WbAe839QmSfbzwDnGa1YMSaKUe8Mltdc9U0L?=
 =?us-ascii?Q?n/XkLQTUWPiBc02BWgxKTEztL5LbrzP9wvB0bssSEXKvWCr9Dgx9lusR0Gj8?=
 =?us-ascii?Q?vheOSQKUfJHgizd0rfiboGA/GGfWTifZvEmjp4jNvscjBWPZaZzJQMpomBGr?=
 =?us-ascii?Q?I4QB1PToWA9urE88G00q+jTNqxO/5/RqU1BShmN8LM2y8qpjYnt+ei5Qqx8a?=
 =?us-ascii?Q?9oCqOUcSWwho9F32gVcGYG6SzX2iAM7QUGTzXhFTViBjMTeGHgBiWsk9MTN1?=
 =?us-ascii?Q?j7CFCT2X+2k/2bTUMQwOBNGi40PnFMdzyKD9sXzvbNC5sbMZI3b4xKm2sn7D?=
 =?us-ascii?Q?oVe89VUPETr2BzUvB3bgQ381OdR2Nt1b3eW2iEri04jmHMGn7M/9ot4g16GB?=
 =?us-ascii?Q?gA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bbc3864-b3f8-4936-a49a-08ddebc9e721
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 15:44:15.7581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xkbSqaUjlWx11J21mHN5CEyJZoT7XZzPg34pFaHqn5fGlvBTnLZ7EyohhdE9GnuBfRA2qfyQOf6gxX7WokRpKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7635

The current approach of transitioning from one SerDes protocol to
another in lynx_28g_set_lane_mode() is too poetic.

Because the driver only supports 1GbE and 10GbE, it only modifies those
registers which it knows are different between these two modes. However,
that is hardly extensible for 25GbE, 40GbE, backplane modes, etc.

We need something more systematic to make sure that all lane and
protocol converter registers are written to consistent values, no matter
what was the source lane mode.

For that, we need to introduce tables with register field values, for
each supported lane mode.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/phy/freescale/phy-fsl-lynx-28g.c | 657 +++++++++++++++++------
 1 file changed, 494 insertions(+), 163 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 911c975040a3..c483c2a80a77 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -12,32 +12,32 @@
 #define LYNX_28G_NUM_LANE			8
 #define LYNX_28G_NUM_PLL			2
 
-#define LNa_PCC_OFFSET(lane)			(4 * (LYNX_28G_NUM_LANE - (lane->id) - 1))
-
-/* General registers per SerDes block */
+/* SoC IP wrapper for protocol converters */
 #define PCC8					0x10a0
-#define PCC8_SGMIInCFG(lane, x)			(((x) & GENMASK(2, 0)) << LNa_PCC_OFFSET(lane))
-#define PCC8_SGMIInCFG_EN(lane)			PCC8_SGMIInCFG(lane, 1)
-#define PCC8_SGMIInCFG_MSK(lane)		PCC8_SGMIInCFG(lane, GENMASK(2, 0))
-#define PCC8_SGMIIn_KX(lane, x)			((((x) << 3) & BIT(3)) << LNa_PCC_OFFSET(lane))
-#define PCC8_SGMIIn_KX_MSK(lane)		PCC8_SGMIIn_KX(lane, 1)
-#define PCC8_MSK(lane)				PCC8_SGMIInCFG_MSK(lane) | \
-						PCC8_SGMIIn_KX_MSK(lane)
+#define PCC8_SGMIIa_KX				BIT(3)
+#define PCC8_SGMIIa_CFG				BIT(0)
 
 #define PCCC					0x10b0
-#define PCCC_SXGMIInCFG(lane, x)		(((x) & GENMASK(2, 0)) << LNa_PCC_OFFSET(lane))
-#define PCCC_SXGMIInCFG_EN(lane)		PCCC_SXGMIInCFG(lane, 1)
-#define PCCC_SXGMIInCFG_MSK(lane)		PCCC_SXGMIInCFG(lane, GENMASK(2, 0))
-#define PCCC_SXGMIInCFG_XFI(lane, x)		((((x) << 3) & BIT(3)) << LNa_PCC_OFFSET(lane))
-#define PCCC_SXGMIInCFG_XFI_MSK(lane)		PCCC_SXGMIInCFG_XFI(lane, 1)
-#define PCCC_MSK(lane)				PCCC_SXGMIInCFG_MSK(lane) | \
-						PCCC_SXGMIInCFG_XFI_MSK(lane)
+#define PCCC_SXGMIIn_XFI			BIT(3)
+#define PCCC_SXGMIIn_CFG			BIT(0)
 
 #define PCCD					0x10b4
-#define PCCD_E25GnCFG(lane, x)			(((x) & GENMASK(2, 0)) << LNa_PCCD_OFFSET(lane))
-#define PCCD_E25GnCFG_EN(lane)			PCCD_E25GnCFG(lane, 1)
-#define PCCD_E25GnCFG_MSK(lane)			PCCD_E25GnCFG(lane, GENMASK(2, 0))
-#define PCCD_MSK(lane)				PCCD_E25GnCFG_MSK(lane)
+#define PCCD_E25Gn_CFG				BIT(0)
+
+#define PCCE					0x10b8
+#define PCCE_E40Gn_LRV				BIT(3)
+#define PCCE_E40Gn_CFG				BIT(0)
+#define PCCE_E50Gn_LRV				BIT(3)
+#define PCCE_E50GnCFG				BIT(0)
+#define PCCE_E100Gn_LRV				BIT(3)
+#define PCCE_E100Gn_CFG				BIT(0)
+
+#define SGMII_CFG(id)				(28 - (id) * 4) /* Offset into PCC8 */
+#define SXGMII_CFG(id)				(28 - (id) * 4) /* Offset into PCCC */
+#define E25G_CFG(id)				(28 - (id) * 4) /* Offset into PCCD */
+#define E40G_CFG(id)				(28 - (id) * 4) /* Offset into PCCE */
+#define E50G_CFG(id)				(20 - (id) * 4) /* Offset into PCCE */
+#define E100G_CFG(id)				(12 - (id) * 4) /* Offset into PCCE */
 
 /* Per PLL registers */
 #define PLLnRSTCTL(pll)				(0x400 + (pll) * 0x100 + 0x0)
@@ -92,6 +92,10 @@
 #define LNaTECR0_EQ_POST1Q			GENMASK(12, 8)
 #define LNaTECR0_EQ_AMP_RED			GENMASK(5, 0)
 
+#define LNaTECR1(lane)				(0x800 + (lane) * 0x100 + 0x34)
+#define LNaTECR1_EQ_ADPT_EQ_DRVR_DIS		BIT(31)
+#define LNaTECR1_EQ_ADPT_EQ			GENMASK(29, 24)
+
 /* Lane a Rx Reset Control Register */
 #define LNaRRSTCTL(lane)			(0x800 + (lane) * 0x100 + 0x40)
 #define LNaRRSTCTL_HLT_REQ			BIT(27)
@@ -147,6 +151,21 @@
 #define LNaRECR2_EQ_BIN_DATA_AVG_TC		GENMASK(5, 4)
 #define LNaRECR2_SPARE_IN			GENMASK(1, 0)
 
+#define LNaRECR3(lane)				(0x800 + (lane) * 0x100 + 0x5c)
+#define LNaRECR3_EQ_SNAP_START			BIT(31)
+#define LNaRECR3_EQ_SNAP_DONE			BIT(30)
+#define LNaRECR3_EQ_GAINK2_HF_STAT		GENMASK(28, 24)
+#define LNaRECR3_EQ_GAINK3_MF_STAT		GENMASK(20, 16)
+#define LNaRECR3_SPARE_OUT			GENMASK(13, 12)
+#define LNaRECR3_EQ_GAINK4_LF_STAT		GENMASK(4, 0)
+
+#define LNaRECR4(lane)				(0x800 + (lane) * 0x100 + 0x60)
+#define LNaRECR4_BLW_STAT			GENMASK(28, 24)
+#define LNaRECR4_EQ_OFFSET_STAT			GENMASK(21, 16)
+#define LNaRECR4_EQ_BIN_DATA_SEL		GENMASK(15, 12)
+#define LNaRECR4_EQ_BIN_DATA			GENMASK(8, 0) /* bit 9 is reserved */
+#define LNaRECR4_EQ_BIN_DATA_SGN		BIT(8)
+
 #define LNaRSCCR0(lane)				(0x800 + (lane) * 0x100 + 0x74)
 #define LNaRSCCR0_SMP_OFF_EN			BIT(31)
 #define LNaRSCCR0_SMP_OFF_OV_EN			BIT(30)
@@ -162,20 +181,199 @@
 #define LNaRSCCR0_SMP_AUTOZ_EG1R		GENMASK(5, 4)
 #define LNaRSCCR0_SMP_AUTOZ_EG1F		GENMASK(1, 0)
 
+#define LNaTCSR0(lane)				(0x800 + (lane) * 0x100 + 0xa0)
+#define LNaTCSR0_SD_STAT_OBS_EN			BIT(31)
+#define LNaTCSR0_SD_LPBK_SEL			GENMASK(29, 28)
+
 #define LNaPSS(lane)				(0x1000 + (lane) * 0x4)
 #define LNaPSS_TYPE				GENMASK(30, 24)
-#define LNaPSS_TYPE_SGMII			0x4
-#define LNaPSS_TYPE_XFI				0x28
+#define LNaPSS_TYPE_SGMII			(PROTO_SEL_SGMII_BASEX_KX << 2)
+#define LNaPSS_TYPE_XFI				(PROTO_SEL_XFI_10GBASER_KR_SXGMII << 2)
+#define LNaPSS_TYPE_40G				((PROTO_SEL_XFI_10GBASER_KR_SXGMII << 2) | 3)
+#define LNaPSS_TYPE_25G				(PROTO_SEL_25G_50G_100G << 2)
+#define LNaPSS_TYPE_100G			((PROTO_SEL_25G_50G_100G << 2) | 2)
 
+/* MDEV_PORT is at the same bitfield address for all protocol converters */
+#define MDEV_PORT				GENMASK(31, 27)
+
+#define SGMIIaCR0(lane)				(0x1800 + (lane) * 0x10)
 #define SGMIIaCR1(lane)				(0x1804 + (lane) * 0x10)
 #define SGMIIaCR1_SGPCS_EN			BIT(11)
 
+#define ANLTaCR0(lane)				(0x1a00 + (lane) * 0x10)
+#define ANLTaCR1(lane)				(0x1a04 + (lane) * 0x10)
+
+#define SXGMIIaCR0(lane)			(0x1a80 + (lane) * 0x10)
+#define SXGMIIaCR0_RST				BIT(31)
+#define SXGMIIaCR0_PD				BIT(30)
+
+#define SXGMIIaCR1(lane)			(0x1a84 + (lane) * 0x10)
+
+#define E25GaCR0(lane)				(0x1b00 + (lane) * 0x10)
+#define E25GaCR0_RST				BIT(31)
+#define E25GaCR0_PD				BIT(30)
+
+#define E25GaCR1(lane)				(0x1b04 + (lane) * 0x10)
+
+#define E25GaCR2(lane)				(0x1b08 + (lane) * 0x10)
+#define E25GaCR2_FEC_ENA			BIT(23)
+#define E25GaCR2_FEC_ERR_ENA			BIT(22)
+#define E25GaCR2_FEC91_ENA			BIT(20)
+
+#define E40GaCR0(pcvt)				(0x1b40 + (pcvt) * 0x20)
+#define E40GaCR1(pcvt)				(0x1b44 + (pcvt) * 0x20)
+
+#define E50GaCR1(pcvt)				(0x1b84 + (pcvt) * 0x10)
+
+#define E100GaCR1(pcvt)				(0x1c04 + (pcvt) * 0x20)
+
+#define CR(x)					((x) * 4)
+
 enum lynx_28g_eq_type {
 	EQ_TYPE_NO_EQ = 0,
 	EQ_TYPE_2TAP = 1,
 	EQ_TYPE_3TAP = 2,
 };
 
+enum lynx_28g_proto_sel {
+	PROTO_SEL_PCIE = 0,
+	PROTO_SEL_SGMII_BASEX_KX = 1,
+	PROTO_SEL_SATA = 2,
+	PROTO_SEL_XAUI = 4,
+	PROTO_SEL_XFI_10GBASER_KR_SXGMII = 0xa,
+	PROTO_SEL_25G_50G_100G = 0x1a,
+};
+
+struct lynx_28g_proto_conf {
+	/* LNaGCR0 */
+	int proto_sel;
+	int if_width;
+	/* LNaTECR0 */
+	int teq_type;
+	int sgn_preq;
+	int ratio_preq;
+	int sgn_post1q;
+	int ratio_post1q;
+	int amp_red;
+	/* LNaTECR1 */
+	int adpt_eq;
+	/* LNaRGCR1 */
+	int enter_idle_flt_sel;
+	int exit_idle_flt_sel;
+	int data_lost_th_sel;
+	/* LNaRECR0 */
+	int gk2ovd;
+	int gk3ovd;
+	int gk4ovd;
+	int gk2ovd_en;
+	int gk3ovd_en;
+	int gk4ovd_en;
+	/* LNaRECR1 ? */
+	int eq_offset_ovd;
+	int eq_offset_ovd_en;
+	/* LNaRECR2 */
+	int eq_offset_rng_dbl;
+	int eq_blw_sel;
+	int eq_boost;
+	int spare_in;
+	/* LNaRSCCR0 */
+	int smp_autoz_d1r;
+	int smp_autoz_eg1r;
+};
+
+static const struct lynx_28g_proto_conf lynx_28g_proto_conf[PHY_INTERFACE_MODE_MAX] = {
+	[PHY_INTERFACE_MODE_SGMII] = {
+		.proto_sel = LNaGCR0_PROTO_SEL_SGMII,
+		.if_width = LNaGCR0_IF_WIDTH_10_BIT,
+		.teq_type = EQ_TYPE_NO_EQ,
+		.sgn_preq = 1,
+		.ratio_preq = 0,
+		.sgn_post1q = 1,
+		.ratio_post1q = 0,
+		.amp_red = 6,
+		.adpt_eq = 48,
+		.enter_idle_flt_sel = 4,
+		.exit_idle_flt_sel = 3,
+		.data_lost_th_sel = 1,
+		.gk2ovd = 0x1f,
+		.gk3ovd = 0,
+		.gk4ovd = 0,
+		.gk2ovd_en = 1,
+		.gk3ovd_en = 1,
+		.gk4ovd_en = 0,
+		.eq_offset_ovd = 0x1f,
+		.eq_offset_ovd_en = 0,
+		.eq_offset_rng_dbl = 0,
+		.eq_blw_sel = 0,
+		.eq_boost = 0,
+		.spare_in = 0,
+		.smp_autoz_d1r = 0,
+		.smp_autoz_eg1r = 0,
+	},
+	[PHY_INTERFACE_MODE_1000BASEX] = {
+		.proto_sel = LNaGCR0_PROTO_SEL_SGMII,
+		.if_width = LNaGCR0_IF_WIDTH_10_BIT,
+		.teq_type = EQ_TYPE_NO_EQ,
+		.sgn_preq = 1,
+		.ratio_preq = 0,
+		.sgn_post1q = 1,
+		.ratio_post1q = 0,
+		.amp_red = 6,
+		.adpt_eq = 48,
+		.enter_idle_flt_sel = 4,
+		.exit_idle_flt_sel = 3,
+		.data_lost_th_sel = 1,
+		.gk2ovd = 0x1f,
+		.gk3ovd = 0,
+		.gk4ovd = 0,
+		.gk2ovd_en = 1,
+		.gk3ovd_en = 1,
+		.gk4ovd_en = 0,
+		.eq_offset_ovd = 0x1f,
+		.eq_offset_ovd_en = 0,
+		.eq_offset_rng_dbl = 0,
+		.eq_blw_sel = 0,
+		.eq_boost = 0,
+		.spare_in = 0,
+		.smp_autoz_d1r = 0,
+		.smp_autoz_eg1r = 0,
+	},
+	[PHY_INTERFACE_MODE_10GBASER] = {
+		.proto_sel = LNaGCR0_PROTO_SEL_XFI,
+		.if_width = LNaGCR0_IF_WIDTH_20_BIT,
+		.teq_type = EQ_TYPE_2TAP,
+		.sgn_preq = 1,
+		.ratio_preq = 0,
+		.sgn_post1q = 1,
+		.ratio_post1q = 3,
+		.amp_red = 7,
+		.adpt_eq = 48,
+		.enter_idle_flt_sel = 0,
+		.exit_idle_flt_sel = 0,
+		.data_lost_th_sel = 0,
+		.gk2ovd = 0,
+		.gk3ovd = 0,
+		.gk4ovd = 0,
+		.gk2ovd_en = 0,
+		.gk3ovd_en = 0,
+		.gk4ovd_en = 0,
+		.eq_offset_ovd = 0x1f,
+		.eq_offset_ovd_en = 0,
+		.eq_offset_rng_dbl = 1,
+		.eq_blw_sel = 1,
+		.eq_boost = 0,
+		.spare_in = 0,
+		.smp_autoz_d1r = 2,
+		.smp_autoz_eg1r = 0,
+	},
+};
+
+struct lynx_pccr {
+	int offset;
+	int width;
+	int shift;
+};
+
 struct lynx_28g_priv;
 
 struct lynx_28g_pll {
@@ -219,6 +417,10 @@ static void lynx_28g_rmw(struct lynx_28g_priv *priv, unsigned long off,
 	iowrite32(tmp, reg);
 }
 
+#define lynx_28g_read(priv, off) \
+	ioread32((priv)->base + (off))
+#define lynx_28g_write(priv, off, val) \
+	iowrite32(val, (priv)->base + (off))
 #define lynx_28g_lane_rmw(lane, reg, val, mask)	\
 	lynx_28g_rmw((lane)->priv, reg(lane->id), val, mask)
 #define lynx_28g_lane_read(lane, reg)			\
@@ -327,130 +529,6 @@ static void lynx_28g_lane_set_pll(struct lynx_28g_lane *lane,
 	}
 }
 
-static void lynx_28g_cleanup_lane(struct lynx_28g_lane *lane)
-{
-	struct lynx_28g_priv *priv = lane->priv;
-
-	/* Cleanup the protocol configuration registers of the current protocol */
-	switch (lane->interface) {
-	case PHY_INTERFACE_MODE_10GBASER:
-		/* Cleanup the protocol configuration registers */
-		lynx_28g_rmw(priv, PCCC, 0, PCCC_MSK(lane));
-		break;
-	case PHY_INTERFACE_MODE_SGMII:
-	case PHY_INTERFACE_MODE_1000BASEX:
-		/* Cleanup the protocol configuration registers */
-		lynx_28g_rmw(priv, PCC8, 0, PCC8_MSK(lane));
-
-		/* Disable the SGMII PCS */
-		lynx_28g_lane_rmw(lane, SGMIIaCR1, 0, SGMIIaCR1_SGPCS_EN);
-
-		break;
-	default:
-		break;
-	}
-}
-
-static void lynx_28g_lane_set_sgmii(struct lynx_28g_lane *lane)
-{
-	struct lynx_28g_priv *priv = lane->priv;
-	struct lynx_28g_pll *pll;
-
-	lynx_28g_cleanup_lane(lane);
-
-	/* Setup the lane to run in SGMII */
-	lynx_28g_rmw(priv, PCC8, PCC8_SGMIInCFG_EN(lane), PCC8_MSK(lane));
-
-	/* Setup the protocol select and SerDes parallel interface width */
-	lynx_28g_lane_rmw(lane, LNaGCR0,
-			  FIELD_PREP(LNaGCR0_PROTO_SEL, LNaGCR0_PROTO_SEL_SGMII) |
-			  FIELD_PREP(LNaGCR0_IF_WIDTH, LNaGCR0_IF_WIDTH_10_BIT),
-			  LNaGCR0_PROTO_SEL | LNaGCR0_IF_WIDTH);
-
-	/* Find the PLL that works with this interface type */
-	pll = lynx_28g_pll_get(priv, PHY_INTERFACE_MODE_SGMII);
-	if (unlikely(pll == NULL))
-		return;
-
-	/* Switch to the PLL that works with this interface type */
-	lynx_28g_lane_set_pll(lane, pll);
-
-	/* Choose the portion of clock net to be used on this lane */
-	lynx_28g_lane_set_nrate(lane, pll, PHY_INTERFACE_MODE_SGMII);
-
-	/* Enable the SGMII PCS */
-	lynx_28g_lane_rmw(lane, SGMIIaCR1, SGMIIaCR1_SGPCS_EN,
-			  SGMIIaCR1_SGPCS_EN);
-
-	/* Configure the appropriate equalization parameters for the protocol */
-	lynx_28g_lane_write(lane, LNaTECR0,
-			    LNaTECR0_EQ_SGN_PREQ | LNaTECR0_EQ_SGN_POST1Q |
-			    FIELD_PREP(LNaTECR0_EQ_AMP_RED, 6));
-	lynx_28g_lane_write(lane, LNaRGCR1,
-			    FIELD_PREP(LNaRGCR1_ENTER_IDLE_FLT_SEL, 4) |
-			    FIELD_PREP(LNaRGCR1_EXIT_IDLE_FLT_SEL, 3) |
-			    LNaRGCR1_DATA_LOST_FLT);
-	lynx_28g_lane_write(lane, LNaRECR0,
-			    LNaRECR0_EQ_GAINK2_HF_OV_EN |
-			    FIELD_PREP(LNaRECR0_EQ_GAINK2_HF_OV, 31) |
-			    LNaRECR0_EQ_GAINK3_MF_OV_EN |
-			    FIELD_PREP(LNaRECR0_EQ_GAINK3_MF_OV, 0));
-	lynx_28g_lane_write(lane, LNaRECR1,
-			    FIELD_PREP(LNaRECR1_EQ_OFFSET_OV, 31));
-	lynx_28g_lane_write(lane, LNaRECR2, 0);
-	lynx_28g_lane_write(lane, LNaRSCCR0, 0);
-}
-
-static void lynx_28g_lane_set_10gbaser(struct lynx_28g_lane *lane)
-{
-	struct lynx_28g_priv *priv = lane->priv;
-	struct lynx_28g_pll *pll;
-
-	lynx_28g_cleanup_lane(lane);
-
-	/* Enable the SXGMII lane */
-	lynx_28g_rmw(priv, PCCC, PCCC_SXGMIInCFG_EN(lane) |
-		     PCCC_SXGMIInCFG_XFI(lane, 1), PCCC_MSK(lane));
-
-	/* Setup the protocol select and SerDes parallel interface width */
-	lynx_28g_lane_rmw(lane, LNaGCR0,
-			  FIELD_PREP(LNaGCR0_PROTO_SEL, LNaGCR0_PROTO_SEL_XFI) |
-			  FIELD_PREP(LNaGCR0_IF_WIDTH, LNaGCR0_IF_WIDTH_20_BIT),
-			  LNaGCR0_PROTO_SEL | LNaGCR0_IF_WIDTH);
-
-	/* Find the PLL that works with this interface type */
-	pll = lynx_28g_pll_get(priv, PHY_INTERFACE_MODE_10GBASER);
-	if (unlikely(pll == NULL))
-		return;
-
-	/* Switch to the PLL that works with this interface type */
-	lynx_28g_lane_set_pll(lane, pll);
-
-	/* Choose the portion of clock net to be used on this lane */
-	lynx_28g_lane_set_nrate(lane, pll, PHY_INTERFACE_MODE_10GBASER);
-
-	/* Disable the SGMII PCS */
-	lynx_28g_lane_rmw(lane, SGMIIaCR1, 0, SGMIIaCR1_SGPCS_EN);
-
-	/* Configure the appropriate equalization parameters for the protocol */
-	lynx_28g_lane_write(lane, LNaTECR0,
-			    FIELD_PREP(LNaTECR0_EQ_TYPE, EQ_TYPE_2TAP) |
-			    LNaTECR0_EQ_SGN_PREQ |
-			    FIELD_PREP(LNaTECR0_EQ_PREQ, 0) |
-			    LNaTECR0_EQ_SGN_POST1Q |
-			    FIELD_PREP(LNaTECR0_EQ_POST1Q, 3) |
-			    FIELD_PREP(LNaTECR0_EQ_AMP_RED, 7));
-	lynx_28g_lane_write(lane, LNaRGCR1, LNaRGCR1_IDLE_CONFIG);
-	lynx_28g_lane_write(lane, LNaRECR0, 0);
-	lynx_28g_lane_write(lane, LNaRECR1, FIELD_PREP(LNaRECR1_EQ_OFFSET_OV, 31));
-	lynx_28g_lane_write(lane, LNaRECR2,
-			    LNaRECR2_EQ_OFFSET_RNG_DBL |
-			    FIELD_PREP(LNaRECR2_EQ_BLW_SEL, 1) |
-			    FIELD_PREP(LNaRECR2_EQ_BIN_DATA_AVG_TC, 2));
-	lynx_28g_lane_write(lane, LNaRSCCR0,
-			    FIELD_PREP(LNaRSCCR0_SMP_AUTOZ_D1R, 2));
-}
-
 static int lynx_28g_power_off(struct phy *phy)
 {
 	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
@@ -503,6 +581,266 @@ static int lynx_28g_power_on(struct phy *phy)
 	return 0;
 }
 
+static int lynx_28g_get_pccr(phy_interface_t interface, int lane,
+			     struct lynx_pccr *pccr)
+{
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+		pccr->offset = PCC8;
+		pccr->width = 4;
+		pccr->shift = SGMII_CFG(lane);
+		break;
+	case PHY_INTERFACE_MODE_10GBASER:
+		pccr->offset = PCCC;
+		pccr->width = 4;
+		pccr->shift = SXGMII_CFG(lane);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int lynx_28g_get_pcvt_offset(int lane, phy_interface_t interface)
+{
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+		return SGMIIaCR0(lane);
+	case PHY_INTERFACE_MODE_10GBASER:
+		return SXGMIIaCR0(lane);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int lynx_pccr_write(struct lynx_28g_lane *lane,
+			   phy_interface_t interface, u32 val)
+{
+	struct lynx_28g_priv *priv = lane->priv;
+	struct lynx_pccr pccr;
+	u32 old, tmp, mask;
+	int err;
+
+	err = lynx_28g_get_pccr(interface, lane->id, &pccr);
+	if (err)
+		return err;
+
+	old = lynx_28g_read(priv, pccr.offset);
+	mask = GENMASK(pccr.width - 1, 0) << pccr.shift;
+	tmp = (old & ~mask) | (val << pccr.shift);
+	lynx_28g_write(priv, pccr.offset, tmp);
+
+	dev_dbg(&lane->phy->dev, "PCCR@0x%x: 0x%x -> 0x%x\n",
+		pccr.offset, old, tmp);
+
+	return 0;
+}
+
+static int lynx_pcvt_read(struct lynx_28g_lane *lane, phy_interface_t interface,
+			  int cr, u32 *val)
+{
+	struct lynx_28g_priv *priv = lane->priv;
+	int offset;
+
+	offset = lynx_28g_get_pcvt_offset(lane->id, interface);
+	if (offset < 0)
+		return offset;
+
+	*val = lynx_28g_read(priv, offset + cr);
+
+	return 0;
+}
+
+static int lynx_pcvt_write(struct lynx_28g_lane *lane, phy_interface_t interface,
+			   int cr, u32 val)
+{
+	struct lynx_28g_priv *priv = lane->priv;
+	int offset;
+
+	offset = lynx_28g_get_pcvt_offset(lane->id, interface);
+	if (offset < 0)
+		return offset;
+
+	lynx_28g_write(priv, offset + cr, val);
+
+	return 0;
+}
+
+static int lynx_pcvt_rmw(struct lynx_28g_lane *lane, phy_interface_t interface,
+			 int cr, u32 val, u32 mask)
+{
+	int err;
+	u32 tmp;
+
+	err = lynx_pcvt_read(lane, interface, cr, &tmp);
+	if (err)
+		return err;
+
+	tmp &= ~mask;
+	tmp |= val;
+
+	return lynx_pcvt_write(lane, interface, cr, tmp);
+}
+
+static void lynx_28g_lane_remap_pll(struct lynx_28g_lane *lane,
+				    phy_interface_t interface)
+{
+	struct lynx_28g_priv *priv = lane->priv;
+	struct lynx_28g_pll *pll;
+
+	/* Switch to the PLL that works with this interface type */
+	pll = lynx_28g_pll_get(priv, interface);
+	if (unlikely(pll == NULL))
+		return;
+
+	lynx_28g_lane_set_pll(lane, pll);
+
+	/* Choose the portion of clock net to be used on this lane */
+	lynx_28g_lane_set_nrate(lane, pll, interface);
+}
+
+static void lynx_28g_lane_change_proto_conf(struct lynx_28g_lane *lane,
+					    phy_interface_t interface)
+{
+	const struct lynx_28g_proto_conf *conf = &lynx_28g_proto_conf[interface];
+
+	lynx_28g_lane_rmw(lane, LNaGCR0, conf->proto_sel | conf->if_width,
+			  LNaGCR0_PROTO_SEL | LNaGCR0_IF_WIDTH);
+
+	lynx_28g_lane_rmw(lane, LNaTECR0,
+			  FIELD_PREP(LNaTECR0_EQ_TYPE, conf->teq_type) |
+			  FIELD_PREP(LNaTECR0_EQ_SGN_PREQ, conf->sgn_preq) |
+			  FIELD_PREP(LNaTECR0_EQ_PREQ, conf->ratio_preq) |
+			  FIELD_PREP(LNaTECR0_EQ_SGN_POST1Q, conf->sgn_post1q) |
+			  FIELD_PREP(LNaTECR0_EQ_POST1Q, conf->ratio_post1q) |
+			  FIELD_PREP(LNaTECR0_EQ_AMP_RED, conf->amp_red),
+			  LNaTECR0_EQ_TYPE |
+			  LNaTECR0_EQ_SGN_PREQ |
+			  LNaTECR0_EQ_PREQ |
+			  LNaTECR0_EQ_SGN_POST1Q |
+			  LNaTECR0_EQ_POST1Q |
+			  LNaTECR0_EQ_AMP_RED);
+
+	lynx_28g_lane_rmw(lane, LNaTECR1,
+			  FIELD_PREP(LNaTECR1_EQ_ADPT_EQ, conf->adpt_eq),
+			  LNaTECR1_EQ_ADPT_EQ);
+
+	lynx_28g_lane_rmw(lane, LNaRGCR1,
+			  FIELD_PREP(LNaRGCR1_ENTER_IDLE_FLT_SEL, conf->enter_idle_flt_sel) |
+			  FIELD_PREP(LNaRGCR1_EXIT_IDLE_FLT_SEL, conf->exit_idle_flt_sel) |
+			  FIELD_PREP(LNaRGCR1_DATA_LOST_TH_SEL, conf->data_lost_th_sel),
+			  LNaRGCR1_ENTER_IDLE_FLT_SEL |
+			  LNaRGCR1_EXIT_IDLE_FLT_SEL |
+			  LNaRGCR1_DATA_LOST_TH_SEL);
+
+	lynx_28g_lane_rmw(lane, LNaRECR0,
+			  FIELD_PREP(LNaRECR0_EQ_GAINK2_HF_OV_EN, conf->gk2ovd_en) |
+			  FIELD_PREP(LNaRECR0_EQ_GAINK3_MF_OV_EN, conf->gk3ovd_en) |
+			  FIELD_PREP(LNaRECR0_EQ_GAINK4_LF_OV_EN, conf->gk4ovd_en) |
+			  FIELD_PREP(LNaRECR0_EQ_GAINK2_HF_OV, conf->gk2ovd) |
+			  FIELD_PREP(LNaRECR0_EQ_GAINK3_MF_OV, conf->gk3ovd) |
+			  FIELD_PREP(LNaRECR0_EQ_GAINK4_LF_OV, conf->gk4ovd),
+			  LNaRECR0_EQ_GAINK2_HF_OV |
+			  LNaRECR0_EQ_GAINK3_MF_OV |
+			  LNaRECR0_EQ_GAINK4_LF_OV |
+			  LNaRECR0_EQ_GAINK2_HF_OV_EN |
+			  LNaRECR0_EQ_GAINK3_MF_OV_EN |
+			  LNaRECR0_EQ_GAINK4_LF_OV_EN);
+
+	lynx_28g_lane_rmw(lane, LNaRECR1,
+			  FIELD_PREP(LNaRECR1_EQ_OFFSET_OV, conf->eq_offset_ovd) |
+			  FIELD_PREP(LNaRECR1_EQ_OFFSET_OV_EN, conf->eq_offset_ovd_en),
+			  LNaRECR1_EQ_OFFSET_OV |
+			  LNaRECR1_EQ_OFFSET_OV_EN);
+
+	lynx_28g_lane_rmw(lane, LNaRECR2,
+			  FIELD_PREP(LNaRECR2_EQ_OFFSET_RNG_DBL, conf->eq_offset_rng_dbl) |
+			  FIELD_PREP(LNaRECR2_EQ_BLW_SEL, conf->eq_blw_sel) |
+			  FIELD_PREP(LNaRECR2_EQ_BOOST, conf->eq_boost) |
+			  FIELD_PREP(LNaRECR2_SPARE_IN, conf->spare_in),
+			  LNaRECR2_EQ_OFFSET_RNG_DBL |
+			  LNaRECR2_EQ_BLW_SEL |
+			  LNaRECR2_EQ_BOOST |
+			  LNaRECR2_SPARE_IN);
+
+	lynx_28g_lane_rmw(lane, LNaRSCCR0,
+			  FIELD_PREP(LNaRSCCR0_SMP_AUTOZ_D1R, conf->smp_autoz_d1r) |
+			  FIELD_PREP(LNaRSCCR0_SMP_AUTOZ_EG1R, conf->smp_autoz_eg1r),
+			  LNaRSCCR0_SMP_AUTOZ_D1R |
+			  LNaRSCCR0_SMP_AUTOZ_EG1R);
+}
+
+static int lynx_28g_lane_disable_pcvt(struct lynx_28g_lane *lane,
+				      phy_interface_t interface)
+{
+	struct lynx_28g_priv *priv = lane->priv;
+	int err;
+
+	spin_lock(&priv->pcc_lock);
+
+	err = lynx_pccr_write(lane, interface, 0);
+	if (err)
+		goto out;
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+		err = lynx_pcvt_rmw(lane, interface, CR(1), 0,
+				    SGMIIaCR1_SGPCS_EN);
+		break;
+	default:
+		err = 0;
+	}
+
+out:
+	spin_unlock(&priv->pcc_lock);
+
+	return err;
+}
+
+static int lynx_28g_lane_enable_pcvt(struct lynx_28g_lane *lane,
+				     phy_interface_t interface)
+{
+	struct lynx_28g_priv *priv = lane->priv;
+	u32 val;
+	int err;
+
+	spin_lock(&priv->pcc_lock);
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+		err = lynx_pcvt_rmw(lane, interface, CR(1), SGMIIaCR1_SGPCS_EN,
+				    SGMIIaCR1_SGPCS_EN);
+		break;
+	default:
+		err = 0;
+	}
+
+	val = 0;
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+		val |= PCC8_SGMIIa_CFG;
+		break;
+	case PHY_INTERFACE_MODE_10GBASER:
+		val |= PCCC_SXGMIIn_CFG | PCCC_SXGMIIn_XFI;
+		break;
+	default:
+		break;
+	}
+
+	err = lynx_pccr_write(lane, interface, val);
+
+	spin_unlock(&priv->pcc_lock);
+
+	return err;
+}
+
 static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 {
 	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
@@ -519,33 +857,26 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	if (!lynx_28g_supports_interface(priv, submode))
 		return -EOPNOTSUPP;
 
+	if (submode == lane->interface)
+		return 0;
+
 	/* If the lane is powered up, put the lane into the halt state while
 	 * the reconfiguration is being done.
 	 */
 	if (powered_up)
 		lynx_28g_power_off(phy);
 
-	spin_lock(&priv->pcc_lock);
-
-	switch (submode) {
-	case PHY_INTERFACE_MODE_SGMII:
-	case PHY_INTERFACE_MODE_1000BASEX:
-		lynx_28g_lane_set_sgmii(lane);
-		break;
-	case PHY_INTERFACE_MODE_10GBASER:
-		lynx_28g_lane_set_10gbaser(lane);
-		break;
-	default:
-		err = -EOPNOTSUPP;
+	err = lynx_28g_lane_disable_pcvt(lane, lane->interface);
+	if (err)
 		goto out;
-	}
+
+	lynx_28g_lane_change_proto_conf(lane, submode);
+	lynx_28g_lane_remap_pll(lane, submode);
+	WARN_ON(lynx_28g_lane_enable_pcvt(lane, submode));
 
 	lane->interface = submode;
 
 out:
-	spin_unlock(&priv->pcc_lock);
-
-	/* Power up the lane if necessary */
 	if (powered_up)
 		lynx_28g_power_on(phy);
 
-- 
2.34.1



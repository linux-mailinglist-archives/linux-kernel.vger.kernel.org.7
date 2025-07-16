Return-Path: <linux-kernel+bounces-732922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A96CB06DB8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7AF51C21C2E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 06:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036592E974C;
	Wed, 16 Jul 2025 06:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZszC/vnl"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013058.outbound.protection.outlook.com [40.107.162.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C66C2E88AC;
	Wed, 16 Jul 2025 06:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752646314; cv=fail; b=XnaurrjwCNKq0ExHv1HlFGWsgakSw2SBKkZcaYCUY7+Ee03iIFx/6S1J7kqy3bA+HbB9p6ngXk2wo1nN5EACOiZ9MORNOhQpDLqMbfQf6aJvis9LTCvVgkZfOU7qwy4po8oHkhuajFZCAjzRjw5SDObEdT3VGKgSx0QyojiP9mM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752646314; c=relaxed/simple;
	bh=oDROp5GTyeEM6hwpKi6b9v1wKjovedOSuhMNb6RyC6s=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BfEN4gOUQNQvMb6iorO/kTnS0tHY29KaW6Pln84SrmO+LVq7+mipiYtOVY3vArdyqS1hMyBIsVgUintUHEdRSLwarBm2RkGW/eO7EmKkugmTOwBTp5OzaLikMOLG7MgFlMApIfBXeuV8Z1TUbo/J7XBtJEMOP3UaxPb/htsTMA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZszC/vnl; arc=fail smtp.client-ip=40.107.162.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jWEUuoLSFpPPqnLw5NMyo42nDM9Q4G/6+IJyuyM9lgbENbblIELi4QOrIIhffBClnkSVoY9BM6yPMMiOzsnBvLiW4WIm1AEVIpYwWW/dtuYfUp0ihwQ61G+WjA2F22aKgGRbSXuXNeAdpMHwGq/JngSQY14MRAEiiE84PyvDg/TbbktoaAZHWP2c7Z4Z6nDjGQpX8sCg/9MhDuyCOo8qdk7ybRW4nc71eGf1Ph36I8GNeLN1G+SBILvcCETWqF2pGYCETY+Sjxn64h1X1ixjZO8i9bvo8+ktgdnECo4Yghn0fEhNMeEh03CgKW9/1JsT/ucfoOjvHyB0U/8hEz4RyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+OG/kcphiGbuPzLGUBBDW9v9iqnL94T9PnklWnPvZ4=;
 b=hfNBrHH23/BD1WFzuyhtUxg6fV9TcB1grsAJ5Uuha+vfCQs2doij/erWbyje0XEZnCn6UEu/QFg6SHPrA9/T4rruojwWdxsWf0BnZZ/WEWp+7LxlA88XYGyVyXdtCw9dWuIJIrdOTDBiTjChRyOvohWbKTV9z8+LyK5lkhztGxtA4F8FD/iNoadSEe2FL1/ZsPFgxDtSUJ9wjmnNh4fQXnWFX36wYMN+fX1NpUlOTwt1WH8WRGpKuF60SRIvKEUa+IKfS6DvEhVHkgEm7ZxFjZNIwmgbb+ZTxRcmODgHIjamkzcQQrtBV7FBeB9gLWVmPxmsyOXxYZhApevdZUVWpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+OG/kcphiGbuPzLGUBBDW9v9iqnL94T9PnklWnPvZ4=;
 b=ZszC/vnlpYwiGonE6BxaAIT0etQzSuG4giPYdlcqaxtvzRLPKMOXadQ3f+eqxWw6Art5wRIwxCmLZLXFRu90yv0Lw2HTqZ4mW+d7g/dRDyVbUbK21jXxSii0A0PbvcAyYZupXVuwoA6eA4meH581QvCRpQiFVYB2zZ8M8RS2otndDsWRn68iixsjdpNkIrylQ/hRDC4jSBbxl5zwJwLps4uklvgZ7zxhL+AYCxG9A42U8OZu0q3GWbjxu+Wd5mo/BgdJ0+lfj1sPmB9COBLCKv9FIMst3wVX3PwwVAXrtCRzLQdp0/1TTbnrhLEnJ/DeiiP0yJ2pL1lQQVeT5UA+kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by VI0PR04MB10102.eurprd04.prod.outlook.com (2603:10a6:800:249::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 06:11:43 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 06:11:43 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com
Subject: [PATCH 2/3] arm64: dts: imx8mq-evk: support more sample rates for wm8524 card
Date: Wed, 16 Jul 2025 14:11:13 +0800
Message-Id: <20250716061114.2405272-3-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250716061114.2405272-1-shengjiu.wang@nxp.com>
References: <20250716061114.2405272-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::18) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|VI0PR04MB10102:EE_
X-MS-Office365-Filtering-Correlation-Id: eb4a78f5-4272-41d8-377a-08ddc42fa2ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UhPoM2/Tj96uwgIVMeK4fjs2rmCZGqwuIW4bTYxLAhgMa+ASy264LdwJc+ih?=
 =?us-ascii?Q?TuYMy6SyiP3sv+QAH++0P9e0ELk5YaC04QuCSzKZnEXlpaQ7c2ugbbofTzqo?=
 =?us-ascii?Q?y/27c0BPgvzBdiIq+jjF/0Es5RToyKbf0RqNva0b3SgoAfCZgedSbSln8ZKV?=
 =?us-ascii?Q?3nh5zB+K1/gqcF2sQ+HsaMIbbWHZ/kE+3Va32tjLzkMEi+MZ4ItF16Ggol1z?=
 =?us-ascii?Q?cn6KCJpBHNh0l11TnjIKlgYn2MaB43AWCAPRWsy4zgH1S3pOp1wOfWt/wlxG?=
 =?us-ascii?Q?I0UzEI3B/VhNfzKn5eeIeDNLYXYYcLy0dI1ciSJ5gj6Dzf1tUZ+iRd2DYKEV?=
 =?us-ascii?Q?fXpFrjg/vuuq6fH7sEvo3+RBYgPxHJ+4dIoOLyix8nhJo3kiizzxbx5y+n0n?=
 =?us-ascii?Q?DO5zwCgGHB+fd3xHowVkK+bNJfhA7lXwTuCzBG+lEQPKq4FzhyrETtbhlYNB?=
 =?us-ascii?Q?qVjJYx0kT9FbpNG8oRFfvQbhKvV5KyVdjw43/VZQXe7hyN93CXFPp4y39LVS?=
 =?us-ascii?Q?HCLt31zRxVfpofbjQ5WYmSc7CfgC/hB21LBclfRlnY7a+Be92nR34DSg2Dgs?=
 =?us-ascii?Q?29p+06ppQN2Y5YiVt3Zn1ooTk+gRaeUycHz4tk3E2DP0tc0gRmLlIsaQ7KWY?=
 =?us-ascii?Q?dpOQ3XmRvmQGzQ5S9o75xl+kVEbMlkdCcABVo5ExiEHJQyZvlJF7Go4dSnY4?=
 =?us-ascii?Q?d5To6B6Mw4t+rMNtBUGRL79kTayA5e8EwR7FKRvNWBQ+wxuIiil5y6gchJ43?=
 =?us-ascii?Q?ABsVMJJbOJZR/DppcNg+FS7oe8baF1wC39Ngavluq5h6oiCM0mN6e3xD0c3p?=
 =?us-ascii?Q?sH59n8uC+c4hMXX8FGYe9OE2A1niGBoG8K+wS8bzx0i07BDlqb/Uyp9dbhEp?=
 =?us-ascii?Q?0sOau/zsDzPsRJdqEb9EUNAYvx0OvFkocgN3/+8PHOdUD97BnRC89RLTA0Am?=
 =?us-ascii?Q?8Jd9OCjw1Q/o2TynTqv3msh64JmOJAstx5jeM6XjVu+rNToWWwDKvU/2FYIc?=
 =?us-ascii?Q?dchME5nQsNYPfR36/v23xq60E2gLhm6Cx/ZRJECvGUc+N5+pDp8nUpNEURdE?=
 =?us-ascii?Q?n4IwVDhOoD1khrVrWdkA7JyfuUdtkGlK5J6wwMou0VWCqLYIvYfxqUhJAmm0?=
 =?us-ascii?Q?UrAXxbQBsww8STaNxBoXECK6C2jQVrJAPtPijyWHEwOYktaOpGltBhf0QCGy?=
 =?us-ascii?Q?iFF7lLfImkQE6VZoLsfhkRkKQ2mVY54nM8fvOFmLwgumrlnzMG2XpBSjRb67?=
 =?us-ascii?Q?rSd8cSHXUlEOQStJj99HjS86G2Op+ZRqq42jg/tyEt4oSrgFYpfVJLmKPgB/?=
 =?us-ascii?Q?ZtU5T0zmNMoZlGmX/SbEdpzsQ8bu1nyTwVP+RkRSuvg7pfU3+Y1NXG5m2pPj?=
 =?us-ascii?Q?dUX0zDtPLefJjcwftv/iafGTQsdAjAI/WVneOVRDWFV7u5Ebch9sZZOCvm3m?=
 =?us-ascii?Q?2uzgX59A2WnZDW/8BQzz7qPHtTZm6iyMiZqU7saRsPhs7MI57sIh7sRHYVH8?=
 =?us-ascii?Q?viXUa+P7LOToF7A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PLE2io4OVbz+UzJq/kBo0Usw5E3WGvSQuUzYfhYdbbc5cOrbBzoljU7oJoSk?=
 =?us-ascii?Q?+N1FxW565BR5nSduiTnHlh1V0EN/Haj35MzAWxJDeNC+Q8i5d0ne0B1LpA0r?=
 =?us-ascii?Q?RpCEIBT6cHgarTvhppC75w+eP+DpUCQVmbTe7yQ4z1cgRyeS1gJP3NDyPWt1?=
 =?us-ascii?Q?/x3nWlYeF3yzvkSo7vJgXyapeaLJWkrgkl+YORmz0YAE/u3MjP0Egk2xnoDO?=
 =?us-ascii?Q?ZwxLT08m/GrJHEyLWkScAgzjKU/YlPz3SYtMuNAFC9Pvfi2SPR3yOetD5vdC?=
 =?us-ascii?Q?fYsRdWOqbfiHvv4ED/dk6/loKN5pP8ZzZmGr7cOzmZPDCrHntuCygcgPIbOq?=
 =?us-ascii?Q?yi+ZV4NImTYjYs3MkKc2gOb6C2YELgbfa+0xP4xJp2Sv0YEKL/EJvEX+TSSO?=
 =?us-ascii?Q?k5HcDmLvYdKlkXt6cboBbWP43bTOmQFcYzkL4vq9plyVX10rZdizDXFtpyqT?=
 =?us-ascii?Q?qZh2dCiqyMdT0YK4PYwRvfMQX/yCeEAG3T70QduzF6ZjwsHWe3ufwEXH425j?=
 =?us-ascii?Q?sAEBXS4eqCMbj13lgtJYQ7O0mi2GcypXPh+l2uH+o22OgEyF0gMZY3H2g5MT?=
 =?us-ascii?Q?o6myGp7O2LytLhurKKg+Nn2iewQDZaKopGXlQfVRENsQa5sJiqXpmyJDeOeT?=
 =?us-ascii?Q?0cqgYhQ8UdH4xjSk83wpM5fsWL5IANfS7mcm2cS6PDhexwDfenGQmn0ECxT7?=
 =?us-ascii?Q?s4s4et8QGj94EF+vAzVnFwIkiP6QQlgdhrcAi2q+kaleQBnk9M71dnh3fdlY?=
 =?us-ascii?Q?A8uxZlIqIMpTxQxh1Y9TXtQPP1LnI5GJwfi+zXZeZ/GCKi61PiepSMakVNPr?=
 =?us-ascii?Q?dDWEjYWSn5L/NGGTt1ieB/0M/S8O6LXxA1FZSnNze9ltqR1EYQBv4yZ0e6D7?=
 =?us-ascii?Q?lFKqdoKjy9yePkML8UDmScklTDT/m5tscV3wn0ZYbwCxiB0x1lASMrz8CaiB?=
 =?us-ascii?Q?CStmKcrXGXtx1YaTbJH8xx+8j3WO0pfwBPeVpPhcLDyt+M22gglGtKsIs/cj?=
 =?us-ascii?Q?+6MGaCXFISHiI2tqSj2G5pfnbjUAff1rrHpRad5YHaTKmC6sy+JorpERCd91?=
 =?us-ascii?Q?V44MoRHkCrZG3E9fCWF0JnSVLJieDaNL7Oj1JO0R3VhFNDbxjVCVDKNHNk9c?=
 =?us-ascii?Q?P8rssPhIUX73By2kq7uAgUJ20b28DBC+VlSQWkfR65lfbl/NJ7YXd9K6AvPI?=
 =?us-ascii?Q?TzKPgXEkzOf/p0l2uyezEuaYs0fyLBaMceV0+VusGb8I+zUwEwHUFWwTa+tV?=
 =?us-ascii?Q?x83Nh5Wfs8GN8mk+l2yPIiO0Lzkfb5M6+Kc275n1wSnnBU4mcWQzrDK6GJDe?=
 =?us-ascii?Q?vN6GvbUS4pyOhoyHDr8xKSbelXJJ3uOOKPoxxsPrqKFaf5+4oMQGEGQA5Xqy?=
 =?us-ascii?Q?ikNqcfWzR0pOUBU0GOYLCtxda783coVrsEOg88hkG66ysk03ruCCmG5Enb1L?=
 =?us-ascii?Q?I4ui97Bt1PkEoL+VWQ4pbG+zWSsTO4ug7xi2bPNl1V6N8q25rndFV2HHGRgQ?=
 =?us-ascii?Q?6NrMc68n138Xc8/mhzi7EjMyJ2rRoqiu8jhijuImtyXhvuD7KnUspBx6PeK5?=
 =?us-ascii?Q?EzwrL5H8YdMpANlemiP/7GXddOW/Cf4k+3fKls9b?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4a78f5-4272-41d8-377a-08ddc42fa2ee
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 06:11:43.4903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RCbmy3fSdPaA5SD2o2w3blxJd/z+IaWA+IRg11G3fXt4CFY3ZHDfc31glEHQ/HrtNl9Qeeo1vDBbmp+o61lFcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10102

The wm8524 codec is connected to the SAI interface. There are two audio
plls on i.MX8MQ, one pll can be the clock source of 44kHz series rates,
another pll can be clock source of 48kHz series rates.

Add mclk-fs property for the clock ratio, remove 'clocks' property for
codec that doesn't need to handle clock enablement, add
'system-clock-direction-out' for clock is from cpu dai.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index 43e45b0bd0d1..a88bc9034663 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -108,6 +108,7 @@ sound-wm8524 {
 		simple-audio-card,format = "i2s";
 		simple-audio-card,frame-master = <&cpudai>;
 		simple-audio-card,bitclock-master = <&cpudai>;
+		simple-audio-card,mclk-fs = <256>;
 		simple-audio-card,widgets =
 			"Line", "Left Line Out Jack",
 			"Line", "Right Line Out Jack";
@@ -117,11 +118,11 @@ sound-wm8524 {
 
 		cpudai: simple-audio-card,cpu {
 			sound-dai = <&sai2>;
+			system-clock-direction-out;
 		};
 
 		link_codec: simple-audio-card,codec {
 			sound-dai = <&wm8524>;
-			clocks = <&clk IMX8MQ_CLK_SAI2_ROOT>;
 		};
 	};
 
@@ -440,6 +441,11 @@ &sai2 {
 	assigned-clocks = <&clk IMX8MQ_AUDIO_PLL1_BYPASS>, <&clk IMX8MQ_CLK_SAI2>;
 	assigned-clock-parents = <&clk IMX8MQ_AUDIO_PLL1>, <&clk IMX8MQ_AUDIO_PLL1_OUT>;
 	assigned-clock-rates = <0>, <24576000>;
+	clocks = <&clk IMX8MQ_CLK_SAI2_IPG>, <&clk IMX8MQ_CLK_DUMMY>,
+		<&clk IMX8MQ_CLK_SAI2_ROOT>, <&clk IMX8MQ_CLK_DUMMY>,
+		<&clk IMX8MQ_CLK_DUMMY>, <&clk IMX8MQ_AUDIO_PLL1_OUT>,
+		<&clk IMX8MQ_AUDIO_PLL2_OUT>;
+	clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3", "pll8k", "pll11k";
 	status = "okay";
 };
 
-- 
2.34.1



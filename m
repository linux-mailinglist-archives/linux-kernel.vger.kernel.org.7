Return-Path: <linux-kernel+bounces-732921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00766B06DB5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94D6E566D27
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 06:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC602E8DF0;
	Wed, 16 Jul 2025 06:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f24ek3tn"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013058.outbound.protection.outlook.com [40.107.162.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41394272811;
	Wed, 16 Jul 2025 06:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752646312; cv=fail; b=PuSjhe4KzLJw4/3aKAE2R2QAKX9ZZSyMlm+EnZ1866JZhWJ0yENwco2vzgGSmDONaot9i6z7RgD1wc14GKNFZb7Oq/YXX1zrDFWHOTICF2ymmtS7GLYBt1JcgeIN1k620Zs5Ve8GzwUeBu8MJlgJ7rrQJ5u08sMsupH6Cu9sZf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752646312; c=relaxed/simple;
	bh=EHw0EiEODDPq15mBwenu+kEaKdLaJl/AMOZ/CkTkhro=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WFwvBVdnVj/ljQikp/lYsffXE3VG7sGWBF8HC3CeaRvc720NxrPzdUI+ae4/p+6vpSFJnbg8H7plng3oG6VxTRdZQ+vMNbU7BIVGudbnaKxxrF7P+Isp82pEvKH6vELDDKUJZ2be2TS6fS09WigRoWkofSZx/1WRQeHe+JeUxxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f24ek3tn; arc=fail smtp.client-ip=40.107.162.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G+NDDBXHfGQJTlhYbOw37BIe97ixoxDjyiwwDeR5f58S2rRYYEueX3sKFBZGZuT/43HXwIMbcNAi2Lyj6NcR4iEdOZHDsky0ZN5bHC3YarhQfONgI4fpqAyVnU60jrZLjBlIINyFPoplrzmGUDuAe0zSSM1Hxtic9/Ybg99sI9Zwrku/2fz9jN3uxIthUwVAIKUV0Vzq6GCChSNk6bCVKl6Wnk+SaDvgTrHhvFHC3OtArHEl0rkUhZlBboAD+4x2MQxEZOQlLldvdgVXTSuH5TWtxkKHszGsDKXLw64k8B8d5njD5HG/qrObwII/ZhxBNiOiKkQLClBDK1mQLX6d8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxLqchhpsDLFz+pjioksJJmkqEQJUzRiCzL5lic7InA=;
 b=jEs2Y9A/A1giS2mX0caaxgeEMpwKZKyPIu7pK4i+gfJafAC8Dy+AKAUS1YZ7VRH9z0gWVXSI6pfNdzAFAYFLomizNebVYSwyDxDpSKquRPtQSDcr8jl8XZREj5UbRINJgCkvE75aXAcszMe0hCxFqDF7+85BRvYQmZkPHikUMGtnzfjOdDZ+vsxX4FsXW3NCkXkXbwSPkx+R6vwNK7OVBHzpW04VB75/iW1BNiUyM3yNH45bOzVUjDh6zInkcs7aF4033QlhcbzRPmr2Br7ArilmCFpGSCbdVYpfxtRJL5XUYoMCSOzuNjEE5kE1r3h74gMkSmkei6bp2IJykMG9Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxLqchhpsDLFz+pjioksJJmkqEQJUzRiCzL5lic7InA=;
 b=f24ek3tnhS+wgykGpRN2rJ/Vds5Om3g2D6l5KN/vDQGewOD1S3NU0D6d5hyuTYT5nADe6EiKdilADgicT0n5Gu0/CRe+Un75iypKOq96tM8TsAb4SC2kVPEcq09HcBVJKZhhcFNbfygsziMzTNzAelIvouZZR0ZF5FHzQ/nESlqoQynBodqsyX3fvPeIj9/NPmcdcLuiwd9hB5Fsi8zR7S5p41Fd84pSAem/f0VtElxrG+bib8mkze+PKrH8nq6kDFHW32W/08SyA+WOYS/tehdY+Bnx8pQ1FBBYnqsCfRiAoNfckWfBLi9NLKmHkqJfJQM6gLUi8CpF26BhKefZaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by VI0PR04MB10102.eurprd04.prod.outlook.com (2603:10a6:800:249::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 06:11:47 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 06:11:47 +0000
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
Subject: [PATCH 3/3] arm64: dts: imx8mn-evk: support more sample rates for wm8524 card
Date: Wed, 16 Jul 2025 14:11:14 +0800
Message-Id: <20250716061114.2405272-4-shengjiu.wang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6183d7c4-fba7-4ebb-a6d6-08ddc42fa576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EtGY7TioAtVB+m19hyLF4LXmYicfwG5D1xsl1etK0aMZgMXH00L3uWtXNTCg?=
 =?us-ascii?Q?5CoYY8nzL6TvTVMZ5WVDel0892LoBFlpPz1oT4RYXJ3C/GyJWPdDJxSPek8m?=
 =?us-ascii?Q?VVUiM3cBi6RHXezbDtqL+Lqp2Xyk3IF5QSVn6ihqc3V94DCfsCSYkjjL52nb?=
 =?us-ascii?Q?8zapRUpbqKmQPZ7rCeOWG7ltLyY7fi6LdjsTup6S4a60dV6rVwQ6tPgmoRl5?=
 =?us-ascii?Q?iHaZaHerC3u/AdcKs9zMPOsFbSLa0AjkBitD/UkJHwroNJC3yIUu2uns9iXc?=
 =?us-ascii?Q?IrWUEnyVTTPOz0pSrw7pPEWYsEBkix6AkJ96dFA05nD4vf/lTy5/bb2AsJop?=
 =?us-ascii?Q?phWC5ggM/FNmh7dBcbzAYht6gbbLmIZyd4DxqkPdl4uuYAN+L2p5aTbIhytT?=
 =?us-ascii?Q?ieJQa95FdvPwkmnZ53Mq7rC+Dot0LNMk0Dyk9hycT+/va3p9Qr1KfHvsHdaW?=
 =?us-ascii?Q?PsbFyPozM7Gp1zB3+6+YVFqI6BJXqhruDLsneuRDfVEujqjVotLBFiZLzNcs?=
 =?us-ascii?Q?x5QqpG85WDnSiXG5geZDoyujRLp21R61HGlXfIdK2eadiOfFXbejhJGnqxqB?=
 =?us-ascii?Q?IUG3pJTeQbbWyd6t+tkVNp2ysr0F5gTakUuVfTovt7Dev+AEXWyrjJURb0Pl?=
 =?us-ascii?Q?PZpM6ZSaX18nxP67MvUUf9vmxAIHevK7Z7Bw14pWmmFj/vEXY4UaA/fGLiNH?=
 =?us-ascii?Q?Zs/dVWvfPJG2QvK1kBRN2uDdA1AGB6tRRIsLl5rW7RdqshfP2QvWrSC7ff24?=
 =?us-ascii?Q?nlgUntXoke38l3N0PNwHg40KpM8Ygy8Y9yJ5RT7faVQfL40sCuL4Rtx/J0++?=
 =?us-ascii?Q?I9K86hFMzUFyDWo+HBWwonUxh3Dv3haxpNDCUYcG5kjMecVeZWHWXPONtkeX?=
 =?us-ascii?Q?EmbdUmf32wCH71CMv98Wej9Cz515aGHEhOZCO9z067fA+7bCwcVrFnR9T8sN?=
 =?us-ascii?Q?Wh1H0FElawiojl8s9OSuwmtX1pWgrsAI1VYON5In/zrJk/1vWNNuGoQ15ThI?=
 =?us-ascii?Q?zfVNN0i7IRZPm6Fn/qTlQAZz4ZInbKXp+ZeXP7AERKjcfNZGdOYpaQQDa3Gl?=
 =?us-ascii?Q?TL6HnqHfhDTSuPzMkd/1jJH1IbO1404cqy+4pqdVBdIWqAxiPQQ1sXk+GJhC?=
 =?us-ascii?Q?CZiC/DFYQm/2crurcc0pmnzPioKSWnsBmUtdrl7TDKWD2bVOlraNgoTQIBJ/?=
 =?us-ascii?Q?gNUTtJj5Wz/CpTogpXDoP7y9li1dRuXDaOZaqLBkcpuUaBa0lB+XQDBfFYJr?=
 =?us-ascii?Q?+qT5S5WI5ly/9S0SSEPbPArm9trWKPkkAHQnJEy+0toKZ3WoRyWCoHp2z/mH?=
 =?us-ascii?Q?CY7l3GMLRpxE4qyoxbR8+cZe0WZoyJekSvlbl/cet6rjcTYSmtEOcW7bxyuJ?=
 =?us-ascii?Q?8GmmWHwZ94ZizBFBTSPOAN9Az03ouv5lIjTo/mDnd+dymdyqwiem0pyrIFR2?=
 =?us-ascii?Q?s/oNhSNZ6FAJlrhePaWLBaTct+MVfyJ8biaOHoeWFMuBUC0zhL2ft030Lbff?=
 =?us-ascii?Q?v+monr71pZTlYI0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AlesdRyP0jPDqjunDmHKxGobzGPTrC7Cvt5qVtoCe/N2dKVq9jhAA52+yRCI?=
 =?us-ascii?Q?qjDmvgzH3Yw/xNEt2rVncUZo2Oooi/o3f/Fr7SLVwReMHw2J5q8zauCmgaLY?=
 =?us-ascii?Q?5PG9oX1XZQdkkt5PR0PGiQ+jxrHKCi1+ce3rlcI/lrvTvFemGbgTBv+Jcval?=
 =?us-ascii?Q?mF9DjjqsFywn5LylJdr65nuA8rvcgvogow0iJc2WoJikYagIgNYTpA0ui6ij?=
 =?us-ascii?Q?hVgU787KL7T3drn+5HA0e8bc3+fhYgI+L04wM9yOq8VjBmVbFLlabK60aoFI?=
 =?us-ascii?Q?3dEWkwiQwZKdtjYkRLrsBRzCXWtmLO1CJcw2Twz6vvgjpNgGceK+vb8mGsWS?=
 =?us-ascii?Q?iroDTzAbTB/vidmLe19GJ1OvhSJARPq+lQWzdD73DTva97SpSejMlL3kovmB?=
 =?us-ascii?Q?tR6e3NsUd1lrpOn6/i7NXqHVGCRgyL4mBvtnKf4lpIhxUSJ0pCvcgfBTsRjz?=
 =?us-ascii?Q?RY4/kHI3e+pX9NcvwGHLVpV37vuS7lnFdv3eathIZlnWhpQ0uauXJ6YtG1+n?=
 =?us-ascii?Q?QFWbmq+huxHaU3oJxJtzgcKcNcrP04AHFmTBMv5PoNZeJQ3/1D3eo2X9ocqM?=
 =?us-ascii?Q?713g+qcA/OojaY/chsi2atvUoOTeysJb748ZrkIifqnem9oNwxyGWNjoJoDU?=
 =?us-ascii?Q?qxVKbpgGkH9MzyHP5LPKDSCR25MD/nzNUCEuptl4N06ADUk5fN9FCKVFGr0E?=
 =?us-ascii?Q?5eCfuFsw5094/+vA3XvCMjCDd7qMEuruARbAr32N1JheFAV6lDOxEeNkh9+e?=
 =?us-ascii?Q?XN/xzpV3UN0ueFUMJgYlAkYgRQJYaFvvxYlei7KS5/0WqdbrE2VBtL3IMpcc?=
 =?us-ascii?Q?lCqHY+Wu1/emvq3luT+WO0ZIo/2bYUB5wEJ9vM63WL9gfdgB4MT4ftcM5IdX?=
 =?us-ascii?Q?Ik2krvUBDWCvu69RtNUlp7pUJ2m9vGxuGSRlVSddRDgOmHB/RPdO9wNkWgKi?=
 =?us-ascii?Q?oDKcNlDgvaUlXhPUqCRHcqZKHnMHQNykglf/bNZJC2ZhMDc55Rv99N9uT4ru?=
 =?us-ascii?Q?wSwXh+SuPxY0LIQDYfyc+8suBR7ww0W+8B/Ukz389Hl0h32kqHX5cbrNDJ6R?=
 =?us-ascii?Q?lpdB7521+MneI7wTMPSikN3Fe9oJeDRWzWhr7sHi6ACwqoHsO1NWHaJw3nAN?=
 =?us-ascii?Q?2vDdrWq5v9ZKnQLl21Xnj1SMJlDSOnXq7uY6m3dtTRdPlipZIYvFcUcbuQGK?=
 =?us-ascii?Q?sEkJe2QOW4LNvsFB0jGhKtThiPpzOB1oeqqenEmn0x4Td1FjB2l0/Px7ICI0?=
 =?us-ascii?Q?4ykKqvqO6hnrJ0GNSmefdSDrbnu76EAIoxgxzGBrRyBvQtrOj1FULrppANhX?=
 =?us-ascii?Q?uYoWLyOXBAHCFfRshWFBlAnXjzc2pRfxoBFkn79C+8dbaYCUWTz5HuDj+wWI?=
 =?us-ascii?Q?P+r/l7Xg2gGIFYl5j4KvAbfwypSpU9wTdZctUsVmdsuXPSyziV+fiLDHcYvY?=
 =?us-ascii?Q?stNNJ6DJDqt/X/iCdfyuj1vwV1anPkky4biU75MiPi6AIybU8VIhXud4keqO?=
 =?us-ascii?Q?WnV/byQZgw/gw5kFL/43F6vt1382jM/jZI8k439RDB3GaAEQ4+Uw2YYTiioB?=
 =?us-ascii?Q?2ycf133X4UNSx0DUYxFFXA2yjxYS5wp6JuRCCayi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6183d7c4-fba7-4ebb-a6d6-08ddc42fa576
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 06:11:47.8106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m0t1/N7b7WShCYd3mzL8P41uaL8DlTk2w49A72yWCK/M46PS1LcK27gQ5toT4AedzXJ/udojoJnMjIIc+Y0fgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10102

The wm8524 codec is connected to the SAI interface. There are two audio
plls on i.MX8MN, one pll can be the clock source of 44kHz series rates,
another pll can be clock source of 48kHz series rates.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
index 33d73f3dc187..145355ff91b4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
@@ -387,6 +387,11 @@ &sai3 {
 	assigned-clock-parents = <&clk IMX8MN_AUDIO_PLL1_OUT>;
 	assigned-clock-rates = <24576000>;
 	fsl,sai-mclk-direction-output;
+	clocks = <&clk IMX8MN_CLK_SAI3_IPG>, <&clk IMX8MN_CLK_DUMMY>,
+		<&clk IMX8MN_CLK_SAI3_ROOT>, <&clk IMX8MN_CLK_DUMMY>,
+		<&clk IMX8MN_CLK_DUMMY>, <&clk IMX8MN_AUDIO_PLL1_OUT>,
+		<&clk IMX8MN_AUDIO_PLL2_OUT>;
+	clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3", "pll8k", "pll11k";
 	status = "okay";
 };
 
-- 
2.34.1



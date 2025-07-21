Return-Path: <linux-kernel+bounces-738919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A203B0BF0C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52F1118815D6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FE6288CAE;
	Mon, 21 Jul 2025 08:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dghKB9pL"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011056.outbound.protection.outlook.com [52.101.70.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858A3288C06;
	Mon, 21 Jul 2025 08:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753086921; cv=fail; b=pT7wPD8uteuyzRjSWgnYEGpy8I8Zl044UsZ+iegkd7pNie3VeEhhfp8NOMVdLlhQxH6GTdszjrvd0ncgp3JXRd/KiJKxEzBozloBNPpBFLrFCjezfVt5V6xF3jpiK6YKh2aMg06Rh8JgnzQfBrEnwEr0TpKGzW01AOzvsJDJPek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753086921; c=relaxed/simple;
	bh=oG7hINMvPsIvR3ZJxXyUQPGu5A6PnpcikzQgbdp44eo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Owpvx/BMEQ0YVL3q2uOdJP+GEcHmvNfGJOiwFaSNHF847HV3VT3imE0SQPlXJAV1E5HopXk7NzAlkJrmPj+8kjvs83a+k2b/KZb6hzLsb6GtUgEfaypmB4b1mtlZpPFTnuf96QUCC/A4tEiSogS8cdoTn80EACVKvD6RAJf7xLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dghKB9pL; arc=fail smtp.client-ip=52.101.70.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y6u2Z4Mb/21vqGD/aN3z1fS3O5u5N3FGGzWwW+WhHc4CQ6C8g6JQLZxjRW53yBBgiPfACm6W+LU3ZyUng0I49mbu7BSx+tHuHZKK5zvSvjowcTgUIIo1vbvcBE1lf2hlaBMpxXcaEPxMHe4WQ8+rnm/GNbu8GSapl6yNgpdfDgzGIYTklJwW/2MgJr9aQKx3iZI44wZ94UDIKYLFXPMBY5gScAuy3lOIwmSp3oTfCBB3i7a8xScinjH18amCHQsYzFcSZ5FLLE0Y8cigpetKkz0o+p9oYlz67+k4ZP+zStctFvSJCqRuDy5AED9u+0KWhhhIu+fWnU5pP+9Ae2yVvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3K94yifV4gSSqBELwb8wZ+/k1coPBg69fCGUlBmZqk8=;
 b=fUtJpxqpPDYtVPqbVkAPULVfRwXs2yAOZvk/1LBR54EwBNawqsv7uOGBbrCoSpRnSCCkQVDD1KrLtPY5YYh89MzbJJRPN5OozyXUHl5tpa6bAn04jPeI0py7FgD6dD7rLEB6brvJc7eMzUhLei78uDY3u3QXHe07vErcqzUbzsE+DM7PWiIcqzhEQAG+HciAPIKoJpNPbjCRDVAIdzbIVBs9jSrBUWpkuJOFasRysTiVC8PjowpKkfJHOMmyv56ekxutfYcdfiHLAb2OVMZxiUkHB4s9F4Z14HWTxRcfYBj6FN5u575A3IXPYas/T1LWsyjwDe3e19ITIHxqZnWlWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3K94yifV4gSSqBELwb8wZ+/k1coPBg69fCGUlBmZqk8=;
 b=dghKB9pLotD0f2/MKWtBAwhXQ3n9KFOrN/i1qRJuOGJfjPecxinRiaYta7EvgPYpIjRfA95O7XFfUrZopjskucqN0cHJtcyMf3lPQxccn+iXtht9GllOBHiVUWS0wwV4hN0x6neLECfmscmMEwzAJLPhLRvq61q2/aCPb6nW/dr+LJJqN82PQQgEuiUicEbHMsPYpN6kugyekC0RZrPNxuKMVUa9JXqMFVRuZTvTZ/cYnwy7uyJI7gu1UOgYnnEgG5fk6cZoWoot0YG2T2BIkAd4jMgrfA7wRlwljqkp4wJgou5WYXyZDibMKjRd6O/KwiIW/nMFmn0wTMsPTCHqJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by DBAPR04MB7223.eurprd04.prod.outlook.com (2603:10a6:10:1a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 08:35:17 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%5]) with mapi id 15.20.8943.024; Mon, 21 Jul 2025
 08:35:17 +0000
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
Subject: [PATCH v2 3/3] arm64: dts: imx8mn-evk: support more sample rates for wm8524 card
Date: Mon, 21 Jul 2025 16:34:33 +0800
Message-Id: <20250721083433.25711-4-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250721083433.25711-1-shengjiu.wang@nxp.com>
References: <20250721083433.25711-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0022.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:179::12) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|DBAPR04MB7223:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ed51ca-e941-4b33-c223-08ddc831850b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BoM9eeLJBx0fKt68NQ8W6PqIt5YsL1vuXh3rC9COEV0FWY22TpD2L8yUXbXJ?=
 =?us-ascii?Q?Bna71Y6hAQnKH/RP8ZV/q1/SPoqEvaKvQwBfpCBOzdl+Voaa812i2i6NIMEF?=
 =?us-ascii?Q?Z/bDcgOBIw0Q38+5ZLDbv88mUZpto3wx86XXBWoSr277uq9D62qjhgq6R7QS?=
 =?us-ascii?Q?vyH+kkOENNihnYOBv9pTe6hx5e3zhwGHSJ+m9c4YItgbDFWmE0mXMMU2Bhvo?=
 =?us-ascii?Q?OZi8wuPfWluR/mHZyeuYJ6SqoHSvxRJRS2iz9aJlrY70xhk5FdXPVUK9Mx/p?=
 =?us-ascii?Q?JZ0qkbEi6Vb0d3bSyHsuH/V4Ana99+Fe33wQpSQsD0xHufTd1JRToFBW1zLW?=
 =?us-ascii?Q?iB8AT4EWyIQNUUs7P1VSwV+iE32JN6Tj5Fq45ueCIGOU52mSpFXjmY2iLifM?=
 =?us-ascii?Q?Jqk5xxMciXS2OW96H34KjKtRFHR213K/sgSGaV04HdwYf2KAP/QVOkt116Ti?=
 =?us-ascii?Q?ytfGUBiL/NiB31xgi6nnOkhBIzGw31tcBap74w/FqOQx+v8aWjiIQA9wCT7c?=
 =?us-ascii?Q?WrW5XiD8241/XShHIkGXasXEGYZpfCenecXIXD3f5KqCBJlQFP3i5Gr7U6pW?=
 =?us-ascii?Q?a2mpTe3a3R+xExxcecd4Q/vO35sBiSsh5zetD16y1GGAXbnFSDy18V7MmBjf?=
 =?us-ascii?Q?YSgAEJczn8SM0ShTlnyRmyfk19qScRV6SNrPb9PWlXe/aVXK7Bj4G+6NQKzn?=
 =?us-ascii?Q?JmXL6Wn+Bxarm/jIrBZ6bkiQxhieXXZ+VYpPWFDLprSQBjrR+V8yDJrHGrIb?=
 =?us-ascii?Q?FbkrGxgZhTDYJPtYRZkkVk0B2etSoFrHcyZzVT2CRQGer4fr2kKnpOrhx3VU?=
 =?us-ascii?Q?iE+0eigDrITRQAEgua/jvC2KT16x7LwW3RU5fcQaDlvt4LLouuNrLvDBFNbb?=
 =?us-ascii?Q?3b7BHS6SXAiuBjPxugecCJmvWXiJCZWsi6j04v8J+JIPN5TaL31NWfhazaH5?=
 =?us-ascii?Q?4Gxa9ugJ0/05nk6TV0tNcrQNqyU3jbifbmEH6rqJMGejZjmNDt4LaZ1MfvEk?=
 =?us-ascii?Q?FxLwBZsx7eaXvl5ZkDzm/V2Wh70+N90MbV3oMa8vKt8UJqN5Nf2BbabBTQ49?=
 =?us-ascii?Q?VtTfjDewhHifbYhmN1Y8gbgvvFvIRaVrj6pjLhu3Dl8xu9FFXztM0HwuZIbA?=
 =?us-ascii?Q?7AxBAvW7l9AY96984heuN7un3QsXapRzR5k0ahoIXF2pymZ/1hyPjDGmNfkz?=
 =?us-ascii?Q?jyfi3LJqozzO0WuiK2SO+ZzD+CIYug/EKO2iO3KR5dOwartynAGflU8KV1Ge?=
 =?us-ascii?Q?oWYcGTxQr8NPYrmapsJP0FyDrxFg0fAHeDpOalvjQVu0CNOtoro6YutkgyFS?=
 =?us-ascii?Q?lze8gkRFe9WPT7GYOOm8lcx3orL97j2d75lLntmk0d8p8ZqPmniMFOou40RX?=
 =?us-ascii?Q?rMrbf9zDmAN+OxpU8Xp7njbcHB1S19PN5DDQFUza8DDo15ek/t6fd6DnAjAR?=
 =?us-ascii?Q?YmsvjZYQUVBGaOMYqpdk5uwOd+EH/8ESv19qrx1wfeoUFRQOZAYe0VYudDqj?=
 =?us-ascii?Q?zK6NqDSkoim8wy8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zspj43b9l0DVOShNo8SwPMpGVXRfbdFXDxGqvRFWSqnU6b/tX7yBSKBUfhSG?=
 =?us-ascii?Q?O9PXmRocAhnK60Q5R1+oFQgPrOSdzxZZIF+R2lvHK9+/RyYjyedLLOjCL2kG?=
 =?us-ascii?Q?ZQ2AjO23sRXp5LFKeMVZE67tpTEf0NJVU5trqiB/HFsp18LOoJataF0oXDeu?=
 =?us-ascii?Q?nZJJ2EBDSWjsPQlyTHyvsA3TSxMi2YiPVkgHRYMs5oF8z0mUqDGdmdBakNuE?=
 =?us-ascii?Q?ijJkdmEfhJ0+ta52It4427wyJ37fEfOSzQC44TjD7F2tvvDH5DARzEWz6uGi?=
 =?us-ascii?Q?jrkua311TFm4icxiWsDCfSlycoMhAK5FOp8BrTP5v+prYGVjNgQkvre9t0wY?=
 =?us-ascii?Q?a/I5I0KeOUMf/9NhMKaNlnoihTKRmX90aseBGMVzdfnPZdfK8HRNTzvn5DHu?=
 =?us-ascii?Q?pyGaRPQ/8+sqHFb9GV7s4eTHUPRPYXravKZE5G/d8BGLHo/uy/ZwCIn/EL/X?=
 =?us-ascii?Q?kXYx0NUJqQcHSJjafp0t24OzU6GGG3xKGNyoPyAtgyhnAu7s95IM1UNFWpVI?=
 =?us-ascii?Q?1nOWlC6mW8t4W3L3WtrH2mOGF9jB5tH2dIR594Am1yhmWYr2BSm4voExxQfJ?=
 =?us-ascii?Q?RCQOuXPP8HidvGhs3liDz5ZG+2XTccxtuFW+kVfn4PUkyDuZFd7yrIerL9r2?=
 =?us-ascii?Q?pwHAf8Mqlc1uHv/cUC3yWwyZk/cLIz1Ut5hFR1n/N+Oh44tNMaTd8gs1hltc?=
 =?us-ascii?Q?ZS2mLlJer2kZ7JF7xBhsyrvnbaJRAtm4JBPNKQRDrEMxpK2kw5HdPnHfwbSm?=
 =?us-ascii?Q?AaqyU5wuQ2tFNqKX36hpgY1ac02U6DjvY6Nthv2uKEDf97gHXi6VWnMdjs0I?=
 =?us-ascii?Q?BQaTi6qb6ZlG4V2LmNYldBkUBn/qOT/4QZFGWv1MmaS5TsNJIS/q7zH7/jyf?=
 =?us-ascii?Q?diS1BTKUZ0p3GVI6NeDGyQCnCoUBBQZsBJKhkfpaOpfkh+wyl7/12SVGaOsq?=
 =?us-ascii?Q?QaYq6iwJGTXaNhWR7/O4HibrPVHifVuZuYyWhmJ+wuIKDOMIOmwPEPAfaOCk?=
 =?us-ascii?Q?Ls9Ojx6Glxey+qHipTQi/cO0Ke/6fQ8zUS1tQ3Cpql/MzHUQIeet90Y+ubRD?=
 =?us-ascii?Q?iuBU3PRmjQLn2gJF2mUGlQb0d+9iHESiOWh1xBB0RVL6oawWLLI0ADP7C28t?=
 =?us-ascii?Q?yV0vIciLyAj497mPDHZgMAzMScSLTtao4PM1/11FlNttzyd0/J28CJhtGyk/?=
 =?us-ascii?Q?NMHtt5qCgbnetLqZuImShEivBS2Wj9urqbHm4gHOYI1EeWU6T6adTlyih5ug?=
 =?us-ascii?Q?iPMaxxhmOMnuGW+XanggwSyI/XSa4sUfDP06mge7IClz9iSS7a4JdYTalu4I?=
 =?us-ascii?Q?D0k0jfkll5OWkIpkEkc/GRJODXVLbsqG9frk1PQmDZyAG4dsHN+KLjVrSata?=
 =?us-ascii?Q?u2YxeonP7Rj9EbEdCsNwLsYUD2HLyqRu+aVCTZZy2XaClwgQBzjetkjeVGZ5?=
 =?us-ascii?Q?IlNOwdCaQwT9f+cx0ODUmcVYM0UjAbVmx4fZkXTqG7M4qWRrNWOxW0PUXhqd?=
 =?us-ascii?Q?w06k6A4Q7UVTglzhSc2bffF41jDyMkWgyAg8nq3aPyGJ4RBnEZIMD/JbqTMA?=
 =?us-ascii?Q?W9s0Y1QzEiGPHSJWKLrs9G+yKYL8yZ6X9dOVBTfM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ed51ca-e941-4b33-c223-08ddc831850b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 08:35:17.0643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4SBYOU4/JgSl2z7NyR3Yd6Q2rJZU+9fB+7XEwN1okROOCAYU2k6LfeaymkeViVfxv+rCkKJ/jj+UvzifBLl4sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7223

The wm8524 codec is connected to the SAI interface. There are two audio
plls on i.MX8MN, one pll can be the clock source of 44kHz series rates,
another pll can be clock source of 48kHz series rates.

Previously it only supported 48kHz series rates, with this change the
supported rates will include 44kHz series rates, from 8kHz to 192kHz.

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



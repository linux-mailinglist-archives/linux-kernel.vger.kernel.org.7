Return-Path: <linux-kernel+bounces-770718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1328DB27E2C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7265A5BCB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C702FE040;
	Fri, 15 Aug 2025 10:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Gc8nhDKA"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010068.outbound.protection.outlook.com [52.101.69.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7302FFDCE;
	Fri, 15 Aug 2025 10:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755253431; cv=fail; b=uHCX21Vd3oqOnYnWs6lBG0Xk3g8Swcm+t1bhkq+iKvY8yuFNAJeLdWtpwiSa0YDlrPIDGe9glCfQIjgqd3voySHwE+8AUp6DN5eJp0dwH1bKHdKFS2jY96kNC9FgztQmRSEukX3trUndK2gpTui5V/P8/+jQYZujXdCQWh3WxV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755253431; c=relaxed/simple;
	bh=T+maRZIoLtqXsqTe2AZbdjl1PdEJmTML7Y0dNBVzUNk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s5M4RkJVTZfK4vp+/iPDdmfSi0SEOgo3/C/jkye98o3R2PatW5MQyG7/eu2loEGzHyl/zm2ODkn04hK7KPl2YhjDATnCFjISRWOvq0+xUvIZZtcPvNT9MTrz9XCPxvXvR48ousniNyKYHsOvf/7qFGGun5Cz7aHBJhUh7U85HUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Gc8nhDKA; arc=fail smtp.client-ip=52.101.69.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RLkBKbQTA+pOkBzp9IuHAWGM9ZxXpiwp4uNKjkK7bWCfH4ely02OZukfWKB3AGSrs2manN4UKPwUy4zV3XVxn/HwoTYYR11kAFzRC6qQfc6w8sZ2Ao4LPmrStFY9Is21TDx4qdd+F6TEVnLms1fdCUI0D+Qc2JDDR+ZmELNyVerb3xdJMGTJ8rI2q0YDQ3EHGufRNgg70iw271qFfxxtC2RWIGOzCxvR0F4YJ2QgOuHdEP+ZiVvdCQRFuGjhRdtvOLcf+4dHNb7D3TYBH8K/+rAtyYCYI51z2rPwBmzrpmKS20DXU+3SfBCf3dkYWqfrSwJBAWeR7Rp315y5DJxhLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ayMgB1ot6r44u/kMZIJ/di78WkQP7O9bb5QT75RvIo=;
 b=JfgvdHdJIN9uytbJPRlHxfDLmFDl2FZ+NaEdnBn323Zy0wWZz8vmXfhkg75I62047f4djWniPQZokKsvLCinbefCoUNJG4993oA57VM2+oNDF50UWif5zDHV4k8BDLhNZyR22jtOsIZ43fGy78uDTZiMpOiTdF1A3ptUapKjtHGE0PEitwdTX4VcHL3eNe1Txtqd5pVHsF62eU/RhKv1u3EV9eBUgOfM8cI8KUBCSr/c3G9LhK+8enFUv4WgnBmIJ3uFmcDIAPOccJkjz/VRk7jFAGm5n35SaDKGFsUgIGjah/rC4CsoZYCRLpunnkLDoRnFYlnfi41mlKKBHEfY3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ayMgB1ot6r44u/kMZIJ/di78WkQP7O9bb5QT75RvIo=;
 b=Gc8nhDKAZN3o2mt0C+BbzPR1WNfGPipsVlm1roQNdztJ8rhw/jbROHfKFT2F8RSBb1XSjH5TyVKNTw/HctggrHW2OgbarD38H3SzRTBaIZdbWEDEy8tIueqXvebiNsDKyNVP8cUP41hRCPwgbEF6GH71gVEbzdLP6p1RQevm8m6fTbQ0Tl5ilbwZs89f9Ii+4iHuHuMYKbo5EhdRPtVCsuflVMRIFsQ7HaRKq7RY7qGf2V5RImjwuc/9SyA23FmPMcPFP2WGo74xahQTcZaZ5oHB5OwKZ4RJ3hYHSChDIp84ibqRjGCSGzR2k1JlczYKIZMe6fyeYoTHF4f4q/RBjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB7055.eurprd04.prod.outlook.com (2603:10a6:800:123::21)
 by PA1PR04MB10178.eurprd04.prod.outlook.com (2603:10a6:102:463::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 10:23:46 +0000
Received: from VI1PR04MB7055.eurprd04.prod.outlook.com
 ([fe80::d6ab:1538:d868:bf8]) by VI1PR04MB7055.eurprd04.prod.outlook.com
 ([fe80::d6ab:1538:d868:bf8%6]) with mapi id 15.20.9052.006; Fri, 15 Aug 2025
 10:23:46 +0000
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
Subject: [PATCH v3 2/3] arm64: dts: imx8mq-evk: support more sample rates for wm8524 card
Date: Fri, 15 Aug 2025 18:23:16 +0800
Message-Id: <20250815102317.910014-3-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250815102317.910014-1-shengjiu.wang@nxp.com>
References: <20250815102317.910014-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To VI1PR04MB7055.eurprd04.prod.outlook.com
 (2603:10a6:800:123::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7055:EE_|PA1PR04MB10178:EE_
X-MS-Office365-Filtering-Correlation-Id: 2badc3b2-4411-41b3-7508-08dddbe5d15c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vhEZB/HxYyAA39UJSuC/ph2XPF4Jj3qMyQGw+23BWW13EXlMjgAYm4lCecTx?=
 =?us-ascii?Q?t2qqfHjIqGZgz6c9gKxxFi8741B2KNyyLfmq/IM+JNH+NPG0y38c87DmCEtq?=
 =?us-ascii?Q?kpuKqVr0LdJ5STVG4vdDPffPd+m2lACauCXi3RUyxjowHmbEu2YHos8fS1TQ?=
 =?us-ascii?Q?eXNkkNRAmnzcAWIcGCUiVZBAnGl4Qd0nNhhQCZpwOq/oo14uJlRMVvaSBaXj?=
 =?us-ascii?Q?K315a7sJpIt/WvMxt8NJ58f9smnM2sdo1f8682j9Hhjaf0+HyitYoADNYtlE?=
 =?us-ascii?Q?wuVF5QdTCRNSS2B4hVhUj0OBd4omTpNgNYksVUGKqH3n2M+OCbt9IgvbRNDA?=
 =?us-ascii?Q?6Xe9ztzy8GanAeZdYZnytGhFW+Z7GIN1O9VOqRdXMYsw7atqEWSqUPLnFK46?=
 =?us-ascii?Q?YvdA5tu38paHxd8msknVP0iwRLhEoxmES5HcGpnJMEXbGuT1vikFsx3zPOJK?=
 =?us-ascii?Q?39LcK2AN589x1O/MG9fHPjp2uI5kNjwq5JAvUk+ZTodkudD1b/3X+KMDTHzl?=
 =?us-ascii?Q?cjWNDaTkpy7VPyDLOj8LuH8srXz326bIDHlES98yO2nHt98vFUFA6A0o/lDY?=
 =?us-ascii?Q?QPlcQTaCncSuL5dDyym7voJrMZfTXrDycUverpwx7dfT8/1lNMz0LX+7RMmK?=
 =?us-ascii?Q?E61bh+KTES9kQcb6RL/obQinkSvWy5PSXjOI4HKdvfK1B1C1woQbmB1JVYFj?=
 =?us-ascii?Q?lZrZ/XEx2tr6q4AsdGbdTNQQx1srOmvUX6cF+n/7y0a1VF1EcoIIqbSJ4Kqg?=
 =?us-ascii?Q?NgZzGg5AGxYlEVXx/Mmi2rCJk2q+4HlKtQV5LEbixC8BlyUKEjnl08DrtO1s?=
 =?us-ascii?Q?LPkBAZDlu0XErsE11LTngEssZcAg9TUk/X5n1Dyck+OElJ+wghtQRK92jsNd?=
 =?us-ascii?Q?moFEWLG1KZrz2vF5q5mvc0KADmK0QtQD93xAQIyDH8TJuz0HpcKcOLYB49dB?=
 =?us-ascii?Q?Mx378HjuB5Wd0cKcxdAW/A0Qt4K5I6zpSZr5mfUQBafO87gyDhLevgg3EqHa?=
 =?us-ascii?Q?23J+Llulj/k3dPMQ5GGlP+zQpzVbAl7umJVKzT27F5Fnr4Mi9CqQl3bWdAXo?=
 =?us-ascii?Q?OuA17KfD4Wsv/MkIik6HIJPNITVBbMUJRWkxY9dYTeJJNk92s5yTHxA5kECI?=
 =?us-ascii?Q?HmxR1aj3ndraTBIELdbdngkAPQCr73O4CChjENoJU22YmveS956VlwSJsYye?=
 =?us-ascii?Q?OvAR0WVo/jmf30FI21OVtXYO9T7tmJvq7hKK1UxFluuuD3D4YNFYN+6Yf5Ru?=
 =?us-ascii?Q?pvqh3sND5sOCHM/6kcpBHV42Pqhed2XlBZnpFCGcsPnauxdOmeLccHV7+cCc?=
 =?us-ascii?Q?+ZBpcDc0AITLdZRyzHnI12ekOvzrOOXN8FcnlLOMOzhC3PdBCbvJvdxJLb3T?=
 =?us-ascii?Q?FEpo41E8nzXoLjyleu6eoyOdiO5SC6n3AlBIePB77z2ab3qiXesnYkRTx5dB?=
 =?us-ascii?Q?XpNLdF3HjG5tIfygBxfA09ak+KH/2j0tmmvnMTBl3f2PyzsEu9EI8mlh3AWF?=
 =?us-ascii?Q?gAkYZDbk26C8Qgc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7055.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AX81GjJ2/w0yE3vudPdNbKjaR1WciJF4NHRJThfykxqfCCdf3PnAFoVPWBrp?=
 =?us-ascii?Q?Vi6PFmfHE95R5QCB7W/YMjAsYkGrr+68S/dTQeKUA2dI4gKxDSoTfFDTnxuj?=
 =?us-ascii?Q?a86jW1MpfsQeLDRMUcjjbovqBM3DaOg7W1q2PHUl6WQUUk1Hc3JLRmCkO1rd?=
 =?us-ascii?Q?AZFp1MkwFik0RuLoGpNWfgdix2ivJDUEySN6KNHu70gLTUvT+3LoQ0qkOmVY?=
 =?us-ascii?Q?KhTw0Jqk6K8GnW9O8mESCkqssgvpSrEXidZfpf8gVXJKnkWiJUppoBVquc0H?=
 =?us-ascii?Q?sOA62cEEyTE+rKTNDUXc5s5b24R4fBoP72xgo/jBRljIcpBJ1ZrHYxokO9r0?=
 =?us-ascii?Q?gaoXKPg9EF2ManuBitMMUvNHtO9IRxYSzd7Hv8hi9aoIqZxDBt13M/N4Ztwp?=
 =?us-ascii?Q?8wCXOiYM/dDJBb6rMToH9rEN6Ul10qr4gzdWeNaKTj32IQUinof2F9DCo7vL?=
 =?us-ascii?Q?r5pug6zC3pgLA8fsZb6eOTwETgkWUn63NhYcqu+ZRh9i1uA2RypgMjmXq1Pa?=
 =?us-ascii?Q?yNtykNNciARJsEo2z7C3HIaamnwvU/C/z3Ek5oL7X0iXFPoxJloRtbO3hYFv?=
 =?us-ascii?Q?0lArELD+uKuQgHJhvckexItFHq+bBG69pNU1UkaDIqB7H+b0XNLNi/VWO91f?=
 =?us-ascii?Q?K3FkklRdRKOtDWXf9oCmypf5bGLdO1hWZgjCUxQkFhNrekwsiRVdAWUC24fB?=
 =?us-ascii?Q?vTAW2KUMQTl14Qgm+A7B5ovRJX0LRdgoMcEjZ77VCHj4uNd9LTDxXDUjliAx?=
 =?us-ascii?Q?lJl1m+I/H8Hs6mK5uF/4O7Nh02n8Gn3iShg5UmaTxMvmnbmeazDhl3YTOm5U?=
 =?us-ascii?Q?umFppgfQJLW3QGjDomtOanQoDXybcMbbPQ2Jt2xTnyjbY6bXjaR177hpVJ+M?=
 =?us-ascii?Q?KZ5HRGTiSvFRG4ioXTNngGW4GqbRcSQHQDNgy+1DZrTAsqxRXx258D/w+AbZ?=
 =?us-ascii?Q?OFusQ/K/jkDqSimPBWnXSKC4mt/TWOQupvQ2IJV7AVY1ZCJACwf2Arke6wsP?=
 =?us-ascii?Q?D/BghwRzaz4rbcoofefixZ5OeymqiWeFo8efH2WWU9d3AKnThQOON0k1lYjR?=
 =?us-ascii?Q?pJoIs5gXa86L6nSCizKS8p1Y4Vh8ayo9jnmVEnGxzbnKmnVsKPauldlA3cxf?=
 =?us-ascii?Q?P00dapJ6QamRBFiJDvWGeN/CzywK2SWRv1qrtjcq6axBHG8rkuJdnwLKOARO?=
 =?us-ascii?Q?KPIwQrHwEgAhZrgzgx3IekhFGTD6IMF3TEMc7wc+EM5Kopapged9rqvX1pdz?=
 =?us-ascii?Q?WQ8PYgv4+BV9I+3gPtVaFycTUsPQTxvgYJpMyVI+NdXjTNHJjIzOgo1eE4hw?=
 =?us-ascii?Q?xz8W6L0zBD6lBcqgs4Q+00fQOAMzN0wDOIStE7nIsorfFy7gLCrULIsxWPae?=
 =?us-ascii?Q?oJW4PSN6CofxBpB5yJRe27pENDkiRFfgCiKrfB6Zh2rJ0IP2VdX0FaJLDOA6?=
 =?us-ascii?Q?k3cj535vtQPdZ4tB+jZcgOyU8w3r/1EvAgHmI+4byqbaNLhd1Pv+k8BRRrqx?=
 =?us-ascii?Q?IhAb01fsggmBiSLMnWE8NcgAZhG8cJ674qBIlwr+zwGbR1E/kx63G0REEuEw?=
 =?us-ascii?Q?5GqZdTYhnjRRQfKffC3q+Q2cAcRvPDzIQF/OMN70?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2badc3b2-4411-41b3-7508-08dddbe5d15c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7055.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 10:23:46.5982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z7xP60Ft3oRAVpm2/KI1O0GX36yS88o/GIkAs+0/Dhns2N6az5Z2/Oiv3dd9/wfG8tJrqIJzw9ifYv6V8AkybA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10178

The wm8524 codec is connected to the SAI interface. There are two audio
plls on i.MX8MQ, one pll can be the clock source of 44kHz series rates,
another pll can be clock source of 48kHz series rates.

Previously it only supported 48kHz series rates, with this change the
supported rates will include 44kHz series rates, from 8kHz to 192kHz.

As commit 17cc308b1833 ("ASoC: wm8524: enable constraints when sysclk is
configured.") make wm8524 release the constraint when codec's sysclk is
not configured, so configure the cpu dai's sysclk to support more rates
with the 'clocks' property removed.

Add mclk-fs property for the sysclk ratio, which is required by
calculating the sysclk, 256 is a common ratio for audio.

'system-clock-direction-out' is a required property after
commit 5725bce709db ("ASoC: simple-card-utils: Unify clock direction by
clk_direction") to specify the clock direction.

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



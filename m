Return-Path: <linux-kernel+bounces-770719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCC7B27E2E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D0C34E5BB2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133E93002BA;
	Fri, 15 Aug 2025 10:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GCaREZp+"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010068.outbound.protection.outlook.com [52.101.69.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F5E2FFDEC;
	Fri, 15 Aug 2025 10:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755253433; cv=fail; b=cFxOTb5VcgHhBCWr/QrRC/Dn35eey8NRIyUbCTz6TrPUUW7yyNWDKP3rzuEXZJddJfReIG1ctlv53gUqj3GO/OGia857a2vjRoKYDOq44H/uaLPGNc68o07mtsxXorJNInwtvXNjvRA7i7vuL9xDHx6NhGLiFrkuUBmXtf9ve+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755253433; c=relaxed/simple;
	bh=oG7hINMvPsIvR3ZJxXyUQPGu5A6PnpcikzQgbdp44eo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gp3aYB408kO5+O1vZ3b0Q/WQfmt3+ClUJPqLj0cc0RAVfwwqxuuzx2WvMvtFJjlnYyMsa+MrnZzOrlXhobHvXb6xCN1FASQ5KjTrD9um7SM6gDkptODiMq+/UtkOJCkF40kzP4BFcCgW/MNPv4Pd8JzN1SBHNMl1N0a3wgY4bRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GCaREZp+; arc=fail smtp.client-ip=52.101.69.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0jZD8pKhlpJP8qCRjcdv6YEUafzmgumJp8i5w5tW/uRtUV0Uz0RNgsNd8UfKTkYLQHE5CwSz4l0cYULcazWv887froohq4NxmtJIKhcroS9UVAeaoYTV/4VStECRh0c3NkIeBcHBm1jA5+mcI7jo4bArb9OmP+Yo8qTAtecWWX9B2GVpxmzVAP7x2r0Qd3KXOrG7vXSu4DP1oRw8x5tYVXhQTufiUq3f2cwXjtAb5YI97jJ2gf18Wp7G+ocWTVmmWyBzhsggsuTodEOF//pfXOKEsgmtSC5jEDDc2iesfhGGDsL74EKAl29CRFCBHXpQLI/v4C53lxozm/IZPXRgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3K94yifV4gSSqBELwb8wZ+/k1coPBg69fCGUlBmZqk8=;
 b=XMMbiJy8V8TdXZ3HdyQ1SGjcWilHKBi64Jci4FQZ1KuFi/mJEQaVbE6W0oZwFQAUc34p8SuzVhTVJszHt05MAGqAftz8O7dqYNtVL6R/1rvRYGOVLn+fuYQbYtL8Q1+9T4DDcqfdkxPFG+qA5yiabJ8Nh8jyzfo4NIulDgOXNif4rMF9FEVIAn3Q7TWAim01fgYYYQE2hY9Spha1yPoeeQH84fhVhpw/A2idPGipWXg2G5Qrpbi6pPCDspITkECtqb85okmfb554cJXZYhh5kNlwHwwfnvk8eawLbtSYlGLQxCn8OXOpp0pq/2UnrakpK/wZWS2EY4ceDdMUyfkNRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3K94yifV4gSSqBELwb8wZ+/k1coPBg69fCGUlBmZqk8=;
 b=GCaREZp+OWc4ZSSTfokNgk/T9aGzmZil/eagBFOowE1Q6tjsJsO0cY7eLNze5hRkmUxx37642VNFkQo8/9u8dK2xN9hpslYV5cCzP1tqnu0qnTJq+9fVkECBpV7gAllSBVLXHyAyc8WLZTXklfaMIIfhVkMWwi24+4RXeu4jGUA6TOq0vxGu5jSfUvnsAiLBnkzs/QmI98MMWGHsFrhPVH76vR1tPwMJzxaHcbBX3Q1EXRCJMva77eBNPxP0mkvasFpgmgkxMQeprPtGaTCNMci6xjVjk7pNW0affwaPOBUrz7Fh6RbU4cp0SAoxwfDK6B/RMn8oXHElGU+mHOYbdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB7055.eurprd04.prod.outlook.com (2603:10a6:800:123::21)
 by PA1PR04MB10178.eurprd04.prod.outlook.com (2603:10a6:102:463::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 10:23:50 +0000
Received: from VI1PR04MB7055.eurprd04.prod.outlook.com
 ([fe80::d6ab:1538:d868:bf8]) by VI1PR04MB7055.eurprd04.prod.outlook.com
 ([fe80::d6ab:1538:d868:bf8%6]) with mapi id 15.20.9052.006; Fri, 15 Aug 2025
 10:23:50 +0000
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
Subject: [PATCH v3 3/3] arm64: dts: imx8mn-evk: support more sample rates for wm8524 card
Date: Fri, 15 Aug 2025 18:23:17 +0800
Message-Id: <20250815102317.910014-4-shengjiu.wang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6ce8db0a-d445-4573-bbfd-08dddbe5d3ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QahNuuiLiNIaXk67lgqV4NaiRff+GVjaJHyY7YvOTgsq7dVmsKAIgaK+72P2?=
 =?us-ascii?Q?KRxHlmwfYCNgSvMp4qlJ6Rk1LaaWv7ILUmplUaeaWGGJknRituh6+nj9ZCwG?=
 =?us-ascii?Q?wXJrp5qcxSE2O44qSjm2asmm/u6eppmvXtddsPiBgLrn7V1DvXvUxVnZXctl?=
 =?us-ascii?Q?viQy/a4BGhT1MVmd0wxOO5WR2vD0GBK5CQi1Oirs+W59zTxp0gPXCPhl1M0y?=
 =?us-ascii?Q?YgPzC6wh6X3FhOrLfGcyweuFnDbWTc6kXRx9ikAAjamsFsO2oO8W+hOJLrmN?=
 =?us-ascii?Q?7Uk7GI11IEk7vExL1cFbj0sfG1j18eVPMk+H9uHhM8r85pu4VMAfjlCCsfJ7?=
 =?us-ascii?Q?ghwtNB2uiFw5c0dH5jYVh1Q2EvGcfj+/bgUDmXZDIdWfdnpJd5qEDTvE3wzA?=
 =?us-ascii?Q?TquJ4z7jN/fajUzqxzaF+6eTYEx8ArIZDcDeRuy3eKLZ7rmC83DgBRr2RcwT?=
 =?us-ascii?Q?lEdVlGs/Sh2FmzArkWkePyO3tGHpLeTJHq3ZOhq4veqiJbpfC52zJ/gby0Mq?=
 =?us-ascii?Q?yuPmmyzXYcozL666M7En0CnSwR/17F7i5dI6ssu/90by43nk8lLKhoQahKxm?=
 =?us-ascii?Q?xSxdNW5Dww2VkZ+fA66fljSX/w9Rk+1A5Ho5DTp/Z4UKlKcmhWC1tOxqmGnm?=
 =?us-ascii?Q?uuLInQNBdUIMRLIQBSIMVGIk4BrfBoW8Pr0IbiNMJ6JqEBE4l85kZ/5Ns3+8?=
 =?us-ascii?Q?ywZQpBJ66F16UgwclHQa8v8x7zOMOddxMgMbrizxMlwNsign5sRWSbLxrjeV?=
 =?us-ascii?Q?IUFC3zyxyLLaGzkZj8PiMkkvFUSaXjt9qqATfEX8wbmvs2L1oKzDOivTQjAG?=
 =?us-ascii?Q?fOGcC9fPVsc4barJsdwJ4xGyLNsZHvHpmZhWOpsKsyUese2ptz/VNhKqLkz7?=
 =?us-ascii?Q?ax8dpcc3czdTCgvvHr9bgJNI9+tFlAFQj0hMEPGguap8OIogA+d3KE3QTyk2?=
 =?us-ascii?Q?djgdVHTo+1cIheqmpoT5hhyN3PWxSdoRhwOg9bj1zC4aSafBs9n0C8LGitLo?=
 =?us-ascii?Q?ibFagU/OwU6k4ENpTESSxId6QclqcnRiWGo/2pXEBXnfqyZkKRI/OIXwuqP7?=
 =?us-ascii?Q?Wr35vrNuC5mdu5dh44KEdWovYqc4MHmg+FJ9yk2EYuo0xl0z9Gb65aCsolKt?=
 =?us-ascii?Q?zvqTQngwtvtvyz+OVH4DD2q5RfMZ+QheJ9MPnwe4izwjvawFm2ltllLg13VC?=
 =?us-ascii?Q?GYEwK/e4ZOuJwZMQoblfV2BXmr+1d32uSF1ILNlIGbrsfqkd586e1qmznr8g?=
 =?us-ascii?Q?pfYabemjMTL/xObDVUVAge07dPSfkmsNFy2R88BC7GVjVst+V6+GeWB1hr7e?=
 =?us-ascii?Q?P6yhdS149JR3QoiGkZqLndPU3I+Vzbt314t3AGvFN8YjGKWlvdPWJlzTairl?=
 =?us-ascii?Q?JJvBi9yU7mz5B4yIrBDFD+/yIUJBxAnaXO3egmmhSgqA/92jJuulihydpf8t?=
 =?us-ascii?Q?NhHXnmwaiH0H9JOT4lHeEUd1tC+AP3kADYBFQK+EroDTpJ9uRanmUubqSWZO?=
 =?us-ascii?Q?mE5TC1AZ3l8Zw2Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7055.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JxUBeTWjL0fWb78IjVIgZhmMD5W3ocHbro8eHiFkPxgHiPHV0ekZXKraFcRv?=
 =?us-ascii?Q?56IT4tGCiFno68LWWdayIH00gCRJwB9uzuSx10idNNp08nafLl1vmP4gKE4U?=
 =?us-ascii?Q?2apjCax4AFzeMV5hg+tfcwH2gm0YfoEZT9TMcQ6Juv6w4056WKzW2WEiLJO5?=
 =?us-ascii?Q?PgBmIaq7h5Ewb+/4p8BoZZA/C1UB76MiovWUManYL2pcCvXREdE+blDnYVLK?=
 =?us-ascii?Q?RWF0naIFU4GAhd6p7PFL7cJfn1kYfgkIlVtdZfOe8/tSYyn9pZ5vqMAFSWSK?=
 =?us-ascii?Q?1ms4swd1/Xk5yB8J+Fttnrl/08gfQMXGDR2dpo48HflUtTPl3/3LvOoZJgbo?=
 =?us-ascii?Q?37QPHGyPvIzVduM6V9LUToOLPbz2ag8vBnbgUZ6yeANo63vlT0tr8WXbhgCU?=
 =?us-ascii?Q?sTmuE8n+SlBaebBUCKBnNLkrQX6JSSnbVHIFgnVkH8LENyGI74bvaACDYKl3?=
 =?us-ascii?Q?C+SgJuFrH7fzYaAXP24EP2OsV4PkFKLHbitibByCt03+N5YGyiSgC/DIfOr9?=
 =?us-ascii?Q?Ihkz9/HYGQLiC0nVGMYDIuR4OiZJ7p/4WwAF6Z+6sCcLODUaqzIOpMmJyB0d?=
 =?us-ascii?Q?bDNQuAvCgGBxMhBovbl6WbOiRNU1uYH2oKoYupubU9r0ruRrkJlLL/5tPu6g?=
 =?us-ascii?Q?UHD7V/aS3zAzfuK1iAogbPqRZTyiANe2wh/vPZLMFK31Nlwg+1/kMhSydpLc?=
 =?us-ascii?Q?3Kz6H4zkh194sB8eSZJjVOXbgo13c63Ih7ZB4bQwWvoVu1vmeBHR4L5G2off?=
 =?us-ascii?Q?Dpz+dtbs1ZBaGBWfiEHq6YzVKhCLW92qxN9xMBeh22N10L+sZ5iiAd9HQTdu?=
 =?us-ascii?Q?Os3UMiAd6QaydPzY0em7YGTG7q1dtYhHRvd5YwM73yZiC1pESDrGUZoly1wW?=
 =?us-ascii?Q?Cuw25Qh+FAp4P/PitJCs7yJ89+GpP37LJCuFw+/McTfrSI6G7zAGyJZ24Qni?=
 =?us-ascii?Q?A9CMYUMBiD9sPsS2wT/NnDEYeIVNac+2fIQg0Pk8W9DpdH9ApY7+26ezpKKP?=
 =?us-ascii?Q?2rBzRtngbHe5cUsqmHRIN1ymfip/QIvVbYL1D0SnMEwHcLFwjwCk1nmEjeI0?=
 =?us-ascii?Q?KwXb5n2ptTGDkbYtf79lDNwTMaoq+JD1pscglqQ49mo2xhxGKeGFqScM5HNy?=
 =?us-ascii?Q?KMHK4gwNr63irogzvwYnGahceOwZu0ZfzERKofcm0z/lCAAeOkJ8sNZD/3YH?=
 =?us-ascii?Q?aVjZeLDe7XTcnNmR44rOZ75F7Y+3l7FoVZYa4qcBpstQWiOTz3vTKyP9Cp6S?=
 =?us-ascii?Q?eq+MTCdOPd/7tl3FW9TW8PdlhHsNhOaSo0DKkKYlf6NfDBaQLHPYpEP2QFOq?=
 =?us-ascii?Q?IVFGa4APWKuYWw8994CAJrRwppm6pC8vsHI945K/p7aJ5ynecO5SWtAybzlq?=
 =?us-ascii?Q?oO6zM9qkMXuL6rHGfVDpMWu4Ee4Z9J2DucFD2ekDM3xFc8HtAzRdyBi7yRiR?=
 =?us-ascii?Q?s0lYFHm3CPx7UC7n293sYQbZHWMyGJLk9uPaJxyiQkwN9gZb6Ula0+ASu6Dr?=
 =?us-ascii?Q?DZURjIWhyhzWjxartvqrB24n3o7cOXvJsRO0gaECDFGDKrz7TOuDWVnV+wu9?=
 =?us-ascii?Q?430jYRHngPCMyIph9C3ztJMJ6oz8GEMSdlf9zbld?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce8db0a-d445-4573-bbfd-08dddbe5d3ab
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7055.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 10:23:50.5078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sdL/dEjlqkoBb0eTYywqao5ZVEjSIDivx5qUKbBqpH10kRWGKXkbqnI6dFS3ETKD/m+y/j6c/LX1e/J0JysmTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10178

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



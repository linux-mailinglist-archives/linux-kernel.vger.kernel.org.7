Return-Path: <linux-kernel+bounces-771174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 473FCB283D2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40DDF1CE6847
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE37F3093AC;
	Fri, 15 Aug 2025 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gCMyUkje"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013021.outbound.protection.outlook.com [40.107.162.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4397AF9E8;
	Fri, 15 Aug 2025 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755275508; cv=fail; b=PGjJHEpQ0xx3Td+/GFV4XvY4KFfvdx6woxm8FwlfnqpMh0pbKAzNjmaHHL779BwSIIg9J/mgLT/qluvep49F+xlvLlmji8G6V4K56KaEHPxj2yZx51MJ5uJo+Hrr6tPf4CDtVHb4INqmTYKgM4vhdq6eUW+3KNyhp5SR9rkhEa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755275508; c=relaxed/simple;
	bh=zlSmhNfAQu+X4gMv6D3cHbVM+II1zkmhUZdIqj5sVMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DGqI0lMypxH4Ab75XnhimfpirOko+H0fR2agSmEKqOPSsoFqYb1fQFHTBY+C8gQWB/cgTvqb7NPst5IlqqLkWcyE9a3LkmiqxjoqjEQL6XoVv4g34P5JGgujqIY3N1IFNZULD3xS1e1dJSiMy5sC2yYQNw0dYoRo04U13Z7mBFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gCMyUkje; arc=fail smtp.client-ip=40.107.162.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sM4KO3gSK/wCW2U7jQgZ42FcXQ6qmcddgAKbmQTXLQU91tGxsxSzl7x+K0FCgwgvhpsFrTsd+UmwViLu0Ppw3+5n79iBYKlvMJZ8Xu87Q9pe3bnvALC6WH5ZTL2Gyjvszdxhd9mq/SAtYRGpf+xVoGYxaQyZq5ESiI1v1kBhYeKkRrdMAXQBalfbLhguZhmTE6SWSbd6VurbDIj/3wjNfvJguS1CDIC5KXM0+71AF1Kt887WAJSRYAXvplU+WlD1iwpSg8wiWKlGRKaVdaJcuu+2BlxxzDv0X0bW3Wxm2W6VfpVj8iJ21hL85LJJMTRjLzxahx0WYDtcDw5BqfLHsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bXTqrUAEm71guheuwN49sGXN3vAWZbu43oSQCoEelk=;
 b=IMBDy4SIjRymfYc2YFa2ZlOeYNREwhJij/Hatk8ojI3du3Ho86+5XY5uaH8JWQXtCIkLc0Se0ZoCzv4CsSz7uR/d+bmgBZYplfIPKGXclLF/CRztTjmu94YGMjlkIPzH97ChoKficjm488eKo3LPDyk5tXEGadF1Gm4cf3fdIAwrCaGiyjk6Q4ZT+Arzm62OrvGxyxeGRbZGkNaO5ijVuRIqKfYOaT5UpD68Prnlqo1AyBIL2QHGglh3JZRKb3jMU5Qy88ol0qjdqifgz5/6ApdMJcIXjDnkRte9oWS7hv6OtzXMQaAYHBnESgj0u/6npr7+Yje7iMJ6C3/8eJIo9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bXTqrUAEm71guheuwN49sGXN3vAWZbu43oSQCoEelk=;
 b=gCMyUkjeHtRyPrbdkXErO0Jxf++m0PuDE8RQ9FV5bbbRUTiky5gpYzXPiXFjM3pbTHjfrDtuhydUKAdzTDTQ+me2Kb2Zz6jl6UUUJetsmGumq2NvBRL4GKOk+SgQ35/xs3MTjdkriQXSR7IgjrG7x8CQ1usoBBApIbMXJeWAEle6t6yhs2119pG0myMVlpn5WidAX7IgQY6XyzmAlk3oGYjdGAOkHGCG6Hcar+3xZ+0+uyseVh3WybT7zHwE9pXbWY3L4hKwOFgEOHuftz7FLfAxe6zw3HildvneuQ+3A0aOmirpAJZI1oxSKfUMDXPd/gaT30v/wRkdmGm+mtj/rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9595.eurprd04.prod.outlook.com (2603:10a6:102:23d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Fri, 15 Aug
 2025 16:31:43 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.006; Fri, 15 Aug 2025
 16:31:43 +0000
Date: Fri, 15 Aug 2025 12:31:36 -0400
From: Frank Li <Frank.li@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Joy Zou <joy.zou@nxp.com>
Subject: Re: [PATCH 01/13] arm64: dts: imx95: Correct the lpuart7 and lpuart8
 srcid
Message-ID: <aJ9g6DAMdmkSvNkU@lizhi-Precision-Tower-5810>
References: <20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com>
 <20250815-imx9-dts-v1-1-e609eb4e3105@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815-imx9-dts-v1-1-e609eb4e3105@nxp.com>
X-ClientProxiedBy: PH8PR22CA0006.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9595:EE_
X-MS-Office365-Filtering-Correlation-Id: 4815c8b1-eb5b-4111-bb26-08dddc193861
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5p5hSS9u++EvuD93zEFY/nvVwWst08RgVFioo4h3oy4srNZU830lnomPMlvY?=
 =?us-ascii?Q?hm6uRu9w39h9kFVxT3yXgZRa4ogSKR4D/MTCPdnpTWn7QNXsjZAGbSnC4DcH?=
 =?us-ascii?Q?zU3ddqdWI3i0uDYAgU3c3iWidugm9PlK4cxJVdRQbQsvwZughrmkmNGhKyRT?=
 =?us-ascii?Q?ejIe7u8wQBxDZMFHFo/0NXlLmBBOIHybwWdMUZ5SXF5wezNgK3XkGWFW5kxK?=
 =?us-ascii?Q?jifNMTcsLxoawqWyoj1ZXMv4FMoGGE11GqEhACFfgF6QVXaD3Q4rF6A7au6p?=
 =?us-ascii?Q?vfM+X7LYZOh7r+KoJZabI/u7R39TcCaI16Mt8d2NHI2KamwXrkNEBUBTLgMQ?=
 =?us-ascii?Q?ACVWyKynnwgI3bpb1fkNSuTPLpys1MuiVgQRQkXEbqFJdpHdcPYazGXC5zrC?=
 =?us-ascii?Q?xg2mgSEJmkvd3sdEN/Sx/8ak+Se7lXYzd4ZSqxgLbMRoR6S0dZ9yi2JzWAsi?=
 =?us-ascii?Q?jIf1yiOpSTzYw/lngEJEAiO958k9C5RfEStSMDBRL5l04gttRrE2WX/elQEl?=
 =?us-ascii?Q?8G6e/3ci4Pw8NvzNAVR2WVlCesXnMmaNHZf7Zy8OHk6dJRfvIS7+aD24fbA3?=
 =?us-ascii?Q?/o2P3hjfyxUrKYQ3jXFQVBryumKuirQqccgdlGLLXp0484ZoDDsQaMbK7KD0?=
 =?us-ascii?Q?tUDzMmom7S7arygoBd32BxE44l4kwdguGI0C0uj33O1/O5y54EiUo2CCySKW?=
 =?us-ascii?Q?8rVxNsHSG/NlkFwG2vjR97N2LcVfcdEniHVvKyPTKZkLKrGX7bB53fF4OAEX?=
 =?us-ascii?Q?TUFKQT8cD9rCezdSeD+Qn+B9h7SZJIEVK66ChE1Gh/teBeFdVRXdiMtREvGU?=
 =?us-ascii?Q?fUsB11Ezik02z9H6KLSahsVhTb5ZTsLDtd8DZaaAo64bv1Rv5LyQ3o1RJvoT?=
 =?us-ascii?Q?3/AZuVPU1BQTK1S5DhEi1PPl01dvcjQV/H+PxpD1UYIQ9zlV4g9yU6zfcyHm?=
 =?us-ascii?Q?gEMYT6yZEGF70w2otkS78IDwJ87Whgys5zm9/L28PAal6XVwWZArrnfK6r6t?=
 =?us-ascii?Q?Q6D5hP7emUeclDlR8syM4NfPZSFuAnZriEAm+IVIkb1F/e45tKrsmtDiCb8I?=
 =?us-ascii?Q?sTZRcYocISnZjNmsXTAGlmryMtOg6gqxFpsiPMy1xnvfwElEpZSmY2owliWq?=
 =?us-ascii?Q?3IOur7drt9Axfed/Tv/SX8wHYhQ0crZ2ax0LVej/drWlW1N+tS4n5HyTxXrd?=
 =?us-ascii?Q?CIffKeExRLIeHFkPrETk4Iay6dcQQpzdjbotd/B8H1Q4rhfcwZx8TFo0tLP+?=
 =?us-ascii?Q?Gnz/7Pmd4GNtXqTUmBE8YBlu63GmuVgqvkadaI9lAHblYUpBSTli0FNc6ODb?=
 =?us-ascii?Q?tDmbuISrAMBvT6+fUwP9/Hl6FdapwVxxVVfQ3phxEMTUYFeYEHS2C78Qkn+q?=
 =?us-ascii?Q?7FZBbonF32y/jOoLUG6qMy+U33Zj/Z7HIavV4PjTIdvfJVi887fbaX97EArP?=
 =?us-ascii?Q?lP5uA+G3FLaVhKx6kOWS7l9m4NNsTnzFs1r10Uf8V34k8x/fSh0btA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?44FtuEcBhyAVo5gdC7YyhH+BpvZp2JmZsiV8pTGq1/Ef1nwFewEkwhZam/bM?=
 =?us-ascii?Q?aY0XIT4NUMCyefQ/G2XvCFQtnhDMiIFR/jUPUwI/VJmwy3xkjnNV+GG+rIwy?=
 =?us-ascii?Q?D+h6NKdxxaDeikbshM3LZGsBF5bTsmJpgewsVhiN23O/Zv4FiqXTmn258T5d?=
 =?us-ascii?Q?3CGat8Gs42VdYCYoJh1+nJeEIW0J19jmdTs+Eh1PuVNoE72fBGYy7BavYmkh?=
 =?us-ascii?Q?0DyWGUwK8WDh3GDztdB5qOyofUOAu9GsE4oNT/UIAGDI8jYdHpivue2jDGmz?=
 =?us-ascii?Q?2XzxPHcCZj7I4jxX0d5nR5kZuVc8Mqn67AUu0bdvBwkW0ZByLxstjzl7M70/?=
 =?us-ascii?Q?P8No8J0bqetv/+6/mSzQfeozlVwPXKszjHqIavDw4R8N8UxE8x+/JVczsjYj?=
 =?us-ascii?Q?y5AxcFWbQGmhAHcMVc3mT+9ibZgxV7byKgSN4gOguCcpCcKfL99x2EYzXtO4?=
 =?us-ascii?Q?nMzFwHLHDor2yFmfdK27jXSttdKV7kGvcC6jYC6+8j56r/ZmUImLM0v0dQkU?=
 =?us-ascii?Q?c4PwL9HF+9CMJcn7vG8lErVatXidW4Q5qGgyjLOTkn1KqdnyxY67HimAWo7g?=
 =?us-ascii?Q?tcz85WzjTYYwIbt4F08kWbld/JwdiMyzyPtfj1F9UZCAdgOsggx85X1skf/g?=
 =?us-ascii?Q?RVeyN842Rhsa2qJ1T4n5ORoyEFTfIH+q1xhDXhUgeWw1lwx5BZw1W6wrwCz2?=
 =?us-ascii?Q?ovtoGnGoPh8LL1FBjJTb2RadwgKwWQw1qmRlt3A+WNqMRX4c1nHJEhk0Dyq0?=
 =?us-ascii?Q?4Ultitvt5Ms63wX918mTs3NaDkOAYrzq8F3Y166EqAXBUDkJVtHiWB9nV2U1?=
 =?us-ascii?Q?/kbRUuNdCUtN8GQsmzWDn4Uffjve6DeIwf/KL9NWk/d8wQw6HKMnkItngRc1?=
 =?us-ascii?Q?MwVvdpKcboWgCs3EQSC6Hqs8aUnzBQsBK9YCm3w+75BuUVMy9j/AKtdJGNA1?=
 =?us-ascii?Q?GsbMKFSCECQP2rRR6NmWaciwex7FX6C0RFBmLDBT2pHaLFIsMIcjeFIIYmfx?=
 =?us-ascii?Q?7vJmcvU5ZpGOLgOLHpcoJyGTpPWOZ+7DDwrRlrtsw1TY1fVpOiVw/nCgmcAy?=
 =?us-ascii?Q?AUI3FvX17VRvU2DACxEzaDjm3bJesKNrpSVbUHX0pBmII6d1uHQLc7jevd3i?=
 =?us-ascii?Q?uttLHC6NUFuUXOpDMpFxfGVc2QWKwfW7rfCsT7eKAftTLl50SSG8QTT5V8Dl?=
 =?us-ascii?Q?mJqVYplgUxj2Iqa9/NSJsCMw37gpR3UmyfULABwXV41ktMbHhOUqUTUCM0ID?=
 =?us-ascii?Q?DoLEltNdBcydw+mYEVdpsOL0uKFh01Ntuij8ON2HDqQqi9B3XZ0VRtLjei4D?=
 =?us-ascii?Q?1/ouFGxTJdPVlg8ZWmRT4iaNbik7OTJCk51liu7z/unYtdVpIeoDzfV9oS6t?=
 =?us-ascii?Q?ECKLcRTCywi0PiK8gVMx1ha6PaQHZHACSRte75xrrX9NWjGyqdv1SgPWwg3z?=
 =?us-ascii?Q?9v5o49tOKaukBTGTxEXHzimYGZPN58t0b8KYf3nfDTbXvheYa+PQQ3WAn7bu?=
 =?us-ascii?Q?FPgZt1Z1HH8Qr/My3ykmXTtCk9DlNtvnLVOBD0ojMxa8jE2mKQaggTfedXMn?=
 =?us-ascii?Q?O0sLUhnOcYvI1nRRXieqi1ImCD3h0tBwGZx54Or5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4815c8b1-eb5b-4111-bb26-08dddc193861
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 16:31:43.6332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GbVDZFSVjPC7nCNMCv/0ACqsMq1oHZZfBcZ3sb0OBbCLFUVKOVf6WwYCU+TSZVukZ6BYNkFUH+9LQHTVqqmL4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9595

On Fri, Aug 15, 2025 at 05:03:47PM +0800, Peng Fan wrote:
> From: Joy Zou <joy.zou@nxp.com>
>
> According to the imx95 RM, the lpuart7 rx and tx srcid is 88 and 87,

DMA's srcid

> and the lpuart8 rx and tx srcid is 90 and 89. So correct it.
>
> Fixes: 915fd2e127e8 ("arm64: dts: imx95: add edma[1..3] nodes")
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx95.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
> index 4ca6a7ea586eaa5fbbaa56be8b821f7c929b7dc4..dbcc557d07f5b8a0ef27d68b7211b07d26fdb9bc 100644
> --- a/arch/arm64/boot/dts/freescale/imx95.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
> @@ -913,7 +913,7 @@ lpuart7: serial@42690000 {
>  				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&scmi_clk IMX95_CLK_LPUART7>;
>  				clock-names = "ipg";
> -				dmas = <&edma2 26 0 FSL_EDMA_RX>, <&edma2 25 0 0>;
> +				dmas = <&edma2 88 0 FSL_EDMA_RX>, <&edma2 87 0 0>;
>  				dma-names = "rx", "tx";
>  				status = "disabled";
>  			};
> @@ -925,7 +925,7 @@ lpuart8: serial@426a0000 {
>  				interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&scmi_clk IMX95_CLK_LPUART8>;
>  				clock-names = "ipg";
> -				dmas = <&edma2 28 0 FSL_EDMA_RX>, <&edma2 27 0 0>;
> +				dmas = <&edma2 90 0 FSL_EDMA_RX>, <&edma2 89 0 0>;
>  				dma-names = "rx", "tx";
>  				status = "disabled";
>  			};
>
> --
> 2.37.1
>


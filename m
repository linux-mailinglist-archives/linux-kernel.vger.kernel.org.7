Return-Path: <linux-kernel+bounces-830679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4893B9A498
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6240517B20D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE73B30AAC9;
	Wed, 24 Sep 2025 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KELm8YaI"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011062.outbound.protection.outlook.com [52.101.70.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4C0308F23;
	Wed, 24 Sep 2025 14:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758724630; cv=fail; b=Myh5BFVNJUA+kAbqrAROeej4KH2TADnH+lmNlrXhlRqKVF+mHsI1rCU/eSaY24IBqVSZq/39q1iZ8hsh/4CIIL89LxQitwbsJfEmSZHN4VXFZnL1qV3vVF/ydh5HyatCbFmXYqzUlg+m5Y40zysms9APe7IDOztxyJJVsI0JX0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758724630; c=relaxed/simple;
	bh=S75c4NHv8L69wf7ARikIil/jDymv+QikLJNRYeANXqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OazdaCbnE2pIs4DRL+XtoiV7OHh/OWFcgJSLO+IITvEQC5pzDvVzuyw5IKJ3xWiFCceHC06owTIP5MHDo4kRnmEupX1SsInZVlF7QRsiuVURY959q9LSoem2AKPz6aZnwG2477ECNW7DH6p+ogZGPQ1AMl8F/ZEgUMxpmz5mj8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KELm8YaI; arc=fail smtp.client-ip=52.101.70.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XcWaoHn0RCAwToyGUjy+f19W9N3kqRyE3bp1nqjZKA7HFz/8J8EB/K9DJ6+ubMSqizNMq42n5T1yWk8SkBM2F559Z2+rMCf22bTzs+Y0+mKQrpal4D3AgVXo8v8V7NQw4PP31CnOsx1UNcZzRXzTAq0aSPXJGV8e6NUFq8+VAuBfhxZV10yP1sZbcxA8InnzmzV1rlvfbdbREszHZVewyvvpALT/ekgsroTNdB2P5aE66TSAZBLYJIjL9FTeeZYpIF27DsGaZHX6k/lj4MJFef26cVdsKdO1FBhDVink9kllg1fGkEEbALgWJRRko2uCw7qKLtjU9KMPTOFA1WiJ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tt2nzROO1dP5M+WfbYjjlUOFquD62+5wVc0GNE0v67c=;
 b=wfAJJMLighirr0JVUAdscAaCgtOo6wE0dEIkPkXmAZYNTvVP4YakpVz/axQDyvH4QLhaBKczfJ2vxKUG+CWuRfgMUsj06RVOupyusyfjWuX+5rB7E26YhpTyMPmfV9lWq1PNvLmxkO+qW7pz9HlsPGCVdRJkpWsV9tYWhxGlSGu3dNCFU7dV8qE6QkjJviJP96gpjryDk5mGE2dRxECkux5WYxXC1OyYAiqfUGByNPvJPno582uI+udKvClmOEqZ5iZEpj9A2Ej2j4XM5Flz9ixO6wBVXd7oqTwbKnUrp7qffGWU/DeRcKy31m52efcbEd7lVsx0A0o1sRtXx2odWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tt2nzROO1dP5M+WfbYjjlUOFquD62+5wVc0GNE0v67c=;
 b=KELm8YaI+WfrLUL40SzEDIuGvb5ntiPCrbfKI77DoXnhG+FxgJ8VU8FiYCeRyUfRsY4XyVrAcc8yH7gyD73wLcQWV/b2MJII8z91g/hCXAkYyTtGjNeeOb2AQOeX3ZCS9EedIBbppSWeiGkIiPfsyi0NI0RQMdhMc8Phj7U/IHdGNefVPRJf4GJqHZHhlvuCqAQ6bYNAlfzRPAeXJw/BcDbF0FlFwk7vckMOhoOUNSuT3yphRHaRSkEcjbOS8D+AY/CDVcS1x107+Kg1iHLBdMQ5Rdcw7EeYWwDQCeMsJ8Q9xZARH5lgdE7hTVx2Xq92ywrL+G2tZz2x3YLOwqP0Mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by VI2PR04MB11028.eurprd04.prod.outlook.com (2603:10a6:800:27e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 14:37:03 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 14:37:03 +0000
Date: Wed, 24 Sep 2025 10:36:56 -0400
From: Frank Li <Frank.li@nxp.com>
To: Yannic Moog <y.moog@phytec.de>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, upstream@lists.phytec.de
Subject: Re: [PATCH v2 2/3] arm64: dts: imx8mp pollux: add expansion board
 overlay
Message-ID: <aNQCCDQkFFT0ad4s@lizhi-Precision-Tower-5810>
References: <20250924-imx8mp-pollux-display-overlays-v2-0-600f06b518b9@phytec.de>
 <20250924-imx8mp-pollux-display-overlays-v2-2-600f06b518b9@phytec.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-imx8mp-pollux-display-overlays-v2-2-600f06b518b9@phytec.de>
X-ClientProxiedBy: PH7P220CA0050.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::28) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|VI2PR04MB11028:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fbaf97e-146a-4b9d-cea6-08ddfb77d426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|19092799006|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YO+UuKWgZCZoe1BcfT+qN6AmjYDG6To2zMUeJAUjrzvix0qRrt1Se+zNYCXl?=
 =?us-ascii?Q?eD/A6m7WDpQhRMSErAqCT4HkxRboxrDzd130vvhNcxizaUPNlVJLM64hw23H?=
 =?us-ascii?Q?skS4vaJY1tclXvckTvSWRmQo8al7GeO3ttfg1IU7v8eGY1meY8PsL4YjvtTX?=
 =?us-ascii?Q?ipYvtng9SyfLcTbYfwzDcRnqvRXlFV4gDSHx7L7+CLiN+Ioy/gN4hLn8fj2/?=
 =?us-ascii?Q?GDoY/0ucAFyHq9B+GcogLrhwrHPbXEJ2KjVGDujHAdb4cHo9iGG/vvxjOrgp?=
 =?us-ascii?Q?DwZH4Z4uq9xB9fOR1+gbWIR+r39EcA24nvZuTbsNlQL9dpevKKGFUmvxEyN0?=
 =?us-ascii?Q?HYcPpcZUgUci7UWyaPnUjFpTmW0Wxk+9eTd4GMZtCQmSGE9f8C4J5c7IfheI?=
 =?us-ascii?Q?ou6Xwkv7QnwDli4zkFTOS+/7HCW32fMBLC5tN8O7in59Ay8GhE81lwRbZWhm?=
 =?us-ascii?Q?F8Yy0NAJHCwD5JgRqjBTdSfagfs/fcXWI8/jWTr65xqsrwKLakOXbV74Rr8E?=
 =?us-ascii?Q?uwKui7tMevDb3GpcvQI2P1NtHHh2T98uiLZY3ASnqxvu8NbYd6an8kta9Xbm?=
 =?us-ascii?Q?rxjxDZ0AtO9DLKR9gDdXmZsqjyFKMwcfjdnpZsdh/G9CajzV3USxlpppxHRe?=
 =?us-ascii?Q?sxNLnTnkEwFtB44Xm5yDoltlQTACt5I2kwfPTgzz8HMBiSPBIOiagPITb3UD?=
 =?us-ascii?Q?6Rk41LR0voOLiMai1e6gWrvMnu47YUgpSa83NP3zWy22QGwoskfaahUG8lsB?=
 =?us-ascii?Q?eToM7+6oflhvydkyBmF/WE5rGf8stUL7NWe3XJPmpE4OieYIa1a2UUYurKnP?=
 =?us-ascii?Q?DahSbJyC9Z1IjcBaVqxi8IKX859sw0IWbPsaG+oDMU/5XK7iW/Bnd87ky31e?=
 =?us-ascii?Q?Ox6hUgPOl8Ndk1Garv/cDuUwuMsKsZC8MXw/PD218y6UG8EXa30QucwC2iZL?=
 =?us-ascii?Q?yFbrqdYlgKt2CgcrZ8MBl5JKUhYCoMhHL88SyMPiREfyOjkm8FgvhBgKswuN?=
 =?us-ascii?Q?swTWxeWA9DcumjdmNIVEvEt5OdSA+s3heDNmwHa/DwC03++1PAyxA4i5NwYI?=
 =?us-ascii?Q?m82Ysx00DWY/TUPH3j6t/piTiKv9VMt512oYdlQdBPCWBhtLwZmMgTqMUu2F?=
 =?us-ascii?Q?+Te1r1Cu4bTcuU2sR0mdKPjREJymW6M3T+K+US6mLWRwtd1XQLHKqB5YVl8/?=
 =?us-ascii?Q?mqWHcVpoK4NINDs6lZA6LTp4RAGNV5TKwse7Q5KHgQsOz9TqwWcGvlAtpkVg?=
 =?us-ascii?Q?GCXOVdYXmTepCIEtMqOmnKvPWMLz73ZPhvWS+Q+jEYmcpqSh029NtqONmEFM?=
 =?us-ascii?Q?7+4+sTZ0oxcNEg+nfWFXsgbIKYaJXlWwxd3qWRoXT92Wt53t4RUaKUijh1kf?=
 =?us-ascii?Q?mV++o4uPLwalyhm7yE/mgtbHTYeqpfUGKbSgxix0JRDHM8JhAlc7pY0ikt2o?=
 =?us-ascii?Q?Zr0z/u5AHpS7V0BL65THNMSnfLQBkl+1aQdx5G/7q2KDaOs8967Lvw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Vq9CzjpqCKozJI8x2Abt3CmrkFSVbe6VMt8WevWVoGUDK+Ym4D4OLY99Ll3?=
 =?us-ascii?Q?G69GKGrmvHsW8wQNTFvCso2utwNPFN8KGjPoTrw4xY7iXDXkBczsjmhJObl4?=
 =?us-ascii?Q?luuRuGkZibRtzFujaufk+NK2bME/QcboNZhxykMCI1y/l+z/rrCV5AI4xop4?=
 =?us-ascii?Q?ih6XQkYMlw83EMPJZ7UGnQxz2QPVOljVhnzfnOppEbW++QXP9gN8qc8AgMB8?=
 =?us-ascii?Q?z7kL1awLwzhFZK3UFqE/c+S1y+/L+bdnIpCQbVne7uni4yDFVmq1rMtLWcFn?=
 =?us-ascii?Q?g+Kr5AmpV9rq+y7Nrq6C2gXsCkZ1IkLQsFuyZHKoAT//eOz+lLHnHc69ulUU?=
 =?us-ascii?Q?r+yYoOQnUglZ1LqZa7xS8HajnFDtL/z5KjHub+CA5+HBcsBcDC6pM+MR45Wp?=
 =?us-ascii?Q?jOk5pZ9RxwqbveuLBKtLWAIIls51gW55Rw9q58ijSIXkJ27NepAtOd3Rpk7u?=
 =?us-ascii?Q?46NzAqhSb0Gl3lQq4OiOSFPojJ+8eTdayEi5vHreF3AQsjtWVSetGnq4NPqs?=
 =?us-ascii?Q?QjK5W3wOrVTpOkaPA3zEUgp0j0vGTzeRwxR+PuGDcymieal+QyLRmvXFZm3f?=
 =?us-ascii?Q?VtOLpf62iJ+RXvwlO7r1YOCsdk6biWpji0doEBSVhyhrn24VuoCN69ZrdEn6?=
 =?us-ascii?Q?Ro3iEkSUvUBHzgCalanNjOFlnvca0qyiU11CgcHYbcopMVyvWmPeKIHOq+F9?=
 =?us-ascii?Q?kCEB4ViXmXjohR1KLXiyKT4Xeb/fXAU2JWboVRyREXCUmZVDSiYcImqGpnNt?=
 =?us-ascii?Q?iCfF4J6EojkahJBG5sRjHcJcfyRXry718CgOJlU5yzVm/ow+s4apgmy5v9ES?=
 =?us-ascii?Q?iwhgEi4gecfsbi4YZH+njjVC3fXQfyi/hthZVoGLHTnLOeP355Ub5gXgwo6v?=
 =?us-ascii?Q?x/IM4EzWd+F+sm028oCoCL0zO2ipkzMYSFF8itaNUkbFi4LO9Ln0CXrWg6lG?=
 =?us-ascii?Q?ovSDIlH46bw44hVWiHbB7qakG61Ma9PEHH+q7j1c2Oq66CR0HUh/I97g71wX?=
 =?us-ascii?Q?Zmq0KIBrPPBukBrm8+VdxPN5SoX2rH1tEp02qDm3UYf3tVHq2NmwrIEr2Y63?=
 =?us-ascii?Q?593HgF2vvylsxLItR52No2HuhPkSl81R2F7m4gf7WCLQBdb5tN7QnnCO2+1O?=
 =?us-ascii?Q?I6yt+toeNlzAJt3FsCdGowWOETMSF/DQ6Su1Pxh2+hbnPHcp2o8XwvG0KAmN?=
 =?us-ascii?Q?4S9VHUx/wyjoEpOZG3xKeubzmV48hDQxtnPW95ladPMnNQqVav1nRpepIS35?=
 =?us-ascii?Q?hTBa1n780x+A18141A8IG+jaSoQvtHiIGialOB5J/TujFSrhSGWvKtz63lKD?=
 =?us-ascii?Q?cihFOkf0JxeicB3Ih4PC94MlVHzGrmZfusBqDvc2IKHJc7rZmov/cygBUmHm?=
 =?us-ascii?Q?XbEXKMs9sR6HnfJVrtkkQVCm6zD2WOBB//mZVYEzJwkW4Qf6tlSRY4bBU6EJ?=
 =?us-ascii?Q?CR4Aofjcv8AfGfIx2SD5sl+Uak6Y5cddYhIh1NWeiKctlJC7RG6Pon6zXzvm?=
 =?us-ascii?Q?hLqRBtup8U6zV1razPpCTTrDDFilH/YpG5JanU+SUN/wR+B9NbtSkWrMugFq?=
 =?us-ascii?Q?te5OHUkX43EC0f5TnKcBNMxU4K+pP4ZeMqvvofG2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fbaf97e-146a-4b9d-cea6-08ddfb77d426
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:37:03.7246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fm46DbJnCtojEz3ukG5cMp1tJUmvzM2kBE0ehtGuEjPscYXMPc+Topf1NnOO9EjX2+dhCHt6Q9AEwKPIpsOoFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11028

On Wed, Sep 24, 2025 at 01:59:05PM +0200, Yannic Moog wrote:
> An expansion board (PEB-AV-10) may be connected to the
> imx8mp-phyboard-pollux. Its main purpose is to provide multimedia
> interfaces, featuring a 3.5mm headphone jack, a USB-A port and LVDS as
> well as backlight connectors.
>
> Signed-off-by: Yannic Moog <y.moog@phytec.de>
> ---
>  arch/arm64/boot/dts/freescale/Makefile             |   3 +
>  .../imx8mp-phyboard-pollux-peb-av-10.dtsi          | 198 +++++++++++++++++++++
>  .../imx8mp-phyboard-pollux-peb-av-10.dtso          |   9 +
>  3 files changed, 210 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 805ab9e5942bc9e2b9776e92412f56e969b6b39a..9c121041128972d2239e2cc74df98b0bf7de1ac2 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -220,10 +220,13 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-nitrogen-smarc-universal-board.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk.dtb
>  imx8mp-phyboard-pollux-etml1010g3dra-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
>  	imx8mp-phyboard-pollux-etml1010g3dra.dtbo
> +imx8mp-phyboard-pollux-peb-av-10-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
> +	imx8mp-phyboard-pollux-peb-av-10.dtbo
>  imx8mp-phyboard-pollux-ph128800t006-dtbs += imx8mp-phyboard-pollux-rdk.dtb \
>  	imx8mp-phyboard-pollux-ph128800t006.dtbo
>  imx8mp-phyboard-pollux-rdk-no-eth-dtbs += imx8mp-phyboard-pollux-rdk.dtb imx8mp-phycore-no-eth.dtbo
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-etml1010g3dra.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-peb-av-10.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-ph128800t006.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk-no-eth.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-basic.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..4653af62b582ead04aed2cffde11ef0b142be343
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtsi
> @@ -0,0 +1,198 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2025 PHYTEC Messtechnik GmbH
> + */
> +
> +#include <dt-bindings/clock/imx8mp-clock.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include "imx8mp-pinfunc.h"
> +
> +&{/} {
> +	backlight_lvds0: backlight0 {
> +		compatible = "pwm-backlight";
> +		pinctrl-0 = <&pinctrl_lvds0>;
> +		pinctrl-names = "default";
> +		power-supply = <&reg_vcc_12v>;
> +		status = "disabled";
> +	};
> +
> +	panel_lvds0: panel-lvds0 {
> +		backlight = <&backlight_lvds0>;
> +		power-supply = <&reg_vcc_3v3_sw>;
> +		status = "disabled";
> +
> +		port {
> +			panel0_in: endpoint {
> +				remote-endpoint = <&ldb_lvds_ch0>;
> +			};
> +		};
> +	};
> +
> +	reg_vcc_12v: regulator-12v {
> +		compatible = "regulator-fixed";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-max-microvolt = <12000000>;
> +		regulator-min-microvolt = <12000000>;
> +		regulator-name = "VCC_12V";
> +	};
> +
> +	reg_vcc_1v8_audio: regulator-1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-name = "VCC_1V8_Audio";
> +	};
> +
> +	reg_vcc_3v3_analog: regulator-3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-name = "VCC_3V3_Analog";
> +	};
> +
> +	sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "snd-peb-av-10";
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,bitclock-master = <&dailink_master>;
> +		simple-audio-card,frame-master = <&dailink_master>;
> +		simple-audio-card,mclk-fs = <32>;
> +		simple-audio-card,widgets =
> +			"Line", "Line In",
> +			"Speaker", "Speaker",
> +			"Microphone", "Microphone Jack",
> +			"Headphone", "Headphone Jack";
> +		simple-audio-card,routing =
> +			"Speaker", "SPOP",
> +			"Speaker", "SPOM",
> +			"Headphone Jack", "HPLOUT",
> +			"Headphone Jack", "HPROUT",
> +			"LINE1L", "Line In",
> +			"LINE1R", "Line In",
> +			"MIC3R", "Microphone Jack",
> +			"Microphone Jack", "Mic Bias";
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&sai2>;
> +		};
> +
> +		dailink_master: simple-audio-card,codec {
> +			sound-dai = <&codec>;
> +			clocks = <&clk IMX8MP_CLK_SAI2>;
> +		};
> +	};
> +};
> +
> +&i2c4 {
> +	clock-frequency = <400000>;
> +	pinctrl-0 = <&pinctrl_i2c4>;
> +	pinctrl-1 = <&pinctrl_i2c4_gpio>;
> +	pinctrl-names = "default", "gpio";
> +	scl-gpios = <&gpio5 20 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpio5 21 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +
> +	codec: codec@18 {
> +		compatible = "ti,tlv320aic3007";
> +		reg = <0x18>;
> +		pinctrl-0 = <&pinctrl_tlv320>;
> +		pinctrl-names = "default";
> +		#sound-dai-cells = <0>;
> +		reset-gpios = <&gpio4 28 GPIO_ACTIVE_LOW>;
> +		ai3x-gpio-func = <0xd 0x0>;
> +		ai3x-micbias-vg = <2>;
> +		AVDD-supply = <&reg_vcc_3v3_analog>;
> +		DRVDD-supply = <&reg_vcc_3v3_analog>;
> +		DVDD-supply = <&reg_vcc_1v8_audio>;
> +		IOVDD-supply = <&reg_vcc_3v3_sw>;
> +	};
> +
> +	eeprom@57 {
> +		compatible = "atmel,24c32";
> +		reg = <0x57>;
> +		pagesize = <32>;
> +		vcc-supply = <&reg_vcc_3v3_sw>;
> +	};
> +};
> +
> +&ldb_lvds_ch0 {
> +	remote-endpoint = <&panel0_in>;
> +};
> +
> +&pwm4 {
> +	pinctrl-0 = <&pinctrl_pwm4>;
> +	pinctrl-names = "default";
> +};
> +
> +&sai2 {
> +	pinctrl-0 = <&pinctrl_sai2>;
> +	pinctrl-names = "default";
> +	assigned-clocks = <&clk IMX8MP_CLK_SAI2>;
> +	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL1_OUT>;
> +	assigned-clock-rates = <12288000>;
> +	clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI2_IPG>,
> +		 <&clk IMX8MP_CLK_DUMMY>,
> +		 <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI2_MCLK1>,
> +		 <&clk IMX8MP_CLK_DUMMY>,
> +		 <&clk IMX8MP_CLK_DUMMY>,
> +		 <&clk IMX8MP_AUDIO_PLL1_OUT>,
> +		 <&clk IMX8MP_AUDIO_PLL2_OUT>;
> +	clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3", "pll8k",
> +		      "pll11k";
> +	#sound-dai-cells = <0>;
> +	fsl,sai-mclk-direction-output;
> +	fsl,sai-synchronous-rx;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_i2c4: i2c4grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_I2C4_SCL__I2C4_SCL		0x400001c2
> +			MX8MP_IOMUXC_I2C4_SDA__I2C4_SDA		0x400001c2
> +		>;
> +	};
> +
> +	pinctrl_i2c4_gpio: i2c4gpiogrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_I2C4_SCL__GPIO5_IO20	0x1e2
> +			MX8MP_IOMUXC_I2C4_SDA__GPIO5_IO21	0x1e2
> +		>;
> +	};
> +
> +	pinctrl_lvds0: lvds0grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI3_TXD__GPIO5_IO01	0x12
> +		>;
> +	};
> +
> +	pinctrl_pwm4: pwm4grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI3_MCLK__PWM4_OUT	0x12
> +		>;
> +	};
> +
> +	pinctrl_sai2: sai2grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI2_MCLK__AUDIOMIX_SAI2_MCLK	0xd6
> +			MX8MP_IOMUXC_SAI2_RXFS__AUDIOMIX_SAI2_RX_SYNC	0xd6
> +			MX8MP_IOMUXC_SAI2_TXC__AUDIOMIX_SAI2_TX_BCLK	0xd6
> +			MX8MP_IOMUXC_SAI2_TXD0__AUDIOMIX_SAI2_TX_DATA00	0xd6
> +			MX8MP_IOMUXC_SAI2_RXD0__AUDIOMIX_SAI2_RX_DATA00 0xd6
> +		>;
> +	};
> +
> +	pinctrl_tlv320: tlv320grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI3_RXFS__GPIO4_IO28	0x16
> +			MX8MP_IOMUXC_SAI2_RXC__GPIO4_IO22	0x16
> +		>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtso b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtso
> new file mode 100644
> index 0000000000000000000000000000000000000000..52020c9361cc8fc84823fcae93aa3651332b91d2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-peb-av-10.dtso
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2025 PHYTEC Messtechnik GmbH
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include "imx8mp-phyboard-pollux-peb-av-10.dtsi"

Your dtso only include one dtsi file, why not direct use
imx8mp-phyboard-pollux-peb-av-10.dtsi as dtso.


Frank
>
> --
> 2.51.0
>


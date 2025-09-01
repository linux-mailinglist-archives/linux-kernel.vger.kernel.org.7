Return-Path: <linux-kernel+bounces-793665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D96DB3D692
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 04:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28A2C3B99E5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 02:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A77C20E6E1;
	Mon,  1 Sep 2025 02:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JnhzgGed"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013032.outbound.protection.outlook.com [40.107.159.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA851F61C;
	Mon,  1 Sep 2025 02:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756692658; cv=fail; b=ivpl3N3tRgr+X/WV777hc7Ca8RjOnk97UCnlx3RsMRgU2LFMADNb9SBPIx2AI4SZqFnHT1DCcbsR1m66ZW90JJWamC7HXja/VwUPfFVaxAbx1xoCiRRUxLx62wG8H82DPN3F/7iz3tiy4rOz+ufHkgpofg7C23Wb5jTJXB4FgJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756692658; c=relaxed/simple;
	bh=q8riTGHkjQ7lxewUGc/0UafRaBp3SNT4WBaqk8+R/Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CcEoSPn/10ERJQGbq4zN2Fka9TMN4IOgtsyUXZgXjFxIO9VvYcaTSrgdpKfwkUkEcJzU7ZHyDH5KxH47vTxhTk7e/ZXyEq11TtH4sDQ4H33r03gDMspugAOrz35L2mgg7Vz6zKmGovIdckm6bbCh8mRIBS2DQNosfi0TLj2HmOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JnhzgGed; arc=fail smtp.client-ip=40.107.159.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HOgPhnTBip57Ack/A5zpY2O1YtSaQA8b1o4L3V8zErLwyaKlPEjlRTyP3cKM/VaPZ8SwxC7fLASKYRmUTsDP4PrvFdvgNY2m643CqsKkjBq/J6xja6R1qTAcqXX+zxbG6utnx0M4l5xkjBn3T81YTRUWyK+5ipNNwyVUf2WAU01WgGCOnPKiKS+pyd/02Xzx69BQycCD25ztSZhs0X4ReDzb41cZDabEhWRTxYxYgBwof8Oo1GgCIky1e6KOvr4SkZ8Xyk9KSsD9N8liIEN3+VUi61aTy4+aVa5+sxVF8mx1ZWgHCjGfKg+Sofrr4jwdMD+DKnIsgVTY2jzcNpdCgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8riTGHkjQ7lxewUGc/0UafRaBp3SNT4WBaqk8+R/Vo=;
 b=Eb9sLsdoGNLROZBBC3K8xPhF+Ra5qkGfWq28nWtdi7UShdHntaF+8rdmv+1bzSX8OYMSQeS7kNs9vTQ8jvT0tIUhWUNaVHecjMDvfjYHi3JYClnziWInBHFIU3kqG56+J7BA86Nx7srZsd/BIkVb3T/HgND2HJ0YuNU9OfWuMunKwIInmWBrq4PiqhOTeufgieM4VaUoDKaJzKHSc2GNCA/9KJasltI/TB2LUr/tDLbpXnfIcADUfmXRd6tpl6GnLPIFAb8dJAhCEvD8AIHNO3w/338/nnKIt+FvSaYMi2aWk+JNjgdIOYYYBDgVDDSJMeryvQmXd2gM2GEvRzZbSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8riTGHkjQ7lxewUGc/0UafRaBp3SNT4WBaqk8+R/Vo=;
 b=JnhzgGedt6kVxPxPEMLXe0CO+Kj70ujrPoXQuDw8yt92MsXWG+ivoTnotx5+pFrepMDnZ4bdexkEfSU/9B28FZcLU3p1KdIYWzTP1s4mxxZIwJ8y+QBZXcTWpY+p5OTE25aDn2lhAu0cAKtIOVayI0H8Y5vNpzvLU3S8K0GWJ6ruUa3iX2Btq0vUQETuNihCz4/RO29dBZiLOQzb4yIvMtfeE6L1v6QOF9K1JOtc9jYunsO/tGlORKPCftCFT2iZWS4k5K4zYKDj/H5VPEAYbG6ImpyAUnICmPLcYdA95XYJgzvNycNn1JLk5dINa9x3GPHmQqMCRlmv+v5COnCkzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7831.eurprd04.prod.outlook.com (2603:10a6:20b:2a8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.12; Mon, 1 Sep
 2025 02:10:53 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.015; Mon, 1 Sep 2025
 02:10:52 +0000
Date: Mon, 1 Sep 2025 11:22:03 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: E Shattow <e@freeshell.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v1] dts: arm64: freescale: move imx9*-clock.h
 imx9*-power.h into dt-bindings
Message-ID: <20250901032203.GA393@nxa18884-linux.ap.freescale.net>
References: <20250831200516.522179-1-e@freeshell.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250831200516.522179-1-e@freeshell.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR01CA0169.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::25) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7831:EE_
X-MS-Office365-Filtering-Correlation-Id: 6afa6482-8d1d-4960-9bba-08dde8fcc70c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yfdcNSNM8qKTKfmrQvNdNE/B04EzTh8GtLSEtMSqFSUokwohCe5YkXjHIC+y?=
 =?us-ascii?Q?iQQheRf3gem33as3DqHmht/xSxiJCDtP2YYEdYn0w8SzOkT9nhMwFEMq2LAo?=
 =?us-ascii?Q?DBoqwgt/sxeD6BwSZw70eruv+dVtlY0kWVmC9RM8bpsDG6Xe1ioiPQ97F2Fw?=
 =?us-ascii?Q?Rv9cFKylCfjJdZRhwMt9/Bg6f2pyD7VUxaOFox0EJhvBW8P462yvy/6+x/2U?=
 =?us-ascii?Q?1FeY7gNlcB7cGVr/FMbMULw5k3dlk2n7FuoSl/Ap/qzMgvwBArWmeneNN0ag?=
 =?us-ascii?Q?T/Rdndag+XiUCAkqxB29UyAoa93/dYwrgAWjtcBX9aA1jkYAOZxkzLrQ8ro/?=
 =?us-ascii?Q?kya3hN4VNbgecuetWzgxKJ+qvirRjfa0bzN50qVZiPZMf3Mlz50UzdRrGgTM?=
 =?us-ascii?Q?TS751xEGsJmwDlRpGLegwLMjKAX1/EBfhprYC/ymN/t6wOipztttdOJzYZPV?=
 =?us-ascii?Q?S5Yo4jKQs+VcBO11mDKUCJANnKi75KLGiTFzExtTJVpy2zmiT4tiUu0MhHBg?=
 =?us-ascii?Q?4Vbzz2/Xh2Q7IQFeLCE5cf4nm2HT3tWG3hkipY7r0HtWp4Z3FWULt99iWywD?=
 =?us-ascii?Q?+9WVr4jPFmHa106H6d4tYF65zqmWikTVKV1jLben3z88EANMrFzWDuXkSdG3?=
 =?us-ascii?Q?ZeIFyI1J+x2rc6l6UydgoskL6yEHIhRsTaJj9My1t5m3tyUmgvHOSqg2cS5F?=
 =?us-ascii?Q?nz5sLyOu97qMO66KuNoYxYOnsRyCv/QTClgznjoNLHRR0ytcDuzLIUd3HHeM?=
 =?us-ascii?Q?v+dP+hbfBiPkbnWPpXUAorK9svXzJKt1OaGNPUlSfYMexPPZOr3hesNIQ8tt?=
 =?us-ascii?Q?k1vATocy9ECBKOElwa9unsAIivEW/6rUxjzQ9EQ047w4P6efOcsGiCNQEtsC?=
 =?us-ascii?Q?1ur5WtdMV5a0hi95rsGWRZvQyzDjbrgPcuJ2sdzhOyu9bUFSoR9QdZ0gC8ta?=
 =?us-ascii?Q?iu+vUysiun15a7c6UqZvcScaVKpLymDQ1Y/gJI46jmlp5RvXk3YpivDY157c?=
 =?us-ascii?Q?PLJifdptjEKbAzRN8iW3fztlg4a6qcf3ZHEP5cWIWN+/yAbw1d/xynMwxoQj?=
 =?us-ascii?Q?LEPVdRK5zWXU8Xr2tlf/8TaKZU7daCxszZ+lt2Row18nI4X+OXzIzQBLZbO7?=
 =?us-ascii?Q?W3arM2Qcq/EfO6R+h9Z+E01RxvPYBa0B/XypRmtkLuX1vmKahbPMO5VfYNqa?=
 =?us-ascii?Q?y4fZnP62Jmwcl5Xgi3IlWisYfJmXF2RK6NdIYuPoF+J7UijV8cKuu4tdnTk0?=
 =?us-ascii?Q?7IkTGplYaV7kruqQ3rnvgsS/uqkYcbjP92BhLRc6tTh05fH60SuVp49P7IPS?=
 =?us-ascii?Q?4gRJaZr7Nx5trZu9ajt9tKaVono+srFhrxAVJk25hwa03Iee3FfjxVKiiHKA?=
 =?us-ascii?Q?ROoq98lg3R804ckBjWqGf7bqx5l+2UR4YhRidjRVzFLG9sTQCOFW5HJ+QW39?=
 =?us-ascii?Q?Ez9Wz3DITs3eA1I0jeufaHFY50IRDBl0KcoCgbWls11O/K7wBeUZHw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t07H0xlsPcbJxzRSKblFvmdwd2y9m6B6eaUKqCC7NRBF6Ehcqsm6twJ93iPf?=
 =?us-ascii?Q?a4dev3QWK800EZ6X0tCWOQRfOwEdjU4Qutv/IdhnF+U5cDEa1oJmMgM8F/K2?=
 =?us-ascii?Q?OrU2JYt6Ck7j3t5RbaUopg/tgwPht/3DH13Kjhvkg+awS6pthpSWgnlwC0ec?=
 =?us-ascii?Q?HVi+pC/7rpQKwVtphX9FhtSQbSznOmxsPs36amUMIbK0uLE3hu7AO2mPpBY2?=
 =?us-ascii?Q?RMK3OI+8870WwqITutWjPlluanKZTZIPrppRE6ogPKLOtm9yYzkNovrRK1km?=
 =?us-ascii?Q?dlrQks5UcDR3btmICh1RfU3yHId68MvOhtDQHzKH9kjL+CQTSUWWt4me5FcS?=
 =?us-ascii?Q?tYYFCo7biu8tbzWrnRwH6MudygxIFOnLUYycEo1Z0KdSFxnzSzqT6gI2QiU8?=
 =?us-ascii?Q?ay/nTAs3CxbUV9b0DClqe/vyRVK90ZoF+aoY/7q8JaRFHmY3csgB5iT0w08Q?=
 =?us-ascii?Q?IwQaWE+/X8uRq+fHIngTT6nm7uJ7wgcxI1U9MVHQWd2TmSkAwPFjwiiIQvw5?=
 =?us-ascii?Q?3mtnLeH17c2c3NOh7eS0BdAnDPhz4O5p5lSo/ShIfRvgUEXZRR9NkBb0Zcup?=
 =?us-ascii?Q?WmzNk9buVwHTYhYJt2RZ1Ade3KLI5/qWNG5ZYkLloFt/p8vPsBtC03pmXrXv?=
 =?us-ascii?Q?opfbGQiZAY11ddYDueb0mtDAvfw3QjyipCR4cBTFrp8YlU5Ja8zdrxKLv5O1?=
 =?us-ascii?Q?ZsCs/G0cFvQP1y9MNqjeNYoVdxcYtOYT93P5m7RxMOzz8Z5wo96sNAFx23CC?=
 =?us-ascii?Q?YdBab7Xb5cr27HoRJwLK5zPYiyKM5uo2rvVKSRo02ZYASml7ChaU7Vgv8YjW?=
 =?us-ascii?Q?IYOkyA0nIkFCZKiKBlnFuNbzbhKLQWWOIsNtZfE4n8zIj/EBayLNdTcEHnLU?=
 =?us-ascii?Q?++ZFeyK/K+OZWRmv5nMEwMXUlrisSOQoT+Oy3RljvjU8J3g5bFBfqJGX9jV5?=
 =?us-ascii?Q?sHa6Ud1VpoVhQH7AQSxIb8If7ues+2925x5HRdoijNOv9s7C9sjCOoyVOj5u?=
 =?us-ascii?Q?PE3kwJk3TsZr+B1zJj6lMmrfyvzrgh9nVH33rpJnFWU3bJgzwsX3MwrfP5TP?=
 =?us-ascii?Q?Z4zNCQalyoPdE4LddWJ6o3YOTvROabvMfelN4v13RojfqZlm1XG6oRKmGID5?=
 =?us-ascii?Q?LNyXw5v3R+4uOnHOCkupxwYlwQZYbRponDhDGXr3tJ6s7vYNy3ofYAzoLTK7?=
 =?us-ascii?Q?utfvgxekuINDe+VU79t/fWCDONO38IyzISpFnYv3fxgRdK7av0EaqnP5clvy?=
 =?us-ascii?Q?FbxZj1iqWIuIDMmYH6wYqrGP94K6Ty2B0zlBxl5KvkDLbriwS7DBAt1G1sjb?=
 =?us-ascii?Q?AES7tdsPx6FM1jGhetCzdhTf6ZoDPqXmbrF049iyqjEPxuHkAoqtOjAgaLkC?=
 =?us-ascii?Q?PdG3lp+yk7upgoKckHFAWDY6MVR26co5dkzCrMwZJ64Hy1ccqD7kgLu9E+Ig?=
 =?us-ascii?Q?yvUSr3/RYAKhwxF2CUBYEcFSQLRZ0TXhSopWwCslecbEe37Z9zIfge2mmYC0?=
 =?us-ascii?Q?MZ9gqwkccbGMxtuK1v2qlsz8PRlQBn2ksJxRgBEnltUuKhEpSMIrgvFXdr39?=
 =?us-ascii?Q?C9jyxGYAed+aCgmNHpDX3DDjC8jJOngKg+9pzHch?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6afa6482-8d1d-4960-9bba-08dde8fcc70c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 02:10:52.7805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKLkfSz1sud+nQbjZSLeSd0iTqu9lZ6+we7EAOKZc2n+AHKsqwcCDZMo7nrkmZjoV9hXiugzgBP0yiNDnbcMXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7831

On Sun, Aug 31, 2025 at 01:04:45PM -0700, E Shattow wrote:
>Move imx9*-{clock,power}.h headers into
>include/dt-bindings/{clock,power}/ and fix up the DTs

No. The files should be under arch/arm64/boot/dts/freescale/
What issue are you trying to fix?

Regards
Peng


Return-Path: <linux-kernel+bounces-876684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21226C1C450
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29527585074
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D6B2EE5F4;
	Wed, 29 Oct 2025 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dp8vXOfd"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011050.outbound.protection.outlook.com [52.101.65.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62972D9795;
	Wed, 29 Oct 2025 16:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754652; cv=fail; b=tb0VkVtOlsWfLyuMld+kurnRSC3vpDw7+tM1HFCkngGSYD1PbdwYi1NZUZpK4buS/oelrEQRepFuvDJWX2SBc3LwZ0j6/zCA3rZbmwhgQ5flfBcli4CDueFkXcudrW9O8cmph3HSGgXFqQ3SydWOkcYCzVGSQ+9KiGb/QUHie1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754652; c=relaxed/simple;
	bh=TieIOlXl0/aLM+ezJs/gFu86OKPqAC1U6wlP+HJYS+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ClxdKuuvogQbsBMPqXRYXblC8MAs16DIoyI7PdaG337nSuXGcFNmcNF0Q0Msalfh8pGD11OpcRtigPv6TYfxHGd4zzeh+4dQZRAF2kA4I8zRhEQsPQsXFw64iLkPHRywgox2OAznE3EOg9Xlr4prbUJcZ//jnlaARti4LiTzgAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dp8vXOfd; arc=fail smtp.client-ip=52.101.65.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mhRbW/fUiIRgV56Y3onyqjm4AU3Ypqf4kmpWJOdyCrBtZThF/WUUdBGFJEHDlFzdw0eB53Mihp6IFDfUpViaih3a7ihZtM/GVdfeVyOMyZLzuQll4sAOMzX6Pe6vhxWeMyznTekbc3+H9AGW4u4KGRNwkW69/buXnBRHMDCOIg1gh3pt2vo5eDhzrTPWGit3YJpRsl6cfeA4JaggQXM6xIRtFxej9ebdyGKjI4tpVbu902TTFkEJI5b69AaUzjc9ttZvlsnBfC1/HUTbC0WTxGg53fEep0MFbPY7/5AWG2U3t9n7o2QTOWWID96U4A71OLs5gkheNnYcLGyWGBxFRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8pK95hYEHy3qJNXXH4pfVDT7nbc+NOztt5v2HIHrdA=;
 b=yvt4yDmEpjEeDUquvVpbYr1i/NdJIF9AvxlJsqp4RrMNZ3IvPynP087Ke/4B4oDzqDVnH+6/3YWf8lFEU1Dc/3HPi0XypwQ2qxIjz8K4RfQ2MRmTm/GPYzXRke1EQSnuvwpFxlu9uy/vI8/T1rerOZ7rr4NNZEuZMt4z7vDVbrAosqw2hYC+iGkCQDDZI6mGOEg4MqrTSY0YwCHv24/tegQHm9i32+jifRfwYqQf+SHfPt/DoITKLzdfdDahVdbw9225OcrTdX0w1hM9j42kcCgHhIPrvY+BTpQvq9NvZbbrG0KnX1f53DkgbXbx39XIVkA0Mlia0iTtnptS4YF56g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8pK95hYEHy3qJNXXH4pfVDT7nbc+NOztt5v2HIHrdA=;
 b=dp8vXOfdnYQEwx+Nm5iSmn+FImLwwGWMfjrsvE/wc+tF+KlleCgGGeG5hwBuLvw2gNa6QC/YW2ATgts9C1hXXmJABTnhZ3UV6/dL7nyPSDls9b+IvEIQRzzkwOhmHILcoUywqm1zW2KPdL637pKnXB8PD6ccGDFlUk3AZ+Jm5haV/HbYvCCGidkQ5zfGAk8Xbvv7IAviUTh1jaWVApP1BhU3WHXI6PJqHWBIcEjEEK8Lryj0Y6fSmcHZTYpARg6/SeIwVOdQJyPD5qRISBpodx4up4GsPD9fuG7TA1Hm14SGRUZkgE+BRKJq8F8ZOZq96ENKMKIKkjyhW4yfLKv/5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DB9PR04MB8124.eurprd04.prod.outlook.com (2603:10a6:10:246::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.20; Wed, 29 Oct
 2025 16:17:24 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 16:17:24 +0000
Date: Wed, 29 Oct 2025 12:17:16 -0400
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v3 3/8] clk: imx: add driver for imx8ulp's sim lpav
Message-ID: <aQI+DPncZ7oTGhp5@lizhi-Precision-Tower-5810>
References: <20251029135229.890-1-laurentiumihalcea111@gmail.com>
 <20251029135229.890-4-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029135229.890-4-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: PH8PR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::12) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DB9PR04MB8124:EE_
X-MS-Office365-Filtering-Correlation-Id: 046175a8-da0b-466e-f839-08de1706a543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PcUjPB1EeXLOg4RHBeuD2gKklSl6AEdqTXUeSw5RQAMl03otSAgoJoyYCyi9?=
 =?us-ascii?Q?IqSPsUkcS8t1gPpdK1DclZhZcT8OBiPAuJIlq/Q8ZiDXIJNmdh6oNltbFfWR?=
 =?us-ascii?Q?3sKlwAsoPtE+CukP640SXzf6gvR5m/gzvPvPLsbzNwNlipU/T3juBMLg2O1c?=
 =?us-ascii?Q?3c3H7vFbpW7DRlyF7iUxY5i/l1Yzw/ybz3d5cFexs+EFFLKB656jW6oYvlVY?=
 =?us-ascii?Q?BQC64psr9Lrkmm/a/5kZpcRLosRuS9JgyNo9EnRJASTAlt9nixlDU5tOJcFm?=
 =?us-ascii?Q?+FGTK/uv/5ggjj2FToJuXdN9xVoAwOwwZVTFQaNPKBe1Un/+x1cpkNq4WUEd?=
 =?us-ascii?Q?Z/WURWa1a9xhy7IPLVgpXcqbgeLxRFul27d6nqnliviDChAAnDV+W8In4OvE?=
 =?us-ascii?Q?/spXk4Hp02ie7d3v9NZ1OxdvYxlHcA3qzuDecw0ccZ5PUXrxjIitk/pqEOuF?=
 =?us-ascii?Q?Xn7UxjYekqcN++4VC2KtBOydMo4lKgRXV6JRuzY8nMMjQ95MuTrfM0XGC/5D?=
 =?us-ascii?Q?1MnRngVrKfGqcWlxYE7baKdOWWpeMlC2b7BFBTOj08XgTBICAcSj4QufnHT/?=
 =?us-ascii?Q?PccKqoEVbE99ldLsRGesT+tj7JTLn4hKyoM0zOBnC8jqe1t+j/fneMmXaFDC?=
 =?us-ascii?Q?ZyEssXpsn959Qy4BGULzd5W3TMMIFE2p4GqpEpJJ9yMI82gfzIawUp6ZfLKN?=
 =?us-ascii?Q?ppp+IkTsoNhM8erCfsWhWDVt5DjG9+X16qNARUdPeLcrVQ8C0fCAsj2Zk4Mx?=
 =?us-ascii?Q?7d4aEwBQC4iTz7IUROlpa/733oDx7ahfHFl2uBZI7ynPewI41KZKWMtPByFJ?=
 =?us-ascii?Q?GcLnwMT30ggPG3PavqVezaWXwc6LId+eQU78uvIMfvqF6UXo17xWxEy8bfPZ?=
 =?us-ascii?Q?z1U0YJufXwUR9uDmvHS+5+8nzlcrMCjR2yrh3pGm4daiGou+m6B6jK1Pd8kR?=
 =?us-ascii?Q?H7U/VoJqjxJp02BZuT4QuZCthHozy6TMPH9Xd5xaxNyPwYKFWoyauoB8qgba?=
 =?us-ascii?Q?mDXRe2pdSfwj9fl/D/8DNAoKzIko4LKfkG1iMkY2azH2x2sPzrdykB2x6wzZ?=
 =?us-ascii?Q?Nrgs7lLg5fhHL8+JF+uLX33Y+5kVEYHe2iHV9sEtJB12W2u79CoUF+shAPu2?=
 =?us-ascii?Q?7RqR44CsYN34NA6+X0DZ0yxxfozlaEB9YPmEX+9LFCcPB2+Ttu1thehdMFni?=
 =?us-ascii?Q?VhKZucxjwY+OurEwF4URfzUCkEO9Pu8UxnE5jLPs1h9+mndu5zTIochqzTy9?=
 =?us-ascii?Q?Oq7AJ4nGmFKJ5s/CskJLpfNG855xI9jonzpM3G2DRAb0pR6MQSogA1gCbK4P?=
 =?us-ascii?Q?rvCqmJhEh2aG1tEQCWpwrSBtSwQYMOwP7qES5uAOj/u9ZTqja6RPJJhcdO4R?=
 =?us-ascii?Q?F90mIiC5gRo+JLOEC9NkacVrLuGGhBdYh3JKAD8NEnBxPxJWHDRsiDaKvTsg?=
 =?us-ascii?Q?WarfmbjitOOo6E66xdeYaNwAcFJW9QZx14Ic9uncPBy2tqy/nf8snVAdz8El?=
 =?us-ascii?Q?nfvf+cmMFWa1sGNlk6CJbyGZjtRmetb3Qu2q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TOUb7a6kuUTzVn6YkR8f1Mh2asCRXXJMePiL3R5IpS1Xmckq2jxgLAw+5Mti?=
 =?us-ascii?Q?TlwlGq/tJqgQz57+yPDXhBkoBfkK2gCNpvMXU02Vv961QJizY7OIjG+KqvHp?=
 =?us-ascii?Q?idu3kborWyXScF/m2HGA6+nJjrbxfRYn4UVDKPE5Rnf4qzu+lk9JA7iVwaus?=
 =?us-ascii?Q?xSYXeapul7jLxYL+1ZNCU4UiHW7YIt/PwI43LNv2If6NWh8rHrDAVvWkczBA?=
 =?us-ascii?Q?OfYujV/LgOJeKOeEGlVv/b7MKwXS3p82Q0frzYPVhixKcrLdODTDmcW1UJGa?=
 =?us-ascii?Q?gCq1AR3skRyuOlsfU6jQdw1OgY8mt90laVs9BboREhrz2j49dqK1zodBDGZX?=
 =?us-ascii?Q?KLPS3kLcL6ZQZNcxfbtTQ1T/NEzt7OfaIK5V+rIHsNAO7J9rq5cP3bnKanr8?=
 =?us-ascii?Q?T69qinWsYvPEy76bRfL+buiwQasrqwDZcqOHtgwABR2WoSK+GCYShTUHU917?=
 =?us-ascii?Q?o95viTWwHNXS1tdv56d2bukRhOQtUA8JUiQ3MlwfsPWSQ3zew3KfHlehdb59?=
 =?us-ascii?Q?ku+CI+BuOh32IV6r1S1wJWHDNEEwefRkyz/sQZ8MOIc50olr8H9P7VONwsNb?=
 =?us-ascii?Q?qUQ5Iz3pRIdx5sU41slo9Y7lAIGKJJ6/8BXhgFPLz+voGp70WjfSrvgzWZ/u?=
 =?us-ascii?Q?JH6Uwy3K8oV0DtzVG/aP+3Sf85ri7Ic4dPfSioY05NkxQVVNcJoRMUg7vWxY?=
 =?us-ascii?Q?MOe/hu3EmCC52LVAsjsVX78YF0HrOPNfB/koZ6O+KOdmtqdW64WzUz+spTlU?=
 =?us-ascii?Q?UOgejHicTuh9ZLcr0Yt921vGtKOdAkf4LMD7BsjjrAqaEyJl4RISAQve58up?=
 =?us-ascii?Q?UUYEWU94q/DB1ruhoCWF4j/W8BaCJd2m/17JFeb1Q9GTWumJ9kh89TOHbVxb?=
 =?us-ascii?Q?LdM4jfO/d7pwd4pvHmlLYz0nOuVe8XWJANF9FtDoqffq9WJVX55+UI9N3b6h?=
 =?us-ascii?Q?aqeGXo+YPZ/r1gFCSbnIX2ixlGlCN0vXBfovatkrCErNSnGn1W+1e0dKZMZB?=
 =?us-ascii?Q?MKIkk6fQ24FS2Om38hQmxr4NI24ohI2Ic2sda2wUGqIxX9AC1zSUKnfC5Pq5?=
 =?us-ascii?Q?togQcY6ahIPoLuku7DOiU0qE2dnEmObZo0Q17pRiL3pRE4FQIldKwbzwrkd0?=
 =?us-ascii?Q?YU6QovjmhT9yENekE49OXplTvC2hrSNBPW5MYmffeWhyH4J8KANoBpm4uZcd?=
 =?us-ascii?Q?Dfut2ZTNUh1gG746Hvo/4YnFDiRcQzKYpQ8/OiFIG5xZWGRITUCNJlg6Cgwn?=
 =?us-ascii?Q?PfptVcnp8hXIvisXDBipe7W+vHOEFZoQI7xchyplIdANl/ZFd1eVoR8h2rrg?=
 =?us-ascii?Q?OpRA7GBK7EU9bhuWBkPLezy04uPuSvlS6ymyytA+FN+yapcs+1vgzFFutO0x?=
 =?us-ascii?Q?KzuRevpZ7iwqo1jzKX4IPskgk1+brD9YtZ3Cm5j0Z4F2ed2YCmjTaJQvBUtM?=
 =?us-ascii?Q?DFSKEubrXJ2kWTkh1anEwFXNjN8BUpXGcvqfkIVF+XyqIUx6xdhH7vnhZTMl?=
 =?us-ascii?Q?ItwSCPw1DTFp8Q8Y14+mh6YJGUbYxHfg9A4RxBGmTtqMUDSMAYbA7dYHxQML?=
 =?us-ascii?Q?ZiHdRMkbXe8ANlT+caXJQGU24RXbh2gX0eE6DXiR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 046175a8-da0b-466e-f839-08de1706a543
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 16:17:24.4511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4jw8dL56VAMUCPXwXwKcqAAnioUwOM6RSzecaYegS6XXKKgQzw5GixhuJe/ktnxe2A14gSTy7JoDnPZuhlueQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8124

On Wed, Oct 29, 2025 at 06:52:24AM -0700, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> The i.MX8ULP System Integration Module (SIM) LPAV module is a block
> control module found inside the LPAV subsystem, which offers some clock
> gating options and reset line assertion/de-assertion capabilities.
>
> Therefore, the clock gate management is supported by registering the
> module's driver as a clock provider, while the reset capabilities are
> managed via the auxiliary device API to allow the DT node to act as a
> reset and clock provider.
>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  drivers/clk/imx/Makefile               |   1 +
>  drivers/clk/imx/clk-imx8ulp-sim-lpav.c | 160 +++++++++++++++++++++++++
>  2 files changed, 161 insertions(+)
>  create mode 100644 drivers/clk/imx/clk-imx8ulp-sim-lpav.c
>
> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> index 03f2b2a1ab63..208b46873a18 100644
> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -41,6 +41,7 @@ clk-imx-lpcg-scu-$(CONFIG_CLK_IMX8QXP) += clk-lpcg-scu.o clk-imx8qxp-lpcg.o
>  clk-imx-acm-$(CONFIG_CLK_IMX8QXP) = clk-imx8-acm.o
>
>  obj-$(CONFIG_CLK_IMX8ULP) += clk-imx8ulp.o
> +obj-$(CONFIG_CLK_IMX8ULP) += clk-imx8ulp-sim-lpav.o
>
>  obj-$(CONFIG_CLK_IMX1)   += clk-imx1.o
>  obj-$(CONFIG_CLK_IMX25)  += clk-imx25.o
> diff --git a/drivers/clk/imx/clk-imx8ulp-sim-lpav.c b/drivers/clk/imx/clk-imx8ulp-sim-lpav.c
> new file mode 100644
> index 000000000000..1614d9209734
> --- /dev/null
> +++ b/drivers/clk/imx/clk-imx8ulp-sim-lpav.c
> @@ -0,0 +1,160 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +#include <dt-bindings/clock/imx8ulp-clock.h>
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#define SYSCTRL0 0x8
> +
> +#define IMX8ULP_HIFI_CLK_GATE(gname, cname, pname, bidx)	\
> +	{							\
> +		.name = gname "_cg",				\
> +		.id = IMX8ULP_CLK_SIM_LPAV_HIFI_##cname,	\
> +		.parent = { .fw_name = pname },			\
> +		.bit = bidx,					\
> +	}
> +
> +struct clk_imx8ulp_sim_lpav_data {
> +	void __iomem *base;
> +	struct regmap *regmap;
> +	spinlock_t lock; /* shared by MUX, clock gate and reset */
> +	unsigned long flags; /* for spinlock usage */
> +	struct clk_hw_onecell_data clk_data; /*  keep last */
> +};
> +
> +struct clk_imx8ulp_sim_lpav_gate {
> +	const char *name;
> +	int id;
> +	const struct clk_parent_data parent;
> +	u8 bit;
> +};
> +
> +static struct clk_imx8ulp_sim_lpav_gate gates[] = {
> +	IMX8ULP_HIFI_CLK_GATE("hifi_core", CORE, "core", 17),
> +	IMX8ULP_HIFI_CLK_GATE("hifi_pbclk", PBCLK, "bus", 18),
> +	IMX8ULP_HIFI_CLK_GATE("hifi_plat", PLAT, "plat", 19)
> +};
> +
> +static void clk_imx8ulp_sim_lpav_lock(void *arg) __acquires(&data->lock)
> +{
> +	struct clk_imx8ulp_sim_lpav_data *data = dev_get_drvdata(arg);
> +
> +	spin_lock_irqsave(&data->lock, data->flags);
> +}
> +
> +static void clk_imx8ulp_sim_lpav_unlock(void *arg) __releases(&data->lock)
> +{
> +	struct clk_imx8ulp_sim_lpav_data *data = dev_get_drvdata(arg);
> +
> +	spin_unlock_irqrestore(&data->lock, data->flags);
> +}
> +
> +static const struct regmap_config clk_imx8ulp_sim_lpav_regmap_cfg = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.lock = clk_imx8ulp_sim_lpav_lock,
> +	.unlock = clk_imx8ulp_sim_lpav_unlock,
> +};
> +
> +static int clk_imx8ulp_sim_lpav_probe(struct platform_device *pdev)
> +{
> +	struct clk_imx8ulp_sim_lpav_data *data;
> +	struct regmap_config regmap_config;
> +	struct auxiliary_device *adev;
> +	struct clk_hw *hw;
> +	int i, ret;
> +
> +	data = devm_kzalloc(&pdev->dev,
> +			    struct_size(data, clk_data.hws, ARRAY_SIZE(gates)),
> +			    GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(&pdev->dev, data);
> +
> +	memcpy(&regmap_config, &clk_imx8ulp_sim_lpav_regmap_cfg, sizeof(regmap_config));
> +     regmap_config.lock_arg = &pdev->dev;

You copy clk_imx8ulp_sim_lpav_regmap_cfg to regmap_config and only once.
look like not neccessary to use clk_imx8ulp_sim_lpav_regmap_cfg at
all.

	struct regmap_config regmap_config = {
		.reg_bits = 32,
		.val_bits = 32,
		.reg_stride = 4,
		.lock = clk_imx8ulp_sim_lpav_lock,
		.unlock = clk_imx8ulp_sim_lpav_unlock,
		.lock_arg = &pdev->dev;
	};

it will be more straightforward.

Frank

> +
> +	/*
> +	 * this lock is used directly by the clock gate and indirectly
> +	 * by the reset and mux controller via the regmap API
> +	 */
> +	spin_lock_init(&data->lock);
> +
> +	data->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(data->base))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(data->base),
> +				     "failed to ioremap base\n");
> +	/*
> +	 * although the clock gate doesn't use the regmap API to modify the
> +	 * registers, we still need the regmap because of the reset auxiliary
> +	 * driver and the MUX drivers, which use the parent device's regmap
> +	 */
> +	data->regmap = devm_regmap_init_mmio(&pdev->dev, data->base, &regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(data->regmap),
> +				     "failed to initialize regmap\n");
> +
> +	data->clk_data.num = ARRAY_SIZE(gates);
> +
> +	for (i = 0; i < ARRAY_SIZE(gates); i++) {
> +		hw = devm_clk_hw_register_gate_parent_data(&pdev->dev,
> +							   gates[i].name,
> +							   &gates[i].parent,
> +							   CLK_SET_RATE_PARENT,
> +							   data->base + SYSCTRL0,
> +							   gates[i].bit,
> +							   0x0, &data->lock);
> +		if (IS_ERR(hw))
> +			return dev_err_probe(&pdev->dev, PTR_ERR(hw),
> +					     "failed to register %s gate\n",
> +					     gates[i].name);
> +
> +		data->clk_data.hws[i] = hw;
> +	}
> +
> +	adev = devm_auxiliary_device_create(&pdev->dev, "reset", NULL);
> +	if (!adev)
> +		return dev_err_probe(&pdev->dev, -ENODEV,
> +				     "failed to register aux reset\n");
> +
> +	ret = devm_of_clk_add_hw_provider(&pdev->dev,
> +					  of_clk_hw_onecell_get,
> +					  &data->clk_data);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to register clk hw provider\n");
> +
> +	/* used to probe MUX child device */
> +	return devm_of_platform_populate(&pdev->dev);
> +}
> +
> +static const struct of_device_id clk_imx8ulp_sim_lpav_of_match[] = {
> +	{ .compatible = "fsl,imx8ulp-sim-lpav" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, clk_imx8ulp_sim_lpav_of_match);
> +
> +static struct platform_driver clk_imx8ulp_sim_lpav_driver = {
> +	.probe = clk_imx8ulp_sim_lpav_probe,
> +	.driver = {
> +		.name = "clk-imx8ulp-sim-lpav",
> +		.of_match_table = clk_imx8ulp_sim_lpav_of_match,
> +	},
> +};
> +module_platform_driver(clk_imx8ulp_sim_lpav_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("i.MX8ULP LPAV System Integration Module (SIM) clock driver");
> +MODULE_AUTHOR("Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>");
> --
> 2.43.0
>


Return-Path: <linux-kernel+bounces-876746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 601FCC1C23B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D86033440C4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E842F34405F;
	Wed, 29 Oct 2025 16:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z3PobGlw"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013035.outbound.protection.outlook.com [52.101.72.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA8D335091;
	Wed, 29 Oct 2025 16:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755844; cv=fail; b=rm+HQcwpNu8XntHXOdXP16u1DhpgUfZE1Tot0FXk867XapohD6llyjZ9aYDgMTRVB4Fa1713Xss3oqnOiwNZhVVLhDPve/YJJTeTnNu6x/wlEaNwYYnxywaaIQLy7wvP2rdWxNqaVCeh62fAPdFpByAjLOtf5pNWPuUwoOc+N/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755844; c=relaxed/simple;
	bh=YJpC9n9iT+4JLffLQYrvMK97WHCHlPXrxZAoTHGZdjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZlRFMd0pp5mWyjnRZ9ez3d8KHd9bl/gEUPiMPXHvndW0AiKFadUANlz/ofL3NoRSdCZKrC4xPK3jvlND8PtvTeyOcgoPa6pkCBXCqsOS3Dtepphh3Lp8bPcrIcAtqQHedAu+GS3FwEy+mPQhcSkPix/qjzVzc5IX9wV3GOkNHqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z3PobGlw; arc=fail smtp.client-ip=52.101.72.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aa+GlXchmcfI1tTJHGLsn5r/7kJN/MvNLDkHaQNPE3sBN8FGq8EU9FP7XTbvn8MCJX9ne77nIWWY+Z8/jYbkL9yBRQgElwNGzk9ZnJOlbtxA2xXJVg9sEsgKFjnZD+JUMZaYWIkfd5A1BUoWGHXzf4YzU5ciFZDjJuqR13MU0t5qTFvI9kEE2FvJnv7zMW43N+I+mO62iyYt0drsRfOw7Fao5rLfL/Z8ubDG2FiVjhL0wQdXvUahuSUDIGe8Lw/qnMKqZtqmjD9oVSt5BvljNckmZQRl1lLL82SxGm5zT3JJ67Bd+pTOtW9n88FKI87eo9E+nphDCFzZaNnxub1RkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzbgJNsFCm2s8kZGrRpVogd8nnClBtV3Cnvj7MvBmoI=;
 b=RHik1SYlhDMZKYClUhwOvqcABBjg/8g5V2BLHyg1b32zJZRsLUKv12bV23NlLx/pQQJgh4ci9V5SCAZrpsF+XDHMYR29ODTUKUl2XMcuZbV0QuATI9wSoijHlnNIH1HxaUHFUzs2oEGtaqqpXldA861OZBRQsr8Ur2O1sBuSmppr8UZF1GxYzuOsYMHWiLQM+7SNpzykHyXIwudW0Dj2PiW0acUjzUPbsW3av3V4qBnTqf6gB26hmqiIb0i0f+Sy1VSAi4TWWJmP6gXx62OAwQixWXz20a4DjW2/k5f/t28E1ac4nslAWXIfYx340ObGsdkGqgJZVc1fzKV9l3Fqyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzbgJNsFCm2s8kZGrRpVogd8nnClBtV3Cnvj7MvBmoI=;
 b=Z3PobGlwCrvnTe3BJZqk61XPtrNwdueazCDJerrZaEFGnPhiJsQpXEKKXW7/PzcOEqprglNJ+hmF2M43orsRM1e4sDDT8b6oQH6wPZ3+H0BpOgCn570xk8abzO+DWesrOroyRDcvJtNhW7DT4kSswVA9/AfUsIMwN4Pw8pcOp+9ZTxLj1IYYw+Tfsm/KaIG9kzs03ARHeOrqaBItEPPqXhvVJM09YSK96WJIdJ/2IvaI+kiG6HSYurMacC+zbjMgDnUlQ78m5GUzS8jpSdJGDHMfUAA7iHTeQAyb0L/3BhcvF84vVsoHQl9oZkIjqcN1tyN9pujkFmHLHd6o+aHgzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM9PR04MB8890.eurprd04.prod.outlook.com (2603:10a6:20b:409::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 16:37:19 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 16:37:18 +0000
Date: Wed, 29 Oct 2025 12:37:09 -0400
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
Subject: Re: [PATCH v3 5/8] reset: imx8mp-audiomix: Switch to using regmap API
Message-ID: <aQJCtZjAGiQdzfDz@lizhi-Precision-Tower-5810>
References: <20251029135229.890-1-laurentiumihalcea111@gmail.com>
 <20251029135229.890-6-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029135229.890-6-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: BYAPR21CA0008.namprd21.prod.outlook.com
 (2603:10b6:a03:114::18) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM9PR04MB8890:EE_
X-MS-Office365-Filtering-Correlation-Id: 89f54ea1-4253-4c1d-014b-08de17096d23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OGagFcoqExX9HZaD+bVd3a9sCeqwfW9Fh4tG54LGKnXyZA4iOC9zKOrfw2Q4?=
 =?us-ascii?Q?NxC2v1hcDIgH+zXBewLGAYiJlL/KyI/ZKhANHpW7ff5ii38jp/zlB0tGkqPv?=
 =?us-ascii?Q?2wwSMYrseltkMS4NfmIL9mUudYHEgruV2RJ4oU3pbNmLHBm4OpncIMnvYTTJ?=
 =?us-ascii?Q?yauvmFFG/isZN1+0KoCaSfHN2IusdFsseBZYYhwYkVI62RmSHLvgh3O4NLnQ?=
 =?us-ascii?Q?0eu0ZMXHlEamJGr56ZDN6WM2/df5/8y9bJ/N+Yg1VuQoGFvLIrCgUcFC22RV?=
 =?us-ascii?Q?TqoYF4zVo37GuFTUIwi/yU98KmEh+RqIZPlLC/22dgmuVcLryvOjGZ1EbVUk?=
 =?us-ascii?Q?Af2u2biLtjCoPxyS7sD2nZqVklZ+EJczUbinLtc1Yzcrkb2VwozOm4jH4Zhx?=
 =?us-ascii?Q?wsNAElORB01HgBwB3eJ00kVM7uw4dvwOHgYr7VatsP68DVEvde1qWUQlVJbG?=
 =?us-ascii?Q?Msqp9Qp897E/wWnxgk6jFomK6o5Xc95JAkHiv51kaz3QNbMdGa9HUyYZFXg8?=
 =?us-ascii?Q?vAdYFyEMOJWmdaUxFbCU5Go3p7/XBpLL8CZIna4sHtmrzVBvnx7frjKFc17a?=
 =?us-ascii?Q?eJGNkrdxyitZEMu42sjJTioj1+sxDn+PGKWsbQXnmPoWyUgLIKFKcvnD0hBd?=
 =?us-ascii?Q?94pB295RKjEjyoylLRR5kSI2MoLC5EiwO8cHyo9OXRSoAMEZjOtu0tZa6DMs?=
 =?us-ascii?Q?+l57nAgGd1ERvEwI0f7HLaMuL0uiqDNi2khpMjF+mc6vEZczw93HPqPCKS0X?=
 =?us-ascii?Q?F7lQ8IYAprH+EeeSclBOpPZqpgP6j1/GJqvO/4EVTstdLlFKQ7Ev1qTNvPkd?=
 =?us-ascii?Q?YcRuVRc4d9rDsMARsA3zlw3TqRZ3duoey+QRj1bBB+/7xEMwlr4tXHb75XGJ?=
 =?us-ascii?Q?gyY3hf936IBMUnQNzqNxFAKXfrXdUURgz11JxY9ijjl44SblcPsEJq+JAkGp?=
 =?us-ascii?Q?kzXUHR+PoBWf4XFjY9MwEE7/HLOtlh71a7iuf7w+Ni0IDmIY9f9tvkpwtxCb?=
 =?us-ascii?Q?DSCES5VUdPoHrCXpKtVh9hdT0nCrWURCrGHx3+y7CiruFJ5A7ZclfMx79ZgI?=
 =?us-ascii?Q?285PzU/M65yS4uxsiDSTjty5yGQDTHkR2EbfMHtXBTzm28pw59Bt4CI7/0sr?=
 =?us-ascii?Q?MbNvrMDk++zju14QgFT+EvRgZPAUrpO6hSMiaE398AuhIiGVwG/1XHuGbjnC?=
 =?us-ascii?Q?k5GLceWGb+kB5wIEppd5H7AVd/fOIEPFtfipAQS8M3CJvNAKw28T8YmDD9JX?=
 =?us-ascii?Q?zivn4kZ4MsE89DWVbPXWpojXpzWvo1bsYQmcMspqm3n0Oo0Unyw2p9HGiO6m?=
 =?us-ascii?Q?P1Lo2iBLD1L7Lm2qKF2uBmqexsiKdermGnX6iC9Tv3ELqJPSIAmDMjz0n4y+?=
 =?us-ascii?Q?iolqJbreb87mTc6oU0cmfs8RHD2sAp0SD345g7jvjW+Hi+hNv5PrRlsxzvgF?=
 =?us-ascii?Q?4Mla9ObUVFAMwC8ionZhd+5vBeAbidWfN0qzJWcQt+hJ0RTFcG6VRP7+mW02?=
 =?us-ascii?Q?eoexQmmwV12rGU70Bd0sF+FSvjj84Kwi9zo7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DycKFQ7moPpeZG7LtibkRwuu+c8dbx/ARWlT89FtaMBano9yuZ8+1iEXPwiP?=
 =?us-ascii?Q?aMo748t164n+O8iI4cdUgfm1h02bbNRd/1LkFulnlnQ5lw1wgSuKGKii1mWy?=
 =?us-ascii?Q?qFO0MV+OyFDZC374UvmE98cJprIL81Y0jlxhUxgAzCvu0xqXvLGqiiusfFgk?=
 =?us-ascii?Q?RJSXVBKgVHs1o3peGXvydNsXSsQiRqTM9wv52TyfGD6mCLdNFocJ8wC/sqTc?=
 =?us-ascii?Q?iuNkDulFreWp88UUDJtgMu5+/3V7x81qsNlw/klIFHI7dZRiA9uTTcpFtBN8?=
 =?us-ascii?Q?xd1TJvb+GUJO25MZWlIoyUT3yFdGU3pJNMKiJDuK+6b0wDOfaWz0jVBDyVvg?=
 =?us-ascii?Q?OfacxFFc9BWapWACX/JCKhNlCZjb2s73h3RNjg61+yUgEx6lA+yT/lOfCvsd?=
 =?us-ascii?Q?ecXWOqq5KEpME+7cjg7YYKlEdqq7Tl5OJnTUyMyrxpD/b8E3d22Np+oLLDdv?=
 =?us-ascii?Q?8fMt9JMESWpqK2nqOv8A2x6+Dm4dvhDFWuYxIsO2y3bJ2D3FE2GlDJ5q2/YT?=
 =?us-ascii?Q?bwsqCDqbQOdE70HA7I3J+N2v46Yb2m7qgnV69IJjTzLypqxKBTu/OIBByael?=
 =?us-ascii?Q?ltoSvTpemhIMtEY4dWVHZc3ebwEKXNvbj8qGLz4GBXes310QR+tFjmPxFLe7?=
 =?us-ascii?Q?F9PV4QHcNvchxQBXkpYjD47AVbOHjvWsiztG+u4mXXKpPHMsLC+zjTW33se8?=
 =?us-ascii?Q?pK1g8AeC2FOgfQV3Tv+nldovjzd3ZVeqJFXkCcfLF0uRt0mtvRmYURvaj0BK?=
 =?us-ascii?Q?2fm7MArNZKQnW2TzWBBRpWUyVuIKX5srVNdE7PDtmp6jjLtNDdcaN7mSVIFe?=
 =?us-ascii?Q?k7ebMRWQG1MAErWCEaDmOglRDCnc87e8zaRp37GtMhV7MpyN9eJ7SryLBJJH?=
 =?us-ascii?Q?wk/bybMInHm+70AxOL3jDWsPSTD5DjCFPQhMjzgGbUMBJwuwroJlKgiUzJhU?=
 =?us-ascii?Q?jqsyz5LILMOJRt+DlOw0e7S+YUfNVE3yHfSt/xS3GP6WQl7yjuY31YYtu9ak?=
 =?us-ascii?Q?H4y/3H5DtPCZM9ClvW1/3O6N7TdR1pZf7avWPC2TwnTNijG9QxeyaeWZABal?=
 =?us-ascii?Q?RQIB+ofEyy3oAogwYAVJTyFDArwV42rLj2nXHWraIe/vLwlCeUJMr8kDwlHH?=
 =?us-ascii?Q?k5VgYJ6ybfDpy/6nOKS7G4s74X/38Aq/aQcgciu92az/O/hL71Pr+TMv0UEB?=
 =?us-ascii?Q?/HnE4bEsmTevLKgdSALGjVXaxhPIGqHiu/+ougyNsyAdEzjejDqxczi8Q5vA?=
 =?us-ascii?Q?OspQGysYnMlb7h6gNODn94XGoNXHC+8A/Jh0uG8Wsm9H61kN/zd6eGXyuxh/?=
 =?us-ascii?Q?jZv8LmmNNDDf9NB7VdTG9lpqYCY5/TidPAmdsfX8jdsMBpa7+lpKmA6HB9VR?=
 =?us-ascii?Q?pUPbmbSJZph5+oimoBbCsj0OWql2Uf5NjBZ98G+RdDZn7I60oXgMdWyFbNJc?=
 =?us-ascii?Q?SzvyvnUWCm/fmpDeQu6DEyF2CEt/+uMT9MVjTyOOov4y6HtfB0vuHEI4KBFq?=
 =?us-ascii?Q?5ZI+ejmHuMjBakpuFbBhatW+Or4Qc3dBqekoyfKEk3CTOb+F3+m2H5G2sVA/?=
 =?us-ascii?Q?lpLFmdKqTu0snDzVymw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f54ea1-4253-4c1d-014b-08de17096d23
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 16:37:18.8681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mqTWvdy0lyF8K1Ic8vl1H+c1nM2tkOZn3F3Qo9BWn5mnBX+/N2/DFEbMpD03aoiWgwOeAX+ZTicdr5KenxafEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8890

On Wed, Oct 29, 2025 at 06:52:26AM -0700, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> As far as the Linux kernel is concerned, block devices such as i.MX8MP's
> AUDIOMIX block control or i.MX8ULP's SIM LPAV can simultaneously act as
> clock controllers, reset controllers or mux controllers. Since these IPs
> offer different functionalities through different subsystem APIs, it's
> important to make sure that the register R-M-W cycles are performed under
> the same lock across all subsystem APIs. This will ensure that registers
> will not end up with the wrong values because of race conditions (e.g.
> clock consumer tries to update block control register A, while, at the
> same time, reset consumer tries to update the same block control register).
>
> However, the aforementioned race conditions will only impact block control
> IPs which use the same register for multiple functionalities. For example,
> i.MX8MP's AUDIOMIX block control IP provides clock gating functionalities
> and reset control functionalities through different registers. This is why
> the current approach (i.e. clock control and reset control work using
> different locks) has worked well so far.
>
> Since we want to extend this driver to be usable for i.MX8ULP's SIM LPAV
> block control IP, we need to make sure that clock control, reset control,
> and mux control APIs use the same lock since all of these functionalities
> are performed using the SYSCTRL0 register.
>
> To do so, we need to switch to the regmap API and, if possible, use the
> parent device's regmap, which, in the case of i.MX8ULP, will be the clock
> controller. This way, we can make sure that the clock gates and the reset
> controller will use the same lock to perform the register R-M-W cycles.
>
> This change will also work fine for cases where we don't really need to
> share the lock across multiple APIs (e.g. i.MX8MP's AUDIOMIX block
> control) since regmap will take care of the locking we were previously
> explicitly performing in the driver.
>
> The transition to the regmap API also involves some cleanup. Specifically,
> we can make use of devres to unmap the device's memory and get rid of the
> memory mapping-related error paths and the remove() function altogether.

Can you simpifly commit message? The key points are 1: lock, 2: nice API.
like regmap_update_bits().

Switch to using the regmap API to simplify register access. The regmap
infrastructure provides synchronized register access and richer helpers
such as regmap_update_bits().

>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  drivers/reset/reset-imx8mp-audiomix.c | 91 +++++++++++++++++----------
>  1 file changed, 57 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
> index e9643365a62c..3f6d11270918 100644
> --- a/drivers/reset/reset-imx8mp-audiomix.c
> +++ b/drivers/reset/reset-imx8mp-audiomix.c
> @@ -11,6 +11,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/regmap.h>
>  #include <linux/reset-controller.h>
>
>  #define IMX8MP_AUDIOMIX_EARC_RESET_OFFSET	0x200
> @@ -42,8 +43,8 @@ static const struct imx8mp_reset_map reset_map[] = {
>
>  struct imx8mp_audiomix_reset {
>  	struct reset_controller_dev rcdev;
> -	spinlock_t lock; /* protect register read-modify-write cycle */
>  	void __iomem *base;
> +	struct regmap *regmap;
>  };
>
>  static struct imx8mp_audiomix_reset *to_imx8mp_audiomix_reset(struct reset_controller_dev *rcdev)
> @@ -55,26 +56,15 @@ static int imx8mp_audiomix_update(struct reset_controller_dev *rcdev,
>  				  unsigned long id, bool assert)
>  {
>  	struct imx8mp_audiomix_reset *priv = to_imx8mp_audiomix_reset(rcdev);
> -	void __iomem *reg_addr = priv->base;
> -	unsigned int mask, offset, active_low;
> -	unsigned long reg, flags;
> +	unsigned int mask, offset, active_low, shift, val;
>
>  	mask = reset_map[id].mask;
>  	offset = reset_map[id].offset;
>  	active_low = reset_map[id].active_low;
> +	shift = ffs(mask) - 1;
> +	val = (active_low ^ assert) << shift;
>
> -	spin_lock_irqsave(&priv->lock, flags);
> -
> -	reg = readl(reg_addr + offset);
> -	if (active_low ^ assert)
> -		reg |= mask;
> -	else
> -		reg &= ~mask;
> -	writel(reg, reg_addr + offset);
> -
> -	spin_unlock_irqrestore(&priv->lock, flags);
> -
> -	return 0;
> +	return regmap_update_bits(priv->regmap, offset, mask, val);
>  }
>
>  static int imx8mp_audiomix_reset_assert(struct reset_controller_dev *rcdev,
> @@ -94,6 +84,50 @@ static const struct reset_control_ops imx8mp_audiomix_reset_ops = {
>  	.deassert = imx8mp_audiomix_reset_deassert,
>  };
>
> +static const struct regmap_config regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +};
> +
> +/* assumption: registered only if not using parent regmap */
> +static void imx8mp_audiomix_reset_iounmap(void *data)
> +{
> +	struct imx8mp_audiomix_reset *priv = dev_get_drvdata(data);
> +
> +	iounmap(priv->base);
> +}
> +
> +/* assumption: dev_set_drvdata() is called before this */
> +static int imx8mp_audiomix_reset_get_regmap(struct device *dev)
> +{
> +	struct imx8mp_audiomix_reset *priv;
> +	int ret;
> +
> +	priv = dev_get_drvdata(dev);
> +
> +	/* try to use the parent's regmap */
> +	priv->regmap = dev_get_regmap(dev->parent, NULL);
> +	if (priv->regmap)
> +		return 0;
> +
> +	/* ... if that's not possible then initialize the regmap right now */
> +	priv->base = of_iomap(dev->parent->of_node, 0);

Not sure why need map parent devices's ioresource here. You'd better use
regmap_attach_dev() at parent devices, so dev_get_regmap() will get it.

Frank

> +	if (!priv->base)
> +		return dev_err_probe(dev, -ENOMEM, "failed to iomap address space\n");
> +
> +	ret = devm_add_action_or_reset(dev, imx8mp_audiomix_reset_iounmap, dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to register action\n");
> +
> +	priv->regmap = devm_regmap_init_mmio(dev, priv->base, &regmap_config);
> +	if (IS_ERR(priv->regmap))
> +		return dev_err_probe(dev, PTR_ERR(priv->regmap),
> +				     "failed to initialize regmap\n");
> +
> +	return 0;
> +}
> +
>  static int imx8mp_audiomix_reset_probe(struct auxiliary_device *adev,
>  				       const struct auxiliary_device_id *id)
>  {
> @@ -105,36 +139,26 @@ static int imx8mp_audiomix_reset_probe(struct auxiliary_device *adev,
>  	if (!priv)
>  		return -ENOMEM;
>
> -	spin_lock_init(&priv->lock);
> -
>  	priv->rcdev.owner     = THIS_MODULE;
>  	priv->rcdev.nr_resets = ARRAY_SIZE(reset_map);
>  	priv->rcdev.ops       = &imx8mp_audiomix_reset_ops;
>  	priv->rcdev.of_node   = dev->parent->of_node;
>  	priv->rcdev.dev	      = dev;
>  	priv->rcdev.of_reset_n_cells = 1;
> -	priv->base            = of_iomap(dev->parent->of_node, 0);
> -	if (!priv->base)
> -		return -ENOMEM;
>
> +	/* keep before call to imx8mp_audiomix_reset_init_regmap() */
>  	dev_set_drvdata(dev, priv);
>
> +	ret = imx8mp_audiomix_reset_get_regmap(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get regmap\n");
> +
>  	ret = devm_reset_controller_register(dev, &priv->rcdev);
>  	if (ret)
> -		goto out_unmap;
> +		return dev_err_probe(dev, ret,
> +				     "failed to register reset controller\n");
>
>  	return 0;
> -
> -out_unmap:
> -	iounmap(priv->base);
> -	return ret;
> -}
> -
> -static void imx8mp_audiomix_reset_remove(struct auxiliary_device *adev)
> -{
> -	struct imx8mp_audiomix_reset *priv = dev_get_drvdata(&adev->dev);
> -
> -	iounmap(priv->base);
>  }
>
>  static const struct auxiliary_device_id imx8mp_audiomix_reset_ids[] = {
> @@ -147,7 +171,6 @@ MODULE_DEVICE_TABLE(auxiliary, imx8mp_audiomix_reset_ids);
>
>  static struct auxiliary_driver imx8mp_audiomix_reset_driver = {
>  	.probe		= imx8mp_audiomix_reset_probe,
> -	.remove		= imx8mp_audiomix_reset_remove,
>  	.id_table	= imx8mp_audiomix_reset_ids,
>  };
>
> --
> 2.43.0
>


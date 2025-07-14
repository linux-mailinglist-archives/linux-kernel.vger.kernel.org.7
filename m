Return-Path: <linux-kernel+bounces-730302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3343DB04289
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C17CC7B2FAD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D2C255F2D;
	Mon, 14 Jul 2025 15:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mWYU9Ljy"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013028.outbound.protection.outlook.com [40.107.159.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520DD246778
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505459; cv=fail; b=tgsKOSGw3/oyebLOMzcwUsXk7PAEDDrA3Kj+Z8hlMRmpGu6RCJDO/x8evxGYtWhGjPe/2eCoVJO5IBvbMuUA+l+d9q9lTPTzfQaiTEw3kKfpruKnVJoTP476HheM1dY2+mDFEyxADla6h7yGn9a0qRz+EiZlIQtu1pQ1+ksVE3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505459; c=relaxed/simple;
	bh=Zk1w61qGE7nHKxp/3z4kCjfw1HcViGjiljyHHTpgcYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r95p4tdP2fdDFSTIJGI3wrECW+J4JfXG/RCOGMpG7NjibMalWukUK0P8aPAoCuXbMjACPKXcm52GAo+Xzs2Ies6glwpjgK4t2aFoiCc8F6P9MU7yNrm6ySUgrTrf48YHvqD6AsNHos5Tas/eNSUV45Au54JaBmvdADr0aMazq/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mWYU9Ljy; arc=fail smtp.client-ip=40.107.159.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0Q4aMr2FTlDnWFBgepTZGaf+khEFulhcbEQHe9Nfg6hIitGlUirvBnvd78gwBec/mB0sH5dKYq/bYY20M5lJ+DCqMLtwjWllzxIXggb6iY4XucTavRRwu8jCFZlJ+/jj7mfo/2QlGXXmc9YjaJ3NqeDgysvnzPuTdWES2PQBYGzefDG0j836NyptJ6rbMqIVwMxm3yY8MR2coe0j+nQpJ+0zp1sYGNOCAP3gJSWgBnhFRZHCXiU6AFxMnALRyZ16rcb40wqk1qc0Dm/CGMErCLG/1r2CgN2WFnnoOU6SNCIptZFLZUi31RiBE3U38+BHzNfLztGund/9eSKW7zszA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2bhXAOXN3SIsiDA2syisuS7UA0Oi0j1WOg4BmYPqmY=;
 b=SS2Nccocy5PAZcijsjqCeYveGVQyehKNLXmiD6SzRhIBAZ/tOHsTis5w2SgwzUYoxnxrb0BQlkUTiDguiCc9twutsjU9dDFGoYmTbr5d727laNaCFOwKu/tDEqFQ0oP7zJwvZn6O+9UzjsVm7IiW12cgG+cg45flnD3hiRboliH9PSMQo5MQOmT01HTDsloyqClzWSr5DML4A59gPU0x5F26g6Q7U1//OzIVry4h/zefPuw4cF3lXm4Z7fUg85peR+IdC32M1o7M8pBZCPUEi2U5lgdRFlL5RB3coOGjpP3p83HiLDFbFzm5y2dqdjjFtUgTNMtmYNnjPeJEz7Gf3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2bhXAOXN3SIsiDA2syisuS7UA0Oi0j1WOg4BmYPqmY=;
 b=mWYU9Ljy3rU9nlguArL4dkC0RrYbVn1XMoZ3+naG3xKqEdDmHX4BuNnoyG/J+DMHmK9zux8ayAISVAdUaBuSeeWAyHjQMT6HmO+kI+2DNCyELFWtZJd+BnOf7V1AI1YamXcnDITElYYHswx0uotI1Cov5i+ZiXq0qzF9wUPrywS/i06pGx+4FZPnZBAzypcocHdBR/yx4D1/88P5PmMScNtyfJUIrn7VzJhNimRXqq4m7f6NaOJn8KlhOW2OKg7bYHZqIl5o4oVT4NKVNS9sOCFXq/Pg3XijB7BsvRZtaQU5pgjECStoB3BOX0s3JhpwIsTkj9tZ6wJ7S5llFhEQVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8810.eurprd04.prod.outlook.com (2603:10a6:20b:409::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 15:04:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 15:04:12 +0000
Date: Mon, 14 Jul 2025 11:04:08 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: =?utf-8?Q?Przemys=C5=82aw?= Gaj <pgaj@cadence.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c: master: cdns: Simplify handling clocks in probe()
Message-ID: <aHUcaE/3L1Yr+Wzb@lizhi-Precision-Tower-5810>
References: <20250713152411.74917-2-krzysztof.kozlowski@linaro.org>
 <aHUQ7Ge97/glY+s7@lizhi-Precision-Tower-5810>
 <f9157fbf-09a1-41e5-b5f2-902ca20b870d@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9157fbf-09a1-41e5-b5f2-902ca20b870d@linaro.org>
X-ClientProxiedBy: AM0PR06CA0140.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::45) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8810:EE_
X-MS-Office365-Filtering-Correlation-Id: cd8aa3db-8017-451f-6ea3-08ddc2e7b164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|19092799006|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s4j1HhVO2Z2vdbOlnK0sVQUIw8VVQpSv8Qa8atDxn1edz2vssx+B5+i33t8b?=
 =?us-ascii?Q?H8bcaNxGqJtS57c8DhFk6cdgbEhRJkNMlyvXJmYvel7PlwFPM5Ufu7BhYwSS?=
 =?us-ascii?Q?WQdRrOYT9cOV/AJYX0/OPTvxR6j8JrUhOGjcqnM5ZEnNicNrXVWR9KIRYbC7?=
 =?us-ascii?Q?lNCIk1USUJDplSdQD2DEA8r2hlDazM7SblqxJtjG6k8C7ZE6BaMagUBoGH1Y?=
 =?us-ascii?Q?PBobCmNQ2lh657YU4F8DEA9hIPfPliuZwGMvSS/e8i3Ry5u4nC8pD/7TvyPc?=
 =?us-ascii?Q?eQQKYx8ld/K2q/IL8BaMYhwNyfl+cNhhR8Wjnb+r4d/uejjVU21Xj9hq4bVI?=
 =?us-ascii?Q?Ue8kg9XrjEzketUkGF1TMgy4lexq65YQ2wFb+gNSCb64NHNlW4YfPr9Cv90d?=
 =?us-ascii?Q?3umYSJpWW9aZvHNsZwh+Mog0ideysnG8V2ovAmOX0V/Jbax8WdG5QIE7D+Qy?=
 =?us-ascii?Q?6ODBJ23c78vpunBuAuOsup8FDv7SQfcX0hsULhPtAS7UNCJS0NRwd+eXbICH?=
 =?us-ascii?Q?mGpIR7tssVtZyv6EOie6BmimEigYGM31+4RuwjQThagoGdY+37uEQQnobNdj?=
 =?us-ascii?Q?YoI7X44B5ZMA5axqtIQCWz31AG8P7YSOuwy9gRBu2xZCgzP2QzVEdeD9YREw?=
 =?us-ascii?Q?5kBFb1wDGc/H3r6TDR8pwf7ElexdNRf4w7ZdkwUjixD5ATSwKAtC60Wdum0D?=
 =?us-ascii?Q?jOYdCdnAR7lWBeuETvgGRDGdytD6GttSXsARw67WyueHifMtvBh4zP2QcHHP?=
 =?us-ascii?Q?qkwBRfRy03b8qymGrQyCJzpK7/2GcGlvOHZ1yY9YIIY3gXyaIJByaxQtKSe9?=
 =?us-ascii?Q?o7kvxfOEQqkWeR0y2aQnDXUKTbQ7V9sXj35Ukn9bom+CibmQCuTiUEHVKjC0?=
 =?us-ascii?Q?6juOhS/ip2fj6Djab4ENMZmgzd/Qf2+xG3mDfXA48ZIYtxfbfVyAw7DLq2hg?=
 =?us-ascii?Q?PlX164r8Gbjs5yjox3LvTGrOpkwDIrt/6AwxgYptTCcn51DR6fOHMdGezjP2?=
 =?us-ascii?Q?Zoe2Vlh9nZLg6F3gEvAm8vKNy7Fzy4eisvF8pPaWiRkDlif9VGCw5PHQWriT?=
 =?us-ascii?Q?2VIesEJNGDX8YrK3u7A+hqiSue4c6nJI3RyRZmsczq0T1Ri7sOEX5uKTIgyK?=
 =?us-ascii?Q?cdV7BHl1aN98HEqrZ7p8npdSWgAfak7cQ7josQsh7146+ceupqYtmd7gYBmu?=
 =?us-ascii?Q?i+d7Joe9w1hH4OxBJAZAFIAmRgfYZb2at7iSpw1RThy0SAdt+kQ343UvSfPv?=
 =?us-ascii?Q?6vvI8O+tfewlcjlK4bNQOUZx56MpxWCDpd4iHHFt1iUyfJHPo1+UeNVK+cKi?=
 =?us-ascii?Q?yrrzaQ6Fs5CBQ5nVCkHFI3qb8Xl6d+C8Um8XV8KryZwly4MI1/cV2bn+FbVW?=
 =?us-ascii?Q?IwdXzy7aEh3RxnpVuPPxdgeO9SQch7ATxWjO3h/wrm+9k8dfLyJDQI5w2EQy?=
 =?us-ascii?Q?MykbVqrWfnM4/WAWKw/5Xxall2kHvGevAq767qZQ92FfXdif6AI9rQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9/XS4wql8fdghqXajXbGBHngrg+kULLPVNeJYQnXtJ3x4vlzI3tgbiUt7PLg?=
 =?us-ascii?Q?9QF/C9+0AWZSNJF/rtC7jx+NiXpedQvk7B4C1janilVloqrk6JHBZZppNyoc?=
 =?us-ascii?Q?Yrq/A6IUzkAo7MeIljAmYUB3wJQjiJoteOtVftT10fb9t4dvsIe3CjCBzhRP?=
 =?us-ascii?Q?gvgdFI4XbUiM+xjYRpIRc3sMijojffrVtmTXfa5p2yIrZdurNzxObUeIUauV?=
 =?us-ascii?Q?UI0fsHPsBNlF0qnvJcueFSoXCY6V0BVj0F1wID7+Mg8eNhyQab5qmnzHzbLS?=
 =?us-ascii?Q?sLm2+bdksXOtrpfipm0n+opX4iSXZPPupNV5fIbzKw+7sv8ds3xxWYGOFqVy?=
 =?us-ascii?Q?BgDye79/rOrbrp+ZLxDZUE9Lq1EUNTWE9BOnQ66SSHyI+4UXMTcT9Tip00pM?=
 =?us-ascii?Q?fDU7t+/PBpBCIiYq3ye6pQKwaRucCtZCHEmF9GTf2p7EjEJeM7BdnPo8OMfG?=
 =?us-ascii?Q?GIFNcLs74A/DHabKCq9XsI05spGeK79LdvqFeu1X0coiA/H/i7zcXd9OQMNd?=
 =?us-ascii?Q?pLeZD+yZSFnK3vwXhqTnTqDPjnSwIYl3IjrXR8BrGVecl0Q9cgRu2PluHEw2?=
 =?us-ascii?Q?MLtvcmji565WkDEe4HLR0SAIckk/xa5X9Gi5mjyCgLfzIflPzapG7W+dhTuk?=
 =?us-ascii?Q?eZJBWvUjfA4/g7yQeLhrULk7KhdZvuV9t/D+SvyglhrsHzoiPLqybq2cbP0u?=
 =?us-ascii?Q?jolZQMDhlACj3gpprACoHeaV7UeGltB/uEPWczhtDUFEXFc4/Phn03mkxXOo?=
 =?us-ascii?Q?NhdYDNmCcopJ3+OEox01yLXDkxGVqfybN82Z+Qs0J2opwZdNU24kVvQczktE?=
 =?us-ascii?Q?m+0cKAQ5og+v83WctM342DP0ZhcIYwbdGlZukZHbrlEK6bSYTJt+s9Ll7UR1?=
 =?us-ascii?Q?+cctgNTdcMJ2k2OiefXVHTtKRYqYFSrYFt1GVBhxtdm2P/IY0xh2PRgkXgii?=
 =?us-ascii?Q?tdN7U5M6Up7UfxvtlaUdDdpCc2sKWSDUoQTy+K6Zs5RGhouMddkO4vH/GSmM?=
 =?us-ascii?Q?g44vvyOkW+4pQGpMqrXuygpFZ20bWA/0/JxxatJmXZ4lpdFUJ8PGowVK7lnx?=
 =?us-ascii?Q?2jYaM7VHgVweu3U0ydgdMN/RBSlK6XjMHu4iyEAAMuaz2x5IRhFyjcWXiyjZ?=
 =?us-ascii?Q?NZVaX7t3BYB373K8mJ55on7uKtB28QveM6pRKnxG+8ihCucUVcI9a0U2zSZU?=
 =?us-ascii?Q?uJDDzgYoDng9Utm4FMu5Ir6cyNUXefHneG9JkIyYzNSd/2aC8GS7Q33rwYNn?=
 =?us-ascii?Q?aGjc+3bpmVZmegoZKQKvWHrdNKfXnKf+ErnX3h+g0MH8ilcUmgAQad/HBXHc?=
 =?us-ascii?Q?qvCSGnxq+bDl5GcKbOHKpaT5OVuLUp5sEgBmZ4yQ5bycgU4LhydVS0opwtCB?=
 =?us-ascii?Q?PRTVPQnxvn56E73uqQoj3DpOMtzir7F+N5slybPNEYaYPb/2/t0aLewomI83?=
 =?us-ascii?Q?g6Ezg8EANmmWf3Kyfcut2prg1MyMtA5VEiNJgiRl7c3vIdFITeXq4phBmU5X?=
 =?us-ascii?Q?rbI24Y524ilNdJw9QoggHI0kt4M+yt9Obwp1FHXAMNCs4XXH+0u/jZjvj1bg?=
 =?us-ascii?Q?nAzvjgteUb9aiNy5raA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8aa3db-8017-451f-6ea3-08ddc2e7b164
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 15:04:12.8496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xH0gt7Fa6K+RKyDJQGmfmN8B6kA1wKKdeCjf0Bh44z4++A1lWXwUPUvF8Wr4gBoNpx97iToBcG/BZZuAQoWgBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8810

On Mon, Jul 14, 2025 at 04:40:53PM +0200, Krzysztof Kozlowski wrote:
> On 14/07/2025 16:15, Frank Li wrote:
> > On Sun, Jul 13, 2025 at 05:24:12PM +0200, Krzysztof Kozlowski wrote:
> >> The two clocks, driver is getting, are not being disabled/re-enabled
> >> during runtime of the device.  Eliminate one variable in state struct,
> >> all error paths and a lot of code from probe() and remove() by using
> >> devm_clk_get_enabled().
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>  drivers/i3c/master/i3c-master-cdns.c | 51 +++++++---------------------
> >>  1 file changed, 12 insertions(+), 39 deletions(-)
> >>
> >> diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
> >> index 449e85d7ba87..cc504b58013a 100644
> >> --- a/drivers/i3c/master/i3c-master-cdns.c
> >> +++ b/drivers/i3c/master/i3c-master-cdns.c
> >> @@ -412,7 +412,6 @@ struct cdns_i3c_master {
> >>  	} xferqueue;
> >>  	void __iomem *regs;
> >>  	struct clk *sysclk;
> >> -	struct clk *pclk;
> >>  	struct cdns_i3c_master_caps caps;
> >>  	unsigned long i3c_scl_lim;
> >>  	const struct cdns_i3c_data *devdata;
> >> @@ -1566,6 +1565,7 @@ MODULE_DEVICE_TABLE(of, cdns_i3c_master_of_ids);
> >>  static int cdns_i3c_master_probe(struct platform_device *pdev)
> >>  {
> >>  	struct cdns_i3c_master *master;
> >> +	struct clk *pclk;
> >>  	int ret, irq;
> >>  	u32 val;
> >>
> >> @@ -1581,11 +1581,11 @@ static int cdns_i3c_master_probe(struct platform_device *pdev)
> >>  	if (IS_ERR(master->regs))
> >>  		return PTR_ERR(master->regs);
> >>
> >> -	master->pclk = devm_clk_get(&pdev->dev, "pclk");
> >> -	if (IS_ERR(master->pclk))
> >> -		return PTR_ERR(master->pclk);
> >> +	pclk = devm_clk_get_enabled(&pdev->dev, "pclk");
> >> +	if (IS_ERR(pclk))
> >> +		return PTR_ERR(pclk);
> >>
> >> -	master->sysclk = devm_clk_get(&pdev->dev, "sysclk");
> >> +	master->sysclk = devm_clk_get_enabled(&pdev->dev, "sysclk");
> >
> > Can you use devm_clk_bulk_get_all_enabled() to simpilfy futher?
>
> Instead of asking redundant question check yourself. On a first glance
> it cannot, because it won't be simpler - you still need individual
> clock. But if you find it possible which is not visible on first glance,
> make a proposal instead of just random drive by comments.

It is hard to find that sysclk is used at other place only from this patch
without check source code. I think you are expert. If it is feasible, a
simple reminder should be enough. If not, simple reply the reason/difficult.

In svc i3c driver, we use devm_clk_bulk_get_all_enabled(). And make code
simple because it use runtime pm.

In this case, using two dev_clk_get_enabled() is simplest. I think it should
be similar with svc i3c driver at first glance.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

Frank

>
> Best regards,
> Krzysztof


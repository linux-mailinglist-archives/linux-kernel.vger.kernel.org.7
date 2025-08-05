Return-Path: <linux-kernel+bounces-756948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C15B1BB66
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 22:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A076218A1B37
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 20:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7BC23C38C;
	Tue,  5 Aug 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W2pMVxvs"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011071.outbound.protection.outlook.com [52.101.70.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374D61FBC8C;
	Tue,  5 Aug 2025 20:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754425525; cv=fail; b=BzQ06lCOsUrYrm3jeUVO2Z7/xZSIKjK0ImjoPWJarSEdLs9yyGjkIqHKFeqcZAmsFvpk6W7lnIGH3hU4tBV3sdum5NyiVDTmv64RUHZXXqciGedU20G6svwyXZNSp3zPS3satez6ogW5vY5CiI5yqiEi/KuEUyHKbruVxEXy4bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754425525; c=relaxed/simple;
	bh=v/8S26LDywHZ2Gi2lYZfsRtod32PXC6X5LookRwd83k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uy5syPr7Kc2MGw1Ylv9QqlY0TNgoKde0PVWbDi7/xbPvVwBY0s9PiEYPx0CsVoRIW4h4LJJJUuVfTQ6fW4plhtbOWKQadoPKd+wPWlDcfyrU0rOewk/5O/YNUI3iyg3ugFI1S+vET/EkLi8+pEyR1LpiUG9FO91DtozJOz+lrzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W2pMVxvs; arc=fail smtp.client-ip=52.101.70.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yo3PvrUNQmOWYgYromaTRmH+PtnlGIkojkDN7yM6jWhA3KLep1u+abKzcopQZYerP0fXTKMc+emiEhvxkrTFwPDuoBqI/0zy9POGUTNmElwrG+P3zBL2uH8bpjcvFuAEeSPB085pcTDoed8w+jO6eIqw4pXxVLnj/JnBDNAiCT/FOBMWr6L5llRtRUBZfn8QBf0kWb0fvxSmVARb31yAMbjhObA4sFlqKaBHk3Kt2+GAUY7eSAwhVgpIhgz8FYHlZhdBDTMVD6md1TsAxIgR2PV7m61tlqgT/rlCX1At6VdADPnX27X+r0X8/vIkoCjvF1aPJ6EgWwxmn4rYb/87Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIlUNqmF7WguJWK6ExJC3nCjsh+24fVHX93STWkrhEo=;
 b=gqD3W8161pEt0hWg2rgciYd9jZuFC9vaI9YVEwMx/gciuAwPZ8UqXc/ZBv96ktzJF7VPFpsbWDLe3Kp89w3MFwp0HHPb20pMPV8AgRtWT5VU0qegL/OPNG5TnVMxNz9Q3AaJG+S3vCyecyXNCH+SS5I4/mPKcS+7MYhevQCA1RIThP3F4734MstNQmN1zceoyRljaQc1yc3GFowCVqlRy1yeyji/gWm8sztb2fvYTzdKSNuGcPkCaTkmiQmC2LuUoX7gvRLw2fAnNoyYi04N+zTutoa8YH5OUInA7+teRAu70/UEH2+KAieq5m8KeOlEHcQbV+tI7MFfLz1OP6XWOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIlUNqmF7WguJWK6ExJC3nCjsh+24fVHX93STWkrhEo=;
 b=W2pMVxvsGfPhcmNfn3hPTOE2Kptew7y0yx4lOhSPtk8S9kC1G2+8+R1pLxAOy9WhbWw9jMJ4CU3iyd8uGOkUd+98kzTMVNK1IF//xmCJniKD2qgUA4srJEDb2c30bMOhI3GQvhXOtrFRSvBWWRpopv1hdENGlahfK05xPgAlLh15YhXWUhvWwsPRMgA+spIpzRH1aGZVqKuYiiV7nuJjh9CJ/GZuEuuoSub0CrudaBxN3jXGxQHMmwSr0eQ3dS4icdNwYicK2JDU4d1MTEKsl7CSWn11XPBh+Yl919GAeZVIPhn4iF/JARLXQd+lfbkF7tdZr1ycm+HSoZqhuVw29Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10939.eurprd04.prod.outlook.com (2603:10a6:102:489::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Tue, 5 Aug
 2025 20:25:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 20:25:20 +0000
Date: Tue, 5 Aug 2025 16:25:13 -0400
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] clk: imx95-blk-ctl: Save/restore registers when
 RPM routines are called
Message-ID: <aJJoqZN4OOFS8hNT@lizhi-Precision-Tower-5810>
References: <20250804131450.3918846-1-laurentiu.palcu@oss.nxp.com>
 <20250804131450.3918846-3-laurentiu.palcu@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804131450.3918846-3-laurentiu.palcu@oss.nxp.com>
X-ClientProxiedBy: AM0PR01CA0169.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::38) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10939:EE_
X-MS-Office365-Filtering-Correlation-Id: 83e92d8f-7a3d-485f-0127-08ddd45e3292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dd6ad2iCxOX+yWetmnwn4YhYGXLTIzmPrpppU0KFT9oOKB3cGyByL5E7x785?=
 =?us-ascii?Q?nD8FqMogKhe5D1H8UacCm+lRt0VyyfzGO+Zj5ShWq6H9Uier1Tg3PopsQPtL?=
 =?us-ascii?Q?MIww4khnp4kAESBKIUxQxyY0WvTr6pLJaIkviX/iqT19X9+sdqcknvptKjli?=
 =?us-ascii?Q?kUw/IJ/ZFUlOX/LRgQRpzsTr90giQMBaZphi50xGgsP+hXucSz9MdjrlbdB7?=
 =?us-ascii?Q?dH/2B6EPDKTH1G0PmXgH83QtapMzuwUEpt0bn7KKxjk1itN9SyGx7Czq5BPO?=
 =?us-ascii?Q?gEx5SotsrW78vdnDBo5+mPq1KWvpjMwP40LfFY2mAboBY+KBBgJ5lOBjoVuS?=
 =?us-ascii?Q?PDChX9E3R94HfTPLgM36WJ3a+e7Bl7CZ0Rpw8aGTitm2q4pk+NJfCtwURjaX?=
 =?us-ascii?Q?Xh5UYe7KlFGJ78tdk7rUez5wN4CpNpQ6VLQOeCSthwoPRQsQ9RI5ahEY6pCJ?=
 =?us-ascii?Q?D2WhvarFGhfDF515qMQsnehEgSYbJXGr6KytNqBJXT+mN0zcriEaCykPVugN?=
 =?us-ascii?Q?T9VWbR29CAhyLh2fbGTEYkODzGT6Tf54me7X07TCqc7rtCAS2VAaeJ3FZCEi?=
 =?us-ascii?Q?BBlw27XikOab2nG//T4F3jlWlGDspoT4lc7TmPktKKbHdWhJk7q+ZNHd+25m?=
 =?us-ascii?Q?XfLpAc2EKV1L7B2hYS1NixxRPTc22kiE12gCIh6NN20AVQMCFeHG61Xv3/rv?=
 =?us-ascii?Q?59wue1/3hw5gRS8GEXIWegJ3PeYYNy4pnNHZ7Hq9kO/a85bbMNnexrRrvp1D?=
 =?us-ascii?Q?4JUfbO6eXRSZeSykewFUAigCflHi8Ymn/2TuBf+An6RyC+mCHzNZJErr8+V9?=
 =?us-ascii?Q?oKAi/LTr+R85o23Qjuk4ME2Ch1M0WvPPdyDA7D/+f3V6ZxsNAiJW9GFHbkoa?=
 =?us-ascii?Q?ceFXAn3yFYWzWPL4AhuK6R13He4Bn4ubf6fx5vL4zKG3YeJ3nOIs1rQuSiIj?=
 =?us-ascii?Q?3vU+snI7de4bG9NwSjjYKardr7lc+iQ3oM0NG8Ksam2ErIO8whFcCLCgyQvZ?=
 =?us-ascii?Q?RjiF2TuD7DOy/IBKcxb5msTmVRa+fbaqWKDnNjb33IeMDxnXmNvvDIv8oGih?=
 =?us-ascii?Q?FNyaiIw++jgG3hK3NUePBcxkiTk8EdcR1qFDtq34KHMein3YmY4d1Tkt3cxe?=
 =?us-ascii?Q?sTqE/RIKteQBGtghJMWPMdVJNhigEOfguA/fWBG/hLxaGHINlGYpxDcKsnDb?=
 =?us-ascii?Q?jrn2890+HhYr/7eJjKg90le/Jdq7nWqho+lR67gZCYGpiYYr9qlifWOey7L7?=
 =?us-ascii?Q?aIhE4T4sJq1gRGYrGt930OLZQ83fdVV5Nme51PzIn2e2b7kvjbc3RP8bjF+B?=
 =?us-ascii?Q?tF4i0MnHxTift7/NzA5wuQGMENq375CXO8YY4Jye4v4d+StlR8TibQl6nEV2?=
 =?us-ascii?Q?YG95A718C9xa8YDPRcdWzSBaj0kSGQuxJWRRKn81UkWWH+ZcTL2ozv2KELdQ?=
 =?us-ascii?Q?nyd5BxiV1FAAsJxYFuQ0hHVw1zp7aw+7tOhRpT42bAK2BB00lOxpzA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a9Muwi/Nc2VbLRs11Z0ff9/SH+KDaiXi0WKigCfWGA2uQ6tC7NDScLBh09lv?=
 =?us-ascii?Q?G/d0VX08HcQdM0i64OYeDDwibnKfNmZwNs7LpkiuKtiWfgB28OO8FTF49x0E?=
 =?us-ascii?Q?CXwCiknyxszaz0QpNpfGlftzWq56KtAuqhnqzODq24Ig7w28VeRbMpz1STVS?=
 =?us-ascii?Q?FMFldMI51p8Nk1+cLDhxbfZafVBBY/bsjDaeM2orNKiGjJN+fI4mWeL/2IY6?=
 =?us-ascii?Q?0Ic51Ti6TuQcGrtBvaTfhduuWyRYgiKcnwE9XWfJsm62uGDFIElQHgDEYz4P?=
 =?us-ascii?Q?/UF8TRDbmroTVDWNn9dK1C7gnVLar4GvB4WaptB2WQxCFTTxlxdCERfrbtYm?=
 =?us-ascii?Q?lCZ86r3t7JJ0WW1BlyG4JiTxIW9WB7xaXUN/32cXJaXjvmcflmVfuDe6EWGE?=
 =?us-ascii?Q?TVASw1GK1sq+wqSduVjP0ZW2jSHKfKoqft5ZpHjc6eH5jWEQfzBchQqDMZ7X?=
 =?us-ascii?Q?lXno91+GztbnjrAdu4mHQlcuw9BIiLnJmeYeylhsig+UoinWIN6byYVRJd8h?=
 =?us-ascii?Q?2Q5NoJVJM+DQNajVWN1dm9HTdZJ7N0DXbBFQHkY2gC8J4mStXBBbhx/G6zep?=
 =?us-ascii?Q?okPOOz3YdiZRQeqH2IfmNqbev4z1euv7Lhc6SDbw8TTkd5p/msBe+CJqBBvE?=
 =?us-ascii?Q?D/NgCbleM7ZoZ0Ci9h3vBIkM99gi4/jDwFnM4Xn6sz1Ewqf8LarWCCeYNg0t?=
 =?us-ascii?Q?K20G2DGyWZKwmzZHpUa7PhXkIYZktCFYoTZP5/943p3DnhuVUsbYDSzTdNRm?=
 =?us-ascii?Q?ylg6V+QepOV+AXykbJp/9vxkQ0cfPokgPlR3NPn4kVrr4CQp2XK/OVS2lbC0?=
 =?us-ascii?Q?04/dw0MyVOEI02xsnEFbTmtgKXUDtOxbFWyNu7jIJjqmtCeIFtuPgrshiFER?=
 =?us-ascii?Q?xCQU8PQCP3iDCDCsEZPCesLLeY5aXe7mVH1F9R1YlwcsaO4WuGqXBX65MG7k?=
 =?us-ascii?Q?oYkeCDoNMUlYeTpawe+4QxebByfaacpeKo9tSvGocXw2CskS+eQC+zwEZ6HT?=
 =?us-ascii?Q?GsIcraPM21yuDTnnlVCuRPVQjfe+ccxYWAm3w6nu3vPE5lWkbHTwx9KxO9sE?=
 =?us-ascii?Q?L+1NbwrRwnAdAkzRs2mdNFljKmQLAAFDaNfcSQ1k7M1EGngEJFF52p/nxtff?=
 =?us-ascii?Q?XXMYxLhZSLmLfiRdSFnpNyBYwGyKPhphc6lTt+WHRTg5Mv/6KJq2UgPsey9y?=
 =?us-ascii?Q?kR+M6h84Z+e1VWZW0DbgU8aUWzYYJcPDPxlpgQhE2bGE4LDDRAkFeuR5l4d9?=
 =?us-ascii?Q?vHgxFX1UxThzveARF/M7SWgXrRYXwsUOJC0Ptc/cc0FN9frnrO/ohs0CdTUr?=
 =?us-ascii?Q?FX26l/BlfBraqNhET5h1JjGv36TXf70RWuflbAAor+eS6HIxqlkKQy3OAath?=
 =?us-ascii?Q?5jAgr2qtyGZao5/cdYyBjY5BOBvdpZJZExG3/+ppG7TxzINsJGergQWgjCWq?=
 =?us-ascii?Q?MSYFQ6nkF7RuspsCeyX5txdhpuzdj0gCYRoSzS8YjU/adhYzD/ufFE5lTYbZ?=
 =?us-ascii?Q?4o0rB24rNHX/NrrCWnRme90W2eoIm15wlWeu4AKGGnjWUJRT4SbTgPMVru6M?=
 =?us-ascii?Q?SNe2v9Jj04z2QNIjUU1m9Cb/reysPebtpk7z0nXR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e92d8f-7a3d-485f-0127-08ddd45e3292
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 20:25:19.9848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c795sLw6tzjBeRBt+htRoESYKVV/l0NCzxPXCL0FsSN1Um4xSeNXp8Gu0AGql+XnNWg65WRvK1Ig6TQbmsZKVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10939

On Mon, Aug 04, 2025 at 04:14:50PM +0300, Laurentiu Palcu wrote:
> When runtime PM is used for clock providers that are part of a power
> domain, the power domain supply is cut off during runtime suspend. This
> causes all BLK CTL registers belonging to that power domain to reset. To
> prevent this, save the state of the registers before entering suspend
> and restore them on resume. Additionally, disable the APB clock during
> suspend to minimize power consumption.
>
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/clk/imx/clk-imx95-blk-ctl.c | 33 ++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/clk/imx/clk-imx95-blk-ctl.c b/drivers/clk/imx/clk-imx95-blk-ctl.c
> index c72debaf3a60b..56bed44719954 100644
> --- a/drivers/clk/imx/clk-imx95-blk-ctl.c
> +++ b/drivers/clk/imx/clk-imx95-blk-ctl.c
> @@ -453,15 +453,24 @@ static int imx95_bc_runtime_suspend(struct device *dev)
>  {
>  	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
>
> +	bc->clk_reg_restore = readl(bc->base + bc->pdata->clk_reg_offset);
>  	clk_disable_unprepare(bc->clk_apb);
> +
>  	return 0;
>  }
>
>  static int imx95_bc_runtime_resume(struct device *dev)
>  {
>  	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
> +	int ret;
>
> -	return clk_prepare_enable(bc->clk_apb);
> +	ret = clk_prepare_enable(bc->clk_apb);
> +	if (ret)
> +		return ret;
> +
> +	writel(bc->clk_reg_restore, bc->base + bc->pdata->clk_reg_offset);
> +
> +	return 0;
>  }
>  #endif
>
> @@ -469,17 +478,12 @@ static int imx95_bc_runtime_resume(struct device *dev)
>  static int imx95_bc_suspend(struct device *dev)
>  {
>  	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
> -	int ret;
>
> -	if (bc->pdata->rpm_enabled) {
> -		ret = pm_runtime_get_sync(bc->dev);
> -		if (ret < 0) {
> -			pm_runtime_put_noidle(bc->dev);
> -			return ret;
> -		}
> -	}
> +	if (pm_runtime_suspended(dev))
> +		return 0;
>
>  	bc->clk_reg_restore = readl(bc->base + bc->pdata->clk_reg_offset);
> +	clk_disable_unprepare(bc->clk_apb);
>
>  	return 0;
>  }
> @@ -487,11 +491,16 @@ static int imx95_bc_suspend(struct device *dev)
>  static int imx95_bc_resume(struct device *dev)
>  {
>  	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
> +	int ret;
>
> -	writel(bc->clk_reg_restore, bc->base + bc->pdata->clk_reg_offset);
> +	if (pm_runtime_suspended(dev))
> +		return 0;
>
> -	if (bc->pdata->rpm_enabled)
> -		pm_runtime_put(bc->dev);
> +	ret = clk_prepare_enable(bc->clk_apb);
> +	if (ret)
> +		return ret;
> +
> +	writel(bc->clk_reg_restore, bc->base + bc->pdata->clk_reg_offset);
>
>  	return 0;
>  }
> --
> 2.49.0
>


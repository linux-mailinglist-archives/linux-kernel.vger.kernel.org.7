Return-Path: <linux-kernel+bounces-853047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA9DBDA8A3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81A84503796
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F221C3016E7;
	Tue, 14 Oct 2025 15:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FudmFcn+"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013039.outbound.protection.outlook.com [40.107.162.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F342F90C4
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760457439; cv=fail; b=rLjAkbVgz7ZALD7korYF0IbTNp0AZGBx+HevA3mnZQN0iqj8TznnRzkYmKBa+0bpcTxpFCQfjMAiDG/TPviQaPdG4Jx3nLCIKm874L80hO4jLrD1ZOQxcF1DwHduKvPaIq6h31eUu4OxvlgPwjIcaKWjFsb5ag4ccUol4IJHhCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760457439; c=relaxed/simple;
	bh=E525WRH8U//WFTRxPTD6TL4ju3pHMGn+w5+nPQz4680=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EkED4E1EN1Qmu5DCyqwfCWAxMYkvDBAz/5gHx4XGLA4PqVVlte7/6RI32xjJ68oEofOOs0le9n83MXSkD5M+bIsrKUj4CkQomW1x9K7GoLfFeTc7jmfyFQ4pirPrjT62BCnQOF8qhVV5hk7pkgLlTBjK8hrX0+uDWhgUCRjz+Fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FudmFcn+; arc=fail smtp.client-ip=40.107.162.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYOsRFj6BUdVDsQ188cuzC+q9h4VpVTeC5X+ZU+pFWIF5+dHxU9S4QPY4ENgkw7kCsJ4F/2l4VZR8tbEVod0/eCF+vFlBlFAwo0lZy22ZqwBr315l3Ac3CXn977tNUQ9KJYap4uXDKKChjpxMceaRiimrv+LN/ps4ubrQN2gMJPFnDdVLpvW3VbHAUVY9pWC7gTHONAAhIhMC0dAcWaiBRxfcgFa5K+xNnfzo6qVYahVVSD3gynwYUbBiuEDtIq1qaBLYe1mT/wH/WaajeR58BLfzE8b1kTA05nughULiNLQ5FGtykGQmGFh5zdW964KNa0p9qEZ6iSqEYTl8WAnZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3OU1dyQcyiJwoq6/zGCi0O1DyNUFl+1+vr3Pn0yTVE=;
 b=wOQaatFrts4RNFwExmjGpovWDO7n0xyvyAftRyI0Pnk9xJPx7162xGrdPuuvJ/y8Xqao9gvGZoKXYcKtgzPjYqHTxQoMQ5oVFLtQZ+RATn/y+s2cKLDceaCvX/prESrUJPh+ZAzSOFAFbGiB6c+34sbsz0b3Tur8pjMVSJTgd7XnJokRNSV1epyaxhjXKeYEABUd9mn48w6KiycVKhNZ09EWYWM2LjPcSY/99/9kGxLlJaArQOX0ExDQ/lgWhMKynRmuhuTSUfiKPHBnV6MWOWb3qz3Y3vNm/ge6JcF5PnR4k0Lk0ZX0ewSsSbXlp9g09TWn4HlfV/e+uAHn0dr0Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3OU1dyQcyiJwoq6/zGCi0O1DyNUFl+1+vr3Pn0yTVE=;
 b=FudmFcn+ufsqSnJ9B8p5HRdpLAmc2hqcoPy6hs/bpRf0rXHUO1TWb281mCI/Sab04KxFjmUaAWoNqmdkET8z3HAhAvcX9l3CF/2RTi1hbe8j1fH3WnNR1gVa+XnlU8TfXcqdXSLIo6qfqnwmny7n/lPEEeeEiipDf8gRWMwwXuOAu+IYTBp8X3fjW94eXrXruHzhMmPqCjWQlSKZfKPA87sOHyw9K4kLlJgJPvyIcQ/iJpamnJDDGid6ZuJS2RGhPnOPrKhE98fqbnCzK/eOLh0P28BTkmkCZErpzD+qZ/PH91SW/C4ZzFJM8VXEKFcQf+7bjUEYHTgHjj20Vz0hig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM8PR04MB7266.eurprd04.prod.outlook.com (2603:10a6:20b:1d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 15:57:14 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 15:57:14 +0000
Date: Tue, 14 Oct 2025 11:57:08 -0400
From: Frank Li <Frank.li@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dong Aisheng <aisheng.dong@nxp.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] firmware: imx: scu-irq: Set mu_resource_id before
 get handle
Message-ID: <aO5y1MEaRek/V9iG@lizhi-Precision-Tower-5810>
References: <20251014-imx-firmware-v1-0-ba00220613ca@nxp.com>
 <20251014-imx-firmware-v1-4-ba00220613ca@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-imx-firmware-v1-4-ba00220613ca@nxp.com>
X-ClientProxiedBy: PH0P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::15) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM8PR04MB7266:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ce9e372-7ed0-412e-d066-08de0b3a57da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?svPZ3n6a/LnX+pdeciYwEOsJ4zw+brud91KPPuZ18iZteAM4S7GQxQBBj/R0?=
 =?us-ascii?Q?bBe+EeXn9K1cN3sNop+qt0uCiWOhGH27Z11b4MtTZzru/Gc+UorLry58dfDt?=
 =?us-ascii?Q?gXEKzvV+RUv2boegTZq7IdF/oBT8G22HZuYM2xBkpHVt16Qw6gWdaaWZNwqa?=
 =?us-ascii?Q?lqBMLTVfe/E/Sv/gtLyElorIHnTMnIW7vry3+Q1WXxa2wafynMdujPBxPnT7?=
 =?us-ascii?Q?mjpu/+a14xygRthcQgjOxbaRk3yci0+sWbMdNBpmTmq66//hVenmHuEDjCdX?=
 =?us-ascii?Q?ddOis32iioX0dkCG7HO4PG2ECUk27J9JjBDoRZ4k46Pw4+zA/RNZYQ22gLNZ?=
 =?us-ascii?Q?W8B6zh2q+hPkba+TCESDvULDLZjrkSFbBV53rlBPXYdFgU6sEu+Qvjnij4kY?=
 =?us-ascii?Q?BCk1wzsiXwzqyBxk9aWWuOj5K/zQ9ahlkXHGc9pxKA0DRoVVQSdhh+/3eCnk?=
 =?us-ascii?Q?YuOQ8CF1EriDzZdYRs8ZeVCJb88YUmiSbgIFCzPtIiJWmQohBu3UqOmxGi5n?=
 =?us-ascii?Q?rCeEnYTDtM/BtGmnh6AYoWdsEygcEYqkupq76R+swYjAnkzC4LnLLJvQC7Te?=
 =?us-ascii?Q?KAjUU1AloS+c/OOR+7qEegqlIAIHU9UdHoMLc4hJ190r4x7UgW5N7u/mEKFw?=
 =?us-ascii?Q?5rTyTyKvn6z9L5hGdk9UQbw/3DPJGwbKWBbzxJeDw8TjYglhGUrwjRsfYv8z?=
 =?us-ascii?Q?FVLyGHFuo6ZRNd8vbs7RTVkauI6Ae5SmGqN2QurSRnhEGBUfwWS5giG63kyP?=
 =?us-ascii?Q?pDJ9yuR2D96h5SwPLtPq+1lHSTA9odwQlZC3DTXLx5Z6wS4UegaOK57Fz6O7?=
 =?us-ascii?Q?Mc+xhWaUBohuMHG4Gv/DxfNWwJ7kyxpVL0OksjSIAfKO8ioacjp3CuQkq9cC?=
 =?us-ascii?Q?XA4cg25hAxB3prjjNNDEh1PvSD3oJjHIkXQdJB4U2yKA/A4/pnDBxlt16KCv?=
 =?us-ascii?Q?Z1ua2SpSS1PbvbDlYYIiAY64TTocNoaEbP9rzjJVVUf6tn+qTEPWZCqLLAP0?=
 =?us-ascii?Q?gcDFcNXZvFGDSqQYwdd14Q9K9fT2SjJvNycC6CVYHkax1+9/I3NKAK1H09t6?=
 =?us-ascii?Q?OU1NBsLgFs+s5FQ3gWNOq7DvnbKfMhEPEHQOLkxR5Y87lf6DD4O/o6A8izHU?=
 =?us-ascii?Q?amdbFvR8aERrq2fTiKae2mOy0RjKjSNg6q6NdMqttGEub+7VTjUH0ZPMjrKU?=
 =?us-ascii?Q?VcRVOk2dusPeJ2TjDP2f49NjdiUw3n7jQ9j5p3gGA8eBdHJd5sX9mjEeHSJk?=
 =?us-ascii?Q?Z4tM/OaB7SusHHQUw94pz1YbDI88xCEdDihwZb9MLX8FUlqfnQm1bJyq/ea1?=
 =?us-ascii?Q?bDWPT7sBM10dxSYiXOomC7LvpPOsoJNpGMtgHlui66j59V8DmDh/g432AC/J?=
 =?us-ascii?Q?j9ZsAXn903gXywnXzii89GGroyPjzNZDrT0CkRNsv5ofA0LMPrRWiOYw/eGK?=
 =?us-ascii?Q?IZYRUmTKs9pDMKHta3Jc5yiW7lvHCL5ZaRdnHBYds17tv1ZWBw3Vp3Va0DM3?=
 =?us-ascii?Q?dKudY9GFOP90djM0lXginWhhy4uWGHPvlPSV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HJJtaAuHW0Gr8hOxcF6B84WUJzClmHlkpTEBaTNukPqqkZTnUa+DYFs9NnQG?=
 =?us-ascii?Q?d2yjo9X1fnMmhDgFzIOwlDEIrEkbMQaD4epIzXO4fnsQmZlkkhQXBsqehgyM?=
 =?us-ascii?Q?5iroQbonWXoqVeTc6fZAASOBH6GSVL7YLxJFqoDliUhipjG9RXzslrGbGtkc?=
 =?us-ascii?Q?9eeDck2bGaA/LbJYjvpbsak/JNdHZzGadWIzyQwNrGmxsJnelzhT1vhB0YHN?=
 =?us-ascii?Q?MwqTkHBwXTJd9JvLvomPoYbJt8eTnD9fNAcyVUu/IEyRYbMT1YYcxojCH4iL?=
 =?us-ascii?Q?gv5Enivz3ka9sHcXnA1Ki4hoSF4RIjMjzlK/XS9OQsKxHxx4RjVyp/aQP1Kx?=
 =?us-ascii?Q?lNcy7T2YAop/raCsKmfANpcDdOv9ImMArz3Mgdb0J0zcUPzPqEoNTAg12Y7Y?=
 =?us-ascii?Q?YbXMKFt4bgkqsCp8l9XdSBVs8tmFo4Y6BF8UqGnn0SM3h6XN3w+lsY5Tx4w+?=
 =?us-ascii?Q?34M6jGcYJImiPj0x3pvXC1by8Cpz9mI8M9aqPHy8PkmlrlL62ZP2Ux2UL3C3?=
 =?us-ascii?Q?eEWbTGnz0e1KxnD1H/xxSEzIs1daAbZ5RxNGjpWTsOUoYMzwV8oh2FTPjhwT?=
 =?us-ascii?Q?HQQWlnswKK3TB5WRYgPOZoyUIHprV5lwWi+7wmxkGXH+tUmwARHrYgGg+eYh?=
 =?us-ascii?Q?5enySW8dZvJMleK2V8mgaMPV0jtsPRJiw2KuOg8u3N84tlkeCh72eFEqKb46?=
 =?us-ascii?Q?QAC1Yt8plGxipSqJF1Hr7Bt8cn6RGobeDJpbCORiyOjDgom7wn/3nE1rKnbk?=
 =?us-ascii?Q?QKPKraxiuXuqyaJsJwqdEuDlehBvINGyyQXhBgUzdhxUnsJL2Rmlnr62vzYK?=
 =?us-ascii?Q?qQ/hu+j0NX3P/27zPGijF70gopTMVu7/MGUIxyrPlTHGY9zBTFTFvjODvBuS?=
 =?us-ascii?Q?6szS9dz8OSC/7Tu/Q4L+ZLp4k3C7F7wabUw1CK3WAwztkwI5jxejN29bgzrw?=
 =?us-ascii?Q?vGbUurrFtJL7e6N/DA7wAH1KsWEz4pLF78I/k8pMnFaiItP6WEZORsWMjrFj?=
 =?us-ascii?Q?AMFhqxT4hPFcIfHtDnT+xLczk7XYaQLB+W31Jy3EcASM12AOcxJV+oA2PlEI?=
 =?us-ascii?Q?AiqmREJPg6bPDSECKvaUjES8o+OX4/Q36DMRarub8oqq/eDuzcBTSfjo5pm1?=
 =?us-ascii?Q?TQ7m9M1u/fAu3FSxXTbNt3VOqomYX0T9P211Wx2g6Y6PS8vkCI7kBHCa0roE?=
 =?us-ascii?Q?cZ+wwUcaQtYcnzK6khez7Pt+djFVS1xZZ47pgeZ+inGTTW8d6ZTfGfJTFRhG?=
 =?us-ascii?Q?kosaueewZq6LMm9bDHKfjqIFoKddYvDBVDVKHa3BSfHYP31Id7O+8Bm4CLFh?=
 =?us-ascii?Q?H8/QLq8jw+RnNCo/+RH7T240UcCzSlMtvfUETLhKUrwBayoXyKNOzrYu7Usy?=
 =?us-ascii?Q?OwBk6Cwp4xjfW15G001Z9qMeCApZqaf8yWBgXaEdWjB2wjX0IQuIjKClbTbI?=
 =?us-ascii?Q?cPK23mR6xXB3swWOPHAYoPHEYAIZZ6yoCMf/wa3yJDHV55lXKMVXxw9LtiAd?=
 =?us-ascii?Q?/ycwq4LNn0VUJY6HqefkEzAPY2yvbfLejmBQuAEsigJfyq7ru7SFOpvEXVTF?=
 =?us-ascii?Q?prqn6VuWpfXYII75Hso21HEqoh0qDAqGBMv6c2D6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce9e372-7ed0-412e-d066-08de0b3a57da
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 15:57:14.4115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jXzRD+IQ6tNeGU+4Tr5Lbe3wpkVumXvPIogH35ppF/MAqfKJqu3AqEmH5/FgI5rq2ksrnjN9jOJCFo6TKVx8+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7266

On Tue, Oct 14, 2025 at 12:54:41PM +0800, Peng Fan wrote:
> mu_resource_id is referenced in imx_scu_irq_get_status() and
> imx_scu_irq_group_enable() which could be used by other modules, so
> need to set correct value before using imx_sc_irq_ipc_handle in
> SCU API call.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/firmware/imx/imx-scu-irq.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
> index a53ed2040c0cf7065474d681b2eb933a15877380..1346b75596293892ccd90a856d46f52171d88734 100644
> --- a/drivers/firmware/imx/imx-scu-irq.c
> +++ b/drivers/firmware/imx/imx-scu-irq.c
> @@ -203,6 +203,18 @@ int imx_scu_enable_general_irq_channel(struct device *dev)
>  	struct mbox_chan *ch;
>  	int ret = 0, i = 0;
>
> +	if (!of_parse_phandle_with_args(dev->of_node, "mboxes",
> +				       "#mbox-cells", 0, &spec)) {
> +		i = of_alias_get_id(spec.np, "mu");
> +		of_node_put(spec.np);
> +	}
> +
> +	/* use mu1 as general mu irq channel if failed */
> +	if (i < 0)
> +		i = 1;
> +
> +	mu_resource_id = IMX_SC_R_MU_0A + i;
> +
>  	ret = imx_scu_get_handle(&imx_sc_irq_ipc_handle);
>  	if (ret)
>  		return ret;
> @@ -225,18 +237,6 @@ int imx_scu_enable_general_irq_channel(struct device *dev)
>  		return ret;
>  	}
>
> -	if (!of_parse_phandle_with_args(dev->of_node, "mboxes",
> -				       "#mbox-cells", 0, &spec)) {
> -		i = of_alias_get_id(spec.np, "mu");
> -		of_node_put(spec.np);
> -	}
> -
> -	/* use mu1 as general mu irq channel if failed */
> -	if (i < 0)
> -		i = 1;
> -
> -	mu_resource_id = IMX_SC_R_MU_0A + i;
> -
>  	/* Create directory under /sysfs/firmware */
>  	wakeup_obj = kobject_create_and_add("scu_wakeup_source", firmware_kobj);
>  	if (!wakeup_obj) {
>
> --
> 2.37.1
>


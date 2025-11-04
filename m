Return-Path: <linux-kernel+bounces-885171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CE7C322B1
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ECEBA34AD88
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECDD337B9D;
	Tue,  4 Nov 2025 16:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="l+AxJxYH"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013014.outbound.protection.outlook.com [52.101.72.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399AD337BA4;
	Tue,  4 Nov 2025 16:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275409; cv=fail; b=t+sttdjuUnSH2gOVEFseSWjFvYUKAI82rWa12+t3RvZpvqTMK8olCZfk+nUnvVzy6nqqlan06fc+s2PSB5YcnQG6CnUqdJblJuUCstqu/MiHARVjiahBL/LeO4Hiqrk/VQq1jn3LgBqM9OaDb7VM7IX7yAyQDWjdf0RPX/69Fno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275409; c=relaxed/simple;
	bh=kuGHbYD8NF2cpMctNHCPkzqWCb3bRJ+/z1nM1v3F3JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f+lMoKZVSrn0/LE6EI4Qes6mO+T/AwcFfewIJbDNoFRRhwIN8aXOkIjEIZ48kdg0p1/oLcoaV+VcQ1cOmr0bdrThnbYlVPbBRzRLpkrQPlcyhaLu3SvLYXD85s0HcMXqYIyVJGbt5DiyRzxRehGWr4wlwNqdXUiNN3WST6/AnB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=l+AxJxYH; arc=fail smtp.client-ip=52.101.72.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jWlrJl1tgF9oDQFgO5Sq+JxwOp3Mji6z4xu6V4Yj4QyFRtNv15OZ3HqmXjmKV4ZzEbNBLkIoDvAXAA+xJErXtlO236hosQzlRLo8pkQ7dhwsA2WwvfK3JjjS0fd3XuYpzU8ebjlqBCgVliZNzW3e2XsF25M6YAL2kfLqKg6WrTTK6enE/xlOH0PjoJA/S6ae702DUa6OC0HgwCSipOGlukXt0GNd090nB7TkQ/N8hzwxazGWgY9NsNSu9ibYqhL9yU1z30f01Ok4T8d7aANvq00lmZ00LK0g7SAGCk5/1rVFdXKM3+bYgvDnD09ijcygw+Nq4ACnyBzAvA+SUlUL4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57WWz5SjlvNCwVzjvHZK51P97K4LcVGbsvVLPzQ9D9k=;
 b=x9mMMxWiDraLeNDWKKd7E5P6hZe8euxK847li8qN5Tf/KrKYsvhWOubNUeSND3t8p0cz1ScqQjV/CSbGezCs92HbW3/eD58oBfk3ln8sSkkLjJOagcfHBAk4VIuNjWcz05u4r+eHnSsg6bfwCQdSrKOWtFauHeqWLk7Dx5JDX5Zsete6HtG/Y6s2T/5RwcC2/7SIimHYiVIvhJtfugP/l2qUIKNVA9V6NS0irID5eFiDISA45zO7K0vb/ZasOzxd7uWZjDB36XUawSm8PIkymr6RCB4q38QjExDeVTTc/L3kkgE776xmWaRYu0k2cTijvgO65zscfUVr2LDwVY3wJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57WWz5SjlvNCwVzjvHZK51P97K4LcVGbsvVLPzQ9D9k=;
 b=l+AxJxYHZMpHZOGqklQTYVvnZpOGTSAsnTD4j+7iJO9K7yXsMpYTYHJC4nDCn17wcUnDoEuoHsTmyZRf21gFLy9yZF040EjjyH4cqV/Hh5UTdIUFDt+UuMdt5g73q49Y7ItvY1OdwvkpITAlJ016S5yo5yTovO2ocUIEJ5E89aRgXtwpT9JWtNrip7fU1s7EmWwgca2Q2G9AhTo8Q8PsGhI+sWoYnIgewOYES2nGCA7rWx54aYVLOm48jErRikQz2G8jeoahUIBxEA+AFLLLs6TSg5bYAWslxmywWNjLrz3wZNfZ3SFqKXh82h5cWYFc2XXSj2Xs70vkSFEAcwIEHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PA1PR04MB11059.eurprd04.prod.outlook.com (2603:10a6:102:485::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 16:56:44 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 16:56:44 +0000
Date: Tue, 4 Nov 2025 11:56:37 -0500
From: Frank Li <Frank.li@nxp.com>
To: adrianhoyin.ng@altera.com
Cc: alexandre.belloni@bootlin.com, wsa+renesas@sang-engineering.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	dinguyen@kernel.org, linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] i3c: dw: Disable runtime PM on Agilex5 to avoid
 bus hang on IBI
Message-ID: <aQowRfxaH3bdqPXP@lizhi-Precision-Tower-5810>
References: <cover.1762237922.git.adrianhoyin.ng@altera.com>
 <482d540722a98c2809d8275445aaa544b565bf85.1762237922.git.adrianhoyin.ng@altera.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <482d540722a98c2809d8275445aaa544b565bf85.1762237922.git.adrianhoyin.ng@altera.com>
X-ClientProxiedBy: PH8PR07CA0041.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::29) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PA1PR04MB11059:EE_
X-MS-Office365-Filtering-Correlation-Id: 9477573e-8c3b-41ee-cb58-08de1bc3222f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|7416014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wl97AC7I3FsNn6uVxUBm26NcU+eaVu8rGN5Ac3IbKrSd0eVKi7kyytu6MbdE?=
 =?us-ascii?Q?rfvRNPU5CvkS7VLNMHgnvVbckFIac20XHOFLk+gRMuD7n1i06HjmSjcSV2Vw?=
 =?us-ascii?Q?4kJiU0F7mzWbpFV2ZWdwKs6SbMfyk7T2K5Nvmt11zScuyV8tefktyRz9BpZa?=
 =?us-ascii?Q?Et3o8aoFSH4YMkOLjOz25AOZ7OkH9dzfaeDWVjgmlO1u2zlQygBrnT3gg2TD?=
 =?us-ascii?Q?P5TEgPI1Bg0Ksc5rQbQVPtDdHPAKeEERc+UGGUs49Kp1kQl8prUYXlZfl/a8?=
 =?us-ascii?Q?y+kVbG/nJvqQ35Q9ILVDuQ5hw5qBUvS1u417TD2tAHzzSyfGwyc9t/L4WCfB?=
 =?us-ascii?Q?Bq3jL7hEMP4CUCWCPjC4FQ/rfeogm9kX0nonGqwvvdLiBjA8LmY8Wcz+mzGM?=
 =?us-ascii?Q?DITcNh4++aRSJa3b9q/o3JwMz+58F2GWooFrav9h3b+hyneAinhnjo13CuOT?=
 =?us-ascii?Q?Y0GkQDjIBFNbzTph4JYtPuWg7XTSHop7oJRp9viN1fw8ahiABby7uw3/OIw3?=
 =?us-ascii?Q?DaFR2YY+Qv95IsZ28+c2JhcNmFiL7MkytXR1qE02QrZAijdc+ezPLoCMrok7?=
 =?us-ascii?Q?mLLc0cTrPusUvoSWj2WPqTzZjX4Saxuy7wCIZi1drBi5/aQFS1gaQ/ui482u?=
 =?us-ascii?Q?ovI5DGKnPMvCwN8l2AwrLXuBCw1pk27oQUCmr5WLCmymuEXTLkuh/67xgnrH?=
 =?us-ascii?Q?8Bige6aswJZ+7nJfD8DdiYx1SArSjm7kW3xbA2JsFyPaRsBbmdk3WGEPov2e?=
 =?us-ascii?Q?jPpOeO8hujtcBRqsymW7foiYozco1jkx8319x+mq0f/twOlaZCoARPdifXFp?=
 =?us-ascii?Q?zhHonk2OCbBr6DwB8d1WuCXChCIwwAemHcJYtpNCUK6umxi+6dIieZj1gFM4?=
 =?us-ascii?Q?huoUcRjKltLhnnIHCb8kJvYUEf2TYPnj/Bh31jQIKd/Hp1UdBYuA9bLQTT1D?=
 =?us-ascii?Q?ZUD/XRo/rpyEy/1zW+fn6unZKFCXCvYu8JiSLllSTyI97K/DccA3FRR0C7TX?=
 =?us-ascii?Q?wlw2lo9spjI6dHefnqVOHsAQFiWBWbllznGAxjCNQcq4bqWM9zpH0GpRQ6Ke?=
 =?us-ascii?Q?dJOaoe1dwvm054ySyWhGIEPLhqdunAZb/3z9HiPiDMc/9w//+ztdNsskgWFP?=
 =?us-ascii?Q?2iTw/YDDXnfROBkm1ZqfYK9HML9koHYfgXBhgBZGD6Zd3uC/btU3FOwbCDJr?=
 =?us-ascii?Q?Uovgech+4F5npngi00vhAxlA3EiyPAjG9/LErlVHsPHyFPTg7NAQjnI36PPK?=
 =?us-ascii?Q?hRQs7W1WOFq80KFTORSbK4drJYml7uwNaDQkfQSkFHjiXbilCGwqoykCksh7?=
 =?us-ascii?Q?58ixtbX03afTpyKFgfYuHDM3NPc3h27RD5s/u4q4c9EUM/uYjxEBNlKK+nTO?=
 =?us-ascii?Q?yCi0+PWcC1gX92SrBY49ukOo4W48RYpHCAcaw7Y1O3+QKcM5XO5/QuzF7H+N?=
 =?us-ascii?Q?c1OiSYMiotbwSaPhmE7tUtdYKPCpFCh8jsjmV1f+5T9wkx76ny9ORTtuvbfl?=
 =?us-ascii?Q?1OfoavbR3XgsUtZuy9Q7ehudiZQQuRPfHe1/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(7416014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?88bzoHcFeSKmq2iAU8OTnM9YtTE8WpuzLnwzTqMTW64FZ45ikr2oa2s0D2kl?=
 =?us-ascii?Q?WEVZCfNjWvKOybT9MKACo/wq7WhOQqCk+Q0Mabpej39+7kRRSQofG7C5sSfJ?=
 =?us-ascii?Q?UgKvvzybwjlPB9YIe1sq3LPIFBGVGCK7Y3NB1ciWDv+IxI1u66hFb40t/ufw?=
 =?us-ascii?Q?NsO1CiLARr1zShfmF7Oi41xPUIaVfsdk1Uc/lcxL24RAqFKDruMSc31/nsw5?=
 =?us-ascii?Q?oUtaALiAyVAxx8WbdWrKWVFe3cQmShaz9b8Au5FLSFXHF/qa2Ht0BapmNHcI?=
 =?us-ascii?Q?XbQB1Leu0oqB9I+VupQWhua18My3r3ZvtrTzrZD2LVk+7obGaxYAtDJwzQbf?=
 =?us-ascii?Q?Vc4NioQNyAm4Ylfr3ybnJ8Sf4Yss5wIIrvwcagNa4wCQsSc/zQl5CiZLwLXM?=
 =?us-ascii?Q?tSi8s0PkoX3JlJROvqhgZ/7cBEYAwdLbH3yBNjN5jo8CPAZOPyenpSLTzFGE?=
 =?us-ascii?Q?DCeU7ScVaLD0U2ybjzcpDSDkJeeoFMrAht6AWyyGj6TUUhDvHjvkWxGYmWIE?=
 =?us-ascii?Q?VEx/B4GQXJS8TB0KYbsDCshrdHCl/yIpN8XyXuNLx+3O2/ai1MuuVzahrtSd?=
 =?us-ascii?Q?EniPvX4zLap4jvK/2P92+93cbancfcZTxbDoiLt08E9i+BwtPmkXyltgXWB8?=
 =?us-ascii?Q?zWNy4fEqCFUzrw5tnRAJ9AwCg9bH7JQgxo3DLId4pDDWTCIY3vIoYT8W4nIb?=
 =?us-ascii?Q?WWkNAvkiDE4EmZ09sjFssixGwVUvWmdddw0K/O7mOS6SvNOrIy/QP4BN6itf?=
 =?us-ascii?Q?L6/soHsnHfaGj0BiAhjK72+/ECehhlW8ImiPS71cnShM9toJzMmBZJajNlNb?=
 =?us-ascii?Q?WVb7WKy/RMHcbi6l66DwHB9/Rrec57RJi0e6JD85ggHuwXrJMgChP8nIsa03?=
 =?us-ascii?Q?FLI/WZi5ASBATa8qmr/lJE0ZwmLFmkzA2tA+0pr7vmO7s6PR/yTgNP/qb+aa?=
 =?us-ascii?Q?zHGv1AisaMiqtDUvbpO1aT7iLwMN3JUzPnbpzl5ZRQhEjOb0Gi1A7obIA1ef?=
 =?us-ascii?Q?tVTZDtgSG5euQIZmmmuhSbxz6A4SuLMDOwR8UY10DynsZ+e/pFR8E5nwiCl+?=
 =?us-ascii?Q?M0OsIMeF/kakeGi5BIaw3K6fvu0gDPKLvs/cEHqteSENc+oJCa8hgw36rz0c?=
 =?us-ascii?Q?lWQ1NxAunJ4dJDb3luBVd6Z9x/j7eTFT0jBFt3NWpLeYeols5eRszeiVrZPR?=
 =?us-ascii?Q?vdVC6WAKNkIWbMSQDoNzoWOSCemnj3b9uhESuyh6WPrj4KaKYqx8dWevZ5eP?=
 =?us-ascii?Q?e/atw7v142FmNepV3a2vk8KaXERwQb1d3EsUM7z3EpfNHZjoXXV+lQ+Mjqrl?=
 =?us-ascii?Q?xusCvLY/usbg5BiOPBLQzEUhnZkBo2khorVszzwivDahqlDB1SAekK4dClVR?=
 =?us-ascii?Q?oq4xeY/KzYDwE7sNoSc1SBldYa2Msbej5FYtKWeDjvqKM6Joiv1gZZbTIpRN?=
 =?us-ascii?Q?hQZlWm84qo+M3KRrYRr3BtxKp7HAPS6/ITiXi2jrAGaxTtquEanb2kGhSuZR?=
 =?us-ascii?Q?pjVe4lA7/xgZKOVY3JBX1pDf5+wFWwiqBJg0chWei8sg29K6l9LrwKzk50q5?=
 =?us-ascii?Q?5xhvFeRC62yEfgsYSb8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9477573e-8c3b-41ee-cb58-08de1bc3222f
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 16:56:44.0497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AtfLZ5hWGJpiFx1D2388kfOgDR0faqj5aF62qhQXIHXoqF6uc3nqOAiKmCxMbTWrdfXncwvI04LAGkcPxQyxxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11059

On Tue, Nov 04, 2025 at 03:29:08PM +0800, adrianhoyin.ng@altera.com wrote:
> From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
>
> When running compliance tests on the Altera Agilex5 SoCFPGA platform,
> the I3C bus can hang when a slave issues an IBI after the DAA process
> completes. The DesignWare I3C master enters runtime suspend once DAA
> finishes and stops driving SCL, preventing the IBI transfer from
> completing and leaving SDA stuck low.
>
> Add a new compatible string, "altr,agilex5-dw-i3c-master" and apply a quirk
> that keep runtime PM always active on this platform by calling
> pm_runtime_get_noresume() during probe.
>
> Prevent bus hangs triggered by IBIs on Agilex5 while maintaining keep the
> same behavior on other platforms.
>
> Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

 ---
>  drivers/i3c/master/dw-i3c-master.c | 31 +++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
> index 9ceedf09c3b6..276592a8222e 100644
> --- a/drivers/i3c/master/dw-i3c-master.c
> +++ b/drivers/i3c/master/dw-i3c-master.c
> @@ -228,6 +228,7 @@
>
>  /* List of quirks */
>  #define AMD_I3C_OD_PP_TIMING		BIT(1)
> +#define DW_I3C_DISABLE_RUNTIME_PM_QUIRK	BIT(2)
>
>  struct dw_i3c_cmd {
>  	u32 cmd_lo;
> @@ -252,6 +253,10 @@ struct dw_i3c_i2c_dev_data {
>  	struct i3c_generic_ibi_pool *ibi_pool;
>  };
>
> +struct dw_i3c_drvdata {
> +	u32 flags;
> +};
> +
>  static bool dw_i3c_master_supports_ccc_cmd(struct i3c_master_controller *m,
>  					   const struct i3c_ccc_cmd *cmd)
>  {
> @@ -1535,6 +1540,8 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
>  			struct platform_device *pdev)
>  {
>  	int ret, irq;
> +	const struct dw_i3c_drvdata *drvdata;
> +	unsigned long quirks = 0;
>
>  	if (!master->platform_ops)
>  		master->platform_ops = &dw_i3c_platform_ops_default;
> @@ -1590,7 +1597,18 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
>  	master->maxdevs = ret >> 16;
>  	master->free_pos = GENMASK(master->maxdevs - 1, 0);
>
> -	master->quirks = (unsigned long)device_get_match_data(&pdev->dev);
> +	if (has_acpi_companion(&pdev->dev)) {
> +		quirks = (unsigned long)device_get_match_data(&pdev->dev);
> +	} else if (pdev->dev.of_node) {
> +		drvdata = device_get_match_data(&pdev->dev);
> +		if (drvdata)
> +			quirks = drvdata->flags;
> +	}
> +	master->quirks = quirks;
> +
> +	/* Keep controller enabled by preventing runtime suspend */
> +	if (master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)
> +		pm_runtime_get_noresume(&pdev->dev);
>
>  	INIT_WORK(&master->hj_work, dw_i3c_hj_work);
>  	ret = i3c_master_register(&master->base, &pdev->dev,
> @@ -1617,6 +1635,10 @@ void dw_i3c_common_remove(struct dw_i3c_master *master)
>  	cancel_work_sync(&master->hj_work);
>  	i3c_master_unregister(&master->base);
>
> +	/* Balance pm_runtime_get_noresume() from probe() */
> +	if (master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)
> +		pm_runtime_put_noidle(master->dev);
> +
>  	pm_runtime_disable(master->dev);
>  	pm_runtime_set_suspended(master->dev);
>  	pm_runtime_dont_use_autosuspend(master->dev);
> @@ -1759,8 +1781,15 @@ static void dw_i3c_shutdown(struct platform_device *pdev)
>  	pm_runtime_put_autosuspend(master->dev);
>  }
>
> +static const struct dw_i3c_drvdata altr_agilex5_drvdata = {
> +	.flags = DW_I3C_DISABLE_RUNTIME_PM_QUIRK,
> +};
> +
>  static const struct of_device_id dw_i3c_master_of_match[] = {
>  	{ .compatible = "snps,dw-i3c-master-1.00a", },
> +	{ .compatible = "altr,agilex5-dw-i3c-master",
> +	  .data = &altr_agilex5_drvdata,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, dw_i3c_master_of_match);
> --
> 2.49.GIT
>


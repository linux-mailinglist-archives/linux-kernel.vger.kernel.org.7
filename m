Return-Path: <linux-kernel+bounces-854676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ACCBDF14A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 49737344640
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E634829993E;
	Wed, 15 Oct 2025 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c66OVYo8"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011051.outbound.protection.outlook.com [52.101.70.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1619317DFE7
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760538767; cv=fail; b=g/Cl/mbgvWHmyESxQYZpbe2uRfzBvSwGRfKbxu4x8BezL9cSmOKk5Hfopp+KcMInyk40QLbHw7B282tLNj9kcUSELXcKgLhKoZZlwnTV1KZ0LbpQUqN8xbcUFsOU0qz1D11MQkm+Oczk5WC2GbeJX8pLAGqvZ9pXJdAgTGpUGnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760538767; c=relaxed/simple;
	bh=XKTEEZZi4nNZXQbvqCrF3Qm4/siFdv1I9Vf0bC9TKos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WadvYxuEJ++2i8Ih03tQOFy+eqnwGb2Cc1ZbTGYLWU8mEsQZMMZ5S24XBrmPOtW9MNFKGIqWtIuzNDmPOSKtKqhB4ldfXuQFL6jpao8qDftfYCZUcsspAmGyt/2WYVAP6Bi4HsFAz71SO4+qF0AyPERjf3lJWHsuVAeQFA843nQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c66OVYo8; arc=fail smtp.client-ip=52.101.70.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ELb/CRj4d5GsFQ2qNhT460Ho9SUBuJ6rK8xmQbo+9v6TH48rI6il1NjXrk1xCGSDlcXU1FfABxGv6zz7MxzlnI8SQoFr4xlBv9tX9XOUUm+XuTGMfJCnwFOFbNH8MXy6F/t4r0y3aroQiCajxq/RqWhnKwiGY6s1CwnSt2EMwv/nNQJQ/ZDwgBbAsu56HJCtkBEmcjg77sy7rYuZaVdJDFMIqzzlqFi1R2qIEQXU122R7rd4Xmu09r9/B3N8qBK8sQQEcfU2qnbMhw+kI9Tfpxll5+/dSUuVV9aLnoAET54PWJs49vbNscw/owtUYidMoAvxlQ3Jk9N4U8ybP48Whg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pxwtB6d/rdb3F+vj63wWrgz4TY3fYYr6c3UAzOgYk6g=;
 b=fLVsoM5CcVY/b0Aa0xyxURlN7t2V7JOGtKFZ3oUvzrab4e8b/cYVw8uq+mGmyoIygt2QYQ3xhv/jd9nqxZykMnrsOyr8f3P9w4jhoR8vPvJmyoZjRjIBBr4YOAiRXxlLQ8eRskCQ03HcaPH4qls8m03Bc0S6W7FfBG+c77UreE2qvXQmJonSAXS8eiMv4YiOE1igTKzZHTQXBk/Xy4AorZhN989K3aCqeZyaKx57swOGgBW1U8vfbwwMICntYRlliT8qmGjee1qUyasnmT8/3QAhwMlrwMfwdQag5ggio2UOv4PwvjmV1ElSAY6WUD8jJ0/1Y3EUnZas963jU7DDMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxwtB6d/rdb3F+vj63wWrgz4TY3fYYr6c3UAzOgYk6g=;
 b=c66OVYo8ia4xSQrc3Wl1fnCda7eoNy6jZwO8IJVQpQ3UHOpJoa8JVPnecYr42oasjcWZpLpVGsOskE+WNCHX7W+nWbO3wDjQWhvffVFX9pT4MpWRC0PJ8nYPSy4JgJ/JZ/t7fe/atmffAfBNNaA24g+T8EvfLaNd71Dem6Uq9uLCVRamJEI5x8+QOdf8TWH0/lDEkAzkx5XPjfHHDtJRc9jxjkoIPhS6PFu7vtQNyWKDOKz/Urkas+62HSqQhdqyyodQqmKc4OMXjymmqmjHAolPILFhUGkh+dq06wEVdEPybbteCQNVkn+Xh8pRK0zwxaNgucb8PTuf5jthz3DdIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by OSKPR04MB11416.eurprd04.prod.outlook.com (2603:10a6:e10:9b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 14:32:42 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 14:32:42 +0000
Date: Wed, 15 Oct 2025 10:32:35 -0400
From: Frank Li <Frank.li@nxp.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dong Aisheng <aisheng.dong@nxp.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] firmware: imx: scu-irq: Free mailbox client on
 failure
Message-ID: <aO+wg4I1IFxQQ7rf@lizhi-Precision-Tower-5810>
References: <20251014-imx-firmware-v1-0-ba00220613ca@nxp.com>
 <20251014-imx-firmware-v1-2-ba00220613ca@nxp.com>
 <aO5yPLL9HKdM6yuB@lizhi-Precision-Tower-5810>
 <20251015135503.GA31091@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015135503.GA31091@nxa18884-linux.ap.freescale.net>
X-ClientProxiedBy: PH8PR07CA0043.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::28) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|OSKPR04MB11416:EE_
X-MS-Office365-Filtering-Correlation-Id: a5ca298c-c317-4b94-203e-08de0bf7b31e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mYafL5LlEslkvbgnLPILKCsfzP7XPEMqvrf2HPJbc4XiUPlOXKr/0WpRHIQM?=
 =?us-ascii?Q?QgusyjmA+G0ZVGuOXKX5O7qWEdL8NCwlaQzuosnb3L6PlKMfzeZ7yFaMRuYB?=
 =?us-ascii?Q?AYTEBUnMXU9ZM8W9RVvfZuirw1YpLT8FEiftq3OxWbptSHJLB8gOJaqGQSmr?=
 =?us-ascii?Q?W11hcEEA/eKsgYXx4IxGtIwOIHK5WWJ6PKYywup7k8y5nVTXO5VN+7hDpUz2?=
 =?us-ascii?Q?0YVNrEew6gax+QvvKG9/poidvne3ibEcSHAL6NEXC/xYuSANCT0ZQ8uspINn?=
 =?us-ascii?Q?utEHc/bQZzxkwSdXC2MB3w7mKOjs3Y+I2tUlWeTNZU2bpK2sU0Rsg4If2D7+?=
 =?us-ascii?Q?u0FcfmBof1QbzDeKiQwty0AKA++k43KN17pkhIC2Pa9mVeViwbojVv6Z6y5M?=
 =?us-ascii?Q?jxE5jIzjAfzVmNOeLOQW3oFmlPPqK2/TGiuQ2BYuh7YLxqMtQEtK8Cnmtgo2?=
 =?us-ascii?Q?bBta8PLN6LKtLpo+kkRiyhNkcNaX8Rr7Ghz1VvCu9uWhDIybsb3bYUJOr4xg?=
 =?us-ascii?Q?FIlIgUabhVA1Z0dCPgEgtVzKLnICUobkyWnNQwpfTA/7dlY515ezflpulG/c?=
 =?us-ascii?Q?h9lVvgE6U1DeDCj68EDN+SgLjPlJTGAK4N43De1pngcFyGaKekwazcb3ZHT9?=
 =?us-ascii?Q?uOtIUHsqSw3Zz5o/MfQlAUQGocL8+0JpWBM5t6IouVCWWGLFknm7vtGJ4jSn?=
 =?us-ascii?Q?5L7rF2abm3aeA4k50eElrzhHk3+E8/1XbCOlavl0uJsY3I+roNoeY86AW93y?=
 =?us-ascii?Q?n+BORrRVTVoknDwIMU1ex3WSxxZGVQDsfQSsyMdekDSIzL8cQB8YglhjfSfE?=
 =?us-ascii?Q?b2ljsR6P4sf4tdV4uzwr20s2o8V95XBjVrWJBg42OjwbYgGJNZC1H5YV+I6y?=
 =?us-ascii?Q?4EeB9uICLm0M3Nlo98B3XxqROnJrE2Tv6orXfP3VVzHJxEgtYJ8o1Ec3w9QD?=
 =?us-ascii?Q?i0ti6nrBKllQ5d3gfshTaBDkAdq/bq0bPeBZYFpNR2aXJ2ABjV7A8xrYi2bS?=
 =?us-ascii?Q?PGeIPCN3p9grSLgPHGa2moF09VGEKFk7LciCouDmcTx3nUfiQAZzP7eMgjpH?=
 =?us-ascii?Q?TYVg+V28dPXr/Ros3VsPKQclYxlQCUBx3CAUDFA+4PBi2/67iWAJCyDdF2Y3?=
 =?us-ascii?Q?oy02j62AqzWyE4Yzjc38EusT2cT7//3Yxb9jt8bW/SHvZAN8LhXn0iIQeY+Y?=
 =?us-ascii?Q?iAD6M4yYAdt5QzD9mel+tLAjaRgaI0Oenuf+S224CJXOAAR9zRQyIMtoBW+B?=
 =?us-ascii?Q?DVhDlEZjBQarQz/NOJWkKPP+ntKVjb1VqDzhA5qU3A/Qn2bK/dIFc9+mHLSi?=
 =?us-ascii?Q?Cv6wq5byxV0Df5DNc80DtN/+x1gFUBYsnyu8HYqYsmY/FOQJ7RSE2QsNGzDq?=
 =?us-ascii?Q?GCRy8Egzx5Dq7diR+MqwhMy3Txm2IPXfcTvBFhtH1Plj2SA1dEvjsGMfIsLe?=
 =?us-ascii?Q?ESSoiL2AkmdkuVDULkbBRYmCmiNH97fDNtIJxFBqDmF5GKvzEMN86rAi4ueG?=
 =?us-ascii?Q?zkICNPvSA1Hjv9j6jIymZBLgHXbxFROKF9nE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uekOl2txFTd3qp01TPFpIA4VjwR7vBDwxIRjigKlcjvdztsAQMiQFI2+uB9f?=
 =?us-ascii?Q?NZyfKmHHku5TpWS5cp+VuN4pwsle3qzTN90NsvPRpOBS2n+AmMDxrYg9WIE0?=
 =?us-ascii?Q?pfVQUsOPat5U9Doj26bfqwuJX1eGR5kZrDhezHpkwUHfUc82Q7Z84yAFqRin?=
 =?us-ascii?Q?InCuMQmOe4fZNtyJ/2POy7G26x6DCt5ihGeTS0j4g0tuEzWxgP4al7t7Z1Rv?=
 =?us-ascii?Q?qAMo/2wC+sPWIOTc45H7fmRRVe0d+b+zXLIBnSuKL5rzczIu8+vXHLUIe2rk?=
 =?us-ascii?Q?b1F8VWoCk6i4tZRoBWSrdtdbhCizw8LS8+GDmabflsiGBd6iHHIAdyJTTjXZ?=
 =?us-ascii?Q?KPVE/gIcPBClG8e1EKJR81mwYlwZ/oVAPOqQ3FKy5YpopLvbnsMvakIW6odu?=
 =?us-ascii?Q?N4cUH6RMNQrfaLWKxhT/SQU0LsoIu3IhuGFyw39alOLVq4KsrDrut75ZO7ZA?=
 =?us-ascii?Q?BEMh8a9+jp06OrBRavH7sz2LBEEIEjyiNMFEKqTmgHyv4ocA3V3V6MMHmPPK?=
 =?us-ascii?Q?8OEhv2bmxiSC+Z0Ls84WFr/w12YvkjaiXnhsEKaWDOY6W33GXPx8Yh5/Kzv1?=
 =?us-ascii?Q?eFbSoileOVqurA2a1uh/VwWbpbRc+/Rwh9K7VsC19asuus6Df6EtVMqUOS0w?=
 =?us-ascii?Q?MUb+7K+N7oP6EtgPw5sHx1P3/WVeWb7nBjFj0vGhsfuqdNBW/Vqvwh2kGcPZ?=
 =?us-ascii?Q?1R5OGweFD3gqc1aOciGfcfHcxYnbCIrrIOSzsiQs1xNibQQll6WFnuFWOiVL?=
 =?us-ascii?Q?BxzCr0xhOPOD5z9KMxYCSdf2Id+PbfHwThvBcvUbZi0z3B5VZh6jH9BTo5Ti?=
 =?us-ascii?Q?HkjsdJgcH1eFkWA3rB1+9wpeRK0FSxzQCHqSs834apZC1ETqrBY5otgWnaK9?=
 =?us-ascii?Q?e7Ryo//TitbRQ5PZ1ZHx3TeKl5tixEv6tDTX0g5bl7cQbRJwwiMqJKw67Pkj?=
 =?us-ascii?Q?2MxfDrHWgJw8qonPrNO24VGUeOwXrl5T23ORmR5oUHGz7xEr5S4d0/gKiVDZ?=
 =?us-ascii?Q?OBfaXuo93DigrbRYFVP5cWw3ZKfYya2sb+obtICphEHNNL4FYLnyHfl5DYBo?=
 =?us-ascii?Q?0BjJ2yzsNHlopfd6r+UjZsCeBWvRrzXPHXIr1BV7LBBLLgxao+N9VLk7XJFJ?=
 =?us-ascii?Q?vGnwGa6igIhmv9hT8NEhSPBBCmTDMCANh9SczK8hr8ZnNAsulyIg8CoLE/f4?=
 =?us-ascii?Q?JJ0YUoWZUjZCsNYrZR2rA2UFaOGqVxIbIUdUBiVERgcOvd5XDaqMmM05dZhU?=
 =?us-ascii?Q?YuNxX4lFRbjikKrrIb0HJMOO/KKwj7jqDIGOdNxQIDLXZ3dpQ4kntm1tJhvd?=
 =?us-ascii?Q?AdtJpwjHHIQOZ8+9KrMWslMuuz63tO2kMuRdwg+09kLj+bn8vM1GTBoUvzJu?=
 =?us-ascii?Q?mUWp+dRX5pd4IxCCWLFbuU2RBUYKkrcLHJAp8y27OCzWcAzg8p1dYXS3Al/B?=
 =?us-ascii?Q?JOqGStpIEWllkggT5QiohQqDtX5Z5oViVsCPngs/Xhw2SGgk5pwKobHFVBnl?=
 =?us-ascii?Q?9XtfGwtP+OUamfl4ATEPPIDUifRA/TbsW6h8bPh5XZ8ZGUOF8YdltDkd7GKr?=
 =?us-ascii?Q?jPdESbd7sqvNf7fYXA2Zwz6ZNDXaopvYV1GRMNxc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ca298c-c317-4b94-203e-08de0bf7b31e
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 14:32:42.4397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: htzoF7yllwAEyjBqlpId5iENap6D95VSh29Q6PfF/AQ9eYbGsagEDRGqhKNkBVfxHgYB61PLdVmmddtXIKoRVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11416

On Wed, Oct 15, 2025 at 09:55:03PM +0800, Peng Fan wrote:
> On Tue, Oct 14, 2025 at 11:54:36AM -0400, Frank Li wrote:
> >On Tue, Oct 14, 2025 at 12:54:39PM +0800, Peng Fan wrote:
> >> With mailbox channel freed, it is pointless to keep mailbox client.
> >> So free the mailbox client in err path.
> >>
> >> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >> ---
> >>  drivers/firmware/imx/imx-scu-irq.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
> >> index f2b902e95b738fae90af9cbe54da4f488219906f..1fbe4c3de5c1592bfcf2334a83776c25d5ca7a3f 100644
> >> --- a/drivers/firmware/imx/imx-scu-irq.c
> >> +++ b/drivers/firmware/imx/imx-scu-irq.c
> >> @@ -255,6 +255,7 @@ int imx_scu_enable_general_irq_channel(struct device *dev)
> >>
> >>  free_ch:
> >>  	mbox_free_channel(ch);
> >> +	devm_kfree(dev, cl);
> >
> >
> >you use devm_kmalloc(), when return failure, framework will auto free cl.
> >
> >Avoid mixing manual free and management free code.
> >
> >So I think this patch is not neccesary.
>
> Actually in imx-scu.c, there is only a warning message if this API call returns
> error. So need to free here.

what's warning?

Frank
>
> Thanks
> Peng
>
> >
> >Frank
> >>
> >>  	return ret;
> >>  }
> >>
> >> --
> >> 2.37.1
> >>


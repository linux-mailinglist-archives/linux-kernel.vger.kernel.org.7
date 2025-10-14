Return-Path: <linux-kernel+bounces-853057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AF842BDA8DF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 249F45041F7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03ED130274E;
	Tue, 14 Oct 2025 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yn2kNn2h"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012056.outbound.protection.outlook.com [52.101.66.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F01A302146
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760457715; cv=fail; b=ADdPpOv7ugeSq+Gf3hq3i3df8tNKe6Tk2Qb17YxHpKbpJ8puk5oSu4tmDas+a0idRms9zdlEvFMEF/JJsbuVASIcRI5XLYHz8k7tElDav/LdiCJHnkAAOmc12oOHoarX6c+PQY+KUBnAgrWt7N5wyiP9P0tfgjL3khKFuAdwPrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760457715; c=relaxed/simple;
	bh=7xUWhCuRpuV8+/L0ybuiEncn20Gst4YB//UKJ2e4M2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FnWT5NNvqDk3FQo/AvI1/mZa9vzyiHc7xqbHbo+H7mSmMJAt1nc0qq54dMSDlRNy+9Bo8im6i5phZJ3CkQz6cE/TFCqc6+2tEVJRjoExBEYRQZpqEAlkgzYsKcEpo3NPNUCrwTiDsJ9bPbBLecBWw8/kPdQ9XXfG9va8nIOr7Hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Yn2kNn2h; arc=fail smtp.client-ip=52.101.66.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAx6MYM3kHkMoQD1tnW9xmoL8es2CWCrdEOZT/TJX/VrhZ6O6yGOwEJODAw8137M8/DhoW5F/dREerazwDFbqTS4vL6Vnh4X7FNygZYavMSUK5iQ2CYgy5ebBTuL80NOWUlqYwuM8JDSWa57jwynIABUADPbcmL4pZD6t5Q8/u5K+7j8sQYWfzZ/VBQIhcbdx34ZSMPc5PG9M+5AzZSF3rmlvG02QL3AUtPF1yS9cMsbqdG1LE5WoUSrjSqiYqxjyb30ALT7iAMCR+u5mGQhCGWDTxe8XXcrzl9oxgvu/3UoE/t63BbjWE5RbhPAkBhrmwmcnYG9Sq2UZ+75HAm2cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hPnwiSCG1QPpnU7bWn4YFS2zYRYKg8KDCDamqu14Nk=;
 b=Wozzme/FK2pPJ0cAKvccKJyfol1fEObHlygkyo43S/y7HXLaH+3iSvw49gFZ+q3eSqrIybe+o7uKYN2gfVtZ/oPY+NutuND+MqjZCbzKKuGoTkHPpcxmcNljWMnaeOhaQT58WiBKjj03tHGeItDi6Tfi8mrWBmThUQNaCgzoI6IoWr3ZRgrPfOYxy7Y5XeneOjox3jSlYOQnO7o8aLteDlydV3n5RdnXjRYqek09NIIPAEGfyWoHWqBFYebi0kfsZmLGs9JO4r8VZygQjUJ//to2OZO2mo330PXCvMIM8J71S1I5CgQ/WhtB2SDH4B/MAWdm8fawrI/KAcPtW9zlZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hPnwiSCG1QPpnU7bWn4YFS2zYRYKg8KDCDamqu14Nk=;
 b=Yn2kNn2hAQJN9ImDoQwdsM7zzbqAOt7xooCsdj5FIf8hLdzIqCPA0lEJJ2eTkW1p9Rx+QhfYV7dtOTCGaClKpHkLBwsELFQAoNRQDav5l2D/HXh2MhXLjwoGhfMerFczv4kH9a2z79n5ARYuKNMwDeATZ5g+F43UjDq8GYsiCW78A95LhkNA8wqr3KK/YaLaHLze/cqdoTfv3TMg+DpiWB/1iWnLVr/gzPBELVl80JvagJ8iJN+jOAcxNHtFcN0eu49cWFANs9Az0EtPUVhvRottkqeRUW2TzV0umiIOEvVLfOleVGZa6xoTMWhoterL7VisGDcVkZEG9fOIdIiZFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI0PR04MB11538.eurprd04.prod.outlook.com (2603:10a6:800:2ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 16:01:50 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 16:01:50 +0000
Date: Tue, 14 Oct 2025 12:01:45 -0400
From: Frank Li <Frank.li@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dong Aisheng <aisheng.dong@nxp.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] firmware: imx: scu: Suppress bind attrs
Message-ID: <aO5z6YxKnMx4EGlL@lizhi-Precision-Tower-5810>
References: <20251014-imx-firmware-v1-0-ba00220613ca@nxp.com>
 <20251014-imx-firmware-v1-7-ba00220613ca@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-imx-firmware-v1-7-ba00220613ca@nxp.com>
X-ClientProxiedBy: CH5P221CA0010.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::28) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI0PR04MB11538:EE_
X-MS-Office365-Filtering-Correlation-Id: 013da533-3479-42e6-1c83-08de0b3afc8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?53WwFXJ4KYL2ZBdVMx4cFjKNXUSfc4IrDWeSGj1q0OjqknizhYxFAUnbQ/Ao?=
 =?us-ascii?Q?xJcJ0PcRRRIsZ5HuRanRKx8LK17gPvuyyH07E5oV7paQqdVNpI24Y0KhjioT?=
 =?us-ascii?Q?qdVaPUCG2B1O/cQDR5CRjf4QYnV+M+hqV0aE9WuoEnOwVDYtZwl2c3XnbXTI?=
 =?us-ascii?Q?6RPTC2eAkcj+MxCNAbnruSDq4a1hA+Fvhmhf2gQiNawmi3OyaN4FdvXx3y11?=
 =?us-ascii?Q?oQM+32e332xBq6I5RDZMv9SLhC4VuY41ooxOrBUAEh/Xz5LTk3fJFoxOhri+?=
 =?us-ascii?Q?4/+K1RBtHlKK+nTGg+EIJ8cvPY6HN52YvP97hxXMBhmwBhrVbLP0D+hv2sHe?=
 =?us-ascii?Q?Y5RjtLiX00iFqXgmdn4zI9369qLLm9iyfzH9fSQYuu8XDy19E/xxkV3oL9IH?=
 =?us-ascii?Q?ORjlHkZEJ0EIfi+Brwfjz5SoNDNmJTGQUGbtAVWz3OGHJmJXnu4nwnHswE+E?=
 =?us-ascii?Q?h3532IbuTlWzg8JcpUzvYmy3XnloSb7d63w3mmEcB2ucCqSHTQ2GMhUFTIFd?=
 =?us-ascii?Q?U1c/biN6IV4QhdY/5e+QfVaGhL5b7rEOxy0yzJIZUCAihUQaLhCx7OkZTguy?=
 =?us-ascii?Q?rKI6U5W1QjCRoA6jQiyLMGjiLcJVTdIN/M0c2gXLBpjwY+8NzOKhI0WB9+55?=
 =?us-ascii?Q?vbkW4deTm3xKfd2B3mdKMYf2LlD+4dFzuXYf6CLsyT4cYOunwjf1GvanhH2e?=
 =?us-ascii?Q?x+4WGWZB3fRPFZ8gtvm0DKrptNVJcGTlv8SgzPtXcEiGBpqOx2NhXF4jYkVr?=
 =?us-ascii?Q?ZQxOT5xaeWu9jmCysQwg7G2YMk0O+KtaljPcriwOxNrSL8KhjMk8RmwIovEy?=
 =?us-ascii?Q?LHQv7xEkDrRaBF/jUnyWt/eW7qedd+g2Zkkc7Q9emlCZYOXUoJZrvIZfzvr0?=
 =?us-ascii?Q?vEHYxLwbh51j+hmPdys/HwH4Rl+VKEAna0MKXwWANZ7uK5b/wDTca9QCyQJF?=
 =?us-ascii?Q?MYnr8gWYM+QE3Ibtwar3wzrc8XX1mPNVvG24VbzmyyXazAHFIVAs2kQBwJl9?=
 =?us-ascii?Q?4vcyWb0PYtMTwuNPf1z3Pxn/OlxQ1AuJ5ghrbfY7O/nVhYigBJfarPZM3b6D?=
 =?us-ascii?Q?R2ZEvrOUrB97BxJA8+TUm6H8p8N2r6f70s+aTspCucl80WnHH7dl4m4YLwV5?=
 =?us-ascii?Q?CbYPejHLZJDsWv2IOjZ7KiJJo+N1Sxhcossw/N8LOe2IOOtr6Rdh7KhyTHFR?=
 =?us-ascii?Q?fc9TBbkOGQM/04w4M6jS24Z3zNGlZvt/VEX8sXNaQ9FNtdDxsdfn3pTBJxBY?=
 =?us-ascii?Q?X+OsXP5mV/4J6fkU6U122hq7J0U0fnL4f9MFXMl0QdIzVj0CP9JmdUHZIDpE?=
 =?us-ascii?Q?gisklmXMMgbOj7L0JHK7tPD1qRv09ZTgN+f5dQXd7VY666KZSpHes6/HlhGq?=
 =?us-ascii?Q?PGrPph+d/WqL+lOL3UdJqM8SYjBInEwtcLO/SAdgTnwbSvR9PDw9SI4rJfc0?=
 =?us-ascii?Q?QzAU5Eqgm2VcjD7QOIPUZgAN9yK/lNKq9FNMNihIAHzhh8Y95AxW0CLMHoBF?=
 =?us-ascii?Q?gLtSu3LmCPH6gjvbNcTBFwCBemXoQj9xLfCh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lip+LrNCtzOjalUn4xeaZFOeLmsHFH5NgWmooNjqN+0jA7gFEiEN4M3OPQP3?=
 =?us-ascii?Q?91ruo1Z7YKkRpyT/T8T7hXrM99iouN7qEX7gA14yGjB5GKRDJo+i8kNuf+b/?=
 =?us-ascii?Q?ynhh/Urh7x5JaOoE0RQMLrvi0iNEQ4aYjstZZnw1kv8oDwY+U4bVhPRwthwr?=
 =?us-ascii?Q?2aiFiShbH3fHhDM4Szinpewo/cV8qK7NekGQHvsdCQR7Phw0sMzS3N0bwfmI?=
 =?us-ascii?Q?4q3LTGtOLqzytsidv06nGWIL4UdRt4+XU1bjTP5tpao50I1NOw+1U46SDjiR?=
 =?us-ascii?Q?D+AhBwO5Lxl4z4MIcZat/anY8o0kp636djL933ZMOU5MqvTOxOTRPBhWMI6v?=
 =?us-ascii?Q?6lLLx1f10rjyUvXNuOiiFQ9gTVXHG4QJ4Q5UdqWQbNf/0qz/7lLD2PF/u7Zr?=
 =?us-ascii?Q?n5MK8vhcdEzBadmkpsGiEgddJnIyMs4jQ3Q6XDqCbyg8vdoVjh7Gg6PF3B96?=
 =?us-ascii?Q?uqN/j3jaLYw14mP/n7Wvuf6OWpRj5CYtNL39Rg/IdrWbS+gHo+ILqTazfAWx?=
 =?us-ascii?Q?Jt+kGQOg9SJBbvla9I5Iov786ZAx+SXf/zxl/KSaepWZKQwIu98SL+yQOSkB?=
 =?us-ascii?Q?Y2ht8FFXNEVa3oM8NP9cJuxfN3fwLotKnBRh+wogn2Ez7AMn1ALCecf2sXr7?=
 =?us-ascii?Q?GF3qslTbKdsYPfv5a1q1olqM6GGXU0+1Voa2Jx/ShG5deHlK04ilDvi32gog?=
 =?us-ascii?Q?Xda82Sclgij8qtCQTibBHXI6eCuf1sIigF3H2d4yd//DGyqzEMOGoEWn1mDR?=
 =?us-ascii?Q?GXnbbScwjF28jvXiKhSG+g104GiatdjZ0HqWSVyWSBZr/BWkIEUUV2JOzBL+?=
 =?us-ascii?Q?swm3Ao+dHzfpQXFGxfOQ04hcxTSLsQ0BNsL+3ORsrLGsjwroxR8y5P2EELF0?=
 =?us-ascii?Q?bBjMZBDNBEtvSGu76MUhboLSQY02wI9ozQvzazPtcQ/flhDoeX3fuJJkOfVu?=
 =?us-ascii?Q?kRtgspigahJ2loG6w9RAC4rfNSvmUYLBGAgQVApeS16QO3KyrB/OJsXM60+H?=
 =?us-ascii?Q?zaRW5Ll3Q/ZMd/ptCTAKrG0qMMxGkgTqSQPUJX3HRX2YJ2OdeqWLd7cmy+84?=
 =?us-ascii?Q?La8ajxUSIRd0UeGSUt38TJ6aKuyw2czcdhlH9P1FIHidV1dY1GwHQtI9YuaU?=
 =?us-ascii?Q?ifyTSY+fWc0h6n0W56IIv1/J7NpvCWwii6yobXQWoiN5iI1Sb7Lw0H/Q9J2F?=
 =?us-ascii?Q?lj1PTXSou5ZzAbpouXzSiqfZ42Ibew/xUsjxjOO/OoTIUYUrblJkMjxH0wlh?=
 =?us-ascii?Q?6GPbL9ZYcGmgRJ56Gmq1q8F8G/bgRutD1CYYciUfIU0dBZ7ElcpKI0edZTlU?=
 =?us-ascii?Q?i2gaYU0V32LX7QTHFlbCi6sGHP2fwKAFOcasKcR/1UMduGub+5zr/cgGaB8D?=
 =?us-ascii?Q?N2ji7KDS0hn8LBeo0gM+nHj/GjnJ0/VH2rvpHLy+CVWR5SvuA+B2L9NgkuWP?=
 =?us-ascii?Q?v0GBrKW83np6oUChO7Mhr2EThnzQanG673cuoJe6sTfa2hD3cgWG1PiBI6UU?=
 =?us-ascii?Q?oVtoPQpOk+VsOh1aGqRZjr3Ngknb+xDj9xrGR+Re9Tr22JsXQNhrzYzWgys/?=
 =?us-ascii?Q?BiaiQW0zi1lZCGuR/7RIXLuDDCIcuJqNlwoozP4m?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 013da533-3479-42e6-1c83-08de0b3afc8b
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 16:01:50.7202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/fn2cnq0Z318SVsxh7O+Vo9MMl1QKC+Okuhun61gloEM1mDJTiEcMW7/PlBhMi5lCdJwqU4eiM5YD/YEwcz0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11538

On Tue, Oct 14, 2025 at 12:54:44PM +0800, Peng Fan wrote:
> The SCU driver is critical for system working properly, it should
> never be removed and binded again. So suppress the bind attrs
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/firmware/imx/imx-scu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
> index 6046156bc3c9abcd8f62b46f04571b1a9decc0eb..630e3dba4db15961ae4d77273af6248be614145e 100644
> --- a/drivers/firmware/imx/imx-scu.c
> +++ b/drivers/firmware/imx/imx-scu.c
> @@ -352,6 +352,7 @@ static struct platform_driver imx_scu_driver = {
>  	.driver = {
>  		.name = "imx-scu",
>  		.of_match_table = imx_scu_match,
> +		.suppress_bind_attrs = true,
>  	},
>  	.probe = imx_scu_probe,
>  };
>
> --
> 2.37.1
>


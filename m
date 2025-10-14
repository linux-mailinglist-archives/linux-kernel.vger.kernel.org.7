Return-Path: <linux-kernel+bounces-853045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6DDBDA899
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A18194E2B3C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D38305067;
	Tue, 14 Oct 2025 15:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="esvQMwo1"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013008.outbound.protection.outlook.com [52.101.72.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFB3301718
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760457339; cv=fail; b=ncemSwwFs9QepeSrG4/0Mvn07h5SO1KB8d4iptymunA18KFfOn3ylX7GcuKEeRJihOy3A56uVt+SOQacePWqwPCoY7uKquqCtAWKkMQ+1SQ6zISoOPBtpVT7Lfiv2bPlC0ZKSxOccq5KsmN3flvNynLlRGbMFTkRMubwrXJkZ64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760457339; c=relaxed/simple;
	bh=3P5BjiyIRkPS9peGd63NuMGWbKx0ODpieeWHmR01HCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r3iUaCG6CoQ3lZRVkg9xwEsBajTjewsW498TeTVxdcmQIYfPGCD70yYGs6rJs3roVjWAor/O2LsIizrBzvl4CZe3FLUGWS4OwBycbQDh0x8bYhX14CRXTILfv9vy3hfhHvpkBSW1lQLkXJUrIG+TpyMT8BHu+Hk+7wINz+TJ4Og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=esvQMwo1; arc=fail smtp.client-ip=52.101.72.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jy/ZEEis6TlXADkYEldfqLQpDaLMWHUdpFcC1PYVUW/iH7axUabi+e8U1wwAvV6obF68Zp3VDf5kXVdz5KforQTlEJSm/weHuVvlGHgd6QLtmUj2oPu4Q4JDXvJaB1p7ffsTyJmAZyf6ZaAuHwy79z3EVALVIsB8DGjKUd2OZkELCusQur0VlK5tzDcrYanzrPkazNEW7qf33fqv9lYK+8ojH9H3zWKBiFiOWXTlZO4+odWihdaQzKkVfYxMPQK5wDYwWFV8Z5oRFTxeT9PFdCxc5TygWsUHzPoDcE8tRNll1rZYD00opMVntgn5rwGDYLfhtqkwMeTfJs9js43XXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0U2YsKFgkvGPQa0Q7zOnGlW7ho+w4oNF/Fmi5N1q3FM=;
 b=u6jkv2fyGOaABSJVN1AsemAE3NzOzEMx6fzFhir04TwSvWmKHk6FOdD5QGZPbr2l/M1Hib0hZi7ebDz4qPTgn0RwAsn22Q4SqycGUMCsinHoAVJu4EBiA0XiQiUScXvhJL3L0nkg667SqlmkPQaHldEQaJaXg0P8rhhF1b9W+McZmBTcszY69fR7ti10bx07x3getQbee/pGOLjU54TGI9pZjE/E3bF8LI9OQ38RfhRf/QAvLpqAWUwCgbPVJrxy7A/czOXePR5KxEUnQMHMYzld71xyj3XxbqUzRS720bfhFPxVl6vk3pOycKtfMsahIsWZYiM1svjMZXKnHYwl0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0U2YsKFgkvGPQa0Q7zOnGlW7ho+w4oNF/Fmi5N1q3FM=;
 b=esvQMwo1xl3puhgPfCSQfka5Y2VQd6HpRn9HV3iacq01agMy3BrBUrLliCEfqAXHEBsqlnotBB719rWYbRk9KGugBx87jhxSm09GuR++7Ub3W5M76/pCHuB6zyfeMZHC0NNmvKXV+mKmeO/I3io6v3eHG7KMZ08kPuHvzZiJ+QRmR2cg5WUtncHBFc8V2ytp7+taPGL+15p5x0Hu2vUJlm1W10yW7AjkeJpI7hQIbmPSNfDcSMk27nQ7SwL7kvl+yoxvNPFqI6oa9fRaht0FIzsjUwzBsDWuYSx05NeCrcepPAkiYdlk1amy0A0qkF4gpr6HPIdcl8pH0X3dm9D0XA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM8PR04MB7266.eurprd04.prod.outlook.com (2603:10a6:20b:1d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 15:55:29 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 15:55:29 +0000
Date: Tue, 14 Oct 2025 11:55:22 -0400
From: Frank Li <Frank.li@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dong Aisheng <aisheng.dong@nxp.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] firmware: imx: scu-irq: Init workqueue before
 request mbox channel
Message-ID: <aO5yaknwKGftsGxC@lizhi-Precision-Tower-5810>
References: <20251014-imx-firmware-v1-0-ba00220613ca@nxp.com>
 <20251014-imx-firmware-v1-3-ba00220613ca@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-imx-firmware-v1-3-ba00220613ca@nxp.com>
X-ClientProxiedBy: PH8PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::29) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM8PR04MB7266:EE_
X-MS-Office365-Filtering-Correlation-Id: 99e8f71f-f707-4778-218b-08de0b3a192c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?skMvcR3Q4H/1rUNuoW8KuY0ewMhhzosBaYuSaz64gGp1Y368kjhtFU37rgTq?=
 =?us-ascii?Q?rG+kx+AnjUyW+5w4i7kQNxuj8IJmD8mPlSGBtlpBrgWtgXVoWy8hSIQ9+Lyi?=
 =?us-ascii?Q?ODBruBRwymBMzdDGHUYvcw3DSIaFK3QoolCoA2Mk1TjRpKJ0nmPXbjAuB4/o?=
 =?us-ascii?Q?Owyp72s160XRil5BDReW46GEV5qVKznwi5thQgo9trmTLjgxHxpHqF8J1N2h?=
 =?us-ascii?Q?U0VhkYSGDEj3yVHreuZgV2o1NmKc3PTet9Mkaez5wM/6kh5+K/ZsIVnevSKV?=
 =?us-ascii?Q?5YlrK8PrcLtZtf4Keix/x/HwwbnOXQqnIWEQpNzKuBpcOtO27OvsPH1ZVHLG?=
 =?us-ascii?Q?BI+J40hATh4isO82gYsxvKr1d1ofWS9UGERlPTHmr9VahYWJupJALSRF69Re?=
 =?us-ascii?Q?f4KUxRFMbOKnTPnXNkBIaMPO+5tm8z2ast4aWN2d+nQcaJ2CLKM07UWeABXY?=
 =?us-ascii?Q?QNy/DdRk8h427ZUGoA9XukErFF30WAtikO7NMrAu3Rc3TrvdduYaWUFg7L0x?=
 =?us-ascii?Q?2qBifM1wQOZhi7L/A4RR3eNkzIsbuTMDdo1eUkbYXSrIkWD4dIFzNZfY+Asd?=
 =?us-ascii?Q?qC0REEY/ALcqXdR4+w2vGv7KcU17ZG39QJ79SnG4NmZXhyMNlE6bbQG0YqSO?=
 =?us-ascii?Q?iQHMQ1V0/tGFfadQ78fJ7NV7OF8r69/0OzIC1abgOHRbaayotkL0HsUUSkt1?=
 =?us-ascii?Q?zGpJbeVE4VAckZ8jAw/m/DLUj34b2Hzf+hYfkVMDrOGym24SEdMZVmBaAubZ?=
 =?us-ascii?Q?qpvZWjwMb7Wu1R7GkKxqvh08yNPm7s0aRLFIDNaC0yPOCB9kkkQstIHWB3U4?=
 =?us-ascii?Q?Pcrj8k3+Q9+HnMWvzs6zBnhSyIn2OzBe32f1/DCd6QfHUOiPSbyiJ1ToDv+C?=
 =?us-ascii?Q?91+xNRzwuctHEFZANzvbL0DwAEx/TbWCNvnmyR58Wl8OmG5e6WLZ93Q2/Y3Y?=
 =?us-ascii?Q?IYYS32j0n0s5skUzSPQ616ZyFsqLHTuX1e+IR6onBty9rm29A0CoHa+/4iu9?=
 =?us-ascii?Q?Ao9h4zuxqmVfVy7sUG2kUDzCUMRu0JhN8zYNCRPuRHd7mFneO5Ti0zn+xKCu?=
 =?us-ascii?Q?vJVlNHFvi6qBFiqkn167DWZvNp4FvSndI+aWHtqNnt/eREpcERyF57yhWLN5?=
 =?us-ascii?Q?leAdMTCurfwdepQ2BTYCbWHStt5j2B1YQJ7O6ogj1XmMJ3UAAUNkTs30lGdw?=
 =?us-ascii?Q?HGf4fyMqnofpu6wDzje+tACLvtz+qv2enZnZnICLGFSNNHBP7f4Ri1iyS6KK?=
 =?us-ascii?Q?NAV5Oh+R9vRcDKluh7vnWk0ckdJX+c82KXVTNit3DwBhB9JZZBevCFG1sy9b?=
 =?us-ascii?Q?VOUwDSmBMSX4uo23TpEC3Grkpp/ZAmu8KXWSOY2M/t5C3vkW9oJGv+hVH9JQ?=
 =?us-ascii?Q?t+rzuxsMKIB9eoR6vEaxHLKShYDjkixRFyXpFfXHfaD4+Ja8/4hbTLejUSjd?=
 =?us-ascii?Q?q/mkn1w9U/wBWcJIvf6AtBlXzuvrJ2+c0sk93Bgn0vQyPUSTr4sqY/Tcz0xM?=
 =?us-ascii?Q?QTa3AXNOnjZXwdnY6cLRygknYJge9nWiKUd6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RqIFhG7xN4cIuWjwSAtxEBW92IJyPjOBpfG49dRtFUCo5sXtQr93YtYBhYTv?=
 =?us-ascii?Q?u3IP5KKhA5eH8+BcFYXpZ+9NJbNqktD4K4hOOYEK+pTGtWHzbcc6foYzGhYs?=
 =?us-ascii?Q?JqANWl/Ln6uJxY/Osiy0pXtrq3ZGkuJjKJmQzRx4mlPGW8Tu1aAN7tFjR7BR?=
 =?us-ascii?Q?zq+pK9p6SwQ1KxMlGifm5jUtNxVHUJ/umEQVP1JwBf0wDEkXy5oD0nQBJd4I?=
 =?us-ascii?Q?L9vvKSawLHKEke9NvOshWRPAW2wNhxecsKlJjSyscr1IClXWRiztiP3Tvwm7?=
 =?us-ascii?Q?C2o++CFJPY44MtONTRYUPopjT9TWrMB0b4RfNWQJ4X2sSOiWrPInL2rIu2oJ?=
 =?us-ascii?Q?cyWpbFaIrqBQZAVT7zZhNEgJN2csYPeSHy/+sXNZWBm+IFdm8WB1pPSzWwkN?=
 =?us-ascii?Q?jZ5khF+b8PDd2tIuzD762oi/j5eIT0gTIkAlo1gGUMJ7Gbr6lW90KcgS1KzU?=
 =?us-ascii?Q?IjBdFEBifXTxeQR9W/DJqVA1AUxRGpU+rIOTtiQk6/aw3Fw9+p4ue3/7Ib0N?=
 =?us-ascii?Q?PjqjsJ02vPuiqI1J8EUQ1OfrM1PSAJ1tWQ0DD5zK7n6yMAiTjW9u/KoVnfhu?=
 =?us-ascii?Q?cQA9OiZRmyKX8bTizqXJX8acrWzL/IJNUM7AGLwRtnTZkP3FygeDh7A1Ey/u?=
 =?us-ascii?Q?biNOcXxisDcEvn7YUIo5FM0Dr2r+d6C/3G9YObrvUYY1yOfZER6Zr7R3XTE+?=
 =?us-ascii?Q?GytxGXKlAv5xFIu7doSTov5AUgBjHRsKy5KLZqwCwbE0cQjpAuN4OakZYQ6C?=
 =?us-ascii?Q?fc/YBqynfmrrbZID8L8LwfPPVG/0X4DbBI/bzmxkjTeGI722DrlUUdTtdgg2?=
 =?us-ascii?Q?T6zUPLACW4qQ/1IyWhPJ3Nx2c0uAdTUf54EsTWGNiRTy5OCzvl1Oy/a0sQbn?=
 =?us-ascii?Q?G3sBwF/4b9K83J2qobWBSRXwTdvQehWMGUJIOthN/xIGm5wwR7Khh46lqFny?=
 =?us-ascii?Q?PDqChd4CTVwiNDIJCKeEkGT7lop4b58PdfSW99J2+9t99j+lmArSFIiUiBfK?=
 =?us-ascii?Q?WMA7CAhIiMOd5f69kSQCRk2yAyFzd/UI0lTHqnN3TWutG/WKsezT5v3JNrT2?=
 =?us-ascii?Q?iX7zWAyySQQrGSnhY8YUqMzhdZ53Qjqqhzto95J5v9fB3lhDBLVefpCqMZZf?=
 =?us-ascii?Q?T6H/9B0o6yMmbFT2k4pv8eCfdVQhV3I4Mo9w0yUEmUz+DgHKz5zm0S2roJd1?=
 =?us-ascii?Q?Ecom4Tq2JB6V6ajSfpRnZUZPW8hCF0kEJGD35hn39FjygYzQO6bfI3ItU9du?=
 =?us-ascii?Q?lFEHoH+xUqGPMEstx4VxuztIZNTMVtwTAYkmQuJRQ23P4UhVHDqdDntp13DW?=
 =?us-ascii?Q?GTlzpvqe0cR8o6ZDwWyLAbhs8a929gi1CMWazB34/kGnKXHCB9ID3v/iBayN?=
 =?us-ascii?Q?ZpqddUgjwm3ROjJLtC0iY4SmKGYcA6EnvqmBO4kqztTks+43C6yyW6Jlb5FV?=
 =?us-ascii?Q?4DpWVfgaulojJ+yAokCAJguLiKzVQui1k5s/E//i3UB/5+tY+doX+MKZEDQg?=
 =?us-ascii?Q?DJGtXrYxKEM8g5dJHA/RscQitZcCZCjeafZ3gHyTkFx78Y7HJGcRVS2zDDQ/?=
 =?us-ascii?Q?Q6mV+4+CgtloebhpRvLLnYHRTKxNDophXkd+L4Pb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e8f71f-f707-4778-218b-08de0b3a192c
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 15:55:29.2545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r21pxe3l078EiUrk8yi/P6rP6sWxFsMIDhy6/a4ji1YEMQ0UWofWc0sFcAfBrqjipdl+QW5bCbU90bXwZrUR2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7266

On Tue, Oct 14, 2025 at 12:54:40PM +0800, Peng Fan wrote:
> With mailbox channel requested, there is possibility that interrupts may
> come in, so need to make sure the workqueue is initialized before
> the queue is scheduled by mailbox rx callback.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/firmware/imx/imx-scu-irq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
> index 1fbe4c3de5c1592bfcf2334a83776c25d5ca7a3f..a53ed2040c0cf7065474d681b2eb933a15877380 100644
> --- a/drivers/firmware/imx/imx-scu-irq.c
> +++ b/drivers/firmware/imx/imx-scu-irq.c
> @@ -214,6 +214,8 @@ int imx_scu_enable_general_irq_channel(struct device *dev)
>  	cl->dev = dev;
>  	cl->rx_callback = imx_scu_irq_callback;
>
> +	INIT_WORK(&imx_sc_irq_work, imx_scu_irq_work_handler);
> +
>  	/* SCU general IRQ uses general interrupt channel 3 */
>  	ch = mbox_request_channel_byname(cl, "gip3");
>  	if (IS_ERR(ch)) {
> @@ -223,8 +225,6 @@ int imx_scu_enable_general_irq_channel(struct device *dev)
>  		return ret;
>  	}
>
> -	INIT_WORK(&imx_sc_irq_work, imx_scu_irq_work_handler);
> -
>  	if (!of_parse_phandle_with_args(dev->of_node, "mboxes",
>  				       "#mbox-cells", 0, &spec)) {
>  		i = of_alias_get_id(spec.np, "mu");
>
> --
> 2.37.1
>


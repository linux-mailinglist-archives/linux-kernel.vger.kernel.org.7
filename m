Return-Path: <linux-kernel+bounces-858165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8607BE92DE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AA2D624EF4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC7C339702;
	Fri, 17 Oct 2025 14:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iTKX2ION"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013022.outbound.protection.outlook.com [40.107.159.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E23C3396FA
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760710900; cv=fail; b=UyXYktehrqm7N62ChNFtomyivwEmaMIyQah+l1cv11s3xf95eqjhtz0ndcunofItTuMXF8vXRMr6D2PO+f/zYPv8hIJgv8Ioa+fEyiqvWpLXtS2v0szAB7iZGZqj84vPN1pzbe3jdwJg+/nfx0I6X/YuCfsRCPdYTRid2xaJjfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760710900; c=relaxed/simple;
	bh=hFsAu6887zgL3ZMOdpa/pCrubzJ68uRRV2oLITN0TF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DJkv/dqkHpheDHjiGkTM6PZfdIJgx88cCe8MDS+fRJmZVpSECUiCdxmflC7dHX9HA/l4Wgdb2uouQv4Fp57rSSoMtIah/B7FbEhwZ776N3rFuWrq2aZAoENGeQONaS8P2avZcCP2HYwvvUcJxEp3kfqsdU+Xj1B5sRylXdNBalM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iTKX2ION; arc=fail smtp.client-ip=40.107.159.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e0jUDZnGUTEfI0lHDbPmQcWSucxSQVaiWrF2W1AXqmAwl8uqSlY2UcS788t6rTn9HARVjEJVNwAJICUMHO1WvxIRKpF3tlgprQHAXoM2hb7Aq3Cy7S6Bis0DHVZp3DhsUxjU7OF5+NKLXz3ujVJaty58BfngTKKTS1c94dYt4HxJXoIR6PXeHoRFwcA1g38pzy8Abqpaf8xYy3kiMWRuJq11UNmzozk337CT9J+B0p2/F2+CtR7UAGKBlQQfXFfgbx6FvBAMuEyaZkJ1OLnLoifKMZYXQwXOPo3tFp+HIfCjZ/mrTZVqv8BAqik07fx/TQeJGy7CxV44CQem25Eycw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6uKIFLNI8W1KLSAMV/F5aLJF0wp0FzqcSGrsPgnbl0=;
 b=F//iyoLSU2A6zJjGq66rORodfYhhp6Jkq/HgkALIeboFZvuiKuCuQRG778VU3TC6D+M+WwUA5kjC8jOzcI0W1ZtTPSN66QFiqfeMQc3L3JFu15C53Ur75gD6wxTqSeIvUgB2RibQ8eFoOdiTha7C3sV8/iFUNoLahHE6WtXzTqREbCNWdeaNpvGi8YtXnDkuGG92Zgk/JP7AkYi+d7Qd7kLrR6ommfkIjDEA/n+KvcM40xJKAL3iZ+ArPWOPJpKWZedygeH6Y6AVp2t6+vxf7VYaaUf6pg0y43oi3DXwzNDk2GWRDCKZ4/usrgS3ltoPaGnKnLqvgrMVfPZLrjw+lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6uKIFLNI8W1KLSAMV/F5aLJF0wp0FzqcSGrsPgnbl0=;
 b=iTKX2IONMLRn5n/tsuAo9qpO7aQatkJoGmG+tsb/szBIr/j/osG8wWWrLQmBkgipUvd8sW5/eeUwL5E/wILB5KW7ZehqGU5PWXWJo+BlNgC3ashFQkj05fw3329DSc9LKNsAWAJdODEDRpCIJnHNlGxYMFmMr38h4GGV1UlGUm5pOPrCXFqvYxM9F+/y0c9Wwm1QpVhgIZae8ETyxu/puxGhqV6uNrH+EHnynD7CxKR01hTnmlJKmXYMGzNK9UoUOwKuxa2bkAtesyPA4a/4xj/1X3YvdnmZxlhcMdx2mnGs5dI5tfe8Owf5ka126Bawuq3skNK7uK/FseR4MK6kuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GVXPR04MB10449.eurprd04.prod.outlook.com (2603:10a6:150:1dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 14:21:33 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 14:21:33 +0000
Date: Fri, 17 Oct 2025 10:21:24 -0400
From: Frank Li <Frank.li@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dong Aisheng <aisheng.dong@nxp.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] firmware: imx: scu-irq: Free mailbox client on
 failure at imx_scu_enable_general_irq_channel()
Message-ID: <aPJQ5Ef9Il3HWGJt@lizhi-Precision-Tower-5810>
References: <20251017-imx-firmware-v2-0-b58f68ec2ea9@nxp.com>
 <20251017-imx-firmware-v2-2-b58f68ec2ea9@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-imx-firmware-v2-2-b58f68ec2ea9@nxp.com>
X-ClientProxiedBy: PH7P220CA0180.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::30) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GVXPR04MB10449:EE_
X-MS-Office365-Filtering-Correlation-Id: 630a9ded-715d-4050-e3c4-08de0d887911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tQEajJUbE7Xm75WiUUxF7mOQQdJcUttdhpjafaCNZlmEhzzVeew7us8nsDgD?=
 =?us-ascii?Q?qF42Uj/bFyd8p7ywOcg1FPvKQTutlSWpztIrV4rhhl2RoPrQd5psbC6ZShcz?=
 =?us-ascii?Q?APlnaPkfY13ynX97IGJ7Uahj6F66duRcV/Qph8kyP8gtht8fLECi8Yc2JFiC?=
 =?us-ascii?Q?pgNs4sIZ8VFzdAMqWrmlt/1tWXdzsvE5PWm1o5gUA6OAcywyoLIWieGAhYKm?=
 =?us-ascii?Q?rnS7X2mixkmm5XNDtsF3Qe40qaeLZWHrtQSCa7k7MJZjXqqsqwoJ7N1qMiQo?=
 =?us-ascii?Q?yT6Uy0UBmBER/D6Bhts5hGdF3eA0vI5y3XRvODVXzfust+7Wd6nd8WVrky++?=
 =?us-ascii?Q?OrzWbIGKT6UFwevGM0wUxLTcghBBJ/0aOVzf/+GLdAcHHwgrP6+HxdMAQAxD?=
 =?us-ascii?Q?kDBsgZTaB1vCZTa23W/X+Pl283Mti4Vm3GT2bNWMIGqOT4qTxjks5CjZdcar?=
 =?us-ascii?Q?/+eZ1P3ljcPMFFCjY8szH0sEP/2a2eRooCJU/XTwpHN1BURivWQitxWjm/p9?=
 =?us-ascii?Q?yoRNNasc2kjbxdkGrvWBCXk4Mti3u8zSCU8dfakRwHKqRRaTDJSbTbeZIJqb?=
 =?us-ascii?Q?yl58cKO9zzES9wtwglLp2oDUUQ1/8q22dUSbc4A66mbRzX6mojPl0IFSkuZv?=
 =?us-ascii?Q?4vdpITdPsVzUU6mxsJQSRRDZ9PApXLHjsJMz3d4cmoiWoowaL3U2rbbQKB5Y?=
 =?us-ascii?Q?I0b7TgrXAy+IyvsG5szaf+AKYZZousZKReo3MpCjZ0m3uCz7rGDV1LnVvrc6?=
 =?us-ascii?Q?w2uMUitdpq/L6kYY3MOsd43TeN1jsR/mf+1uwhY2HQxa5fmmxHfg4kB/0+EK?=
 =?us-ascii?Q?okEf2pcLw/bC8Ktu/LyHkYBiBpRwKpvvcIPI8AH76+7Zz0i9stpGk4Gg5WpQ?=
 =?us-ascii?Q?ZwD5gFb2H6ZiE+fQDU0MIUTPJeB3ksLJJpsAYDy86HuSprRkPu35zvZvLYpc?=
 =?us-ascii?Q?0jEY3wfe7YF/VeoPqiY80ja6W8lGiLrSl6ZmEvPclQQAGHiWznjW3xfQ/bi0?=
 =?us-ascii?Q?Jx1/jWVRoWnJmgg0UWYSXLKQ1Ip7x+m8AuHu/+gFflxzoFtJBXJKYejeIoP+?=
 =?us-ascii?Q?8sNp7wmhZfqEH6q+bzhCMhXL6hyZYkPqvP3oZUtQxt8VaugTPKlRN800Sxjt?=
 =?us-ascii?Q?AKiePPtqByDs8rt6lab5lHSDb3HN49599ZxcWdzix0cR6cb2v9DEYqTVLFNf?=
 =?us-ascii?Q?KshQ48nSrHeXR557sHLcnXQ97AsnLFJpaLLzoZqm0Iitf6rNwlRM839akqnb?=
 =?us-ascii?Q?BWBh11DY/Qkpl8UziAaafi/bu0rFYVGfrTP0VoisRuGhyvAy1LOGLFgbAoQA?=
 =?us-ascii?Q?9GLgoy3O3x+B+M01tDicghWdpNj/5jZXiBwQrjfpgA7JD+bmtnzfPohv6Msm?=
 =?us-ascii?Q?ZO7IcynlobN8utSwRil6uFlNvaVY7jk1KzeRJhVERumwfKS6ewJzVa96uLJY?=
 =?us-ascii?Q?9pzF7uDi1TMQWnH6d0q7Gtkjm1HrnaXNB/J3MwxbxLMX1zh7HAGLdjuh3gGv?=
 =?us-ascii?Q?w1lUWlv70Xj1dHEQOIQcXlkdpwhTEGvgQkS7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/iEEslt8F3BaGKJtXwyXRfUrnvg+RT3PVVWx1kN1RpLSeplUAZd5Pqi39tNG?=
 =?us-ascii?Q?O3bHyMC+UJb+vpOLjV7z4nRDUec9oLjadNMPwfTWl3YwjWh4MlDlYgg+IdTg?=
 =?us-ascii?Q?PPBvXsnmBZSPo5PXBObJbRlHub1I1MTgo3AoYZSbngKl7TsxZrSrzWXG0JBj?=
 =?us-ascii?Q?h/K4Hb2GlBSIdsZ68OD618bJigTcwbp+GFVtK5AmPQN3hfkCa+LgTdT/1FqC?=
 =?us-ascii?Q?KYEBdlH853s7dWoUjc/jh8warHm5kXNk9X/NS7BryGAS+BR+fi0yDUfg7oOU?=
 =?us-ascii?Q?ep5gGkUKALZg1+qTMCUpfJORGla0l6iJ437K1TOFEVi+jsV97P/3yf27OH+m?=
 =?us-ascii?Q?+X56J3tDz4BCeH0vEzWUbNXrEQnjwC+YEd7NWJE/4JOGx8WrNBKiCS3+e9Hy?=
 =?us-ascii?Q?ja1sZgAri/qngEf6RepdZxmvNaawnD+fR1yTzEAvvrBzFh1Apsq1GY9axD7c?=
 =?us-ascii?Q?U9+8gFrDIc1OSCFl92ay4PSmB95CJ/Jwpe5RMhQPqumCXGe7CdP9zRhZYnRq?=
 =?us-ascii?Q?97Rz1+8Q+7MlZoW7azAsxkhfXlW49XWmob2P/VxJW0cYCh3OzfYvjxuL5/BO?=
 =?us-ascii?Q?31VMt+WOlkfYQMc9+4+L9hbKLzGTOkwqAEdQj4xVweQRkO7w7QpKcW0uT90w?=
 =?us-ascii?Q?JQAzpkmH/Rp9R3QTtw/De3dRO0gaod0Qn6/3NQ47BnWYbeio5Fnp/ZI6/ZB0?=
 =?us-ascii?Q?OA0TIx7LH7wczm0/CEfxEjnsdix1AcEJ3oaBAG/NBvCJBe3/X3Xzvaml5qWt?=
 =?us-ascii?Q?8N+V2qrPC4FuR9JRkUZM+3V4ZO7C20D9hL6MVFnLx8q1vp/nwUkiTYHKWOlV?=
 =?us-ascii?Q?3sUuEKAlHlM846wOmZiqwx6+jCZ40EXC2LstEJKsboL4C7AAHPzfaShTnxU8?=
 =?us-ascii?Q?tfO0+jg5CfFW/K7SW1x62MTVTEKwFrY9724DnclQrA4/hMh6LrLZUTp72xzi?=
 =?us-ascii?Q?1Lue8rVI1Vw547o5y+yjRLruRPb81c+W5m16M4fXosFQYnhwvOwMvvXyS+T5?=
 =?us-ascii?Q?APHWwGnnUMJgM77kTt1uVCoVLl4yAZLIngW6sK/KiR1iHrCb7H9sb+3r9d0c?=
 =?us-ascii?Q?5AssBW+uxVG6t1/DntXzv4NpoCxl2OTqL7ZiyvDZwTUQFPHhJjx2BH5HlAEx?=
 =?us-ascii?Q?l09VYyOzgng5mAWK/3GN2KGx4HTOh1bFM5AR03RPdGa7aUeZgaLXQhknp+5e?=
 =?us-ascii?Q?XzLnP/BE6V7RiZq+PcryD14h4sGeIE3CVpENC6ZB9OV6gs/3XurdCK/wqNg/?=
 =?us-ascii?Q?ynV5hBtj/IAVpTcvTBZILTURq3dGaN09WiU0yf/TAmcPg62O4d3wkTJypUgD?=
 =?us-ascii?Q?/kRxZD3zMiZ6PlRUjmjvjfd/HAaqfVVjQ3BJfVrgqyFEtTSzf78Y3vp7nNoM?=
 =?us-ascii?Q?pRjGaAgo/ZUaEgflnLTXCCFzrYzcu8EJD1WY6LKcdtSGH/evMQZHHbpMYfFw?=
 =?us-ascii?Q?drP+SsSUmVxg5268eW/IiuWG3s206FHAA3Gt9/jrP3+4Ivhi/aAPAroQheox?=
 =?us-ascii?Q?I3g/pq6KQA7RchQIEu9V8vE91Kw2iq5BvwZlUN8Emcwcw0beBfssPuKqEztV?=
 =?us-ascii?Q?WDg64JUva25wGVK6PTOwvERqpi0d7r6Veo2xdqld?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 630a9ded-715d-4050-e3c4-08de0d887911
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 14:21:33.2747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YFcEMrZwjziqXMOTjLgUjOYgtmAkSMiHIiMk1XFv/aBf5BiM229fQ3JWA/FlyBDPd8YBBUfpPsLk75wvxGMQHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10449

On Fri, Oct 17, 2025 at 09:56:25AM +0800, Peng Fan wrote:
> The IRQ mailbox is an optional channel and does not need to be kept until
> driver removal when an error occurs. Free the allocated memory in the
> error path.
>
> Add 'goto free_cl' when mbox_request_channel_byname() fails, to keep free
> at one place.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/firmware/imx/imx-scu-irq.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
> index f2b902e95b738fae90af9cbe54da4f488219906f..d6fd04404e2a3113a6d22b1a580e6c0ac48f5975 100644
> --- a/drivers/firmware/imx/imx-scu-irq.c
> +++ b/drivers/firmware/imx/imx-scu-irq.c
> @@ -219,8 +219,7 @@ int imx_scu_enable_general_irq_channel(struct device *dev)
>  	if (IS_ERR(ch)) {
>  		ret = PTR_ERR(ch);
>  		dev_err(dev, "failed to request mbox chan gip3, ret %d\n", ret);
> -		devm_kfree(dev, cl);
> -		return ret;
> +		goto free_cl;
>  	}
>
>  	INIT_WORK(&imx_sc_irq_work, imx_scu_irq_work_handler);
> @@ -255,6 +254,8 @@ int imx_scu_enable_general_irq_channel(struct device *dev)
>
>  free_ch:
>  	mbox_free_channel(ch);
> +free_cl:
> +	devm_kfree(dev, cl);
>
>  	return ret;
>  }
>
> --
> 2.37.1
>


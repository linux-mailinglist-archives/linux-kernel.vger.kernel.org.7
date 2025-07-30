Return-Path: <linux-kernel+bounces-751045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C726FB1648E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B4D7189930F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4752DCF46;
	Wed, 30 Jul 2025 16:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cr3pXpnh"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013019.outbound.protection.outlook.com [40.107.162.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303D32D838B;
	Wed, 30 Jul 2025 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892641; cv=fail; b=FEPdNSDyliK0jTiLegVdDKebzxcaTrvrFaumxbduGlRMHVQEIZBfXceq+UfBP1nFig2T1p2zuVK6v5rB79dM1zy3WvJerb4O3DegdF4ZvIEoIQ5cr0mSjY/su9lVoeTzsrC5ScCkre/mKCXCDhh7Q+p0+bZSdsCKVMek+w+ZL6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892641; c=relaxed/simple;
	bh=3yv1ZKYdOBm1gIs6jWQsfT5/1nyNiZ025LXlKdpfvcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OKehbb9tWmoLTKm+hwsCqlGakpYywKkvo4m09lhc+szAjzDGMUxZjmXIoOhin3Mp2WD0Ct9evBJoiORECSyOMJGEJ+DfcfDXIr3zOvzJKTrHDNXhPiqNbpYL7QI58Ld6lCimRWLMRnqBpaCGdneKejMhrOgAAx6F3hGOYCRCdyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Cr3pXpnh; arc=fail smtp.client-ip=40.107.162.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rowFoOqPrKygV/DQIUXzjBsuP8cmIpSUhfepMFjzcmnmrG0Y5VprPJvGHDQzrEl5qgnPfo6SE5RvLD3lIe8Hl01LKuYva/fVI71hASYccfA/EXXu4MBIk9YwylrsFLWEeK90crFARWsF2vdqPzyLJ+dkW2/fzc96xKcZ8cMOYNudBdZGjd2EHR3XMvCE1IXubzteY2byCR2lB+9NiuanBLmBOMfuO47c245CDho7jacdMdb85okbvlxEFsK5pvdyZqY9Ur2d9PPmjxUB/pVHVw+mPBobIec9Bj14/1AAP2HPsbcB1RAT7rQ60fK/ecS2p32yVQPnnMQQ/mgk1yAxnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TaVxcVJR8Iow8EXX7p0XNMJQZeeb4WZVCs7MtifldY=;
 b=UEzB7D5XAVBde+ptgKnlnDxy/oKd5ze/UYZwnCIGKo2IIDivUWGfSpMwxZClLUCBpHlTMXa1p+yCE2LHqcJWDeVs4KbDPSlbyn8sZjymFBTbO2Zk8HurdHOhu3ghjWU2/KjI1N+UIfQE1g2ygDjsZZZQK+VqC+UrjS2zFe0hyocR8ZEsB9VPdpzGDZjX8NG1zIZYfixNF3RmhwnrwQfMYz/S+U+wbY8fVJ2dZ67J6+7RP0FRiTfLXfm1aVb6CdeHN76TAwllfP6JtDsAtKbcHXsVx6JV8BrWI9rFujeQHKNASghlUz0ekjOMOqcZ7+kzDhbM1E921VbJWQxbjXLI4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TaVxcVJR8Iow8EXX7p0XNMJQZeeb4WZVCs7MtifldY=;
 b=Cr3pXpnhvsvZVHUyz+KB/uaXgx85x2/hR+ezPHVW4vJTPDymnvKg9kkccp5L6RxQop2vhGwUWkT9bd0raOyr4YNdryE9f/nNFLYC7DwDeCUQA/NrMgD97d4uVQP4T9NQc/9MpIM1c91UlM4rVv1IycmxfP9H6X4Brq+oK4L+5BWJIu0zanngaDvRkmVAUlbwfimHb18i5bsBSfExxC/iA2fA4lveHjkHSZvATibE/+KY5fm4M8+ztrcb03zg0YTqXCbEF93Fb/p3h5Pc6nxZj1qzjPzc4Q4970NBE280kMj73HjL7yZ8rOdMjH5yDuS6TXZxCAvU/sj8P4LY8N4jxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS8PR04MB9094.eurprd04.prod.outlook.com (2603:10a6:20b:445::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Wed, 30 Jul
 2025 16:23:56 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 16:23:56 +0000
Date: Wed, 30 Jul 2025 12:23:46 -0400
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
Subject: Re: [PATCH 2/2] clk: imx95-blk-ctl: Save/restore registers when RPM
 routines are called
Message-ID: <aIpHEugNppI2C0/q@lizhi-Precision-Tower-5810>
References: <20250730125932.357379-1-laurentiu.palcu@oss.nxp.com>
 <20250730125932.357379-3-laurentiu.palcu@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730125932.357379-3-laurentiu.palcu@oss.nxp.com>
X-ClientProxiedBy: PH8PR15CA0020.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS8PR04MB9094:EE_
X-MS-Office365-Filtering-Correlation-Id: 45cee3d5-dfc3-4c9e-42e2-08ddcf857ad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|19092799006|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7PMEIv2jU0kIy0roTIvFmVT7WEtRer9bmFse1ZxWbZk9tSYMU++JeOsT+jqI?=
 =?us-ascii?Q?ASdGJfEMVM+XUjBCw3PVTsC9fI6cNeAglxfKst5gaIJucCqgSnr9BU+Zb4nP?=
 =?us-ascii?Q?oKkPNKTu1G1UgNboG2KdlG+AfFf3E3FDZcqolgvQCgvOtKCn8eiQ50NF1aKO?=
 =?us-ascii?Q?Sh0yNPdJx1EG6GIaBgGFm8Q0h2wR1qqzl5KSi1mFek8gtQqGWOfzicABvBWA?=
 =?us-ascii?Q?OC4lqgqSRQmG6nd93NBW3k0x/QdNgvUSivGNszrOeL9PuqXjsUB2dLXMNXG0?=
 =?us-ascii?Q?NrHHPQVkxeXCc4HLteqleiMiTK3KyEPmGQvJrej+9BQFxoodhI7oVD859M5x?=
 =?us-ascii?Q?ASBlhyBXgyZ333qnvfD4x4JE9BW3bA2wnrjEilHTzGeaCtIjcgO2OCSFNNfa?=
 =?us-ascii?Q?ZmuQX9UCpx+VQLSdqBE+OWlG6zPxofy4VceUmRURzaaDAL+IaPrbcbB774WO?=
 =?us-ascii?Q?Dhc1rup7RjWqGPX7wc0s1FwFvyFh3Mjx9PcrNK38w95dQLgS/iXXrqDXWyur?=
 =?us-ascii?Q?yPvJq0zEW3snW+ZeabOZE/YLokGRXvyxhn3Qo3zRhzwLv6PXXtDotNyZx1r1?=
 =?us-ascii?Q?bUtF+WRuUmBf7m1rBFXrzZ2eef31x0yegbt74uY+9FQPoalj5G9on8edREBl?=
 =?us-ascii?Q?dnwUen0lk/RdR7aKhvsuDpbOVF9Ysr6hAnwq2Iy3XUh4iUHbzSwBXvFbWPtz?=
 =?us-ascii?Q?i4S4qMkp9MGMjIzM5//UIb/zCWh66Cjfs2X1rxuRJjEylCygLwny9MxPGTN5?=
 =?us-ascii?Q?gCx6o6yvQe9OeFrlnBHb4Vd4bDSDquh1Eif9R11AOXlkndSj1op29KzsMuIE?=
 =?us-ascii?Q?Gp7BYylqX8T35EYYFuD/NlFc9tFAIZ4uLaBZc5i2f9GvUuepwxymGI7uzAOX?=
 =?us-ascii?Q?B2pyT9ihHGTbpkmDznPPrld/JNruYn3KSyrlhNCuKdCX9Qp3RmISk017soZN?=
 =?us-ascii?Q?iHJgpkJE1arcrFnqVjprMfVR1h8G2hvGg0o3ua5lxDJTUYClQXpKYieTQjTQ?=
 =?us-ascii?Q?wQ5u5AN9Bsgtm2XD+2BUQ9YmyMJWx5JCiBBblaOeKsojE+UWno/IQLEzkvli?=
 =?us-ascii?Q?W2X4LcXtW9tGTl+o3IuCWjD00VLwiAgl3ZP2eDZ2a9EvGxsc8Inl+3IEsYrY?=
 =?us-ascii?Q?aa9gyMbuYP/vY3mKPGeiSE6EDVRiTDygpqv20yeHupn3ZySTXRyuR5DhBZKq?=
 =?us-ascii?Q?2j4bdyLN2s6QV9YpVM4OiwVpW5gXXlYUR/HYjgSucRSKLiA+IprquL+QyB3t?=
 =?us-ascii?Q?G0F1jqTcwfUjvRbkYY//Xjo+Y46bHJEJTjsZ6H2jMR01SV8aXSn/xiOCb6Sz?=
 =?us-ascii?Q?KQQQk+va3lIPEBhY3xXUj6yjfrQ4JRQXmsmzeZQcl+cc+e1vryD0H2fsZYd5?=
 =?us-ascii?Q?Te0FVcp14hpg5ti0Lkdf901pi8cEuOPLgQrceJN3gNaFXBbbNJvlLu3BTq3u?=
 =?us-ascii?Q?ZEczLr3eRRz+AhCQPIZDQaIlgG47LGI6TQy/HsF7aREpBk4moD5HuWPzuHTY?=
 =?us-ascii?Q?PIV6njoa4ZsOcTY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dnIBMj1bq+JyLpiD+p8olJmPeQodxsFhQE7+6kojVm40d9ctkf6W7rzULDBi?=
 =?us-ascii?Q?vHXoayqD2d976MjYrGCsYi8GIah5thiqh4Uw3Z3xu2gq7E8CA2qF4humIQAb?=
 =?us-ascii?Q?cm0RcHKaPce1xDCsK4hjDUyJPzlelTLj40TsX6RYmDX1e4wsaUV/Pnan443v?=
 =?us-ascii?Q?T8yn96OCBDsxYrEm8SfC6GjNpRtb1kHiiQLqeqK4s1xvbOp8NkZJ01juP6Vb?=
 =?us-ascii?Q?TSc5qZk4VuT2R3YOHb4guiwy2bLcLGvtISjQpdp5FqsHa/JNvQnOpr7hs2sj?=
 =?us-ascii?Q?Pl2o+6Est+uGaXnDv89svLVT9FZx2mjFU27INoq9qh2Rpx8jYOJ/DJPqjxgA?=
 =?us-ascii?Q?DShon0i7erryPpgAt4lpjJn0LSxNR55ckCrZgBYVYYZtGiyHZ6406ubNQ3aF?=
 =?us-ascii?Q?bCgjI4OyNKifXRy4fMAECOelRZe3hzC3aa8JTVRV9u+x4VTTESOidtUZUBMs?=
 =?us-ascii?Q?FdWOEwNC8p1YjA8lbhzLWFkust2RlxWhs+BV5M5mldS6gAXKuD5jqnb28RZ5?=
 =?us-ascii?Q?hk1jrF6JPk1aXoAvcprTQ6bFJiApQGTY8I+nUJmW6I2qWAJUR1irv2azwwM9?=
 =?us-ascii?Q?G15g0cQEY5cKa0Y2yhsto8n/Ot8tjqnIbh+GVGIDSstJT1Dk204hulroCvlv?=
 =?us-ascii?Q?sxMWwnxaATnJAppfodrpKn8/WJ1sQGACKzovfFYB3Qpkh5BcidaNvjt4kta9?=
 =?us-ascii?Q?VC7rZx/lVN1RbeB9qk6jrACWu4/0ltQ5FhgJePvlPBx8NND3WoShkBbZ6yS6?=
 =?us-ascii?Q?b4rbfdDvnAZ40XuRU5klK76hVK6laUYVvjpv18kr4P/lRd0MAJ5nPlw1OJZ1?=
 =?us-ascii?Q?v5vor0MU9gl5jfcRlfaspOYKwd8WiP57ul+SPsKD8RmEQ/jctOdwbzoRYSrA?=
 =?us-ascii?Q?jfOiWhgSJNSQZxngLIMQP1qtp0NaMwhEtlZ+4y9piU5jsdL3Hjid6eDvBVss?=
 =?us-ascii?Q?/EKF5LR4RNvkAwbSiEwbKr/6qwGYvH9paoZ9zVR+zNx+ztcHWq2/zKIahstb?=
 =?us-ascii?Q?tSf/mokGqV1hqnOzRS2yBS9/1KBTwXJJ5UET66uywSDNv34HNrVZ3CIYkFAL?=
 =?us-ascii?Q?HEFehTJQS9gZpAIDaPEBH/OZG/LynKNxFUtOmLyOYFo4XJwEOvm6fwntuXKB?=
 =?us-ascii?Q?4XYsU7sYhUupOPn94pbL2LMUvezqCHV624Sv5C/Pm61vvr8OugwCPBlkf/hw?=
 =?us-ascii?Q?N+GNP6bymgcIzuSIPuQB8haSVJJDqjw81WhyMFmgG3Q6uh/gPRbADOaJzchB?=
 =?us-ascii?Q?JAzpdpI6TnwL+1+UHgAyPIM29jlXfxe+Dz8Moik+wP3hGLd04/d4yFRBZv+w?=
 =?us-ascii?Q?xM4m/pQW7itQve8CYbXvL+gzzg8ct1Lb2rZELMzHdS6SAh9y+XA2Fu7JakJD?=
 =?us-ascii?Q?0Gc6fTLpPOSvB4/a5apBnvUjx9zJxv46uR4FYL+FCMnt8j8m/5vaEV22MRp3?=
 =?us-ascii?Q?f7RRJtjMrpJrSbl0qBnRz8ug6jAWr/9WEWprYRV+OMwhzqhLMrSvgNxz/oXJ?=
 =?us-ascii?Q?V9/vc/kvCXfh7nJsmGWD0WYUqWNCSVD4ZuGRfI2H+Yms4Mdc6RtEtnLImrR/?=
 =?us-ascii?Q?mNEPq9NWB7jVlRILQ60=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45cee3d5-dfc3-4c9e-42e2-08ddcf857ad8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 16:23:56.2922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3YFlYovCMBLjpikfM4UUZW6S5KJwfu2R4KkTrcl+TdI4kIdTYPWvtXtJ9QWZzF6DkFI0a2sVONmO8QFDZ7FzQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9094

On Wed, Jul 30, 2025 at 03:59:31PM +0300, Laurentiu Palcu wrote:
> If runtime PM is used for the clock providers and they're part of a
> power domain, then the power domain supply will be cut off when runtime
> suspended. That means all BLK CTL registers belonging to that power
> domain will be reset. Save the registers, then, before entering suspend
> and restore them in resume.

Save the registers before entering suspend, then restore them in resume.

>
> Also, fix the suspend/resume routines and make sure we disable/enable
> the clock correctly.

Check runtime pm status in suspend/resume routines to make sure
disable/enable clock correctly.

>
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
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
> 2.46.1
>


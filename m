Return-Path: <linux-kernel+bounces-821301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE00B80EDC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B0E1C810F8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C192F83B6;
	Wed, 17 Sep 2025 16:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f/yEwBKP"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012019.outbound.protection.outlook.com [52.101.66.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558CE2F7ADB;
	Wed, 17 Sep 2025 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758125314; cv=fail; b=mIwmvT3m28LfGmtYuYfUZxG/ygIYS5fkzI8iLy4SJLFwaSXmij6NPv2VOrH3267RsQAewqs8ygATnlriiCtGxb8YNTR5D5NskoTa7RUx6mKXTP0NcwRVx85u7Se7MUQbBp+ch/HAy/WjSxqWvrOFZrQFcB7YICX8GwciJKoCAq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758125314; c=relaxed/simple;
	bh=sxgNyeJE98rkzUI7HPALnu6ipiA+b2QG3pKjawIRhp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BU5BT7Vr58ATipQDHih9h0/Zc6RI4KpLPyIaupl9sQYMXqHW1V/zbjPYrJxOb7waB7H8vLwOD40IBeDjc+pg5OGdWt+39J4PWfAQJbHj8P+LaHHaZgNiLUgr/52pXeD9nsGdLair89CgzJJDayIvbsCrvi4VK2bazvh6KWIeeT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f/yEwBKP reason="signature verification failed"; arc=fail smtp.client-ip=52.101.66.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xn7KG3APZwZ32Pz0t6eZOZDHaISPTTy/F/J7GCZmPgce+xzK4XpVlWhHG1/Ip7AwO8SuUwnTfb9ttqSKwH7sc8orDYpCOeGqWTetuLqphBd959vh3DzUDDGOzaahCVWjsjtJJJMft4tiXMxbz17SOgPpptMDqEfuh7yY4h10LoaGZwj6WFZEmiLmn52DMEw4x5NzrGsL/dO9U58t34B6xUpx79RnJlF7L5a/IsJj+5h0FdDNFBCIzbz32cwulhkVDJEJElMsUNE35FAleQZ/r1uxv9n0Okb4x2SaKrLuicdZiHsOc/+UWlt7PtsHgK7TRAed5bo7rzaxWd0zoxmjHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/U0oS60Y/VBQIA9hce3xs3gvCecqgZ9yiqK6ZLtq1Y=;
 b=VcfHHUSfsAU6KuAnkiC6txqT2yIRk2ocMeX3yVjcAURcFyUZ6SlAgLlZAOASQsFA9gt+C4kBAi+xwhw2gaU2Iy9hkFG5yip2R6cX3Rcpi18wbcBl49ZH19y3isfF8LBgrAzlEXd2lBnwpGesEHtJCzWNl3dNevpXTD/gBSQ1kBjd0VZhHULvY5VqGosfs8fU6XI0Nknezk+VfiPhj3PpCnUQ0S23ZZgkGv70hjnk0nH3w7SOQRmOdsYmub9IxzoMmhDHOGjT8qrQS9z/Cu2sdqFw04kehy3aKHffvySlfg5xgU+hA9rV2uGZiNcL6Vls/ApLsPEzj8vDqr87iuDI5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/U0oS60Y/VBQIA9hce3xs3gvCecqgZ9yiqK6ZLtq1Y=;
 b=f/yEwBKP9jvWYnAKZQ8igi6Q2RDNsTcUNtUSEVf9vgXp4U0XSAJvYtWdOPq6F38yG2fgQatgx0YBqplyNSZNGxntPs27fPcn0e2uGLbwcMRNwYxGa6GxsadnuaU8sWXy3vmTSwvg3Nwpn2/XgUHYL8ivM/zKeylMJ/86P6hUeSW3LE20WFALKoQ8bIFsm94AAeuafHI8EVAjmZ9x1TWE9RRVsh6VnfKstg9fdbbZIIn6PlVV6Ek2HThFahTZQmKQlfCl2Q5/EBtH4WZ1PgfOarKsBW3mvC7AP6y5sj/tzIXu7+xwUDT5Clp1XPkwZqPng4URJ/J+eNgEmiBvIFdWKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI1PR04MB7038.eurprd04.prod.outlook.com (2603:10a6:800:12d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 16:08:29 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 16:08:29 +0000
Date: Wed, 17 Sep 2025 12:08:21 -0400
From: Frank Li <Frank.li@nxp.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 5/6] ARM: dts: imx6ull-engicam-microgea-bmm: set
 touchscreen glitch threshold
Message-ID: <aMrc9Z/SNYspPo1l@lizhi-Precision-Tower-5810>
References: <20250917080534.1772202-1-dario.binacchi@amarulasolutions.com>
 <20250917080534.1772202-6-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250917080534.1772202-6-dario.binacchi@amarulasolutions.com>
X-ClientProxiedBy: BY3PR10CA0011.namprd10.prod.outlook.com
 (2603:10b6:a03:255::16) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI1PR04MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: c84d70b9-eb03-45e1-4441-08ddf6047128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|7416014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?1GhvYiPH2fkbtZ7eLW3NMW7Ti59MV+0lcytHZDkAOPMJX2VzePln2aNyLY?=
 =?iso-8859-1?Q?Pf/eMuUvEVGaqaAFVrTKde6dBGFEW8/nnUaA2p9Sa5LW5QXSmbRv7M8+Ry?=
 =?iso-8859-1?Q?t5PkENlBsHYWsoV+wgso/+YLFctJpVY5WwtLYXR2XXq8jJ7/5MfEXttpR2?=
 =?iso-8859-1?Q?3z0D4RMGwdo4lK3ILZOOnObhGRIeaS12eZyLd3V0zEwbsMyi+PDRphVrMQ?=
 =?iso-8859-1?Q?waCsJESz2yicTrrh5X6e9rnr0TKy1ks6lGxBtOGj0TgRBs+L73oyArJP96?=
 =?iso-8859-1?Q?HPXL4KOfe4XpFqTT54DTjJ7+Je+g32/ITnyjSXNceuLkcpWeF0Id0sYbsj?=
 =?iso-8859-1?Q?28Z9CxJ4TLKX9+3M2I5FIVtldhNpM+uZRbRvewNhajdoI5UF1dfvUzfAGY?=
 =?iso-8859-1?Q?lNiA2/eAqdNBB5zDx0pTAwveOxICe1341IvPbPNmZsryyvn1KKzAU6v70W?=
 =?iso-8859-1?Q?2TT0uqUV4UQDFVL4FSccqyHGL3TVb/UpRhCFdxryLeN6VJ727YaPyeG1po?=
 =?iso-8859-1?Q?Oi/XHCfLKTNm4Q4Gcv11v1QSpQZQ2tjvBhgSkAri7aEdky/QfqnrixNWY8?=
 =?iso-8859-1?Q?YEmU/YZxusA/DfsdLHqmAEiii5WnmqWcDqFH3Y4WBUM8zPFrKe0jks1VKk?=
 =?iso-8859-1?Q?f4QNvBtNALtpPYRVn7/M/jhp8YHMdFcLw5GHNgRoMhxQHRgcZBnrD5PgW7?=
 =?iso-8859-1?Q?tmFaQyCBosXYOPw4AZONXxVQMlbtstN3LlsDA4dpp8ifEubDR7Bh51PPld?=
 =?iso-8859-1?Q?PfawQ8YfKMHySin7ZcYIve3RTsP4y5E9jcHKjCxJ4M5QPwPmHMI96x2bSw?=
 =?iso-8859-1?Q?ayye1UG3WSKAaFAgbNH8jzQ+YnFkq4YzhKqJeyhvRGvL2pZYl4tB4o9Go8?=
 =?iso-8859-1?Q?GeaHuXPFoLAI+0FSSvxmmSYitDXIYFYUvib9aGsBjgCLXBzSr2TE2yiMau?=
 =?iso-8859-1?Q?uINt62GRLaiF3t6H9WxD27y1vByzcSkujbeLMHPA/vqlGPWLrIxIrgO3jD?=
 =?iso-8859-1?Q?Ax6/Aam9nw+0wQtq4/xOkvzfYFAr4pYWmSQwkAuMKaPP3ciJiuvqjS+SHk?=
 =?iso-8859-1?Q?xN9MC37xwPHufTs1+0p/rshJysE5vT7aEfUauf3bQp25lG7a/7vQjKVX6A?=
 =?iso-8859-1?Q?GH30G5hdrcKwlP+qlO7MkEVZKX0+7MpJNYarYu02Tjjh19+zG31+yG7ym9?=
 =?iso-8859-1?Q?O1/by7QfnwSf7F9BJzMXbtbo0/rg65jnOFn4Kt8UMvvPSrPk0Oxzns60YI?=
 =?iso-8859-1?Q?6nJIqpXGSsMztx/7m4YeutkqpUNb2Hb4Li/rzWdjF9ceFHpZoAbvrhekQc?=
 =?iso-8859-1?Q?VxDc391ny957u/x+6bPJ0v6fy5+StlhAVUqf2gclgeWql7a6aOEIp2x49S?=
 =?iso-8859-1?Q?M0bImtLppOSpviiiUPfSZ78rypDkLk6c5dL+hhMOXH9D/7Dalglv4LelmA?=
 =?iso-8859-1?Q?pHYOyQWh7oT0Li6jkEvEmPEaYBhmo0clzl58b2+yd/ePr3ME2T36VlWtDF?=
 =?iso-8859-1?Q?G9GILu2Kbe+et/FrM/JfNnPdZYs/hAd4LlUGTPobsJoA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7416014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?YhwrIJpt0ED999UeZBIIxJMQOfBs0Awk5sPC93T59g/LS4zAGRVJdCjlX/?=
 =?iso-8859-1?Q?ccuaFTe0s2DAj+oOHW+p6nzekAgDKmy4QIygzzR0zcD+qeu5VdFu3puZIg?=
 =?iso-8859-1?Q?7choLmYqhHHbR4vd/BzeC1XBp2/KfWB6A+7R6Yk3CWvBEUwocWPY0xOG6i?=
 =?iso-8859-1?Q?iDnpTajBofV43UZn0eAbkhEBqK1oorWqH7JK1Op0algYnMm/av7AI9UHtW?=
 =?iso-8859-1?Q?jG1YiHa7FDtEg5UNbhf2B07CtDBd5vUheHQ7oWKlcJS9YDcNfhfn5nTX0r?=
 =?iso-8859-1?Q?sDsWReSP2NmwKgxnTgX2aHyiKo4FGzSvi3QESOf+yW6zbvxWWfXu/gkSdH?=
 =?iso-8859-1?Q?yvqbpsfi/F/o4lbrAP5an4CQFcHu9C17huQKrUrhSKstcBbkXFDsLDvd0x?=
 =?iso-8859-1?Q?nK9SOB56dfLsMVKK/2o/KZbgNCrTC/HcRe1Wmw4YucW9Nk5tKaFQqDpiUC?=
 =?iso-8859-1?Q?kR0p/SKSYYd6uxbWXc6gcqtxsqKNBgw18LDL1pclv6Qs7F3NxDvb37fHX5?=
 =?iso-8859-1?Q?OQdjcQoOLARkeqOTyHz3q3xzJtjRfCRJ6vo+rZ7WzSWEmq8vegimPghcsd?=
 =?iso-8859-1?Q?G8Y0GDriWZ1BDYJlHb2WQjEngJCsAvLJ2Vh7v8vifwroslgCr4rpBhRSET?=
 =?iso-8859-1?Q?QIHeY2ZK9DrIENb5ohmBIVtB7I45WsPJ8JncHvrknh2Rp9iKQzpI5gFKIX?=
 =?iso-8859-1?Q?xxLF0vD5gWQHFrMNGw5J3YmYgvgrbK+8R4I8G/DxRcIlrD9VdtHc2/3j9R?=
 =?iso-8859-1?Q?F/J52ohdu8EzTyNY50WoYyEyFxi5QUkK+68eYqManSlXJ9CLuHhe4KU21w?=
 =?iso-8859-1?Q?Dp7vCIu9vhyNe36LddegDQkliMuy5Wat9nwgcFm2/3A8zE4paOrG/9tD56?=
 =?iso-8859-1?Q?FwwW7gD2lRYnvWviyE0eTjCKOC80DKot4cC/0F89UqqgmnjMBd9tyCo6al?=
 =?iso-8859-1?Q?7StwaeeE+n3Vb2q+QHh0B/7tF3lpDrJmeR8VyA0qnGtQbgI5pKCw32ZL/X?=
 =?iso-8859-1?Q?NHoSmYLnLhIbHlhtBt+w/R+C1amExpJqfHRhrZ7qLfu8hBJ+Xxor7O5uJg?=
 =?iso-8859-1?Q?zaffsReAnQt8W9tEUaC2yKkxRBnpZv63tVsW7UuGA6XyN9esx+3gxLjHv8?=
 =?iso-8859-1?Q?GMtpcPC1+8MJWscNXVOxW/CHy5Z778uPlQYujAKFLORf+90wfVoqh28lgY?=
 =?iso-8859-1?Q?UCklFdbI0qs1XW/VXqoRh2uYTD1WE9y11pxxaqCFBT+ibaP4Fia40LOliJ?=
 =?iso-8859-1?Q?sqZLwFVWG0xqxndxHovc6sw53NBptc2sqhC+PAes4nfRFAKQ/QWci68doT?=
 =?iso-8859-1?Q?U/cvdVMkth0aOC4Jrs7gubk3hZ3B3p2S517QQ5jHwSLjURMIY4jG05WmjH?=
 =?iso-8859-1?Q?DGKaRHYuu8Q3+d//6JbfBaO0yTEITxqkLnNW0l/r2OQF5xAWOqDmNrku7X?=
 =?iso-8859-1?Q?F9PIXRHPIJ3usxVKUbKt12xRLeOjb2LW68s/4fbtRKebQfuKlho9wbJnQL?=
 =?iso-8859-1?Q?6gexHVH5Y8XEWvzUQYeyZJHo4nZEhAV/V1RqGKwq+26ppCjCmQSwXOr569?=
 =?iso-8859-1?Q?U3dLJS0SSANeVU5stmb1i/UlPx0cGgyaFF9KkrgK2/E1Tm0IuTpokTWrv3?=
 =?iso-8859-1?Q?arzhhsve40ajtgcKqsNyNjYC46uigOw4Lh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c84d70b9-eb03-45e1-4441-08ddf6047128
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 16:08:29.6330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VuuqCqSQTC1uJuuGqZMGFRrFp5m2jrQ0cCjwSl5Ad2/N+137iAZ9mO4MfV2W0tAfIRgKx0w/KxPfcPd5fpJfcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7038

On Wed, Sep 17, 2025 at 10:05:10AM +0200, Dario Binacchi wrote:
> This way the detected signal is valid only if it lasts longer than
> 62 µs, otherwise it is not sampled.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>
> (no changes since v1)
>
>  arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-bmm.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-bmm.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-bmm.dts
> index 279d46c22cd7..f12084d8f2a0 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-bmm.dts
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-bmm.dts
> @@ -154,6 +154,7 @@ &tsc {
>  	pinctrl-0 = <&pinctrl_tsc>;
>  	measure-delay-time = <0x9ffff>;
>  	pre-charge-time = <0xfff>;
> +	touchscreen-glitch-threshold-ns = <62000>;
>  	xnur-gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
>  	status = "okay";
>  };
> --
> 2.43.0
>


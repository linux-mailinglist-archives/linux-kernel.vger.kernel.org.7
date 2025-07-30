Return-Path: <linux-kernel+bounces-751310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C975B16787
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 713FE3B074B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49BD204C3B;
	Wed, 30 Jul 2025 20:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dLrl8oPo"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012057.outbound.protection.outlook.com [52.101.66.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0061F1FDE3D;
	Wed, 30 Jul 2025 20:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753906799; cv=fail; b=NVCPwcMcsxp75JT2nyHhtt89oeiExyyG03+Db8U1W4ycHYJgQCOx02+uhmqzXmWMgrwpOvQV3DdgjIa1Xsrz6e0UIWIcLODctm6IZAujUD6rf9+R7EKv7Fq85KCnxAxf1jZQXC3f/cpEp9X6qy3xy4Em3kaiKyAsA7gAULOoCmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753906799; c=relaxed/simple;
	bh=qwzerQhis512TLJLYGBLdEXcohHbn/IKpWBr2fcQWAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R9tRvFZsCFZGkZMBqEr/sWjlT+5ukmNcoTASFyUJz+3ys7cCQ3SNaC8MF5YK8u4jG4Su9M/wxapq1uELMYEsZJwGHfSCc+SMsIWv0qaxSmUjZVN8QpkYYN/lxovyoAHbbBEDiqNSjl8nblGDQkCB8A+NNCsvKAd3whdikeRHKr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dLrl8oPo; arc=fail smtp.client-ip=52.101.66.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmLkH70Q4JBfViJqwanBl/Wqqp2W+eB2RA3D7j0Qa/eG7ql2Jqf0e+3ARnIj0+LkaGZFIMWSnkyMlGKdR59+DnwPFHyqfTaShPu0M9PgZRQWps+XiDtIVd9ULLN9O0QZyUVuu3KaesM9BNrdwaFpS7/6UiBMb+OfTfM63UGKiXwMCnxweYoynVGRqynLxrbWoNuQdAnndTRp2z9cYXIcTpZzJ7o3LmjM0YBfDKVs9lkk0GecV8AHOx6ZohmnjTrhU9QBLcWJ28x+MTDeWe23DzosrbRDqwtcJUvZdFcz0ln8/N+UCUHsYlB+qgZS09qKwdSWF9NUomFEh7L7VlR/qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNXUjfiWUk5jPT/LYCr6zDN9IaC1DNhajp+YyhRU6h8=;
 b=Qg+a0ePWQDZ2SM/3O2jiwkMXBU1Tl5F3/8hl6OJrNCj/Jgc1rn/2bpfEFuuTzNfhfp+I4WOnxZ3EoIATb/XufNkE73i5JfARN9XX77RxRjhYuwX5YD2ZUFdU5EefvB4JSFXZSGuJE9GAjfhykpQgmTe0OdKIyQrx6Wu3ePJ4jp+q+f5omcswC8+enTWTwkpnq+Dpy+r++3nNoplk54ybmapR7v+Owuuyeqb9Wmf3/jbicn33kOUGPkjea77ehAXKN53e8+E17T19xsVx3kHw4FsHhKstYrcxfjf5M5Z7dCGquJmHhWTmAB+Ad1b1V4PgIo5mTX+3Qt/KmV9YZqTBFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNXUjfiWUk5jPT/LYCr6zDN9IaC1DNhajp+YyhRU6h8=;
 b=dLrl8oPoUj8AKus8cVof10QIq5tEqFj6AKtONUeCUFtpLPZ1Voes/e1bz83zt+Mzoh6Ag+CrKICBtXzv52ZCNgTJtsJ44Gg6M0N4lapk4LL6kY1+IqcuYCoftVy5aR32rDnfZGAiSLUA+Ycl4oepnya3dnKH/XsYdV2J00mylNGaQk8gVbGo8CUzowSiXRrgacUisbWkTYJf4tbQdNi5lMhypkNzjrobacfYDS7bdDxDN/Xgu+9qCGXR2UHyAiLOmD1+V6N1sCKFhZ76fTS6wbI7BWc6go35ZuKiD07wWK/HIlVBtk4KefbhkLv0fnjdbnZbXxEWyLoWB4Dpea3Aig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB11056.eurprd04.prod.outlook.com (2603:10a6:10:58c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Wed, 30 Jul
 2025 20:19:51 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8989.011; Wed, 30 Jul 2025
 20:19:51 +0000
Date: Wed, 30 Jul 2025 16:19:41 -0400
From: Frank Li <Frank.li@nxp.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: mbrugger@suse.com, chester62515@gmail.com,
	ghennadi.procopciuc@oss.nxp.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, s32@nxp.com, kernel@pengutronix.de,
	festevam@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Thomas Fossati <thomas.fossati@linaro.org>
Subject: Re: [PATCH 1/8] arm64: dts: s32g2: Add the STM description
Message-ID: <aIp+XTCSpNGee2qx@lizhi-Precision-Tower-5810>
References: <20250730195022.449894-1-daniel.lezcano@linaro.org>
 <20250730195022.449894-2-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730195022.449894-2-daniel.lezcano@linaro.org>
X-ClientProxiedBy: SJ0PR05CA0116.namprd05.prod.outlook.com
 (2603:10b6:a03:334::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB11056:EE_
X-MS-Office365-Filtering-Correlation-Id: c49fc7d5-8f66-44ec-d605-08ddcfa67005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YSV6V3LBCiWyZ7Pb0glCmAnmUcC395rmR+/q04Ya3gTn+k1GVClDiIcNfCUY?=
 =?us-ascii?Q?bBH+GXUk/NZmZb7frFQfftaHdEvyoNatgUX6ML+EbNMb1l/oDY1xGKLGFoFs?=
 =?us-ascii?Q?pWfBvlexuRFEzTSLPCB+L3QgIYzwbq1nScF/qSqG+6121cAkub4x/96d3AiW?=
 =?us-ascii?Q?r3fmXd9va4y1vJoUoSjOdK3awgEOr7R6SE22rrTRRqiEjLrS/f8/agsyCrJN?=
 =?us-ascii?Q?4YDr4/pxxeutWWA/Wd/qE8RzwQh2OTAM8ENY/kP/v20fim3anXj7jmYTWsWp?=
 =?us-ascii?Q?jVftC3dgFzlgnt3D+mmIxUk4rnku8wT3vlpoobWNsxFUS6M97YrFOsEShPiJ?=
 =?us-ascii?Q?kzgXEqj8od4kAMfV3ylkGE2Pgap0wTeh1pIbJFEmUvNhnJiId9j/ceqeGAXC?=
 =?us-ascii?Q?AaHfIRtZ0nEsrg6K4VMQfioeTmiJRuJR6sWB7gjfpakf7lwwhNGeEjoAIlJD?=
 =?us-ascii?Q?kMy9mgi7dZUe/WldJ05SGwSB9WRJ29cAtCfUbddrXofDKFpi2NztgEzscBJK?=
 =?us-ascii?Q?rNagRcYWiyzf+V4bM+qdXVF+bqDPRuL2WjWuItVoYKxoyLTsPNWtWqpzrmEy?=
 =?us-ascii?Q?W9daWfrQYAvrianI6QjWJ/VTYXwybJlXErEmtLhjb/117h9mmzJ7fNUIVLxe?=
 =?us-ascii?Q?91ihdqPlNGLt7CBU7RaX/3BaCY/c+sASChfYb0FRF2F1Dye5uuXrXOrRLzmg?=
 =?us-ascii?Q?BOcol2yxwDr9v4rTw6VXTY+R3NVayss+ZX+WATnhYdAGGG02o47YCIROViLd?=
 =?us-ascii?Q?6NoKsbdZMPizh0GW5iJW1HATD8+tKrUJrMaadfUv8/hojix3avl/3XQWEacw?=
 =?us-ascii?Q?lxtweNli/evpFcjB3qPrrDiCY31xAMzvjrbGb9KLtMszgYDSS1RMqOWSitZA?=
 =?us-ascii?Q?3wKdwRDIU3txxuRAyBQF1Bu90noJOiPrX127GO53qLT8iP2avYSP9MKI6wB0?=
 =?us-ascii?Q?DzzmlyH6UjkKJ4HPMHnaIWkjN/RQkT9mUgfw5E3tMNsohQZqvNE8myxTriyq?=
 =?us-ascii?Q?48EUbUAxnphdM1nkjmbqBnUsIYlVAUr2iK2tzSx5iudQELwoIeB1RtHj76Af?=
 =?us-ascii?Q?uVq6KJPyRtezbjdfxNDw+cO+vw3yasCql+uovmtqcY8QzC2ubQtfv0/M4CW6?=
 =?us-ascii?Q?B7sAU5TV/8qdgpxmmbM/Bgn1T6R57cbv5zr2CAjAPY4y4zx8dWM8VyK+N4VL?=
 =?us-ascii?Q?8zfUMpmRVlNKzPf29QeWgMZNHtMej9vrPUIHCRdCsVsVKpTb41r8k5+0Lg3j?=
 =?us-ascii?Q?eVlwV9HjAl8nQd0q+OG0CnPgLrP79dIFjg+1T0h5Ri6U8QvejogChkPqFAOP?=
 =?us-ascii?Q?lprgYCgxHZ71luox8dJet4d8WXjayeosoCzKfEr7qsdl3pxdTK/gd/uTXSOA?=
 =?us-ascii?Q?90EJRTtN6JWNoLg7d/HUh8g2erZwl/H1imAkx74fRsg5D8t/3M5gLdjiN39D?=
 =?us-ascii?Q?gVxZBhkgrbxp0jZ2PFuH9AIzO37RqcVjP/m+rNrUb2EWxzNvEoPFxA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lI1Y7V1PWNE3cZIyZMr+mGSlzujqBp1qQZvOE4UFthVtVsQT6W84RQB+b9P7?=
 =?us-ascii?Q?7T3nf5N2f1/0FrJgheaVS01/bNgnElqjL1uy+1I2vnu23sOVTKmbvjeL5fhP?=
 =?us-ascii?Q?cuTvh0GCeP7K1x14pZuPnM2n7Ox5gRcjU+hE4mm7ZcmCRCkovjVM6EqdzZL8?=
 =?us-ascii?Q?vwnL9nAH+cDs7HY8ZC9T1qf+GTmXxV3KC+G7uOM95PRkxfrBbIfE9uoouQJY?=
 =?us-ascii?Q?79neC5yBWjP/gDPNK/C7bOtQ9zRHRvVqOLFEYjh/PibUub9Uk21dYvmN59WO?=
 =?us-ascii?Q?szH/G9hfDA535QjcLqum0eNYCJcVry3JWCYvGbXTBRzF4TwvKuFuTqUsBiXD?=
 =?us-ascii?Q?JKtPIs8aUOz+y/UN2kIy9hn4OoW/PrA2up5p04MiOmyMr2dFWrP2JSgc+oR8?=
 =?us-ascii?Q?eLEZhvH1jdOtp3969phRJ4HJ0BiCk0BiXH9X1f9HoJGhMLevfZmC0S+tyfol?=
 =?us-ascii?Q?G8V3G9FbSj4QMFwSzb1TSj3u8vsRKu3nCZqpEI8UgHkAWcp71RRh9IZfn1p1?=
 =?us-ascii?Q?e4SrJU+8KUfgZ/1zNYjr13bxPzNDpBV7y6jhGoIkRdy6y2EsUey7ZogNflJG?=
 =?us-ascii?Q?VC/V53sw/KCZKz8XW/yfxD17MhG/zttPt2nxiRJ+68r6cX4xnWIGs8NL6umC?=
 =?us-ascii?Q?2sj5I3ZZ01vXx2SvgMGUmnUcmUnVpFyZ1AkRI8Vj5veB1qP3xrPlY2esJ4SY?=
 =?us-ascii?Q?IdFUiT0R3IJdvxRKMXk4mxyrWC6i1sPcupaXlyrXkFy1RvuwfRuO2wtdsMXH?=
 =?us-ascii?Q?MZKD4xiBCDxfVlwIPo5FHQDHDf0XO+iWauS8VMxh140z02bGkxbEq467xIzy?=
 =?us-ascii?Q?6DgBtkdW+NusWpkVgJ0y1ekSGWUiF2Oj202DW/Z7qIKpfcb+o8dK4MiMkAR7?=
 =?us-ascii?Q?NK8XUDSn5iRZ57vlyhQbTF0/TDddnU2/ExBpc0gZzQZCDg2DoelgTIx/dXkh?=
 =?us-ascii?Q?Ztuh5fF3ipqYTFiY7S6m1dhbJwJqefZLIrLrCO2qVpiKBtZqNeWRV4UJzD+0?=
 =?us-ascii?Q?Xk0Lu4cIQrBLJcZL0GvVciiZLyILIkJrxUNCkE1Y5vw019z4yMnFTugeMa9I?=
 =?us-ascii?Q?vMp4lOxA3kypl5q073ycnlT6Dp0notEfU72wcx6Dfh6BA7VWQlzu3aUEuOW6?=
 =?us-ascii?Q?1UGJQv+rHZ723unSO/TZwOHsimd0G3tBd27V7/MCCL4IXFCVBMndSagb9Lq4?=
 =?us-ascii?Q?776ozN5Kx00+fuFDww0smUDmVZ2vjL8YAFCdztttYPU2/OIp/r5x5F0drw/0?=
 =?us-ascii?Q?U3abvjeglPM5DjmsJVUaX70/CepN6WWbibsNFcb16a+/M6laqEbf1ya+B1UK?=
 =?us-ascii?Q?dQo08sM1Dm8ZKX6cUGg+nk8dZV2mTWvWzlcI1tb05oYCp2g9OH+0Kioc7ECZ?=
 =?us-ascii?Q?al5I8pqNDGY8rVXVrYKfwD9KgAcrRb4vlatrSMxVz2XwP991Vt8sn29wYbxh?=
 =?us-ascii?Q?RuxMpmpF3A8mmGr2WzpgIUu9FCjy2C14k0EGkPvVgfHjNgeLPNskR16NBXA4?=
 =?us-ascii?Q?fT5bEjF1fpqHY9MQEUwBEySNF1N8TARLyHo04U914IE9HYDrjfsbtz4zPbY5?=
 =?us-ascii?Q?CEIi5HAyU+UmEO0hfKkEU7A7B1y3oNG0o5xH0mtJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c49fc7d5-8f66-44ec-d605-08ddcfa67005
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 20:19:51.2218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tGn08DIJhHXg+A5L9At05wIcKuZKsuJu6lFediLu0NrX5P+37QCEKoprBkpOd3khuATo32Ojs4yDWkzWO4jSaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11056

On Wed, Jul 30, 2025 at 09:50:14PM +0200, Daniel Lezcano wrote:

I think replace all 'description' with 'node' is easy to read.

> The s32g2 has a STM module containing 8 timers. Each timer has a
> dedicated interrupt and share the same clock.
>
> Add the timers STM0->STM6 description for the s32g2 SoC. The STM7 is
> not added because it is slightly different and needs an extra property
> which will be added later when supported by the driver.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> Cc: Thomas Fossati <thomas.fossati@linaro.org>
> ---
>  arch/arm64/boot/dts/freescale/s32g2.dtsi | 63 ++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> index ea1456d361a3..3e775d030e37 100644
> --- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
> +++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> @@ -503,5 +503,68 @@ gic: interrupt-controller@50800000 {
>  			interrupt-controller;
>  			#interrupt-cells = <3>;
>  		};
> +
> +		stm0: timer@4011c000 {

keep order according to address.

4011c000 should less than 50800000.

> +			compatible = "nxp,s32g2-stm";
> +			reg = <0x4011c000 0x3000>;
> +			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
> +			clock-names = "counter", "module", "register";
> +			status = "disabled";

why not default enable.

Frank

> +		};
> +
> +		stm1: timer@40120000 {
> +			compatible = "nxp,s32g2-stm";
> +			reg = <0x40120000 0x3000>;
> +			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
> +			clock-names = "counter", "module", "register";
> +			status = "disabled";
> +		};
> +
> +		stm2: timer@40124000 {
> +			compatible = "nxp,s32g2-stm";
> +			reg = <0x40124000 0x3000>;
> +			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
> +			clock-names = "counter", "module", "register";
> +			status = "disabled";
> +		};
> +
> +		stm3: timer@40128000 {
> +			compatible = "nxp,s32g2-stm";
> +			reg = <0x40128000 0x3000>;
> +			interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
> +			clock-names = "counter", "module", "register";
> +			status = "disabled";
> +		};
> +
> +		stm4: timer@4021c000 {
> +			compatible = "nxp,s32g2-stm";
> +			reg = <0x4021c000 0x3000>;
> +			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
> +			clock-names = "counter", "module", "register";
> +			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		stm5: timer@40220000 {
> +			compatible = "nxp,s32g2-stm";
> +			reg = <0x40220000 0x3000>;
> +			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
> +			clock-names = "counter", "module", "register";
> +			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		stm6: timer@40224000 {
> +			compatible = "nxp,s32g2-stm";
> +			reg = <0x40224000 0x3000>;
> +			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
> +			clock-names = "counter", "module", "register";
> +			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
>  	};
>  };
> --
> 2.43.0
>


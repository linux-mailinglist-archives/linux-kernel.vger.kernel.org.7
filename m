Return-Path: <linux-kernel+bounces-824911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5D3B8A743
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5C31C85183
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2494031E88A;
	Fri, 19 Sep 2025 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a5RfiNjd"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011001.outbound.protection.outlook.com [52.101.65.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C2831A55C;
	Fri, 19 Sep 2025 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297491; cv=fail; b=AaiRCz0txUd1CSaPf8b3bC2yax9ZKdfwx8uL07yVBfGC8nhfVHVdtVlN4GfYAyErt97QtH44Yt4fUzB4EWVxP2UGNuNlHenRoGVUE+LfZqOSJNhPFSrfXj61ZOxJ9FCbFcMcUUWc0RcqJIGplaVjUMO+fTIIBZjqzE/MGwrOC/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297491; c=relaxed/simple;
	bh=0Hdc4wwVGjBPmQx+kdIk9wrOWa9iMBXd2UC/xVHOYHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IIS65dxL1ENNTgu8RYlM5CFD5PvaPFMDaLfcjvtpFN05c+WyQBgKNBwDds/wG9ZIlCOsZqMDrBGBh0srOlZRbbGTVQ7oQy8V8ywmfRrSKdaT04MvmZ/z6DG6YRxRvKHh6IWSSOouK33BdMjjabIkSuKcY4iZxw41OVhm6ZZcU8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a5RfiNjd; arc=fail smtp.client-ip=52.101.65.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nIVu7/F5uTXbg9NN1LEgxkDCjM7jTqyc7GMZNd4GA3Xeb07BuZXVtvknws2CJHFjsWwq9/i+Pafio8IL4Jn9TJbOZHfsEDmYnF8yfOuv9UJgdnkFrfOVpo3yQS0KKrmaCUXsLIibOYNxR0cJPCQk/p12ulRrhfVdOvG63sk91vIPalp+MvV3B/54IUljwWVPczhRfzsko2W1aM0iFPkEsZY+julylTbParVqDBknuIO/5WJrqE217acUUIQiCrnVa0AZqkH8RP+Nx4bJ6VDUOK66g2WCeskOUJv0seaxGTWNxHlVkzaBAttn/YNQ4MMtu7Q/wb3Klruff/wHkiiDjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wjiyp5bEieA/sOGBjC9aS6+23pI8UuK+i5ChxB6XGE=;
 b=Xp0+C9UiyoFayJ6nkSUzBZsL44AmfGHkRbbrpoTS+N2G5sjHVp5KE9N/4q7guOpp1b1AtrCWvEqRHfnAs1Lu7I0jVQan8HdXXjN3gT2aGqtUSpalWQ090ij0w0Qydw/iiq0hMxYY2bxJoSRhfFUvyPib8GWM5UC4p+i61P8+Ufr2blTTTgAWVKbD+ZEU1VqSlHjWEXeoGQyDyXrd58P0x3LLs4YS5TAuwEv+D98L4XjHHa8fRaPVQGzhjHNvb2utrMaJT06H+5wGs6JI8FRG2a/TJpGSHWeiJjl2G/x+wDX6sHsw+TsvvQ1Mhlq2x3yLWMAoE3Jy6LjM5DMLhxhl0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wjiyp5bEieA/sOGBjC9aS6+23pI8UuK+i5ChxB6XGE=;
 b=a5RfiNjdum8x6MeugTMDad2Fbdt3VkskUJBfIywuoUEhWxsfGMtkIcs26OkIqAIg3+2q3glg5DRRqaEpejgtIe9B4X/AMKank4mVAfuPZExYV8pWtA2GS705XpGj7C6xuH8kDh9BLOhrlphfE9t8JZ3s5dNGjjt86CXbU3FsEr8whhWi1wi7/laKpCKpA/fb3BbI90+HyQLWnaLKO/McS694K3jMsTJvuoRDre+xl/mwXjrKNApv+eYoZFTSsXQNwY6YNMVdw3HqSwpbwPlp2fUgZJlcrh5tKOWfTono4dinC7oFmF2g8oawSUQSWhqCU9iyuBdMEy4VadAhjtF5ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM7PR04MB6872.eurprd04.prod.outlook.com (2603:10a6:20b:106::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 15:58:06 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 15:58:06 +0000
Date: Fri, 19 Sep 2025 11:57:56 -0400
From: Frank Li <Frank.li@nxp.com>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Li Jun <jun.li@nxp.com>,
	Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH 3/4] phy: fsl-imx8mq-usb: support alternate reference
 clock
Message-ID: <aM19hCiKrP/z/W1h@lizhi-Precision-Tower-5810>
References: <20250919-usb-phy-alt-clk-support-v1-0-57c2a13eea1c@nxp.com>
 <20250919-usb-phy-alt-clk-support-v1-3-57c2a13eea1c@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919-usb-phy-alt-clk-support-v1-3-57c2a13eea1c@nxp.com>
X-ClientProxiedBy: BYAPR01CA0021.prod.exchangelabs.com (2603:10b6:a02:80::34)
 To PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM7PR04MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: e345c1d4-61ea-4fea-a6a9-08ddf7955272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GwlztPRng1IM8c7LC96rjMNehjjKT2UiE54fwXMsXWCUMu9Q2JjlrzsK8Far?=
 =?us-ascii?Q?0QQW6HxLNc05J9zFYcXRKWjDd+QUm5/s/MKjJ3ydNiQksMu9ork7a3pY0HB6?=
 =?us-ascii?Q?VT/X1wypmKNxKo4irLr7hWgz/OYaiD/WUnwQ4J67V2gs2p53aKXwmHsdJqRN?=
 =?us-ascii?Q?03RRabMkYbcGA7zUtNnV6hLcvpUi7wzfzeJBE0/JL3BXWsAsoS+14reSAuGO?=
 =?us-ascii?Q?NvmSczOFGVSEx5VfJcqqukxRRfn1RBT/F2SCno2fyZ+Ms72aHiigRYYqdzM7?=
 =?us-ascii?Q?/Ghm3yvWr+SE7sjqR7YGGT8HG8qoY8s/RhjYKS4gKbGmXaITdqG1vWZljqju?=
 =?us-ascii?Q?A1wSDbrMRuFAfBBb/QsYakIOuTceucVd2nt6XFI/BjdB8svIzoV9WIPFdgne?=
 =?us-ascii?Q?+RX4pVNqZqSXOm5MWo/fg+bxGs60yxb96COlKKBcOtdvaA43OgoTjHMOdXQv?=
 =?us-ascii?Q?VHdQetLims2P6wI+q8znaDcpcpAMMkxtymKynmnLvG5mOoLdoKJM7iBzgwcc?=
 =?us-ascii?Q?dzOPKgDfcw0gZ/8om3OOnQkXMEDW852QTIO3aK7WCUqLG8VI25ie4lguTa5B?=
 =?us-ascii?Q?xMmW5ICaRmNZzP5WCXz5Jn72u/gTjrq+FMTHqG7mOgDx2ANEHGZBIj8LXpmL?=
 =?us-ascii?Q?MsrUupBIP5GaEprl++rCxzCQRGcA6KOCtIAjIX+WBBhrJzoeBH5DDwzeWexW?=
 =?us-ascii?Q?CZ1ECSXlEaIz2SBOOqRCSF8ZptDAHhJP49wKtKKOvP8NA0RgSgYf04XUV0Kt?=
 =?us-ascii?Q?hotP0lyt5TpCSZZ5gEajw8DaUTstK1LZ23/dPIz0ov9eEpvS3BsnC9vmVLkT?=
 =?us-ascii?Q?qFDvQWnz9gchd13xj7ieNZJwYnyA89MQuuCzUw/b/V6kZYg3q7rIZ5BqbV73?=
 =?us-ascii?Q?dis9khJyNvmK3P892Q7fg2ImWWS6K7p58cDfakpVovixFeNvwLTZGoFijlg8?=
 =?us-ascii?Q?i0n01FSyEp+ueupBMVOxdfSZzw2pIubGY0Ib6hhPP2AxP5TwEwEPCsVLcmtD?=
 =?us-ascii?Q?6OB6IpRcr53m+rgKD9YXjJ3vhlOyT4yvcF0ULAp4lfT2n/dfNZdrDUenO9IS?=
 =?us-ascii?Q?WuVuCxbNBUQycFmE0Aufh4KdjPsImf4LBqrhHBGx/2f7Asi5MG2Zkz3kgwTc?=
 =?us-ascii?Q?OHFf7r/Nz92n9zQFg3vx2v4OO5bOuMag3BBvlcl23JnLO3cEg8Py953SgO8a?=
 =?us-ascii?Q?5PoUie6gH+7E6RSDWsNLrz0L93UpC8fElIhGtOecEptnav5TjPQ4sK8BGcXY?=
 =?us-ascii?Q?QwOhiUWPoe82Jf7Hvw332jNId8FQY0ZapXpaZSbnbKDWST3/1Q4UpZPQAyKQ?=
 =?us-ascii?Q?R3cCa/68P9xpoqDp1ZkyZg0Tc4NZTInKuxtvKgRvWgq0Iuye+T5pQBATAr27?=
 =?us-ascii?Q?7S0sNB+ZyvUNEfqHgOUqguYcsQbQ2eV9w8gvpH4XROHiaFKCK6OeWR6GGPMX?=
 =?us-ascii?Q?OXzYiSMiHsZ0JzOka980+csQiXICm+hqLhKmIC+83yn2vk965Zc3qw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZDAh9Z0FymFp91hd52DpuLRcXL6kGf3vTvbMc8wlJV0Mrd0nQNCqZ/R+cwzy?=
 =?us-ascii?Q?uJhx9IuQ4fLvBi7vYvtAvnmDEM4QF4jS3GRok9BtDmjk034FB5ZW/sOhYkBf?=
 =?us-ascii?Q?GpNWU1HXwJLHmw4RNcM9lZSxLnRQvCQr9ygAJ7kvuuYhBFlmTce5LUj4fT2Z?=
 =?us-ascii?Q?bHyKFFj/3EW4V8le2L8qSrxpoSkT361IWg40efKxMd/C4L3EpScI1yWYWNjs?=
 =?us-ascii?Q?/8YR/+jqnEG78i9hUtNarK0PH8L51o118VfgmpVAyZgwJPB1VAOCT0HYTlH/?=
 =?us-ascii?Q?XbCOP6Ftlj5NMoPYai2ReKf8DiN9gOXiLmN1oqRwo3LK8hwRGADGSwnt9sUf?=
 =?us-ascii?Q?HnfHQ2OCCyA5S1ky8clbBOddZsiqz9MRHQjdwEvtZ6dn8fEplt9wOBgix9ks?=
 =?us-ascii?Q?KCb5KEPug/f5wC8fvFZJjN5UWH8ZepyqpDdKHu4D1+J6ftCMLjXJDjvz7GIQ?=
 =?us-ascii?Q?laFECXwrAC8fY3o2F4UK2Lch1wQIQgWgVx0fZVzEx/hkRoHobgxwRXgiQF+S?=
 =?us-ascii?Q?gEWW1A8/cG3l9ZslP6jbPVPmm2t1d5sTxqKMup0egeeW7Eq1D2OorWnEmeux?=
 =?us-ascii?Q?EcNC44L+PxGnYO+3J88QWffPbm1PcTVYOW6uIzbBfEdLYfc4uXbyxikdRa+T?=
 =?us-ascii?Q?FYnyCOzFoLXNJ+rl/zbZpTHdGPUd0dgmHLWcJfhhMnOt6Tmjge6z9Y3Y1aKe?=
 =?us-ascii?Q?EnnVJEZVi63emCjinngo64dyX6hElLuO2LWAjjxfdVDbNVbMjJYSIs+5TIDz?=
 =?us-ascii?Q?tpsa2uUOFuRzE3cuyBCgDxx6Cbsnqg6fxAgAnuqTbBMhVSexT5Ffiqvm3C+O?=
 =?us-ascii?Q?fdj5hvCflvn95fMdgwAMn3/jEoSwMAFrsxM2c4mWzON4xixr0FRL6gxakrvP?=
 =?us-ascii?Q?2FhU84EBwr4PaluFfK69r6FJ15G+dmJE9YfKfQoRtlM0ml5aA/iEcGkOj5E+?=
 =?us-ascii?Q?3riETdOen2g9NlYHzv058IbNC70VTVpulrFGuKVcFV+oclJdrl+fAnL7Ez0t?=
 =?us-ascii?Q?eCLFEBwfoddADW5wgv3xnuv6wZpicbqlL25FQ6PN/JSVVJmw3RMa4chHA/B8?=
 =?us-ascii?Q?Qmi2KRvjTCGvAFJnRn0I9Bbfc4aOshTX6Gucft+kniw6h7HgVai7DbkT6mY2?=
 =?us-ascii?Q?ILofX9VSfi8R8hFznCLNdH55z2XYqrL3YhoeCbh5C4+x8Nd9pCLlsqGpLu/C?=
 =?us-ascii?Q?i+2qiZUxgFTeyn+a1s/aTbQaDDXNDH7cb6Mk7/StVr9QIZii1x9/bMNtPJHK?=
 =?us-ascii?Q?icR3qrWI256c4D+iZtGapG9ZKuTrZCo5YlcBVo3easVOx796GYJ41AQ8y3Op?=
 =?us-ascii?Q?ScVmV7TkEWX27YGuqFLBhu8eMbQ5jFBuXYW2/VBHk+E2kQszDiZ1eREfV/jm?=
 =?us-ascii?Q?cyEyIG+yToWYXkgX5L//Q5iGTzEacFzKBWf5L5lxJHkB3wtOjkltDJ2aB6U0?=
 =?us-ascii?Q?d8sHcjKXceoNBnp4VYSKRotXWrjXJyOU84iheGaHcQMGzNsLXKzIjORVjvQf?=
 =?us-ascii?Q?xheRsjuPYcs/Sp+nMYpdsQAdWiVuBxUZq/n9uHvIQER/pEtqYyltmS/fQr9Z?=
 =?us-ascii?Q?ebrvd5Mf67LCy+xgtTFG1eR/V3Nd9YbO6KsId+f5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e345c1d4-61ea-4fea-a6a9-08ddf7955272
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 15:58:06.3460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1uJ7MJYA5gm26DRJ0ftx4cQ8ILPv0ruTFkfgMoFmGfUKMSKWehTLn3CeRkH84VTe4jknXYk89JZBeuyy21qa5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6872

On Fri, Sep 19, 2025 at 03:02:59PM +0800, Xu Yang wrote:
> This phy supports both 24MHz and 100MHz clock inputs. By default it's
> using XTAL 24MHz and the 100MHz clock is a alternate reference clock.
> Add supports to use alternate reference clock in case 24MHz clock
> can't work well.
>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/phy/freescale/phy-fsl-imx8mq-usb.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
> index b94f242420fc733cd75abef8ba1cd4f59ac18eb5..ad8a55012e42f2c15496955d00c6d5fd85c5beb2 100644
> --- a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
> +++ b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
> @@ -16,6 +16,7 @@
>  #define PHY_CTRL0_REF_SSP_EN		BIT(2)
>  #define PHY_CTRL0_FSEL_MASK		GENMASK(10, 5)
>  #define PHY_CTRL0_FSEL_24M		0x2a
> +#define PHY_CTRL0_FSEL_100M		0x27
>
>  #define PHY_CTRL1			0x4
>  #define PHY_CTRL1_RESET			BIT(0)
> @@ -108,6 +109,7 @@ struct tca_blk {
>  struct imx8mq_usb_phy {
>  	struct phy *phy;
>  	struct clk *clk;
> +	struct clk *alt_clk;
>  	void __iomem *base;
>  	struct regulator *vbus;
>  	struct tca_blk *tca;
> @@ -582,7 +584,8 @@ static int imx8mp_usb_phy_init(struct phy *phy)
>  	/* USB3.0 PHY signal fsel for 24M ref */
>  	value = readl(imx_phy->base + PHY_CTRL0);
>  	value &= ~PHY_CTRL0_FSEL_MASK;
> -	value |= FIELD_PREP(PHY_CTRL0_FSEL_MASK, PHY_CTRL0_FSEL_24M);
> +	value |= FIELD_PREP(PHY_CTRL0_FSEL_MASK, imx_phy->alt_clk ?
> +			    PHY_CTRL0_FSEL_100M : PHY_CTRL0_FSEL_24M);
>  	writel(value, imx_phy->base + PHY_CTRL0);
>
>  	/* Disable alt_clk_en and use internal MPLL clocks */
> @@ -626,13 +629,24 @@ static int imx8mq_phy_power_on(struct phy *phy)
>  	if (ret)
>  		return ret;
>
> -	return clk_prepare_enable(imx_phy->clk);
> +	ret = clk_prepare_enable(imx_phy->clk);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(imx_phy->alt_clk);
> +	if (ret) {
> +		clk_disable_unprepare(imx_phy->clk);
> +		return ret;
> +	}
> +
> +	return ret;
>  }
>
>  static int imx8mq_phy_power_off(struct phy *phy)
>  {
>  	struct imx8mq_usb_phy *imx_phy = phy_get_drvdata(phy);
>
> +	clk_disable_unprepare(imx_phy->alt_clk);
>  	clk_disable_unprepare(imx_phy->clk);
>  	regulator_disable(imx_phy->vbus);
>
> @@ -681,6 +695,11 @@ static int imx8mq_usb_phy_probe(struct platform_device *pdev)
>  		return PTR_ERR(imx_phy->clk);
>  	}
>
> +	imx_phy->alt_clk = devm_clk_get_optional(dev, "alt");
> +	if (IS_ERR(imx_phy->alt_clk))
> +		return dev_err_probe(dev, PTR_ERR(imx_phy->alt_clk),
> +				    "Failed to get alt clk\n");
> +
>  	imx_phy->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(imx_phy->base))
>  		return PTR_ERR(imx_phy->base);
>
> --
> 2.34.1
>


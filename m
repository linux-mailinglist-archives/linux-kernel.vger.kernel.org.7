Return-Path: <linux-kernel+bounces-876763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59716C1C3D5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D0C1A2551C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B7D33F39D;
	Wed, 29 Oct 2025 16:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iaX6WodE"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013022.outbound.protection.outlook.com [52.101.83.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3511348890;
	Wed, 29 Oct 2025 16:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761756290; cv=fail; b=q71J7S7jWt3Wehthfd1YKtV0rHKd5kSPvXlZZ2k2/cCXWuvmNrUMBkg0PEkQ/CnhkYsxhIt5RLNk8x7OVkIYibiTzRoVYS9gwwfqJyApccb41GGPRAO8qilc2XaNbnVn1iNsn0dqr7xwCWEwhhD3M92kfhZocr3OrsBj3Dh72pQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761756290; c=relaxed/simple;
	bh=/oqbmjNrL70pxHfIcQb9PChTTgNxB/0IH4Ud7sVfYkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gikfDGAOXik6rVQQTJ23nspjtf+rImETvvi3I/S1eutNG8GxdaYolryvS7zewujn42XnBOPU12365t8NEVBAx2PF9LokOH6ZX/AEMccYQILY5+KVZ7ucuNHpC0kZP3uI6ysOm+S+wpggeu2pGeABx5lbz/B0UJ3tZtjcCeJQLgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iaX6WodE; arc=fail smtp.client-ip=52.101.83.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qnEP/QezDhIRv7ERbs2HIGbUVUyozo4pIGZ2ZRvwAuqXuO1+gtdb9u98fBTv9qfja1pHSLk1Zei/BOWbnRDRDwd8NnInVsZViX/htGH8VtBqIYAPJdDLRwlwH7c8Ixd9Bf3lIZk3WAR4OJTzM+zmyzbMy1Mzup6/NCeknmJqSgFMmO301vEV9sA9eqlzCh60R2mU3Qvg40pc/pCxiRHYQkgWisbh+hfN4OMvm2Z+Ndokl8CBbBDhFHaP2BJDIdTyFdXuJyWss/l+Woj2hrk7P36AXjlNHKH19b3lMMZWcbgfL2W36ILCKkGg1TZwLGQ9XwP9ovfgCe/AFdfzOtY+0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGkvAIwuHJwOg/pdQe8w7pth9hr1P4q0juN9Gca7CfM=;
 b=lPqAlkHv5PHUhU54pqd5MK5qqzqkmeg3swHqljbhrcsjFXPU6uZ+ztGAqRzVpi7ikhfLHGgOWo2hEp9hZe/pbjDrYPg7d+YpPAEqKriDd/hpy0WlGWcR2w+jqWsaBX++t9LvShH5T7s1ZT+0zBrKWinENldzonb9bL/hYs5fn/ejVuasveP83xoZ4TDnahzk/1vCxbOQqHf3XAmj7obgjTggoxpOUITwrSnp716f6I82VK3Dnv0bxsGrOkfkzxoCzE71KxJC+VuA+1/61C8Dxkb3GPHt7gV7IAJ7EgOnqecCA3TxDruSxKwN/DV+gEacKtFK4tHysqoSfes2jFZTsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGkvAIwuHJwOg/pdQe8w7pth9hr1P4q0juN9Gca7CfM=;
 b=iaX6WodERsFpTsAr6S7SqB3rfzQpirWXGlULGPjLQP2263YcthA6yFiFvXglPz8o5G+D2KsKaJ/bZ8BDNHJgsnoEv16AdM6cBMIYAdXcDhTzEt8WFw9wllrdxxLSMBzo76hzyoDduKmDiJS/lvlsTSuQw0RhuJY4sPjuBXhILzs3qRV+AyISHOi5xhI+beRoVCJMpyJ9dytiaP7VbqH1lRBiPfU2jAwvEBZLYZjx+07MPqkbtK3l2oIHMlQDUPDfDc/kmyRJgo2oGI9n1HkgomcQ5oWNliB/XN02OmJOD/ZNlDMsI2ibNzpp7npxYsP/C24pl87ZFu17Hga8IimfVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM0PR04MB7156.eurprd04.prod.outlook.com (2603:10a6:208:19b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 16:44:46 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 16:44:46 +0000
Date: Wed, 29 Oct 2025 12:44:36 -0400
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v3 8/8] arm64: dts: imx8ulp: add sim lpav node
Message-ID: <aQJEdCqLajoCsFh+@lizhi-Precision-Tower-5810>
References: <20251029135229.890-1-laurentiumihalcea111@gmail.com>
 <20251029135229.890-9-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029135229.890-9-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0220.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::15) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM0PR04MB7156:EE_
X-MS-Office365-Filtering-Correlation-Id: d5c2504b-a5cd-4244-b43c-08de170a77bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ijeyk1rB+++mpHwlcz+u9+xG5h4JSPIxBKBwtDne7YNSrfVVGElP6kctdElD?=
 =?us-ascii?Q?KCOFqZAQgRLg/gXQWocf9rpzGv/XhiBfjhOvkBqG1Zp5zrOzRO6uLN3VfIz3?=
 =?us-ascii?Q?6HkMeafP41uLwtJQFOeZXpuEzk3oXcf6dM/Sm/4XMswRo9+lqhozRhxgmNnZ?=
 =?us-ascii?Q?MGPLalwt+fgZpVgZU8w7ElWMHBwUlxaSjb+gxDecuLbLaIpzHpaCSTsp8Ns9?=
 =?us-ascii?Q?qqfDNOi7L/AFPcIYCPXs3Ps3mWHb4ms8AwnNPyBLrJRNosnECiOkNbsrmz9h?=
 =?us-ascii?Q?bP30EC8TiBQXlHxzx8mahtq/aK+A3YNMP6o/mGalpT/MikGSnQxaH9DjmRtQ?=
 =?us-ascii?Q?iPLf9YFKBPeZ6vK1hCW/Rh3zRxUFgMEeIb8pGwjTAJakyGVK8EW1SdqmBBFv?=
 =?us-ascii?Q?dlO0GmWHW7kQVGr32tA21bwT7S1JXD92lT/Ub4klCaKEPu6Hqc4LuyY44Oxx?=
 =?us-ascii?Q?PXaJjSSiLGcsbsJUugVM5EA91VEwREgIFvzbvZKXwmO28+atjmBFkmokzWzp?=
 =?us-ascii?Q?V+nnm3vDXyeH4VUNTRtz9M2uLGc8nPiqxg/cXi/64+ap9buzhyyoIx8gQlOp?=
 =?us-ascii?Q?AqMA4QMLTLHm5lBSB8H/RXge0dqz3U0R96GVMkqmvnZ9pAvWxWWVYDpTw1+b?=
 =?us-ascii?Q?TA05qbwUiEoPxHcBMBKAStx6QNztlxhh0/3hYX6Yb62nBRuOTiIgx0W1nQSX?=
 =?us-ascii?Q?d3XkV4e+Ahe6ofIzpbdNFwzYtUOdeWPPA9LA6XCnPvezCAxUpsaeh6q2Qbz3?=
 =?us-ascii?Q?4bYtaekHHyxilVZcdZWn6d4mxrX9PDick0SZOqXsgmZcyEh6wA2nBHf7+orG?=
 =?us-ascii?Q?lEAgcaBajeBCVqX4jEGIXDgH/kLX+3YQzgjHAF4xxNiB4x3KSAzwLt3/JEeN?=
 =?us-ascii?Q?ccIxqisbuuns1nIbIHfgtp7XKPJ8k2DtEuNwnxFR8w5CJN2MZZ+bqmyg13bs?=
 =?us-ascii?Q?Wmj316ItCFRX+oDQ254RGNishIDK1IECN7dM8vraBXbjxbCCCMv2icI9vTD0?=
 =?us-ascii?Q?zssNN0GI1sf5hNcQrS0JCuvS+cg5u0PhytE4lPRIIKtyaN8+ntcjF6+vhgzF?=
 =?us-ascii?Q?EFJ5F8eLNyCQhI89vDMKRXVHhxJ0vFFAhbCaFlNI/d1+zpdUDOnc9TnlItae?=
 =?us-ascii?Q?HLl4PT1IV3H49Umn+M9roPRdhGZZfcnDv8wBBmMGq4nKdSASGIUFch19ZdoO?=
 =?us-ascii?Q?g6qhliRIDvPCTN6OXUTFjGoZR/2aNqdSkk6NG/oDax6qY0z3lYZAlSNVdmaN?=
 =?us-ascii?Q?eVdW76euEhYrRXt/WywEfgh8HbVDBrClaKT5kWX5xkXzE9BCKIsVn+oP+IkE?=
 =?us-ascii?Q?BrjmZJSLf6sRwuhg14pW7kOSivtnp7MaSMCBNKU+bglZde+oo89v2mkAL+bb?=
 =?us-ascii?Q?GZ4RB/UOgQtysSXJTnqLn39+7AGT5Z7e4jCiYGectBBUinxQLzEIBAV29s+5?=
 =?us-ascii?Q?7F0WWdbZdghhx0ffhusZ25NLiMUA/Mxg2BhjzS344Cfh47wDchiWqgAzQ8Gc?=
 =?us-ascii?Q?8SSW+sFfJqPpEzlxjTU5UFg7wrGujNkElLRs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/F02cyzjMPEjrvcS9VNBFXfzLM7NlLDh74ocqUPrXlkaJNonrSp4KA+Xf8Xk?=
 =?us-ascii?Q?ESkUltiR/6FwT5d/x+vNQ6hwpjI5rr6wOGFPqOTmNa7+y6NHRTAt/GFMZLUm?=
 =?us-ascii?Q?4WjwZ6eB2RfDbtG3hzdag9jF9jrmZoz7PRutgZDe7jGJMAE23DTzW7g9BRJ4?=
 =?us-ascii?Q?LPMe2iI0nEJ0175Y0x0uQPoitnlIS0MvpgVsuFAxAR+tMnoLon0r8RMmebNf?=
 =?us-ascii?Q?O3LFBDCxrAUteTcEVp+qFDnxky0F6cIc0hFeX3/5hRwguHayMvnyGHqlZBTj?=
 =?us-ascii?Q?AKTTVx1D9J+Ji+rjen4zFyk5zd3GCJ0X39km+iVZxHvmJdLiIdRmPWgdFuM/?=
 =?us-ascii?Q?MC5nIbhaPEeP6pPhFvxxrfswDDIhXLbtoxSoJrsxL0mv/GJTYp9qkSN5EN+a?=
 =?us-ascii?Q?s4Ez3YRv6SA0h5U8Pm4cxehYm/xvLJuNEUWaQLmaDHYc37sflXybzzcFvY1R?=
 =?us-ascii?Q?ud2hGiK3tRn5dHFeT6Z8YfkSLmnz94URt65lkbHAEIHxUYSq20fTSeBOnuXC?=
 =?us-ascii?Q?uYfR3SKVmGy1rVA7Nrbk6FneElQQhVmhg5xslqFNLFev1PQYujhPo2Vm4Wz8?=
 =?us-ascii?Q?WWNcnJAa02LiHIovwgnyq92pgegggJAk259tanwrU8syDdoUPG3lN4nHNv4j?=
 =?us-ascii?Q?Z7FmmvNySChPObLfpM9Vf+LRvORymRRhIEpfcTG0YZ8juq5eA6+rXPVk+tJe?=
 =?us-ascii?Q?05YJLKSDT12Vq+83JbNq6dParvPYDLlu97wNq2L7C2xRA/ABDr1im70zDllO?=
 =?us-ascii?Q?kwl2n7AtuP7rcCexZ44mdBav5/+H2xqraM5he+Jp3S9ovlkxUDvDIy3kV63d?=
 =?us-ascii?Q?slsN4W/jm5h1W56uzXZvnTGsHmSY688yfk9/4HZwA5LM5MaTihoEZnkyQR36?=
 =?us-ascii?Q?JPCdkFa/yjHMdTpqhLlEBAQtxt5ObFREvnoVl36o+nmQDOi2+AwcIa0NgiwJ?=
 =?us-ascii?Q?NV4WkGi9NCIEkLnDK1go+dcroe1AZJth+0vescBZjAPFoJCvD00ap6wweMkh?=
 =?us-ascii?Q?7RMrNPeB9W5Z1nNO4vhDSih7APISYCTSLfO8P+9Gz6qijLDJb8ZsxTGSUfTV?=
 =?us-ascii?Q?eF/yiM4PaNkAXu43klzXBkI8ie0gvZ+dd7MyhjEQJSoZdMqlPQNjcM/T9MHL?=
 =?us-ascii?Q?5+MUkZ2d6bSQKGF80c3ZWRTucwhcaU6lk+zyTwtG5EOrCpPpGYGo3EjpfiWH?=
 =?us-ascii?Q?Q6qz0xnpSkOJLinQPlY1FTUrkhVJaFDLyFeSo+oBNSvdJFWiZObF20mEwegf?=
 =?us-ascii?Q?4ofYrIOgPCdFWIa3kQkjokEPMeGaVU3Swmg/irtXmoTSy2JoPVWWjpoCdRuE?=
 =?us-ascii?Q?09x3I8yAX/3M+WHxV1lLnnBhZmOlgeRTtl+xbKoKQsfvMGPPxeEZK658t90L?=
 =?us-ascii?Q?W8j31AYls4BOlqTfhvfbMMJ61UYb7vn0/tI1QG06URRzxHXFeTekTgZQ8EZ+?=
 =?us-ascii?Q?xhLamqfM0UPcaTmP4226aSp+eb3PyZfNoJWxDCzUHUu67Kt6dzLpHpAXS3Do?=
 =?us-ascii?Q?xRUkwqhDFfXJ72bQqzE+1064FdXDzDNKfHBJyiH8oqd9hPTkmIvc0xaLIyb9?=
 =?us-ascii?Q?iV7lzuQjz4UzjRWNgJm8cHaawdVHhYk7kZZzzteW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c2504b-a5cd-4244-b43c-08de170a77bd
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 16:44:46.0845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40BuJni1rkzinYEptJUbc3J5LRDe1zt+7bOtDxadQJp4OjDS+wCUkmSPgwdGzPrJQ8ZDKxk7aljbJwyTp8pRQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7156

On Wed, Oct 29, 2025 at 06:52:29AM -0700, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> Add DT node for the SIM LPAV module.
>
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> index 13b01f3aa2a4..9b5d98766512 100644
> --- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> @@ -776,6 +776,23 @@ edma2: dma-controller@2d800000 {
>  						"ch28", "ch29", "ch30", "ch31";
>  			};
>
> +			sim_lpav: clock-controller@2da50000 {
> +				compatible = "fsl,imx8ulp-sim-lpav";
> +				reg = <0x2da50000 0x10000>;
> +				clocks = <&cgc2 IMX8ULP_CLK_LPAV_BUS_DIV>,
> +					 <&cgc2 IMX8ULP_CLK_HIFI_DIVCORE>,
> +					 <&cgc2 IMX8ULP_CLK_HIFI_DIVPLAT>;
> +				clock-names = "bus", "core", "plat";
> +				#clock-cells = <1>;
> +				#reset-cells = <1>;
> +
> +				sim_lpav_mux: mux-controller {
> +					compatible = "reg-mux";
> +					#mux-control-cells = <1>;
> +					mux-reg-masks = <0x8 0x00000200>;
> +				};
> +			};
> +
>  			cgc2: clock-controller@2da60000 {
>  				compatible = "fsl,imx8ulp-cgc2";
>  				reg = <0x2da60000 0x10000>;
> --
> 2.43.0
>


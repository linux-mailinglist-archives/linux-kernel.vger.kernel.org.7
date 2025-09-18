Return-Path: <linux-kernel+bounces-822260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F097EB83673
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A659A541DEE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5DC2EC090;
	Thu, 18 Sep 2025 07:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="oCjF36tK"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013031.outbound.protection.outlook.com [40.107.159.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7552EB5B3;
	Thu, 18 Sep 2025 07:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758182334; cv=fail; b=cW68xzEtmxoXqkFBBDsozmaaz6vUhklR1M/kDRVAPW7tq9xv8HJEiY5Ljq7ervqoA7ayGF2BCnqQc596XeUwWYCfAQwmCUEISq0u/FgaAGXk1JA1Z3DGH7L096vREmGQw9PvWV38SWmxoVtZupnQPuPVCwb4FzLeRZQC351syKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758182334; c=relaxed/simple;
	bh=70X5BxkEbKO6H2RBwB0blOVPH8iXaaSoeK3z9oDWAok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e4RjE/EmVxMr9nwJ4LRGDzYg3+OyUEa5D7M2RBZX3DzrqV5w9zg7JDrP7d1IO76PAJwOfEs8a5VC6tJcibgul8+VJSvEzDtiD7KxTJYzab/KOhLe+wF3K7GniYC1qQkXoM5z32N7xoVoBqhfE3Jvo440scD9oRV/7doxSllYALY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=oCjF36tK; arc=fail smtp.client-ip=40.107.159.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sACX3TVbf2F9DbNOXgWcLyEyIn+lVDPAXnakPFr6qfpEDVGMBBbbWKLYXwPSH30XfOsNtSMIZPLWWapt3VtSpYDWgJvZYmN04MUHhGjfKi+ikiUi8BHmMy+nogs/CkrZTwncQUU9TXCmwxPj2vYOyZPDT+zofJf9jMXjBBq5FHwGA8O534AmC9uJiBuhCfuTDkNdcqd6EG00p0Ct+hjjPiTA4qHGXXePWsf7u9+NyJrBzJRamYcJknsMNtF/bb0Sgm7yqhRq2TwXowPZcAVvBjZbcq//MBRWaVsi01Ww9IgqFWLAnXynRo10P+XgRZzLuGr4JOekiMGCIJ56j/x7xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSrounOq/Zd/8PMXsRA7PLv0gtstu7jedzIuYhK36D4=;
 b=e11iO9Bmj1+u3uSKrP//eAYg7ou3mD5IiWY0njawMZJd+i1kFYjSrLy2iEcxbCgrT1cz+IVTuj/E7bFvg8G4jWZ2zN+5Yn2beu7ppjWak/tYpram2jwSC/pTllSHGPd0ugtoCau6qPcnkA6lYFX11kGAhfiImwlIDSUYJCU6V62vINHDf1XnXq/GBB3g9YL3js04w5geluFki4rkTWqExFIV1HkxUAXX/cT+k2zOyzxVjGRhpgQ3DtkBj96sDY2tHozmQPA2XEzNf9PIfQEWJa0BBdAagRC85LD6V4zbxWWqR/S0T2aSzRk36RaVIb23x9mNkrUgJSy722YhjLG3QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSrounOq/Zd/8PMXsRA7PLv0gtstu7jedzIuYhK36D4=;
 b=oCjF36tKOoGW+10uRsR/HoqOxma3PHH9735QRwnfGV5z8HV4vcu+mtuZcfD7NVz6T0F4pihirEHeMKfFoOl3BRwk7itEZNDl1Zdj1Gzft+tkGFpHmboxerpuxsnXCelcPv38gZ5pY79WFRNkwex99nsQUgBY9TmYneuqRPt0/z2wj7FTQcx+Ossf5onPnwegFb8dRytsmykZjQskFIzY9L0CEOzAvE8/EOQZmlihnjOp4eu6jxrD8/+/339DNROAiIbgTTtf09U+Qec2nrqEFhkr8+LN8HpAfYWQ5VEQbKf7faaHQgjhGbOXoEpRE+v7V4XSWjxy6fjO40XO+8KZeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB9007.eurprd04.prod.outlook.com (2603:10a6:102:20f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 07:58:47 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 07:58:47 +0000
Date: Thu, 18 Sep 2025 17:10:23 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] arm64: dts: imx8mp-venice-gw702x: reduce RGMII CLK
 drive strength
Message-ID: <20250918091023.GC23028@nxa18884-linux.ap.freescale.net>
References: <20250916153216.1042625-1-tharvey@gateworks.com>
 <20250916153216.1042625-4-tharvey@gateworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916153216.1042625-4-tharvey@gateworks.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA1P287CA0001.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB9007:EE_
X-MS-Office365-Filtering-Correlation-Id: 58363fb7-609c-4829-5040-08ddf6893274
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?IdLtOQnCM29hfGN8x1smdxarV9kyzG6w6aP0PEdknhmrDdrZkNjseSa9q1p3?=
 =?us-ascii?Q?FT21ErUajzH4BbnTcojSGS6WHCtML5XcVe9losKOaivFlBspkjY1V+7C4erM?=
 =?us-ascii?Q?+TQXzXdh0NtzsnIJYI38BvfvDWCIwPIgFYoRFxEROlg8h1HM53q3HXLxMh69?=
 =?us-ascii?Q?bqeoIyoW4Xq7SxPpcf9CNinG/hkEGkifdm6Ohn+5pG7RF3CTj9C48EIOq5JG?=
 =?us-ascii?Q?cfLKTng0lXdJ6kvC0LB2LoM7M7RGoDMG+eBuNn3+7gHH+PbkzZVFpL3GBV2c?=
 =?us-ascii?Q?rnnlQ0fYoLn3hEuImBovUCLDBK03YJxf5uGkPNaeIttqvI9br3vScBkokQ6n?=
 =?us-ascii?Q?DQxGzOBONMPYGrNOp16707Run44E1xvS6yOg7OOcD/MU60MHYwSVzJFzU5RV?=
 =?us-ascii?Q?SPUz1FOvzfIUgZUkjRbYHVMgM0CEYyUKbXVW2ApBgEHESOjMlIjViNd0tKDR?=
 =?us-ascii?Q?9Qk73IUDp8z+N+bKbHPE5NZIjtJpiPxXojuwYdEhQqmQoN83m8fD1SGgTlag?=
 =?us-ascii?Q?VOq1rg+Qto0UeU01I4J6iktoeg0VnjmB9Zi6KKL89PrPROB0sEjsXnADD9HK?=
 =?us-ascii?Q?DjaRIjSHxTKNI0/U6yD4yzg2UuLCZqjP1h0xop425UQ6NCDUVr8RNEEu2XMO?=
 =?us-ascii?Q?JFqHjHbOQP/51xmIdXayu/d8/8QLUBvd9NaEOnQaVbmIbT/nE0ZtRutYloH9?=
 =?us-ascii?Q?7Gx7erH76IffBR+gMq4h8JPjZKt/4cIHu44UDCaO9tfy6UJ5sDn9IuRGo6jH?=
 =?us-ascii?Q?1yULo8GXsDK0iSHZME0UyhUGbfhCgFNmAi4VcrfyTL1h+a/0op93xl53IIaH?=
 =?us-ascii?Q?lDJ7kyrMkUaFZoJXnXygyv6BKgZYOTN5IMXnjR4CyoxkoPCfe6ndrwVXVDmI?=
 =?us-ascii?Q?wyPKmTSBb0PbzP/+yHJm51mfD5UfrXrh3RgoIUqGsrYDhxrO/PQbimMP1QGf?=
 =?us-ascii?Q?kXCeWkJ35ZwahfnwqNFpjuPKzS+PYEM25uhJw+rYQQB6+hu78013MFqWo7aA?=
 =?us-ascii?Q?D+ioy332vMk/oz4tydVc2yG5BpfBFQl30eA0fVjDk46R75N9UjjIFo/JvbmU?=
 =?us-ascii?Q?lbttzHnxUmFrioNDB3m+DXTK7+QuYpWJ11f2M7m5k/eQJCwWUMkMNLVtdU3l?=
 =?us-ascii?Q?OP7Vz/0tHcZo02VMAL1PKxfWwQNw9CnO0IU2TXdlBnTTktavT3dbaDsFIGL2?=
 =?us-ascii?Q?Er9vlnAWt8V6ZnKT2T/nj8PeG6WceSvyuzFCoNUHTjhyhztsCFatYaJPOiYL?=
 =?us-ascii?Q?hGYP8b7X4/BwTlVUOMuUfLetbYlWPC+NVytfNfvUJp9M9K4zm5GGUj2qo/pS?=
 =?us-ascii?Q?/Q5U2aksZi4jWdSrG2lsEvDXkkY5ZbK5WMpKg+mgTfdhfkuFTn4gF0s5NmQC?=
 =?us-ascii?Q?4SxVXS39uHet5lmxkkABJc8W1u09s6ULlkSvPG7t8b83N5obh0tKcXrkTpNl?=
 =?us-ascii?Q?RtkwKNjzKQec0meHF6xjq+2T91oC8aUpXl2i1FO1UPLhuYI4KFZ12Q=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?JVSSQ0/r2VXhMLj0suMNJOSYFlex4MbVl6Qfy1nv2b4Pp1jyAPutLIecFcBB?=
 =?us-ascii?Q?VZ90zF2NO8+0RBAZX1G3MOo083cKwl0E5aUYfMySlDOvXYwMcNoMRfMmLrEu?=
 =?us-ascii?Q?2rBKz+vZxvSf30W4p4FYli3/1kUO1lbcP3r6y6TLJXG//CEA7j49VQ3txrz0?=
 =?us-ascii?Q?iK/JlfeEXeW/kpmbhHLRZZiLCM4GMYppMD/EeVE4P4QnO9aVK8CMjRUxW7W7?=
 =?us-ascii?Q?3Ni4/sRETK9nH5rhVc7q6jB3Y1BWX0xeMg5pBcvkQhziXmhnJsl4nHI8qJue?=
 =?us-ascii?Q?rBN3o+UBpbvFLmDyO2TzoIREpUc72qnmA9e6JP0KAg7jazGQHzCB4SwlNZoJ?=
 =?us-ascii?Q?hX5xnHlBxgX3SFCqfBElJtTQLW3h+0r6W8LkHBSTfz6Z2MfC4sN86sLSYfDy?=
 =?us-ascii?Q?9kK89mfYkRb8TEvMwj+/SOMoMNvfJv8/S1x4vPpQ1G8zfdKn+1pBCkwSuQJm?=
 =?us-ascii?Q?I4vOX3Hgg0BmFS+RCypNKv/o2D/lKacNrNHt1CMRoMo87awZVyRa+pOKDllE?=
 =?us-ascii?Q?mTsUF6ekKpbQ5bvLxaqf+Bt+E3xlBqSSwBu6s4Iyt46CtMO1gLQmA9CeAOyE?=
 =?us-ascii?Q?JiZlOH1HhmNFZiURi9h5q2dh38nMe2+kwikrdsvUT6evft6ZSTL4X37hfE/c?=
 =?us-ascii?Q?qbMoRV3k8Arz9GYUVOA4E+vHEpBVVQYac9y15E3vDHGCAcn4xt/4uUa0+aUO?=
 =?us-ascii?Q?U5l+IQLLfkXWgYngj9cq8w1dbdELjk3M9gK+zzUyGij1Erj+jUbLS6wTUmq+?=
 =?us-ascii?Q?Qu/N5Bd4qQ2SrpR/k2kRoiEBmm5F0ubgAYZPC+JK3O/yfbNJDDZ/IMS2o+6p?=
 =?us-ascii?Q?FDMBwxiEqOc4YWEgio4pUFmXicHRNZrTn89E9TGBHO8p6yS0yCp3BeLnaU9I?=
 =?us-ascii?Q?+//FxC5Iwv7fHilgEOn0JCZX5SxF6mr67tgwLKiQtrfdjCX+V+IVvyTvzcBK?=
 =?us-ascii?Q?00KAOTMke1aUK6UZTmJnlf/j04j3K4FFjjEcDteznnmqOR6hjNs0NBmc0pFx?=
 =?us-ascii?Q?qTEAxzYKVJL7InhWiGgrYhAds9Hy6Dhr1h6j2LlAbDc0o9vgnpXknB0pMpwp?=
 =?us-ascii?Q?n+bh+WuUCLyGyy6oQzvNeXZqe1VUZuidcOJ4VeAsAqwjJH4V2LHyJBVK0hLT?=
 =?us-ascii?Q?HlwqwBd81V8M5387BH+v810B20EfzRWE2TyxQ3aCMGswPg6UVj8c5371C6ss?=
 =?us-ascii?Q?Y/JVDfUTr9nfI5nMI9AfmEcOX0MfEYBNgdwhjUed8VQnVDGJkJgb32eNT69L?=
 =?us-ascii?Q?dZTk+/Ob5uIRe8jcNI1hHh7dC9WOg/eA95soAxyX3m9uPdFELXto3OcFg3ih?=
 =?us-ascii?Q?KugtF8u7OVIqUHS2BLa/sI6THGlLMmUCZf9Iqlb9JNN7Qei7CpeqHBFF+3Bz?=
 =?us-ascii?Q?XNLyEY7PGIGE0CTNX5k+JD9BdcD+McARlGZ4j+y5zpykp8T+2ADNhUog2JGR?=
 =?us-ascii?Q?BV1keMrwKWeeAdgl24OWHiqU7YRltxfAA9JoAyNU15qJyh3pteF1kFGlSWcS?=
 =?us-ascii?Q?ZDU+SP06CM/KmSvmWeUHgZZDCZkNhQpqeTdBLAE1IEs1IWskWNKZuDUgvuhE?=
 =?us-ascii?Q?x7hRX0Oh5DHUqo0worW3vcNVFb03DLIoBjicXTWG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58363fb7-609c-4829-5040-08ddf6893274
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 07:58:47.6894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cte7FzLU7r8H+FKWPK3/tx0IUH1CI410uEzjuqs/QbygSZiI/htunlDpZ3KgA9/W2NmzKFyuXQi8zYjMUCWW1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9007

Hi Tim,

On Tue, Sep 16, 2025 at 08:32:12AM -0700, Tim Harvey wrote:
>The i.MX8M Plus EQOS RGMII tracelength is less than 1in and does not
>require a x6 drive strength. Reduce the CLK drive strength to x1 for
>better emissions.
>
>Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>---
> arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
>index a1232a4f8485..dd9eeb3479fd 100644
>--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
>+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
>@@ -462,7 +462,7 @@ MX8MP_IOMUXC_ENET_TD1__ENET_QOS_RGMII_TD1		0x16
> 			MX8MP_IOMUXC_ENET_TD2__ENET_QOS_RGMII_TD2		0x16
> 			MX8MP_IOMUXC_ENET_TD3__ENET_QOS_RGMII_TD3		0x16
> 			MX8MP_IOMUXC_ENET_TX_CTL__ENET_QOS_RGMII_TX_CTL		0x16
>-			MX8MP_IOMUXC_ENET_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x16
>+			MX8MP_IOMUXC_ENET_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x0

You also changed FSEL from 2 to 0. So I would add this in commit that if this
matches:
Since TXC is not a high frequency clock, use slow slew rate for lower emissions
and better signal quality

Regards
Peng
> 		>;
> 	};
> 
>-- 
>2.25.1
>


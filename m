Return-Path: <linux-kernel+bounces-774006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC054B2AD80
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 092A3201DA4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8C9326D71;
	Mon, 18 Aug 2025 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="J6c9kE1u"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010021.outbound.protection.outlook.com [52.101.84.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3329A32255E;
	Mon, 18 Aug 2025 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755532546; cv=fail; b=t2uwpqFSxCA4jtOVMVQ1K3HPXesCy5ZdvskrNXy+enWVfs6HF753e5/jEcH71LqiaYQYIR2GH/HCMnHiniVeaRQVtukMGcqJ7wQ2QbHGujayp/Inugi6Et3OOriX+EH04F2cH2r5c1rGX5O/76l/WL/s1N0wjZQGAlMWNZ0fA9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755532546; c=relaxed/simple;
	bh=muBcNI0wyaqi9nToIhzYi2dC23WBOOImyooTdOQy2YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LT5HpFIZpkVL0GXFBRO/z+zk5mCKL+DfYy6wdJDGIPAKzc/RJSYcgEaoSe25wNkXV/pVci0yvX8VAcH9tej/5lo5dQluIFAYtI+f1znTHaRA6d81uE+ARvOyp/yyYlXJDa8bfIEw4lWLzylqB9iGdC1MqV/8xfbl4F8Osw/+xXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=J6c9kE1u; arc=fail smtp.client-ip=52.101.84.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SP8z9mKtW51+VZLr6rhdoapfQ947gqfEW9NPj/olIG1ombXD4TkRGQpg7IwlD6Y9d6zHfxgkcZdnQY7EXx6bUqYkZAqJAupSeXVk3OE3t++ZhtatGReotcIKSMlrVJgjeFShrPWZvziENLWTOI6+PrgG0DYNsTS5A63+b+z3T8Emm/ZQK/BFrI6977Eu+lilqtVJg14o977OJDXWL4wdW9DlhCS1Vd0IOvZ1tDJPR0cvMFamVT2KgM9ZcltH0s1TrHMyo4hYfHTCoZp2ghe6NzG0N6+yHHHCunMhmyg/kKAhQrZilBBesU5cqpzcJJggXrdUS7J+3WgOo1HNclNO2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkkRLu32be70JeggRlq3y/2D4d55PGrkqN7hUk/LmgU=;
 b=hOPYPllCmAM9lxYbavwXWL4u0MAnZVRFyuLiZmcdFfjXeo0KQELknQB89/QlyLKM3ytLllwIc3mcSk0/CbXSU/FGPCSHy9UGCJ2GGINK/2nLWs0SEN00wGqwUKdhlu9NzYfeJROrtz/qjq6JFtXES3e2JgWEUB01cor+vruvjlDCizfD2XRdcUOkRBVO5XAooitYKaEg+o7rvfny1j6F6PLrmdajdrcd0bCOf3ySd610j8wumJyCgq6M0W8RDbQqFsjqMSY6Z6OaBDM2MWowbFpJy3xxVWl3dBIsSVXz2FNhgCmFSMDn4IJJ83x/xleiXTZsEkTVZh/nHkrU4NNp0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkkRLu32be70JeggRlq3y/2D4d55PGrkqN7hUk/LmgU=;
 b=J6c9kE1uixU0XzxSuLUwsEc6Kmmi02jhOpaeqWuLllvtUnGBL2eaMmka6apqaA+BJ1woaT6583KGSnM1JKKfzLOMmLxEsJ+GoV4+U8HVFdu+fkqznJlAvwYG92Qow4pDB2fFoc+4KHvZ0n2FLexboPYtv1Z9DZdIqPSurNnKoBoJbiueYBnlqEqN3P7Uss23k8BdY2nZ/4MMRBF+MTUT5Ey/uBDGyoNoGb48JdMY9NRTnsk+a3fVfC9r76dZcFnPMf2d267XraDsM4aWFNAf/QEX87LMBOl012krwnToGFOzBmnU1WZsJWMLNmaizVPQUmDGyhPUdT1he95SfXm8YA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7787.eurprd04.prod.outlook.com (2603:10a6:10:1e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 15:55:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 15:55:41 +0000
Date: Mon, 18 Aug 2025 11:55:33 -0400
From: Frank Li <Frank.li@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/11] arm64: dts: imx95: Add coresight nodes
Message-ID: <aKNM9dbHbprDDvJS@lizhi-Precision-Tower-5810>
References: <20250818-imx9-dts-v2-0-8ba787fb5280@nxp.com>
 <20250818-imx9-dts-v2-6-8ba787fb5280@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818-imx9-dts-v2-6-8ba787fb5280@nxp.com>
X-ClientProxiedBy: SJ0P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7787:EE_
X-MS-Office365-Filtering-Correlation-Id: 2684fc5a-8e11-41d4-9b02-08ddde6faec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2ras9ofbJhfa6LYoVZ26F0S78IRZg5seva3ZpcpCL29p8Q94RDjShXLxPt3M?=
 =?us-ascii?Q?EsfPe6hPU2uRszDOpg8bqaZ6+LEkxeyhll/PKXNQQmlLRWvO9UGYuPlcX6yF?=
 =?us-ascii?Q?3KbYb5GZUMzAhG+4CkC+65aL8QZr7otwfYwc2AZ2bIGfSq36VyHUll01jpYr?=
 =?us-ascii?Q?lkYzkFciOAMFB2SGntRhfFDSyPBZFlFg1OQg2xWLMk628FNMI2sC0XiA904g?=
 =?us-ascii?Q?BkgKqCDFE0qtp7FubLs1yzsIk+/8n3yM4OhsR1nXEnQ6Z/THWgv0JML5KreO?=
 =?us-ascii?Q?xOJY5fE+e/T5azVEAwnDmLc7SV3xSAJLuxT0RKSr5b+A4PfytAon53uRTLfb?=
 =?us-ascii?Q?aN2X+LVcaUvxspOss8v7h0xvI2xAGueF4+ikLt5UFsFA5p5IU0Q8igPq5BuK?=
 =?us-ascii?Q?Fc0pJcq1TBPENuFTWpvotVKu94FNbek9hnq0M4vcMdyuFd4fRhqKlPpKJK7T?=
 =?us-ascii?Q?z/+AU7jKLtEhc+JqotKZSvLDeaH3/8FaJrnSG8M56l2ulLHq8lHmVrY1Bonv?=
 =?us-ascii?Q?mvciM4nPKiv5hXiym5bRxr9TC6j49B8LEUKwi5koIwY3zealH4vzD8v7HVKc?=
 =?us-ascii?Q?GI6ldaQFhpg6nHhxdFjexgMxRMjOAONwv+9IY2jog6rID62O3g0ksQNIAL1x?=
 =?us-ascii?Q?k94K0/pImmc4j2u1Ahlwb6uzcWCZtjb70MOf1dvoF87F7etDtd4gMEPgfF6+?=
 =?us-ascii?Q?Z0Ms/gaqx/pzwz8wouazBNXgqnNe8lOM0HyOjOcPYcomfutXeEHS10ACtQcK?=
 =?us-ascii?Q?k4FUS+7itU7ktdh+pk+lviYxJXoxxHa6Qaxm3NWbd2wQ84mQyDvCaFQHiL92?=
 =?us-ascii?Q?IYVvUs4nHAwdJpTVeiNOo5gLehdik3X++uyK7jyZKDxF2oD6DH1y9LSm1pwK?=
 =?us-ascii?Q?oBPIMzX8krGFYe0cK18ip4mEfW/2j28VI0VaGf5mAyuz8x9z8B8af8g3J6do?=
 =?us-ascii?Q?blV/m/7g/lhZMwvkrQ5jr/PetrbbGF3rfmlqvTZenM+BR5MCB5+7q45hmb6z?=
 =?us-ascii?Q?s6pJxFYafH0v1fw90kz9uUUJQgbsZs72mK5M+KQPmBmQqqPsLEkLChmYmZ+B?=
 =?us-ascii?Q?/r1EhUau/D2eAGG3Y4CvI/TJT+DVcb1ELMo2GiODvpYW3UkE8V/mzdzYQicz?=
 =?us-ascii?Q?YUX1ufzcRwb1v2m90u+e9mU7b9SkNWNvrf01/lzGW36YJqO/8xzERVLloDss?=
 =?us-ascii?Q?bdvCGwh1TmCJfmIt24/P13pfH0R2YhkD6NVmk7Dz0wLboCTa8MZ/JQv3RoxD?=
 =?us-ascii?Q?FIZi1N3Ia1cJN3N5keoYJdV2wycdQJ0lCezGGXP4pWQy9ZkY/XGkELUOLl9X?=
 =?us-ascii?Q?c1fd/a6Efb6xbeYqrcQGlHHzsOqyqCXjV0SaHVIt+jYvR5wDjLAUcbTniLiG?=
 =?us-ascii?Q?dV60cEUv49ttqs2QvRS/xrdCBrHNhE9YXP14eX0D1T4DtKhuuZ81uwR7jCic?=
 =?us-ascii?Q?45Ck8KsM/wHAyNCeisJjgkoRTONS0/YHVxSgwHSMbID0oJe9bGDNgA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gf1MZR1O37oooxoII8VSvXy8zYUZhvI3ouNgUP4a567oFQUDZyQuYhvNKZYZ?=
 =?us-ascii?Q?SPTT2L3Q/MUuGLzc1JI6B0Aa8EcTN0rbP9qsqFML8q5RXp6lzajHIudm4cCj?=
 =?us-ascii?Q?XrYwwr2y3kdYGe1wiHPCRlhF4vi7zD/whtJdJUUypW2mnHWE4s+WKypEWh8z?=
 =?us-ascii?Q?L+95DoWnDiZvXW8kV/R7j+IOmQp4wmmAFkKaTYZ0AaleQoCeueHnXg+iLDfL?=
 =?us-ascii?Q?KmcTKkcLcVJm1wHvhViizdULqXeDXjOjIFooRNUjfDnsp4wNkVfPRN+eJlFY?=
 =?us-ascii?Q?aU+me2f1sKvM1A0q/B700CNZeA85oHHi/+d69+y0Q1aBh9dsi6Mco0eTCutC?=
 =?us-ascii?Q?0eV1gpUb0Dqe22QsfPQxRt6oMIH0k626I0y2DJMtAI6uL0Vkx0lFH1AamVyW?=
 =?us-ascii?Q?sesPfOkyQAq+7u8i83TWkWUGCokTDkkD9DlX7jmbcR8ItED1agSXTjWHm8Hh?=
 =?us-ascii?Q?TnEybaeawIuRW7w0oMKRZByN5ndsPIh//NfYOtl6+RHkUSpbjbG1jslnOX3W?=
 =?us-ascii?Q?pVnjx8xMCSmduxwN/Jj1cMeEXuYclbd4tG2PbkpCJkCmXBQIRZ/4w1VNyg+5?=
 =?us-ascii?Q?7Djj3yyfkVJQ8DDKP/QVjQQiOTPtD308+cCBdY04g6CKFjthgWAZ26LGZoVW?=
 =?us-ascii?Q?WuitKY5mBnTZvxUu42a+V2G7dLomJoB5qy+p2E03UuH2aFfzbJ47yNYHhs/c?=
 =?us-ascii?Q?ZorDPbr3jGcv6jSP+yCZeZYAc5tI16nXdVnpf/3K1WjIDfaoBasinPUcj2oD?=
 =?us-ascii?Q?29rEcxm0SoBIr3+dPg1BdP9m3ZrbVw8f+95/iZ7DCUW8zJUA4nFkFyx0WtNB?=
 =?us-ascii?Q?zAnwfSDm6tbuAACbD5v6s03g71AT+vxQGBDTd0loNJvZM+9N6H/tog4UW93b?=
 =?us-ascii?Q?wp1eqBlD7IJ5BSfTCW54n5f7PYq/iJaq6l/pJFFgR/VwL1s3wtSTqt0NOVU2?=
 =?us-ascii?Q?OCRZaduLrdugUCzgj3INtduGAQEYts854kOKiDbyzy+75NPBA2SFxIi61Lsw?=
 =?us-ascii?Q?FcjxplXoQdvJJfTqEcJlIpfgYMehsdlkK643P9ukiNRixg9f7/nbwml/NaN6?=
 =?us-ascii?Q?/6YSPe4k7EyYzF+xMMWJ0k6SQtutMDT4SvNW5J6gxdMqlcWIm0Zwgc2rhcxG?=
 =?us-ascii?Q?8PoOVH8N0LDaxwvHIzjxFC8rBQ97aJYollRFIELvOkGm83AE/SgIkBYctTv1?=
 =?us-ascii?Q?3JstG/sFDYSTO7R/JCaMLkL9yAvYKdhmZlSqR1FdDuGtfoa3leoRFYndvB/X?=
 =?us-ascii?Q?f/xzcYjtavrQ1xVpVmpEYFu8vzdce0OmbBgPFvcDq+WIYXpUstjAff27WJwG?=
 =?us-ascii?Q?AGw+uwX1lzaUxowKHwgNWW5YjfO+YL8rqlD8ueRKfU36kJBLU3HPJDmyc14i?=
 =?us-ascii?Q?BveCO9A8i0WbxLT01nrk2kQh8b5BgYH7GU3sGZvY+sHrQFguOi9WKXYj/SIb?=
 =?us-ascii?Q?z//ddDMSsRHB9q62H9B9fQreW7KjUoADrkLj60JFjq41d0UouWch390dz+S9?=
 =?us-ascii?Q?kaWwKXtQMZ4cjMJZXPimWQyZAiQnJvBihBtGifOysXlxtuH7w0B6nlvLmu+6?=
 =?us-ascii?Q?juTMqn2B8h3tq9t8u6yToQFg2s5r/q1uBIlCdvaX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2684fc5a-8e11-41d4-9b02-08ddde6faec2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 15:55:41.3081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LEc+kcY8QW0F6B4L/3I/PhB0XyVmLI5amrEdM5pFmiddvqg2aQw6UCk4Iu8yoN1Z5mlP2Zf1cGtyafitAKaYkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7787

On Mon, Aug 18, 2025 at 09:25:36AM +0800, Peng Fan wrote:
> Add etf, etm, etr, funnel nodes for coresight.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  arch/arm64/boot/dts/freescale/imx95.dtsi | 104 +++++++++++++++++++++++++++++++
>  1 file changed, 104 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
> index adc63448aa15b148ca0eb8499ff5bc217fe8208e..56d782f423bbba6b38bc51369ab9535e8da2eae4 100644
> --- a/arch/arm64/boot/dts/freescale/imx95.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
> @@ -492,6 +492,110 @@ soc {
>  		#size-cells = <2>;
>  		ranges;
>
> +		etm0: etm@40840000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			reg = <0x0 0x40840000 0x0 0x10000>;
> +			arm,primecell-periphid = <0xbb95d>;
> +			cpu = <&A55_0>;
> +			clocks = <&scmi_clk IMX95_CLK_A55PERIPH>;
> +			clock-names = "apb_pclk";
> +			status = "disabled";
> +
> +			out-ports {
> +				port {
> +					etm0_out_port: endpoint {
> +						remote-endpoint = <&ca_funnel_in_port0>;
> +					};
> +				};
> +			};
> +		};
> +
> +		funnel0: funnel {
> +			/*
> +			 * non-configurable funnel don't show up on the AMBA
> +			 * bus.  As such no need to add "arm,primecell".
> +			 */
> +			compatible = "arm,coresight-static-funnel";
> +			status = "disabled";
> +
> +			in-ports {
> +				port {
> +					ca_funnel_in_port0: endpoint {
> +						remote-endpoint = <&etm0_out_port>;
> +					};
> +				};
> +			};
> +
> +			out-ports {
> +				port {
> +					ca_funnel_out_port0: endpoint {
> +						remote-endpoint = <&hugo_funnel_in_port0>;
> +					};
> +				};
> +			};
> +		};
> +
> +		funnel1: funnel-sys {
> +			compatible = "arm,coresight-static-funnel";
> +			status = "disabled";
> +
> +			in-ports {
> +				port {
> +					hugo_funnel_in_port0: endpoint {
> +						remote-endpoint = <&ca_funnel_out_port0>;
> +					};
> +				};
> +			};
> +
> +			out-ports {
> +				port {
> +					hugo_funnel_out_port0: endpoint {
> +						remote-endpoint = <&etf_in_port>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etf: etf@41030000 {
> +			compatible = "arm,coresight-tmc", "arm,primecell";
> +			reg = <0x0 0x41030000 0x0 0x1000>;
> +			clocks = <&scmi_clk IMX95_CLK_A55PERIPH>;
> +			clock-names = "apb_pclk";
> +			status = "disabled";
> +
> +			in-ports {
> +				port {
> +					etf_in_port: endpoint {
> +						remote-endpoint = <&hugo_funnel_out_port0>;
> +					};
> +				};
> +			};
> +
> +			out-ports {
> +				port {
> +					etf_out_port: endpoint {
> +						remote-endpoint = <&etr_in_port>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etr: etr@41040000 {
> +			compatible = "arm,coresight-tmc", "arm,primecell";
> +			reg = <0x0 0x41040000 0x0 0x1000>;
> +			clocks = <&scmi_clk IMX95_CLK_A55PERIPH>;
> +			clock-names = "apb_pclk";
> +			status = "disabled";
> +
> +			in-ports {
> +				port {
> +					etr_in_port: endpoint {
> +						remote-endpoint = <&etf_out_port>;
> +					};
> +				};
> +			};
> +		};
> +
>  		aips2: bus@42000000 {
>  			compatible = "fsl,aips-bus", "simple-bus";
>  			reg = <0x0 0x42000000 0x0 0x800000>;
>
> --
> 2.37.1
>


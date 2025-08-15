Return-Path: <linux-kernel+bounces-771183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C6AB283E6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1063C1D03D65
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93161309DA7;
	Fri, 15 Aug 2025 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kZTX3D+b"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013041.outbound.protection.outlook.com [40.107.162.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B343B3090C3;
	Fri, 15 Aug 2025 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755275848; cv=fail; b=USwB6eFEqsFprS/oDEMw6aXmyQHm22ynZqac3csiE3LecQ4r0/jIXsK9C6moNHGyvlXboUVhMKVogDzbgTQrEBlvkCMdvy+S2+EcgUF8oaOXChB2GDF3c4/fsQjPIEtEM77Zy4C/K6UVfKJCvergGVvHiNdgV+MIHDJ09LFB4fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755275848; c=relaxed/simple;
	bh=X4qiMTxnjD5jL6MxH8nnnrHairFXnJY1GyNCGZOXFFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y4Q/U4LH02KQusnctE/97xj5zqAGgQa1UWYnw06xRhj3a2pY3+DsAMLO0HVQD50rK9anojMRe+2Pzt4uMsPJF7ZKJXLGmLw7Bx1FGPMNVVtRP6EfwQ5VnjfZnguFpqb11YuFQZiwQoYiRvIHJi43to+Dv2UF2ThC8ed26cgefPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kZTX3D+b; arc=fail smtp.client-ip=40.107.162.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qf8l977LB+3qyoolIc9gtpCs0H9M07AVfxeDwCzJ9TWFWeDBKuJ/pKlc1Zs104hlsJsJJU9nlN2OSVl0kaLl4unzRDa+C8q6PzKoMnZZb0NnV8z3XC/n8ZoePCmpUlOhSTU5aUMnX4O2VjyGZf6aB2GploU5ati3Bjq9hEGb9+YWN3UMebLVwobLBrKY4Bo4GacHuwDdTEjO6+e1K5NZHLzsacwThmm8bGfg9Sp8VPMd63ro12/ss/D7QvbnqZHIa4BUgpYDQ8mR9Rug2qYZwmjQRwZ7E/S2pm78XlnJbt/HJ3Vk7H7DZQKirAlZAjO3ArW7WGjokoUDYokzc+Qy1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHh9e46lJfGZTox6Td2tj5buMm/3FsFlqFPy087Vj2E=;
 b=Pd+fITsnYcGAtPURAHwmiQGzfOaVRP8AXXTnzKFW9jJln6pY7Bjq+EjZ3oBMSbJ1+HHIoymmdSRlfnteXysvOWR5nUQdUYhEXr3eFS0Dtes9w0gvWK2iKU+qR1+zfAZKE/Z0iYYFxZyQXEhr4P4GC20sfSo+gvkqd1Kp/I/vIJXWElyUVgzvbHaCLSHS9NjYCz2l59WNzJbJvNTuVtB3Ch1ig2v9oeYR1DdtCLPYjl5Pmz5P3k49owmATa3FBvVlG7knmRh9WBfbHy3sa2pySjase326a0ianI/4ZoEJkTrD5ir3XEC2qNFvVvx8LQ9teC5rxJF2d8zPVEmzY+pG+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHh9e46lJfGZTox6Td2tj5buMm/3FsFlqFPy087Vj2E=;
 b=kZTX3D+bOwmFF0k6AfDWjSDrzDOXgu3lY7kFisUU1mx0hUc7ELUkXmCWk2+mux7PaB57aTpzUEo93DAPoFe6AYyx362zPOwCjpqknYpbwKIaWm5801jf51IZDImMrqqLRTwyA1enFHnVHvTuDzUqbKm9SLmjsY5AR2ZCcEYgt1LHaSPujxOP1ICaAjbTq+R1Sh7PO/TUPL8mkxnQXVgKGP7ztUMhdfkhxKzI8Urkn2lbGh4/Ddq+B42OrexIBE2uzmR33L+kWpm7DVHUo/OJfFkuL2PgZTUQSb5YhqQ7fwmrdrrSdjdFX4vh0hXRL6ZzutJnLSYHRfCIVYMZr+Mhkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10655.eurprd04.prod.outlook.com (2603:10a6:150:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 16:37:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.006; Fri, 15 Aug 2025
 16:37:23 +0000
Date: Fri, 15 Aug 2025 12:37:15 -0400
From: Frank Li <Frank.li@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/13] arm64: dts: imx95: Add coresight nodes
Message-ID: <aJ9iO+iJL6aZBz0t@lizhi-Precision-Tower-5810>
References: <20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com>
 <20250815-imx9-dts-v1-6-e609eb4e3105@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815-imx9-dts-v1-6-e609eb4e3105@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0173.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10655:EE_
X-MS-Office365-Filtering-Correlation-Id: db46d6f0-516f-46a1-1fae-08dddc1a0308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qLagSiAal1KSN8qj+HLVF8Qo3FOgCAsMY9ggUKqH/LEunkD1jlH5hKVIyhNh?=
 =?us-ascii?Q?5vN/Xf9rVag11onYlV/RuO7RrD1mI3YenhGs/tNkYo208qvB1pC6RytbJmvJ?=
 =?us-ascii?Q?R2SVJjvj+bI0D/BMtlauasmxe/dYZ/l8RjTIIT4AFexSpdIPhlK6CQra654Y?=
 =?us-ascii?Q?mz37oayDB52B+DUES2ZcbL5DeaTdpk6Wy5b9fGFxDUtKPBS3brjCFXwtPkeX?=
 =?us-ascii?Q?ra5d+40R6ZkzgoCKBkTbnZYS72OYdKXGSYUamvy/Iq8UHEdY0U51wi9wK6Du?=
 =?us-ascii?Q?RaN2R4EYOz6rEsu36rLClLVS4Uebi4/PLApA90dlEMAuMmEMhieD53+h6RHK?=
 =?us-ascii?Q?RtX+kIZHgVEkobDWG+BfcZN25r7hPLlVoX2ThQvjAECCaonkTDDdDswqLTtP?=
 =?us-ascii?Q?KVObaIEU31e4BflcGy8EhID8Pz9+fvN8jmGKTJXrhpvuXGOh5u3sHrgPebe3?=
 =?us-ascii?Q?ar+rAOnfM2vGh2d2o44xKqkqcdpCBRrIkGpLBeKeoFShlXErNOOvC9eZnDxL?=
 =?us-ascii?Q?F3snl6HoP2rDi3E9Do+dHqVLVc1299ZHDR1/yY5vyEzbBIADvTdvuWWu1JSt?=
 =?us-ascii?Q?qsbhc54b9RAWVhq6+SZvi21/Ptf1nZAWZycvsSMkvyawrLE0KFA+Eow+kBU6?=
 =?us-ascii?Q?tUlGHohLJ7I9uu4XegM/C17SRhRS58PrqFp1QQyn5hKxTgVI20NP/6zbupkG?=
 =?us-ascii?Q?H45Fu9U1gfqFLvtx7Bs+xdDyBiQlSZgW4qXcFqkgkBBBfgC3956YhgH4zgaR?=
 =?us-ascii?Q?NrDHnTs+85cwL/19jFhOWM0Iy9nk772ybc1gNK9282RJNko1OtdHbhSie2s8?=
 =?us-ascii?Q?3xCVJ501QjVUUw0f6nha1mqGa31n7kZjnt/QDSaStu+F+OgC6+HrCopwdMT6?=
 =?us-ascii?Q?SJAAgNul329j9bRqUZLsHWg/YR5wr8Y+yS3DHgvViDIi3yi4Q1lXt4gRv51e?=
 =?us-ascii?Q?3xPtYG06fCUAGlHZdMQ3iKE7u3jTlqk6LIR0bZ8m740IU2cmio9eqJCagrUF?=
 =?us-ascii?Q?AZeFfxpktdT5n/t/yKiAddpYAGoHGJg5c6dqhI3LfnHR9OZpoDXgm0r5YzfF?=
 =?us-ascii?Q?PVPuV6toqn8eANoJcPhaD6axaHWYIf5iF/adDES9SXXnNh1ywTMpFQnNgS0a?=
 =?us-ascii?Q?vVC2/yUEdhHLo2DvUpP07aMAVzoGxvS6vznggKrTV+/fUGu158fEoEXdCEFj?=
 =?us-ascii?Q?yw7LpjWJQlxW0VqdZ/sjsCGRcQtA2t00tm25H9Ye1y8QMeQEe/0JyLflsZU7?=
 =?us-ascii?Q?VQttyRHb8JgwHfxmihotmt7xszjL2DSTk3VAAgJlmzScmUXHyI4x8AkmpAKO?=
 =?us-ascii?Q?MRfmZX6o94Q4l57dj0klkzsik8hZFoctYTg26UJeuyAYWXaglUupew++qtt1?=
 =?us-ascii?Q?X4KFVH+KFRr1t4+TsmG1omI6xFi2AlfzEqiud+gmfjuwKbL0Ui/DJnfGEJEE?=
 =?us-ascii?Q?usrNn27JtTt1HSTHt6TZ0JqlFQTxE9VzdIx0qK7d9V9YgqvlqOnu3g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kw0pHNYcoVPqjmoO4EHWnJ7T/BcnivDPnJZi7xB09KuGZWftGTHZlTb9xqGV?=
 =?us-ascii?Q?B8NfYWxIy6VLmbJxJmNw8j09UxTyvxxMc1ZEvU5b8+7wMciRijl7SOOCfw5x?=
 =?us-ascii?Q?hsqbYvaXePTqPCGE5PVRu8fHQOHRUJBNSWYAJmenNriSge2tDRGV1haRIh7B?=
 =?us-ascii?Q?G8c8pk3kFEQ+rZ+lUoPAnR7r94TIb6Bmro75aaBWO/q7cWo7Is271ijX3Wzt?=
 =?us-ascii?Q?tI/TegYI8nCOeW90qonzYZu/PJYxLdiFpZW5OHfNplZAtoPwkPcMygf2Ueen?=
 =?us-ascii?Q?2pmBN9+uAOixKi/bMaS3rvwC1y3wcyxAogPwKwO7g7IxNeMDox5QusYLEZur?=
 =?us-ascii?Q?JMJ0u5JVR1z3lvNeL+yNNRATYVOyI99gT4B2V9puMcwWtdR53sHaJogdXwWD?=
 =?us-ascii?Q?Y1yuk4Ll7tlLWqNFyBld+BxsEhTQQ/VbWX1LJxtydlFeztW3PpyAi79qltPA?=
 =?us-ascii?Q?peZkxQ3BvOUckIibBEyygqsqgpoQPq/er78BwXvZplqaOSqo0u+YScoh0ccL?=
 =?us-ascii?Q?0y/P2j+n8La05cm3LDL1cagNoQBMvBkb3240jaEyn688nO/PKXsi96844+W6?=
 =?us-ascii?Q?Prw75tAKpN9uhjwZ3kUvfnb20xVFid6SaJrHu8g9l+Jr4+rs/unhXsWCXCpf?=
 =?us-ascii?Q?xeUSBBiyJ8stIm7kiVB7M+EbLZqTarteCn3vAJYwx3zcheh1GhpIo3Qxkd7Y?=
 =?us-ascii?Q?Ud7bdBcJtiGIbkehvusDbgExYSyesyq6c7BCECAAhzF1kyQiepfulX+Miqa6?=
 =?us-ascii?Q?4e0VJuviQxLncQYl2AQF9JynGPwRpRohfeN7ZGqowFO8FghAirsVHC5qffgA?=
 =?us-ascii?Q?55ncUUwMpIZhLOVB6RZljoLtYVD0m6SFrsMbnoMY1Ka6MNus1klbq0UzJ+ZO?=
 =?us-ascii?Q?Cx6Gm1oL550/x5IUNlJwPLzBtCSZ329exOyRMN0vE1VbI2nA3H/ipTC2ewlP?=
 =?us-ascii?Q?d5j/7AGTXkauIW6ZZjufKtcvwk6LqbU/WIylalOaVHoRR4/RJHOvC0QrMTL+?=
 =?us-ascii?Q?YOFOtYFY8whJ3R5+NozHuzf8jKo3rBCQ3/R7d5/UW1bkUM4JEZ3WjIKHgBG0?=
 =?us-ascii?Q?EVHbeeDD2FZqlxNJKVI/j50I8dC7xc+R2dcnqVZFlHQ0Nk6hlyOJQ8iPoWFX?=
 =?us-ascii?Q?UWEisp6lmt0cUqQ7iA9+GxCHFFRC/8y7+jSZJtpylEXfVuokgraaWC4fKcAV?=
 =?us-ascii?Q?AUcfNs2JIUDJyOk2O3f/4zJRJXTV/rBbql3ysSI5zosdZ9+J1WN3GFLBxB3V?=
 =?us-ascii?Q?garfOOdHhTTSV6xun67WSy8dZzSviavXFjsfL+XtBlSwcYzI/Di8K7cAPz9J?=
 =?us-ascii?Q?Qc+i1kjJzvdtJgiGirraHfKmx8cli1STl8EVMZfcXHGoPKETQgZY+1ZM/vkA?=
 =?us-ascii?Q?AQtl3tzCn7SXdeBCU/2FyeK6s+1YWn9rQ2yy6VgzjRe3GGbmMAkyCp9ySl5V?=
 =?us-ascii?Q?XgR81zhdG4k9G6sPU7O+q1RLAJpYgTN0UCvYWqPB+USulr7WLqLO6UUbJImi?=
 =?us-ascii?Q?J+dlCkkkdqDJvUSzOcewJAgfDz3BVBEqh8FITd2rzhxnWlruIuNuVmnIN3Hb?=
 =?us-ascii?Q?UorMPuwHNSbj+I1W+JE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db46d6f0-516f-46a1-1fae-08dddc1a0308
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 16:37:23.5840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TSpGN3vWeL/64+PBrmr84eZnzIHTRsdHLCnLmIa5Vdempx2eVxyvyjR8Qp0EYlGgHLxBl1nCOVxgsFMQ8/mXyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10655

On Fri, Aug 15, 2025 at 05:03:52PM +0800, Peng Fan wrote:
> Add etf, etm, etr, funnel nodes for coresight.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx95.dtsi | 104 +++++++++++++++++++++++++++++++
>  1 file changed, 104 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
> index adc63448aa15b148ca0eb8499ff5bc217fe8208e..2fbdd9c7ca099ba6971e4f6914be680a5b96da36 100644
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
> +		funnel1: funnel_sys {

node name use -, funnel-sys

Frank
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


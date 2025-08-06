Return-Path: <linux-kernel+bounces-757982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6B7B1C949
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22A99189BD18
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84ACE293B5F;
	Wed,  6 Aug 2025 15:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QWXq7YIi"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010049.outbound.protection.outlook.com [52.101.69.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62682904;
	Wed,  6 Aug 2025 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754495352; cv=fail; b=HDrzPr/mlTrGI63mSV6GljBFH9x+AabEn/GPibVrZjLfHTqxEfMv1iTyCMuhM5H4wk17xLYLKlY5F46mFuls9CQ9suvPy08uMB15b634gJZvBDGYiro5FEUBWTJhRR24OIVW7rVatuONc5UWY/bfTpdmQS5+8ds9grYFHQMqVlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754495352; c=relaxed/simple;
	bh=PXD0z3sVbVQUVYQRymnTBwUArCVCI8uHK5YWYMdvPts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Uv9t5sZM0j2YD5qKihNwFloTeyzvXYrGGxjFJCwE7/vb6eeiYwSy6oCdB8cggrZJPHvwYS5+VYmQpD8QwLSht/ulLCv85mrp6LKLfzstrHyPe9r9ZH8GZOIU1gFGidCIy6d9XXXKl8aT7dqOn0qjZmdERLsGeg3tJRKvp0f0HSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QWXq7YIi; arc=fail smtp.client-ip=52.101.69.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tgXRyGSUwLd+My5EzmjnffkaYiOMVf0DJiDHWywCeNRVHldwcNQA7O4wZOscOEHF2LbWC13k/nWxebv1oOGAR0ikPCbdeR2CA4elUroBwoHYjFtvOTzgoKnRDf3mMOi6OfHI0OlNZZOPiTOfHrFXIsjSlCYgpv1SQUsTw+Z+MqhsFJnLI5AXQ04GlhRtf1XobmQkm5Zzx46XCuwYF3ITwveHoHgAc9VpPy44aYQ4y253Fb73kyjqZg5lem5L+3wJR7DuinuosRNkHAJn8E+90Js+qK/Ssy12L39VGMiRaQmeXNowdEmErVPq2CkZz/mawmr5mzw7x1TziJDTsNwq9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKUMkof0yDSklPJvNUiOC6HWjmCacHq0KUBY+XOiAjg=;
 b=nyTiqIkNAyOPArKTs8y0Ih7+wNSdLPfjpuzUO5SPAZOM2/rLuinG/TQcHsuTi4LF3Q/RxHshWoVJDwE5eQ5dOL1/Pg0eMlKtXf4gn2oqN2f6+XAOpmegftkQcNqDRO5VKmPW9OLI4S5xvTuP9zfllu4ledOTdcNrdST9FIzR2z28hckPgUzO8lKODYqM5N9FKHivibS/lKPo02t5Q3t0ik1resQN5IDJTdiNYLIPaxkerHvVnS5hhJk9AHenrAMVTjpEKVBN1sideJlX59WyFFJpxGqL5K5DqDfVm4L2/uqBl7sBax0Wjd4VTbOmz75f8N1f2kFnlcgbFV4f2NdvzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKUMkof0yDSklPJvNUiOC6HWjmCacHq0KUBY+XOiAjg=;
 b=QWXq7YIi1qFKhdfo6JiXc4v5w2GONtYmcQdQk71cnN4RcvLVfmbW1YT/q9xKdbYFm9mFowcIr3DIf8ciq+6MTGBioqLGmWbEjdE8lGT86EL3ht5m3iMMisT6AdEs84xmtzvha3xeqToup6BDHEBt+DpPxYObjEGSxqcYA5EsyMLiW9d9prRY7ejrGwoAduyF46jKkaRWzIskt80ehd2y5Pnv/mG52vdF1vgEnPmBNUefY/TX09x+D3/ZNtO1Nu9iV3SSSYJHCFZmbz1m8XD+y6LJZeV2cYSVzLYxPqgLsoM6E8oem15CHztuZJw1bMvzEZDGlDvgdxmqbK6Ev4Yu/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7776.eurprd04.prod.outlook.com (2603:10a6:102:c4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Wed, 6 Aug
 2025 15:49:07 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 15:49:07 +0000
Date: Wed, 6 Aug 2025 11:49:02 -0400
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: imx@lists.linux.dev, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 8/9] arm64: dts: imx943-evk: Add display support using
 IT6263
Message-ID: <aJN5bs0fA0NGfwxf@lizhi-Precision-Tower-5810>
References: <20250806150521.2174797-1-laurentiu.palcu@oss.nxp.com>
 <20250806150521.2174797-9-laurentiu.palcu@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806150521.2174797-9-laurentiu.palcu@oss.nxp.com>
X-ClientProxiedBy: AM4PR07CA0025.eurprd07.prod.outlook.com
 (2603:10a6:205:1::38) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb2a3e2-3da8-4509-5256-08ddd500c733
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|52116014|376014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/7P+2/crUmTHU2ufp7QWpJrY/Uvej8dNXZtCRz+NSBaZYsz40YgQC20PfQGl?=
 =?us-ascii?Q?z0zZaQjvWQcccJ8DDk2uIBadyE2h1PUQxsaV3YVXreBd3MGUBCoEJvDuapii?=
 =?us-ascii?Q?pVvazxebwj6BXlrJzGeNImrNoR0oMr2Uh46fa4XRWmMsueVi+XzxPjNyhfIk?=
 =?us-ascii?Q?FE05GHqMsf1cc8fKlMAHq10mWchWZ76boiRc/kjwMWI7PnxqdEt0sXoHBe8x?=
 =?us-ascii?Q?pqPV8ivOxZ/ThmLsY3gnUEyJvZrOw6ju+a3dv1WDoNR37DdSQEbfeYY57Rh8?=
 =?us-ascii?Q?S9eaEjUrIsrKyPfPEaduUPPGAG3LVaQirGi8dj++5OrMCO9qvSck3+hPGbr2?=
 =?us-ascii?Q?i99A3eftVAPR6Na+vtLatR9ePh89eFw7eGovt6tD80yBCtzxTWuxtRp2B367?=
 =?us-ascii?Q?uiPSPffUbjcG2K6GqGkspBg87GrHU1zHmdlDq0D4siBdZG2JQOqJc06gnRdy?=
 =?us-ascii?Q?v6ERquDYdfbRiCAeI0FG2Erjo9HJE1KoqB4d453ZbqR0/gr8U5N3rM6lsevj?=
 =?us-ascii?Q?v+RvELtw7VP5+rUPV0fBWBe2CHZs+fVXWrb4tdTPEplpg7keE1Wwq5YidWnT?=
 =?us-ascii?Q?PHAxTdLomDIfKBFGTWIgOsQ2eU5ljmWculVeM+2datY56Z2yZmdonYMWI+dC?=
 =?us-ascii?Q?GukWsD4wv9yyZFjsj0XLmJiuybFDt3F6iL3+8a4ldh9BZLgbjnnT4luB/4Db?=
 =?us-ascii?Q?eEaMvF/dB1yxVYh7PuHTS0b/iVJlcGjDd9Rat3fori39GyfQRGWT1hpIBdvi?=
 =?us-ascii?Q?P7ctv+rkhU2jmgDdtDKeysiqSDe5TNNUo7lwT0noNlZSGqV/mvLy1fF7T7Bm?=
 =?us-ascii?Q?n1dKoaOQp1IkR7908Gk7wdkj5f9QhLgQXmo28syHhkUiwe21g7y9XFcZuf7G?=
 =?us-ascii?Q?saZjBgzTgHs9tI9YwMProqR+kN9XOihecCl7j4v4q7cK0fDjKBDXgro6DS7I?=
 =?us-ascii?Q?XXB2LzPU+Prbr1ZYtDNzJ/fQzWTYbjJP2tFR+MpoTIF+qrhwfdUn8KCsEJBE?=
 =?us-ascii?Q?p6k3C37Dmtbjrv1LLsJoLNZanpZXAQYdCzEnyCFdeCA96tf0OJIzRQc1XwaD?=
 =?us-ascii?Q?wAoihMTWdYleks6vcCVxbFG0qjogoeP7crfItMak8rfLR7KDlwfSZDHy2l8/?=
 =?us-ascii?Q?kNM1KyxGvDQirzLAf1c0rSqU3Aacf88SMGxXa/r1JbPHVV1+8cAktPiA3r84?=
 =?us-ascii?Q?2Fm1T3HNYyDrGvCrbL62Wi7wxQ0huZ2yCoBSTNyBMmMUJU3zzEAUdBMgzIop?=
 =?us-ascii?Q?47s1ajLxCnLDEb9+c2sOLmfmTTkwbABM+78DcqVsXeCxS8MRBff+Fy2eM4vy?=
 =?us-ascii?Q?16qa3D1qjhUjiWiIsdiC5LJcQKOy9h+1h16ekZaN6hudPHPcNhFLan5Q8X1T?=
 =?us-ascii?Q?lu3xUZcay6HY3fmPyDcCeXDSvaCFpKfymZ49q7TAU8dzNg7IQbkdvGDyRKTf?=
 =?us-ascii?Q?pXnIaqAn4sWPuxLUrLx88qRr4qu7o9dIq3YDRATSJma+vKpRyAejng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(52116014)(376014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cr5L+vYWTYXQhDvxyMMXZyna5aqdRngAHKdE6pxN7bqygwu7a3VEr+hF7FKe?=
 =?us-ascii?Q?Piad9rLJnDIqYog13WEyk54qvOURAA1n2EJv+6Wyzna7MTtrimglAaFBAJFu?=
 =?us-ascii?Q?qRawAqRPg/Brj5dTXDbyfK1cvaLFxjmUj+nDfXq5BTMgGaYdeLd8TjuCTl7B?=
 =?us-ascii?Q?ydt3zCxs5EqekpglvbVrpNrqlxxsz/AcvyWvkEbZwgeUkWeYJA1wYaRvEfN8?=
 =?us-ascii?Q?AQ1hHwfBL33KbKbzXYjZCqudHOMSNTYTk2lM2PdpqYPRF6B8LqXhtLT1SdOi?=
 =?us-ascii?Q?CkiPRzXcqnc+sZpeF+mxrG5RsevX7IwS3O5eecFHKJMvXxd/ju4MsvZKwF7F?=
 =?us-ascii?Q?yDHPfoyJzAMIMbBeE4j5+fwgXn9KfJOl+oc9EaD0QMGF2/tWFCoiylGhhSN9?=
 =?us-ascii?Q?+Vw606Xz81t8a96C5vBBFM6KsiiruzTQ6y5hmb9V4D+gGZKr3twEjh+amE/m?=
 =?us-ascii?Q?kw80MvSlJC83k/5qhhb6vDZxKhuf3sO0iggPr8MmOIuATm5ptyeot2KBbfeN?=
 =?us-ascii?Q?4Cjg/UXJdsk+xfGkfiQnTBDI+vFkyLOsbnyqYT7+S6sNI+RLreA7W3rxRXkR?=
 =?us-ascii?Q?/x4p3eReTFRJ3e2mmxL4WG/inKmIFJwWVbfdYUPXHeED4we1t7C/QpBox1Ca?=
 =?us-ascii?Q?Rgnm4VbaQPE8ybdjMr2SLp6y433Ke/Ag1nOasT2SVI+eYsRG2wtogCQTmXID?=
 =?us-ascii?Q?MIioDU9j1NYxWoNsLG1NVe35GfvmbrdMbCeSpHL0HF4rlm6bShfudVac2kCv?=
 =?us-ascii?Q?XiSc60D8jFUGE51yOzcbXw8/8olgIqkRLjC72LJ4qayA3gxMrzPTBWyfNAew?=
 =?us-ascii?Q?NuFjpvCsz5m23CfmbOOPJe1oiTWorEZd1ntOfvJ3UJfaJEPRqBQbczgoSG2q?=
 =?us-ascii?Q?cXDlANgEV83zBMyAyBC1fTB8MLNpiS85LxabMcFn05rrQU5MnBlyGXQeQG4N?=
 =?us-ascii?Q?wfIsYA/Mh5Bdmdk32OvwHbpOZKtCOvI27vd3edD0lXVno4NQGma8+z/eb9NN?=
 =?us-ascii?Q?QkIGTDigpa0Fh2+TpEvC0itti7wOm6hRGh0rJXTIbSCsrh878a1b4/uBztsN?=
 =?us-ascii?Q?4Ia+bnPeM37YdZ95/i2b0bx37QHMJ3sffTXjiScll+bUoyFdc9umq5pp/a/w?=
 =?us-ascii?Q?SRXLYcxMHnBPyMacY6rKufYNgBKHA2HA7+KWVuY4x/rmdbYasblJriYq3+o2?=
 =?us-ascii?Q?/2yVpny5FU888onGX+/h6+a7SV0dmYM81vPyrUchAZQaKG8Xa/cWyrdulvMb?=
 =?us-ascii?Q?5gC38K5bPVWuwn1uBo3fDuQWaLjMhjtUUtG5C1PPIz1TQVDzITjipkOAXWLg?=
 =?us-ascii?Q?xZq1DhwqZwCETmD9ntft0/SJk9x5NIPUYxDEIs7LsBVNz/2JjGA4UUObB+MT?=
 =?us-ascii?Q?3ABb6qeK5tab/+VcklhnVLdLhVLDLcBlUnyZH8Na8bQ0g0oXToIxbVAIwi1P?=
 =?us-ascii?Q?uWUhyzV3OYTM3Oyv2JFWMRB6saxYo3rmL0DvSjHy7UQRuc3IFPcjVXH/Qmxm?=
 =?us-ascii?Q?m8IhzoyLaN3DQ2NVOEhbF0aH5Cquvfezo+TwyOyIcQV9FbzEYWLDym6rKBgT?=
 =?us-ascii?Q?vr3/m3LOlkhUIknYRCQmDDtVmnWeZiftNJ7zXnA0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb2a3e2-3da8-4509-5256-08ddd500c733
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 15:49:07.7420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0qAIMGaotMdf3eIdHrnsew3oTOKG4A4EKZ828tN2Y4biw81YvxWeAa4mecE0wU43IcGyxvfRMi8GBt8jxZ7fVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7776

On Wed, Aug 06, 2025 at 06:05:15PM +0300, Laurentiu Palcu wrote:
> The ITE IT6263 based NXP LVDS to HDMI converter can be attached to the
> i.MX943 EVK board LVDS port using the mini-SAS connector. Since this is
> the default configuration for the EVK, add support for it here.
>
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  arch/arm64/boot/dts/freescale/imx943-evk.dts | 121 +++++++++++++++++++
>  1 file changed, 121 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx943-evk.dts b/arch/arm64/boot/dts/freescale/imx943-evk.dts
> index c8c3eff9df1a2..5900ff355abc2 100644
> --- a/arch/arm64/boot/dts/freescale/imx943-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx943-evk.dts
> @@ -34,6 +34,18 @@ dmic: dmic {
>  		#sound-dai-cells = <0>;
>  	};
>
> +	hdmi-connector {
> +		compatible = "hdmi-connector";
> +		label = "hdmi";
> +		type = "a";
> +
> +		port {
> +			hdmi_connector_in: endpoint {
> +				remote-endpoint = <&it6263_out>;
> +			};
> +		};
> +	};
> +
>  	reg_usdhc2_vmmc: regulator-usdhc2 {
>  		compatible = "regulator-fixed";
>  		off-on-delay-us = <12000>;
> @@ -127,6 +139,115 @@ memory@80000000 {
>  	};
>  };
>
> +&dcif {
> +	status = "okay";
> +};
> +
> +&ldb {
> +	assigned-clocks = <&scmi_clk IMX94_CLK_LDBPLL_VCO>,
> +			  <&scmi_clk IMX94_CLK_LDBPLL>;
> +	assigned-clock-rates = <4158000000>, <1039500000>;
> +	status = "okay";
> +
> +	ports {
> +		port@1 {
> +			lvds_out: endpoint {
> +				remote-endpoint = <&it6263_in>;
> +			};
> +		};
> +	};
> +};
> +
> +&lpi2c3 {
> +	clock-frequency = <400000>;
> +	pinctrl-0 = <&pinctrl_lpi2c3>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	pca9548_i2c3: i2c-mux@77 {
> +		compatible = "nxp,pca9548";
> +		reg = <0x77>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		i2c@0 {
> +			reg = <0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c@1 {
> +			reg = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c@2 {
> +			reg = <2>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c@3 {
> +			reg = <3>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			lvds-to-hdmi-bridge@4c {
> +				compatible = "ite,it6263";
> +				reg = <0x4c>;
> +				data-mapping = "jeida-24";
> +				reset-gpios = <&pcal6416_i2c3_u171 8 GPIO_ACTIVE_HIGH>;
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +
> +						it6263_in: endpoint {
> +							remote-endpoint = <&lvds_out>;
> +						};
> +					};
> +
> +					port@2 {
> +						reg = <2>;
> +
> +						it6263_out: endpoint {
> +							remote-endpoint = <&hdmi_connector_in>;
> +						};
> +					};
> +				};
> +			};
> +		};
> +
> +		i2c@4 {
> +			reg = <4>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c@5 {
> +			reg = <5>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c@6 {
> +			reg = <6>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c@7 {
> +			reg = <7>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +	};
> +};
> +
>  &lpi2c3 {
>  	clock-frequency = <400000>;
>  	pinctrl-0 = <&pinctrl_lpi2c3>;
> --
> 2.49.0
>


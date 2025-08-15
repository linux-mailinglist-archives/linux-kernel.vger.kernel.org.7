Return-Path: <linux-kernel+bounces-771188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B15B283F1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3272D5A87F6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C5230BF5E;
	Fri, 15 Aug 2025 16:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hjQELzZk"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010019.outbound.protection.outlook.com [52.101.84.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D87730BF4B;
	Fri, 15 Aug 2025 16:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755275959; cv=fail; b=NUVeW6A/JeFxCMl7vAn6L9BsgzJ2CL3ZHgyTNYsgUGZ/4i29Y1FeUJiCfqs+OLIpTu0A/Ihl/Q+a62pYc+IPMEvkrZUIgv1vU+JW9RmF9QtDPoeNppoa5kitj08/+iopoh09ZQgneuG8Jk4p4Vb2dTr8v+f42Y0BEMAZNN3dagA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755275959; c=relaxed/simple;
	bh=Q246ITqqqweJP2AOG7DidpHrZ7n81awrFV/jFvD8C6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uqa+4Xem9T9PEepBOGo0nXe4Tusk/OHXmXQQ3AndNEW5D/yayyY5nZdOGv/kOvh/5HnoHJ5gk8mCZi691gtE8KXbRRC0xonUY6vbQ9121V94JrOXzD28kTfU+WJw+j+uDMPBGxbe+juk7TeRRlq0+TAOdXzmKUWLHYoZvBzuKcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hjQELzZk; arc=fail smtp.client-ip=52.101.84.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+Q07Q9pP7yAwqxnKSoaIf1h8jb0LVCekh0yKk26+VhONRaTMRS6ol6h9GmFHUu0UIvN3r249KOW4p0akjMlCg+eS8I/TneVWIVsLKMmj/KiBx1Vm9fI7PK34TQTN1DIAIojrbxECGxo4O0UStYDI1Mf8iqC6AhKr5f6WTb9l82a/sl+BisjtcOh/uH85SdzMTAJDsBdvEsVPSCn3+tWMGuJFPs45h6Q5BwlB+THUcIoTZXpjvIjdaAwecapCls6lHdOEsdD3MW4TaSJ/hfybKZ65pGjvCU9QMQqfUqddKmGXYcd5Npxpj1cTEc3JR6Ww/HiEE59ue6w4JUB+0QFVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQ1ZiCMxulyc45mrsQowxPGphScu0uJzvY4QFGA+dHc=;
 b=f/PZOcs80rsILRWdp9QY34N7GpMcMjJFAfQDEgJ5646hqhYAML7n3/pOW2vmAR5ZzOVegRjagYK7HDV0Boho3Img9Euao/tj66cDuDYYceVZpk75D2zdgDR5meZMNdPKWr+xF7n1/DPdz60R3uRoWbRX1SiVLLqG5zIdDvxOqcT3mCqi512ui5Ne9Ll5CmrVVpPwWqxGox2M20TtfenBPw+0Ks6Aylnd3ruLq/2Z2p8/JbAkqUfUHiBIHm75loUhjB1mo9gdWg5MEvNmsTbfBTlg2FvOz56cGFCR/0BxvJ9eSxcIxnrvGdfWnBMW/u5A6Iph7z2h/fHQalH9tlttOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQ1ZiCMxulyc45mrsQowxPGphScu0uJzvY4QFGA+dHc=;
 b=hjQELzZkSVjEV0mr9R7ArtICYkMrIoXZk2tcMf2tgvxLi/5vsUdsVPdt5R7Ri18vr5B0VgStZjaTu3XpW3DgcWo4GzmzigkuZbr0VHBPGX0IUgVksiEWtnyx+A09+FkYrJUsDXMAFHcO27vVvtejBno8W1cx6rZbgRgrQTScz8upl+TRGI+SsuiO//t16xzozkKblzxPgGQgkJF/IW1EHFS6+cvE5UQw0bQxMW1I3qN8eCJZ4rGTkjm1PPlTHx1Wbsu9Xbu9Kg4PPXZNEAsJA3MV++InpgDUTm45x6nIxnKF1uahVA2LzmW6hN2Hx/9ZU62mHt+QRyb/sLlMVDlfXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10655.eurprd04.prod.outlook.com (2603:10a6:150:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 16:39:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.006; Fri, 15 Aug 2025
 16:39:12 +0000
Date: Fri, 15 Aug 2025 12:39:04 -0400
From: Frank Li <Frank.li@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/13] arm64: dts: imx95-19x19-evk: Add phy supply for
 netc
Message-ID: <aJ9iqIrAqTTx8QIx@lizhi-Precision-Tower-5810>
References: <20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com>
 <20250815-imx9-dts-v1-8-e609eb4e3105@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815-imx9-dts-v1-8-e609eb4e3105@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0073.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10655:EE_
X-MS-Office365-Filtering-Correlation-Id: f1bb27dc-cf46-4810-de1a-08dddc1a43fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bpnnADP67UdqMwzfWbs0dEMJlU0qijIuPnp5fF8ZBybW6OpXavZtO0IZ40hl?=
 =?us-ascii?Q?ov7w/2c+quFoo7AwREedkz1KEEOpCVRlaEegEX/yhgGqWVQ1j2DFDgk7YGYw?=
 =?us-ascii?Q?0fxL1WyGmBDxyMyezEywCnPND0Jfcntc+z4Og1/RW0zCtLOztOJ4suxjVaKY?=
 =?us-ascii?Q?iV4htbCgc4hMlhsnuqgMHmE0Vxuc+1V+uyE9O2eCmYNA0xo8qD974ejPtCaV?=
 =?us-ascii?Q?q+p2z+74OhjrGOOqxpfYSCwy9Ori1hLe+cFFWxPi4lB+SuLaeoNnEVtLJ8A9?=
 =?us-ascii?Q?3m1o53mAy3l3E5qDDcK85PZN6f33LCdncelCzFM0Q+WLOKPker4KZ244b4dx?=
 =?us-ascii?Q?P/WXyB/Rrnnh2of5c3JzOVHGPwJyBY3Uo/uKkMAuudUOWemE1NelD5Zygyws?=
 =?us-ascii?Q?AMd+3SOCsDS20UBlHJxLfPdncx2hdu90Q0Wae6B4El3YU6Peu7kAm8ed1sxw?=
 =?us-ascii?Q?PzHb5FBN5G5Y9Zb4w/Op5gabRyCt0J30g6B5CjModrZ13F5Aq8V0VKyCWh/N?=
 =?us-ascii?Q?4uA1+RJ/+KNLvJsr+nTJ7clbk9smDiIkPGeV9PWE8Ez1PQf3/oQC2ZGnJjio?=
 =?us-ascii?Q?THQQyx5g81SWYhKpPjy7tZ0ybff793CkgfxyP9LUCk39ucOCiDNXDhk9HncM?=
 =?us-ascii?Q?7bzLDLor7MDa8DqI1Z3fOhbaBrBQShQ2Cu8yHSHtFo+Sefh+muLCBvHf37Jl?=
 =?us-ascii?Q?xMbkDLyn45tuOjtUXJad+O84hsvdTKDRbGcN3taNwX/LtyvRBUG4UjlWaOgP?=
 =?us-ascii?Q?mQkoGcvqW7qh6Q0JW1lDkslouOCFSWoqGZSvsKooLBwdGkV+gwuE39YqHSwo?=
 =?us-ascii?Q?n3xT4fH00qBxP5c0Hk87PabB4/pdbIQ0Br9w8M/tf1sL/pmJ3OHZyjdnUsvf?=
 =?us-ascii?Q?VokGN+wZF2s614l+QOgMTvRXrT6TTYQjdnZr2hJepu8QW8KMNZ8gvktUEoBL?=
 =?us-ascii?Q?QKC/8oB+nG6pfAVHlm/y2+FvGn/kl2q+71Fxe4qLcgtCtGbBe+cekiaUbSZ5?=
 =?us-ascii?Q?yakoYqxKjlofnWg/3mR1Tp2cGcOLtbPcygRMtrePDnMtMxZIOAeTZFnyn/wb?=
 =?us-ascii?Q?TJE7hAueEER+mFM80eEeioq9akQN3DyIJ2EgEBUDKJ5lnAGtCZV/EAkuxe/n?=
 =?us-ascii?Q?HaOWExBBxlxThiIvp5h9uw6/UXCZu/bAmIafhOy54zccG2/edRJraUsAMYaj?=
 =?us-ascii?Q?PKJFOtx/2huQdwpk3LylEV46ffEJ2PfBZTpUEEps4G0K2k961a7qki2ZeJ5A?=
 =?us-ascii?Q?V72UtMjatdPMLgOBOGKVf+48NPfjC959TB3U02Gi+W25xCjaivCofoeKQ0+K?=
 =?us-ascii?Q?WFupxO8aU6NIF2Yhm+cr3uuQrFj6A5i80HFiDfoqnAwjJiugLnLCtPBA2A08?=
 =?us-ascii?Q?MLjLy08ZAXIjgxNf2YATaX1VBUkuIAuNcwe1yjwy8IxLSL0apTn9S1l7BJxt?=
 =?us-ascii?Q?NTqgQona8k29vCfmDT+B6C/COavYfSvTyeonVY9kWXfyz/OFivPQOQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sS5tkblZ/CqUgcruIMqSfDV3JsyMflL8duCox+CpLtLkEA2KnuQaQ56pd0YY?=
 =?us-ascii?Q?l3NVclXClm4/6JIk4HSWGiA4emESIe4Lj/o8Qe4x0KfQftXgoXSCL6wuviK5?=
 =?us-ascii?Q?W39Y7KK/pd1RwaVv718idGix/W/McOqg7wPjc9LzcdtdOXvigHdy/GNICFb2?=
 =?us-ascii?Q?LvDX82dvYvNvZEqGZ3gBnPtEDG+3tX0e3E03PNd33K4SoM9GyB9iHL/AN1tx?=
 =?us-ascii?Q?0BrNYFIK22a/WRVaS0tc/yruBrgJnGLaBZK/7/HJrpMVyjr5m0kw1QDDw+AW?=
 =?us-ascii?Q?aT8adG1jLg2grzuevTcwXYR6QtwR8huv/F9RtDD8824vO44+HVZm1DptwxJB?=
 =?us-ascii?Q?TiH5TvJ8/lDciqa7/JGJjye6knSo10HgjV1izspdQbCvhhgeptHAR7TrehGi?=
 =?us-ascii?Q?iEYSgNPrhoICBcuNVYM047StWXSHoHmnHmKLJN+2gj2zRynlRd5mzkvDIleG?=
 =?us-ascii?Q?7irCO+pm0eq6E0+Xpo8Xx8mE/Sn5gkdIbp6J/paXFMtKnCpf+pERcHZQ1g25?=
 =?us-ascii?Q?JIhu84473p5TW4aTM8MZg8RHVuzjCx7psxZYcvCi4xI3M3QloYxv+c/530Av?=
 =?us-ascii?Q?zP9Kk7WR5evPin/vmyG6rkfjUI/Trgn3HUCJvyLMgrpIHdTaqUVZI/fwLyDG?=
 =?us-ascii?Q?vAjjWs414my+nCV2ICxKMwwd8yEG48XJHysA6/oBeLqZFeauYqvaO9Pv+K3g?=
 =?us-ascii?Q?noIzGxhMbVUrrtJ3jYNYE6V/QZmoxYApTx2+j+p9H48nauxWMzfcM2lJfVf5?=
 =?us-ascii?Q?LoxvCEp57im9oA5N74PKpiLNlVK77CU7DFJoiFgghKdxx7XzqbO3mULh1ub9?=
 =?us-ascii?Q?SeeUWtGpq0w8qfebqPcg1ET/Mr/Pruf3/ivzZPv/gfg6dlRv7MxKU6b/3b0P?=
 =?us-ascii?Q?qHld0cswkfXjx4cjGgp42n7kdCeDmMsLHOjjbB2dAIEKZBLyzamCJ6hiv4aA?=
 =?us-ascii?Q?IbWSu4sZAiy9S3jt1adXy3eYc7EyQNzj1m/nQ3X173Bx9AB/1b+eax283g1r?=
 =?us-ascii?Q?FzkDVSjuVcyM6txHVpoigao5DKHsTRRWDtowg6EbC+xKhG44S/Wf2ryL+klm?=
 =?us-ascii?Q?V4MaV/gd6N3s1LpY1JgR+4a8xyhQT6w9u+eXLM7a5g1Q4pT1XvEOlIFRdFW9?=
 =?us-ascii?Q?6SNPyilKk7nNASTD1dUxnbP1mWj+ElalNhJXO0AQrzvjftMxS+dkae/i+Y3M?=
 =?us-ascii?Q?o4uS/fSb7ZWbXww9Eq9Oz9iu7Z2ZgI3wEHmseg7MG57wEjAPs4JSkCj7DYLH?=
 =?us-ascii?Q?wzIUnVuR3lNtktacdvzWnZkXZlJzY+loYzVMfCQPVVPQSeD51cejw2t6f5qu?=
 =?us-ascii?Q?fpFXhw9+4kVVB+hCbCzFWzmYv4mcKnfSS4lOIeKnDsObGn/n7W+zh7ycCYKa?=
 =?us-ascii?Q?69yJx4RUN/4ciOGzpfeaY8+W/G3HIDmCAOCoiETeICo2YCw99FwRMAHRDegh?=
 =?us-ascii?Q?X2XlAKjq1wBVVdzuwxicz3/PqfltbhTAubY9/js7WqeqoSuyzEeEEWB5fpV/?=
 =?us-ascii?Q?e/kTHbjpxOiAvYpHcVjwPwviZ+LeKagIJhmsksjmo975BQOkjhY0Of8yA3Mr?=
 =?us-ascii?Q?xQfGVMWiPjUWZ39fWrtMlMWJ2natQxrWlVyc7Lst?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1bb27dc-cf46-4810-de1a-08dddc1a43fa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 16:39:12.6039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H+DBn0IZh/r+8xNpB/RED7LZYoawrPgj0ZAju/Qr4m/3TdR5Wu2mABkXmcN7AASVeeb95fjvvI+1f16zYyzr2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10655

On Fri, Aug 15, 2025 at 05:03:54PM +0800, Peng Fan wrote:
> Add phy supply for netc emdio on board.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> index 39815b21d235d2f8cfa49720d3be49d056ea039a..feee6da65d37cae7413b09216014d6fe2b76b032 100644
> --- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> @@ -226,6 +226,25 @@ sound-wm8962 {
>  				"IN3R", "AMIC",
>  				"IN1R", "AMIC";
>  	};
> +
> +	reg_aqr_stby: regulator-aqr-stby {
> +		compatible = "regulator-fixed";
> +		regulator-name = "aqr-stby";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&i2c5_pcal6408 1 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reg_aqr_en: regulator-aqr-en {

keep order as node name

regulator-aqr-en should before regulator-aqr-stby

Frank

> +		compatible = "regulator-fixed";
> +		regulator-name = "aqr-en";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&reg_aqr_stby>;
> +		gpio = <&i2c5_pcal6408 0 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
>  };
>
>  &adc1 {
> @@ -502,6 +521,7 @@ &netc_blk_ctrl {
>  &netc_emdio {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_emdio>;
> +	phy-supply = <&reg_aqr_en>;
>  	status = "okay";
>
>  	ethphy0: ethernet-phy@1 {
>
> --
> 2.37.1
>


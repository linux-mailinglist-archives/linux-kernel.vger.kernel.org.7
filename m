Return-Path: <linux-kernel+bounces-775978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 100F8B2C6FC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C61CF3AC297
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D193A26B2CE;
	Tue, 19 Aug 2025 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WOqyp4S8"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011059.outbound.protection.outlook.com [40.107.130.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A7525524D;
	Tue, 19 Aug 2025 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755613709; cv=fail; b=cjBWKq3T1YJnlTOPhien6XEggBHzRY/MUr8rkvNDhjAajj8mdO1PPlWcaQE/ivziPPkAYGZ247b40WG+RQgLvCkzCzR7lo+h3MugaEl62cBMfkXjOSEX/grh1b5nprdhXKVvuTG707KWB5KGKV6ujQV9K6jMs617bg03ElHNHi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755613709; c=relaxed/simple;
	bh=I0t1EZ7mXLCewbs0sfx7Ne4g5ZEXj0JHpj9JOudaG0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JDlkla+nl7wnRyilpQ3qq48okbULz8Rik3L41fqgQ1SqbCXcK9KvwKdrS6+Rs1V7BQCsh61ed9c10010Mm+P5O0Rm7QYD6xZndX/lY/V0ridaE64T00QffTgC7KG3nmpkBtUpuWAVVLt7xX5m23+PxgIsuahXlHWpv2UCHtyJKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WOqyp4S8; arc=fail smtp.client-ip=40.107.130.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/nOTfT1amA0ys/4TY8rI71bmHtwWdIPO0TKIFypf5nz4M/0hSxEfzTI9l+hFXhTtP0QHER4KbWOSkjm7DMuvMz0+n9moW4tf4RaHlBQ9+njskOe/t8mNUlzM7IKjyRGgN40onMROLFJaUvVapAKAzGOzu4lL6Ru3I3C0Ea0dZL3fmCN7QW9sWYbqDlEllDmjwU6O1TzpPV9woXsvUrGi04GO6ozVwCc07UgqlHbjXy3wbsb/dLfnsslODySEth1xiFasnMgJxrDWdTe9sBF3NnsWrTryH+VNT5AvLSkZCzBdYyx4ogPes/Wu7PddzHOuX9MRjFJXeQprWOWS4cfSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCrgtkiuTXDzTUaoyp18mT1ioHu6dc94OYKxKuqc/X0=;
 b=O2ioMMUybBvwzXEyFWMVIQ+2hoLMJMNCGX+zn1Kin7G0qYZIFfiWd54E6KQJ/wrYhUAcBwRoGuOfdPVik20UDmS8rVegzzNpvV8VUM2H2/Cq9zQmjZRBzgK2Cd66siI5kIl0AFnSS7Mr30oYUEAZYNArQhZco32/NS3mYpCMdnZRTANPQsKQinZDF7xrsBVRVXSqyUPuwSVu4AAEqVyMUglK5kz4DXyBcwKOlFW4NM9ndKHda9y8edDZTp8ipMra/HyAEN1AUMfu3jFRyGl0tvru68sjLugwdbZpqmYOXgdmomOq0YeP39GTjAPXzoXRTSpuHEADoA4iXAmavwbpKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCrgtkiuTXDzTUaoyp18mT1ioHu6dc94OYKxKuqc/X0=;
 b=WOqyp4S8wBu5YYhkGVEIdeJFCPCQ3m2ml7VEO68caDfQabtNVc1nCvLuEcuVkPkWk5imrCQYXxQYM6+jIQoO68pp6XIfea3qfZNQ7m298OVDoc7DTY4uvAZPBtixJXtmlvUOimBiGdg/5HBzt8lgASOfYIPvQLvmhsi56RzFSvBfCHK7G3qLn4nd6sw5PzqwJKjsrpqJGY6b2CjlFUhTg/u8kr8unJUv5zh4o0NcN4MbLl/4WNPVsO+AF7QJ6Ko7FGvc1f76ueKtREi4ObgllgNe/OQ29GqEe5dO4FAq3/7Rw5lIOSyjaWPX6F2bxiFTiexqDkTGYSxEAC0+G26sTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9326.eurprd04.prod.outlook.com (2603:10a6:102:2b8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 14:28:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 14:28:23 +0000
Date: Tue, 19 Aug 2025 10:28:16 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: nxp: imx6ull: Minor whitespace cleanup
Message-ID: <aKSKAJL6KYbaP9Mu@lizhi-Precision-Tower-5810>
References: <20250819131800.86990-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819131800.86990-3-krzysztof.kozlowski@linaro.org>
X-ClientProxiedBy: PH8PR07CA0035.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9326:EE_
X-MS-Office365-Filtering-Correlation-Id: e0c98224-bbd2-4e85-99e4-08dddf2ca75b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|1800799024|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jcLE0RWIbAavrkBhy3y39nko/esKI0KF2Qqja/4C+2OjtvST+iJmukpHyMPw?=
 =?us-ascii?Q?8PT1kyn8VklNEIkXGEPlZNSNHyKR07LEVjt2vfBCNpM4Ihdl/8KvMb6muKK9?=
 =?us-ascii?Q?LHJUO69/0LXUx2M7ipSh+oRLedXb9E4mSv+WY5elwYI5xP6eMxSd31WwR6Ke?=
 =?us-ascii?Q?EZmpV22dW3QlIZ88kHU+uscmI53Edo97KPlW9RLZi6sg2WsLTXlnKShfGSvY?=
 =?us-ascii?Q?JlfDb0XdqqEbubEleZi9MjG1UnTEd/SaL8qLU4XFimZAncrmKCErLmXH2dzx?=
 =?us-ascii?Q?MkP81AAHy/zVUttuVEzcVxjq2dNizQSXpBpUBXAKuPYvr8/OkE458wyc5GN4?=
 =?us-ascii?Q?3nYzjZlCAVxwiJvH8/cwi2GSRh2twk/+BaQ5+NxraEQ65ZNGrmk9sucj442a?=
 =?us-ascii?Q?dlPF8v3CMBWDr60RH9wDiHgGs/2iU6OS5S5WgC/P86uaUU5CMZxSy+TPCda/?=
 =?us-ascii?Q?50LP4wrnNGkgWPqjeM1AGR0eRCF4STwac7VYpkP+uynKcP+l/h2eD1c/Fjjq?=
 =?us-ascii?Q?iqMlhbZrBdRj4GowFeQylClbx8iGK1KaZ9p1AlGA64b0LcK9iTER/bXYMhUp?=
 =?us-ascii?Q?L/RRhIcRbLxNjOP/nIGZx4QOkA2qAoAId/rftmBlMacj9mDzg5bsUmkxpBS8?=
 =?us-ascii?Q?WoXfuHQv7ZohtcPOrms0IUfLOeySQuCHPQ0rLmzvM3OXgiww0vxxE3fy1iak?=
 =?us-ascii?Q?ZDWS8D9Rio5QBAXHVp45dSPG7iGrDUFRGddEtSuTXQkQbLaPP4ivBqzbPV9C?=
 =?us-ascii?Q?96wRfZTKXJql2/fSFuheN42XwkKpD5xBH8gj1VwXIiD4w0/Ew5QJmauiFEAH?=
 =?us-ascii?Q?OZLZQLt8q9v/HT1/XoqHq08lLieE+bI2m9JoIffb/b3P006n2Cg5BjYzBu8v?=
 =?us-ascii?Q?7tUpv7heljIsa+ntYG44whRIP8D6+/0o/DDgvvr6avM1ElpR51M750NcPeP9?=
 =?us-ascii?Q?4Ygoz1C6bTm7JPii1WkdgLiEFMbNTPWGQINFqSGHsusJ3z6t4ZNy4q+83wPM?=
 =?us-ascii?Q?f2t7KXSnujUp98+NAcnggbKILANLMajxSbH86HU1gvn74wpTDHJCVBWqpIyH?=
 =?us-ascii?Q?USQ7yvP324s6nU0Ok2Gq3wG8nVH44/AR1Hcl3Z1yJi26pN++Ol3Pueyu4bsB?=
 =?us-ascii?Q?WffPM0m+VRBddsL0hhRNXb9vijVA9FjboTwrCDmObNOGSlEatPWoFGqL+pn2?=
 =?us-ascii?Q?3iaYndCiHwjL1g2399ppmD6nZ+TawxgnhLS1z+9cwDs78Z2gb2djeuDfID7g?=
 =?us-ascii?Q?7xhqCCzkptkLhxspjBek0QmlzQD9+wFaRcxsuNA8HfZsHOk6NajDah/VpCfV?=
 =?us-ascii?Q?eWwpmINLSBkOJfTFR7kbicLq1g2kD4HEtrb2wEkNxY2LN29hwtnIDoZIacCU?=
 =?us-ascii?Q?60DN7RpWdVA4ryZku1YOFVAQYLEFCJjXvhrgzR8Xl9tj5MAU7RAQwaeMPnMp?=
 =?us-ascii?Q?OplfDPhcZ2/Uf0ksTe0CEpP7f4P6bGrWfNcu0/y90CMvPUW3eOXEpw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(1800799024)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hpthmTpPS45P9XjMEBcSks4PZa+wXAco01BBMJTZoKCIw92Sebli3j49biFY?=
 =?us-ascii?Q?WahZpeSVBIZpu6y35NtDXRPZP+VxwJLBRVhcLbQCI9EKNE2walDx/Ld4DU5z?=
 =?us-ascii?Q?SeUxQXsHFrU5PfVO6c337rh7sVsQiNaEZkNRqISa14sk9Lix2JHRwULW4X3u?=
 =?us-ascii?Q?JVYVgGkBVIanyc8+GYDpgKJxA5zUMSs7RIXttil/4glyBu17K7V5tqYg3DRk?=
 =?us-ascii?Q?oBN09giEnEcxTUm8McVIaTvLmw4JWUnUTjUElObvG/e3bkQVzNwZCpX5Hexd?=
 =?us-ascii?Q?ANbm7ihj+npKWW+9ZWlZp5EB1W76WmHgblYYQTvCgoEpAxyckr6Qc6orpVWD?=
 =?us-ascii?Q?u594wi1Irfm9GyH7VAsRKHxuaB3+VjprpbQsAmOJSZ7HolkXswMwfLB9yeHy?=
 =?us-ascii?Q?XiZ0SGI8uUeyaWvh1ZiawT+LquMJzib5UDu5/X4jO6HPELZmpGphkzj8WUZK?=
 =?us-ascii?Q?dPAxMYYZpgckgsaWsjcKZkonao1BaFxVV1ysZ3wiWkCoQmf2liUqmDXM141m?=
 =?us-ascii?Q?PSfkts57Y0/cAuAVThQ1L8AHyjU7a3WCDGi0mTJigrpHAX8EDr12WeSASyda?=
 =?us-ascii?Q?F+87LNLdWYZrDAiUw2iu4nolbRSaKdNujGRwcYzMuFNlofa+E4HnribDoFzz?=
 =?us-ascii?Q?gsiTbAj06AxnIBoeqYRyYLmVelHfzjCpeoBzCuwzun4ARmMDKWeKQnhTw1/2?=
 =?us-ascii?Q?wXqW890TqU3iDt7823rrEe9Lhdyrw6Srs25idLPmXClWVmIAZj13FCZJlrCE?=
 =?us-ascii?Q?AetTBq8WYk7pKI7fqvNsHWlJiCpXq9nagxUq1Hmlg9fRgRIBy81eVx3m74b0?=
 =?us-ascii?Q?foB4RkruHpFhLVsJ8LOuGhRwt+3qguNEjQMw9rak20GXxrDy1grk4ypu4B+R?=
 =?us-ascii?Q?EPSuWcGB7BNLpRp9fonbCjDXzrK34zRv0x2NZF8YULuDL76hw66hYoU3qsbJ?=
 =?us-ascii?Q?JhQ1wzXb+uV4Fpx5LGFWTq8zKskyuefb60HlpN9Aj5RfcCwfSudCbnVNMHSn?=
 =?us-ascii?Q?E2ljtprLFP4JD6kQuuE7ggHBNCHjwa+NtA5cdDE3WNYpFg34Y+bOg1eMLGcx?=
 =?us-ascii?Q?hiuxFH5oPDeUvQrtoxNgvD3Sw/xAL21ttDchs7Y9M/qT2w6KpbbI7035X1ey?=
 =?us-ascii?Q?i7X+nK10btD0fiPJL0l6IbO2WXZti3yepct7rbVWhr5wMCFWqw/A4bDHzEPn?=
 =?us-ascii?Q?nkW7s3pgp72SjckVMRQdetlAsTB8p6a9izabR5JKMROwigIZn2uJNnMIjxal?=
 =?us-ascii?Q?QjwAPEOfEFtUBOnFwYJBV4QJSnzJjJTvBRw77CjgqZyXEoJkLRyf/FlizRZ6?=
 =?us-ascii?Q?fEmdE88xLMr+0LlkFUjLGxsOWZzCnPGlwDPuS5peStMdjH4uR4wSFja+CY80?=
 =?us-ascii?Q?GizGe3e5HQbGPsAlUtn0WUYFvDsw2e0GHNdMzNAxkv9+kLzzp26vSKGhEfGY?=
 =?us-ascii?Q?m+CSuUXN9B/ivZ92BKW0ovORaRQrJurlMCdpwdcqOcR0ao+MCIwcA79LKuPQ?=
 =?us-ascii?Q?9KYAMaTmxlltQAeTx30rk9ixRlqVLbe+CfdjmdPU1uSEKcZ5rV6PZM+4zwJ9?=
 =?us-ascii?Q?f/CcDlq230MlxhVHAocZXMZQ/E3sCZ8zJBD4Bseo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c98224-bbd2-4e85-99e4-08dddf2ca75b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 14:28:23.7423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQmZJi/emVhz93n9NeaQwpTsLvzTJ4FeI5Bj+O3Sp7W5ZUwIGsH+++2bkDfUktSiygXhd9y8t+UpyNhSAyB6cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9326

On Tue, Aug 19, 2025 at 03:18:01PM +0200, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space around '='
> character.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-rmm.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-rmm.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-rmm.dts
> index 5d1cc8a1f555..107b00b9a939 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-rmm.dts
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-rmm.dts
> @@ -129,7 +129,7 @@ &i2c1 {
>  	status = "okay";
>
>  	touchscreen: touchscreen@38 {
> -		compatible ="edt,edt-ft5306";
> +		compatible = "edt,edt-ft5306";
>  		reg = <0x38>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pinctrl_touchscreen>;
> --
> 2.48.1
>


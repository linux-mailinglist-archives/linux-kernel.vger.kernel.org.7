Return-Path: <linux-kernel+bounces-751313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5389B1678F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AC327AB0FE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303BA218E99;
	Wed, 30 Jul 2025 20:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fGfh/ANL"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013002.outbound.protection.outlook.com [52.101.83.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683FA1E1E1E;
	Wed, 30 Jul 2025 20:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753907049; cv=fail; b=qsX+fRYG5SwnUATQXZsu4nSfi2OCmFrPm3pgvuD5Vuu5B5DT7+b0yI1VKk029/BLzrVi9SNffA6rn+d3HMliuCNX/ofTVYh60Qzhv0gFhATeEltBAPiljv1XUbbjDjRdQLfjektLQ7NSznVlxe53noP/HTuYKFbEKuJy3Nx4mDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753907049; c=relaxed/simple;
	bh=H0Cz5nBEmddxSmoGQme3RnkjPlvhoUWA3PTOFJ5HFi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lVTjcw41n2div/ioQOBhgbRt0BPrSJkyAZWT8WJfndb7VYwzV0mMJ+5fy17NdasIZrTeY3INN3wZ4icoT/T2RacFHYOIepasv+rrEVFouIOC19jDJFF+hdptfuGbZZ6GdhdA8vVaaCnpLMb7i+P2MJRfGf2acQZkYJCyAZeKyUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fGfh/ANL; arc=fail smtp.client-ip=52.101.83.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F69qMndj75tPvtudYN9GImXK2GwnAT+9j52DJkh2ZuC1Dr9fb0Ce8yjzf/f10/BlxkWbN4XlHaAKcNIUF1Pe1etE2x1UNppqeLXgrfLpQfja/c2NyX7Yx0P7YRr9lPRHD9Vb/P05KHoXf8XzJRDXWT83hSRPZXe44sU3V+HhvXj3SqhY6P4o/T7b13s1YzOYhYmoSi59Jgx4SWu5LA5M4cHU9mjKl40/oVAQcdSr4ZhjalUgwlKxvHWiDdZ1EefB4/Ltap0AnQXqMpRnB7SnAOnWxXtL1/GcCtqPd6hMCfpkhNEWkLf+k6IrbtELUeWG/mXRo3haARbqrJ2x6oACTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joQFjweOExbIDwZ5VR8djFVG1yiixuGuEIW7q0g/tl0=;
 b=kYJQmTn/2aQEyCHWK/d0vPHpuX5f1+6v+kEqkhPr2JIgN9KoQzYWSmuGRNCEHbk9HxUeJwlzErKjEb/P+UVWnRco+44Ms3JlpFHSGi75ykoMkzxt/5TIA5Myvpa3ExxmlI+P6o8VOdrMmsBtvhlOG5wNOpIhBYg7xfrfInSIwe8wo8OvJs/PBqfp1S9QTGMp0597TBvopA8q7N6YwKOn4Bn93u626dtDu2IkK8+eLVwkLAmfsPL78IGO2d5cr4Jh5xhE1d/aQvfJtcndtbg/XJpo9FNke0hU/MONo8vqryYoSuLNgjj6imKNb2l9RZT/wBaI75WI+bROVod2GfymDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joQFjweOExbIDwZ5VR8djFVG1yiixuGuEIW7q0g/tl0=;
 b=fGfh/ANLHped4cs8QvwqgeH/BOu0CZqzb9kamLj9rXQzUNJVvLKWwb453ddrOJa0+FMIsBk1lh/Ybt7KjQj8LhQJ2EEPopDx+cVXHdOqI8HiDqvwSnJ0jIuI5idsN4d2MmhKw6ZlxPboH/QjRYbgOmJ6spv85CQ+YGTOpP88X111kh0IdJYMceDg/BiMkqTPsDHLbYxat3F+w35XeikNBkwRmV5AtUBwyVkpvSK7GTdX5dHSwEWRtEc8mgLK2zKszgRWqc8Gk0wvRlz27nF1V5AWAntsax6C6t4O8KxU8ppLQmIl6yNxzLAufRRDB42W9kSv0AEhC3FWp9q4f1BHOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10358.eurprd04.prod.outlook.com (2603:10a6:102:453::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.28; Wed, 30 Jul
 2025 20:24:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8989.011; Wed, 30 Jul 2025
 20:24:02 +0000
Date: Wed, 30 Jul 2025 16:23:54 -0400
From: Frank Li <Frank.li@nxp.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: mbrugger@suse.com, chester62515@gmail.com,
	ghennadi.procopciuc@oss.nxp.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, s32@nxp.com, kernel@pengutronix.de,
	festevam@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] arm64: dts: s32g2: Add the Software Timer Watchdog
 (SWT) description
Message-ID: <aIp/WrOjYhn61ZPH@lizhi-Precision-Tower-5810>
References: <20250730195022.449894-1-daniel.lezcano@linaro.org>
 <20250730195022.449894-6-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730195022.449894-6-daniel.lezcano@linaro.org>
X-ClientProxiedBy: BY3PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:217::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10358:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cfdf679-d7de-495d-ab87-08ddcfa70634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dAiHrx6ShgK7FI3injBGggtfN4kF0eV4sb0AwEK0CI+g/BU9y60kioDJHeo8?=
 =?us-ascii?Q?l6YL2Z6A3ElYdZs3l48kkRZKRthryyos9k67EESxWAebAs9bBNN46yo9BSia?=
 =?us-ascii?Q?U7YtwZdYXcD0h/yXzQ0aklzCsl0Kv3QNgcn6h0g/pjFsjJJaQeJ0RPBEyWAa?=
 =?us-ascii?Q?TZp/ucP/c26XvUA7yVpXuDORMaKQ83h0pIhwiapQFg1/qd2Z8CHpbEvmj7vN?=
 =?us-ascii?Q?OitmMZBfkQuWdhc1SiKaow3PHv2oYL2/N9eqI++SLNh4NGseImBx8BQMl1Pg?=
 =?us-ascii?Q?V55Do04YkjXlVOfnXnDhG25appvvWEuKQWJGAJ3FpnvA8friTqRHPBr6Uv4l?=
 =?us-ascii?Q?DJMrzhU+Ob8jplK8U6234XaJEkp4aRIlWPTuTpqq5d1j8PSxrBbOXEONyB8/?=
 =?us-ascii?Q?xyzc/oNH+esb1bur8igrqbagixgmgPQlAuJQSqgaFNRui9PYFToPXJCTrq4v?=
 =?us-ascii?Q?GgwpjgsKvf3gK9M7GmeLPZW4m4ORr95r0x2byDZTMdHFWofSjjMmBzjFYLS3?=
 =?us-ascii?Q?NHdPxnkTfMeceTiWGwF4isuTaROXMUm/sLXN4jSqkhucpFwATRfW1RaqJn+o?=
 =?us-ascii?Q?ouZtbyYQBW6BI1vLfpSILcPAPB1umLlafZ2eUqhSjtxtuJD89vJerbYhEvte?=
 =?us-ascii?Q?5STY2Dn5X1vztwqY0vwmMU1YXgEj/SC8bC2R+B+9SybxcoefTcj5z4UGe4dI?=
 =?us-ascii?Q?bG2M+oTVfQT+RIP4XPyaCK5viGqtK1frrKxDThEXxCtUtjZE8oHpYDWccpCm?=
 =?us-ascii?Q?qiPwXT+KGlsUud+3aEqjMuLI105sVj6S/g6DfeNdZDIrbzL/WT2zQWN7IpyZ?=
 =?us-ascii?Q?H0rjbCrIJ6M8RVgxV9cIvk7OBmQ2I1YsUYwB7NlKjZkIypj7nQaoFNI/itu7?=
 =?us-ascii?Q?dyZ61jTRP4xtFGZMgh+54jOBFNFi8ukw0aUzdcO33zJ2Zfu3HjjhtiQiecmv?=
 =?us-ascii?Q?Do0uagg+bnfVGDtIk9HyIe0R+ubI/VNmHG4ulRgqUiMzPuqlMR4Y3yT33tcI?=
 =?us-ascii?Q?3McBM9GSjNuNXdHl3TkTaCE6c6wPnrE5IXgStTf48ilZMHYlVh4cts3SGxYq?=
 =?us-ascii?Q?0xQ0nceGo7tiD6N/JUG/Ya836rD15toeVfl9KIRYpfon9pUSuU4pS/n6hlt4?=
 =?us-ascii?Q?/YaDkC5dc6uMYCvXEyzrWAcd0WmBErqpPnTt2yKUYRiVgzD2BW4QdgE+eC/r?=
 =?us-ascii?Q?eo/pExGiSkZAl0gfLsXugDM/GFhZqRRWdtLbYGkWu3B4ppZ/qJTnVyrTQxwJ?=
 =?us-ascii?Q?E3vehS8Pwfk4B6QZ1w0XfC7p5FUPfQLZAhH0zfpiZCgh6djw25NNZfb83D8e?=
 =?us-ascii?Q?qKWUGbmSk0Pws97oeZ2hOlGF1hJomEyTo0MFTXnbkQP4uF4yk2r8c/ru1dsd?=
 =?us-ascii?Q?IrlKc8vbq0LF80pHJDEvPI9peCQwUXd06+AgsjsVp9Q+H1O1TdRQB8AU3FJL?=
 =?us-ascii?Q?IKSULjDMiJ4rNmf5PCvzN7NRms5RxU2+jLO5N6IBY8WLsWar6fq5hO5Al/FQ?=
 =?us-ascii?Q?lkeIOiD7YbHxBEQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iuPr6GwHFXzgWpPWrLQgY9gSHBgpU0s3bn5dpM7KWkn+mnnkJVp4I0ENi2zq?=
 =?us-ascii?Q?OlnYvHRMsG9M/glBgAA923C9Ape+E57wLKQdyoQku2i9TQDJ9lHNPJWcnsBz?=
 =?us-ascii?Q?M3a9NhcYlBgVmtj8bnjRVQAdRViHCfUFWCnJAo0KVR2KIvvrrfEJPUPlPwrF?=
 =?us-ascii?Q?wpyQGWtKFykXe2npihiQvgJpmt40rv0n4hn79ekueenZCEBCGFQq9YkrsxL9?=
 =?us-ascii?Q?DmFHBYLwShnyAkCTVDwCIgSF00T/Xwp97qkvIyAaJ2MQzUCzWMoWabh/Bn6P?=
 =?us-ascii?Q?510mxqKp1ZCS7/qDMDiWBQlRDIXShU1Ytp0983674PuCrwZGyrmyh0D6Xa1C?=
 =?us-ascii?Q?BdrhZhQ45eskC6sC/l3Wp5wECNgHEewUNh8WcpCWvsNL9iz1RrsMvbWUsXeL?=
 =?us-ascii?Q?gJQIhIwoiQI/EdO8jZzh6m4qwu0wsX2EBBQGhjXIp9kOK4fjyS3Y7HxPfJjZ?=
 =?us-ascii?Q?2rlqpvWxfnxnwMJjufUNqW6KeAImMh8CDOg5P1tBLYd9S2Fp2jCbKtMhvvy5?=
 =?us-ascii?Q?t2FepWWjGl0bQ9K2lu5IW+Y8eSmfBrR0DcmFNxscRtSnxnOgNU0ZxMi530Va?=
 =?us-ascii?Q?CzuX19ME+98TmtGgpxFyDybWwIZILB3m+5Ye0JZjbgWqxawJ24LPFghI9WlO?=
 =?us-ascii?Q?eZFE/etNBcclkBXU1QRsZvl7tqMCiybN7OGOYu6WSu8L0v8gqa5QNeswtYh6?=
 =?us-ascii?Q?50gWWcxzf0fMnTXlIcS9HwOWFaVJiavzStpDLur5Xu/K2o2pXcXO2zqN8avx?=
 =?us-ascii?Q?zGvBQzidiWlAW94t5fiDdINyAuOqXtYrhnDl/j3t6zD4LiQVjFHMb5UcnMl8?=
 =?us-ascii?Q?oE18isGVRDJs6JpI4GK0rg3Hh+YQe7X8SB1qiy0/o1EFY5ZZS51e0umMWP/t?=
 =?us-ascii?Q?AGeqvinNKaxxGFAkBoJ+iq6gQQivgW12FwerbOuyJK3mmqhUjdb0sgfwTzir?=
 =?us-ascii?Q?0XdZr9x0BSJhPJQa8r9hGaYD0BvL1s8ueWItLpW6YjZ6I4/aNKOdmoWwyK7Q?=
 =?us-ascii?Q?twBJhq0Q3nnloC6n0FWvOHkX7GYBqlXmlVMBa0biZJR+fI7lUxSNNc496eke?=
 =?us-ascii?Q?oAo8DOS++9VJyppSxQlHj6q3QTM+wNOQLqsU3S6Bz/Y8cSFTmPm02j1vfPzM?=
 =?us-ascii?Q?SyQkaAcIzToIBMd9jLgjNPGfrsSxNWL0byeowvqbInwKSkXMaoTkyOEPdtPZ?=
 =?us-ascii?Q?jWD7nSNXC6yO5fx4MqQBHO7H4gQBm5gMTOE+wVJkYllop1tmk4LSUQaFPkzi?=
 =?us-ascii?Q?84dqSlp0pLyu+HTM5JGY4V9ncLllfiMlA10rhzsOvqtUBMnUqQYeCpMCeHTv?=
 =?us-ascii?Q?Ueo8o/xaVxJUKjK1G81SLM16hVR7hQ5NRIO/SlKtkJH0OfkUIK4HPURtZ7kG?=
 =?us-ascii?Q?o5nkOi8DsZFAr+e0RL78fTo8qP0pOI+DAaVxwd1NWetexFaVaBcE9ruLWs62?=
 =?us-ascii?Q?z+9BDSM2NswPI8FOudIsZcHyU9TErsE3iLPPwYljTHWYjfPlum1pBxsNTwmd?=
 =?us-ascii?Q?l4J1b5DjO2OUA3d7g+WYVYjItzn4f17KD1PY6XLnbrycIfijCfA2witEq5VT?=
 =?us-ascii?Q?AfRQTrnYDHPQZV4pLkXAB2zxB0OfUAwv2x+qlV1t?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cfdf679-d7de-495d-ab87-08ddcfa70634
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 20:24:02.9176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WWNQyAKEXLRg18IhRjDgTKpJDEHaClkNLPzPAdrTvSqw8CRKR4f028ZxyBsC3lcV/8IRkqXrLJr8s/SxH08n1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10358

On Wed, Jul 30, 2025 at 09:50:18PM +0200, Daniel Lezcano wrote:
> Referred in the documentation as the Software Timer Watchdog (SWT),
> the s32g2 has 7 watchdogs. The number of watchdogs is designed to
> allow dedicating one watchdog per Cortex-M7/A53 present on the SoC.
>
> Describe them in the device tree.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm64/boot/dts/freescale/s32g2.dtsi | 56 ++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> index 3e775d030e37..12ce02525ae1 100644
> --- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
> +++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> @@ -566,5 +566,61 @@ stm6: timer@40224000 {
>  			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
>  			status = "disabled";
>  		};
> +
> +		swt0: watchdog@40100000 {

keep order according to hex address.

Frank
> +			compatible = "nxp,s32g2-swt";
> +			reg = <0x40100000 0x1000>;
> +			clocks = <&clks 0x3a>, <&clks 0x3b>, <&clks 0x3b>;
> +			clock-names = "counter", "module", "register";
> +			status = "disabled";
> +		};
> +
> +		swt1: watchdog@40104000 {
> +			compatible = "nxp,s32g2-swt";
> +			reg = <0x40104000 0x1000>;
> +			clocks = <&clks 0x3a>, <&clks 0x3b>, <&clks 0x3b>;
> +			clock-names = "counter", "module", "register";
> +			status = "disabled";
> +		};
> +
> +		swt2: watchdog@40108000 {
> +			compatible = "nxp,s32g2-swt";
> +			reg = <0x40108000 0x1000>;
> +			clocks = <&clks 0x3a>, <&clks 0x3b>, <&clks 0x3b>;
> +			clock-names = "counter", "module", "register";
> +			status = "disabled";
> +		};
> +
> +		swt3: watchdog@4010c000 {
> +			compatible = "nxp,s32g2-swt";
> +			reg = <0x4010c000 0x1000>;
> +			clocks = <&clks 0x3a>, <&clks 0x3b>, <&clks 0x3b>;
> +			clock-names = "counter", "module", "register";
> +			status = "disabled";
> +		};
> +
> +		swt4: watchdog@40200000 {
> +			compatible = "nxp,s32g2-swt";
> +			reg = <0x40200000 0x1000>;
> +			clocks = <&clks 0x3a>, <&clks 0x3b>, <&clks 0x3b>;
> +			clock-names = "counter", "module", "register";
> +			status = "disabled";
> +		};
> +
> +		swt5: watchdog@40204000 {
> +			compatible = "nxp,s32g2-swt";
> +			reg = <0x40204000 0x1000>;
> +			clocks = <&clks 0x3a>, <&clks 0x3b>, <&clks 0x3b>;
> +			clock-names = "counter", "module", "register";
> +			status = "disabled";
> +		};
> +
> +		swt6: watchdog@40208000 {
> +			compatible = "nxp,s32g2-swt";
> +			reg = <0x40208000 0x1000>;
> +			clocks = <&clks 0x3a>, <&clks 0x3b>, <&clks 0x3b>;
> +			clock-names = "counter", "module", "register";
> +			status = "disabled";
> +		};
>  	};
>  };
> --
> 2.43.0
>


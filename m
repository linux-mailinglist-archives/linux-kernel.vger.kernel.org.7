Return-Path: <linux-kernel+bounces-721515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCC5AFCA3A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB42188C144
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349612DAFCF;
	Tue,  8 Jul 2025 12:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YHY4DYKA"
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012052.outbound.protection.outlook.com [52.101.71.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6C92206B5;
	Tue,  8 Jul 2025 12:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751977180; cv=fail; b=KYRQrAXnpgLvgFUq4McDStJ7Omx0uKRHx8Bo2uZQx2AMPIO6a10xA5AA5eE0Re6PgIfmi5cxs+9L+fRC2U5id512aRZSHALGBr9+1ytW97+0Az7hUmmiRzr1KPnbbiOfJFNxkOI29e8WDA7LeM5ot8ILGiXtJzk2I8tZKkR3PjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751977180; c=relaxed/simple;
	bh=+qGsMu9j5TZOujTNyL0t/Z5pXhwbbEG0sHPxRXD/cnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gxQVUsYNR6vA3UtTSDqniUvYc18T5S2ZgB618BXrbzSC13vqXqZSYQ6lp3CRInyj79pQhbaSiS03RZ1o+6MZTUbYTreYwVay4bxNsjFwtfAXT/54goLvyQvj3qP25U1Dw/rWrkppu/sKfx4/XYWB/INxLCQVRdfb+09/9xqOBg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=YHY4DYKA; arc=fail smtp.client-ip=52.101.71.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DL+/Jl3WGUmU+fMZXCDlnX/z5qXTYtNDRHjPue55bGUvGwnu9lWyjbs+jvwUre0GEFIQyebVfDv65z/ZKZOx/WQod3yhhHc0CCpLaVfqK+FRg9mUyrGJAAUiVtc86CHw1a+RL2LerfXAFyJ7kkfxZx+mwG2yM0jTI4yH2fue+ZHAF58g9HbHcCguoFExwxa1Z1rDEgUwtM68sYTsP/tOFwAzXptOPira8gQg/wkJZd1T1A3Lj8iLoAP5lFyHrLEVWG0atRe4jokHLrfXjZllGreIP8kceD+AOEBriVA5xj85PXirdaqOq2Y+frMxIZkXvYFTAxJnxX3pbP7AS9Ez3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wwq0e9483KTPs325cpUTTnFxQBQZv7qZC2FQhbkTs8=;
 b=NgKsvLfJmxJ9vhOgKiOe5MlKKLy7gMwjYMrsu9Fmx/vo3Id+5svOcBwKBqcpgFgdgXHE8n2f+ieLTW1v5sWJ5i5AaqBOe6zM/ZrJvZQNaiytwao110D9ppN2X4AYenNFfJR9Hy9Ce7pA6wvzHeFBL7Ie0mza9atbnn/dzs+xj1bUH0AGc14DCRJF1w4Pcac6tBZXkibHcl2FKnrtMPzdZtBMVt9pDM13VsR9PKI0eVxNrIMmTZPwocvJR+5VcPxzAniM1KkI7+hyFdWhvcDrSTc2oMnV1fvwyWQy+xqqbWdYzHZ817fQElVYKDO5SbTN2I5pMaf8MaQ4CVVOP9FRMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wwq0e9483KTPs325cpUTTnFxQBQZv7qZC2FQhbkTs8=;
 b=YHY4DYKAWKtB6ybbdgXaUl8s4WNzTD4AkKV5EXFxx2YqpeiYUTRmkwYSCRAw4VkXa2U6Vvy5oYsJZ5g/nchSG1WuozdmuF7GvQbimy/UI5yNTk8ylKkIGsiocxuFTW7yP3sfWTQgkUG14sSw1pdz0XKQYmGqJaS4HiLO6vYe6i5kKJoVtz5cXV6iMsTlBydInQrgN0u0iutgp0Ahcwarew9n2iWXb9sJ5dANJPn6vrEnEoTeRPCx0zrn8R/g268/nLJoMCuSvOyHXQau/j1WDYHcDEqKeJpJx7g+UZEIH2Hz5+ZXZXTH4GGCBghpdTQhZuTWJFzTdW/FDLgJU1n2YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9576.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::12)
 by GV1PR04MB10630.eurprd04.prod.outlook.com (2603:10a6:150:212::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 12:19:31 +0000
Received: from AS4PR04MB9576.eurprd04.prod.outlook.com
 ([fe80::9cf2:8eae:c3d1:2f30]) by AS4PR04MB9576.eurprd04.prod.outlook.com
 ([fe80::9cf2:8eae:c3d1:2f30%4]) with mapi id 15.20.8901.021; Tue, 8 Jul 2025
 12:19:30 +0000
Date: Tue, 8 Jul 2025 15:19:26 +0300
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Abel Vesa <abelvesa@kernel.org>, Frank Li <frank.li@nxp.com>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
Subject: Re: [PATCH v3 6/6] arm64: dts: imx943: Add LVDS/DISPLAY CSR nodes
Message-ID: <o4sxmotqixib4tqbvjb5m3l6tnbwbjzodywla4ezf66zmwd2t2@5bd27bkfnsy2>
References: <20250707-imx95-blk-ctl-7-1-v3-0-c1b676ec13be@nxp.com>
 <20250707-imx95-blk-ctl-7-1-v3-6-c1b676ec13be@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707-imx95-blk-ctl-7-1-v3-6-c1b676ec13be@nxp.com>
X-ClientProxiedBy: FR4P281CA0200.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::9) To AS4PR04MB9576.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9576:EE_|GV1PR04MB10630:EE_
X-MS-Office365-Filtering-Correlation-Id: 54c7313c-3e8e-47f5-4a5e-08ddbe19b0b9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xn50IdkLENAtxL2s6rA74rS7Op3DudgmMbKYsRoGF32XSO5yb9aEYrUtktuO?=
 =?us-ascii?Q?hIZBRlt2pS9hz++o42QC/Q1SFHBsz68ztGFNVy8qT4hracVy9j5WdEX2z6Q3?=
 =?us-ascii?Q?MKA1OgnLY4HFfXkTPxSBRvHXNXVDcIMwV26hU/susLIFMiSeAEERoIU4YXg0?=
 =?us-ascii?Q?9B/+r8nrkgJbpgDxNGHGf9/VrbYpoUpo0HR/efOdz2jCi1Aw3KQF+wbLM6O1?=
 =?us-ascii?Q?lICvhpLahOH+RGKWtTrlfdEpDS2Etou9AsIL081/Gmm6IFVfkm1xml4vsXdV?=
 =?us-ascii?Q?7vFYI/kMpngfvybvnK1H6WDGwLgFFygJ7AGeKUlFebiHjl48tkHxQybRBiHE?=
 =?us-ascii?Q?ITqbvtAVI8vNMFy7ULp+CayywSmx95GXoIGGxvz058Oq1E7LOt9ME3t7MuAX?=
 =?us-ascii?Q?gxJ+DEU9mN3XqHUvu3kGvS0bAIkX9Y6GRWleG7kU86xhMIM/GihAJNAwNIB8?=
 =?us-ascii?Q?olZvNO1c/viHdCyy6oSeb9ucf27cL4yMz/4qo90V+AFP8SgcEkmSUYJtklRd?=
 =?us-ascii?Q?yokPkfRjbpqajlm7IpOmCujuFea6WPmmO99ExKrPDLDKTIDq8zPmuivT6W9V?=
 =?us-ascii?Q?I/0mAKoLRrsjS5nSpy4nxZZAGbp6KHA/LRxUS8HeWOxu4GiP/b+pCWZePCQu?=
 =?us-ascii?Q?fPtXQqkEKl4OWSKuSEJvfUgq40uWzi5tzviEOudWZUkgVvj8BV5ws0bwHYu1?=
 =?us-ascii?Q?yvblqHXmc/jR5GedqSHv+KpNjY8GMRY7nwEC6/2Q3bBlhDaJe/cc6ubnaW7k?=
 =?us-ascii?Q?IdM9qA6R+tYxeSGgx4PFbCs2yKdPWnT7t0GKh8LvRTD4hcFdDl/7YXaRCyIp?=
 =?us-ascii?Q?yfkhmRwbZboVheFWXhzUzBPN42TTBYwilOcUvOs27KLn+HCF8z8fQeAQGB8O?=
 =?us-ascii?Q?vR0ObmmJ+LzaS6GZIPJmrI36XvjipBnnkTlRrv6Mwp0kAab3bACMxJEG5o/O?=
 =?us-ascii?Q?o3b3JvvmPFAflQKGvuKkH664eApOpmV/J7mdFhRb2tIgujEM4WJ7s9wNhqQN?=
 =?us-ascii?Q?Zzonkyouk8PbzRXw3F+Lx77uSesi5XEEvgiOurHb4y+CI+mjRNO/gPYFLA5/?=
 =?us-ascii?Q?f37JdgaI43cY3enNTWMP4MGX5G8AVEwkXCqC1ATXnhZ2z+enPeZNmCLkXhG7?=
 =?us-ascii?Q?ZBLLKF/JLdxUemlxTujkhS9zW9aW2sKGbBMvC8jltowG4IKKhGK0myonJ0Ez?=
 =?us-ascii?Q?9IBCr7zHMkcVBhO7Ho6gYOr3VH2Yuja8kVHGAUtUsHSQq/UZIuPevTox39yG?=
 =?us-ascii?Q?3kuGP8CMHkgryuXmYzR6m8gLR339VvPnTeaO+CwE2muOoTg71LtkxGAW/AB6?=
 =?us-ascii?Q?TqovqOa1PSf5LWX0bjDQhTh2qvyVQEO9NmUR7PYWSEYcdSlWMVUn7Uc/IBCj?=
 =?us-ascii?Q?TUeRUlIOCffr1yOFsywB2BPTLZeqRBGfeHnq3eDikRYSECrCneoaWP/RgriK?=
 =?us-ascii?Q?IFDIowjxERU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9576.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P+4qzmqpR6LoAlK6yGwLKzEYg7nlH8uaTLlIbq2gbE8jczC2sVNVmLMcob7b?=
 =?us-ascii?Q?A/80CeTMKpQTNx7Bmvzq+8+yD5ZEQHnB/XkAi1csEdBimrPOchfZn4J7fiVB?=
 =?us-ascii?Q?gPR8z3VWIgGSSC7CBdE2bdRAxiQCYfvm91Co67wmIOMDxkhM+taQtl9pIPj6?=
 =?us-ascii?Q?pdZ3NGLzVE+xrrp7z4ZhxVEKfWD0/xZ3UhoZ+pn6lxRRy3TOfI08rlEWUbnA?=
 =?us-ascii?Q?8sqTZmUYkCe6UD4CdFI1i/61Gh52asTbCatT7j9Ap+azW87/9OTaYmevG+WF?=
 =?us-ascii?Q?gJMr9/hIv5mwrggwNV/fE0spWdlbRrE38pj5EV6tV3VHWPNya7j525WNRtyX?=
 =?us-ascii?Q?VBXpIbicsZf4ptRv03Qr2ZX9ZOLJ1WifpgnXtSZuWpih+etHRWbte1ikaQPj?=
 =?us-ascii?Q?Ln/N2HUV3RfzSDFXSitJ4d98MxQzIIUWluFLnx9ClOD8YiOTI68PtPZSR9ys?=
 =?us-ascii?Q?6rjwGbvm3b4b/F8P+DP/dKpO9LMBEiPWUJ/tUcfvORNgwDI8augML34h5Er0?=
 =?us-ascii?Q?1fHKeuYOqGzAkg5HpnZn2DoZjyFAS/+DNJLzhN20w8KYAvgNUWMM8MoJTLEf?=
 =?us-ascii?Q?18HW4pWIGXGEM8IrFUCNjLnWSlfOVYFzIWzsn3PmJHfZfJ26H/tgug3vRiQy?=
 =?us-ascii?Q?zH71RA0WwyJ45h2U6+pdG700DzTrqD+mQR97YkgJPups9kdiSdXgRS6SE2+d?=
 =?us-ascii?Q?1Dqgaw8IpDtGcEcwfvwTMqudmNiBD8sG9I5MhMPLA26YaLEAip6PKrZxgWaE?=
 =?us-ascii?Q?U9MJC5EdM2eWOEDYBoFRIWIoghdt27iiQoDx5SuQtVoAgBDX2T6vjtliAa22?=
 =?us-ascii?Q?cT48Je0X72rskhW2MLDFZr2EIIqZDwskzZvXCR0S89LLq+XGVQ3rRY4ryF8H?=
 =?us-ascii?Q?NsVByFXh2/HXDAD1HrOY/HhowyINZHxGcBYvhho5TqOXlX+JDmkzueboF8UO?=
 =?us-ascii?Q?pEzPzq44oI5UkYfWfSlyNWZSx7mWbDTrZ0oK8X2nVPm28R+lbCx+EWByxTNf?=
 =?us-ascii?Q?EaVnMDyGTYWhs/V6YN2qO2BZSR38/2ZJa1ZjXHR1jw1uGjS49WiccOQSog54?=
 =?us-ascii?Q?9+jBdtDMDnTdN2OqoilRGjUeXWwb/Z8utgctAf4IHXC3v7/mx4VLDv5RplDQ?=
 =?us-ascii?Q?+mdAhmnoitKYDm/dk0Rldif2iub3v5q3KvcvTqYrrPlzC+8CqFwHjArAs/23?=
 =?us-ascii?Q?hOD4IELCjtKb5U+5xFKfVOZBDvmBtAp+w26HK64uw/s1ZLddSHL5xVrgW7rG?=
 =?us-ascii?Q?GyEIsgFV+f+99Qpz8uy9KZjR3wNiDbA1M3UuT62nCscyvhTkGiRXlJGpzgvu?=
 =?us-ascii?Q?/apOwEMTjoE5L0veFNVcXPUR7xYZhT2Twd0NyjaQaXifk7RICxfTva7o/MdT?=
 =?us-ascii?Q?UG4mYRVxMhQLJrFadyFSo5XJet+/xZvmO9jhpwImCJvfkqG0o4X1IoaGzgFn?=
 =?us-ascii?Q?txvbh404SSzMObrJnExdrfVA0W1KNdXz7FX4xSpGegRTU6JscJdHFCWoBS1g?=
 =?us-ascii?Q?HoES9MmLq8kTilVUFblide4UQV/kK1ySTUk7/gZIq4eEsfN2okJr14imvWUi?=
 =?us-ascii?Q?30Kb88rZwl/Wh25e9d1Mbqp09SDUo2IevIHVlBjrVTMQMvXxovhgocfaTuuA?=
 =?us-ascii?Q?bQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c7313c-3e8e-47f5-4a5e-08ddbe19b0b9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9576.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 12:19:30.9177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vxKkgKXNK8odZX+Uxnz8yh/yopbevlwWwAF/MsHHM/pX7USZ0xrtBMdAuyOM5KwjWss/1aoi9ztPVpceV4b0eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10630

Hi Peng,

On Mon, Jul 07, 2025 at 10:24:42AM +0800, Peng Fan wrote:
> Add nodes for LVDS/DISPLAY CSR.
> 
> Add clock-ldb-pll-div7 node which is used for clock source of DISPLAY CSR.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx943.dtsi | 34 +++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx943.dtsi b/arch/arm64/boot/dts/freescale/imx943.dtsi
> index 45b8da758e87771c0775eb799ce2da3aac37c060..657c81b6016f21270a1b13d636af72c14ab4f8ef 100644
> --- a/arch/arm64/boot/dts/freescale/imx943.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx943.dtsi
> @@ -3,6 +3,8 @@
>   * Copyright 2025 NXP
>   */
>  
> +#include <dt-bindings/clock/nxp,imx94-clock.h>
> +
>  #include "imx94.dtsi"
>  
>  / {
> @@ -145,4 +147,36 @@ l3_cache: l3-cache {
>  			cache-unified;
>  		};
>  	};
> +
> +	clock-ldb-pll-div7 {

You need to add a label to this node, so it can be referenced from
other nodes. I hit this issue while trying to prepare the DCIF patches
for sending upstream, using your latest patchset.

Thanks,
Laurentiu

> +		compatible = "fixed-factor-clock";
> +		#clock-cells = <0>;
> +		clocks = <&scmi_clk IMX94_CLK_LDBPLL>;
> +		clock-div = <7>;
> +		clock-mult = <1>;
> +		clock-output-names = "ldb_pll_div7";
> +	};
> +
> +	soc {
> +		dispmix_csr: syscon@4b010000 {
> +			compatible = "nxp,imx94-display-csr", "syscon";
> +			reg = <0x0 0x4b010000 0x0 0x10000>;
> +			clocks = <&scmi_clk IMX94_CLK_DISPAPB>;
> +			#clock-cells = <1>;
> +			power-domains = <&scmi_devpd IMX94_PD_DISPLAY>;
> +			assigned-clocks = <&scmi_clk IMX94_CLK_DISPAXI>,
> +					  <&scmi_clk IMX94_CLK_DISPAPB>;
> +			assigned-clock-parents = <&scmi_clk IMX94_CLK_SYSPLL1_PFD1>,
> +						 <&scmi_clk IMX94_CLK_SYSPLL1_PFD1_DIV2>;
> +			assigned-clock-rates = <400000000>,  <133333333>;
> +		};
> +
> +		lvds_csr: syscon@4b0c0000 {
> +			compatible = "nxp,imx94-lvds-csr", "syscon";
> +			reg = <0x0 0x4b0c0000 0x0 0x10000>;
> +			clocks = <&scmi_clk IMX94_CLK_DISPAPB>;
> +			#clock-cells = <1>;
> +			power-domains = <&scmi_devpd IMX94_PD_DISPLAY>;
> +		};
> +	};
>  };
> 
> -- 
> 2.37.1
> 
> 


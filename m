Return-Path: <linux-kernel+bounces-822261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E16C2B83679
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B907541EA0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032252EC0A5;
	Thu, 18 Sep 2025 08:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EOoEOCpa"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012017.outbound.protection.outlook.com [52.101.66.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DE32EB5B3;
	Thu, 18 Sep 2025 07:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758182399; cv=fail; b=rzYk0iE9r5Y1/ZZbnUsH7atID1ovPwYB03MNlhiQ61rUel0MA+TWHzlnsmo8o+FURPEitpi0Z9vtYxSW2GpKJf22KvvPHoLSDRnKOirXr7td4CAnM2dPK22rAGh6os7mjkZzLj7Oy79zBMS+SsVZTLmzAnBGyY+wFhO1rqFHhJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758182399; c=relaxed/simple;
	bh=KA1DO/t8LLy9TFkB9cQmFtp7NiKxbUc2QnJRTJ9rya4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hXdlx9aMpZrT/wM5BdT2li6Dg9Jvpu4cl9SdsS1kDysCgk6LiSuEjVXOSoeC9wKJVVZQ7IDcAjk1rhOtXOZoGc95tgHIg2L3OpFI7LnLLx0GmjVJK29i9TdjCMk3X25/0A446iFPXMh/w2l5m+GI3tXps/KvnrIXqC1Ji9VsLyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=EOoEOCpa; arc=fail smtp.client-ip=52.101.66.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hp0g4R2a1EsUfFGU1Em9WsAj+69MuIfR5OUESHrY30CGM8Dz0tSlrE8WyTXtUyWMso+nUPBEXVhycLwt5gvk6h61uk8xv8f5DfEDa4oBeg67hXWwvLhbZavMjcFj4+UciyVoTztFeWKhWauMFZB5Fk4/nc8xkH3FmXHXrABPvTJspB0Tsz7d54KVVqIjpkPwwwemwSPiJyUyqLcChjQcH+80Il31rahT4aColJ+vg/8kud4yvhHoCVELyD9yHqMylbbc2CnuQ9HDv1d70qFLzbWzV1DUqJ9yDvApU0BvwCwZPGRykbM4FQxkyD+hG/3jhSdlbtrGd7C512mwn6OKdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xQW8G1SkUT6zingxfkmCiP+cPe7SHrR2QTFCFB63Ks=;
 b=d4pVjX0PFbqk+D7V3Nl0WSzA8miugMMoih297fKMynIi/ItNC2OaaKqAkwQPLa0WXudRyppFGTaCARq4bcGjmfxNfxi70XHpggQ+ot4J+yLBagKEtxY2vngz+qZkWKrZcZvfSEe8gHKgQUmCLRTtUj/XV6Ha0S9Q0nKt6Lf+d/MUkfTIQqax4vtd6VOqWSZKtetlU0SDu380rGyLovqHDEpcu1mK+bD68h1kv6NsJr7MoSorhtsr/0bHkQa17KEqRTsV9uvf7la+ZGvuP3yGkmpT9D2vxYvhn3K0a3RXNfUaTaKMKgfjCtj1icO3+rfuEFHVPCD/7aAmnu1lYTa/aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xQW8G1SkUT6zingxfkmCiP+cPe7SHrR2QTFCFB63Ks=;
 b=EOoEOCpawnIUJYJuv6fjqeA2P2DdLQ5Qp3F2ohGpK1xkX2ngDFTw1CuxBg6Y8opP0cL+0qffhJAHT8RtOkj7uywcCvnioqWY0IN+m2ZYB47C/ABl/Uud7zRm/RTpm/vz8ycuesZ+7kO/fxvvyZWpNCZYGXX5rOlh0PwhS7n5zjPXSo3r+GvlFx5bnPVPejoA8ICxEe9Zy0upmW7k3HbCbckRrq+FWkhkR9syhSot6OUMEcXuNkVLgLoyQXSiYHojEy7NMJtylYijK65xB2+qpBzScG/TeBByRiddQXY54KXnbvpvI7rYWduDbJMI47mUSeq58Bu+ucwhNhJ2QyZmAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB8268.eurprd04.prod.outlook.com (2603:10a6:10:240::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 07:59:54 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 07:59:54 +0000
Date: Thu, 18 Sep 2025 17:11:32 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] arm64: dts: imx8mm-venice-gw700x: reduce RGMII CLK
 drive strength
Message-ID: <20250918091132.GD23028@nxa18884-linux.ap.freescale.net>
References: <20250916153216.1042625-1-tharvey@gateworks.com>
 <20250916153216.1042625-5-tharvey@gateworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916153216.1042625-5-tharvey@gateworks.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:3:18::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB8268:EE_
X-MS-Office365-Filtering-Correlation-Id: 201217cc-9f0e-45b4-2603-08ddf6895a15
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|376014|52116014|7416014|1800799024|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?30X4GS1Mv8zQoHhws1ucAiOI3yRs5MAwVTpUSERbOxBxpbkhpCk6mszxFv7s?=
 =?us-ascii?Q?BnrzhSyC6KIdyul0BAf+oSBxLKZKgo1RKkvV30930nM1NES7u79NEbx5woRP?=
 =?us-ascii?Q?NfyY+C72lBZjrp8iwio7Agz5PUkxyodUNQr3GLRRQrbmTYlN1PmLKNTvE+ub?=
 =?us-ascii?Q?DCSQBke8BsRdmNuBoKxNJpZBwYiUsK/Lgt8z8LBBlO71Tz/m9GMRH5MiVCmW?=
 =?us-ascii?Q?8Cfzua/dD+FC1SEnSHQhlG+myglgcBtqFHsdqaRs89/Dx4eCAUyrpsgzP/PM?=
 =?us-ascii?Q?nZhvAhnMKFAvlNPE1ffK9ZfjfUK6cBRbx5R4gotFnei4TacJqAngrGK2ro97?=
 =?us-ascii?Q?ndpEv5dJtlHueTVa8BvROoAxD1b5ni+95tYYhAwwfJJFyeYJJAQKsd7IvCP2?=
 =?us-ascii?Q?Pg3PJl+KNt1WpQaaHdBGUEd/PHqHPPw6mWY0PLF9SMFKB0HQomeHQ4QEnBGu?=
 =?us-ascii?Q?q4sQ1kbbo9PyNWa8aut/R+MSDNJRMPfx4RFwHMEdh3+DJzy82pMEePaP2Ce6?=
 =?us-ascii?Q?SwXAQzX02i9JIUwgbiMF6EAoJYC8GTy0zlkP1NQ4fn9yIM/rYv5Qry/+TWcB?=
 =?us-ascii?Q?gC2cgdCQqtNhSiNDQ9Rz2+4ZOWvdP+0tCbCHAc/wRADDwKDU3R9rVVlLpHJC?=
 =?us-ascii?Q?/dWh9BrnEDBWbKj8nIkNx3f/AvkJU2oElrb2+bJosVyD6W26KsiLX4CBrp6P?=
 =?us-ascii?Q?7k3NAybWMaaA7f3x2mfKFJBP1GcJIb2ex62CAXcnXkouCTufJxcWVujJwgmg?=
 =?us-ascii?Q?ykzcMzoxKFc7LWW2QwfnujwW9Hdw0mznfSpSYUhXsyBXbyxyVlPavh2N4E62?=
 =?us-ascii?Q?RqGcwyD3fyJr10U+q8xxNx/GJF3ESpL+40SnQJcgZU4XFFOem9KvXc1Ihl2I?=
 =?us-ascii?Q?oW32gLdB06t/KP3EAR4X2O69c0dSHV8JSIJ8PwG56UjlTjtvMefT9qxwMDW9?=
 =?us-ascii?Q?YyceUHUwXn+p6fbPkKcF8OLMhG2W0SlOjCxgMwFhyRpSkF3IqW2I6Tio+mI4?=
 =?us-ascii?Q?whkZIbv2ktIrW4cwPNEgTGeXIUtGTbTArNWvFIfcys7K+ZLQl1QehDtzL4Kp?=
 =?us-ascii?Q?xVl1ZJZ/N1FXRdLIpt8xojuXCPBk1sYqdZdbOVcMVJ/OJfjbmeD/gzJbbcko?=
 =?us-ascii?Q?YHrStPSDYUUZyilKJmrjJj+P/YAcomh0H6asJc9Ss5SQtXf2Jy0hKvGvilHA?=
 =?us-ascii?Q?LxcWPCoKWHW5q9nRns8dt6Ww0HSgjr/6CzstOTRjXVN2jrDsDYkLk/7xxO2X?=
 =?us-ascii?Q?N7kPGcm5Re6zjmVaz1nzjngWh01ZbHU/Y7usa5WG7xZ2Zg45N77VySHyQEyG?=
 =?us-ascii?Q?O6Z8AfLeeUEcc1U5fS+U4pGaho+nqYuaIepUhY+EQ8GQCPgJ66Pf+qLqJUbC?=
 =?us-ascii?Q?LQGdqnaivdsWfVlu4rI4KcTKEjxxNgt6UHnapOQtZ2VduzhJ6Pk9IblFvR3R?=
 =?us-ascii?Q?W5J5ty3V7c680gy/BRGszox4RfgPt2A3MSBJ14SUrVesR1Y4R7hIRQ=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(7416014)(1800799024)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?/YIBv7uzASpANnHzlAHIT29ZqB9758C2b+iLzR0sZZIhZidcE3hbyl6oxStD?=
 =?us-ascii?Q?Pj+bCSNl1563vJzG2Cnhp/ZBLQFWNyHfEvMU43gdqWdfhSu/r8gSWiF6Dr4W?=
 =?us-ascii?Q?5NQ5teKm+cDcq2t9qUsB4xPLVYRW0KOc6HFSwuoZ7HiBWM6DOrnDdLe3EbcD?=
 =?us-ascii?Q?T7asATjwBWK1btyaQ50veIuDXjiZfp1TLr+jINeMf9gelnMmXFdcTTKi4aNM?=
 =?us-ascii?Q?2V2+gIKtYSajacakty18SuRLPIuLHljlDclkNT83qHCySTErnlSdVD0BO5+u?=
 =?us-ascii?Q?vWuo1Z/K9Cvc+YYv7PtrTsA44YuNUOrG1e+ENx72AostITtI7NHaWdNvyc4t?=
 =?us-ascii?Q?I3JZoIVVh2C2B4txwY1G4sjMB21b4uBZeuN1h52v9EFjX3R+78ShLyUaatYa?=
 =?us-ascii?Q?Hr6DmO0Kt+lV+zHko5pviKA6TavZQ6XepBfaKhp+eoGJg6ESs+m3WAGd6mLB?=
 =?us-ascii?Q?7z3DrzyXw/SH6B7K+Oqv6tlqXTyhd7LGqpFDlr1tSXaZh7d8X3g39bZvGbbf?=
 =?us-ascii?Q?AjYCsuHL5Gx5SDRZe2tJQwmCKfT7IawdFpcr0KQXU9usDIO5GWhT7dx7eY1c?=
 =?us-ascii?Q?XL9HzSwkk51Y29dPADjIaPA975jH/AGZgsAHyto8cHWKUddu+tMcQXjhicpe?=
 =?us-ascii?Q?K6dMlByvpjpCCSgekF0abTMaYokFNUda6zHy6igAI1pE9ryntZFrXK14xw+s?=
 =?us-ascii?Q?BypO+MYFsUc9mU03v8NHu9dOOERiwLAGZO5/QnEiRT7DwTSBFOYLiwEd1hZL?=
 =?us-ascii?Q?cosgsgiL3S8XlLME3Z5e/GLcHC10BhmhQTxxsssGFeO3k1y22Sq/pH/Rvf/k?=
 =?us-ascii?Q?9v9fx+T+yF5J6GUKdeGZmKleFYmXBi5nnJDOnMg+tYBW7gLAryckLSGnhL4C?=
 =?us-ascii?Q?XDQ/Vi3d68CL1Sz6wk+jFi3iwIHg6zHtrmETY2sEInnuhqipp0KVkalYT+5t?=
 =?us-ascii?Q?NPGjqQb/uNoeEFYn9Xezg/rRWCQsX9bOejLh5AvK1tGM5mFI5hzSURbcppH8?=
 =?us-ascii?Q?uUX+Ioz6tnt8Y5+GgItq73cmf60JC49xzzWneDyw1dQK3HtAcVnCadXCOntQ?=
 =?us-ascii?Q?CNQE4VKmMXxg8Tjjhx5pX2dY1MYcP4RuQlExolv+E4r6HHKKphlcuKZyAFxj?=
 =?us-ascii?Q?gqb7+YN9CW7EO+3MeTBaMDNTI+R/HMokIfiPyaMOzdIQ5Ept/S0bhRa/wXm9?=
 =?us-ascii?Q?gkwGePCwpiosTCp7aKx/2qdJM9TaQ2rzYicNOjiGES0SGbPa6qmN9HI8UYTF?=
 =?us-ascii?Q?ElQkkMQ7t+BTcTU8+ea7nzzfH/U+Y+4UwIEHU4xncDbeL2pj8DNFtzCPyFDG?=
 =?us-ascii?Q?Y3jg779tKYi049o+w3t+cX6Zv8mOVZ3NVZ57o4DuLiQbO79BCBBdQM93VToi?=
 =?us-ascii?Q?5pJVRf7tMLeUQPRSxi5SXTfoNFfHl060fQ+1P58grTF1aAglgoLdEKoY6Lm/?=
 =?us-ascii?Q?/p7H4uMO5vCxsMNQyM19M45H0xelJGRA6JYoAd9J+ldRdj8zFI5KlZQfGFBU?=
 =?us-ascii?Q?dutQaRxCt3dh9j6G/tXyT88CGZGNRSvxliKwXmmhe7jqe6rQW6otnSv4Wpe3?=
 =?us-ascii?Q?iuDdJG8KcV9bXVzXWPNIiCTS/AXGLszTREUGxhnm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 201217cc-9f0e-45b4-2603-08ddf6895a15
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 07:59:54.0899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UdNDE9a65sTRstzGItUnfb6f1l8BNCCZqpwHr3QQN0p9kKPRQzSLwzeAkpFVDzI7IBRzzWjSEVk8AuMn2nDTTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8268

On Tue, Sep 16, 2025 at 08:32:13AM -0700, Tim Harvey wrote:
>The i.MX8M Mini FEC RGMII tracelength is less than 1in and does not
>require a x6 drive strength. Reduce the CLK drive strength to x1 for
>better emissions.
>
>Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>---
> arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
>index baf46fe28133..dca213c85cc3 100644
>--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
>+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
>@@ -446,7 +446,7 @@ MX8MM_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91
> 			MX8MM_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91
> 			MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91
> 			MX8MM_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x91
>-			MX8MM_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1f
>+			MX8MM_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x0

Same as comment in patch 3

Thanks,
Peng


Return-Path: <linux-kernel+bounces-848326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB8CBCD6B9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 16:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E6C94FEDC1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67452F5A2C;
	Fri, 10 Oct 2025 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PlPJApLg"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010013.outbound.protection.outlook.com [52.101.84.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C282F3C20;
	Fri, 10 Oct 2025 14:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760105477; cv=fail; b=nSy9uQSgo/dKW7QYbR24N3qNX9psqK9YzVXP+5iUPkupm6Bh1TYdUjwRpDFZxTtynK42judOTb5gcB1f7qJ35P9crEcXAul3Z5spFd0ncb1HXqeUYGYW914ZA1+QxVBGTpbaGkzi9mqy2iFJOWW9+2M3ouplSe2vP3q54FW7oWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760105477; c=relaxed/simple;
	bh=VB6cjx4cEWqlP3omVBfvIQoD8ngOcgbbllGwKy5L0SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UTzVYxgurd8C24//zXGs7lFKuwMR4+1tXcO4cYpyKpNy0ORW12o0RYsiGZ/9M0eIeVh5r5FTSTdWTVAAd7dSK8J8H15LTjcJib0E2f6pVOCzbilASR62YzHm1bWBwNsFWeR2Mut84Q7RFdpPj9VHiyFO8PvIA0iyUQenugJ+udw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PlPJApLg; arc=fail smtp.client-ip=52.101.84.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJzhMRY2ZHBugfvdrVPaRl88Sxa2eF4O0SvB47Fo3QXwkr13tF6ErB8ulgk/7jwVuzhLgFkGU861rBYEYbMPvin92vDdyhd6QIqCsbsAQ2NudtkE/BjVznjxOjVutau3QpxjK234V/E7HyDnhggoI5VY9IASXxni6Qo8yOM1cVGVvZk5+rYaX7KtpQaOwPm/X20H3sN/A/pv87l1nO6OJAaogcoWV64SGroEpYKwcuIL5ebkeMpJMOf0PjebhpaIaLLsMDA3V7RhMlRgAPaR6dX072gL4+BuG06zKkEtAi9Xr1Sd2x6snluG85pW87qaNjG1E0qpICAe62m0SoxVKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UF8g8BgypRT4kO/uQTmYO1qxZNQILjkyhUutjT28ZwE=;
 b=KWBp7LexsEmATT9d9TkTrQqfBryqbcUK0g3u8uRZpc+7GVzJhmlzQcbniP999D8KCiSin8QGhrnp7qVTOCc3pyvOxzRSpG+6xSH8WydKCyu/Z+RCdNw0wcfJ8feZv/fy9IrEMLE+JBWwqg+jLUJTZCZQlMiHXK19JqkZLEZMT6nRMC/YNI1dGcrF1Gj7JDpLlC6/igzEWDq1ioLzEc3nyUafd94SpeV6eWqSnrIhmJKSc1a8btdjkuRtO+5VBltkxYo4Tb4huUU893alv8VS0lEFIrn6qi1FctAIu4nx1eJ2DHq2XPBGRjlSfPSU52Xdpd+kbapSU8lRMXBEhqf8Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UF8g8BgypRT4kO/uQTmYO1qxZNQILjkyhUutjT28ZwE=;
 b=PlPJApLgr6PVl5Eh4i64r5RJXRl8REdzuZ6j9mdZ9rtC31zNoLNIqD3XcVbO/M7097nT3VLG+3ATguRJOicy8SaT44kewSGsz9u4bXdc4tZWX18075aGEish4ffgZz/lFM8CORfH8wCaInleMHdZjRwdGtffHuMh/VbnVw1n9Gc4j4G1ZJhwItZpaWbnMbIBYxbPsU/g49AyBDOjy+cUvhWdFP0KJdVPFrkZv4uLJDQpWIuDE5ioziDPJzjX9G6Nq8aRTEW4bVvSTBLZSAgw1bwhYmHbezqguLYZwBJlzGX68lbPL8PUZUnGW0WyBiLUMqu7C/cYcn10InDi1VzE5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB7671.eurprd04.prod.outlook.com (2603:10a6:20b:299::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 14:11:13 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.007; Fri, 10 Oct 2025
 14:11:13 +0000
Date: Fri, 10 Oct 2025 10:11:02 -0400
From: Frank Li <Frank.li@nxp.com>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Li Jun <jun.li@nxp.com>,
	Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: phy: imx8mq-usb: add alternate
 reference clock
Message-ID: <aOkT9kisv054Tbuh@lizhi-Precision-Tower-5810>
References: <20251010-usb-phy-alt-clk-support-v2-0-af4b78bb4ae8@nxp.com>
 <20251010-usb-phy-alt-clk-support-v2-1-af4b78bb4ae8@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010-usb-phy-alt-clk-support-v2-1-af4b78bb4ae8@nxp.com>
X-ClientProxiedBy: PH7PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:510:23d::11) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: 9555db7b-9c90-4c3c-a7d1-08de0806de88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0ngRMA4HhDqiwxGc8Q1okjtrKlw4Bgs7Rr5lQje8b9iH74HZjTWPjvasl7zn?=
 =?us-ascii?Q?uTmowKyw/altyuDvr4QQ9S+SYp7aR3zIWssfKFj2ME7ep+fRKDg06BVmasfn?=
 =?us-ascii?Q?KLiAdsUKm+QTzHM8Sk6rqd+3dM1Mn2zrweV3RMUmDA8RFI7HKnbmtK91DmiA?=
 =?us-ascii?Q?1/MoKGjAiQJTnDt68T/5qTfRZbsZ4fIsU0kBHvlRYOM4rdUBebXfqZsUQL3N?=
 =?us-ascii?Q?veNC6rc4Dc05w222iQ6Dl2dT7e/CHOEd7u9LhFcesu3z1JCVNTjs/1kPD1Fb?=
 =?us-ascii?Q?fx5MKosfW7d1OST1xZwdi0ZAzk10WRLNdgYVwStH/2LcW7RQCcHztebp0kWJ?=
 =?us-ascii?Q?eW10STDfVSrhzft+l7mvQJVWGeHKZw7iLmGyQA2Sj7ETcPzq7rUujTEhqpLc?=
 =?us-ascii?Q?6gz4llddeTkCggBFbfWxPYmT8rDDieKm3PsTgGOBTqENHoSi0bwV7JyjVCXu?=
 =?us-ascii?Q?eJ2w6RfsQNTW30LaE6IQPbGRUpooO61I0uzS4pkR1BlDd9ldFuFv1ZKkdkvY?=
 =?us-ascii?Q?xzwjqsdKltA4y0gfvVRzy25tNAKG6fs3l9vQoqIiicBO6uZ1ASypHsxUwzef?=
 =?us-ascii?Q?pfcek3+D4d/oM2B7783OYSUFm7/qxAeRJ2ElkdYrSSW71hrX8IPbK0QoEnKA?=
 =?us-ascii?Q?nsiAMKjqaWZ4bPbJ/6apXRbZ9hGXFRMc6Z+x7L69EfwNzrzVf5I1aSkqrmbu?=
 =?us-ascii?Q?y+MfrRXztZlQIIAbcjqu6EX+5tX0DJbYGLpBGoJxUMCI1EhEKpu5UUoLvoqj?=
 =?us-ascii?Q?naL4fQgGCgkgmJZTlIQUbOfTkz4qwi8ugUGwsKQvqQqlDP07/e5WMcu2wvHJ?=
 =?us-ascii?Q?OWZ6Vd5OIWKjQxnqT2g/UJGqiHsMyRTrNtp/sn8WVlHQ/lk2IyqofzDzCROq?=
 =?us-ascii?Q?juVC+FeuofmgWRQmomBTHChebV/Cvv/K6tJWAbe6yOjYD/C5jfFmlgmpZ9Ss?=
 =?us-ascii?Q?4kBk1isWAXSTzx/eZ8VIRoCR8K2jcrlbyIkYkVvESpYBQJnVwDCv2pIlDtk4?=
 =?us-ascii?Q?7mdXv1RkzpQwru/c7IV8LWJXMIYkXLm6CpwA/laLMgJFQ1+aDIe7mqhSFG9q?=
 =?us-ascii?Q?uikzL1s4kP+54Bu5OqxGvEP1bRSzeH84+6QSPkTTM/HPuVH2LCrnV7sySiHu?=
 =?us-ascii?Q?Fw+z8I1YVgDPNaAS7NafXDFqB8pOLfmFnsijS18xe1ah3EAeeaEujFVfcWQf?=
 =?us-ascii?Q?ksqR/ZHIIiDyJdoHkcNd7sgrLE1irqlf78JrkPNT51G/ryIrEoJjLWp55g3+?=
 =?us-ascii?Q?vTGQDNMJvpH1/fGqCva5SblHLtcEOFgLRkpQEC68BkbDFX4MBt4aESRGuNMR?=
 =?us-ascii?Q?d7FBm9bMog0v7ocGOaywxudBS+Yvs9ARCi7tcJ6H556hJ/Mlxsv/hVMlb/U9?=
 =?us-ascii?Q?34CVKrE0V5z0eEwF+in3AokAUDFYuGsWYMffCCCRsqYqTvoYsS0pceT1qGvV?=
 =?us-ascii?Q?TyoNhi4b6d42CDtjk9rDR/rdMeDU1xVu/eHTJVjWPieOS1dwjgpYhAJhLppc?=
 =?us-ascii?Q?6FrE9udYrlbQB/bDFzAYjCWTznvEKFYPWdkq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?phGpCB5aeRVrb81K4Dgf+TAo2fF5jnGS5YFMLaKhFiT3Zleow/wCEF8YOyAQ?=
 =?us-ascii?Q?FHZldXsZNcj7LzhZz6sd+mJdx6R4RaexCfLL5R/iCWR2TLs5KxVyXkpqojGg?=
 =?us-ascii?Q?0UGfg4WFuipmgetUsrbAUrp6DInqVKynV/oyjtB3tFPekFLIoUpoz73T6lcV?=
 =?us-ascii?Q?Rw2YKbjasevk1Gy10ZyH/HnUEG7Usf14hh9pauV1ylFL14bPNX3lEo7BOJGd?=
 =?us-ascii?Q?PCJB6epoO8wqWaxkj44ZU1OxXR+RqqGxMwP4d7zkkILddOcw6MKTadCHukSc?=
 =?us-ascii?Q?48hSJuSkXM6PLL/XhgVmCAD/i7ZLIB2skqiVbBOtFc4KeRJbAzNnycQ2v0n7?=
 =?us-ascii?Q?i9mcV/Z5x9cchbOmr7Laex6l58Q4sjMoH1OAoe+zJtMCQ1jwyz5BTmLGMjTL?=
 =?us-ascii?Q?9VxT6e6CJqGWCHjXzNEt1ZBsInJbB3cNtxmUkNdjY/GNrXESlGQ1MAgjwly/?=
 =?us-ascii?Q?Jp/JaoBwJ8JMwp0N8vVl7wu8xQhzHJsDPivA4zUHoPpfOeY/xViRmnXFAljY?=
 =?us-ascii?Q?ip880a94ez54wiPM3FsI4JLdTb0Px0kK4S6auuDqNlh0m3WS/R2dRag/xY78?=
 =?us-ascii?Q?qlKCir0YWa2jLadXy7axJmNwgWr4aVXTjichnfg9xho6RNLQiyfAnGe/rVVm?=
 =?us-ascii?Q?aYMaD4lm6bnWTNNhsBGmeeZ9Y1vXjszfsA/0RFDtUvYqMuaGtprF828gIfat?=
 =?us-ascii?Q?sG70E99Ha2LFoYfNvhVyKZ1lfhXA15Uv1ZYWYY6NLAq7VAUA/OvMqT2Bd/6q?=
 =?us-ascii?Q?gN6QH0rRCzHBHISjXb8D/vMm+LokeZGAPdNWPhcBg29l9Xd/j33EGhW4A0BU?=
 =?us-ascii?Q?Nie5hr/Q7NI7TfzXgKH0RA/j4tcb9S9zqAVuyc9cqHVS+zbDJbxRQsh0CpiU?=
 =?us-ascii?Q?1emrvSvaWIuvMAlEdqOQc18EAkIJsjkWRPWUgcq2HieRHFgpzUEUINBmioG0?=
 =?us-ascii?Q?c8xI/0Ov2wXGWVlTyScGrC5oWixt4ICKX6p5995GNMwD0ya5weuY6gp5ddFl?=
 =?us-ascii?Q?YVXn4JuYTl0jLuFysD4NcVIRfngiKPZVKu6LmqL/wkhui4dbrzwa+6LAbHPb?=
 =?us-ascii?Q?iY85bL1zNTyArVUwVWD+NGY+3jfVJeUR9JZ/9HMm1TirRLyoCveUi7EBmbcL?=
 =?us-ascii?Q?kDMbxX3c0oIqwU48h+gDYpbuqcbvNtvEZurfzl9OUQvPUbszOvfEbHqrUlqS?=
 =?us-ascii?Q?T85UGTL1WOm6Aqy1WyLvtMAYWgZ0hiZM4auuEGaFTHFx8BxG13MCKXdLq4Qc?=
 =?us-ascii?Q?nT7mZKkekw79O/sMrkEu1pGxSSwzHSMDks+RCavSi5BECcymJmQZ2L1/RzMA?=
 =?us-ascii?Q?OWj09yY7NP7zZI1TosTHzgTsa7JO7M45yyaXaiajxQTgZBHKVy+E3IHd/qoE?=
 =?us-ascii?Q?Tz20cpF0Hk1LA3C1phNN2x6ac19n8VhUuHbsQviCV4zmUXgsa9dzhPPF9VWa?=
 =?us-ascii?Q?27Ebd8AKKysGEVClDoIVbcbnRofnX+pWc4o5gbttB2Y+O/f6fwXeW/CiO4+6?=
 =?us-ascii?Q?iQvlJCaF5Du8t1o5q/FIuUoRCOH2/E5qsKUZa9togi+AapvC9Y6ypIconbH2?=
 =?us-ascii?Q?jzDKqaZWJ5vEYfQXKRI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9555db7b-9c90-4c3c-a7d1-08de0806de88
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 14:11:13.1144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9v3wJi8+svpBMJFInBWIutRH+ngJ3+TxOKrRJ8LoxMhsQ6Rt2RxgZ9lvTukpiMNzoS8uYNRtVx1cliwHUcCVQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7671

On Fri, Oct 10, 2025 at 07:01:10PM +0800, Xu Yang wrote:
> Beside default 24MHz clock input, there is an optional additional 100Mhz
> clock input 'alt' for USB PHY reference clock.
>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> ---
> Changes in v2:
>  - improve commit message
> ---
>  Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml b/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml
> index 6a47e08e0e97b286538798190225ca2966a7ab34..081deb502e21308970a9495528bd745b9085f2f0 100644
> --- a/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml
> @@ -27,11 +27,16 @@ properties:
>      const: 0
>
>    clocks:
> -    maxItems: 1
> +    minItems: 1
> +    items:
> +      - description: PHY configuration clock
> +      - description: Alternate PHY reference clock
>
>    clock-names:
> +    minItems: 1
>      items:
>        - const: phy
> +      - const: alt
>
>    power-domains:
>      maxItems: 1
>
> --
> 2.34.1
>


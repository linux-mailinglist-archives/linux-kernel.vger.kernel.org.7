Return-Path: <linux-kernel+bounces-757919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 422CFB1C84C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ABDF18C4858
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E221229ACD1;
	Wed,  6 Aug 2025 15:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="pvBVnBTC"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013040.outbound.protection.outlook.com [52.101.72.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1621D299944;
	Wed,  6 Aug 2025 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754492765; cv=fail; b=bxVihrwLyTB90HdsE5ICczY72oGdfosM1nkyUdDFWgYkftEy8n77AoKvoYw2+aJ8BiHP39MpwW5D451/WCp4S4emvVGxXAoSEgWoZAQgoGd4ryKJh9YRjqquTNyZ4Pi+zYzkDDOE/0R8f8V4kcROBEW0KbESIKzgys/zq2mx1Mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754492765; c=relaxed/simple;
	bh=gumjwU/gAKlAC1WDrhmkIiMDJBGj0zT45d6La/hfmD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KPefZOBxjRQfqI4vNzdkWFzKkJfanMTRaTEHsHcOg1ODD67krLd+u1+3F7gnhIPHKF6QE+tO4obPJZNVNs5ut5wILjcn644TsRWhGRrjMAC0I01Z/SoDa0wROvF/PaiGZafy72WKgRSBesXNvN3GPEiBvvyQyvxb91bgbWgkeIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=pvBVnBTC; arc=fail smtp.client-ip=52.101.72.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WybzTtkQHeyZcZUXEwgC83i35qTb7x/Rt7InHuZt1dFwKqJV67R6FcvAjxbGm9tCIrZKn0vw5popkzKc9jvi27mm4+MmR/HvBcafxLhSjf7mXjAZ14TzxveHQENsQo34RuqQEnv6zphPeqJJUyRuHPCNVKSYkIdH9fQs03EhOahbL9u+PMHqJOxrNZdJvK5Cxvws1Aon+hWejk5SBMCzqtMXOBnkmK/CUsOTT5jq/TpJHSAqSdo2ojs9e1ZSKyoPGH4tYrnzyJQMOAX6UWGFcAb9vb0O6+zhHWFrhWUWxO3VzeYWsQrflRRLnyJvokWzDGzrXbj3peVBTlXj9v0cfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqSFGSknhmlx0FIYjahYkyZj2ajyLBBuUiUXGtqFspI=;
 b=MOR3vM4BrPYYT5afuv2krjUKkZ3OLL1O1wdy0W0Jmrv/jPWPYzcqmIEN3XXbGL7OUV677GcWESvUNO8rFCZ0lbkM5rGQ87Ozbfq81yxuwxQX1EHVG5ot3uUUqM3Us0UTRN/ibRdXeRkq+F6E1OurbXNj7rsAIRXy27Fu8s7pSS74yjNk9zOc3rnd4f1DaFcCkx3cOQq+N5Y8FDTcTy/o/BBYHn8KpxrMiL21C5G9Rh8FNP4/vCMwL+pzf0+NNAVD1xyy6Cs4iOOWkogz20+uW2vFEkwURhs3io+ZnhPWXs8Qvd2joiR1aZZfNIQHqwJxQu+68YZ9CTh+RbKbAOtu4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqSFGSknhmlx0FIYjahYkyZj2ajyLBBuUiUXGtqFspI=;
 b=pvBVnBTCQJX37V4AYlicdyG90gmkepSYq4xVxMSDof2aBtz3TgrHPpKvSO11mIMfTtT47XWeUH0U0Ao7J+Mxs1/S52iYOMyOqWT4xrMczCa96mCQPWXbC4AVZGDCsHXONn5i6u9np1IIGWbj6RyR1YHwTDHr+BhtlIzp/mwD0CtKun1n9BXPkcokZ41hfjdJ6gcutWGSvI3yUSdHIrGpvTM3tlE3Wp6MZ0nIye1kPRKgZPq5vRZIQ+F8YwtII3CCIJXIFAVmZ9MJnPQbH2Pjpy51oQS+Eyw4uojN9prnnp7pf6W3zf4K6gw7sBxuvPXxxVXq/iCGbHxm0T2zYPMGRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by AS1PR04MB9429.eurprd04.prod.outlook.com (2603:10a6:20b:4db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Wed, 6 Aug
 2025 15:06:01 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::b1f6:475e:de5d:8442]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::b1f6:475e:de5d:8442%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 15:06:01 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: imx@lists.linux.dev,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Frank Li <frank.li@nxp.com>,
	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 8/9] arm64: dts: imx943-evk: Add display support using IT6263
Date: Wed,  6 Aug 2025 18:05:15 +0300
Message-Id: <20250806150521.2174797-9-laurentiu.palcu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250806150521.2174797-1-laurentiu.palcu@oss.nxp.com>
References: <20250806150521.2174797-1-laurentiu.palcu@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0004.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::19) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|AS1PR04MB9429:EE_
X-MS-Office365-Filtering-Correlation-Id: ad53a5a9-d90b-4b55-d3e2-08ddd4fac13d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?THlYTuXQ81j5LgbdZmT7LV/LXUmr8AWBX4RlT5nKyKEFFkGwsaUhWx0rWu/m?=
 =?us-ascii?Q?HPtsPz6E5iK3oCbgsD0uju61GDVWA9hJu/FM1axYAKImJCi2+y5Zumhvbb2B?=
 =?us-ascii?Q?8C5EZviYSa1xD+V0N7ISxYYe0tvdFv00LZsySBAZDpfkVV6AzHFcTLTmYfe/?=
 =?us-ascii?Q?bFuvlbbCkrOd8P90PivU/wOrxE0K1dGqtEQRbhV4dgP1nPn1LZWTIWpwoX4Y?=
 =?us-ascii?Q?Kc3jon5T/c5q858HjxG1ROf+BApCOLQk9XYE+x/n+8xcCesjqZkUXj34x2Eq?=
 =?us-ascii?Q?0X66ccYnE9eOcbBZUvb4pQnLuv0f6aLED58fPIEGxBoXiVdK7kRiNh3pk6Gm?=
 =?us-ascii?Q?y4Xd1EyHlQeAPBVv0FmfgvRzGdeFkY2fPDExVdCYqX6Q2oZO+STEPnIjEvly?=
 =?us-ascii?Q?0A8n1ETJWa1seoTxEe9vS9cjbW40QJUGqBAlJ+I2CU8vxc5QL+Dg/6vy9/qK?=
 =?us-ascii?Q?oKFm4kUlBPKslkhqOgMFwggWfFn8r+2lZ+lzO/FB6K40a+BocoEDNTbIhbSc?=
 =?us-ascii?Q?NuYheewiHYIrXGh23w8vFpNegqRTdyGc+iEtblwaCGy0sTV53/3KldrhQ1Au?=
 =?us-ascii?Q?wKfRMvGwDRjpenWQmblo9IeswZMvA4QL/Cg7lSnFlTiXJYBM4mfCLSVWcIgd?=
 =?us-ascii?Q?uwNfuVwD0RfdCtAcRky2RNbi+fHImcSYRxZge2vGM4J4qr2MJQ9Pz3nCpOS6?=
 =?us-ascii?Q?WrZK+nShBuVmMhph/MvxP0sgkZNZGkkwmQnto+ZuWtydGbFvSdq9THkWBNBU?=
 =?us-ascii?Q?g0NxKtyOMzOiQhFy43MF1pE7RyQOU2L/7v3bpjznQYlk6zG3VoorJi0xJQUA?=
 =?us-ascii?Q?9ZLrUYcI/ElEIZw8EDDF333YK3CCt48KxbNTez/KV/kSOwafYc8YLh1rfJB0?=
 =?us-ascii?Q?cyB1dKz/ibzu68ZIMVmlxGNfbUIiDlNG8mn8XWxc8y2oHmCxs2JBGSr3+Am7?=
 =?us-ascii?Q?WB32lWS6nviRCjCQkN3HR4WSIG9FR8g7NnH8pgEwWEw6LJ82uYJbXBtjOgeb?=
 =?us-ascii?Q?rSXvxy+jai48l/NYU0ULDPTlum6SrvRdnw/uAjVo/jPX1v3a/RFU/h6Z8MCP?=
 =?us-ascii?Q?BtDCEEau3CoPB7/QAYf/i4ag+H5GPL6A22WfKPxM1+cO4i7xsqyjXpdt8oMk?=
 =?us-ascii?Q?n3Bn4bN9Xx0XuuwdT5Ell3OTS+ir850O5HRJEGwPjwQSB0EcTHcyEgV+ONim?=
 =?us-ascii?Q?pPs5Agap4kXEwaxx3WUDn76IRLrPtesBED/bIx5H5ofrfyEEdSkeZ57OhId4?=
 =?us-ascii?Q?M9Z64ETEEq7WEeVM9epkEdQ67VO2L04+T6QSD8svNH1TVXgvS7DVsw7BtmlV?=
 =?us-ascii?Q?gn0UiyZfjnFdb0HLpI5sgPeJ46+nDvA0dLT88DsL2heFtIiJxsm5jgXzuubY?=
 =?us-ascii?Q?nyIaI93MWBI4l3xUIjUfVh/F++6KgKck/y7sQWXnCCmmOS990w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9135.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1sRjOJc0Anhu8o8LkLVNdesSiEYl7N3E31tIod8wRccFSN14QUbyiWjPBmXk?=
 =?us-ascii?Q?9iUu2Vf018ZSBiHp9nMIDAQk+ykEbOQojDmooHS8LVfdQsrWgPIB4iUrdKeI?=
 =?us-ascii?Q?0wf/1d7QxyZ2jcPlEq1vT1MZE3x61kqNVWObCzHxLUx2ZCxH5HCoM6zEpYZW?=
 =?us-ascii?Q?beev2UVD15VGVMMCkU+nOLX6EQ0RNtoVkU6tx+hdpd+Eigd8PYTi4r0vf23a?=
 =?us-ascii?Q?cjZ+A1pBCRttAwttF8YyOrO2PGd216N8LaSzpGYRC6+MlC0FNG7a+dwesC7v?=
 =?us-ascii?Q?pjjMlMiYyZsilt6A4P5cV3EwPfj8RX3FcTwElxFtonZOPGDoPTBedyo5rDB9?=
 =?us-ascii?Q?sBqY2L8vlWET+X5BuHu3D21k/wawLsAVe4MngmE6xJJ/4bJN4HEFjIRMqjVu?=
 =?us-ascii?Q?uajujYADJ3tqklLXPf4FO15JLp+gg03ltRMHBBqtkKMn/f0mcTOdLjWq296D?=
 =?us-ascii?Q?buLtekXgOxvVH+ICy10drqHjlTHueeyO6PcaZ3Va26ntukM2HjV4MgA1TFYq?=
 =?us-ascii?Q?NNYs7r3dDtkpSXFp7FL6mjHdeTC2+OvG6a9RvXeiFhtQGZj8SD9cuBoDPLgx?=
 =?us-ascii?Q?SAOeswc+wtY2eCUZzNafL3DDpKTqlG6YssCDQT7edJyunnQscS0GLsP+QA7w?=
 =?us-ascii?Q?bjRunJIkEmH6LuYbRq4pnQqXhe8uw1YvP+mC3g6GikgKT3ojHYLvY2z/4w6A?=
 =?us-ascii?Q?Ff9UcKgQhrpOQcwuq6ezG4iCQxGRJagZnt2anuM4Oo0OMQtw4B+mcr/jkPip?=
 =?us-ascii?Q?+X8VWWdIygz6CjcdXle1IhxWIeqOgBwxxULVBwIpXZVLyn2Z6obycdT/R4xJ?=
 =?us-ascii?Q?1YZ4sFRWHJljJWqlGpuXCFnJXI07gcBWgGujUfPvKb5iig73W9IoF8PxnQjn?=
 =?us-ascii?Q?61XQw0Gr0vAekZnIPART+brp+1QGNdJK2g8h40Fpedbuq1ymavE20CGJprlb?=
 =?us-ascii?Q?jcHb6LoZOBJjQ8xrApX2kDkjH04Vrskn5XTmfm1ZRjL7Zjbid43kR7V69TAj?=
 =?us-ascii?Q?20CPEXwL6dHw7QzxyQ+0B05q9RdQp+Mtu8wxB61oghkhVd27wcPV0cV9EJvN?=
 =?us-ascii?Q?L9fo+HwY59IoXbPHO98WN2X6alT1l0bVJegSYoJvrBxnv6me68hc9psCVry1?=
 =?us-ascii?Q?B/cdQ5GSn6fgZc4c4T/9/QSKGSW12NPKh0S2l1UESYt19/TF/m1VJQXJwShl?=
 =?us-ascii?Q?wkvTYuX6Sv7bvN5lhlmnsGlRAs5fyoKbgeHpAbed/UZqkG6gejuLZbUWWZ6g?=
 =?us-ascii?Q?+QxgpUuJXOZJvGBYYSR8fmazc7vhhulTP+g3neyXS3mnim3GauwNmPBzNZ8j?=
 =?us-ascii?Q?WQb36uddIvgyatw3qv/6NamX+vDoqw687fusWORBX/IcKnKEqMr4qI07scF8?=
 =?us-ascii?Q?CK+oZgZqoEyCABj0WseIYvcT2VuP0En1QZZJbRjLqBhh/NZG+s64XEv0bBHY?=
 =?us-ascii?Q?7fNtD9iU/ExntAtDuug/vdSVvIs3TC31AbXiE0ti7xeERFKZJvxOaXGKkdDO?=
 =?us-ascii?Q?8xVBYPBlK3Cfoa4Mila7oe+hjlBH6pyKwvRFfVG90Yk9tbIRf9Byim96y96O?=
 =?us-ascii?Q?ve0exIK8EAfm5QAP/3KK4gxwxDdf3aFSljwtqVxutLcpYD2h9umhKUuhdSFh?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad53a5a9-d90b-4b55-d3e2-08ddd4fac13d
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 15:06:00.8888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cudclVSVF2JcXV6dEPq4ZvWz5YIG3j8ZNEwKLYiwNU9MsTaJjF4LRONdTUYuAg2iQSWV9uoPiOfCIh8daHSOpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9429

The ITE IT6263 based NXP LVDS to HDMI converter can be attached to the
i.MX943 EVK board LVDS port using the mini-SAS connector. Since this is
the default configuration for the EVK, add support for it here.

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/imx943-evk.dts | 121 +++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx943-evk.dts b/arch/arm64/boot/dts/freescale/imx943-evk.dts
index c8c3eff9df1a2..5900ff355abc2 100644
--- a/arch/arm64/boot/dts/freescale/imx943-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx943-evk.dts
@@ -34,6 +34,18 @@ dmic: dmic {
 		#sound-dai-cells = <0>;
 	};
 
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&it6263_out>;
+			};
+		};
+	};
+
 	reg_usdhc2_vmmc: regulator-usdhc2 {
 		compatible = "regulator-fixed";
 		off-on-delay-us = <12000>;
@@ -127,6 +139,115 @@ memory@80000000 {
 	};
 };
 
+&dcif {
+	status = "okay";
+};
+
+&ldb {
+	assigned-clocks = <&scmi_clk IMX94_CLK_LDBPLL_VCO>,
+			  <&scmi_clk IMX94_CLK_LDBPLL>;
+	assigned-clock-rates = <4158000000>, <1039500000>;
+	status = "okay";
+
+	ports {
+		port@1 {
+			lvds_out: endpoint {
+				remote-endpoint = <&it6263_in>;
+			};
+		};
+	};
+};
+
+&lpi2c3 {
+	clock-frequency = <400000>;
+	pinctrl-0 = <&pinctrl_lpi2c3>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	pca9548_i2c3: i2c-mux@77 {
+		compatible = "nxp,pca9548";
+		reg = <0x77>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			lvds-to-hdmi-bridge@4c {
+				compatible = "ite,it6263";
+				reg = <0x4c>;
+				data-mapping = "jeida-24";
+				reset-gpios = <&pcal6416_i2c3_u171 8 GPIO_ACTIVE_HIGH>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						it6263_in: endpoint {
+							remote-endpoint = <&lvds_out>;
+						};
+					};
+
+					port@2 {
+						reg = <2>;
+
+						it6263_out: endpoint {
+							remote-endpoint = <&hdmi_connector_in>;
+						};
+					};
+				};
+			};
+		};
+
+		i2c@4 {
+			reg = <4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c@5 {
+			reg = <5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c@6 {
+			reg = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c@7 {
+			reg = <7>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
 &lpi2c3 {
 	clock-frequency = <400000>;
 	pinctrl-0 = <&pinctrl_lpi2c3>;
-- 
2.49.0



Return-Path: <linux-kernel+bounces-895621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DF6C4E835
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1BE394F1D9D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426452DE707;
	Tue, 11 Nov 2025 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="QBRdb4PI"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021090.outbound.protection.outlook.com [52.101.70.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A862DC767;
	Tue, 11 Nov 2025 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871672; cv=fail; b=HYXrbEAUP95SS7AW2/1+97HZwuqwIqjU2Ln4By+BJ5pgzlQhBahTbw8rJBSrWuD4EI0mpY580ddu3IkCP0rDKg+9XSCwcVvBB9A7pDqyZZK5j5vlSRnLdD6Xis8zgDKU508myAQLOS0KfPNFLKkgtjXGak10YwuYgCRtGkOtdJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871672; c=relaxed/simple;
	bh=8lFeGKQi3XJoXbqFOaS4GywGRv1YbNZKN/zH1aKDWQI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ccn68hHM1aYfmVy4jxu3HnVLe8K0bdUbNDvJqTm/AijFKCmexNEUyLOfomnyE2z3pV4QXcUU1eVlOBvHqd0YNy1JY7Mg9hGG/DkuTm505pkNLOyWZAJ44sM5ILV2qUk9Ec3hQzgreF1HfyA8gEx/6376TSdjomlDP6lu8HMzmlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=QBRdb4PI; arc=fail smtp.client-ip=52.101.70.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOwCowaduIftag0b6Mcou7UnpABMuAUTrmYpYo/UK6vAHiZNrfvS0uZIvJvnYKNCo2333UhPv/TE7R6JP72eYNCSZdMhGh5gd7EwVoGjCoyT4VK9xmPZbqArj2Ihfms0XUjl8QhcYXCIEceGvdYjmDJ7P5qfbv45U2xj/YwsNqjQPPuyQbExP+1TJOtSKQGMNndKGPKtRdJjImG6JEPpJQQX+O2iAdzdf9cmltDjXLMwbZJayc7JtntwXvQP15IlYPjZ1ptAIQle+Q5PrRX9KANmF+SltZg+Em2vIhn6YK+HSaUp5Uv1JoHtkez84qYk/QwyocwJsH94+TR5WfinBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awz8JyVgwCWWIHu3ZS5zJIjBoq5ipV22WVrbdn9LsCE=;
 b=DUp4arllXz7VuU8Iq6MeT8a4L/QKDb8m9GPbZwIpuai3gOv+46vWdvQmbpVrbFxfzW0WRQrMlI9sSJkPMCE2BBrcBEyzYMfXAfx92XZhW57XnO/2YZY69AnfFbuLURdcXH29k2rVIS6qjuSJ+1VZ8M6lnoY3cBfMYmGLoRj6tYrbyv1zwQsc33asYZwauKZSRkWHQKtvn5fpaT+ZdVC356rTblkc6myO08K1R5knTF6f0kLSrIxAnqi188CJsCHPVB6mYvNDMVoAKyTJ1DldWuXJNkuTdh6Lzs0u39uLvwkjsrgbOf99lMJOcYoLOrQ11yBK+O0kBTzZMzA9hd4dbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=kernel.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awz8JyVgwCWWIHu3ZS5zJIjBoq5ipV22WVrbdn9LsCE=;
 b=QBRdb4PIoLyYgaRs+ecDrnMEgY5UvCcbwCCOu+7qS5UVngZ2HjirMx+lZ88UFdDgDsoR+adanlBRYfozllgg/uj1gITb/gB7weoqbuR+TGMUEs3S3wZdkKziOfYWUYzG9pzvJyiwVq3oZe2h/CprsoCrLaBwTUlx1us2VKYdYCC5PBYD/JikDhr8Qm+/abs7VNFCAnJjq7X/I0liutC6LuUlZGhko16XVkZm9O2NMi7KdswcnxQcoJWSFE1QbwehG1tclhfft/cJ4tWZWr3NmLiOWRGa+cWWKpNStUpNozVeApraUdTlM9mfbEklo7x9d9BGMjgbNNg9jfC8fBxamg==
Received: from AM0PR02CA0160.eurprd02.prod.outlook.com (2603:10a6:20b:28d::27)
 by VI2P195MB2519.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:21d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 14:34:23 +0000
Received: from AMS0EPF000001B7.eurprd05.prod.outlook.com
 (2603:10a6:20b:28d:cafe::ce) by AM0PR02CA0160.outlook.office365.com
 (2603:10a6:20b:28d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 14:34:23 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AMS0EPF000001B7.mail.protection.outlook.com (10.167.16.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 14:34:23 +0000
Received: from llp-varakala.phytec.de (172.25.32.223) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 11 Nov
 2025 15:34:22 +0100
From: Yashwanth Varakala <y.varakala@phytec.de>
To: <shawnguo@kernel.org>, <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
	<festevam@gmail.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<upstream@lists.phytec.de>, <peng.fan@nxp.com>, <y.varakala@phytec.de>
Subject: [PATCH 1/2] arm64: dts: imx8mp libra: add and update display overlays
Date: Tue, 11 Nov 2025 15:34:06 +0100
Message-ID: <20251111143407.24657-2-y.varakala@phytec.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251111143407.24657-1-y.varakala@phytec.de>
References: <20251111143407.24657-1-y.varakala@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B7:EE_|VI2P195MB2519:EE_
X-MS-Office365-Filtering-Correlation-Id: 121884f5-48df-42d8-0f67-08de212f689c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JUgcv1Qbw2BZH0FfeLiUEtR2n/rx15zgHYhLx2u0tCpOI1WN9K1Jb9H9+Zp1?=
 =?us-ascii?Q?ecs/Tie/i5h0D0re1WjGYje5Vqa6jlI3Twujy+anZCr74qX8acy6orWN5HV0?=
 =?us-ascii?Q?o7HwEK3Al7/dsEjHctHQqXRdU7SRoCHNGLo9yY6lK+FQrByIaIhaVAsyosV0?=
 =?us-ascii?Q?KCLi2YDK8ZfuGr3QclkyaNug+VXCD3+lV12/3U4UPxcL5u+t+OtCPu/LXYy2?=
 =?us-ascii?Q?umZcU5ZxxLC9y8IE8p1RXTSWblrnSPvlhTXiqkdi5vfqEkHXShZQN++C7PZq?=
 =?us-ascii?Q?SSxz3Y3jvbJgRKWCjyrRtlqcNJUwSWtgT3RdPW39COlP+qhGMJVDtug78wnV?=
 =?us-ascii?Q?AtZ4jiMAuTeXNW++KHPEuJE7an07YLN+ZV8JBDXFLmdIKv1o4N4/v+ZOnOxV?=
 =?us-ascii?Q?TjcajBAxlVvx7ZUadXcRzvE2QVXB9ExA+xhTFTAI74ef6Cmpjj7vxVTlRJIC?=
 =?us-ascii?Q?+pfoopuZYnXhh8J0ki4aNYcuAtE5qas59jXt8dOoI64Z//bP6zGRENAUgZPG?=
 =?us-ascii?Q?CqTKa+JHTVtGQXYHR7+XCHGMvnU4uDNSo007TBUntulncyE061l4t4Hfzf6A?=
 =?us-ascii?Q?FBLBLMd+AI42TffGpXysEH0Gna1de+rrVbzECTFctYGpeSwrakABHeJ/Gv1C?=
 =?us-ascii?Q?RN3pFwD1L4bgJf/1zp0wKNbqxQwsNJpcvDEpcBO6FEgjdOu7YolhiSoSxTIc?=
 =?us-ascii?Q?7SwehlK3Kz8wUroAOQDHY7Zd14vdmMD54IxWY1YtHVqBQMdMe0mqOS974jTt?=
 =?us-ascii?Q?JyvdimP4GB38K1UNuPFKTYt7yEngbN0rfq2ztJHIPWGkJnfrfJuuAYgICxXf?=
 =?us-ascii?Q?/R6wEgBmj3GXiuwG+qmoc7DN0xyA1HP4iTsZhGAqOWLAGwfQIsPEJir1aWbY?=
 =?us-ascii?Q?2hVOy+50K+p32UG64mqMvmi+AwvV6zCoZjTRSwGepfo88Ky8z6/rZz6Wd6Ej?=
 =?us-ascii?Q?3inNcDX/kf0xHOJ5KHtfWfLh6iVM1YfJvQ79ds7h/7X6+RV3103cWD2pWg/q?=
 =?us-ascii?Q?YG9wo0jVOaswkDu8DNEXkf71a7oWplBaF0KyROpDmRBWr42W7RDNGsNCmYAg?=
 =?us-ascii?Q?SdmU72zOjStVoQ1bwowXInN9UKEhTnPG4a1Hz8UtzukBQU/faID6holZrFvJ?=
 =?us-ascii?Q?a93pURiBaRGI8ORfTBotQaKwvBaTq1elbydC21+NfC+kI+xE4A0vrCzhxaCd?=
 =?us-ascii?Q?ojILzjiBHxbCcZExv/dhFFsgPgI2zp7OSHpc57xUvP5vGG2Vvt4iJYymDbrP?=
 =?us-ascii?Q?+DQo9TmyzACJXkZtjaFTP/d3u4QVkw6F7mmWEXotx7SPsBTRm26lgORHfAVv?=
 =?us-ascii?Q?eVIz/mOiX3UTjaV8J6ui/685CaoL7S5uNW71FecPdbMTTw9sFIh+l0h54U0Y?=
 =?us-ascii?Q?v9oCKI063xPzXwsQjHdckljJHwgnsSgkeG2n6K3ncZ64MDLop17LwRYSJT9I?=
 =?us-ascii?Q?ELBH4zvb4QqcsmhnUMG3pfUCZjMC64z0wUEF+SiwR5YJcNQsHp8qJEWez8g2?=
 =?us-ascii?Q?YkeuTsgr6+LQ94vddbdOm0ZZysQQ3JUjixx5M9hh3SokpAwkyWi7Wyk0og?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Postix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 14:34:23.5003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 121884f5-48df-42d8-0f67-08de212f689c
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2P195MB2519

Add imx8mp-libra-rdk-fpsc-lvds-ph128800t006-zhc01.dtso
devicetree display overlay for the i.MX8MP Libra RDK platform.
The overlay enable LVDS display configuration.

To keep the consistent style of panel and backlight nodes and labels.
They are updated in imx8mp-libra base board devicetree and
etml1010g3dra display overlay.

Signed-off-by: Yashwanth Varakala <y.varakala@phytec.de>
---
 arch/arm64/boot/dts/freescale/Makefile        |  8 +++-
 ...8mp-libra-rdk-fpsc-lvds-etml1010g3dra.dtso |  2 +-
 ...ibra-rdk-fpsc-lvds-ph128800t006-zhc01.dtso | 44 +++++++++++++++++++
 .../dts/freescale/imx8mp-libra-rdk-fpsc.dts   |  4 +-
 4 files changed, 53 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-libra-rdk-fpsc-lvds-ph128800t006-zhc01.dtso

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 525ef180481d..eb38dcc76b84 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -219,8 +219,12 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-kontron-dl.dtb
 
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-kontron-smarc-eval-carrier.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-libra-rdk-fpsc.dtb
-imx8mp-libra-rdk-fpsc-lvds-dtbs += imx8mp-libra-rdk-fpsc.dtb imx8mp-libra-rdk-fpsc-lvds-etml1010g3dra.dtbo
-dtb-$(CONFIG_ARCH_MXC) += imx8mp-libra-rdk-fpsc-lvds.dtb
+imx8mp-libra-rdk-fpsc-lvds-etml1010g3dra-dtbs += imx8mp-libra-rdk-fpsc.dtb \
+	imx8mp-libra-rdk-fpsc-lvds-etml1010g3dra.dtbo
+imx8mp-libra-rdk-fpsc-lvds-ph128800t006-zhc01-dtbs += imx8mp-libra-rdk-fpsc.dtb \
+	imx8mp-libra-rdk-fpsc-lvds-ph128800t006-zhc01.dtbo
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-libra-rdk-fpsc-lvds-etml1010g3dra.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-libra-rdk-fpsc-lvds-ph128800t006-zhc01.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-msc-sm2s-ep1.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-navqp.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-nitrogen-enc-carrier-board.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-libra-rdk-fpsc-lvds-etml1010g3dra.dtso b/arch/arm64/boot/dts/freescale/imx8mp-libra-rdk-fpsc-lvds-etml1010g3dra.dtso
index 1dcf249ca90d..02889d691c01 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-libra-rdk-fpsc-lvds-etml1010g3dra.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mp-libra-rdk-fpsc-lvds-etml1010g3dra.dtso
@@ -34,7 +34,7 @@ &lvds_bridge {
 	status = "okay";
 };
 
-&panel0_lvds {
+&panel_lvds0 {
 	compatible = "edt,etml1010g3dra";
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-libra-rdk-fpsc-lvds-ph128800t006-zhc01.dtso b/arch/arm64/boot/dts/freescale/imx8mp-libra-rdk-fpsc-lvds-ph128800t006-zhc01.dtso
new file mode 100644
index 000000000000..418c8536e791
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-libra-rdk-fpsc-lvds-ph128800t006-zhc01.dtso
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clock/imx8mp-clock.h>
+
+/dts-v1/;
+/plugin/;
+
+&backlight_lvds0 {
+	brightness-levels = <0 8 16 32 64 128 255>;
+	default-brightness-level = <8>;
+	enable-gpios = <&gpio5 23 GPIO_ACTIVE_LOW>;
+	num-interpolated-steps = <2>;
+	pwms = <&pwm1 0 66667 0>;
+	status = "okay";
+};
+
+&lcdif2 {
+	status = "okay";
+};
+
+&lvds_bridge {
+	assigned-clocks = <&clk IMX8MP_CLK_MEDIA_LDB>, <&clk IMX8MP_VIDEO_PLL1>;
+	assigned-clock-parents = <&clk IMX8MP_VIDEO_PLL1_OUT>;
+	/*
+	 * The LVDS panel uses 66.5 MHz pixel clock, set IMX8MP_VIDEO_PLL1 to
+	 * 66.5 * 7 = 465.5 MHz so the LDB serializer and LCDIFv3 scanout
+	 * engine can reach accurate pixel clock of exactly 66.5 MHz.
+	 */
+	assigned-clock-rates = <0>, <465500000>;
+	status = "okay";
+};
+
+&panel_lvds0 {
+	compatible = "powertip,ph128800t006-zhc01";
+	status = "okay";
+};
+
+&pwm1 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-libra-rdk-fpsc.dts b/arch/arm64/boot/dts/freescale/imx8mp-libra-rdk-fpsc.dts
index 7a20284b0a29..4ffc950711d8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-libra-rdk-fpsc.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-libra-rdk-fpsc.dts
@@ -15,7 +15,7 @@ / {
 		     "phytec,imx8mp-phycore-fpsc", "fsl,imx8mp";
 	model = "PHYTEC i.MX8MP Libra RDK FPSC";
 
-	backlight_lvds0: backlight0 {
+	backlight_lvds0: backlight-lvds0 {
 		compatible = "pwm-backlight";
 		pinctrl-0 = <&pinctrl_lvds0>;
 		pinctrl-names = "default";
@@ -27,7 +27,7 @@ chosen {
 		stdout-path = &uart4;
 	};
 
-	panel0_lvds: panel-lvds {
+	panel_lvds0: panel-lvds0 {
 		/* compatible panel in overlay */
 		backlight = <&backlight_lvds0>;
 		power-supply = <&reg_vdd_3v3>;
-- 
2.34.1



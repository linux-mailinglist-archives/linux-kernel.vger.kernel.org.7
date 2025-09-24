Return-Path: <linux-kernel+bounces-830684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C66C3B9A4C2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36CE41749ED
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F08309EEC;
	Wed, 24 Sep 2025 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="rHr2x1Dh"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020092.outbound.protection.outlook.com [52.101.84.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914FC347C7;
	Wed, 24 Sep 2025 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758724776; cv=fail; b=I3gCdoyEXUoes9P13KSA4Dr4oEc3dTTm4gbVfgqab73U3MjLCYtPyYWCbXmZ5XeHUgpVsKBQy14aHFuFQ55vrCTaHhpVr/iP6P7iRWiQ9IWqU3OCNaeiG44eQKAX4imqpniAC2OLhuJzxX2ipOncpysTa8QXzRpGI4xGEZYT8Sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758724776; c=relaxed/simple;
	bh=TsSjGv60nXugF708EDyoJocZoh3bKqkgYWfgWdq9C1c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tjh5aedfYzRZYN7PgpNL31OeP+X2wXvJJE8xVxaIJFwpMCH23PvRVPZfANXCRNFkTUIzRqAI7+ARGx4QeCEdt7lG+06Ri48/HhYlkwLgayereoy/vS7GymtbWDnCwUWfueAFJ7oBGQJ64Bf6guOtuE5P59KULzDdlFgLi/VY7r0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=rHr2x1Dh; arc=fail smtp.client-ip=52.101.84.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSw7q62pE3VsH3aENGY9Q4cfoM+5IJuY7jJ4f87U0bUADC0Bt/Baqb1+HJH8tcYr3gasdzil/M0tpzsE2mG1o34anuRVnWP5aHrO8WTvkLqqSUC3FXblmuO+MJtn0fGAk+2gF5VXHAL+G1JszNOfP/0zCAyCXaqj7uGvf4efxU5tPQC3EpUKyUYk6sKBgGTI0uawQpEon3pppph5MTLH7cxg+1r3uyF1M/1EQ4RvyWIZR5UDJfELXzmQRKfkYVLFkYqJBw+dS/1NGzMDPGadqcPatWrQ0NseqZrXQBS3nS35ON8uMVlTKstSUtSUb+YMf6tHAS2YJI4YWtcOQ1aJtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hWhBeXjtLptFpWWoM4lvcKdFje/4R/pXn4EXGBIAWI=;
 b=qsMEKEZdLPucjLSc/hZVhe4NdhVJDazu5Kzm0uHZ37EymLdsf2Kmwj58yvGmU/7UqmGARn62YG8xzNkOiA+7QY9jI+dpr9+dlegmpjQie5SqwJhiYtSVrv0cXwqp9RH648MXtCUuu7ns094pCNJgWjbulMO4Zf0YUxnhPoDMCdQyc6BIgaZM9XGjTwil2qkenhfyfzwbwuP5hoaan0sIzSLimRvhVk1W/09PeKRhqFkJWbWN+Ags7eDskKevLi0G8/r1h/J+YWJR+ZsdKd0fcEu/oBzNOinzv2oNBxLsyA+wPwk5STIqyG82ftkFBJUq1LMLjYxAqa3XxJJKPgzziw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=ti.com smtp.mailfrom=phytec.de; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine header.from=phytec.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hWhBeXjtLptFpWWoM4lvcKdFje/4R/pXn4EXGBIAWI=;
 b=rHr2x1DhFmCW6Kyyb3G/r2Dc+89eaGGGhXL3SOceRDRmLQ16+vSax0RlIH81Bz6rOylD82qlqY1HcekN1hFnqzR2RN0R8hnEzK2HJOIFJ9NhOZeNkiohQU+v4bs7aVq56cyjXxFJtjQ72F2rTdzfqE6+JA8mokvH1vCXCjIFukSc2xBl1l60TiGJVX2RbCNAOIdW3BQRGFC4mjJCHnJpeaPn+YL/gZpTojYcmuJMKEZXCP3QXRGtYtugkaMMN7TxvsiF2356QFbJAvzkvSD4tQ5JWk7/bFVVlRa9tgS/CWW8DJ/dLGyVaQxO4GJ2BEBaTg+HjTCC7BzMztQvEDO5QA==
Received: from CWLP123CA0077.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:5b::17)
 by PR3P195MB0960.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:af::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 14:39:28 +0000
Received: from AM4PEPF00027A5E.eurprd04.prod.outlook.com
 (2603:10a6:401:5b:cafe::be) by CWLP123CA0077.outlook.office365.com
 (2603:10a6:401:5b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Wed,
 24 Sep 2025 14:39:28 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AM4PEPF00027A5E.mail.protection.outlook.com (10.167.16.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 14:39:28 +0000
Received: from phytec.de (172.25.0.51) by Postix.phytec.de (172.25.0.11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 24 Sep
 2025 16:39:26 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <aradhya.bhatia@linux.dev>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
Subject: [PATCH 3/3] arm64: dts: ti: am625-phyboard-lyra: Add Lincoln LCD185-101CT panel overlay
Date: Wed, 24 Sep 2025 16:39:16 +0200
Message-ID: <20250924143916.2023919-3-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250924143916.2023919-1-w.egorov@phytec.de>
References: <20250924143916.2023919-1-w.egorov@phytec.de>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A5E:EE_|PR3P195MB0960:EE_
X-MS-Office365-Filtering-Correlation-Id: e46f1b45-35fa-4992-5df2-08ddfb782a90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GoeGp8SuPf96YCoUQ3ye3jR8m/VCBydZyI2cFJZRlqSUxa/NnvWcyJsiIlKm?=
 =?us-ascii?Q?winujdHzZYjmP+pzTzMPUHDyeLTfKAn46YwTYnIJ+ymCVvrdsWOx0tBhJ+de?=
 =?us-ascii?Q?cZw482R62jcvIOAL0sscM2C9iA5hni5T9OdeDkOQoD46wt9Veo54p+NvMInq?=
 =?us-ascii?Q?hobpGf4+fvxqMF1xr3H+lG35eruKBfiTC+4bOnd1yo8jo8wMPbCafZUG9f1v?=
 =?us-ascii?Q?/OPlspNvYVoBE216eTpyUUmA0ZmKoXTnf1lMgDHaBvHCVr4a334p1v9DQkJN?=
 =?us-ascii?Q?pONPACy3VB/KWCDIXbV0ZXyyDV5VrhQf8fLYgwtCP+/gb5Ooy1iw/odhLGtl?=
 =?us-ascii?Q?xtd2JdpKQ2wbbhKmM/ROwvEk87P7DBjkTZNnJdvBdUamfV3/3XCU3VA4osTa?=
 =?us-ascii?Q?EMVAq8LZJBzmpLP8ih1/D+bql/z05wwPcAHrXcwVADk/SdNOUECIBvYLXOfZ?=
 =?us-ascii?Q?iCdurculcEsBFOQnGfTpxGIYAdPoZNSx4rROM24swFWVOpAfLYk0iWMaoyd8?=
 =?us-ascii?Q?bronCV1xZvyWIdzGBUadbTQNi1N1p5dVi2bzMBjTmtEjLBP9XOWokZe8PmQo?=
 =?us-ascii?Q?Y9iU9TkylbDiFFP23AfFJ+IqNgs+BShkCn9h+VYlSSFv+b5Qh8g65uygrA7P?=
 =?us-ascii?Q?yfTrpqj5E+LIrrtro40snVq63cuxe85XQX/jBs9QjRfJjQ2Z6ACxTIPr6FMG?=
 =?us-ascii?Q?Xm1hch+oKi+q105tqjf9ZtBLklvgrIdz6GfWlSQ1QtYSPnW2w8Zm4b/ELPkJ?=
 =?us-ascii?Q?y/di20GxlsfaoS/X7aA2Ku2GFs3dF6pjctIOvOYLHnx3HuFkfMEf4ApAaYHd?=
 =?us-ascii?Q?+t7EiFVx4heratUMMUWhqZRF+qjJfWx1hnooTtayyQn0sZ9b2diqifBPwZkj?=
 =?us-ascii?Q?l0eYpRnwcOif88qBamOUcQW9bhsNH2CNsRlx7qe5YRGXEZb+atYkySwq1RI5?=
 =?us-ascii?Q?GGTEwQ0JWypYg9dRLIY17rOmvY6aKfKUe0z9XkjdyPddtKCA4olnqk9e/D21?=
 =?us-ascii?Q?2e9XvsY8Qv0aHoWkxdj19JIPvxY0mDUALcGdEj/mnCJptTGm+rJT8iH8yyxc?=
 =?us-ascii?Q?OvLSm33cr1IoXKNf71fF9HGkBAEZOlM7eZ/nJm8DDOs2Aj8eS126Svl8pcgP?=
 =?us-ascii?Q?9sCLKh+6KTAdXqO35PccNF6vv1tVsTFd/AsmN2zt3CQo/Mk8sSI78MrFRrfc?=
 =?us-ascii?Q?pgPpw/60Afy/p4YoCJIxawDNsgPEiNZF+jTb/Is15P2jQMs9n5t2PggZtVV6?=
 =?us-ascii?Q?ngeDpXepInsjitI826mPOUlhOigM46wDsGp9vdbSqeC38I6MldvJpW1uEf+L?=
 =?us-ascii?Q?ImuOHUk96+z5+Z/zqXtZO7UNX55N7Z8mPvROE+6dXAUBw4aVD7UAS8yOmCwO?=
 =?us-ascii?Q?iEMiHnr7czaViP/SHOUZ9bRt6lDbljtvMP0eOdVYlPBf4n5Tq/U/dg8IdMaF?=
 =?us-ascii?Q?2LFh65J/sLoXEH75HpJNoc5RD0KcMsVw1nYstJpZI0nPpHIBkscWDQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Postix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:39:28.4830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e46f1b45-35fa-4992-5df2-08ddfb782a90
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A5E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0960

The panel is a Lincoln Technology Solutions LCD185-101CT [0]. It is
a dual-link LVDS panel and supports WUXGA resolution (1920x1200).
Furthermore, it has an I2C based touch controller: Goodix-GT928.

Add an device tree overlay to support the Lincoln LCD185-101CT panel
in combination with the phyBOARD-Lyra-AM62x.

[0] https://lincolntechsolutions.com/wp-content/uploads/2024/09/LCD185-101CTL1ARNTT_DS_R1.3.pdf

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm64/boot/dts/ti/Makefile               |   3 +
 .../k3-am625-phyboard-lyra-oldi-lcd185.dtso   | 202 ++++++++++++++++++
 2 files changed, 205 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-oldi-lcd185.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index aad9177930e6..aa34a0d77615 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -13,6 +13,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am625-beagleplay.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-beagleplay-csi2-ov5640.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-beagleplay-csi2-tevi-ov5640.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-phyboard-lyra-rdk.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am652-phyboard-lyra-oldi-lcd185.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-nonwifi-dahlia.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-nonwifi-dev.dtb
@@ -165,6 +166,8 @@ k3-am625-phyboard-lyra-gpio-fan-dtbs := k3-am625-phyboard-lyra-rdk.dtb \
 	k3-am62x-phyboard-lyra-gpio-fan.dtbo
 k3-am625-phyboard-lyra-qspi-nor-dtbs := k3-am625-phyboard-lyra-rdk.dtb \
 	k3-am6xx-phycore-qspi-nor.dtbo
+k3-am625-phyboard-lyra-oldi-lcd185-dtbs := k3-am625-phyboard-lyra-rdk.dtb \
+	k3-am625-phyboard-lyra-oldi-lcd185.dtbo
 k3-am625-sk-csi2-imx219-dtbs := k3-am625-sk.dtb \
 	k3-am62x-sk-csi2-imx219.dtbo
 k3-am625-sk-csi2-ov5640-dtbs := k3-am625-sk.dtb \
diff --git a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-oldi-lcd185.dtso b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-oldi-lcd185.dtso
new file mode 100644
index 000000000000..8f8e0eddc748
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-oldi-lcd185.dtso
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ * Author: Wadim Egorov <w.egorov@phytec.de>
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/pwm/pwm.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "k3-pinctrl.h"
+
+&{/} {
+	display {
+		compatible = "lincolntech,lcd185-101ct";
+		backlight = <&backlight>;
+		power-supply = <&vdd_usb_5v0>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				dual-lvds-odd-pixels;
+				lcd_in0: endpoint {
+					remote-endpoint = <&oldi_0_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				dual-lvds-even-pixels;
+				lcd_in1: endpoint {
+					remote-endpoint = <&oldi_1_out>;
+				};
+			};
+		};
+	};
+
+	backlight: backlight {
+		pinctrl-names = "default";
+		pinctrl-0 = <&bl_pwm_pins_default>;
+
+		compatible = "pwm-backlight";
+
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+
+		enable-gpios = <&gpio_exp 5 GPIO_ACTIVE_HIGH>;
+		pwms = <&epwm0 1 50000 0>;
+	};
+
+        vdd_usb_5v0: regulator-vdd-usb5v0 {
+                compatible = "regulator-fixed";
+                regulator-name = "vdd-usb5v0";
+                regulator-min-microvolt = <5000000>;
+                regulator-max-microvolt = <5000000>;
+                regulator-always-on;
+                regulator-boot-on;
+        };
+};
+
+&dss {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_oldi0_pins_default &main_dss0_pins_default>;
+};
+
+&dss_ports {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* VP1: Output to OLDI */
+	port@0 {
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		dpi0_out0: endpoint@0 {
+			reg = <0>;
+			remote-endpoint = <&oldi_0_in>;
+		};
+
+		dpi0_out1: endpoint@1 {
+			reg = <1>;
+			remote-endpoint = <&oldi_1_in>;
+		};
+	};
+};
+
+&epwm0 {
+	status = "okay";
+};
+
+&main_i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	touchscreen@5d {
+		compatible = "goodix,gt928";
+		reg = <0x5d>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&touch_screen_pins_default>;
+
+		interrupt-parent = <&main_gpio0>;
+		interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
+
+		reset-gpios = <&main_gpio0 18 GPIO_ACTIVE_HIGH>;
+		irq-gpios = <&main_gpio0 19 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&main_pmx0 {
+	bl_pwm_pins_default: bl-pwm-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x01b8, PIN_INPUT, 2) /* (C13) SPI0_CS1.EHRPWM0_B */
+		>;
+	};
+
+	touch_screen_pins_default: touch-screen-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x048, PIN_OUTPUT, 7) /* (N25) GPMC0_AD3.GPIO0_18 - RST */
+			AM62X_IOPAD(0x04c, PIN_INPUT, 7) /* (P24) GPMC0_AD4.GPIO0_19 - INT */
+		>;
+	};
+
+	main_oldi0_pins_default: main-oldi0-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x0260, PIN_OUTPUT, 0) /* (AA5) OLDI0_A0N */
+			AM62X_IOPAD(0x025c, PIN_OUTPUT, 0) /* (Y6) OLDI0_A0P */
+			AM62X_IOPAD(0x0268, PIN_OUTPUT, 0) /* (AD3) OLDI0_A1N */
+			AM62X_IOPAD(0x0264, PIN_OUTPUT, 0) /* (AB4) OLDI0_A1P */
+			AM62X_IOPAD(0x0270, PIN_OUTPUT, 0) /* (Y8) OLDI0_A2N */
+			AM62X_IOPAD(0x026c, PIN_OUTPUT, 0) /* (AA8) OLDI0_A2P */
+			AM62X_IOPAD(0x0278, PIN_OUTPUT, 0) /* (AB6) OLDI0_A3N */
+			AM62X_IOPAD(0x0274, PIN_OUTPUT, 0) /* (AA7) OLDI0_A3P */
+			AM62X_IOPAD(0x0280, PIN_OUTPUT, 0) /* (AC6) OLDI0_A4N */
+			AM62X_IOPAD(0x027c, PIN_OUTPUT, 0) /* (AC5) OLDI0_A4P */
+			AM62X_IOPAD(0x0288, PIN_OUTPUT, 0) /* (AE5) OLDI0_A5N */
+			AM62X_IOPAD(0x0284, PIN_OUTPUT, 0) /* (AD6) OLDI0_A5P */
+			AM62X_IOPAD(0x0290, PIN_OUTPUT, 0) /* (AE6) OLDI0_A6N */
+			AM62X_IOPAD(0x028c, PIN_OUTPUT, 0) /* (AD7) OLDI0_A6P */
+			AM62X_IOPAD(0x0298, PIN_OUTPUT, 0) /* (AD8) OLDI0_A7N */
+			AM62X_IOPAD(0x0294, PIN_OUTPUT, 0) /* (AE7) OLDI0_A7P */
+			AM62X_IOPAD(0x02a0, PIN_OUTPUT, 0) /* (AD4) OLDI0_CLK0N */
+			AM62X_IOPAD(0x029c, PIN_OUTPUT, 0) /* (AE3) OLDI0_CLK0P */
+			AM62X_IOPAD(0x02a8, PIN_OUTPUT, 0) /* (AE4) OLDI0_CLK1N */
+			AM62X_IOPAD(0x02a4, PIN_OUTPUT, 0) /* (AD5) OLDI0_CLK1P */
+		>;
+	};
+};
+
+&oldi0 {
+	ti,companion-oldi = <&oldi1>;
+	status = "okay";
+};
+
+&oldi1 {
+	ti,secondary-oldi;
+	status = "okay";
+};
+
+&oldi0_ports {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	port@0 {
+		reg = <0>;
+		oldi_0_in: endpoint {
+			remote-endpoint = <&dpi0_out0>;
+		};
+	};
+
+	port@1 {
+		reg = <1>;
+		oldi_0_out: endpoint {
+			remote-endpoint = <&lcd_in0>;
+		};
+	};
+};
+
+&oldi1_ports {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	port@0 {
+		reg = <0>;
+		oldi_1_in: endpoint {
+			remote-endpoint = <&dpi0_out1>;
+		};
+	};
+
+	port@1 {
+		reg = <1>;
+		oldi_1_out: endpoint {
+			remote-endpoint = <&lcd_in1>;
+		};
+	};
+};
-- 
2.48.1



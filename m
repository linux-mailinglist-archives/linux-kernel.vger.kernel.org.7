Return-Path: <linux-kernel+bounces-832163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8536B9E872
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 832DE1651F9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEA42EA179;
	Thu, 25 Sep 2025 10:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="OXxAlb89"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021118.outbound.protection.outlook.com [52.101.70.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16D02550AD;
	Thu, 25 Sep 2025 10:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758794454; cv=fail; b=J4lxnJEpXTZe0sKpSb5Ent9OgQVf9FQt496xM1AoZDKyjtUlByjGTbqf5XErJOnKDqtEBV7RJ4Q67/6tEP/NGlW2DU0/cPMyhqacUqd7jWrvpUqMCjKSfqbX4hE42b6bZuRMUeMy5BvRf17FskAQ9jsCpO1tXlyDWOFTBOeR7sU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758794454; c=relaxed/simple;
	bh=a0VWFHYHHd8VzQUEVQNCB+zbIK1bKRgAD+9UKfeRO/4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oe8UaFPZfLWGqci9sKVnGy8AeJjZADQ8ADH+HOkxETXV7ey6zprmH+a3El9dqf7QJ3txV2KD9QJOnT62/B+qSkdh6uR1oUFM+L4R8VvJB8jKag10Q4bsbhKkUOZdjqd++18yKD+uH3AIZc/Jb6z5ybc+eIYMIXrY8PwBraa5IqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=OXxAlb89; arc=fail smtp.client-ip=52.101.70.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lbMQqTk2Kf+rlPHpMXuUzqiEEXZ/9at25JZDNouI6+U+As44cU/CcYNkg32ztQXWbaTrfsCJjaOkGLdyNNK7XAFlGsnH4ZuBbKjpC/Kbs2CB9f8WoBkxlqBoLnttiZ+gEunapMFOpyfx5rVC/0yMVHyb74DhC1tZllnKYezX1gP2nmPNSrJu9/sPMRVOcOXNP6bIK9ilMDY+vaI09lYdPGUaMghX97H2tokzhuCQPiNwhoI3MOfee7OmMI2s7QBJZI/FfBElvBuNgWKQNr/gOS+zCPG2xFsmtTJaPZoG8O5bt4jFzSbAJn0C81Zl6kcSz5dptYZbb9d0QUgBh14j5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjfLd1KwWR3eJHSXHXjdsR07lo1IOFz8xElOeao3qbY=;
 b=AIbgWHy3IAB0XEr08b0giBRj0cjUE63ULoiJBNEOkbEtWxdjeQa+lLULpgIuVHkGYIRZFiFIiM0s2e/FbAcjFE5CWoz27zHestwuB7Sxs0R1nYtpavwu1uQTbeGs8rOVqsdMyCwFDFFzAeGGnb9g5yz/pT1N47GIvtcg8AITF5Fb1U71+HtU0ssssVN8pJPMVtzRSrMekpYYldOeg+xswTXmShy8kIPlDzf4KorJY6xXMQ9B0hQcto8C9YfEAMlnSJshcMUH4KHACjQXg8GaKxC+6B4gzwq6x68RLIxiB6SC2EbTL3KAcaBsafuYYu3VNwL4xppzyB24Kqt18l/arg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=ti.com smtp.mailfrom=phytec.de; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine header.from=phytec.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjfLd1KwWR3eJHSXHXjdsR07lo1IOFz8xElOeao3qbY=;
 b=OXxAlb89AqIhtw5SUjF7+tl56JQbZEtk1sSUUG2Z36DpszniXUUsTiOkUxA16bT0U4MquK5C7SfacMCwq3+Js1lhL5ckMks276G7ol6sz0WVhOE+/v8hASRGd1TU5L5Kiy1GhwAxgp+fiS4ErzadhtcFsrvPvuENmSiy5L8iLP87bqNR/bQFejrBFlhQkOJnaNPWTRZV8v9N7rZqPbGuL0FCa8mfWEtTxqaTTZYYL4iagiI0pNjbN66+xYa8WeU3jgCfdihu3XNmXdvpBcb6aSJcWiRSHvQX4Qw1dXJuKM1/TKDgASPKZeZ5ac/1kEg0fGyzS6RKOqSRHC1idC401A==
Received: from AM0PR01CA0145.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::14) by DU7PPF2CD800A78.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:18:3::bcd) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Thu, 25 Sep
 2025 10:00:47 +0000
Received: from AMS0EPF000001B3.eurprd05.prod.outlook.com
 (2603:10a6:208:aa:cafe::8a) by AM0PR01CA0145.outlook.office365.com
 (2603:10a6:208:aa::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.22 via Frontend Transport; Thu,
 25 Sep 2025 10:00:45 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AMS0EPF000001B3.mail.protection.outlook.com (10.167.16.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 10:00:47 +0000
Received: from phytec.de (172.25.0.51) by Postix.phytec.de (172.25.0.11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 12:00:45 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <aradhya.bhatia@linux.dev>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
Subject: [PATCH v2 3/3] arm64: dts: ti: am625-phyboard-lyra: Add Lincoln LCD185-101CT panel overlay
Date: Thu, 25 Sep 2025 12:00:38 +0200
Message-ID: <20250925100038.3008298-3-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250925100038.3008298-1-w.egorov@phytec.de>
References: <20250925100038.3008298-1-w.egorov@phytec.de>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B3:EE_|DU7PPF2CD800A78:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f57bd38-7300-48d2-00f8-08ddfc1a66a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1woEwnL+Sw4D6jMEOqphiIX8AxwK2RkdoFWgYq2K06HrNInVFSJnjNXj9/z3?=
 =?us-ascii?Q?hE1ced+U8z+m6CxJ4s8GBGlUlbsoSBQNNvxoHs2qaGFXoLyYJuiGXF6fs3v8?=
 =?us-ascii?Q?VWvuaCpjtHVmwK+XdLx8FfZe/qGjErEbVlxaDztU9BCu6i7VMlMRs++e7WAb?=
 =?us-ascii?Q?jrtHCzNaRQIKkNFkt6fh0rkPUOHDkOmKUDQlp7N5ruBEKeE0xze7Jo/IFvR+?=
 =?us-ascii?Q?ZbAS8Ts3qDVpx7xem66JoMYmGUrK+2mU8Kr2YHSC6M6ks7UUdN2kE7F/8bG/?=
 =?us-ascii?Q?3UIJxehN7yyMzTm52z1uVMd2xwv2/97x/ZyQTLkJIrzfDtKos757ZlISyu7G?=
 =?us-ascii?Q?jWKkkstaBYAncEQdWek4jynvU/0neSziesYhecmqvYfAbPtgmCtC807e7P82?=
 =?us-ascii?Q?TbDGA7Iald2WOttqOg2HcY1RwZM+dr6laUJoO/2hVr9VopfpUkPyc9VUi2DK?=
 =?us-ascii?Q?6VIuDIFg4zYbsrhZY1Gl6SLRD173pXCa/b+gOIjbBmX8N1IOnVit0y5J8xym?=
 =?us-ascii?Q?mMih5m+ArIVovniRMelSzaLUmaH5aU1OyxAsqWzuxExK+PGmlLM/8gOCwF06?=
 =?us-ascii?Q?9WKeLQbNf+X1FD3VgSU7DkWVhqP9ZEv1rUqWKsUQfotbHoAVvOu0WVYg4MRk?=
 =?us-ascii?Q?jSWSYud//ksl7xMOQqN5ZlqET1IEInaI50ER/mVR60FbbhZTL89bZLeBZOZ3?=
 =?us-ascii?Q?dvjgXa2C2ATEg6DAOTSqHEJKkgWfS3oi/eaHOWF2ZdYrFWgpMQ7fsxKKhvP2?=
 =?us-ascii?Q?BjoV8j8YQoVWCJVh1yGUaPOhf40aag48viznBXLYwfDBuFUAacVViRRJIfZi?=
 =?us-ascii?Q?D9yJqHVUan2gKARaukaBd7DxF2Lg1Vc8g8HBT/0D54W7WCVF/uJ78ny89Zfd?=
 =?us-ascii?Q?YAWB2bb01O3odk9+NUL4x1XwaBr9KkLB60Ct49RcUPG/tQM82Gv1zOQnO0hC?=
 =?us-ascii?Q?YbMeg8beNPxJZBJjgZ/G6MCqFuWNmfn3yfWgpKMa4gFuoj1nd1DdO1MSTEyn?=
 =?us-ascii?Q?ziwef+Ooc5ph/Qw39W0sqQDmbUWqklFDtlnLkoIk4DzmkLUngQ2ARD1V0nEd?=
 =?us-ascii?Q?8B2XqEOfEvnYMc7tUyCXdzRYl3w2OVIUD2/eucmcCA6kTV7htHL8fXLctmuf?=
 =?us-ascii?Q?69LLd3IwbcSeBV3omt2RSZagXaMY7Q4+e+lFVK3K0tiIyHged2Wj9l3VXKTx?=
 =?us-ascii?Q?TkRLRj/M/OWFZl1sjaPDLfJtlHhKiIl8KUzbfgzhd2AhbdogfgntSvI4SNpa?=
 =?us-ascii?Q?iIV2zuiOOvImw57yLC/YNvinUsCMwvinbGj1H2e9nj+RcLxwVLd7gFZQssN4?=
 =?us-ascii?Q?bvY19ELQyjVCaKhT4M8AAYcYjqIdNEiK0kWtptnYruNambz0Mx2BJobtQDft?=
 =?us-ascii?Q?uhT5cI0B+1nlhG7zhqRJyfol+HOrI+n82DFLC2n69BvZZUl4pvRdZP4QkAOw?=
 =?us-ascii?Q?i685EDa0qvU6uQyzhGTVA9X0PS7ZXLY5/njeBNFnQN5F5bkaPIm/ng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Postix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 10:00:47.7153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f57bd38-7300-48d2-00f8-08ddfc1a66a0
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PPF2CD800A78

The panel is a Lincoln Technology Solutions LCD185-101CT [0]. It is
a dual-link LVDS panel and supports WUXGA resolution (1920x1200).
Furthermore, it has an I2C based touch controller: Goodix-GT928.

Add an device tree overlay to support the Lincoln LCD185-101CT panel
in combination with the phyBOARD-Lyra-AM62x.

[0] https://lincolntechsolutions.com/wp-content/uploads/2024/09/LCD185-101CTL1ARNTT_DS_R1.3.pdf

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
v1: https://lists.infradead.org/pipermail/linux-arm-kernel/2025-September/1065767.html
v2: Use port dummies defined in previous patch
---
 arch/arm64/boot/dts/ti/Makefile               |   3 +
 .../k3-am625-phyboard-lyra-oldi-lcd185.dtso   | 188 ++++++++++++++++++
 2 files changed, 191 insertions(+)
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
index 000000000000..b1feb665248b
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-oldi-lcd185.dtso
@@ -0,0 +1,188 @@
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
+&oldi0_port0 {
+	oldi_0_in: endpoint {
+		remote-endpoint = <&dpi0_out0>;
+	};
+};
+
+&oldi0_port1 {
+	oldi_0_out: endpoint {
+		remote-endpoint = <&lcd_in0>;
+	};
+};
+
+&oldi1 {
+	ti,secondary-oldi;
+	status = "okay";
+};
+
+&oldi1_port0 {
+	oldi_1_in: endpoint {
+		remote-endpoint = <&dpi0_out1>;
+	};
+};
+
+&oldi1_port1 {
+	oldi_1_out: endpoint {
+		remote-endpoint = <&lcd_in1>;
+	};
+};
-- 
2.48.1



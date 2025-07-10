Return-Path: <linux-kernel+bounces-724662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9D3AFF590
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12351894C02
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B3528F1;
	Thu, 10 Jul 2025 00:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rF5a7frG"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0F8A29;
	Thu, 10 Jul 2025 00:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752106150; cv=none; b=Xtf8BCpb4ZnR9Da99qNGfI7LLc6rDuxkt+6DFjOciIPvQYY62YpxZFZvZFP1n0DmwUPOWK2J6gG/ra8oi26SLuL+lsXySK7kdp7X9hqWSe51b4UXlDCPScNxpHxs51WHRaFU2sVgfTYCqrJr9Wf2J2LTBicH9zwziIocnS5rY2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752106150; c=relaxed/simple;
	bh=ZRa1TuL6z0JIeZdAZJweiG9RqGgswS3wpSGcj1p4BoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=OxC7ru37LP358+uQ5p1nymt/XO2U5012KT1dq5seIjiMhXBFDnRKVx5q4deVPnWa6vMI2QRZf00rz0V22fE59V+Blekb0jQP9XNB7DwT65IVgUOVxgG0Za561b5NJqspM29xLEZtRClHesLkdRxUkfU9E3OcKQWD5P2I0sRFLQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rF5a7frG; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56A091Ex965455;
	Wed, 9 Jul 2025 19:09:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752106141;
	bh=E23B2sZy7p9/MMQMvZrIGEuUqSiJtl0btky7YYvriJA=;
	h=From:Date:Subject:To:CC;
	b=rF5a7frGeiE2KOz7GgL9/64LPGFi6uZSThdGatvQ0ERP1VKJGss7buB3QQ+tGSvJW
	 U338Tpfkvvz9vQWzXgBWb5W5ge4FPXg0oX0TnilRn0i0G3ocGKrvzmBVBVI4aoxApp
	 0GiCewO/jWH7UUdZ59RHdh/DWXmmrn9BIlMbXlVM=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56A091Ma2476618
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 9 Jul 2025 19:09:01 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 9
 Jul 2025 19:09:01 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 9 Jul 2025 19:09:00 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56A090qx338248;
	Wed, 9 Jul 2025 19:09:00 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Wed, 9 Jul 2025 19:08:56 -0500
Subject: [PATCH] arm64: dts: ti: k3-am62a7-sk: add boot phase tags
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250709-62a-uboot-cleanup-v1-1-70f8e6cde719@ti.com>
X-B4-Tracking: v=1; b=H4sIAJcEb2gC/x3MQQqAIBBA0avErBuwCaW6SrSwGmsgNLQiiO6et
 HyL/x9IHIUTdMUDkS9JEnxGVRYwrdYvjDJnAynSylCNhiyeYwgHThtbf+44NopNq8m11Qy52yM
 7uf9nP7zvB7Q/oUJjAAAA
X-Change-ID: 20250623-62a-uboot-cleanup-b80e6952f91d
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.14.2
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The 'bootph-all' tag was added to the dt-schema to describe the various
nodes used during the different phases of bootup with DT. Add the
bootph-all tag to all nodes that are used during the early stages of
bootup by the bootloaders.

This includes the console UART along with the SD and eMMC nodes and its
required regulators for the 3v3 to 1v8 transition and the various nodes
for Ethernet booting.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index f11284b3fe8e23b4c48d8d2f3a7202e80dc57370..bb565c52dc2c6365aac1e3a62461de4aef79c51b 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -36,6 +36,7 @@ memory@80000000 {
 		/* 4G RAM */
 		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
 		      <0x00000008 0x80000000 0x00000000 0x80000000>;
+		bootph-all;
 	};
 
 	reserved-memory {
@@ -151,6 +152,7 @@ vdd_mmc1: regulator-3 {
 		regulator-boot-on;
 		enable-active-high;
 		gpio = <&exp1 3 GPIO_ACTIVE_HIGH>;
+		bootph-all;
 	};
 
 	vcc_3v3_sys: regulator-4 {
@@ -297,6 +299,7 @@ main_uart0_pins_default: main-uart0-default-pins {
 			AM62AX_IOPAD(0x1c8, PIN_INPUT, 0) /* (E14) UART0_RXD */
 			AM62AX_IOPAD(0x1cc, PIN_OUTPUT, 0) /* (D15) UART0_TXD */
 		>;
+		bootph-all;
 	};
 
 	main_uart1_pins_default: main-uart1-default-pins {
@@ -320,6 +323,7 @@ main_i2c1_pins_default: main-i2c1-default-pins {
 			AM62AX_IOPAD(0x1e8, PIN_INPUT_PULLUP, 0) /* (B17) I2C1_SCL */
 			AM62AX_IOPAD(0x1ec, PIN_INPUT_PULLUP, 0) /* (A17) I2C1_SDA */
 		>;
+		bootph-all;
 	};
 
 	main_i2c2_pins_default: main-i2c2-default-pins {
@@ -356,6 +360,7 @@ AM62AX_IOPAD(0x228, PIN_INPUT, 0) /* (C21) MMC1_DAT2 */
 			AM62AX_IOPAD(0x224, PIN_INPUT, 0) /* (D22) MMC1_DAT3 */
 			AM62AX_IOPAD(0x240, PIN_INPUT, 0) /* (D17) MMC1_SDCD */
 		>;
+		bootph-all;
 	};
 
 	usr_led_pins_default: usr-led-default-pins {
@@ -375,6 +380,7 @@ main_mdio1_pins_default: main-mdio1-default-pins {
 			AM62AX_IOPAD(0x160, PIN_OUTPUT, 0) /* (V12) MDIO0_MDC */
 			AM62AX_IOPAD(0x15c, PIN_INPUT, 0) /* (V13) MDIO0_MDIO */
 		>;
+		bootph-all;
 	};
 
 	main_rgmii1_pins_default: main-rgmii1-default-pins {
@@ -392,6 +398,7 @@ AM62AX_IOPAD(0x140, PIN_INPUT, 0) /* (AA17) RGMII1_TD3 */
 			AM62AX_IOPAD(0x130, PIN_INPUT, 0) /* (AB17) RGMII1_TXC */
 			AM62AX_IOPAD(0x12c, PIN_INPUT, 0) /* (W16) RGMII1_TX_CTL */
 		>;
+		bootph-all;
 	};
 
 	main_mcasp1_pins_default: main-mcasp1-default-pins {
@@ -572,6 +579,7 @@ exp1: gpio@22 {
 		#interrupt-cells = <2>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&main_gpio1_ioexp_intr_pins_default>;
+		bootph-all;
 
 		gpio-line-names = "GPIO_CPSW2_RST", "GPIO_CPSW1_RST",
 				   "BT_EN_SOC", "MMC1_SD_EN",
@@ -675,10 +683,12 @@ &sdhci1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc1_pins_default>;
 	disable-wp;
+	bootph-all;
 };
 
 &main_gpio0 {
 	status = "okay";
+	bootph-all;
 };
 
 &main_gpio1 {
@@ -693,6 +703,7 @@ &main_uart0 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart0_pins_default>;
+	bootph-all;
 };
 
 /* Main UART1 is used for TIFS firmware logs */
@@ -737,12 +748,21 @@ &cpsw3g {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_rgmii1_pins_default>;
+
+	ethernet-ports {
+		bootph-all;
+	};
+};
+
+&phy_gmii_sel {
+	bootph-all;
 };
 
 &cpsw_port1 {
 	status = "okay";
 	phy-mode = "rgmii-rxid";
 	phy-handle = <&cpsw3g_phy0>;
+	bootph-all;
 };
 
 &cpsw_port2 {
@@ -759,6 +779,7 @@ cpsw3g_phy0: ethernet-phy@0 {
 		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
 		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
 		ti,min-output-impedance;
+		bootph-all;
 	};
 };
 

---
base-commit: 3b08f8a34a2061d89a2411d04a675b3860d4f9cc
change-id: 20250623-62a-uboot-cleanup-b80e6952f91d

Best regards,
-- 
Bryan Brattlof <bb@ti.com>



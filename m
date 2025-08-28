Return-Path: <linux-kernel+bounces-789658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC9EB398BD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C5E98794A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296D62EDD61;
	Thu, 28 Aug 2025 09:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="JxAnN/Ug";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="aI5b7UF5"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CDB2ED141;
	Thu, 28 Aug 2025 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756374496; cv=none; b=ckUeYuLD4YkuOyRdtbgmyXONVjmxRuS71ohBJp8WCxdFYsr0wMCSalLph3q+K3DIEhmP8FTs6iLNHkUdblO81xExgxRMd2gG3oGVHamNpyI1yqAwweZ4gHGCJpdACpgIyZm6r9pe04xp1aWuWGHuUzyuCQvJ5nOjfgJtYbUz/D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756374496; c=relaxed/simple;
	bh=oVBUOCGr+bHCyijZa+e0f0XTQKCdnt1Iuc1oBqQY57c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SEvupBNU90wRUHInFox5+MjsV5SbQfb7sEnQvDxyT0FWbC7ERPedcf2ei62X2imYoR07yAx2v6h6tGUlHE7dc9raLPgdM0gCw/13wPEBWBlRLVLkaqbfzmF1ZkOol8nX5lcWBJuBYKAxeIwiMvuzDp63C3hCYO+WcWTFim2vXSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=JxAnN/Ug; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=aI5b7UF5 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1756374493; x=1787910493;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=20f8TN6rUSbNfHjL+x4oeeyMAXKfnv1ChSbem98tBJg=;
  b=JxAnN/UgXb7c3V/DAyiuaX2auolMShCduQpQPmXh9PZdCwt0pqIXB3A4
   WqaTNMKOZpIu/cykY2svqzn/9zgWLqbESsHHNO4DhgEnb6hd+FTE9TnKq
   5ZwQ0JEa0Yj6Ao3tyKCyMi5pWHL/qLXXzqXiC9KU1geNtHKzIdXZLvreD
   IGKOWD9oaBeVHH4fUtZpfiBKva3r5PcULW906w7vdXnaav+f6SeOwnaKV
   B3HHKLv2YbpcN2pNnbl4pMzvYlZpTWZIig1QmgbcVvS4vsETtwa+cI+uM
   geep/n8sEzPLKG+uCqtOioqpu7FzJ3xY3hxa/UfzDPq4jjmllt41pR09N
   Q==;
X-CSE-ConnectionGUID: jL3W3PCdSxC2FnwgQuHGMg==
X-CSE-MsgGUID: SccCeNYlQR+OyX13EDjsQQ==
X-IronPort-AV: E=Sophos;i="6.18,217,1751234400"; 
   d="scan'208";a="45953048"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 28 Aug 2025 11:48:04 +0200
X-CheckPoint: {68B025D4-2C-AD8F5F64-F0EACAA5}
X-MAIL-CPID: DCBA5596B410D01D65AC702F1E9888EB_1
X-Control-Analysis: str=0001.0A00210B.68B026F8.0046,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F24C2169476;
	Thu, 28 Aug 2025 11:47:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1756374480; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=20f8TN6rUSbNfHjL+x4oeeyMAXKfnv1ChSbem98tBJg=;
	b=aI5b7UF55dyUNNUT7XyHG0rLlMLaINyc9Gbt/Ec5d4w5HQ/4tfmj+jkYsMfFwVP38D+UWX
	CyDZ9F+xzp/G/7ZhYPyB5VUHCgrRD0ShIUjV7c5fTL0qBn4YooRU+QShijyaEIEtqXsY6S
	C1IJdAOhuLqsLz5SAVy69xEofloHX+2Iw2O0wTFiwphWj1dgMNRVZJoZMLj7N1dTraVLzl
	ORNe4sMMO7WXnTUP039ANZfCnsYOzC6U5sKtFDGB/9Bh2Yq3/LPxXHHJ3ueAijJtePQ8IJ
	QEA0TcRkiEwznE9lFMS2w4pXbL/MVULODDPk2FsbcRI25O7MGqTlwY/88cjEqw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com
Subject: [PATCH 2/2] arm64: dts: freescale: add initial device tree for TQMa91xxCA/MBa91xxCA
Date: Thu, 28 Aug 2025 11:47:43 +0200
Message-ID: <20250828094745.3733533-3-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828094745.3733533-1-alexander.stein@ew.tq-group.com>
References: <20250828094745.3733533-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This adds support for TQMa91xxCA module attached to MBa91xxCA board.
TQMa91xx is a SOM using i.MX91 SOC. The SOM features PMIC, RAM, e-MMC and
some optional peripherals like SPI-NOR, RTC, EEPROM, gyroscope and
secure element.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../freescale/imx91-tqma9131-mba91xxca.dts    | 737 ++++++++++++++++++
 .../boot/dts/freescale/imx91-tqma9131.dtsi    | 295 +++++++
 3 files changed, 1033 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx91-tqma9131-mba91xxca.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx91-tqma9131.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 947de7f125caf..3a937232d6f29 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -338,6 +338,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-tqma8xqps-mb-smarc-2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8ulp-9x9-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx91-11x11-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx91-tqma9131-mba91xxca.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-9x9-qsb.dtb
 
 imx93-9x9-qsb-i3c-dtbs += imx93-9x9-qsb.dtb imx93-9x9-qsb-i3c.dtbo
diff --git a/arch/arm64/boot/dts/freescale/imx91-tqma9131-mba91xxca.dts b/arch/arm64/boot/dts/freescale/imx91-tqma9131-mba91xxca.dts
new file mode 100644
index 0000000000000..354cebf4a7c9e
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx91-tqma9131-mba91xxca.dts
@@ -0,0 +1,737 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (c) 2022-2025 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
+ * Author: Alexander Stein
+ */
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/net/ti-dp83867.h>
+#include <dt-bindings/pwm/pwm.h>
+#include <dt-bindings/usb/pd.h>
+#include "imx91-tqma9131.dtsi"
+
+/{
+	model = "TQ-Systems i.MX91 TQMa91xxLA/TQMa91xxCA on MBa91xxCA starter kit";
+	compatible = "tq,imx91-tqma9131-mba91xxca", "tq,imx91-tqma9131", "fsl,imx91";
+	chassis-type = "embedded";
+
+	chosen {
+		stdout-path = &lpuart1;
+	};
+
+	aliases {
+		eeprom0 = &eeprom0;
+		ethernet0 = &eqos;
+		ethernet1 = &fec;
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		gpio3 = &gpio4;
+		i2c0 = &lpi2c1;
+		i2c1 = &lpi2c2;
+		i2c2 = &lpi2c3;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
+		rtc0 = &pcf85063;
+		rtc1 = &bbnsm_rtc;
+		serial0 = &lpuart1;
+		serial1 = &lpuart2;
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&tpm2 2 5000000 0>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <7>;
+		power-supply = <&reg_12v0>;
+		enable-gpios = <&expander2 2 GPIO_ACTIVE_HIGH>;
+		status = "disabled";
+	};
+
+	display: display {
+		/*
+		 * Display is not fixed, so compatible has to be added from
+		 * DT overlay
+		 */
+		power-supply = <&reg_3v3>;
+		enable-gpios = <&expander2 1 GPIO_ACTIVE_HIGH>;
+		backlight = <&backlight>;
+		status = "disabled";
+
+		port {
+			panel_in: endpoint {
+			};
+		};
+	};
+
+	fan0: gpio-fan {
+		compatible = "gpio-fan";
+		gpios = <&expander2 4 GPIO_ACTIVE_HIGH>;
+		gpio-fan,speed-map = <0 0>, <10000 1>;
+		fan-supply = <&reg_12v0>;
+		#cooling-cells = <2>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		autorepeat;
+
+		switch-a {
+			label = "switcha";
+			linux,code = <BTN_0>;
+			gpios = <&expander0 6 GPIO_ACTIVE_LOW>;
+			wakeup-source;
+		};
+
+		switch-b {
+			label = "switchb";
+			linux,code = <BTN_1>;
+			gpios = <&expander0 7 GPIO_ACTIVE_LOW>;
+			wakeup-source;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		led-1 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&expander2 6 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-on";
+		};
+
+		led-2 {
+			color = <LED_COLOR_ID_AMBER>;
+			function = LED_FUNCTION_HEARTBEAT;
+			gpios = <&expander2 7 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc1 0>, <&adc1 1>, <&adc1 2>, <&adc1 3>;
+	};
+
+	lvds_encoder: lvds-encoder {
+		compatible = "ti,sn75lvds83", "lvds-encoder";
+		powerdown-gpios = <&expander2 3 GPIO_ACTIVE_LOW>;
+		power-supply = <&reg_3v3>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				lvds_encoder_input: endpoint {
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				lvds_encoder_output: endpoint {
+				};
+			};
+		};
+	};
+
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "V_3V3_MB";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	reg_5v0: regulator-5v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "V_5V0_MB";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	reg_12v0: regulator-12v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "V_12V";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		gpio = <&expander1 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_mpcie_1v5: regulator-mpcie-1v5 {
+		compatible = "regulator-fixed";
+		regulator-name = "V_1V5_MPCIE";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+		gpio = <&expander0 2 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	reg_mpcie_3v3: regulator-mpcie-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "V_3V3_MPCIE";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&expander0 3 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+};
+
+&adc1 {
+	status = "okay";
+};
+
+&eqos {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_eqos>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy_eqos>;
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy_eqos: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_eqos_phy>;
+			reset-gpios = <&expander1 0 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <500000>;
+			reset-deassert-us = <50000>;
+			interrupt-parent = <&gpio3>;
+			interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
+			enet-phy-lane-no-swap;
+			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
+			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
+			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+			ti,dp83867-rxctrl-strap-quirk;
+			ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
+		};
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy_fec>;
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-frequency = <5000000>;
+
+		ethphy_fec: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_fec_phy>;
+			reset-gpios = <&expander1 1 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <500000>;
+			reset-deassert-us = <50000>;
+			interrupt-parent = <&gpio3>;
+			interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+			enet-phy-lane-no-swap;
+			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
+			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
+			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+			ti,dp83867-rxctrl-strap-quirk;
+			ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
+		};
+	};
+};
+
+&flexcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	xceiver-supply = <&reg_3v3>;
+	status = "okay";
+};
+
+&gpio1 {
+	gpio-line-names =
+		/* 00 */ "", "", "", "PMIC_IRQ#",
+		/* 04 */ "", "", "", "",
+		/* 08 */ "", "", "USB_C_ALERT#", "BM2_LCD_INT#",
+		/* 12 */ "PEX_INT#", "", "RTC_EVENT#", "",
+		/* 16 */ "", "", "", "",
+		/* 20 */ "", "", "", "",
+		/* 24 */ "", "", "", "",
+		/* 28 */ "", "", "", "";
+};
+
+&gpio2 {
+	gpio-line-names =
+		/* 00 */ "", "", "", "",
+		/* 04 */ "", "", "", "",
+		/* 08 */ "", "", "", "",
+		/* 12 */ "", "", "", "",
+		/* 16 */ "", "", "", "",
+		/* 20 */ "", "", "", "",
+		/* 24 */ "", "", "", "",
+		/* 28 */ "", "", "", "";
+};
+
+&gpio3 {
+	gpio-line-names =
+		/* 00 */ "SD2_CD#", "", "", "",
+		/* 04 */ "", "", "", "SD2_RST#",
+		/* 08 */ "", "", "", "",
+		/* 12 */ "", "", "", "",
+		/* 16 */ "", "", "", "",
+		/* 20 */ "", "", "", "",
+		/* 24 */ "", "", "ENET1_INT#", "ENET2_INT#",
+		/* 28 */ "", "", "", "";
+};
+
+&gpio4 {
+	gpio-line-names =
+		/* 00 */ "", "", "", "",
+		/* 04 */ "", "", "", "",
+		/* 08 */ "", "", "", "",
+		/* 12 */ "", "", "", "",
+		/* 16 */ "", "", "", "",
+		/* 20 */ "", "", "", "",
+		/* 24 */ "", "", "", "",
+		/* 28 */ "", "", "", "";
+};
+
+&lpi2c3 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_lpi2c3>;
+	pinctrl-1 = <&pinctrl_lpi2c3>;
+	status = "okay";
+
+	temperature-sensor@1c {
+		compatible = "nxp,se97b", "jedec,jc-42.4-temp";
+		reg = <0x1c>;
+	};
+
+	ptn5110: usb-typec@50 {
+		compatible = "nxp,ptn5110", "tcpci";
+		reg = <0x50>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_typec>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <10 IRQ_TYPE_EDGE_FALLING>;
+
+		connector {
+			compatible = "usb-c-connector";
+			label = "X17";
+			power-role = "dual";
+			data-role = "dual";
+			try-power-role = "sink";
+			typec-power-opmode = "default";
+			pd-disable;
+			self-powered;
+
+			port {
+				typec_con_hs: endpoint {
+					remote-endpoint = <&typec_hs>;
+				};
+			};
+		};
+	};
+
+	eeprom2: eeprom@54 {
+		compatible = "nxp,se97b", "atmel,24c02";
+		reg = <0x54>;
+		pagesize = <16>;
+		vcc-supply = <&reg_3v3>;
+	};
+
+	expander0: gpio@70 {
+		compatible = "nxp,pca9538";
+		reg = <0x70>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pexp_irq>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
+		vcc-supply = <&reg_3v3>;
+		gpio-line-names = "TEMP_EVENT_MOD#", "MPCIE_WAKE#",
+				  "MPCIE_1V5_EN", "MPCIE_3V3_EN",
+				  "MPCIE_PERST#", "MPCIE_WDISABLE#",
+				  "BUTTON_A#", "BUTTON_B#";
+
+		temp-event-mod-hog {
+			gpio-hog;
+			gpios = <0 GPIO_ACTIVE_LOW>;
+			input;
+			line-name = "TEMP_EVENT_MOD#";
+		};
+
+		mpcie-wake-hog {
+			gpio-hog;
+			gpios = <1 GPIO_ACTIVE_LOW>;
+			input;
+			line-name = "MPCIE_WAKE#";
+		};
+
+		/*
+		 * Controls the mPCIE slot reset which is low active as
+		 * reset signal. The output-low states, the signal is
+		 * inactive, e.g. not in reset
+		 */
+		mpcie_rst_hog: mpcie-rst-hog {
+			gpio-hog;
+			gpios = <4 GPIO_ACTIVE_LOW>;
+			output-low;
+			line-name = "MPCIE_PERST#";
+		};
+
+		/*
+		 * Controls the mPCIE slot WDISABLE pin which is low active
+		 * as disable signal. The output-low states, the signal is
+		 * inactive, e.g. not disabled
+		 */
+		mpcie_wdisable_hog: mpcie-wdisable-hog {
+			gpio-hog;
+			gpios = <5 GPIO_ACTIVE_LOW>;
+			output-low;
+			line-name = "MPCIE_WDISABLE#";
+		};
+	};
+
+	expander1: gpio@71 {
+		compatible = "nxp,pca9538";
+		reg = <0x71>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		vcc-supply = <&reg_3v3>;
+		gpio-line-names = "ENET1_RESET#", "ENET2_RESET#",
+				  "USB_RESET#", "",
+				  "WLAN_PD#", "WLAN_W_DISABLE#",
+				  "WLAN_PERST#", "12V_EN";
+
+		/*
+		 * Controls the WiFi card PD pin which is low active
+		 * as power down signal. The output-low states, the signal
+		 * is inactive, e.g. not power down
+		 */
+		wlan-pd-hog {
+			gpio-hog;
+			gpios = <4 GPIO_ACTIVE_LOW>;
+			output-low;
+			line-name = "WLAN_PD#";
+		};
+
+		/*
+		 * Controls the WiFi card disable pin which is low active
+		 * as disable signal. The output-low states, the signal
+		 * is inactive, e.g. not disabled
+		 */
+		wlan-wdisable-hog {
+			gpio-hog;
+			gpios = <5 GPIO_ACTIVE_LOW>;
+			output-low;
+			line-name = "WLAN_W_DISABLE#";
+		};
+
+		/*
+		 * Controls the WiFi card reset pin which is low active
+		 * as reset signal. The output-low states, the signal
+		 * is inactive, e.g. not in reset
+		 */
+		wlan-perst-hog {
+			gpio-hog;
+			gpios = <6 GPIO_ACTIVE_LOW>;
+			output-low;
+			line-name = "WLAN_PERST#";
+		};
+	};
+
+	expander2: gpio@72 {
+		compatible = "nxp,pca9538";
+		reg = <0x72>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		vcc-supply = <&reg_3v3>;
+		gpio-line-names = "LCD_RESET#", "LCD_PWR_EN",
+				  "LCD_BLT_EN", "LVDS_SHDN#",
+				  "FAN_PWR_EN", "",
+				  "USER_LED1", "USER_LED2";
+	};
+};
+
+&lpuart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&lpuart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	linux,rs485-enabled-at-boot-time;
+	status = "okay";
+};
+
+&pcf85063 {
+	/* RTC_EVENT# from SoM is connected on mainboard */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcf85063>;
+	interrupt-parent = <&gpio1>;
+	interrupts = <14 IRQ_TYPE_EDGE_FALLING>;
+};
+
+&se97_som {
+	/* TEMP_EVENT# from SoM is connected on mainboard */
+	interrupt-parent = <&expander0>;
+	interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+};
+
+&tpm2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_tpm2>;
+	status = "okay";
+};
+
+&usbotg1 {
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	usb-role-switch;
+	disable-over-current;
+	status = "okay";
+
+	port {
+		typec_hs: endpoint {
+			remote-endpoint = <&typec_con_hs>;
+		};
+	};
+};
+
+&usbotg2 {
+	dr_mode = "host";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	disable-over-current;
+	status = "okay";
+
+	hub_2_0: hub@1 {
+		compatible = "usb424,2517";
+		reg = <1>;
+		reset-gpios = <&expander1 2 GPIO_ACTIVE_LOW>;
+		vdd-supply = <&reg_3v3>;
+	};
+};
+
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2_hs>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_uhs>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_uhs>, <&pinctrl_usdhc2_gpio>;
+	cd-gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	bus-width = <4>;
+	no-sdio;
+	no-mmc;
+	disable-wp;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_eqos: eqosgrp {
+		fsl,pins = /* PD | FSEL_2 | DSE X4 */
+			   <MX91_PAD_ENET1_MDC__ENET1_MDC				0x51e>,
+			   /* SION | HYS | FSEL_2 | DSE X4 */
+			   <MX91_PAD_ENET1_MDIO__ENET_QOS_MDIO				0x4000111e>,
+			   /* HYS | FSEL_0 | DSE no drive */
+			   <MX91_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0			0x1000>,
+			   <MX91_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1			0x1000>,
+			   <MX91_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2			0x1000>,
+			   <MX91_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3			0x1000>,
+			   <MX91_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL		0x1000>,
+			   /* HYS | PD | FSEL_0 | DSE no drive */
+			   <MX91_PAD_ENET1_RXC__ENET_QOS_RGMII_RXC			0x1400>,
+			   /* PD | FSEL_2 | DSE X4 */
+			   <MX91_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0			0x51e>,
+			   <MX91_PAD_ENET1_TD1__ENET1_RGMII_TD1				0x51e>,
+			   <MX91_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2			0x51e>,
+			   <MX91_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3			0x51e>,
+			   <MX91_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL		0x51e>,
+			   /* PD | FSEL_3 | DSE X3 */
+			   <MX91_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x58e>;
+	};
+
+	pinctrl_eqos_phy: eqosphygrp {
+		fsl,pins = /* HYS | FSEL_0 | DSE no drive */
+			   <MX91_PAD_CCM_CLKO1__GPIO3_IO26		0x1000>;
+	};
+
+	pinctrl_fec: fecgrp {
+		fsl,pins = /* PD | FSEL_2 | DSE X4 */
+			   <MX91_PAD_ENET2_MDC__ENET2_MDC		0x51e>,
+			   /* SION | HYS | FSEL_2 | DSE X4 */
+			   <MX91_PAD_ENET2_MDIO__ENET2_MDIO		0x4000111e>,
+			   /* HYS | FSEL_0 | DSE no drive */
+			   <MX91_PAD_ENET2_RD0__ENET2_RGMII_RD0		0x1000>,
+			   <MX91_PAD_ENET2_RD1__ENET2_RGMII_RD1		0x1000>,
+			   <MX91_PAD_ENET2_RD2__ENET2_RGMII_RD2		0x1000>,
+			   <MX91_PAD_ENET2_RD3__ENET2_RGMII_RD3		0x1000>,
+			   <MX91_PAD_ENET2_RX_CTL__ENET2_RGMII_RX_CTL	0x1000>,
+			   /* HYS | PD | FSEL_0 | DSE no drive */
+			   <MX91_PAD_ENET2_RXC__ENET2_RGMII_RXC		0x1400>,
+			   /* PD | FSEL_2 | DSE X4 */
+			   <MX91_PAD_ENET2_TD0__ENET2_RGMII_TD0		0x51e>,
+			   <MX91_PAD_ENET2_TD1__ENET2_RGMII_TD1		0x51e>,
+			   <MX91_PAD_ENET2_TD2__ENET2_RGMII_TD2		0x51e>,
+			   <MX91_PAD_ENET2_TD3__ENET2_RGMII_TD3		0x51e>,
+			   <MX91_PAD_ENET2_TX_CTL__ENET2_RGMII_TX_CTL	0x51e>,
+			   /* PD | FSEL_3 | DSE X3 */
+			   <MX91_PAD_ENET2_TXC__ENET2_RGMII_TXC		0x58e>;
+	};
+
+	pinctrl_fec_phy: fecphygrp {
+		fsl,pins = /* HYS | FSEL_0 | DSE no drive */
+			   <MX91_PAD_CCM_CLKO2__GPIO3_IO27		0x1000>;
+	};
+
+	pinctrl_flexcan1: flexcan1grp {
+		fsl,pins = /* HYS | PU | FSEL_0 | DSE no drive */
+			   <MX91_PAD_PDM_BIT_STREAM0__CAN1_RX		0x1200>,
+			   /* PU | FSEL_3 | DSE X4 */
+			   <MX91_PAD_PDM_CLK__CAN1_TX			0x039e>;
+	};
+
+	pinctrl_jtag: jtaggrp {
+		fsl,pins = <MX91_PAD_DAP_TCLK_SWCLK__JTAG_MUX_TCK	0x051e>,
+			   <MX91_PAD_DAP_TDI__JTAG_MUX_TDI		0x1200>,
+			   <MX91_PAD_DAP_TDO_TRACESWO__JTAG_MUX_TDO	0x031e>,
+			   <MX91_PAD_DAP_TMS_SWDIO__JTAG_MUX_TMS	0x1200>;
+	};
+
+	pinctrl_lpi2c3: lpi2c3grp {
+		fsl,pins = /* SION | HYS | OD | FSEL_3 | DSE X4 */
+			   <MX91_PAD_GPIO_IO28__LPI2C3_SDA		0x4000199e>,
+			   <MX91_PAD_GPIO_IO29__LPI2C3_SCL		0x4000199e>;
+	};
+
+	pinctrl_pcf85063: pcf85063grp {
+		fsl,pins = <MX91_PAD_SAI1_RXD0__GPIO1_IO14		0x1000>;
+	};
+
+	pinctrl_pexp_irq: pexpirqgrp {
+		fsl,pins = /* HYS | FSEL_0 | No DSE */
+			   <MX91_PAD_SAI1_TXC__GPIO1_IO12		0x1000>;
+	};
+
+	pinctrl_rgbdisp: rgbdispgrp {
+		fsl,pins = <MX91_PAD_GPIO_IO00__MEDIAMIX_DISP_CLK	0x31e>,
+			   <MX91_PAD_GPIO_IO01__MEDIAMIX_DISP_DE	0x31e>,
+			   <MX91_PAD_GPIO_IO02__MEDIAMIX_DISP_VSYNC	0x31e>,
+			   <MX91_PAD_GPIO_IO03__MEDIAMIX_DISP_HSYNC	0x31e>,
+			   <MX91_PAD_GPIO_IO04__MEDIAMIX_DISP_DATA0	0x31e>,
+			   <MX91_PAD_GPIO_IO05__MEDIAMIX_DISP_DATA1	0x31e>,
+			   <MX91_PAD_GPIO_IO06__MEDIAMIX_DISP_DATA2	0x31e>,
+			   <MX91_PAD_GPIO_IO07__MEDIAMIX_DISP_DATA3	0x31e>,
+			   <MX91_PAD_GPIO_IO08__MEDIAMIX_DISP_DATA4	0x31e>,
+			   <MX91_PAD_GPIO_IO09__MEDIAMIX_DISP_DATA5	0x31e>,
+			   <MX91_PAD_GPIO_IO10__MEDIAMIX_DISP_DATA6	0x31e>,
+			   <MX91_PAD_GPIO_IO11__MEDIAMIX_DISP_DATA7	0x31e>,
+			   <MX91_PAD_GPIO_IO12__MEDIAMIX_DISP_DATA8	0x31e>,
+			   <MX91_PAD_GPIO_IO13__MEDIAMIX_DISP_DATA9	0x31e>,
+			   <MX91_PAD_GPIO_IO14__MEDIAMIX_DISP_DATA10	0x31e>,
+			   <MX91_PAD_GPIO_IO15__MEDIAMIX_DISP_DATA11	0x31e>,
+			   <MX91_PAD_GPIO_IO16__MEDIAMIX_DISP_DATA12	0x31e>,
+			   <MX91_PAD_GPIO_IO17__MEDIAMIX_DISP_DATA13	0x31e>,
+			   <MX91_PAD_GPIO_IO18__MEDIAMIX_DISP_DATA14	0x31e>,
+			   <MX91_PAD_GPIO_IO19__MEDIAMIX_DISP_DATA15	0x31e>,
+			   <MX91_PAD_GPIO_IO20__MEDIAMIX_DISP_DATA16	0x31e>,
+			   <MX91_PAD_GPIO_IO21__MEDIAMIX_DISP_DATA17	0x31e>,
+			   <MX91_PAD_GPIO_IO22__MEDIAMIX_DISP_DATA18	0x31e>,
+			   <MX91_PAD_GPIO_IO23__MEDIAMIX_DISP_DATA19	0x31e>,
+			   <MX91_PAD_GPIO_IO24__MEDIAMIX_DISP_DATA20	0x31e>,
+			   <MX91_PAD_GPIO_IO25__MEDIAMIX_DISP_DATA21	0x31e>,
+			   <MX91_PAD_GPIO_IO26__MEDIAMIX_DISP_DATA22	0x31e>,
+			   <MX91_PAD_GPIO_IO27__MEDIAMIX_DISP_DATA23	0x31e>;
+	};
+
+	pinctrl_touch: touchgrp {
+		fsl,pins = /* HYS | FSEL_0 | No DSE */
+			   <MX91_PAD_SAI1_TXFS__GPIO1_IO11		0x1000>;
+	};
+
+	pinctrl_tpm2: tpm2grp {
+		fsl,pins = <MX91_PAD_I2C2_SCL__TPM2_CH2			0x57e>;
+	};
+
+	pinctrl_typec: typecgrp {
+		fsl,pins = /* HYS | FSEL_0 | No DSE */
+			   <MX91_PAD_PDM_BIT_STREAM1__GPIO1_IO10	0x1000>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = /* HYS | FSEL_0 | No DSE */
+			   <MX91_PAD_UART1_RXD__LPUART1_RX		0x1000>,
+			   /* FSEL_2 | DSE X4 */
+			   <MX91_PAD_UART1_TXD__LPUART1_TX		0x011e>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = /* HYS | FSEL_0 | No DSE */
+			   <MX91_PAD_UART2_RXD__LPUART2_RX		0x1000>,
+			   /* FSEL_2 | DSE X4 */
+			   <MX91_PAD_UART2_TXD__LPUART2_TX		0x011e>,
+			   /* FSEL_2 | DSE X4 */
+			   <MX91_PAD_SAI1_TXD0__LPUART2_RTS_B		0x011e>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = /* HYS | FSEL_0 | No DSE */
+			   <MX91_PAD_SD2_CD_B__GPIO3_IO0		0x1000>;
+	};
+
+	/* enable SION for data and cmd pad due to ERR052021 */
+	pinctrl_usdhc2_hs: usdhc2hsgrp {
+		fsl,pins = /* PD | FSEL_3 | DSE X5 */
+			   <MX91_PAD_SD2_CLK__USDHC2_CLK		0x05be>,
+			   /* HYS | PU | FSEL_3 | DSE X4 */
+			   <MX91_PAD_SD2_CMD__USDHC2_CMD		0x4000139e>,
+			   /* HYS | PU | FSEL_3 | DSE X3 */
+			   <MX91_PAD_SD2_DATA0__USDHC2_DATA0		0x4000138e>,
+			   <MX91_PAD_SD2_DATA1__USDHC2_DATA1		0x4000138e>,
+			   <MX91_PAD_SD2_DATA2__USDHC2_DATA2		0x4000138e>,
+			   <MX91_PAD_SD2_DATA3__USDHC2_DATA3		0x4000138e>,
+			   /* FSEL_2 | DSE X3 */
+			   <MX91_PAD_SD2_VSELECT__USDHC2_VSELECT	0x010e>;
+	};
+
+	/* enable SION for data and cmd pad due to ERR052021 */
+	pinctrl_usdhc2_uhs: usdhc2uhsgrp {
+		fsl,pins = /* PD | FSEL_3 | DSE X6 */
+			   <MX91_PAD_SD2_CLK__USDHC2_CLK		0x05fe>,
+			   /* HYS | PU | FSEL_3 | DSE X4 */
+			   <MX91_PAD_SD2_CMD__USDHC2_CMD		0x4000139e>,
+			   <MX91_PAD_SD2_DATA0__USDHC2_DATA0		0x4000139e>,
+			   <MX91_PAD_SD2_DATA1__USDHC2_DATA1		0x4000139e>,
+			   <MX91_PAD_SD2_DATA2__USDHC2_DATA2		0x4000139e>,
+			   <MX91_PAD_SD2_DATA3__USDHC2_DATA3		0x4000139e>,
+			   /* FSEL_2 | DSE X3 */
+			   <MX91_PAD_SD2_VSELECT__USDHC2_VSELECT	0x010e>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx91-tqma9131.dtsi b/arch/arm64/boot/dts/freescale/imx91-tqma9131.dtsi
new file mode 100644
index 0000000000000..a92bc2000367f
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx91-tqma9131.dtsi
@@ -0,0 +1,295 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (c) 2022-2025 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
+ * Author: Alexander Stein
+ */
+
+#include "imx91.dtsi"
+
+/{
+	model = "TQ-Systems i.MX91 TQMa91xxCA / TQMa91xxLA SOM";
+	compatible = "tq,imx91-tqma9131", "fsl,imx91";
+
+	memory@80000000 {
+		device_type = "memory";
+		/* our minimum RAM config will be 1024 MiB */
+		reg = <0x00000000 0x80000000 0 0x40000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* default CMA, must not exceed assembled memory */
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			alloc-ranges = <0 0x80000000 0 0x40000000>;
+			size = <0 0x10000000>;
+			linux,cma-default;
+		};
+
+		/* EdgeLock secure enclave  */
+		ele_reserved: ele-reserved@a4120000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0xa4120000 0 0x100000>;
+			no-map;
+		};
+	};
+
+	/* SD2 RST# via PMIC SW_EN */
+	reg_usdhc2_vmmc: regulator-usdhc2 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
+		regulator-name = "VSD_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&buck4>;
+		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&adc1 {
+	vref-supply = <&buck5>;
+};
+
+&flexspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexspi1>;
+	status = "okay";
+
+	flash0: flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		/*
+		 * no DQS, RXCLKSRC internal loop back, max 66 MHz
+		 * clk framework uses CLK_DIVIDER_ROUND_CLOSEST
+		 * selected value together with root from
+		 * IMX91_CLK_SYS_PLL_PFD1 @ 800.000.000 Hz helps to
+		 * respect the maximum value.
+		 */
+		spi-max-frequency = <62000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+		vcc-supply = <&buck5>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+	};
+};
+
+&lpi2c1 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_lpi2c1>;
+	pinctrl-1 = <&pinctrl_lpi2c1>;
+	status = "okay";
+
+	se97_som: temperature-sensor@1b {
+		compatible = "nxp,se97b", "jedec,jc-42.4-temp";
+		reg = <0x1b>;
+	};
+
+	pca9451a: pmic@25 {
+		compatible = "nxp,pca9451a";
+		reg = <0x25>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pca9451>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+
+		regulators {
+			/* V_0V8_SOC - hw developer guide: 0.75 .. 0.9 */
+			buck1: BUCK1 {
+				regulator-name = "BUCK1";
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <900000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			/* V_DDRQ - 1.1 V for LPDDR4 */
+			buck2: BUCK2 {
+				regulator-name = "BUCK2";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			/* V_3V3 - EEPROM, RTC, ... */
+			buck4: BUCK4 {
+				regulator-name = "BUCK4";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* V_1V8 - SPI NOR, eMMC, RAM VDD1... */
+			buck5: BUCK5 {
+				regulator-name = "BUCK5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* V_1V1 - RAM VDD2*/
+			buck6: BUCK6 {
+				regulator-name = "BUCK6";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* V_1V8_BBSM, fix 1.8 */
+			ldo1: LDO1 {
+				regulator-name = "LDO1";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* V_0V8_ANA */
+			ldo4: LDO4 {
+				regulator-name = "LDO4";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			/* V_SD2 - 3.3/1.8V USDHC2 io Voltage */
+			ldo5: LDO5 {
+				regulator-name = "LDO5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+
+	pcf85063: rtc@51 {
+		compatible = "nxp,pcf85063a";
+		reg = <0x51>;
+		quartz-load-femtofarads = <7000>;
+	};
+
+	eeprom0: eeprom@53 {
+		compatible = "nxp,se97b", "atmel,24c02";
+		reg = <0x53>;
+		pagesize = <16>;
+		read-only;
+		vcc-supply = <&buck4>;
+	};
+
+	eeprom1: eeprom@57 {
+		compatible = "atmel,24c64";
+		reg = <0x57>;
+		pagesize = <32>;
+		vcc-supply = <&buck4>;
+	};
+
+	/* protectable identification memory (part of M24C64-D @57) */
+	eeprom@5f {
+		compatible = "atmel,24c64d-wl";
+		reg = <0x5f>;
+		vcc-supply = <&buck4>;
+	};
+
+	imu@6a {
+		compatible = "st,ism330dhcx";
+		reg = <0x6a>;
+		vdd-supply = <&buck4>;
+		vddio-supply = <&buck4>;
+	};
+};
+
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1>;
+	pinctrl-2 = <&pinctrl_usdhc1>;
+	vmmc-supply = <&buck4>;
+	vqmmc-supply = <&buck5>;
+	bus-width = <8>;
+	non-removable;
+	no-sdio;
+	no-sd;
+	status = "okay";
+};
+
+&wdog3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_flexspi1: flexspi1grp {
+		fsl,pins = /* FSEL 3  | DSE X6 */
+			   <MX91_PAD_SD3_CMD__FLEXSPI1_A_SS0_B		0x01fe>,
+			   <MX91_PAD_SD3_CLK__FLEXSPI1_A_SCLK		0x01fe>,
+			   /* HYS | PU | FSEL 3  | DSE X6 */
+			   <MX91_PAD_SD3_DATA0__FLEXSPI1_A_DATA0	0x13fe>,
+			   <MX91_PAD_SD3_DATA1__FLEXSPI1_A_DATA1	0x13fe>,
+			   /* HYS | FSEL 3  | DSE X6 (external PU) */
+			   <MX91_PAD_SD3_DATA2__FLEXSPI1_A_DATA2	0x11fe>,
+			   <MX91_PAD_SD3_DATA3__FLEXSPI1_A_DATA3	0x11fe>;
+	};
+
+	pinctrl_lpi2c1: lpi2c1grp {
+		fsl,pins = /* SION | OD | FSEL 3 | DSE X4 */
+			   <MX91_PAD_I2C1_SCL__LPI2C1_SCL		0x4000199e>,
+			   <MX91_PAD_I2C1_SDA__LPI2C1_SDA		0x4000199e>;
+	};
+
+	pinctrl_pca9451: pca9451grp {
+		fsl,pins = /* HYS | PU */
+			   <MX91_PAD_I2C2_SDA__GPIO1_IO3		0x1200>;
+	};
+
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		fsl,pins = /* FSEL 2 | DSE X2 */
+			   <MX91_PAD_SD2_RESET_B__GPIO3_IO7		0x106>;
+	};
+
+	/* enable SION for data and cmd pad due to ERR052021 */
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = /* PD | FSEL 3 | DSE X5 */
+			   <MX91_PAD_SD1_CLK__USDHC1_CLK		0x5be>,
+			   /* HYS | FSEL 0 | no drive */
+			   <MX91_PAD_SD1_STROBE__USDHC1_STROBE		0x1000>,
+			   /* HYS | FSEL 3 | X5 */
+			   <MX91_PAD_SD1_CMD__USDHC1_CMD		0x400011be>,
+			   /* HYS | FSEL 3 | X4 */
+			   <MX91_PAD_SD1_DATA0__USDHC1_DATA0		0x4000119e>,
+			   <MX91_PAD_SD1_DATA1__USDHC1_DATA1		0x4000119e>,
+			   <MX91_PAD_SD1_DATA2__USDHC1_DATA2		0x4000119e>,
+			   <MX91_PAD_SD1_DATA3__USDHC1_DATA3		0x4000119e>,
+			   <MX91_PAD_SD1_DATA4__USDHC1_DATA4		0x4000119e>,
+			   <MX91_PAD_SD1_DATA5__USDHC1_DATA5		0x4000119e>,
+			   <MX91_PAD_SD1_DATA6__USDHC1_DATA6		0x4000119e>,
+			   <MX91_PAD_SD1_DATA7__USDHC1_DATA7		0x4000119e>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = /* PU | FSEL 1 | DSE X4 */
+			   <MX91_PAD_WDOG_ANY__WDOG1_WDOG_ANY		0x31e>;
+	};
+};
-- 
2.43.0



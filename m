Return-Path: <linux-kernel+bounces-877618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB89C1E967
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2B583AE278
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D567A2FFFAB;
	Thu, 30 Oct 2025 06:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ty7GpROr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED8030E0EA;
	Thu, 30 Oct 2025 06:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761806142; cv=none; b=ETXQnrUUSoD0dbNoWW8POU9VGc1pylqIWNpdDJGaw4Kp1O5ZugY8+2AgW5WXBxuAsUGSxU9ljYwIbMXBlA256i+VvbEeU3ITzYpJL7P4AkclU+qraTrEbRs+BD+uJGc01IyQgi8TO37ZpJyhmTNGtK6TWSMdNWou2ZRgRIeN/3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761806142; c=relaxed/simple;
	bh=m/U0Tljvx324qvjAXdb/tvGVAjuU08X4d5nBLEnbYOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cNzARRunX/twKkaSR2Yh2oQDeUlTtApttE4FfpLvk9Q5dEyNIg48n1BAcS62XhtN6lL4n40qVrpGLXjJaMUGmEIsumaQhTHiCylwYVOELU4ba6uhUy6a2tgFX43k//9uTKdCZL+IdoZIgTglcLEqTLvw9aAxfDSmSyCpZzk6IeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ty7GpROr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2AF1EC2BCB1;
	Thu, 30 Oct 2025 06:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761806142;
	bh=m/U0Tljvx324qvjAXdb/tvGVAjuU08X4d5nBLEnbYOE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ty7GpROr3YqpZ6f+o7DHaz0PT4cM7ksM9bD2kQZK5aogmvJ6rqCxg9CcpL5x4pbiA
	 4qQgg//Nj4tp/LLRZf5T68K+XkiDNZHFml9OfnK4vD2WUWsP/icEDdk1y6FDGOCsmL
	 ciMkH3jUuX01MCqCHuAJMFuOfapYZv777Ia419czXK6S1zY/fuomYb/lLuTjPDLxdB
	 Kvo6BlpXo2e305HhHxHZ0JyM2WXL8xGVjPCR5HE5FPYSrgYgyuH6lP8m+IP1hb2ZD/
	 mrzRl2bIgrLznQIRtK/4XH8KR8P7hAeklWgfTQUL08ON5HCmkZ54ZUllcczcnLviaN
	 4l7goTYEso/Ng==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E01CCCF9F0;
	Thu, 30 Oct 2025 06:35:42 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Thu, 30 Oct 2025 07:35:41 +0100
Subject: [PATCH v3 5/6] arm64: dts: freescale: Add the GOcontroll Moduline
 IV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-mini_iv-v3-5-ef56c4d9f219@gocontroll.com>
References: <20251030-mini_iv-v3-0-ef56c4d9f219@gocontroll.com>
In-Reply-To: <20251030-mini_iv-v3-0-ef56c4d9f219@gocontroll.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Maud Spierings <maudspierings@gocontroll.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761806140; l=21467;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=f0dYb2RX9gtslmRjdgJ852dUBEFEYxhr6fX8tf41SzM=;
 b=0R/O1z5PLepfgtJwpsHpSuysTJvrepEl6UzkiuBHO2edzl2LGxnBJDIV3VQgRG+TugbC6269w
 IsOerQkvxXkD4Ab9PnPA1x7DkMkX5g0VHW40BeV4cfdA/5tCwiVceRl
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

The Moduline IV is a part of the wider GOcontroll Moduline ecosystem. These
are embedded controllers that focus on modularity with their swappable IO
modules.

Features:
- up to 8 Moduline IO modules
- 4 CAN busses
- 1 LIN bus
- 1 Ethernet
- 4 RGB leds
- optional Wi-Fi/Bluetooth
- optional 4G/GPS

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
 arch/arm64/boot/dts/freescale/Makefile             |   2 +
 .../imx8mm-tx8m-1610-moduline-iv-306-d.dts         | 800 +++++++++++++++++++++
 2 files changed, 802 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 525ef180481d3..b2fef44e0a370 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -124,6 +124,8 @@ imx8mm-evk-pcie-ep-dtbs += imx8mm-evk.dtb imx-pcie0-ep.dtbo
 imx8mm-evkb-pcie-ep-dtbs += imx8mm-evkb.dtb imx-pcie0-ep.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk-pcie-ep.dtb imx8mm-evkb-pcie-ep.dtb
 
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-tx8m-1610-moduline-iv-306-d.dtb
+
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-icore-mx8mm-ctouch2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-icore-mx8mm-edimm2.2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-iot-gateway.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-tx8m-1610-moduline-iv-306-d.dts b/arch/arm64/boot/dts/freescale/imx8mm-tx8m-1610-moduline-iv-306-d.dts
new file mode 100644
index 0000000000000..01df9d77fa51b
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-tx8m-1610-moduline-iv-306-d.dts
@@ -0,0 +1,800 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2025 Maud Spierings <maudspierings@gocontroll.com>
+ */
+
+/dts-v1/;
+
+#include "imx8mm-tx8m-1610.dtsi"
+#include <dt-bindings/leds/common.h>
+
+/ {
+	chassis-type = "embedded";
+	compatible = "gocontroll,moduline-iv-306-d", "karo,imx8mm-tx8m-1610", "fsl,imx8mm";
+	hardware = "Moduline IV V3.06-D";
+	model = "GOcontroll Moduline IV";
+
+	aliases {
+		usb-host = &usbotg2;
+		usbotg = &usbotg1;
+		spi0 = &ecspi2; /* spidev number compatibility */
+		spi1 = &ecspi3; /* spidev number compatibility */
+		spi2 = &ecspi1; /* spidev number compatibility */
+	};
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+
+	mcp_clock: mcp-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <20000000>;
+	};
+
+	reg_3v3_m2: regulator-3v3-m2 {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio4 8 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&pinctrl_reg_m2>;
+		pinctrl-names = "default";
+		power-supply = <&reg_6v4>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "3v3-m.2";
+	};
+
+	reg_5v0: regulator-5v0 {
+		compatible = "regulator-fixed";
+		power-supply = <&reg_6v4>;
+		regulator-always-on;
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "5v0";
+	};
+
+	reg_6v4: regulator-6v4 {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-max-microvolt = <6400000>;
+		regulator-min-microvolt = <6400000>;
+		regulator-name = "6v4";
+	};
+
+	reg_can1_stby: regulator-can1-stby {
+		compatible = "regulator-fixed";
+		gpio = <&gpio3 16 GPIO_ACTIVE_LOW>;
+		pinctrl-0 = <&pinctrl_can1_reg>;
+		pinctrl-names = "default";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "can1-stby";
+	};
+
+	reg_can2_stby: regulator-can2-stby {
+		compatible = "regulator-fixed";
+		gpio = <&gpio3 17 GPIO_ACTIVE_LOW>;
+		pinctrl-0 = <&pinctrl_can2_reg>;
+		pinctrl-names = "default";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "can2-stby";
+	};
+
+	reg_can3_stby: regulator-can3-stby {
+		compatible = "regulator-fixed";
+		gpio = <&gpio1 11 GPIO_ACTIVE_LOW>;
+		pinctrl-0 = <&pinctrl_can3_reg>;
+		pinctrl-names = "default";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "can3-stby";
+	};
+
+	reg_can4_stby: regulator-can4-stby {
+		compatible = "regulator-fixed";
+		gpio = <&gpio3 8 GPIO_ACTIVE_LOW>;
+		pinctrl-0 = <&pinctrl_can4_reg>;
+		pinctrl-names = "default";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "can4-stby";
+	};
+
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-0 = <&pinctrl_wl_reg>;
+		pinctrl-names = "default";
+		post-power-on-delay-ms = <100>;
+		power-off-delay-us = <500000>;
+		reset-gpios = <&gpio3 3 GPIO_ACTIVE_LOW>;
+	};
+};
+
+/* SPI 2 */
+&ecspi1 {
+	cs-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>,
+		   <&gpio1 0 GPIO_ACTIVE_LOW>,
+		   <&gpio5 2 GPIO_ACTIVE_LOW>,
+		   <&gpio4 27 GPIO_ACTIVE_LOW>,
+		   <&gpio3 1 GPIO_ACTIVE_LOW>;
+	pinctrl-0 = <&pinctrl_ecspi1>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	connector@0 {
+		compatible = "gocontroll,moduline-module-slot";
+		reg = <0>;
+		i2c-bus = <&i2c2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
+		slot-number = <3>;
+		spi-max-frequency = <54000000>;
+		sync-gpios = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		vddhpp-supply = <&reg_6v4>;
+		vddp-supply = <&reg_5v0>;
+		vdd-supply = <&reg_vdd_3v3>;
+	};
+
+	connector@1 {
+		compatible = "gocontroll,moduline-module-slot";
+		reg = <1>;
+		i2c-bus = <&i2c2>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <21 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&gpio3 15 GPIO_ACTIVE_LOW>;
+		slot-number = <4>;
+		spi-max-frequency = <54000000>;
+		sync-gpios = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		vddhpp-supply = <&reg_6v4>;
+		vddp-supply = <&reg_5v0>;
+		vdd-supply = <&reg_vdd_3v3>;
+	};
+
+	connector@2 {
+		compatible = "gocontroll,moduline-module-slot";
+		reg = <2>;
+		i2c-bus = <&i2c2>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&gpio4 25 GPIO_ACTIVE_LOW>;
+		slot-number = <5>;
+		spi-max-frequency = <54000000>;
+		sync-gpios = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		vddhpp-supply = <&reg_6v4>;
+		vddp-supply = <&reg_5v0>;
+		vdd-supply = <&reg_vdd_3v3>;
+	};
+
+	connector@3 {
+		compatible = "gocontroll,moduline-module-slot";
+		reg = <3>;
+		i2c-bus = <&i2c2>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&gpio4 28 GPIO_ACTIVE_LOW>;
+		slot-number = <6>;
+		spi-max-frequency = <54000000>;
+		sync-gpios = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		vddhpp-supply = <&reg_6v4>;
+		vddp-supply = <&reg_5v0>;
+		vdd-supply = <&reg_vdd_3v3>;
+	};
+
+	adc@4 {
+		compatible = "microchip,mcp3004";
+		reg = <4>;
+		spi-max-frequency = <2300000>;
+		vref-supply = <&reg_vdd_3v3>;
+	};
+};
+
+&ecspi2 {
+	cs-gpios = <&gpio3 23 GPIO_ACTIVE_LOW>,
+		   <&gpio5 9 GPIO_ACTIVE_LOW>,
+		   <&gpio3 2 GPIO_ACTIVE_LOW>,
+		   <&gpio5 25 GPIO_ACTIVE_LOW>;
+	pinctrl-0 = <&pinctrl_ecspi2>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	connector@0 {
+		compatible = "gocontroll,moduline-module-slot";
+		reg = <0>;
+		i2c-bus = <&i2c2>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <19 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&gpio3 24 GPIO_ACTIVE_LOW>;
+		slot-number = <7>;
+		spi-max-frequency = <54000000>;
+		sync-gpios = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		vddhpp-supply = <&reg_6v4>;
+		vddp-supply = <&reg_5v0>;
+		vdd-supply = <&reg_vdd_3v3>;
+	};
+
+	connector@1 {
+		compatible = "gocontroll,moduline-module-slot";
+		reg = <1>;
+		i2c-bus = <&i2c2>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <22 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&gpio3 21 GPIO_ACTIVE_LOW>;
+		slot-number = <8>;
+		spi-max-frequency = <54000000>;
+		sync-gpios = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		vddhpp-supply = <&reg_6v4>;
+		vddp-supply = <&reg_5v0>;
+		vdd-supply = <&reg_vdd_3v3>;
+	};
+
+	can@2 {
+		compatible = "microchip,mcp25625";
+		reg = <2>;
+		clocks = <&mcp_clock>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-0 = <&pinctrl_can1>;
+		pinctrl-names = "default";
+		spi-max-frequency = <10000000>;
+		vdd-supply = <&reg_vdd_3v3>;
+		xceiver-supply = <&reg_can1_stby>;
+	};
+
+	can@3 {
+		compatible = "microchip,mcp25625";
+		reg = <3>;
+		clocks = <&mcp_clock>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <13 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-0 = <&pinctrl_can2>;
+		pinctrl-names = "default";
+		spi-max-frequency = <10000000>;
+		vdd-supply = <&reg_vdd_3v3>;
+		xceiver-supply = <&reg_can2_stby>;
+	};
+};
+
+&ecspi3 {
+	cs-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>,
+		   <&gpio1 10 GPIO_ACTIVE_LOW>,
+		   <&gpio5 5 GPIO_ACTIVE_LOW>,
+		   <&gpio5 4 GPIO_ACTIVE_LOW>;
+	pinctrl-0 = <&pinctrl_ecspi3>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	connector@0 {
+		compatible = "gocontroll,moduline-module-slot";
+		reg = <0>;
+		i2c-bus = <&i2c2>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
+		slot-number = <1>;
+		spi-max-frequency = <54000000>;
+		sync-gpios = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		vddhpp-supply = <&reg_6v4>;
+		vddp-supply = <&reg_5v0>;
+		vdd-supply = <&reg_vdd_3v3>;
+	};
+
+	connector@1 {
+		compatible = "gocontroll,moduline-module-slot";
+		reg = <1>;
+		i2c-bus = <&i2c2>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <20 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&gpio3 11 GPIO_ACTIVE_LOW>;
+		slot-number = <2>;
+		spi-max-frequency = <54000000>;
+		sync-gpios = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		vddhpp-supply = <&reg_6v4>;
+		vddp-supply = <&reg_5v0>;
+		vdd-supply = <&reg_vdd_3v3>;
+	};
+
+	can@2 {
+		compatible = "microchip,mcp25625";
+		reg = <2>;
+		clocks = <&mcp_clock>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-0 = <&pinctrl_can3>;
+		pinctrl-names = "default";
+		spi-max-frequency = <10000000>;
+		vdd-supply = <&reg_vdd_3v3>;
+		xceiver-supply = <&reg_can3_stby>;
+	};
+
+	can@3 {
+		compatible = "microchip,mcp25625";
+		reg = <3>;
+		clocks = <&mcp_clock>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <18 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-0 = <&pinctrl_can4>;
+		pinctrl-names = "default";
+		spi-max-frequency = <10000000>;
+		vdd-supply = <&reg_vdd_3v3>;
+		xceiver-supply = <&reg_can4_stby>;
+	};
+};
+
+&gpu_2d {
+	status = "disabled";
+};
+
+&gpu_3d {
+	status = "disabled";
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	pinctrl-1 = <&pinctrl_i2c2_gpio>;
+	scl-gpios = <&gpio5 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+};
+
+&i2c3 {
+	clock-frequency = <400000>;
+	pinctrl-0 = <&pinctrl_i2c3>;
+	pinctrl-1 = <&pinctrl_i2c3_gpio>;
+	pinctrl-names = "default", "gpio";
+	scl-gpios = <&gpio5 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+
+	lp5012@14 {
+		compatible = "ti,lp5012";
+		reg = <0x14>;
+		vled-supply = <&reg_6v4>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		multi-led@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			color = <LED_COLOR_ID_RGB>;
+			label = "case-led1";
+
+			led@0 {
+				color = <LED_COLOR_ID_RED>;
+				reg = <0>;
+			};
+
+			led@1 {
+				color = <LED_COLOR_ID_GREEN>;
+				reg = <1>;
+			};
+
+			led@2 {
+				color = <LED_COLOR_ID_BLUE>;
+				reg = <2>;
+			};
+		};
+
+		multi-led@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			color = <LED_COLOR_ID_RGB>;
+			label = "case-led2";
+
+			led@0 {
+				color = <LED_COLOR_ID_RED>;
+				reg = <0>;
+			};
+
+			led@1 {
+				color = <LED_COLOR_ID_GREEN>;
+				reg = <1>;
+			};
+
+			led@2 {
+				color = <LED_COLOR_ID_BLUE>;
+				reg = <2>;
+			};
+		};
+
+		multi-led@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			color = <LED_COLOR_ID_RGB>;
+			label = "case-led3";
+
+			led@0 {
+				color = <LED_COLOR_ID_RED>;
+				reg = <0>;
+			};
+
+			led@1 {
+				color = <LED_COLOR_ID_GREEN>;
+				reg = <1>;
+			};
+
+			led@2 {
+				color = <LED_COLOR_ID_BLUE>;
+				reg = <2>;
+			};
+		};
+
+		multi-led@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			color = <LED_COLOR_ID_RGB>;
+			label = "case-led4";
+
+			led@0 {
+				color = <LED_COLOR_ID_RED>;
+				reg = <0>;
+			};
+
+			led@1 {
+				color = <LED_COLOR_ID_GREEN>;
+				reg = <1>;
+			};
+
+			led@2 {
+				color = <LED_COLOR_ID_BLUE>;
+				reg = <2>;
+			};
+		};
+	};
+};
+
+&iomuxc {
+	pinctrl_bt: btgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO01_GPIO1_IO1
+				MX8MM_DSE_X1
+			MX8MM_IOMUXC_SAI5_MCLK_GPIO3_IO25
+				(MX8MM_PULL_UP | MX8MM_PULL_ENABLE | MX8MM_HYS_SCHMITT)
+			MX8MM_IOMUXC_ECSPI2_SS0_GPIO5_IO13
+				MX8MM_DSE_X1
+		>;
+	};
+
+	pinctrl_can1: can1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_ALE_GPIO3_IO0
+				(MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+			MX8MM_IOMUXC_NAND_CE3_B_GPIO3_IO4
+				(MX8MM_PULL_UP | MX8MM_PULL_ENABLE | MX8MM_HYS_SCHMITT)
+		>;
+	};
+
+	pinctrl_can1_reg: can1reggrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16
+				(MX8MM_DSE_X2 | MX8MM_FSEL_FAST | MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_can2: can2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12
+				(MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+			MX8MM_IOMUXC_NAND_DATA07_GPIO3_IO13
+				(MX8MM_PULL_UP | MX8MM_PULL_ENABLE | MX8MM_HYS_SCHMITT)
+		>;
+	};
+
+	pinctrl_can2_reg: can2reggrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_WE_B_GPIO3_IO17
+				(MX8MM_DSE_X2 | MX8MM_FSEL_FAST | MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_can3: can3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SPDIF_TX_GPIO5_IO3
+				(MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+			MX8MM_IOMUXC_NAND_DATA06_GPIO3_IO12
+				(MX8MM_PULL_UP | MX8MM_PULL_ENABLE | MX8MM_HYS_SCHMITT)
+		>;
+	};
+
+	pinctrl_can3_reg: can3reggrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO11_GPIO1_IO11
+				(MX8MM_DSE_X2 | MX8MM_FSEL_FAST | MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_can4: can4grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_DQS_GPIO3_IO14
+				(MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+			MX8MM_IOMUXC_NAND_WP_B_GPIO3_IO18
+				(MX8MM_PULL_UP | MX8MM_PULL_ENABLE | MX8MM_HYS_SCHMITT)
+		>;
+	};
+
+	pinctrl_can4_reg: can4reggrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_DATA02_GPIO3_IO8
+				(MX8MM_DSE_X2 | MX8MM_FSEL_FAST | MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_ecspi1: ecspi1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_ECSPI1_MOSI_ECSPI1_MOSI
+				MX8MM_DSE_X4
+			MX8MM_IOMUXC_ECSPI1_MISO_ECSPI1_MISO
+				(MX8MM_DSE_X4 | MX8MM_HYS_SCHMITT)
+			MX8MM_IOMUXC_ECSPI1_SCLK_ECSPI1_SCLK
+				MX8MM_DSE_X4
+			MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9
+				MX8MM_DSE_X1
+			MX8MM_IOMUXC_GPIO1_IO00_GPIO1_IO0
+				MX8MM_DSE_X1
+			MX8MM_IOMUXC_SAI3_MCLK_GPIO5_IO2
+				MX8MM_DSE_X1
+			MX8MM_IOMUXC_SAI2_MCLK_GPIO4_IO27
+				MX8MM_DSE_X1
+			MX8MM_IOMUXC_NAND_CE0_B_GPIO3_IO1
+				MX8MM_DSE_X1
+		>;
+	};
+
+	pinctrl_ecspi2: ecspi2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI
+				MX8MM_DSE_X4
+			MX8MM_IOMUXC_ECSPI2_MISO_ECSPI2_MISO
+				(MX8MM_DSE_X4 | MX8MM_HYS_SCHMITT)
+			MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK
+				MX8MM_DSE_X4
+			MX8MM_IOMUXC_SAI5_RXD2_GPIO3_IO23
+				MX8MM_DSE_X1
+			MX8MM_IOMUXC_ECSPI1_SS0_GPIO5_IO9
+				MX8MM_DSE_X1
+			MX8MM_IOMUXC_NAND_CE1_B_GPIO3_IO2
+				MX8MM_DSE_X1
+			MX8MM_IOMUXC_UART2_TXD_GPIO5_IO25
+				MX8MM_DSE_X1
+		>;
+	};
+
+	pinctrl_ecspi3: ecspi3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART1_TXD_ECSPI3_MOSI
+				MX8MM_DSE_X4
+			MX8MM_IOMUXC_UART2_RXD_ECSPI3_MISO
+				(MX8MM_DSE_X4 | MX8MM_HYS_SCHMITT)
+			MX8MM_IOMUXC_UART1_RXD_ECSPI3_SCLK
+				MX8MM_DSE_X4
+			MX8MM_IOMUXC_GPIO1_IO04_GPIO1_IO4
+				MX8MM_DSE_X1
+			MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10
+				MX8MM_DSE_X1
+			MX8MM_IOMUXC_SPDIF_EXT_CLK_GPIO5_IO5
+				MX8MM_DSE_X1
+			MX8MM_IOMUXC_SPDIF_RX_GPIO5_IO4
+				MX8MM_DSE_X1
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL
+				MX8MM_I2C_DEFAULT
+			MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA
+				MX8MM_I2C_DEFAULT
+		>;
+	};
+
+	pinctrl_i2c2_gpio: i2c2-gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C2_SCL_GPIO5_IO16
+				MX8MM_I2C_DEFAULT
+			MX8MM_IOMUXC_I2C2_SDA_GPIO5_IO17
+				MX8MM_I2C_DEFAULT
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL
+				MX8MM_I2C_DEFAULT
+			MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA
+				MX8MM_I2C_DEFAULT
+		>;
+	};
+
+	pinctrl_i2c3_gpio: i2c3-gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C3_SCL_GPIO5_IO18
+				MX8MM_I2C_DEFAULT
+			MX8MM_IOMUXC_I2C3_SDA_GPIO5_IO19
+				MX8MM_I2C_DEFAULT
+		>;
+	};
+
+	pinctrl_reg_m2: reg-m2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI1_RXD6_GPIO4_IO8
+				MX8MM_DSE_X1
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI2_RXC_UART1_DCE_RX
+				(MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+			MX8MM_IOMUXC_SAI2_RXFS_UART1_DCE_TX
+				(MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+			MX8MM_IOMUXC_SAI2_RXD0_UART1_DCE_RTS_B
+				(MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+			MX8MM_IOMUXC_SAI2_TXFS_UART1_DCE_CTS_B
+				(MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI3_TXFS_UART2_DCE_RX
+				(MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+			MX8MM_IOMUXC_SAI3_TXC_UART2_DCE_TX
+				(MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+			MX8MM_IOMUXC_SAI3_RXD_UART2_DCE_RTS_B
+				(MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+			MX8MM_IOMUXC_SAI3_RXC_UART2_DCE_CTS_B
+				(MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART3_RXD_UART3_DCE_RX
+				(MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+			MX8MM_IOMUXC_UART3_TXD_UART3_DCE_TX
+				(MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_uart4: uart4grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART4_RXD_UART4_DCE_RX
+				(MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+			MX8MM_IOMUXC_UART4_TXD_UART4_DCE_TX
+				(MX8MM_PULL_UP | MX8MM_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_usdhc2: pinctrlusdhc2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK
+				(MX8MM_DSE_X2 | MX8MM_FSEL_FAST | MX8MM_PULL_ENABLE)
+			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD
+				(MX8MM_DSE_X2 | MX8MM_USDHC_DATA_DEFAULT)
+			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0
+				(MX8MM_DSE_X2 | MX8MM_USDHC_DATA_DEFAULT)
+			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1
+				(MX8MM_DSE_X2 | MX8MM_USDHC_DATA_DEFAULT)
+			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2
+				(MX8MM_DSE_X2 | MX8MM_USDHC_DATA_DEFAULT)
+			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3
+				(MX8MM_DSE_X2 | MX8MM_USDHC_DATA_DEFAULT)
+		>;
+	};
+
+	pinctrl_wl_int: wlintgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI5_RXC_GPIO3_IO20
+				(MX8MM_PULL_UP | MX8MM_HYS_SCHMITT | MX8MM_PULL_ENABLE)
+		>;
+	};
+
+	pinctrl_wl_reg: wlreggrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_CE2_B_GPIO3_IO3
+				MX8MM_DSE_X1
+		>;
+	};
+};
+
+&uart1 {
+	pinctrl-0 = <&pinctrl_uart1>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "infineon,cyw43439-bt", "brcm,bcm4329-bt";
+		device-wakeup-gpios = <&gpio5 13 GPIO_ACTIVE_HIGH>;
+		interrupt-names = "host-wakeup";
+		interrupt-parent = <&gpio3>;
+		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+		max-speed = <921600>;
+		pinctrl-0 = <&pinctrl_bt>;
+		pinctrl-names = "default";
+		shutdown-gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
+		vbat-supply = <&reg_3v3_m2>;
+		vddio-supply = <&reg_3v3_m2>;
+	};
+};
+
+&uart2 {
+	pinctrl-0 = <&pinctrl_uart2>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-0 = <&pinctrl_uart3>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&uart4 {
+	pinctrl-0 = <&pinctrl_uart4>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&usbotg1 {
+	disable-over-current;
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&usbotg2 {
+	disable-over-current;
+	dr_mode = "host";
+	vbus-supply = <&reg_5v0>;
+	status = "okay";
+};
+
+&usdhc2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	cap-power-off-card;
+	keep-power-in-suspend;
+	max-frequency = <50000000>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	non-removable;
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	pinctrl-names = "default";
+	sd-uhs-sdr25;
+	vmmc-supply = <&reg_3v3_m2>;
+	status = "okay";
+
+	wifi@1 {
+		compatible = "infineon,cyw43439-fmac", "brcm,bcm4329-fmac";
+		reg = <1>;
+		pinctrl-0 = <&pinctrl_wl_int>;
+		pinctrl-names = "default";
+		interrupt-names = "host-wake";
+		interrupt-parent = <&gpio3>;
+		interrupts = <20 IRQ_TYPE_LEVEL_LOW>;
+		brcm,board-type = "GOcontroll,moduline";
+	};
+};
+
+&vpu_blk_ctrl {
+	status = "disabled";
+};
+
+&vpu_g1 {
+	status = "disabled";
+};
+
+&vpu_g2 {
+	status = "disabled";
+};
+
+&wdog1 {
+	status = "okay";
+};

-- 
2.51.2




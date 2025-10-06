Return-Path: <linux-kernel+bounces-842897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F56BBDEAE
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 13:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 274313B39D7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 11:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A82527602B;
	Mon,  6 Oct 2025 11:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Ma95DS9Q"
Received: from mx-relay54-hz1.antispameurope.com (mx-relay54-hz1.antispameurope.com [94.100.133.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5438271440
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 11:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.133.227
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759751410; cv=pass; b=oxBEE6YHlmgSWBPTBIRrU+v0oY8LVl90Hub79fQeIBnqgk1HqP/ZysioBhjy5f3Kk2ilvqg8q6uUvXtcrCQpFME8cSg3PdEcoX+DNlOUDMR3o4JAXHg06Vl+9GJIKnrtClLZmkVhcN5B3OWuy3CZVZGauHnAyOwV5dzLpKOmXIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759751410; c=relaxed/simple;
	bh=G+fSl3GvLbmfCz0wid++D/wUtH8sh45uQde54m/17Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EClX2jA8N57LdM6xvnmH4llMmWC2CQ/uLkWqzIwcK7NZQidTOlfCTiHoK4Uj8qpCTSFZPM8RdIzBTf9RDJAnhtxcbP5YQfecM9W2iITIgVWjMT4nz1c9b9pqZWR8L8uF/RYxwNoR1Bn4KBif8sW3zBkQy9becVkhsqm/cyWPuyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Ma95DS9Q; arc=pass smtp.client-ip=94.100.133.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate54-hz1.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=WoZnFskb8vm9QgMi690391dTpuu87ixCWtZEaCFyjf0=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1759751381;
 b=h45uYZBTcvEVe9MTs9+ANLqbmFC5rnuSyWE3kWLqynWEmCHFrmOwu2/Ux60e3D1MkW6AyYsD
 QUJH41OpmEZodIwtatnf2+zON68NDFQ6tm2xKcNYNU576grpjBbe/AQ6TQO6ByYSjSLBOsmD8sx
 ygUVsXqnmm7JX/anBb3KaDDWoxTMZqqpiqNDmzGpTRIamFIPZSe2Fzo+BSuj6uWINBG55IYw2pp
 RW+w+uIyICn5tmr2jPsY/ZVFiMHLne+GUJExfysQ7eOHC1ij0DXzPnYd5CUZMkEAc3YzCRA2T6l
 WqWOxYBG2y4/HwvGALmQXZefxhyJ91f2zz8JFLrjNAHlg==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1759751381;
 b=fg62fa22g9ECNCVKdQP7YMLfgmyf8MaOdNiyBnelDl0pgQWlBeU9RpjouR09C0Yd+LCIEr99
 NkvOXxth4S1c1el+J+dbMboyF27d9zLu3vPXuIHhDNRlM41gUqzTbxXQcB+rwrn3gWDnVyPsMUT
 MjBTFZ8pL2lxlCcJj5bBvX57VmDQ4pVyGlzJwMue67d/0r9D/K5/tckxE5P59zVNvAvjpItqMPd
 A9qbbcL/GGqcdVj45u+mXMVI0lJElaq9o3hqbHX4zAcR+/cPNKib0dtfNU4IB4dk+vVAHrvo61F
 39s4qESTJSbpILKqSTOdNn6SXLNkRAneNF9eq+HivlCVA==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay54-hz1.antispameurope.com;
 Mon, 06 Oct 2025 13:49:41 +0200
Received: from schifferm-ubuntu.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: matthias.schiffer@ew.tq-group.com)
	by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 1E49F220CF5;
	Mon,  6 Oct 2025 13:49:04 +0200 (CEST)
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Andrew Lunn <andrew@lunn.ch>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v3 2/2] arm64: dts: ti: Add TQ-Systems TQMa62xx SoM and MBa62xx carrier board Device Trees
Date: Mon,  6 Oct 2025 13:47:48 +0200
Message-ID: <9d32ed8e097f3aeb3df7696c00ba167d9441cadc.1759749553.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1759749553.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1759749553.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:matthias.schiffer@ew.tq-group.com
X-cloud-security-recipient:linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: matthias.schiffer@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay54-hz1.antispameurope.com with 4cgHc06nmrz1h1mF
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:afb2ee389c59cce4535cde9b0415640c
X-cloud-security:scantime:3.781
DKIM-Signature: a=rsa-sha256;
 bh=WoZnFskb8vm9QgMi690391dTpuu87ixCWtZEaCFyjf0=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1759751380; v=1;
 b=Ma95DS9QfBT/nYDZfsyrF5ndBEXEfHALi+3SRxkrxvsIdZeZ5iiczYTU3SncW6L5qHEy1RE+
 zuXAZ2+E1Nsxto59x0Ld+PCgwc5/WXayayhGlZTPxyPuxkoLPkgK+ixRaI+9TveWFavQal+z/72
 oB60Ug6/NfnEah7AJjQr+JakiICnY8MrmLvM9nOoVLwt0wfZ3be+L93WcXNAMrB9NfmLbsa+obs
 VPAcdpuW0o3YTsyAZbXaZq1NhsnIsF3Ku9t5fDAdLKVV5oTrmQ2BjHvegPYZvEOnd9izokk66S+
 CnPlJq759YtH+g/gUpkWaWWpoPh4G+u4KvWp/lngIEhpw==

The TQMa62xx is a SoM family with a pluggable board connector based on the
TI AM62x SoCs. Add DTS(I) for the AM625 (2x Cortex-A53) variant and its
combination with our MBa62xx carrier board.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 arch/arm64/boot/dts/ti/Makefile               |   1 +
 .../boot/dts/ti/k3-am625-tqma62xx-mba62xx.dts | 928 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am625-tqma62xx.dtsi | 319 ++++++
 3 files changed, 1248 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-tqma62xx-mba62xx.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-tqma62xx.dtsi

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 743115b849a7a..f4b13c44f18bb 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -14,6 +14,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am625-beagleplay-csi2-ov5640.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-beagleplay-csi2-tevi-ov5640.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-phyboard-lyra-rdk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-sk.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am625-tqma62xx-mba62xx.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-nonwifi-dahlia.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-nonwifi-dev.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-nonwifi-ivy.dtb
diff --git a/arch/arm64/boot/dts/ti/k3-am625-tqma62xx-mba62xx.dts b/arch/arm64/boot/dts/ti/k3-am625-tqma62xx-mba62xx.dts
new file mode 100644
index 0000000000000..9e9bf1a830091
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am625-tqma62xx-mba62xx.dts
@@ -0,0 +1,928 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (C) 2021-2022 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (c) 2023-2024 TQ-Systems GmbH <linux@ew.tq-group.com>, D-82229 Seefeld, Germany.
+ * Author: Matthias Schiffer
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/net/ti-dp83867.h>
+#include <dt-bindings/pwm/pwm.h>
+#include "k3-am625-tqma62xx.dtsi"
+
+/ {
+	compatible = "tq,am625-tqma6254-mba62xx", "tq,am625-tqma6254",
+		     "ti,am625";
+	model = "TQ-Systems TQMa62xx SoM on MBa62xx carrier board";
+	chassis-type = "embedded";
+
+	aliases {
+		can0 = &mcu_mcan0;
+		can1 = &mcu_mcan1;
+		ethernet0 = &cpsw_port1;
+		ethernet1 = &cpsw_port2;
+		i2c1 = &main_i2c1;
+		mmc1 = &sdhci1;
+		mmc2 = &sdhci2;
+		serial0 = &main_uart0;
+		serial1 = &mcu_uart0;
+		spi1 = &main_spi0;
+		usb0 = &usb0;
+		usb1 = &usb1;
+	};
+
+	chosen {
+		stdout-path = &main_uart0;
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pinctrl-names = "default";
+		pinctrl-0 = <&backlight_pins>;
+		enable-gpios = <&main_gpio0 38 GPIO_ACTIVE_HIGH>;
+		status = "disabled";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_key_pins>;
+
+		user-button {
+			label = "USER_BUTTON";
+			linux,code = <BTN_0>;
+			gpios = <&main_gpio0 40 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_led_pins>;
+
+		led-1 {
+			gpios = <&main_gpio0 41 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_INDICATOR;
+		};
+
+		led-2 {
+			gpios = <&main_gpio0 42 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_YELLOW>;
+			function = LED_FUNCTION_INDICATOR;
+		};
+	};
+
+	panel: panel {
+		pinctrl-names = "default";
+		pinctrl-0 = <&lvds_panel_pins>;
+		enable-gpios = <&main_gpio0 36 GPIO_ACTIVE_HIGH>;
+		power-supply = <&reg_lvds_pwr>;
+	};
+
+	fan0: pwm-fan {
+		compatible = "pwm-fan";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm_fan_pins>;
+		fan-supply = <&reg_pwm_fan>;
+		#cooling-cells = <2>;
+		/* typical 25 kHz -> 40.000 nsec */
+		pwms = <&epwm0 1 40000 PWM_POLARITY_INVERTED>;
+		cooling-levels = <0 32 64 128 196 240>;
+		pulses-per-revolution = <2>;
+		interrupt-parent = <&main_gpio1>;
+		interrupts = <30 IRQ_TYPE_EDGE_FALLING>;
+		status = "disabled";
+	};
+
+	wifi_pwrseq: pwrseq-wifi {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&main_mmc2_pwrseq_pins>;
+		reset-gpios = <&main_gpio0 44 GPIO_ACTIVE_HIGH>;
+	};
+
+	reg_1v8: regulator-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "V_1V8_MBA";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	reg_3v3_sd: regulator-3v3-sd {
+		bootph-all;
+		/* TPS22963CYZTP */
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&reg_3v3_sd_pins>;
+		regulator-name = "V_3V3_SD";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		enable-active-high;
+		vin-supply = <&reg_3v3>;
+		gpio = <&main_gpio1 8 GPIO_ACTIVE_HIGH>;
+	};
+
+	reg_lvds_pwr: regulator-lvds-pwr {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&reg_lvds_pwr_pins>;
+		regulator-name = "LVDS0_PWR";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		vin-supply = <&reg_3v3>;
+		gpio = <&main_gpio0 61 GPIO_ACTIVE_HIGH>;
+	};
+
+	reg_pwm_fan: regulator-pwm-fan {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&reg_pwm_fan_pins>;
+		regulator-name = "FAN_PWR";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		gpio = <&main_gpio0 62 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	sound: sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "tqm-tlv320aic32";
+		simple-audio-card,widgets =
+			"Line Out",	"Line Out",
+			"Line In",	"Line In",
+			"Microphone",	"Microphone Jack";
+		simple-audio-card,routing =
+			"Line Out",		"LOL",
+			"Line Out",		"LOR",
+			"IN1_L",		"Line In",
+			"IN1_R",		"Line In",
+			"IN3_L",		"Microphone Jack",
+			"Microphone Jack",	"Mic Bias";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&sound_master>;
+		simple-audio-card,frame-master = <&sound_master>;
+
+		simple-audio-card,cpu {
+			sound-dai = <&mcasp1>;
+		};
+
+		sound_master: simple-audio-card,codec {
+			sound-dai = <&tlv320aic32x4>;
+			clocks = <&audio_refclk0>;
+		};
+	};
+};
+
+&audio_refclk0 {
+	/* Set parent to POSTDIV1_16FFT_MAIN_1_HSDIVOUT6, for 96MHz clock output */
+	assigned-clock-parents = <&k3_clks 157 7>;
+};
+
+&cpsw3g {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_rgmii1_pins
+		     &main_rgmii2_pins>;
+};
+
+&cpsw_port1 {
+	phy-mode = "rgmii-id";
+	phy-handle = <&cpsw3g_phy0>;
+};
+
+&cpsw_port2 {
+	phy-mode = "rgmii-id";
+	phy-handle = <&cpsw3g_phy3>;
+};
+
+&cpsw3g_mdio {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mdio1_pins>;
+
+	cpsw3g_phy0: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x0>;
+		reset-gpios = <&main_gpio1 11 GPIO_ACTIVE_LOW>;
+		reset-assert-us = <1000>;
+		reset-deassert-us = <1000>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
+	};
+
+	cpsw3g_phy3: ethernet-phy@3 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x3>;
+		reset-gpios = <&main_gpio1 12 GPIO_ACTIVE_LOW>;
+		reset-assert-us = <1000>;
+		reset-deassert-us = <1000>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
+	};
+};
+
+&dss {
+	pinctrl-names = "default";
+	pinctrl-0 = <&dss_pins>;
+};
+
+&epwm0 {
+	status = "okay";
+};
+
+&epwm1 {
+	status = "okay";
+};
+
+&main_gpio0 {
+	bootph-all;
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_gpio0_pins &main_gpio0_pr0_pins>;
+	gpio-line-names =
+		"", "", "", "", /* 0-3 */
+		"", "", "", "", /* 4-7 */
+		"", "", "", "", /* 8-11 */
+		"ADC_SYNC", "ADC_RST#", "ADC_DATA_RDY", "", /* 12-15 */
+		"", "", "", "", /* 16-19 */
+		"", "", "", "", /* 20-23 */
+		"", "", "", "", /* 24-27 */
+		"", "", "", "", /* 28-31 */
+		"", "", "", "", /* 32-35 */
+		"", "", "", "BG95_PWRKEY", /* 36-39 */
+		"", "", "", "BG95_RESET", /* 40-43 */
+		"", "", "", "", /* 44-47 */
+		"", "", "", "", /* 48-51 */
+		"", "", "", "", /* 52-55 */
+		"", "", "", "", /* 56-59 */
+		"", "", "", "", /* 60-63 */
+		"", "", "", "", /* 64-67 */
+		"", "", "", "", /* 68-71 */
+		"ADC_INT"; /* 72- */
+};
+
+&main_gpio1 {
+	bootph-all;
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_gpio1_pins &main_gpio1_pr0_pins>;
+
+	/* No overcurrent handling in USB host driver - pin is hogged for now */
+	line7-hog {
+		gpio-hog;
+		gpios = <7 GPIO_ACTIVE_HIGH>;
+		line-name = "USB0_VBUS_OC#";
+		input;
+	};
+};
+
+&main_i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c1_pins>;
+	clock-frequency = <400000>;
+	status = "okay";
+
+	tlv320aic32x4: audio-codec@18 {
+		compatible = "ti,tlv320aic32x4";
+		reg = <0x18>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&audio_codec_pins>;
+		#sound-dai-cells = <0>;
+		clock-names = "mclk";
+		clocks = <&audio_refclk0>;
+		reset-gpios = <&main_gpio0 33 GPIO_ACTIVE_LOW>;
+		iov-supply = <&reg_1v8>;
+		ldoin-supply = <&reg_3v3>;
+	};
+};
+
+&main_spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_spi0_pins>;
+	ti,pindir-d0-out-d1-in;
+	status = "okay";
+
+	/* adc@0: NXP NAFE13388 */
+};
+
+&main0_thermal {
+	trips {
+		main0_active0: trip-active0 {
+			temperature = <40000>;
+			hysteresis = <5000>;
+			type = "active";
+		};
+
+		main0_active1: trip-active1 {
+			temperature = <48000>;
+			hysteresis = <3000>;
+			type = "active";
+		};
+
+		main0_active2: trip-active2 {
+			temperature = <60000>;
+			hysteresis = <10000>;
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map1 {
+			trip = <&main0_active0>;
+			cooling-device = <&fan0 1 1>;
+		};
+
+		map2 {
+			trip = <&main0_active1>;
+			cooling-device = <&fan0 2 2>;
+		};
+
+		map3 {
+			trip = <&main0_active2>;
+			cooling-device = <&fan0 3 3>;
+		};
+	};
+};
+
+&main1_thermal {
+	trips {
+		main1_active0: trip-active0 {
+			temperature = <40000>;
+			hysteresis = <5000>;
+			type = "active";
+		};
+
+		main1_active1: trip-active1 {
+			temperature = <48000>;
+			hysteresis = <3000>;
+			type = "active";
+		};
+
+		main1_active2: trip-active2 {
+			temperature = <60000>;
+			hysteresis = <10000>;
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map1 {
+			trip = <&main1_active0>;
+			cooling-device = <&fan0 1 1>;
+		};
+
+		map2 {
+			trip = <&main1_active1>;
+			cooling-device = <&fan0 2 2>;
+		};
+
+		map3 {
+			trip = <&main1_active2>;
+			cooling-device = <&fan0 3 3>;
+		};
+	};
+};
+
+/* Main console */
+&main_uart0 {
+	bootph-all;
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart0_pins>;
+	status = "okay";
+};
+
+/*
+ * IOT module - GNSS UART
+ *
+ * Board configuration must not enable UART trace output for TIFS firmware
+ */
+&main_uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart1_pins>;
+	/* IOT module uses USB by default, UART can be enabled as fallback */
+	status = "disabled";
+};
+
+/* Bluetooth module */
+&main_uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart2_pins>;
+	/* Bluetooth module uses SDIO by default, UART can be enabled as fallback */
+	status = "disabled";
+};
+
+/* IOT module - main UART */
+&main_uart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart5_pins>;
+	/* IOT module uses USB by default, UART can be enabled as fallback */
+	status = "disabled";
+};
+
+&mcasp1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcasp1_pins>;
+	#sound-dai-cells = <0>;
+	op-mode = <0>; /* MCASP_IIS_MODE */
+	tdm-slots = <2>;
+	serial-dir = < /* 0: INACTIVE, 1: TX, 2: RX */
+	       1 0 2 0
+	       0 0 0 0
+	       0 0 0 0
+	       0 0 0 0
+	>;
+	tx-num-evt = <0>;
+	rx-num-evt = <0>;
+	status = "okay";
+};
+
+&mcu_gpio0 {
+	bootph-all;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_gpio0_pins>;
+	gpio-line-names =
+		"EN_DIG_OUT_1", "EN_DIG_OUT_2", "STATUS_OUT_1", "STATUS_OUT_2", /* 0-3 */
+		"EN_DIG_OUT_3", "", "", "V_VPP_EN", /* 4-7 */
+		"", "", "", "EN_DIG_OUT_4", /* 8-11 */
+		"STATUS_OUT_3", "", "", "", /* 12-15 */
+		"", "STATUS_OUT_4", "DIG_IN_1", "DIG_IN_2", /* 16-19 */
+		"DIG_IN_3", "", "", "DIG_IN_4"; /* 20-23 */
+};
+
+&mcu_mcan0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_mcan0_pins>;
+	status = "okay";
+};
+
+&mcu_mcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_mcan1_pins>;
+	status = "okay";
+};
+
+&mcu_uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_uart0_pins>;
+	rs485-rts-active-low;
+	linux,rs485-enabled-at-boot-time;
+	status = "okay";
+};
+
+&reg_sd {
+	bootph-all;
+	pinctrl-names = "default";
+	pinctrl-0 = <&reg_sd_pins>;
+	gpios = <&main_gpio0 31 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&sdhci1 {
+	bootph-all;
+	/* SD-card */
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mmc1_pins>;
+	vmmc-supply = <&reg_3v3_sd>;
+	vqmmc-supply = <&reg_sd>;
+	bus-width = <4>;
+	disable-wp;
+	no-mmc;
+	no-sdio;
+	ti,driver-strength-ohm = <50>;
+	status = "okay";
+};
+
+&sdhci2 {
+	/* WLAN */
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mmc2_pins>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	keep-power-in-suspend;
+	cap-power-off-card;
+	bus-width = <4>;
+	non-removable;
+	no-mmc;
+	no-sd;
+	ti,driver-strength-ohm = <50>;
+	ti,fails-without-test-cd;
+	status = "okay";
+};
+
+&usbss0 {
+	bootph-all;
+	ti,vbus-divider;
+	status = "okay";
+};
+
+&usbss1 {
+	ti,vbus-divider;
+	status = "okay";
+};
+
+&usb0 {
+	bootph-all;
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_usb0_pins>;
+	dr_mode = "otg";
+	usb-role-switch;
+
+	connector {
+		compatible = "gpio-usb-b-connector", "usb-b-connector";
+		id-gpios = <&main_gpio0 71 GPIO_ACTIVE_HIGH>;
+		type = "micro";
+	};
+};
+
+&usb1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_usb1_hub_pins>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	dr_mode = "host";
+
+	usb1_hub_2_0: hub@1 {
+		compatible = "usb424,2514";
+		reg = <1>;
+		reset-gpios = <&main_gpio1 23 GPIO_ACTIVE_HIGH>;
+		vdd-supply = <&reg_3v3>;
+	};
+};
+
+&wkup_uart0 {
+	/* WKUP UART0 is used by DM firmware */
+	status = "reserved";
+};
+
+&main_pmx0 {
+	audio_codec_pins: audio-codec-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x088, PIN_OUTPUT, 7) /* (L24) GPMC0_OEn_REn.GPIO0_33 */
+			AM62X_IOPAD(0x1d0, PIN_OUTPUT, 5) /* (A15) UART0_CTSn.AUDIO_EXT_REFCLK0 */
+		>;
+	};
+
+	backlight_pins: backlight-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x009c, PIN_OUTPUT, 7) /* (V25) GPMC0_WAIT1.GPIO0_38 */
+			AM62X_IOPAD(0x01a0, PIN_OUTPUT, 6) /* (E18) MCASP0_AXR0.EHRPWM1_B */
+		>;
+	};
+
+	dss_pins: dss-pins {
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
+
+	csi_clk_pins: csi-clk-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x019c, PIN_OUTPUT, 6) /* (B18) MCASP0_AXR1.EHRPWM1_A */
+		>;
+	};
+
+	gpio_key_pins: gpio-key-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x0a4, PIN_INPUT, 7) /* (M22) GPMC0_DIR.GPIO0_40 */
+		>;
+	};
+
+	gpio_led_pins: gpio-led-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x0a8, PIN_OUTPUT, 7) /* (M21) GPMC0_CSn0.GPIO0_41 */
+			AM62X_IOPAD(0x0ac, PIN_OUTPUT, 7) /* (L21) GPMC0_CSn1.GPIO0_42 */
+		>;
+	};
+
+	lvds_panel_pins: lvds-panel-pins {
+		pinctrl-single,pins = <
+			/* (N20) GPMC0_BE1n.GPIO0_36 - LVDS0_RESET# */
+			AM62X_IOPAD(0x0094, PIN_OUTPUT, 7)
+		>;
+	};
+
+	main_gpio0_pins: main-gpio0-pins {
+		pinctrl-single,pins = <
+			/* Control GPIOs for IOT Module */
+			/* (K25) GPMC0_WPn.GPIO0_39 - BG95_PWRKEY */
+			AM62X_IOPAD(0x0a0, PIN_OUTPUT, 7)
+			/* (K22) GPMC0_CSn2.GPIO0_43 - BG95_RESET */
+			AM62X_IOPAD(0x0b0, PIN_OUTPUT, 7)
+		>;
+	};
+
+	main_gpio0_pr0_pins: main-gpio0-pr0-pins {
+		pinctrl-single,pins = <
+			/* (N24) GPMC0_AD2.GPIO0_17  */
+			AM62X_IOPAD(0x0044, PIN_INPUT, 7)
+			/* (N25) GPMC0_AD3.GPIO0_18  */
+			AM62X_IOPAD(0x0048, PIN_INPUT, 7)
+			/* (P24) GPMC0_AD4.GPIO0_19  */
+			AM62X_IOPAD(0x004c, PIN_INPUT, 7)
+			/* (P22) GPMC0_AD5.GPIO0_20  */
+			AM62X_IOPAD(0x0050, PIN_INPUT, 7)
+			/* (W25) VOUT0_DATA2.GPIO0_47  */
+			AM62X_IOPAD(0x00c0, PIN_INPUT, 7)
+			/* (W24) VOUT0_DATA3.GPIO0_48  */
+			AM62X_IOPAD(0x00c4, PIN_INPUT, 7)
+			/* (Y25) VOUT0_DATA4.GPIO0_49  */
+			AM62X_IOPAD(0x00c8, PIN_INPUT, 7)
+			/* (Y24) VOUT0_DATA5.GPIO0_50  */
+			AM62X_IOPAD(0x00cc, PIN_INPUT, 7)
+		>;
+	};
+
+	main_gpio1_pins: main-gpio1-pins {
+		pinctrl-single,pins = <
+			/* (B19) MCASP0_AXR3.GPIO1_7 - USB0_VBUS_OC# */
+			AM62X_IOPAD(0x0194, PIN_INPUT, 7)
+		>;
+	};
+
+	main_gpio1_pr0_pins: main-gpio1-pr0-pins {
+		pinctrl-single,pins = <
+			/* (C15) MCAN0_TX.GPIO1_24 */
+			AM62X_IOPAD(0x01d8, PIN_INPUT, 7)
+			/* (E15) MCAN0_RX.GPIO1_25 */
+			AM62X_IOPAD(0x01dc, PIN_INPUT, 7)
+		>;
+	};
+
+	main_i2c1_pins: main-i2c1-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x1e8, PIN_INPUT, 0) /* (B17) I2C1_SCL */
+			AM62X_IOPAD(0x1ec, PIN_INPUT, 0) /* (A17) I2C1_SDA */
+		>;
+	};
+
+	main_mcasp1_pins: main-mcasp1-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x090, PIN_INPUT, 2) /* (M24) GPMC0_BE0N_CLE.MCASP1_ACLKX */
+			AM62X_IOPAD(0x098, PIN_INPUT, 2) /* (U23) GPMC0_WAIT0.MCASP1_AFSX */
+			AM62X_IOPAD(0x08c, PIN_OUTPUT, 2) /* (L25) GPMC0_WEN.MCASP1_AXR0 */
+			AM62X_IOPAD(0x084, PIN_INPUT, 2) /* (L23) GPMC0_ADVN_ALE.MCASP1_AXR2 */
+		>;
+	};
+
+	main_mmc1_pins: main-mmc1-pins {
+		bootph-all;
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x23c, PIN_INPUT, 0) /* (A21) MMC1_CMD */
+			AM62X_IOPAD(0x234, PIN_INPUT, 0) /* (B22) MMC1_CLK */
+			AM62X_IOPAD(0x230, PIN_INPUT, 0) /* (A22) MMC1_DAT0 */
+			AM62X_IOPAD(0x22c, PIN_INPUT, 0) /* (B21) MMC1_DAT1 */
+			AM62X_IOPAD(0x228, PIN_INPUT, 0) /* (C21) MMC1_DAT2 */
+			AM62X_IOPAD(0x224, PIN_INPUT, 0) /* (D22) MMC1_DAT3 */
+			AM62X_IOPAD(0x240, PIN_INPUT, 0) /* (D17) MMC1_SDCD */
+		>;
+	};
+
+	main_mmc2_pins: main-mmc2-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x120, PIN_INPUT, 0) /* (C24) MMC2_CMD */
+			AM62X_IOPAD(0x118, PIN_INPUT, 0) /* (D25) MMC2_CLK */
+			AM62X_IOPAD(0x114, PIN_INPUT, 0) /* (B24) MMC2_DAT0 */
+			AM62X_IOPAD(0x110, PIN_INPUT, 0) /* (C25) MMC2_DAT1 */
+			AM62X_IOPAD(0x10c, PIN_INPUT, 0) /* (E23) MMC2_DAT2 */
+			AM62X_IOPAD(0x108, PIN_INPUT, 0) /* (D24) MMC2_DAT3 */
+			AM62X_IOPAD(0x11c, PIN_INPUT, 0) /* (#N/A) MMC2_CLKB */
+		>;
+	};
+
+	main_mmc2_pwrseq_pins: main-mmc2-pwrseq-pins {
+		pinctrl-single,pins = <
+			/* (K24) GPMC0_CSn3.GPIO0_44 - WIFI-BT_EN */
+			AM62X_IOPAD(0x00b4, PIN_OUTPUT, 7)
+		>;
+	};
+
+	main_mdio1_pins: main-mdio1-pins {
+		pinctrl-single,pins = <
+			/* (B20) MCASP0_ACLKX.GPIO1_11 - RESET_RGMII1# */
+			AM62X_IOPAD(0x1a4, PIN_OUTPUT, 7)
+			/* (D20) MCASP0_AFSX.GPIO1_12 - RESET_RGMII2# */
+			AM62X_IOPAD(0x1a8, PIN_OUTPUT, 7)
+
+			AM62X_IOPAD(0x160, PIN_OUTPUT, 0) /* (AD24) MDIO0_MDC */
+			AM62X_IOPAD(0x15c, PIN_INPUT, 0) /* (AB22) MDIO0_MDIO */
+		>;
+	};
+
+	main_rgmii1_pins: main-rgmii1-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x14c, PIN_INPUT, 0) /* (AB17) RGMII1_RD0 */
+			AM62X_IOPAD(0x150, PIN_INPUT, 0) /* (AC17) RGMII1_RD1 */
+			AM62X_IOPAD(0x154, PIN_INPUT, 0) /* (AB16) RGMII1_RD2 */
+			AM62X_IOPAD(0x158, PIN_INPUT, 0) /* (AA15) RGMII1_RD3 */
+			AM62X_IOPAD(0x148, PIN_INPUT, 0) /* (AD17) RGMII1_RXC */
+			AM62X_IOPAD(0x144, PIN_INPUT, 0) /* (AE17) RGMII1_RX_CTL */
+			AM62X_IOPAD(0x134, PIN_OUTPUT, 0) /* (AE20) RGMII1_TD0 */
+			AM62X_IOPAD(0x138, PIN_OUTPUT, 0) /* (AD20) RGMII1_TD1 */
+			AM62X_IOPAD(0x13c, PIN_OUTPUT, 0) /* (AE18) RGMII1_TD2 */
+			AM62X_IOPAD(0x140, PIN_OUTPUT, 0) /* (AD18) RGMII1_TD3 */
+			AM62X_IOPAD(0x130, PIN_OUTPUT, 0) /* (AE19) RGMII1_TXC */
+			AM62X_IOPAD(0x12c, PIN_OUTPUT, 0) /* (AD19) RGMII1_TX_CTL */
+		>;
+	};
+
+	main_rgmii2_pins: main-rgmii2-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x184, PIN_INPUT, 0) /* (AE23) RGMII2_RD0 */
+			AM62X_IOPAD(0x188, PIN_INPUT, 0) /* (AB20) RGMII2_RD1 */
+			AM62X_IOPAD(0x18c, PIN_INPUT, 0) /* (AC21) RGMII2_RD2 */
+			AM62X_IOPAD(0x190, PIN_INPUT, 0) /* (AE22) RGMII2_RD3 */
+			AM62X_IOPAD(0x180, PIN_INPUT, 0) /* (AD23) RGMII2_RXC */
+			AM62X_IOPAD(0x17c, PIN_INPUT, 0) /* (AD22) RGMII2_RX_CTL */
+			AM62X_IOPAD(0x16c, PIN_OUTPUT, 0) /* (Y18) RGMII2_TD0 */
+			AM62X_IOPAD(0x170, PIN_OUTPUT, 0) /* (AA18) RGMII2_TD1 */
+			AM62X_IOPAD(0x174, PIN_OUTPUT, 0) /* (AD21) RGMII2_TD2 */
+			AM62X_IOPAD(0x178, PIN_OUTPUT, 0) /* (AC20) RGMII2_TD3 */
+			AM62X_IOPAD(0x168, PIN_OUTPUT, 0) /* (AE21) RGMII2_TXC */
+			AM62X_IOPAD(0x164, PIN_OUTPUT, 0) /* (AA19) RGMII2_TX_CTL */
+		>;
+	};
+
+	main_spi0_pins: main-spi0-pins {
+		pinctrl-single,pins = <
+			/* (A14) SPI0_CLK */
+			AM62X_IOPAD(0x1bc, PIN_OUTPUT, 0)
+			/* (A13) SPI0_CS0 */
+			AM62X_IOPAD(0x1b4, PIN_OUTPUT, 0)
+			/* (B13) SPI0_D0 */
+			AM62X_IOPAD(0x1c0, PIN_OUTPUT, 0)
+			/* (B14) SPI0_D1 */
+			AM62X_IOPAD(0x1c4, PIN_INPUT, 0)
+		>;
+	};
+
+	main_spi0_adc_pins: main-spi0-adc-pins {
+		pinctrl-single,pins = <
+			/* (G21) OSPI0_CSn1.GPIO0_12 - ADC_SYNC */
+			AM62X_IOPAD(0x030, PIN_INPUT, 7)
+			/* (H21) OSPI0_CSn2.GPIO0_13 - ADC_RST# */
+			AM62X_IOPAD(0x034, PIN_OUTPUT, 7)
+			/* (E24) OSPI0_CSn3.GPIO0_14 - ADC_DATA_RDY */
+			AM62X_IOPAD(0x038, PIN_INPUT, 7)
+			/* (B23) MMC2_SDWP.GPIO0_72 - ADC_INT# */
+			AM62X_IOPAD(0x128, PIN_INPUT, 7)
+		>;
+	};
+
+	main_uart0_pins: main-uart0-pins {
+		bootph-all;
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x1c8, PIN_INPUT, 0) /* (D14) UART0_RXD */
+			AM62X_IOPAD(0x1cc, PIN_OUTPUT, 0) /* (E14) UART0_TXD */
+		>;
+	};
+
+	main_uart1_pins: main-uart1-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x1ac, PIN_INPUT, 2) /* (E19) MCASP0_AFSR.UART1_RXD */
+			AM62X_IOPAD(0x1b0, PIN_OUTPUT, 2) /* (A20) MCASP0_ACLKR.UART1_TXD */
+		>;
+	};
+
+	main_uart2_pins: main-uart2-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x0b8, PIN_INPUT, 4) /* (U22) VOUT0_DATA0.UART2_RXD */
+			AM62X_IOPAD(0x0bc, PIN_OUTPUT, 4) /* (V24) VOUT0_DATA1.UART2_TXD */
+			AM62X_IOPAD(0x104, PIN_INPUT, 4) /* (AC24) VOUT0_PCLK.UART2_CTS# */
+			AM62X_IOPAD(0x100, PIN_OUTPUT, 4) /* (AC25) VOUT0_VSYNC.UART2_RTS# */
+		>;
+	};
+
+	main_uart5_pins: main-uart5-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x0d0, PIN_INPUT, 4) /* (Y23) VOUT0_DATA6.UART5_RXD */
+			AM62X_IOPAD(0x0d4, PIN_OUTPUT, 4) /* (AA25) VOUT0_DATA7.UART5_TXD */
+		>;
+	};
+
+	main_usb0_pins: main-usb0-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x254, PIN_OUTPUT, 0) /* (C20) USB0_DRVVBUS */
+			AM62X_IOPAD(0x124, PIN_INPUT, 7) /* (A23) MMC2_SDCD.GPIO0_71 */
+		>;
+	};
+
+	main_usb1_hub_pins: main-usb1-hub-pins {
+		pinctrl-single,pins = <
+			/* (B15) UART0_RTSn.GPIO1_23 - USB_HUB_RESET */
+			AM62X_IOPAD(0x01d4, PIN_OUTPUT, 7)
+		>;
+	};
+
+	pwm_fan_pins: pwm-fan-pins {
+		pinctrl-single,pins = <
+			/* (C13) SPI0_CS1.EHRPWM0_B - FAN_PWM */
+			AM62X_IOPAD(0x01b8, PIN_OUTPUT, 2)
+			/* (A18) EXT_REFCLK1.GPIO1_30 - FAN_RPM */
+			AM62X_IOPAD(0x01f0, PIN_INPUT, 7)
+		>;
+	};
+
+	reg_3v3_sd_pins: reg-3v3-sd-pins {
+		bootph-all;
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x198, PIN_OUTPUT, 7) /* (A19) MCASP0_AXR2.GPIO1_8 */
+		>;
+	};
+
+	reg_lvds_pwr_pins: reg-lvds-pwr-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x00f8, PIN_OUTPUT, 7) /* (AB24) VOUT0_HSYNC.GPIO0_61 */
+		>;
+	};
+
+	reg_pwm_fan_pins: reg-pwm-fan-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x00fc, PIN_OUTPUT, 7) /* (Y20) VOUT0_DE.GPIO0_62 */
+		>;
+	};
+
+	reg_sd_pins: reg-sd-pins {
+		bootph-all;
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x07c, PIN_OUTPUT, 7) /* (P25) GPMC0_CLK.GPIO0_31 */
+		>;
+	};
+};
+
+&mcu_pmx0 {
+	mcu_gpio0_pins: mcu-gpio0-pins {
+		pinctrl-single,pins = <
+			/* (E8) MCU_SPI0_CS0.MCU_GPIO0_0 - EN_DIG_OUT1 */
+			AM62X_MCU_IOPAD(0x000, PIN_OUTPUT, 7)
+			/* (B8) MCU_SPI0_CS1.MCU_GPIO0_1 - EN_DIG_OUT2 */
+			AM62X_MCU_IOPAD(0x004, PIN_OUTPUT, 7)
+			/* (A7) MCU_SPI0_CLK.MCU_GPIO0_2 - STATUS_OUT1 */
+			AM62X_MCU_IOPAD(0x008, PIN_INPUT, 7)
+			/* (D9) MCU_SPI0_D0.MCU_GPIO0_3 - STATUS_OUT2 */
+			AM62X_MCU_IOPAD(0x00c, PIN_INPUT, 7)
+			/* (C9) MCU_SPI0_D1.MCU_GPIO0_4 - EN_DIG_OUT3 */
+			AM62X_MCU_IOPAD(0x010, PIN_OUTPUT, 7)
+			/* (C6) WKUP_UART0_CTSn.MCU_GPIO0_11 - EN_DIG_OUT4 */
+			AM62X_MCU_IOPAD(0x02c, PIN_OUTPUT, 7)
+			/* (A4) WKUP_UART0_RTSn.MCU_GPIO0_12 - STATUS_OUT3 */
+			AM62X_MCU_IOPAD(0x030, PIN_INPUT, 7)
+			/* (A8) MCU_I2C0_SCL.MCU_GPIO0_17 - STATUS_OUT4 */
+			AM62X_MCU_IOPAD(0x044, PIN_INPUT, 7)
+			/* (D10) MCU_I2C0_SDA.MCU_GPIO0_18 - DIG_IN_1 */
+			AM62X_MCU_IOPAD(0x048, PIN_INPUT, 7)
+			/* (B9) WKUP_I2C0_SCL.MCU_GPIO0_19 - DIG_IN_2 */
+			AM62X_MCU_IOPAD(0x04c, PIN_INPUT, 7)
+			/* (A9) WKUP_I2C0_SDA.MCU_GPIO0_20 - DIG_IN_3 */
+			AM62X_MCU_IOPAD(0x050, PIN_INPUT, 7)
+			/* (A12) WKUP_CLKOUT0.MCU_GPIO0_23 - DIG_IN_4 */
+			AM62X_MCU_IOPAD(0x084, PIN_INPUT, 7)
+			/* (A6) MCU_UART0_CTSn.MCU_GPIO0_7 - V_VPP_EN */
+			AM62X_MCU_IOPAD(0x01c, PIN_OUTPUT, 7)
+		>;
+	};
+	mcu_mcan0_pins: mcu-mcan0-pins {
+		pinctrl-single,pins = <
+			AM62X_MCU_IOPAD(0x038, PIN_INPUT, 0) /* (B3) MCU_MCAN0_RX */
+			AM62X_MCU_IOPAD(0x034, PIN_OUTPUT, 0) /* (D6) MCU_MCAN0_TX */
+		>;
+	};
+
+	mcu_mcan1_pins: mcu-mcan1-pins {
+		pinctrl-single,pins = <
+			AM62X_MCU_IOPAD(0x040, PIN_INPUT, 0) /* (D4) MCU_MCAN1_RX */
+			AM62X_MCU_IOPAD(0x03c, PIN_OUTPUT, 0) /* (E5) MCU_MCAN1_TX */
+		>;
+	};
+
+	mcu_uart0_pins: mcu-uart0-pins {
+		pinctrl-single,pins = <
+			AM62X_MCU_IOPAD(0x014, PIN_INPUT, 0) /* (B5) MCU_UART0_RXD */
+			AM62X_MCU_IOPAD(0x018, PIN_OUTPUT, 0) /* (A5) MCU_UART0_TXD */
+			AM62X_MCU_IOPAD(0x020, PIN_OUTPUT, 0) /* (B6) MCU_UART0_RTS# */
+		>;
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am625-tqma62xx.dtsi b/arch/arm64/boot/dts/ti/k3-am625-tqma62xx.dtsi
new file mode 100644
index 0000000000000..df6d167c29eb2
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am625-tqma62xx.dtsi
@@ -0,0 +1,319 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (C) 2021-2022 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (c) 2023-2024 TQ-Systems GmbH <linux@ew.tq-group.com>, D-82229 Seefeld, Germany.
+ * Author: Matthias Schiffer
+ */
+
+#include "k3-am625.dtsi"
+
+/ {
+	aliases {
+		i2c0 = &main_i2c0;
+		mmc0 = &sdhci0;
+		spi0 = &ospi0;
+	};
+
+	memory@80000000 {
+		bootph-pre-ram;
+		device_type = "memory";
+		/* 1G RAM */
+		reg = <0x00000000 0x80000000 0x00000000 0x40000000>;
+	};
+
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ramoops@9c700000 {
+			compatible = "ramoops";
+			reg = <0x00 0x9c700000 0x00 0x00100000>;
+			record-size = <0x8000>;
+			console-size = <0x8000>;
+			ftrace-size = <0x00>;
+			pmsg-size = <0x8000>;
+		};
+
+		/* global cma region */
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x00 0x8000000>;
+			linux,cma-default;
+		};
+
+		rtos_ipc_memory_region: memory@9c800000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9c800000 0x00 0x00300000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_dma_memory_region: memory@9da00000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9da00000 0x00 0x100000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_memory_region: memory@9db00000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9db00000 0x00 0xc00000>;
+			no-map;
+		};
+
+		secure_tfa_ddr: tfa@9e780000 {
+			reg = <0x00 0x9e780000 0x00 0x80000>;
+			alignment = <0x1000>;
+			no-map;
+		};
+
+		secure_ddr: optee@9e800000 {
+			reg = <0x00 0x9e800000 0x00 0x01800000>; /* for OP-TEE */
+			alignment = <0x1000>;
+			no-map;
+		};
+	};
+
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "V_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	reg_sd: regulator-sd {
+		/* Output of TPS6521902RSM */
+		compatible = "regulator-gpio";
+		regulator-name = "V_VDDSHV5";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		vin-supply = <&reg_ldo1>;
+		states = <1800000 0x0>,
+			 <3300000 0x1>;
+		/* Controlling GPIO set by base board */
+		status = "disabled";
+	};
+};
+
+&main_i2c0 {
+	bootph-pre-ram;
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c0_pins>;
+	clock-frequency = <400000>;
+	status = "okay";
+
+	tps65219: pmic@30 {
+		compatible = "ti,tps65219";
+		reg = <0x30>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_irq_pins>;
+		interrupt-parent = <&gic500>;
+		interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		buck1-supply = <&reg_3v3>;
+		buck2-supply = <&reg_3v3>;
+		buck3-supply = <&reg_3v3>;
+		ldo1-supply = <&reg_3v3>;
+		ldo2-supply = <&reg_buck2>;
+		ldo3-supply = <&reg_3v3>;
+		ldo4-supply = <&reg_3v3>;
+		system-power-controller;
+		ti,power-button;
+
+		regulators {
+			reg_buck1: buck1 {
+				regulator-name = "V_VDD_CORE";
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <750000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_buck2: buck2 {
+				regulator-name = "V_1V8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_buck3: buck3 {
+				regulator-name = "V_1V1";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_ldo1: ldo1 {
+				/* Actual voltage of LDO1 is controlled by GPIO, see reg_sd */
+				regulator-name = "V_VDDSHV5_3V3";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-allow-bypass;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_ldo2: ldo2 {
+				regulator-name = "V_0V85";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_ldo3: ldo3 {
+				regulator-name = "V_1V8A";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_ldo4: ldo4 {
+				/* Unused */
+				regulator-name = "V_VLDO4";
+				regulator-boot-on;
+			};
+		};
+	};
+
+	tmp1075: temperature-sensor@4a {
+		compatible = "ti,tmp1075";
+		reg = <0x4a>;
+		vs-supply = <&reg_buck2>;
+	};
+
+	eeprom0: eeprom@50 {
+		bootph-pre-ram;
+		compatible = "st,24c02", "atmel,24c02";
+		reg = <0x50>;
+		vcc-supply = <&reg_buck2>;
+		pagesize = <16>;
+		read-only;
+	};
+
+	pcf85063: rtc@51 {
+		compatible = "nxp,pcf85063a";
+		reg = <0x51>;
+		quartz-load-femtofarads = <12500>;
+	};
+
+	eeprom1: eeprom@54 {
+		compatible = "st,24c64", "atmel,24c64";
+		reg = <0x54>;
+		vcc-supply = <&reg_buck2>;
+		pagesize = <32>;
+	};
+};
+
+&ospi0 {
+	bootph-all;
+	pinctrl-names = "default";
+	pinctrl-0 = <&ospi0_pins>;
+	status = "okay";
+
+	flash@0 {
+		bootph-all;
+		compatible = "jedec,spi-nor";
+		reg = <0x0>;
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+		spi-max-frequency = <84000000>;
+		cdns,tshsl-ns = <60>;
+		cdns,tsd2d-ns = <60>;
+		cdns,tchsh-ns = <60>;
+		cdns,tslch-ns = <60>;
+		cdns,read-delay = <2>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			/* Filled by bootloader */
+		};
+	};
+};
+
+&sdhci0 {
+	bootph-all;
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mmc0_pins>;
+	non-removable;
+	disable-wp;
+	no-sd;
+	no-sdio;
+	ti,driver-strength-ohm = <50>;
+	status = "okay";
+};
+
+&wkup_rtc0 {
+	/*
+	 * Erratum i2327: We can't guarantee that the TQMa62xx will boot fast
+	 * enough for U-Boot to apply the workaround within one second after
+	 * power-on. Keep the RTC disabled to avoid RTC interrupt issues.
+	 *
+	 * The external RTC of the TQMa62xx should be used instead.
+	 *
+	 * If needed, the RTC can be enabled in a baseboard DTS, as long as
+	 * boot is fast enough on all relevant boot media.
+	 */
+	status = "disabled";
+};
+
+&main_pmx0 {
+	main_i2c0_pins: main-i2c0-pins {
+		bootph-pre-ram;
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x1e0, PIN_INPUT, 0) /* (B16) I2C0_SCL */
+			AM62X_IOPAD(0x1e4, PIN_INPUT, 0) /* (A16) I2C0_SDA */
+		>;
+	};
+
+	main_mmc0_pins: main-mmc0-pins {
+		bootph-all;
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x220, PIN_INPUT, 0) /* (Y3) MMC0_CMD */
+			AM62X_IOPAD(0x218, PIN_INPUT, 0) /* (AB1) MMC0_CLK */
+			AM62X_IOPAD(0x214, PIN_INPUT, 0) /* (AA2) MMC0_DAT0 */
+			AM62X_IOPAD(0x210, PIN_INPUT, 0) /* (AA1) MMC0_DAT1 */
+			AM62X_IOPAD(0x20c, PIN_INPUT, 0) /* (AA3) MMC0_DAT2 */
+			AM62X_IOPAD(0x208, PIN_INPUT, 0) /* (Y4) MMC0_DAT3 */
+			AM62X_IOPAD(0x204, PIN_INPUT, 0) /* (AB2) MMC0_DAT4 */
+			AM62X_IOPAD(0x200, PIN_INPUT, 0) /* (AC1) MMC0_DAT5 */
+			AM62X_IOPAD(0x1fc, PIN_INPUT, 0) /* (AD2) MMC0_DAT6 */
+			AM62X_IOPAD(0x1f8, PIN_INPUT, 0) /* (AC2) MMC0_DAT7 */
+		>;
+	};
+
+	ospi0_pins: ospi0-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x000, PIN_OUTPUT, 0) /* (H24) OSPI0_CLK */
+			AM62X_IOPAD(0x02c, PIN_OUTPUT, 0) /* (F23) OSPI0_CSn0 */
+			AM62X_IOPAD(0x00c, PIN_INPUT, 0) /* (E25) OSPI0_D0 */
+			AM62X_IOPAD(0x010, PIN_INPUT, 0) /* (G24) OSPI0_D1 */
+			AM62X_IOPAD(0x014, PIN_INPUT, 0) /* (F25) OSPI0_D2 */
+			AM62X_IOPAD(0x018, PIN_INPUT, 0) /* (F24) OSPI0_D3 */
+			AM62X_IOPAD(0x01c, PIN_INPUT, 0) /* (J23) OSPI0_D4 */
+			AM62X_IOPAD(0x020, PIN_INPUT, 0) /* (J25) OSPI0_D5 */
+			AM62X_IOPAD(0x024, PIN_INPUT, 0) /* (H25) OSPI0_D6 */
+			AM62X_IOPAD(0x028, PIN_INPUT, 0) /* (J22) OSPI0_D7 */
+			AM62X_IOPAD(0x008, PIN_INPUT, 0) /* (J24) OSPI0_DQS */
+			AM62X_IOPAD(0x004, PIN_INPUT, 0) /* (G25) OSPI0_LBCLKO */
+		>;
+	};
+
+	pmic_irq_pins: pmic-irq-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x01f4, PIN_INPUT_PULLUP, 0) /* (D16) EXTINTn */
+		>;
+	};
+};
+
+#include "k3-am62-ti-ipc-firmware.dtsi"
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/



Return-Path: <linux-kernel+bounces-647894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 587DCAB6F03
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 17:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13BA616E653
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 15:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0739E27AC3A;
	Wed, 14 May 2025 15:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="cbreNX6i"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9231E5213;
	Wed, 14 May 2025 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747235292; cv=none; b=ikiJgzUPGMZ8ilfLC7KvL8Mbwh0ZBYiYsY686DcZZknpfcfzSzMcfq8Dlsi2YW2517sydezMR2Ny1KDVi60sWYCfRovSyBwfm5LPtJZsjdDP4ufixJmMppwP00aUkiXPUpfzocJbNOqRWVZ3aUj6FWhMK7TaFWWfVHJctZRIFxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747235292; c=relaxed/simple;
	bh=Z2k+Z3ej+xBBSlI+v5A/FT6JPN3k1dR1YS9RIx2vmrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VRHg2bKjYTgxHegY7tbqRjDNLSB4orxBpu6cUI+PWhn8an3UdMaFeW9FjBoQy+tbMz5fIax39mnmtXSxtAF5WW/FD8RCy3b+MCii1pI/IfLYU2BdhfJ7BkwahewK+dcA7fi9CGCpNwNZY41It+0Xav0G/+HcuPJQMdkEYfRsheg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=cbreNX6i; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Drf+NVrVuz8HdLieCwaETCrvT5VW/a6sghwm+qTJzWg=; b=cbreNX6iIiLWQZ+zDS8RTJYuS7
	krv7lSwz5rhhB2FAUxleRZgwGQGBnn/K++9g4EF3fE/GK4EFGIZuHsnzUE/QGK0p0dOyUHF50O4KW
	BN7ZNIl8ny/iclMCRllL0Fn/6bSUG1cAa6MutXCAuovX1OB7TcXJ2t+EwP7IOd/22zq/2lRudboKj
	BX/0bMG3uoCiWCrKnVOl0sfkQJ5lU3mcyYjMzMki1tlU8EktyDCtPAm9B8JGxS0/93ayEP1dvpMdQ
	nXkRhKSYHFwTcZ/0G+zEr4GZnoAhTgtKCTLCkuRuwaOOH3Y3YaKURDzKPlnge95vnvv4yvR/hd8ml
	kTluc3Ig==;
Received: from i53875a50.versanet.de ([83.135.90.80] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uFDiA-0006vE-CB; Wed, 14 May 2025 17:07:58 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@cherry.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH v4 6/6] arm64: dts: rockchip: add px30-pp1516 base dtsi and board variants
Date: Wed, 14 May 2025 17:07:45 +0200
Message-ID: <20250514150745.2437804-7-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250514150745.2437804-1-heiko@sntech.de>
References: <20250514150745.2437804-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

PP1516 are Touchscreen devices built around the PX30 SoC and companion
devices to PX30-Cobra, again with multiple display options.

The devices feature an EMMC, OTG port and a 720x1280 display with a
touchscreen and camera

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm64/boot/dts/rockchip/Makefile         |   2 +
 .../rockchip/px30-pp1516-ltk050h3146w-a2.dts  |  39 ++
 .../dts/rockchip/px30-pp1516-ltk050h3148w.dts |  39 ++
 arch/arm64/boot/dts/rockchip/px30-pp1516.dtsi | 602 ++++++++++++++++++
 4 files changed, 682 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-pp1516-ltk050h3146w-a2.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-pp1516-ltk050h3148w.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-pp1516.dtsi

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 8151e8bb1cd3..899113f88a29 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -8,6 +8,8 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-engicam-px30-core-ctouch2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-engicam-px30-core-ctouch2-of10.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-engicam-px30-core-edimm2.2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-firefly-jd4-core-mb.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-pp1516-ltk050h3146w-a2.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-pp1516-ltk050h3148w.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-ringneck-haikou.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-ringneck-haikou-lvds-9904379.dtbo
 dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-ringneck-haikou-video-demo.dtbo
diff --git a/arch/arm64/boot/dts/rockchip/px30-pp1516-ltk050h3146w-a2.dts b/arch/arm64/boot/dts/rockchip/px30-pp1516-ltk050h3146w-a2.dts
new file mode 100644
index 000000000000..b71929bcb33e
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/px30-pp1516-ltk050h3146w-a2.dts
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2025 Cherry Embedded Solutions GmbH
+ */
+
+/dts-v1/;
+#include "px30-pp1516.dtsi"
+
+/ {
+	model = "Theobroma Systems PP-1516 with LTK050H3146W-A2 Display";
+	compatible = "tsd,px30-pp1516-ltk050h3146w-a2", "tsd,px30-pp1516", "rockchip,px30";
+};
+
+&dsi {
+	status = "okay";
+
+	panel@0 {
+		compatible = "leadtek,ltk050h3146w-a2";
+		reg = <0>;
+		backlight = <&backlight>;
+		iovcc-supply = <&vcc_1v8>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&dsp_rst>;
+		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
+		vci-supply = <&vcc_2v8>;
+
+		port {
+			mipi_in_panel: endpoint {
+				remote-endpoint = <&mipi_out_panel>;
+			};
+		};
+	};
+};
+
+&dsi_out {
+	mipi_out_panel: endpoint {
+		remote-endpoint = <&mipi_in_panel>;
+	};
+};
diff --git a/arch/arm64/boot/dts/rockchip/px30-pp1516-ltk050h3148w.dts b/arch/arm64/boot/dts/rockchip/px30-pp1516-ltk050h3148w.dts
new file mode 100644
index 000000000000..a9bd5936c701
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/px30-pp1516-ltk050h3148w.dts
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2025 Cherry Embedded Solutions GmbH
+ */
+
+/dts-v1/;
+#include "px30-pp1516.dtsi"
+
+/ {
+	model = "Theobroma Systems PP-1516 with LTK050H3148W Display";
+	compatible = "tsd,px30-pp1516-ltk050h3148w", "tsd,px30-pp1516", "rockchip,px30";
+};
+
+&dsi {
+	status = "okay";
+
+	panel@0 {
+		compatible = "leadtek,ltk050h3148w";
+		reg = <0>;
+		backlight = <&backlight>;
+		iovcc-supply = <&vcc_1v8>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&dsp_rst>;
+		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
+		vci-supply = <&vcc_2v8>;
+
+		port {
+			mipi_in_panel: endpoint {
+				remote-endpoint = <&mipi_out_panel>;
+			};
+		};
+	};
+};
+
+&dsi_out {
+	mipi_out_panel: endpoint {
+		remote-endpoint = <&mipi_in_panel>;
+	};
+};
diff --git a/arch/arm64/boot/dts/rockchip/px30-pp1516.dtsi b/arch/arm64/boot/dts/rockchip/px30-pp1516.dtsi
new file mode 100644
index 000000000000..3f9a133d7373
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/px30-pp1516.dtsi
@@ -0,0 +1,602 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2025 Cherry Embedded Solutions GmbH
+ */
+
+/dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+#include "px30.dtsi"
+
+/ {
+	aliases {
+		mmc0 = &emmc;
+	};
+
+	chosen {
+		stdout-path = "serial5:115200n8";
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		power-supply = <&vcc5v0_sys>;
+		pwms = <&pwm0 0 25000 0>;
+	};
+
+	beeper {
+		compatible = "pwm-beeper";
+		pwms = <&pwm1 0 1000 0>;
+	};
+
+	emmc_pwrseq: emmc-pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		pinctrl-0 = <&emmc_reset>;
+		pinctrl-names = "default";
+		reset-gpios = <&gpio1 RK_PB3 GPIO_ACTIVE_HIGH>;
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&debug_led_pin>, <&heartbeat_led_pin>;
+
+		/*
+		 * LED2 on the PCB, left of the USB-C connector.
+		 * Typically NOT populated.
+		 */
+		debug: led-0 {
+			label = "debug";
+			gpios = <&gpio3 RK_PC3 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "none";
+		};
+
+		/*
+		 * LED14 on the PCB, left of the PX30 SoC.
+		 * Typically NOT populated.
+		 */
+		heartbeat: led-1 {
+			label = "heartbeat";
+			gpios = <&gpio0 RK_PA0 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	vcc5v0_sys: regulator-vccsys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	vcc_cam_avdd: regulator-vcc-cam-avdd {
+		compatible  = "regulator-fixed";
+		regulator-name = "vcc_cam_avdd";
+		gpio = <&gpio3 RK_PC0 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&cam_avdd_en>;
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		vin-supply = <&vcc_2v8>;
+	};
+
+	vcc_cam_dovdd: regulator-vcc-cam-dovdd {
+		compatible  = "regulator-fixed";
+		regulator-name = "vcc_cam_dovdd";
+		gpio = <&gpio3 RK_PC1 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&cam_dovdd_en>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_1v8>;
+	};
+
+	vcc_cam_dvdd: regulator-vcc-cam-dvdd {
+		compatible  = "regulator-fixed";
+		regulator-name = "vcc_cam_dvdd";
+		gpio = <&gpio3 RK_PC5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		pinctrl-names = "default";
+		pinctrl-0 = <&cam_dvdd_en>;
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		vin-supply = <&vcc_3v3>;
+	};
+
+	vcc_lens_afvdd: regulator-vcc-lens-afvdd {
+		compatible  = "regulator-fixed";
+		regulator-name = "vcc_lens_afvdd";
+		gpio = <&gpio3 RK_PB2 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&cam_afvdd_en>;
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		vin-supply = <&vcc_2v8>;
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu1 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu2 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu3 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&csi_dphy {
+	status = "okay";
+};
+
+&display_subsystem {
+	status = "okay";
+};
+
+&dsi_dphy {
+	status = "okay";
+};
+
+&emmc {
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	/*
+	 * For hs200 support, U-Boot would have to set the RK809 DCDC4
+	 * rail to 1.8V from the default of 3.0V. It doesn't do that on
+	 * devices out in the field, so disable hs200.
+	 * mmc-hs200-1_8v;
+	 */
+	mmc-pwrseq = <&emmc_pwrseq>;
+	non-removable;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&vcc_emmc>;
+	status = "okay";
+};
+
+&gpu {
+	mali-supply = <&vdd_log>;
+	status = "okay";
+};
+
+/* I2C0 = PMIC, Touchscreen */
+&i2c0 {
+	status = "okay";
+
+	touchscreen@14 {
+		compatible = "goodix,gt911";
+		reg = <0x14>;
+		AVDD28-supply = <&vcc_2v8>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA1 IRQ_TYPE_LEVEL_LOW>;
+		irq-gpios = <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&tch_int &tch_rst>;
+		reset-gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
+		VDDIO-supply = <&vcc_3v3>;
+	};
+
+	rk809: pmic@20 {
+		compatible = "rockchip,rk809";
+		reg = <0x20>;
+		#clock-cells = <0>;
+		clock-output-names = "xin32k";
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA7 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_int>;
+		system-power-controller;
+		wakeup-source;
+
+		vcc1-supply = <&vcc5v0_sys>;
+		vcc2-supply = <&vcc5v0_sys>;
+		vcc3-supply = <&vcc5v0_sys>;
+		vcc4-supply = <&vcc5v0_sys>;
+		vcc5-supply = <&vcc_3v3>;
+		vcc6-supply = <&vcc_3v3>;
+		vcc7-supply = <&vcc_3v3>;
+		vcc9-supply = <&vcc5v0_sys>;
+
+		regulators {
+			vdd_log: DCDC_REG1 {
+				regulator-name = "vdd_log";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <950000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <950000>;
+				};
+			};
+
+			vdd_arm: DCDC_REG2 {
+				regulator-name = "vdd_arm";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <950000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <950000>;
+				};
+			};
+
+			vcc_ddr: DCDC_REG3 {
+				regulator-name = "vcc_ddr";
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vcc_3v0_1v8: vcc_emmc: DCDC_REG4 {
+				regulator-name = "vcc_3v0_1v8";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3000000>;
+				};
+			};
+
+			vcc_3v3: DCDC_REG5 {
+				regulator-name = "vcc_3v3";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vcc_1v8: LDO_REG2 {
+				regulator-name = "vcc_1v8";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vcc_1v0: LDO_REG3 {
+				regulator-name = "vcc_1v0";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1000000>;
+				};
+			};
+
+			vcc_2v8: LDO_REG4 {
+				regulator-name = "vcc_2v8";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <2800000>;
+				};
+			};
+
+			vccio_sd: LDO_REG5 {
+				regulator-name = "vccio_sd";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3000000>;
+				};
+			};
+
+			vcc_sdio: LDO_REG6 {
+				regulator-name = "vcc_sdio";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vcc_lcd: LDO_REG7 {
+				regulator-name = "vcc_lcd";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <1000000>;
+				};
+			};
+
+			vcc_1v8_lcd: LDO_REG8 {
+				regulator-name = "vcc_1v8_lcd";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vcca_1v8: LDO_REG9 {
+				regulator-name = "vcca_1v8";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+		};
+	};
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	status = "okay";
+};
+
+/* I2C2 = Accelerometer + Camera */
+&i2c2 {
+	/* MEMSIC MXC4005 accelerometer is rated for I2C Fast Mode (<=400KHz) */
+	/* OmniVision OV5675 camera is rated for I2C Fast Mode (<=400KHz) */
+	clock-frequency = <400000>;
+	status = "okay";
+
+	focus: focus@c {
+		compatible = "dongwoon,dw9714";
+		reg = <0xc>;
+		vcc-supply = <&vcc_lens_afvdd>;
+	};
+
+	accel@15 {
+		compatible = "memsic,mxc4005";
+		reg = <0x15>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <RK_PB4 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&accel_int>;
+	};
+
+	camera@36 {
+		compatible = "ovti,ov5675";
+		reg = <0x36>;
+		clocks = <&cru SCLK_CIF_OUT>;
+		assigned-clocks = <&cru SCLK_CIF_OUT>;
+		assigned-clock-rates = <19200000>;
+		avdd-supply = <&vcc_cam_avdd>;
+		dvdd-supply = <&vcc_cam_dvdd>;
+		dovdd-supply = <&vcc_cam_dovdd>;
+		lens-focus = <&focus>;
+		orientation = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&cif_clkout_m0 &cam_pwdn>;
+		reset-gpios = <&gpio2 RK_PB0 GPIO_ACTIVE_LOW>;
+		rotation = <0>;
+
+		port {
+			ucam_out: endpoint {
+				remote-endpoint = <&mipi_in_ucam>;
+				data-lanes = <1 2>;
+				link-frequencies = /bits/ 64 <450000000>;
+			};
+		};
+	};
+};
+
+&io_domains {
+	vccio1-supply = <&vcc_sdio>;
+	vccio2-supply = <&vccio_sd>;
+	vccio3-supply = <&vcc_1v8>;
+	vccio4-supply = <&vcc_3v3>;
+	vccio5-supply = <&vcc_3v3>;
+	vccio6-supply = <&vcc_emmc>;
+	status = "okay";
+};
+
+&isp {
+	status = "okay";
+
+	ports {
+		port@0 {
+			mipi_in_ucam: endpoint@0 {
+				reg = <0>;
+				data-lanes = <1 2>;
+				remote-endpoint = <&ucam_out>;
+			};
+		};
+	};
+};
+
+&isp_mmu {
+	status = "okay";
+};
+
+&pinctrl {
+	accel {
+		accel_int: accel-int {
+			rockchip,pins =
+				<2 RK_PB4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	camera {
+		cam_afvdd_en: cam-afvdd-en {
+			rockchip,pins =
+				<3 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		cam_avdd_en: cam-avdd-en {
+			rockchip,pins =
+				<3 RK_PC0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		cam_dovdd_en: cam-dovdd-en {
+			rockchip,pins =
+				<3 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		cam_dvdd_en: cam-dvdd-en {
+			rockchip,pins =
+				<3 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		cam_pwdn: cam-pwdn {
+			rockchip,pins =
+				<2 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	emmc {
+		emmc_reset: emmc-reset {
+			rockchip,pins =
+				<1 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	leds {
+		debug_led_pin: debug-led-pin {
+			rockchip,pins =
+				<3 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		heartbeat_led_pin: heartbeat-led-pin {
+			rockchip,pins =
+				<0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	panel {
+		dsp_rst: dsp-rst {
+			rockchip,pins =
+				<0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
+		tch_int: tch-int {
+			rockchip,pins =
+				<0 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		tch_rst: tch-rst {
+			rockchip,pins =
+				<0 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	pmic {
+		pmic_int: pmic-int {
+			rockchip,pins =
+				<0 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+};
+
+&pmu_io_domains {
+	pmuio1-supply = <&vcc_3v3>;
+	pmuio2-supply = <&vcc_3v3>;
+	status = "okay";
+};
+
+&pwm0 {
+	status = "okay";
+};
+
+&pwm1 {
+	status = "okay";
+};
+
+&saradc {
+	vref-supply = <&vcc_1v8>;
+	status = "okay";
+};
+
+&tsadc {
+	status = "okay";
+};
+
+&u2phy {
+	status = "okay";
+};
+
+&u2phy_host {
+	status = "okay";
+};
+
+&u2phy_otg {
+	status = "okay";
+};
+
+&uart5 {
+	pinctrl-0 = <&uart5_xfer>;
+	status = "okay";
+};
+
+&usb20_otg {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
+
+&vopb {
+	status = "okay";
+};
+
+&vopb_mmu {
+	status = "okay";
+};
+
+&wdt {
+	status = "okay";
+};
-- 
2.47.2



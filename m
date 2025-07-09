Return-Path: <linux-kernel+bounces-724566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE76AFF468
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 264873AB77F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F12251793;
	Wed,  9 Jul 2025 22:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiRRSvL+"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EAD24EA90;
	Wed,  9 Jul 2025 22:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752098888; cv=none; b=fxI7oy+yGaiOovJ8nU848TFEyT4rFx88vrqda4Mh8eTTTi2rRx0XjegI9JmKiF39Lyton1727RX1JbnEOE0s0X2bXel6cJ0aiXDHFmA91pFKL3pVvK0O0lAZoIGB7QP/VguleXYM/IitINNYCVicYdaV8KvUZb98BVxP6KgKESU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752098888; c=relaxed/simple;
	bh=rJWiQcVI1CNZaMoEK5k1d9UihfFjxn+pGyO5aS18Wnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ze43tXmNZXcr8ZOf8ibAArDVIkgiX9tiguImz8+SYm/S3iiosGXgtn2BtNvdOytSRAbKeq9pB8SELiFQomMm3uw423RexFVPqOyq5g8sknT84DXMyaaVmOGTJrn8i49URWH9FJvuoHp0Bh4A0iKWXZaKvm1UhjupZKKR7pReePQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WiRRSvL+; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae04d3d63e6so52751066b.2;
        Wed, 09 Jul 2025 15:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752098884; x=1752703684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WN3/NRlumLNf+Ilny9QPev+JuOpqmQonm9TX080d5u0=;
        b=WiRRSvL+xq2FOlGOuoNAcZQl6o6GheeErLndENRR2byFPWOXNXhtB2SH/3byVu4/Sa
         aEd8vL4D6VxWsFjwze4XywgM9sK43mY+FHA2b32E4liC8nIehRhVOWMd/mr0NzSOQz+X
         cxTzaJAMH7xxYzB/YOwIRIEyNveZdf0oNrSCA5AL0SzIBIYpsJMIxYpY7LIyOILoGn3x
         GCv6MQ+OYregpO1+1TY3D8m56HWCBh+KG4wFIp/ywqRidWxeKUaEI41lYgGZfhvBjX0C
         VPR0pzm61lZRc+CSjv/ot2Z2qOVbFIaRXAQGmDD2G48s4zzovQgRZhjd9/MxB5IodJGF
         7eYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752098884; x=1752703684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WN3/NRlumLNf+Ilny9QPev+JuOpqmQonm9TX080d5u0=;
        b=FwqF1Rrw0f2rb2hVXaTBAhMMiz6pTMRZOa2lkae3M44DMBkwBU/N5xkIWTnU6vbm2R
         bfVJtd9mHhIFLpdsl6oUA/fF2jBeBlwyE9jKDJBnhxCajdXHG6ke3SeDx6ELfsMOiyq3
         hzcebre1Mn75pQeSG7BiQGzYvufmRfFXNbFlT4k92jT4GLNf8Gmx+gXW8pbuR6MHcI+A
         Es4W3FVEWCmzlaCKIY11R6GQhDU6vqgR+62dM/XVqudK3Lm+hxP7fi+5WwTEEPV8CXmX
         D8yofBeUBrydlg3pjlINE56f+/oyeiPIdiBGTOFbYy12r9XdzLyvql6n7A+mfsC+Tvko
         l7LA==
X-Forwarded-Encrypted: i=1; AJvYcCXVTM1bWDFn5e+bl4vGcM6aQDQ875dkruCcx4tkEzaq1xScBCIvW5pei30nxeXpF2UFXfSp+Kj0/VTnNOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtczPG7Md8SMVa4XyQ5hlmBBihdh9add5JIsZIpEH8iV3x05uM
	i/zRkFyq5NabiTYWasHypyRVTWIqql4fqNh+GL2letoi7m5tkAfo4d0+YJOOmfTc
X-Gm-Gg: ASbGncuritoh/PeelI3VGgXQQ5+X/DSgi76xjGQan5CKyCMA0gF94+7OTIW1Kly5eWw
	HhoDd8jOEb+pkUNlRtk1rATxr/HSEw8fJu0JV2WVke/chKR+EU/M19F3gkIiju/A8J8x2tQwsxn
	4aJa+c6SFP8NtK2FAMmPPpJPpJmrCVT9EbudLveOyLkXA7nRlOhRkeO3Wk0fP6Nu1VhtnoJvXMm
	LxhKF4oF+OFuWg6k+f0YMagR8EiFxzIIOxtKAXEcc+C+rmkvzHrdb9KeBaCvZWlybOFL1IrHDNd
	mXUn9mr9yE5p3gO8ljpebP9MvFhKht+R+agPUQrCT5NRd+a4SGj3z+9ReC8oAQhr/6+uNQ2w1jX
	PRmhNQPQDR95mZXf69f+LILfYSH1lAjTkBl6DLEGnYXKMiQ==
X-Google-Smtp-Source: AGHT+IHCaDM4PpiRDQQDr2u7EGdvb0jmJXdArRmbc90iDOadT0pMcNpmJ5IpgDME7us7vvIsadIJhg==
X-Received: by 2002:a17:907:c8aa:b0:ae0:cc5f:88ef with SMTP id a640c23a62f3a-ae6e12566f6mr135330066b.32.1752098884013;
        Wed, 09 Jul 2025 15:08:04 -0700 (PDT)
Received: from Lord-Beerus.station (net-93-70-53-177.cust.vodafonedsl.it. [93.70.53.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8264fbcsm10520666b.75.2025.07.09.15.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 15:08:03 -0700 (PDT)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Stefano Radaelli <stefano.radaelli21@gmail.com>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/3] arm64: dts: ti: Add support for Variscite VAR-SOM-AM62P
Date: Thu, 10 Jul 2025 00:07:05 +0200
Message-ID: <20250709220714.85697-3-stefano.radaelli21@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709220714.85697-1-stefano.radaelli21@gmail.com>
References: <20250709220714.85697-1-stefano.radaelli21@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree support for the Variscite VAR-SOM-AM62P system on module.
This SOM is designed to be used with various carrier boards.

The module includes:
- AM62Px Sitara MPU processor
- Up to 8GB of DDR4-3733 memory
- eMMC storage memory
- PS6522430 chip as a Power Management Integrated circuit (PMIC)
- Integrated 10/100/1000 Mbps Ethernet Transceiver Analog Devices ADIN1300
- Resistive touch panel interface controller TI TSC2046
- I2C interfaces

Only SOM-specific peripherals are enabled by default. Carrier board
specific interfaces are left disabled to be enabled in the respective
carrier board device trees.

Link: https://www.variscite.it/product/system-on-module-som/cortex-a53-krait/var-som-am62p-ti-sitara-am62px/

Signed-off-by: Stefano Radaelli <stefano.radaelli21@gmail.com>
---
v2:
 - Fixed warnings and cleanup

 arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi | 374 ++++++++++++++++++
 1 file changed, 374 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi
new file mode 100644
index 000000000000..a12522e554fe
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi
@@ -0,0 +1,374 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Common dtsi for Variscite VAR-SOM-AM62P
+ *
+ * Copyright (C) 2021-2022 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2025 Variscite Ltd. - https://www.variscite.com/
+ *
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pwm/pwm.h>
+#include "k3-am62p5.dtsi"
+
+/ {
+	compatible = "variscite,am62p-var-som", "ti,am62p5";
+
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		post-power-on-delay-ms = <100>;
+		power-off-delay-us = <10000>;
+		reset-gpios = <&main_gpio0 54 GPIO_ACTIVE_LOW>,	/* WIFI_PWR_EN */
+			      <&main_gpio0 59 GPIO_ACTIVE_LOW>;	/* WIFI_EN */
+	};
+
+	mmc_pwrseq: mmc-pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_mmc_pwrseq>;
+		reset-gpios = <&main_gpio0 49 GPIO_ACTIVE_LOW>;
+	};
+
+	memory@80000000 {
+		/* 8G RAM */
+		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
+		      <0x00000008 0x80000000 0x00000001 0x80000000>;
+		device_type = "memory";
+		bootph-pre-ram;
+	};
+
+	opp-table {
+		/* Add 1.4GHz OPP for am62p5-sk board. Requires VDD_CORE at 0v85 */
+		opp-1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			opp-supported-hw = <0x01 0x0004>;
+			clock-latency-ns = <6000000>;
+		};
+	};
+
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		rtos_ipc_memory_region: rtos-ipc-memory@9b500000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9b500000 0x00 0x00300000>;
+			no-map;
+		};
+
+		mcu_r5fss0_core0_dma_memory_region: mcu-r5fss-dma-memory-region@9b800000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9b800000 0x00 0x00100000>;
+			no-map;
+		};
+
+		mcu_r5fss0_core0_memory_region: mcu-r5fss-memory-region@9b900000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9b900000 0x00 0x00f00000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9c800000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9c800000 0x00 0x00100000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_memory_region: r5f-memory@9c900000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9c900000 0x00 0x01e00000>;
+			no-map;
+		};
+
+		secure_tfa_ddr: tfa@9e780000 {
+			reg = <0x00 0x9e780000 0x00 0x80000>;
+			no-map;
+		};
+
+		secure_ddr: optee@9e800000 {
+			reg = <0x00 0x9e800000 0x00 0x01800000>; /* for OP-TEE */
+			no-map;
+		};
+	};
+
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "On-module +V3.3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	reg_1v8: regulator-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "On-module +V1.8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&reg_3v3>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	reg_3v3_phy: regulator-3v3-phy {
+		compatible = "regulator-fixed";
+		regulator-name = "On-module +V3.3_PHY";
+		gpios = <&main_gpio0 45 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+		status="okay";
+	};
+};
+
+&cpsw3g {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii1>;
+};
+
+&cpsw3g_mdio {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mdio1>;
+	cpsw3g_phy0: ethernet-phy@4 {
+		reg = <4>;
+		compatible = "ethernet-phy-id0283.bc30";
+		reset-gpios = <&main_gpio0 46 GPIO_ACTIVE_LOW>;
+		reset-assert-us = <10000>;
+		reset-deassert-us = <100000>;
+	};
+};
+
+&cpsw_port1 {
+	/*
+	 * The required RGMII TX and RX 2ns delays are implemented directly
+	 * in hardware via passive delay elements on the SOM PCB.
+	 * No delay configuration is needed in software via PHY driver.
+	 */
+	phy-mode = "rgmii";
+	phy-handle = <&cpsw3g_phy0>;
+	status = "okay";
+};
+
+&main_i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&main_i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&main_pmx0 {
+	pinctrl_mmc_pwrseq: main-emmc-pwrseq-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x00c8, PIN_OUTPUT, 7) /* (AB23) VOUT0_DATA4.GPIO0_49 */
+		>;
+	};
+
+	pinctrl_i2c2: main-i2c2-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x00b0, PIN_INPUT_PULLUP, 1) /* (T22) GPMC0_CSn2.I2C2_SCL */
+			AM62PX_IOPAD(0x00b4, PIN_INPUT_PULLUP, 1) /* (U25) GPMC0_CSn3.I2C2_SDA */
+		>;
+	};
+
+	pinctrl_i2c3: main-i2c3-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x01d0, PIN_INPUT_PULLUP, 2) /* (A23) UART0_CTSn.I2C3_SCL */
+			AM62PX_IOPAD(0x01d4, PIN_INPUT_PULLUP, 2) /* (C22) UART0_RTSn.I2C3_SDA */
+		>;
+	};
+
+	pinctrl_mcasp1: main-mcasp1-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0090, PIN_INPUT, 2) /* (U24) GPMC0_BE0n_CLE.MCASP1_ACLKX */
+			AM62PX_IOPAD(0x0098, PIN_INPUT, 2) /* (AA24) GPMC0_WAIT0.MCASP1_AFSX */
+			AM62PX_IOPAD(0x008c, PIN_OUTPUT, 2) /* (T25) GPMC0_WEn.MCASP1_AXR0 */
+			AM62PX_IOPAD(0x0084, PIN_INPUT, 2) /* (R25) GPMC0_ADVn_ALE.MCASP1_AXR2 */
+			AM62PX_IOPAD(0x00a0, PIN_OUTPUT, 1) /* (P24) GPMC0_WPn.AUDIO_EXT_REFCLK1 */
+		>;
+	};
+
+	pinctrl_mdio1: main-mdio1-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0160, PIN_OUTPUT, 0) /* (F17) MDIO0_MDC */
+			AM62PX_IOPAD(0x015c, PIN_INPUT, 0) /* (F16) MDIO0_MDIO */
+		>;
+	};
+
+	pinctrl_mmc2: main-mmc2-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0120, PIN_INPUT_PULLUP, 0) /* (K24) MMC2_CMD */
+			AM62PX_IOPAD(0x0118, PIN_INPUT_PULLDOWN, 0) /* (K21) MMC2_CLK */
+			AM62PX_IOPAD(0x011C, PIN_INPUT_PULLUP, 0) /* () MMC2_CLKLB */
+			AM62PX_IOPAD(0x0114, PIN_INPUT_PULLUP, 0) /* (K23) MMC2_DAT0 */
+			AM62PX_IOPAD(0x0110, PIN_INPUT_PULLUP, 0) /* (K22) MMC2_DAT1 */
+			AM62PX_IOPAD(0x010c, PIN_INPUT_PULLUP, 0) /* (L20) MMC2_DAT2 */
+			AM62PX_IOPAD(0x0108, PIN_INPUT_PULLUP, 0) /* (L21) MMC2_DAT3 */
+		>;
+	};
+
+	pinctrl_rgmii1: main-rgmii1-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x014c, PIN_INPUT, 0) /* (B15) RGMII1_RD0 */
+			AM62PX_IOPAD(0x0150, PIN_INPUT, 0) /* (B16) RGMII1_RD1 */
+			AM62PX_IOPAD(0x0154, PIN_INPUT, 0) /* (A14) RGMII1_RD2 */
+			AM62PX_IOPAD(0x0158, PIN_INPUT, 0) /* (B14) RGMII1_RD3 */
+			AM62PX_IOPAD(0x0148, PIN_INPUT, 0) /* (A16) RGMII1_RXC */
+			AM62PX_IOPAD(0x0144, PIN_INPUT, 0) /* (A15) RGMII1_RX_CTL */
+			AM62PX_IOPAD(0x0134, PIN_INPUT, 0) /* (A18) RGMII1_TD0 */
+			AM62PX_IOPAD(0x0138, PIN_INPUT, 0) /* (C17) RGMII1_TD1 */
+			AM62PX_IOPAD(0x013c, PIN_INPUT, 0) /* (A17) RGMII1_TD2 */
+			AM62PX_IOPAD(0x0140, PIN_INPUT, 0) /* (C16) RGMII1_TD3 */
+			AM62PX_IOPAD(0x0130, PIN_INPUT, 0) /* (B17) RGMII1_TXC */
+			AM62PX_IOPAD(0x012c, PIN_INPUT, 0) /* (B18) RGMII1_TX_CTL */
+		>;
+		bootph-all;
+	};
+
+	pinctrl_spi0: main-spi0-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x01bc, PIN_OUTPUT, 0) /* (B21) SPI0_CLK */
+			AM62PX_IOPAD(0x01b4, PIN_OUTPUT, 0) /* (D20) SPI0_CS0 */
+			AM62PX_IOPAD(0x01c0, PIN_OUTPUT, 0) /* (B20) SPI0_D0 */
+			AM62PX_IOPAD(0x01c4, PIN_INPUT, 0) /* (C21) SPI0_D1 */
+		>;
+	};
+
+	pinctrl_uart5: main-uart5-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x00ec, PIN_INPUT, 4) /* (AC21) VOUT0_DATA13.UART5_CTSn */
+			AM62PX_IOPAD(0x00e8, PIN_OUTPUT, 4) /* (AD21) VOUT0_DATA12.UART5_RTSn */
+			AM62PX_IOPAD(0x00d0, PIN_INPUT, 4) /* (AC23) VOUT0_DATA6.UART5_RXD */
+			AM62PX_IOPAD(0x00d4, PIN_OUTPUT, 4) /* (AE23) VOUT0_DATA7.UART5_TXD */
+		>;
+	};
+
+	pinctrl_bt: main-btgrp-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x00f4, PIN_OUTPUT, 7) /* (Y20) VOUT0_DATA15.GPIO0_60 (BT_EN) */
+		>;
+	};
+
+	pinctrl_restouch: main-restouch-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x00c4, PIN_INPUT_PULLUP, 7) /* (Y23) VOUT0_DATA3.GPIO0_48 */
+		>;
+	};
+
+	pinctrl_wifi: main-wifi-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x00dc, PIN_OUTPUT, 7) /* (AC22) VOUT0_DATA9.GPIO0_54 - WIFI_PWR_EN - */
+			AM62PX_IOPAD(0x00f0, PIN_OUTPUT, 7) /* (AA20) VOUT0_DATA14.GPIO0_59 - WIFI_EN - */
+		>;
+	};
+};
+
+&mcu_pmx0 {
+	pinctrl_wkup_clkout0: wkup-clkout0-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_MCU_IOPAD(0x0084, PIN_OUTPUT, 0) /* (F13) WKUP_CLKOUT0 */
+		>;
+	};
+};
+
+&main_spi0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi0>;
+	ti,pindir-d0-out-d1-in;
+
+	/* Resistive touch controller */
+	ads7846@0 {
+		compatible = "ti,ads7846";
+		reg = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_restouch>;
+		interrupt-parent = <&main_gpio0>;
+		interrupts = <48 IRQ_TYPE_EDGE_FALLING>;
+		spi-max-frequency = <1500000>;
+		pendown-gpio = <&main_gpio0 48 GPIO_ACTIVE_LOW>;
+		ti,x-min = /bits/ 16 <125>;
+		ti,x-max = /bits/ 16 <4008>;
+		ti,y-min = /bits/ 16 <282>;
+		ti,y-max = /bits/ 16 <3864>;
+		ti,x-plate-ohms = /bits/ 16 <180>;
+		ti,pressure-max = /bits/ 16 <255>;
+		ti,debounce-max = /bits/ 16 <10>;
+		ti,debounce-tol = /bits/ 16 <3>;
+		ti,debounce-rep = /bits/ 16 <1>;
+		ti,settle-delay-usec = /bits/ 16 <150>;
+		ti,keep-vref-on;
+		wakeup-source;
+		status = "okay";
+	};
+};
+
+&main_uart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart5>, <&pinctrl_bt>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "nxp,88w8987-bt";
+	};
+};
+
+&mcasp1 {
+	status = "okay";
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mcasp1>;
+	op-mode = <0>;          /* MCASP_IIS_MODE */
+	tdm-slots = <2>;
+	serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
+	       1 0 2 0
+	       0 0 0 0
+	       0 0 0 0
+	       0 0 0 0
+	>;
+	tx-num-evt = <0>;
+	rx-num-evt = <0>;
+};
+
+/* eMMC */
+&sdhci0 {
+	status = "okay";
+	ti,driver-strength-ohm = <50>;
+	mmc-pwrseq = <&mmc_pwrseq>;
+	disable-wp;
+	bootph-all;
+};
+
+/* WIFI */
+&sdhci2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mmc2>, <&pinctrl_wifi>;
+	bus-width = <4>;
+	disable-wp;
+	non-removable;
+	keep-power-in-suspend;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	ti,fails-without-test-cd;
+	status = "okay";
+};
+
+&usbss0 {
+	ti,vbus-divider;
+};
+
+&usbss1 {
+	ti,vbus-divider;
+};
-- 
2.43.0



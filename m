Return-Path: <linux-kernel+bounces-698548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EF1AE466C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 16:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7C0172C8F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 14:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5787F241668;
	Mon, 23 Jun 2025 14:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rnkWRbWM"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA0D14A0B7;
	Mon, 23 Jun 2025 14:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688024; cv=none; b=WXqubmXgj0l5uMFDXSoQQWkirxeOwVUvS1JuZ9wS9nP853u55+m4v29NB9qM+oCNMVfZbgLQsZ9gxo0b+jPoaWFSKp02811bjLRvrii2FbxRgWDZJ/+acNFQ/DXos1PAzYASIhBuzAhkLAuowNQqhbIorPDfL53rXp5WOJfbIAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688024; c=relaxed/simple;
	bh=jIW1Hc6ylu6cw4ZvJ0DkbB8wdSaMS96CKw6z0FYODiU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hv7JIrGbK1W1njPUs/39CITqrHyokZzUqSFC3XKTeONrF4gvqibRzgq2EuPuI0RousxoI8HUTkYGSWFf74AglpAK8QkLNvWdKyj2cTEXyJk1feGdGUPJGsMJhlh4sFjGZGZmS1lw9iUGNeuiH9CDF3NLZ39Zi1eKyZ0lN9VBMwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rnkWRbWM; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55NEDZok1502378;
	Mon, 23 Jun 2025 09:13:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1750688015;
	bh=tK38eQd1VuQ/C/1+2r39WnKiLiGo3ot+WXEuqvNBrkE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=rnkWRbWM9n7pCZgKLIU5ryWTrQjul5F1tAFN6VvefQQULGKLq7Jq3DnUNW51bk6DE
	 jn0+jqSSl5y8umnH86NgnLvCGoKEcpdbCKBOHmI+XkMpQKyaWT+GUeo+5Ti8/5+pBq
	 O9qwpgJW6D6FHw2BhQpFdshAYHS2Ixjqk5+4Vve8=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55NEDZfY828155
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 23 Jun 2025 09:13:35 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 23
 Jun 2025 09:13:34 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 23 Jun 2025 09:13:34 -0500
Received: from localhost (ula0502350.dhcp.ti.com [172.24.227.38])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55NEDXul050357;
	Mon, 23 Jun 2025 09:13:34 -0500
From: Paresh Bhagat <p-bhagat@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <khasim@ti.com>, <v-singh1@ti.com>, <afd@ti.com>, <bb@ti.com>,
        <devarsht@ti.com>
Subject: [PATCHv4 4/6] arm64: dts: ti: Add support for AM62D2-EVM
Date: Mon, 23 Jun 2025 19:42:51 +0530
Message-ID: <20250623141253.3519546-5-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250623141253.3519546-1-p-bhagat@ti.com>
References: <20250623141253.3519546-1-p-bhagat@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

AM62D-EVM evaluation module (EVM) is a low-cost expandable platform board
designed for AM62D2 SoC from TI. It supports the following interfaces:

* 4 GB LPDDR4 RAM
* x2 Gigabit Ethernet expansion connectors
* x4 3.5mm TRS Audio Jack Line In
* x4 3.5mm TRS Audio Jack Line Out
* x2 Audio expansion connectors
* x1 Type-A USB 2.0, x1 Type-C dual-role device (DRD) USB 2.0
* x1 UHS-1 capable micro SD card slot
* 32 GB eMMC Flash
* 512 Mb OSPI NOR flash
* x4 UARTs via USB 2.0-B
* XDS110 for onboard JTAG debug using USB
* Temperature sensors, user push buttons and LEDs

Although AM62D2 and AM62A7 differ in peripheral capabilities example
multimedia, VPAC, and display subsystems, the core architecture remains
same. To reduce duplication, AM62D support reuses the AM62A dtsi and the
necessary overrides will be handled in the board specific DTS. Add
basic support for AM62D2-EVM.

Schematics Link - https://www.ti.com/lit/zip/sprcal5

Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 arch/arm64/boot/dts/ti/Makefile          |   3 +
 arch/arm64/boot/dts/ti/k3-am62d2-evm.dts | 561 +++++++++++++++++++++++
 2 files changed, 564 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62d2-evm.dts

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index c6171de9fe88..3da3a1d1dc33 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -33,6 +33,9 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62-pocketbeagle2.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am62a7-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am62a7-phyboard-lyra-rdk.dtb
 
+# Boards with AM62Dx SoC
+dtb-$(CONFIG_ARCH_K3) += k3-am62d2-evm.dtb
+
 # Boards with AM62Px SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am62p5-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am62p5-verdin-nonwifi-dahlia.dtb
diff --git a/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts b/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
new file mode 100644
index 000000000000..8fde89ecba67
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
@@ -0,0 +1,561 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * AM62D2 EVM: https://www.ti.com/lit/zip/sprcal5
+ *
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/net/ti-dp83867.h>
+#include "k3-am62a7.dtsi"
+
+/ {
+	compatible = "ti,am62d2-evm", "ti,am62d2";
+	model = "Texas Instruments AM62D2 EVM";
+
+	aliases {
+		serial0 = &wkup_uart0;
+		serial1 = &mcu_uart0;
+		serial2 = &main_uart0;
+		mmc1 = &sdhci1;
+		rtc0 = &wkup_rtc0;
+		ethernet0 = &cpsw_port1;
+		ethernet1 = &cpsw_port2;
+	};
+
+	chosen {
+		stdout-path = &main_uart0;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		/* 4G RAM */
+		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
+		      <0x00000008 0x80000000 0x00000000 0x80000000>;
+		bootph-all;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		bootph-pre-ram;
+
+		/* global cma region */
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x00 0x2000000>;
+			alloc-ranges = <0x00 0xc0000000 0x00 0x2000000>;
+			linux,cma-default;
+		};
+
+		secure_tfa_ddr: tfa@80000000 {
+			reg = <0x00 0x80000000 0x00 0x80000>;
+			alignment = <0x1000>;
+			no-map;
+		};
+
+		c7x_0_dma_memory_region: c7x-dma-memory@99800000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x99800000 0x00 0x100000>;
+			no-map;
+		};
+
+		c7x_0_memory_region: c7x-memory@99900000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x99900000 0x00 0xf00000>;
+			no-map;
+		};
+
+		mcu_r5fss0_core0_dma_memory_region: r5f-dma-memory@9b800000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9b800000 0x00 0x100000>;
+			no-map;
+		};
+
+		mcu_r5fss0_core0_memory_region: r5f-dma-memory@9b900000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9b900000 0x00 0xf00000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9c800000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9c800000 0x00 0x100000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_memory_region: r5f-dma-memory@9c900000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9c900000 0x00 0xf00000>;
+			no-map;
+			bootph-pre-ram;
+		};
+
+		secure_ddr: optee@9e800000 {
+			reg = <0x00 0x9e800000 0x00 0x01800000>; /* for OP-TEE */
+			alignment = <0x1000>;
+			no-map;
+		};
+	};
+
+	opp-table {
+		/* Requires VDD_CORE at 0v85 */
+		opp-1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			opp-supported-hw = <0x01 0x0004>;
+			clock-latency-ns = <6000000>;
+		};
+	};
+
+	vout_pd: regulator-1 {
+		/* TPS65988 PD CONTROLLER OUTPUT */
+		compatible = "regulator-fixed";
+		regulator-name = "vout_pd";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		regulator-boot-on;
+		bootph-all;
+	};
+
+	vmain_pd: load-switch {
+		/* Output of TPS22811 */
+		compatible = "regulator-fixed";
+		regulator-name = "vmain_pd";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vout_pd>;
+		regulator-always-on;
+		regulator-boot-on;
+		bootph-all;
+	};
+
+	vcc_5v0: regulator-2 {
+		/* Output of TPS630702RNMR */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vmain_pd>;
+		regulator-always-on;
+		regulator-boot-on;
+		bootph-all;
+	};
+
+	vdd_mmc1: regulator-3 {
+		/* TPS22918DBVR */
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_mmc1";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&exp1 3 GPIO_ACTIVE_HIGH>;
+		bootph-all;
+	};
+
+	vddshv_sdio: regulator-4 {
+		compatible = "regulator-gpio";
+		regulator-name = "vddshv_sdio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vddshv_sdio_pins_default>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		gpios = <&main_gpio1 31 GPIO_ACTIVE_HIGH>;
+		states = <1800000 0x0>,
+			 <3300000 0x1>;
+		bootph-all;
+	};
+};
+
+&mcu_pmx0 {
+	wkup_uart0_pins_default: wkup-uart0-default-pins {
+		pinctrl-single,pins = <
+			AM62DX_MCU_IOPAD(0x0024, PIN_INPUT, 0) /* (C9) WKUP_UART0_RXD */
+			AM62DX_MCU_IOPAD(0x0028, PIN_OUTPUT, 0) /* (E9) WKUP_UART0_TXD */
+			AM62DX_MCU_IOPAD(0x002c, PIN_INPUT, 0) /* (C10) WKUP_UART0_CTSn */
+			AM62DX_MCU_IOPAD(0x0030, PIN_OUTPUT, 0) /* (C8) WKUP_UART0_RTSn */
+		>;
+		bootph-all;
+	};
+};
+
+/* WKUP UART0 is used for DM firmware logs */
+&wkup_uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_uart0_pins_default>;
+	status = "reserved";
+	bootph-all;
+};
+
+&main_pmx0 {
+	main_uart0_pins_default: main-uart0-default-pins {
+		pinctrl-single,pins = <
+			AM62DX_IOPAD(0x01c8, PIN_INPUT, 0) /* (E14) UART0_RXD */
+			AM62DX_IOPAD(0x01cc, PIN_OUTPUT, 0) /* (D15) UART0_TXD */
+		>;
+		bootph-all;
+	};
+
+	main_i2c0_pins_default: main-i2c0-default-pins {
+		pinctrl-single,pins = <
+			AM62DX_IOPAD(0x01e0, PIN_INPUT_PULLUP, 0) /* (D17) I2C0_SCL */
+			AM62DX_IOPAD(0x01e4, PIN_INPUT_PULLUP, 0) /* (E16) I2C0_SDA */
+		>;
+		bootph-all;
+	};
+
+	main_i2c1_pins_default: main-i2c1-default-pins {
+		pinctrl-single,pins = <
+			AM62DX_IOPAD(0x01e8, PIN_INPUT_PULLUP, 0) /* (C17) I2C1_SCL */
+			AM62DX_IOPAD(0x01ec, PIN_INPUT_PULLUP, 0) /* (E17) I2C1_SDA */
+		>;
+		bootph-all;
+	};
+
+	main_i2c2_pins_default: main-i2c2-default-pins {
+		pinctrl-single,pins = <
+			AM62DX_IOPAD(0x00b0, PIN_INPUT_PULLUP, 1) /* (M22) GPMC0_CSn2.I2C2_SCL */
+			AM62DX_IOPAD(0x00b4, PIN_INPUT_PULLUP, 1) /* (M20) GPMC0_CSn3.I2C2_SDA */
+		>;
+	};
+
+	main_mmc1_pins_default: main-mmc1-default-pins {
+		pinctrl-single,pins = <
+			AM62DX_IOPAD(0x023c, PIN_INPUT, 0) /* (C21) MMC1_CMD */
+			AM62DX_IOPAD(0x0234, PIN_OUTPUT, 0) /* (E22) MMC1_CLK */
+			AM62DX_IOPAD(0x0230, PIN_INPUT, 0) /* (B22) MMC1_DAT0 */
+			AM62DX_IOPAD(0x022c, PIN_INPUT_PULLUP, 0) /* (D21) MMC1_DAT1 */
+			AM62DX_IOPAD(0x0228, PIN_INPUT_PULLUP, 0) /* (C22) MMC1_DAT2 */
+			AM62DX_IOPAD(0x0224, PIN_INPUT_PULLUP, 0) /* (D22) MMC1_DAT3 */
+			AM62DX_IOPAD(0x0240, PIN_INPUT, 0) /* (E18) MMC1_SDCD */
+			AM62DX_IOPAD(0x0244, PIN_INPUT, 0) /* (D18) MMC1_SDWP */
+		>;
+		bootph-all;
+	};
+
+	main_mdio0_pins_default: main-mdio0-default-pins {
+		pinctrl-single,pins = <
+			AM62DX_IOPAD(0x160, PIN_OUTPUT, 0) /* (V12) MDIO0_MDC */
+			AM62DX_IOPAD(0x15c, PIN_INPUT, 0) /* (V13) MDIO0_MDIO */
+		>;
+		bootph-all;
+	};
+
+	main_rgmii1_pins_default: main-rgmii1-default-pins {
+		pinctrl-single,pins = <
+			AM62DX_IOPAD(0x14c, PIN_INPUT, 0) /* (AB16) RGMII1_RD0 */
+			AM62DX_IOPAD(0x150, PIN_INPUT, 0) /* (V15) RGMII1_RD1 */
+			AM62DX_IOPAD(0x154, PIN_INPUT, 0) /* (W15) RGMII1_RD2 */
+			AM62DX_IOPAD(0x158, PIN_INPUT, 0) /* (V14) RGMII1_RD3 */
+			AM62DX_IOPAD(0x148, PIN_INPUT, 0) /* (AA16) RGMII1_RXC */
+			AM62DX_IOPAD(0x144, PIN_INPUT, 0) /* (AA15) RGMII1_RX_CTL */
+			AM62DX_IOPAD(0x134, PIN_INPUT, 0) /* (Y17) RGMII1_TD0 */
+			AM62DX_IOPAD(0x138, PIN_INPUT, 0) /* (V16) RGMII1_TD1 */
+			AM62DX_IOPAD(0x13c, PIN_INPUT, 0) /* (Y16) RGMII1_TD2 */
+			AM62DX_IOPAD(0x140, PIN_INPUT, 0) /* (AA17) RGMII1_TD3 */
+			AM62DX_IOPAD(0x0130, PIN_OUTPUT, 0) /* (AB17) RGMII1_TXC */
+			AM62DX_IOPAD(0x012c, PIN_OUTPUT, 0) /* (W16) RGMII1_TX_CTL */
+		>;
+		bootph-all;
+	};
+
+	main_rgmii2_pins_default: main-rgmii2-default-pins {
+		pinctrl-single,pins = <
+			AM62DX_IOPAD(0x0184, PIN_INPUT, 0) /* (AA21) RGMII2_RD0 */
+			AM62DX_IOPAD(0x0188, PIN_INPUT, 0) /* (Y20) RGMII2_RD1 */
+			AM62DX_IOPAD(0x018c, PIN_INPUT, 0) /* (AB21) RGMII2_RD2 */
+			AM62DX_IOPAD(0x0190, PIN_INPUT, 0) /* (AB20) RGMII2_RD3 */
+			AM62DX_IOPAD(0x0180, PIN_INPUT, 0) /* (AA20) RGMII2_RXC */
+			AM62DX_IOPAD(0x017c, PIN_INPUT, 0) /* (W18) RGMII2_RX_CTL */
+			AM62DX_IOPAD(0x016c, PIN_INPUT, 0) /* (AA19) RGMII2_TD0 */
+			AM62DX_IOPAD(0x0170, PIN_INPUT, 0) /* (Y18) RGMII2_TD1 */
+			AM62DX_IOPAD(0x0174, PIN_INPUT, 0) /* (AA18) RGMII2_TD2 */
+			AM62DX_IOPAD(0x0178, PIN_INPUT, 0) /* (W17) RGMII2_TD3 */
+			AM62DX_IOPAD(0x0168, PIN_OUTPUT, 0) /* (AB19) RGMII2_TXC */
+			AM62DX_IOPAD(0x0164, PIN_OUTPUT, 0) /* (Y19) RGMII2_TX_CTL */
+		>;
+		bootph-all;
+	};
+
+	main_gpio1_ioexp_intr_pins_default: main-gpio1-ioexp-intr-default-pins {
+		pinctrl-single,pins = <
+			AM62DX_IOPAD(0x01d4, PIN_INPUT, 7) /* (C15) UART0_RTSn.GPIO1_23 */
+		>;
+	};
+
+	vddshv_sdio_pins_default: vddshv-sdio-default-pins {
+		pinctrl-single,pins = <
+			AM62DX_IOPAD(0x1F4, PIN_OUTPUT, 7) /* (M19) GPMC0_CLK.GPIO1_31 */
+		>;
+		bootph-all;
+	};
+};
+
+&mcu_pmx0 {
+	status = "okay";
+
+	pmic_irq_pins_default: pmic-irq-default-pins {
+		pinctrl-single,pins = <
+			AM62DX_MCU_IOPAD(0x000, PIN_INPUT, 7) /* (E11) MCU_GPIO0_0 */
+		>;
+	};
+};
+
+&mcu_gpio0 {
+	status = "okay";
+};
+
+&main_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c0_pins_default>;
+	clock-frequency = <400000>;
+	bootph-all;
+
+	typec_pd0: usb-power-controller@3f {
+		compatible = "ti,tps6598x";
+		reg = <0x3f>;
+
+		connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			self-powered;
+			data-role = "dual";
+			power-role = "sink";
+			port {
+				usb_con_hs: endpoint {
+					remote-endpoint = <&usb0_hs_ep>;
+				};
+			};
+		};
+	};
+
+	exp1: gpio@22 {
+		compatible = "ti,tca6424";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&main_gpio1>;
+		interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&main_gpio1_ioexp_intr_pins_default>;
+		bootph-all;
+
+		gpio-line-names = "GPIO_CPSW2_RST", "GPIO_CPSW1_RST",
+			"","MMC1_SD_EN",
+			"VPP_EN", "GPIO_DIX_RST",
+			"IO_EXP_OPT_EN", "DIX_INT",
+			"GPIO_eMMC_RSTn", "CPLD2_DONE",
+			"CPLD2_INTN", "CPLD1_DONE",
+			"CPLD1_INTN", "USB_TYPEA_OC_INDICATION",
+			"PCM1_INT", "PCM2_INT",
+			"GPIO_PCM1_RST", "TEST_GPIO2",
+			"GPIO_PCM2_RST", "",
+			"IO_MCAN0_STB", "IO_MCAN1_STB",
+			"PD_I2C_IRQ", "IO_EXP_TEST_LED";
+	};
+
+	exp2: gpio@20 {
+		compatible = "ti,tca6416";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names = "PCM6240_BUF_IO_EN", "",
+			"CPLD1_JTAGENB", "CPLD1_PROGRAMN",
+			"CPLD2_JTAGENB", "CPLD2_PROGRAMN",
+			"", "",
+			"", "CPLD1_TCK",
+			"CPLD1_TMS", "CPLD1_TDI",
+			"CPLD1_TDO", "CPLD2_TCK",
+			"CPLD2_TMS", "CPLD2_TDI",
+			"CPLD2_TDO", "ADDR1_IO_EXP",
+			"SoC_I2C0_SCL", "SoC_I2C0_SDA";
+	};
+};
+
+&main_i2c1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c1_pins_default>;
+	clock-frequency = <100000>;
+};
+
+&main_i2c2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c2_pins_default>;
+	clock-frequency = <400000>;
+};
+
+&sdhci1 {
+	/* SD/MMC */
+	status = "okay";
+	vmmc-supply = <&vdd_mmc1>;
+	vqmmc-supply = <&vddshv_sdio>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mmc1_pins_default>;
+	disable-wp;
+	bootph-all;
+};
+
+&main_gpio0 {
+	bootph-all;
+	status = "okay";
+};
+
+&main_gpio1 {
+	bootph-all;
+	status = "okay";
+};
+
+&main_gpio_intr {
+	status = "okay";
+};
+
+&main_uart0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart0_pins_default>;
+	bootph-all;
+};
+
+&usb0 {
+	usb-role-switch;
+
+	port {
+		usb0_hs_ep: endpoint {
+			remote-endpoint = <&usb_con_hs>;
+		};
+	};
+};
+
+&mailbox0_cluster0 {
+	status = "okay";
+
+	mbox_r5_0: mbox-r5-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+};
+
+&mailbox0_cluster1 {
+	status = "okay";
+
+	mbox_c7x_0: mbox-c7x-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+};
+
+&mailbox0_cluster2 {
+	status = "okay";
+
+	mbox_mcu_r5_0: mbox-mcu-r5-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+};
+
+&wkup_r5fss0 {
+	status = "okay";
+};
+
+&wkup_r5fss0_core0 {
+	mboxes = <&mailbox0_cluster0 &mbox_r5_0>;
+	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
+			<&wkup_r5fss0_core0_memory_region>;
+	bootph-pre-ram;
+};
+
+&mcu_r5fss0 {
+	status = "okay";
+};
+
+&mcu_r5fss0_core0 {
+	status = "okay";
+
+	mboxes = <&mailbox0_cluster2 &mbox_mcu_r5_0>;
+	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
+			<&mcu_r5fss0_core0_memory_region>;
+};
+
+&c7x_0 {
+	status = "okay";
+
+	mboxes = <&mailbox0_cluster1 &mbox_c7x_0>;
+	memory-region = <&c7x_0_dma_memory_region>,
+			<&c7x_0_memory_region>;
+};
+
+&cpsw3g {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_rgmii1_pins_default &main_rgmii2_pins_default>;
+
+	cpts@3d000 {
+		/* MAP HW3_TS_PUSH to GENF1 */
+		ti,pps = <2 1>;
+	};
+};
+
+&cpsw_port1 {
+	status = "okay";
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&cpsw3g_phy0>;
+};
+
+&cpsw_port2 {
+	status = "okay";
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&cpsw3g_phy1>;
+};
+
+&cpsw3g_mdio {
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mdio0_pins_default>;
+
+	cpsw3g_phy0: ethernet-phy@0 {
+		reg = <0>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		ti,min-output-impedance;
+	};
+
+	cpsw3g_phy1: ethernet-phy@3 {
+		reg = <3>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		ti,min-output-impedance;
+	};
+};
+
+/* main_rti4 is used by C7x DSP */
+&main_rti4 {
+	status = "reserved";
+};
+
+/* main_timer2 is used by C7x DSP */
+&main_timer2 {
+	status = "reserved";
+};
+
+&vpu {
+	status = "disabled";
+};
+
+&e5010 {
+	status = "disabled";
+};
-- 
2.34.1



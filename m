Return-Path: <linux-kernel+bounces-722231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23654AFD6B3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C3184805A7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98AC2E5B2C;
	Tue,  8 Jul 2025 18:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYlFuy4k"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6052E540D;
	Tue,  8 Jul 2025 18:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752000577; cv=none; b=ePmTuWJbKxNq4g7BQHXb2WMaDG4Ymqc9lwUnH313FL8ZG51u7qpTxU8aTD3up9w71UeU/lxHyRBfnG2g/9LkSR0494z10vv1OZM3tXfr8QB2hi95XcJuCpNX0/r1mLJz1Q6R9cuMcD1QpZqGipZNyYuHAqGqUrrQImiixWfqtRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752000577; c=relaxed/simple;
	bh=rLgJ2nFplNZlDqL3ipoQ5HW2aaXglJmLgTtNwUFMLWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dCjIVX9KPmsQ/PIvz8lva0Xdtf1b7llJFduZ51decEuI1c+pbPPdjdtq4cAyd6gf9VcmFW+qMslrijfyxJbsFimkpMgmmC3vx5Iv1+GwEjmwlWsLzUuN40CBRUjVodNiOOwrgL3NwT3OvNoSlC28gmdcpVZ2WbETcXBVxxUmrIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYlFuy4k; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad56cbc7b07so799993266b.0;
        Tue, 08 Jul 2025 11:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752000574; x=1752605374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6L1JJzb3y8lN2PKshZQl60XhVP354ueMKpVoS1by5Q=;
        b=YYlFuy4kiDK+rMurA2jI7j5aLJDlWmzR+JGgde0sSgQDxuwTrr/g4K5vE0uIOlDwF9
         gnPlqjI7agnB8qfu6q0Wszro2spmroPpLeYPkUcTgMSjVt4+bvgttezH84xEaThZOas/
         6KhO2eNbCGYcKQL81uhixFzvjaqYLUlUMKyha5MB0idENKGEhrA+9l5A/3B2QTRGxDRF
         Ohos7tOU3S8CwxZXlbmVTeUw6097YrlMsUM3nomO+QRlYqlkbykNGwJn8/FWQN41CEhV
         NY601AA2UREqAvNhofey4v8C5NLmYlbHJU0t7W3dIlQ/7MDWfI7L57jn/bQKhP1zh0Px
         gw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752000574; x=1752605374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6L1JJzb3y8lN2PKshZQl60XhVP354ueMKpVoS1by5Q=;
        b=d2hg983YlnjtBsLFSBmID8lVQeCj6nxapXrfjNRSgRhjeBu7swJLP7LtPKwqvgbrKg
         FVIwFf2v6o9EwRoegBTUBmreRbuG7KFzP9G61D1A1hAQgqJTQwa4qzw7OqkTGYByXrOZ
         osieTHI7hIbrXvXwIsQ9PumOwrdplY8a/14718AvivrlcBTkDnQfrMYhIBVwB2Dp1kma
         2gLlziHR0Kjl+VqlW5Is5N7TBTIW+1zCrPIVIY/ZmiDsALE4haFwCMtu5XWqm/KPEr/p
         ohlxYWK9sjhVisLPiZ1VyUP4a8O16u9/HFU162WXJbO8xx2I6YT8oQyPE0351EkMoIYX
         tjpg==
X-Forwarded-Encrypted: i=1; AJvYcCWCYyQjmNrIPAHha6bsDHt384es+eHsneTsvM8ZPt9u2Xhl/P7t/PsQAdkhUIH8sXPUXVqkAntNsCeTAk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1TmCNSFyd9aTOlXCjs7sO/X1GWqgfPKSFphkxwwHLhJ2sdh9S
	ZNXmZof4cv9xmwrcPN5ojLlCWxWn0ntI1RzKyagM4Hit7G0Uyetqxx1Ly4qAwYL7
X-Gm-Gg: ASbGncttV5FIGIKPrMT8Tw9YQtidgtFBYtL2O8p9au4fXOCtYBo5HXxpeO4GzY/fssd
	7JhdUpHzrTY28ygHcnzvlkzvJq3FwwFj2VJTcSrI/X1hWMcvJJn7PIhaPXa/j0bGt/bsi9qW6d6
	y4Wt2Oo4mLb+v3HrUO+ocTR5qYh+/+NpmQgOVNsv8GovTWlkrbfvu9mqLwm8yzOVoHECfucrs23
	GUuUJTh86U8krkXz8CPnOh4Cfovw0u9nXUpSDGQxUe/JpeD/KmIRjusch9/ExVjhIjk6FVVSJts
	GhmxzqXcmhiFPtkpG4JD3WB4j4ZgGWWcGBsotNjLRfIHKaj+iz12J7x/64aPpRXu9MEsJOYKTcG
	RhrycLoWSjrhOGxEyoSzC87RD1F8AuALfQoNAB6z8btwamVe6lcRvGScuXA==
X-Google-Smtp-Source: AGHT+IExg0bqEzKPStnnRgDdeaHOjyaePJ3jMWIEqB4/kteE8qmWKDkjwjcEpjNacs2hlVtj4NmLFQ==
X-Received: by 2002:a17:907:96a7:b0:adb:1eee:a083 with SMTP id a640c23a62f3a-ae3fe7f78eamr1628519566b.47.1752000573062;
        Tue, 08 Jul 2025 11:49:33 -0700 (PDT)
Received: from Lord-Beerus.tastitalia.local (net-93-70-53-177.cust.vodafonedsl.it. [93.70.53.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6baaaedsm944884666b.173.2025.07.08.11.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 11:49:32 -0700 (PDT)
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
Subject: [PATCH v1 2/3] arm64: dts: ti: Add support for Variscite VAR-SOM-AM62P
Date: Tue,  8 Jul 2025 20:48:34 +0200
Message-ID: <20250708184841.72933-3-stefano.radaelli21@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250708184841.72933-1-stefano.radaelli21@gmail.com>
References: <20250708184841.72933-1-stefano.radaelli21@gmail.com>
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
 arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi | 379 ++++++++++++++++++
 1 file changed, 379 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi
new file mode 100644
index 000000000000..1d4ebc484d55
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi
@@ -0,0 +1,379 @@
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
+	iw612_pwrseq: iw612_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		post-power-on-delay-ms = <100>;
+		power-off-delay-us = <10000>;
+		reset-gpios = <&main_gpio0 54 GPIO_ACTIVE_LOW>,	/* WIFI_PWR_EN */
+			      <&main_gpio0 59 GPIO_ACTIVE_LOW>;	/* WIFI_EN */
+		status = "okay";
+	};
+
+	emmc_pwrseq: pwrseq@0 {
+		compatible = "mmc-pwrseq-emmc";
+		pinctrl-names = "default";
+		pinctrl-0 = <&emmc_pwrseq_pins>;
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
+	vcc_3v3: vcc-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vcc_1v8: vcc-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_3v3>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vdd_phy_3v3: regulator-8 {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_phy_3v3";
+		gpios = <&main_gpio0 45 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+		status="okay";
+	};
+};
+
+&cpsw3g {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_rgmii1_pins_default>;
+};
+
+&cpsw3g_mdio {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mdio1_pins_default>;
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
+	pinctrl-0 = <&main_i2c2_pins_default>;
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&main_i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c3_pins_default>;
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&main_pmx0 {
+	emmc_pwrseq_pins: pinmux_emmc_pwrseq_pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x00c8, PIN_OUTPUT, 7) /* (AB23) VOUT0_DATA4.GPIO0_49 */
+		>;
+	};
+
+	main_i2c2_pins_default: main-i2c2-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x00b0, PIN_INPUT_PULLUP, 1) /* (T22) GPMC0_CSn2.I2C2_SCL */
+			AM62PX_IOPAD(0x00b4, PIN_INPUT_PULLUP, 1) /* (U25) GPMC0_CSn3.I2C2_SDA */
+		>;
+	};
+
+	main_i2c3_pins_default: main-i2c3-pins-default {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x01d0, PIN_INPUT_PULLUP, 2) /* (A23) UART0_CTSn.I2C3_SCL */
+			AM62PX_IOPAD(0x01d4, PIN_INPUT_PULLUP, 2) /* (C22) UART0_RTSn.I2C3_SDA */
+		>;
+	};
+
+	main_mcasp1_pins_default: main-mcasp1-pins-default {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0090, PIN_INPUT, 2) /* (U24) GPMC0_BE0n_CLE.MCASP1_ACLKX */
+			AM62PX_IOPAD(0x0098, PIN_INPUT, 2) /* (AA24) GPMC0_WAIT0.MCASP1_AFSX */
+			AM62PX_IOPAD(0x008c, PIN_OUTPUT, 2) /* (T25) GPMC0_WEn.MCASP1_AXR0 */
+			AM62PX_IOPAD(0x0084, PIN_INPUT, 2) /* (R25) GPMC0_ADVn_ALE.MCASP1_AXR2 */
+			AM62PX_IOPAD(0x00a0, PIN_OUTPUT, 1) /* (P24) GPMC0_WPn.AUDIO_EXT_REFCLK1 */
+		>;
+	};
+
+	main_mdio1_pins_default: main-mdio1-pins-default {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0160, PIN_OUTPUT, 0) /* (F17) MDIO0_MDC */
+			AM62PX_IOPAD(0x015c, PIN_INPUT, 0) /* (F16) MDIO0_MDIO */
+		>;
+	};
+
+	main_mmc2_pins_default: main-mmc2-pins-default {
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
+	main_rgmii1_pins_default: main-rgmii1-default-pins {
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
+	main_spi0_pins_default: main_spi0-pins-default {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x01bc, PIN_OUTPUT, 0) /* (B21) SPI0_CLK */
+			AM62PX_IOPAD(0x01b4, PIN_OUTPUT, 0) /* (D20) SPI0_CS0 */
+			AM62PX_IOPAD(0x01c0, PIN_OUTPUT, 0) /* (B20) SPI0_D0 */
+			AM62PX_IOPAD(0x01c4, PIN_INPUT, 0) /* (C21) SPI0_D1 */
+		>;
+	};
+
+	main_uart5_pins_default: uart5-pins-default {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x00ec, PIN_INPUT, 4) /* (AC21) VOUT0_DATA13.UART5_CTSn */
+			AM62PX_IOPAD(0x00e8, PIN_OUTPUT, 4) /* (AD21) VOUT0_DATA12.UART5_RTSn */
+			AM62PX_IOPAD(0x00d0, PIN_INPUT, 4) /* (AC23) VOUT0_DATA6.UART5_RXD */
+			AM62PX_IOPAD(0x00d4, PIN_OUTPUT, 4) /* (AE23) VOUT0_DATA7.UART5_TXD */
+		>;
+	};
+
+	pinctrl_bt: btgrp {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x00f4, PIN_OUTPUT, 7) /* (Y20) VOUT0_DATA15.GPIO0_60 (BT_EN) */
+		>;
+	};
+
+	pinctrl_restouch: restouchgrp {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x00c4, PIN_INPUT_PULLUP, 7) /* (Y23) VOUT0_DATA3.GPIO0_48 */
+		>;
+	};
+
+	pinctrl_wifi: pinctrl-wifi-default {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x00dc, PIN_OUTPUT, 7) /* (AC22) VOUT0_DATA9.GPIO0_54 - WIFI_PWR_EN - */
+			AM62PX_IOPAD(0x00f0, PIN_OUTPUT, 7) /* (AA20) VOUT0_DATA14.GPIO0_59 - WIFI_EN - */
+		>;
+	};
+};
+
+&main_spi0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_spi0_pins_default>;
+	ti,pindir-d0-out-d1-in = <1>;
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
+	pinctrl-0 = <&main_uart5_pins_default>, <&pinctrl_bt>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth_iw61x: bluetooth_iw61x {
+		compatible = "nxp,88w8987-bt";
+		status = "okay";
+	};
+};
+
+&mcasp1 {
+	status = "okay";
+	#sound-dai-cells = <0>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcasp1_pins_default>;
+
+	op-mode = <0>;          /* MCASP_IIS_MODE */
+	tdm-slots = <2>;
+
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
+&mcu_pmx0 {
+	wkup_clkout0_pins_default: wkup_clkout0_pins_default {
+		pinctrl-single,pins = <
+			AM62PX_MCU_IOPAD(0x0084, PIN_OUTPUT, 0) /* (F13) WKUP_CLKOUT0 */
+		>;
+	};
+};
+
+/* eMMC */
+&sdhci0 {
+	status = "okay";
+	ti,driver-strength-ohm = <50>;
+	mmc-pwrseq = <&emmc_pwrseq>;
+	disable-wp;
+	bootph-all;
+};
+
+/* WIFI */
+&sdhci2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mmc2_pins_default>, <&pinctrl_wifi>;
+	bus-width = <4>;
+	disable-wp;
+	non-removable;
+	keep-power-in-suspend;
+	mmc-pwrseq = <&iw612_pwrseq>;
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



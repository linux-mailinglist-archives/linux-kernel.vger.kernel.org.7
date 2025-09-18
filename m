Return-Path: <linux-kernel+bounces-808642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 217E6B502AF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F37344E31D4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57681356907;
	Tue,  9 Sep 2025 16:31:26 +0000 (UTC)
Received: from mail.grinn-global.com (mail.grinn-global.com [77.55.128.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD08826B779;
	Tue,  9 Sep 2025 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.55.128.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435485; cv=none; b=FRjhk6Cf6MuGvo5QDgFkJionl5xJ2BpnwtHIfrm4+H6MY9vPaQOs3K/i6+VSVd9tsf11TzLS6VAR4QPX27r024BRrmOtO9+ml7rHOpWex6hBrDl7qZdOi2m7LrY9MWUIYttMS1hdvB8nOxOtvOy90OiTKH1rQRwKbB91WBeRqDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435485; c=relaxed/simple;
	bh=jJj8tyoGspKU+pvRZYgT7idl+xJgeHX3//qSFXbC5Ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tljrvXBcXj2tWoifgwKuCs1yw6Jw9uwFidDv1i0McQweT5oCaH83ytBbySEWPQOuaOp1lmpwLrK6i/LZXhqupJzBTFa9do4eGUrxBH7o11IbFHtkYS66zFXRAmbd2nKSBmvlwjBwQ4TMecsleQXNyIAofAPSlX4aXfuZ8qGuPCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grinn-global.com; spf=pass smtp.mailfrom=grinn-global.com; arc=none smtp.client-ip=77.55.128.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grinn-global.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grinn-global.com
X-Virus-Scanned: by amavisd-new using ClamAV (10)
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
Received: from mateusz.int.grinn-global.com (f90-187.icpnet.pl [46.228.90.187])
	by server220076.nazwa.pl (Postfix) with ESMTP id 300621BBDD3;
	Tue, 09 Sep 2025 18:31:13 +0200 (CEST)
From: Mateusz Koza <mateusz.koza@grinn-global.com>
To: angelogioacchino.delregno@collabora.com,
	robh@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	marcin.czarnecki@grinn-global.com,
	b.bilas@grinn-global.com,
	mateusz.koza@grinn-global.com,
	andrew@lunn.ch
Subject: [PATCH v5 1/4] arm64: dts: mediatek: mt8390-genio-700-evk: Add Grinn GenioSBC-700
Date: Tue,  9 Sep 2025 18:30:47 +0200
Message-ID: <20250909163052.446723-2-mateusz.koza@grinn-global.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909163052.446723-1-mateusz.koza@grinn-global.com>
References: <20250909163052.446723-1-mateusz.koza@grinn-global.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-NA-AI-Spam-Probability: 0.50
X-NA-AI-Is-Spam: no

Add support for Grinn GenioSBC-700. The Grinn GenioSBC-700 is a
single-board computer based on the MediaTek Genio 700 SoC. Its device
tree is split into separate SoM (.dtsi) and SBC (.dtsi) files, which are
combined in the SoC-specific .dts file.

More details about the hardware:
- https://grinn-global.com/products/grinn-geniosom-700
- https://grinn-global.com/products/grinn-genioboard-edge-ai-sbc

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Mateusz Koza <mateusz.koza@grinn-global.com>
---
 arch/arm64/boot/dts/mediatek/Makefile         |   1 +
 .../mediatek/mt8390-grinn-genio-700-sbc.dts   |  20 +
 .../dts/mediatek/mt8390-grinn-genio-sbc.dtsi  | 538 ++++++++++++++++++
 .../dts/mediatek/mt8390-grinn-genio-som.dtsi  | 210 +++++++
 4 files changed, 769 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-700-sbc.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-sbc.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-som.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index a4df4c21399e..b37a8c65e724 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -101,6 +101,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8365-evk.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8370-genio-510-evk.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-genio-1200-evk.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8390-genio-700-evk.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8390-grinn-genio-700-sbc.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-kontron-3-5-sbc-i1200.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-radxa-nio-12l.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-radxa-nio-12l-8-hd-panel.dtbo
diff --git a/arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-700-sbc.dts b/arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-700-sbc.dts
new file mode 100644
index 000000000000..4931d761bd1f
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-700-sbc.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2025 Grinn sp. z o.o.
+ * Author: Mateusz Koza <mateusz.koza@grinn-global.com>
+ */
+/dts-v1/;
+
+#include "mt8188.dtsi"
+#include "mt8390-grinn-genio-som.dtsi"
+#include "mt8390-grinn-genio-sbc.dtsi"
+
+/ {
+	model = "Grinn GenioSBC-700";
+	compatible = "grinn,genio-700-sbc", "mediatek,mt8390", "mediatek,mt8188";
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 1 0x00000000>;
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-sbc.dtsi b/arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-sbc.dtsi
new file mode 100644
index 000000000000..888248a75e93
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-sbc.dtsi
@@ -0,0 +1,538 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2025 Grinn sp. z o.o.
+ * Author: Mateusz Koza <mateusz.koza@grinn-global.com>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	chassis-type = "embedded";
+
+	aliases {
+		ethernet0 = &eth;
+		i2c0 = &i2c0;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c5 = &i2c5;
+		i2c6 = &i2c6;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:921600n8";
+	};
+
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/*
+		 * 12 MiB reserved for OP-TEE (BL32)
+		 * +-----------------------+ 0x43e0_0000
+		 * |      SHMEM 2MiB       |
+		 * +-----------------------+ 0x43c0_0000
+		 * |        | TA_RAM  8MiB |
+		 * + TZDRAM +--------------+ 0x4340_0000
+		 * |        | TEE_RAM 2MiB |
+		 * +-----------------------+ 0x4320_0000
+		 */
+		optee_reserved: optee@43200000 {
+			no-map;
+			reg = <0 0x43200000 0 0x00c00000>;
+		};
+
+		scp_mem: memory@50000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x50000000 0 0x2900000>;
+			no-map;
+		};
+
+		/* 2 MiB reserved for ARM Trusted Firmware (BL31) */
+		bl31_secmon_reserved: memory@54600000 {
+			no-map;
+			reg = <0 0x54600000 0x0 0x200000>;
+		};
+
+		apu_mem: memory@55000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x55000000 0 0x1400000>; /* 20 MB */
+		};
+
+		vpu_mem: memory@57000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x57000000 0 0x1400000>; /* 20 MB */
+		};
+
+		adsp_mem: memory@60000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x60000000 0 0xf00000>;
+			no-map;
+		};
+
+		afe_dma_mem: memory@60f00000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x60f00000 0 0x100000>;
+			no-map;
+		};
+
+		adsp_dma_mem: memory@61000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x61000000 0 0x100000>;
+			no-map;
+		};
+	};
+
+	reg_sbc_vsys: regulator-vsys {
+		compatible = "regulator-fixed";
+		regulator-name = "vsys";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	reg_fixed_5v: regulator-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		regulator-always-on;
+		vin-supply = <&reg_sbc_vsys>;
+	};
+
+	reg_fixed_4v2: regulator-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-4v2";
+		regulator-min-microvolt = <4200000>;
+		regulator-max-microvolt = <4200000>;
+		enable-active-high;
+		regulator-always-on;
+		vin-supply = <&reg_sbc_vsys>;
+	};
+
+	reg_fixed_3v3: regulator-2 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		regulator-always-on;
+		vin-supply = <&reg_sbc_vsys>;
+	};
+};
+
+&pio {
+	gpio-line-names =
+	/*  0 -  4   */ "RPI_GPIO0", "RPI_GPIO1", "", "", "RPI_GPIO4",
+	/*  5 -  9   */ "", "RPI_GPIO6", "", "", "RPI_GPIO9",
+	/* 10 - 14   */ "RPI_GPIO10", "RPI_GPIO11", "", "", "",
+	/* 15 - 19   */ "", "", "", "", "",
+	/* 20 - 24   */ "", "RPI_GPIO21", "", "RPI_GPIO23", "",
+	/* 25 - 29   */ "", "", "", "", "",
+	/* 30 - 34   */ "RPI_GPIO30", "", "", "", "",
+	/* 35 - 39   */ "RPI_GPIO35", "RPI_GPIO36", "", "", "",
+	/* 40 - 44   */ "", "", "", "", "",
+	/* 45 - 49   */ "", "", "", "", "",
+	/* 50 - 54   */ "", "", "", "", "",
+	/* 55 - 59   */ "RPI_GPIO55", "RPI_GPIO56", "", "", "RPI_GPIO59",
+	/* 60 - 64   */ "RPI_GPIO60", "", "", "", "",
+	/* 65 - 69   */ "", "", "", "", "RPI_GPIO69",
+	/* 70 - 74   */ "", "", "RPI_GPIO72", "RPI_GPIO73", "RPI_GPIO74",
+	/* 75 - 79   */ "", "", "", "", "RPI_GPIO79",
+	/* 80 - 84   */ "RPI_GPIO80", "RPI_GPIO81", "RPI_GPIO82", "", "",
+	/* 85 - 89   */ "", "", "", "", "",
+	/* 90 - 94   */ "", "", "", "", "",
+	/* 95 - 99   */ "", "", "", "", "",
+	/*100 - 104  */ "", "", "", "", "",
+	/*105 - 109  */ "", "", "", "", "",
+	/*110 - 114  */ "", "", "", "", "",
+	/*115 - 119  */ "", "", "", "", "",
+	/*120 - 124  */ "", "RPI_GPIO121", "RPI_GPIO122", "RPI_GPIO123", "RPI_GPIO124";
+
+	i2c0_pins: i2c0-pins {
+		pins {
+			pinmux = <PINMUX_GPIO56__FUNC_B1_SDA0>,
+				 <PINMUX_GPIO55__FUNC_B1_SCL0>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_011>;
+			drive-strength-microamp = <1000>;
+		};
+	};
+
+	i2c2_pins: i2c2-pins {
+		pins {
+			pinmux = <PINMUX_GPIO60__FUNC_B1_SDA2>,
+				 <PINMUX_GPIO59__FUNC_B1_SCL2>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_011>;
+			drive-strength-microamp = <1000>;
+		};
+	};
+
+	i2c3_pins: i2c3-pins {
+		pins {
+			pinmux = <PINMUX_GPIO62__FUNC_B1_SDA3>,
+				 <PINMUX_GPIO61__FUNC_B1_SCL3>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_011>;
+			drive-strength-microamp = <1000>;
+		};
+	};
+
+	i2c5_pins: i2c5-pins {
+		pins {
+			pinmux = <PINMUX_GPIO66__FUNC_B1_SDA5>,
+				 <PINMUX_GPIO65__FUNC_B1_SCL5>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_011>;
+			drive-strength-microamp = <1000>;
+		};
+	};
+
+	i2c6_pins: i2c6-pins {
+		pins {
+			pinmux = <PINMUX_GPIO68__FUNC_B1_SDA6>,
+				 <PINMUX_GPIO67__FUNC_B1_SCL6>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_011>;
+			drive-strength-microamp = <1000>;
+		};
+	};
+
+	uart0_pins: uart0-pins {
+		pins {
+			pinmux = <PINMUX_GPIO31__FUNC_O_UTXD0>,
+				 <PINMUX_GPIO32__FUNC_I1_URXD0>;
+			bias-pull-up;
+		};
+	};
+
+	uart1_pins: uart1-pins {
+		pins {
+			pinmux = <PINMUX_GPIO86__FUNC_O_UTXD1>,
+				 <PINMUX_GPIO87__FUNC_I1_URXD1>;
+			bias-pull-up;
+		};
+	};
+
+	uart2_pins: uart2-pins {
+		pins {
+			pinmux = <PINMUX_GPIO35__FUNC_O_UTXD2>,
+				 <PINMUX_GPIO36__FUNC_I1_URXD2>;
+			bias-pull-up;
+		};
+	};
+
+	pcie_pins_default: pcie-default {
+		mux {
+			pinmux = <PINMUX_GPIO47__FUNC_I1_WAKEN>,
+				 <PINMUX_GPIO48__FUNC_O_PERSTN>,
+				 <PINMUX_GPIO49__FUNC_B1_CLKREQN>;
+			bias-pull-up;
+		};
+	};
+
+	eth_default_pins: eth-default-pins {
+		pins-cc {
+			pinmux = <PINMUX_GPIO139__FUNC_B0_GBE_TXC>,
+				 <PINMUX_GPIO140__FUNC_I0_GBE_RXC>,
+				 <PINMUX_GPIO141__FUNC_I0_GBE_RXDV>,
+				 <PINMUX_GPIO142__FUNC_O_GBE_TXEN>;
+			drive-strength = <8>;
+		};
+
+		pins-mdio {
+			pinmux = <PINMUX_GPIO143__FUNC_O_GBE_MDC>,
+				 <PINMUX_GPIO144__FUNC_B1_GBE_MDIO>;
+			drive-strength = <8>;
+			input-enable;
+		};
+
+		pins-power {
+			pinmux = <PINMUX_GPIO145__FUNC_B_GPIO145>,
+				 <PINMUX_GPIO146__FUNC_B_GPIO146>;
+			output-high;
+		};
+
+		pins-rxd {
+			pinmux = <PINMUX_GPIO135__FUNC_I0_GBE_RXD3>,
+				 <PINMUX_GPIO136__FUNC_I0_GBE_RXD2>,
+				 <PINMUX_GPIO137__FUNC_I0_GBE_RXD1>,
+				 <PINMUX_GPIO138__FUNC_I0_GBE_RXD0>;
+			drive-strength = <8>;
+		};
+
+		pins-txd {
+			pinmux = <PINMUX_GPIO131__FUNC_O_GBE_TXD3>,
+				 <PINMUX_GPIO132__FUNC_O_GBE_TXD2>,
+				 <PINMUX_GPIO133__FUNC_O_GBE_TXD1>,
+				 <PINMUX_GPIO134__FUNC_O_GBE_TXD0>;
+			drive-strength = <8>;
+		};
+	};
+
+	eth_sleep_pins: eth-sleep-pins {
+		pins-cc {
+			pinmux = <PINMUX_GPIO139__FUNC_B_GPIO139>,
+				 <PINMUX_GPIO140__FUNC_B_GPIO140>,
+				 <PINMUX_GPIO141__FUNC_B_GPIO141>,
+				 <PINMUX_GPIO142__FUNC_B_GPIO142>;
+		};
+
+		pins-mdio {
+			pinmux = <PINMUX_GPIO143__FUNC_B_GPIO143>,
+				 <PINMUX_GPIO144__FUNC_B_GPIO144>;
+			input-disable;
+			bias-disable;
+		};
+
+		pins-rxd {
+			pinmux = <PINMUX_GPIO135__FUNC_B_GPIO135>,
+				 <PINMUX_GPIO136__FUNC_B_GPIO136>,
+				 <PINMUX_GPIO137__FUNC_B_GPIO137>,
+				 <PINMUX_GPIO138__FUNC_B_GPIO138>;
+		};
+
+		pins-txd {
+			pinmux = <PINMUX_GPIO131__FUNC_B_GPIO131>,
+				 <PINMUX_GPIO132__FUNC_B_GPIO132>,
+				 <PINMUX_GPIO133__FUNC_B_GPIO133>,
+				 <PINMUX_GPIO134__FUNC_B_GPIO134>;
+		};
+	};
+
+	spi2_pins: spi2-pins {
+		pins-spi {
+			pinmux = <PINMUX_GPIO79__FUNC_O_SPIM2_CSB>,
+				<PINMUX_GPIO80__FUNC_O_SPIM2_CLK>,
+				<PINMUX_GPIO81__FUNC_B0_SPIM2_MOSI>,
+				<PINMUX_GPIO82__FUNC_B0_SPIM2_MISO>;
+			bias-disable;
+		};
+	};
+
+	audio_default_pins: audio-default-pins {
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO121__FUNC_B0_PCM_CLK>,
+				 <PINMUX_GPIO122__FUNC_B0_PCM_SYNC>,
+				 <PINMUX_GPIO123__FUNC_O_PCM_DO>,
+				 <PINMUX_GPIO124__FUNC_I0_PCM_DI>;
+		};
+	};
+
+	usb_default_pins: usb-default-pins {
+		pins-valid {
+			pinmux = <PINMUX_GPIO85__FUNC_I0_VBUSVALID>;
+			input-enable;
+		};
+	};
+};
+
+&eth {
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethernet_phy0>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&eth_default_pins>;
+	pinctrl-1 = <&eth_sleep_pins>;
+	mediatek,mac-wol;
+	mediatek,tx-delay-ps = <30>;
+	snps,reset-active-low;
+	snps,reset-delays-us = <0 11000 200000>;
+	snps,reset-gpio = <&pio 147 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&eth_mdio {
+	ethernet_phy0: ethernet-phy@3 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <3>;
+		interrupts-extended = <&pio 148 IRQ_TYPE_LEVEL_LOW>;
+		eee-broken-1000t;
+	};
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins>;
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins>;
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&i2c5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c5_pins>;
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&i2c6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c6_pins>;
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
+	status = "okay";
+};
+
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_pins_default>;
+	status = "okay";
+};
+
+&pciephy {
+	status = "okay";
+};
+
+&spi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi2_pins>;
+	mediatek,pad-select = <0>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+};
+
+&u3phy0 {
+	status = "okay";
+};
+
+&u3phy1 {
+	status = "okay";
+};
+
+&u3phy2 {
+	status = "okay";
+};
+
+&xhci1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	vusb33-supply = <&mt6359_vusb_ldo_reg>;
+	status = "okay";
+
+	hub_2_0: hub@1 {
+		compatible = "usb451,8027";
+		reg = <1>;
+		peer-hub = <&hub_3_0>;
+		reset-gpios = <&pio 7 GPIO_ACTIVE_HIGH>;
+		vdd-supply = <&reg_fixed_3v3>;
+	};
+
+	hub_3_0: hub@2 {
+		compatible = "usb451,8025";
+		reg = <2>;
+		peer-hub = <&hub_2_0>;
+		reset-gpios = <&pio 7 GPIO_ACTIVE_HIGH>;
+		vdd-supply = <&reg_fixed_3v3>;
+	};
+};
+
+&xhci2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	vusb33-supply = <&mt6359_vusb_ldo_reg>;
+	status = "okay";
+
+	hub@1 {
+		compatible = "microchip,usb2513bi";
+		reg = <1>;
+		vdd-supply = <&reg_fixed_3v3>;
+	};
+};
+
+&ssusb0 {
+	dr_mode = "peripheral";
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb_default_pins>;
+	vusb33-supply = <&mt6359_vusb_ldo_reg>;
+	status = "okay";
+};
+
+&ssusb1 {
+	dr_mode = "host";
+	maximum-speed = "super-speed";
+	vusb33-supply = <&mt6359_vusb_ldo_reg>;
+	status = "okay";
+};
+
+&ssusb2 {
+	dr_mode = "host";
+	maximum-speed = "high-speed";
+	vusb33-supply = <&mt6359_vusb_ldo_reg>;
+	status = "okay";
+};
+
+&scp_cluster {
+	status = "okay";
+};
+
+&scp_c0 {
+	memory-region = <&scp_mem>;
+	status = "okay";
+};
+
+&gpu {
+	mali-supply = <&mt6359_vproc2_buck_reg>;
+	status = "okay";
+};
+
+&adsp {
+	memory-region = <&adsp_dma_mem>, <&adsp_mem>;
+	status = "okay";
+};
+
+&afe {
+	memory-region = <&afe_dma_mem>;
+	status = "okay";
+};
+
+&sound {
+	compatible = "mediatek,mt8390-mt6359-evk", "mediatek,mt8188-mt6359-evb";
+	model = "mt8390-evk";
+	pinctrl-names = "default";
+	pinctrl-0 = <&audio_default_pins>;
+	audio-routing =
+		"Headphone", "Headphone L",
+		"Headphone", "Headphone R",
+		"AP DMIC", "AUDGLB",
+		"AP DMIC", "MIC_BIAS_0",
+		"AP DMIC", "MIC_BIAS_2",
+		"DMIC_INPUT", "AP DMIC";
+
+	mediatek,adsp = <&adsp>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-som.dtsi b/arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-som.dtsi
new file mode 100644
index 000000000000..386335c19f6c
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-som.dtsi
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2025 Grinn sp. z o.o.
+ * Author: Mateusz Koza <mateusz.koza@grinn-global.com>
+ */
+
+#include "mt6359.dtsi"
+#include <dt-bindings/input/input.h>
+
+/ {
+	aliases {
+		i2c1 = &i2c1;
+		mmc0 = &mmc0;
+	};
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&mfg0 {
+	domain-supply = <&mt6359_vproc2_buck_reg>;
+};
+
+&mfg1 {
+	domain-supply = <&mt6359_vsram_others_ldo_reg>;
+};
+
+&mmc0 {
+	status = "okay";
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc0_default_pins>;
+	pinctrl-1 = <&mmc0_uhs_pins>;
+	bus-width = <8>;
+	max-frequency = <200000000>;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	supports-cqe;
+	cap-mmc-hw-reset;
+	no-sdio;
+	no-sd;
+	hs400-ds-delay = <0x1481b>;
+	vmmc-supply = <&mt6359_vemc_1_ldo_reg>;
+	vqmmc-supply = <&mt6359_vufs_ldo_reg>;
+	non-removable;
+};
+
+&mt6359_vbbck_ldo_reg {
+	regulator-always-on;
+};
+
+&mt6359_vcn18_ldo_reg {
+	regulator-name = "vcn18_pmu";
+	regulator-always-on;
+};
+
+&mt6359_vcn33_2_bt_ldo_reg {
+	regulator-name = "vcn33_2_pmu";
+	regulator-always-on;
+};
+
+&mt6359_vcore_buck_reg {
+	regulator-name = "dvdd_proc_l";
+	regulator-always-on;
+};
+
+&mt6359_vgpu11_buck_reg {
+	regulator-name = "dvdd_core";
+	regulator-always-on;
+};
+
+&mt6359_vpa_buck_reg {
+	regulator-name = "vpa_pmu";
+	regulator-max-microvolt = <3100000>;
+};
+
+&mt6359_vproc2_buck_reg {
+	/* The name "vgpu" is required by mtk-regulator-coupler */
+	regulator-name = "vgpu";
+	regulator-min-microvolt = <550000>;
+	regulator-max-microvolt = <800000>;
+	regulator-coupled-with = <&mt6359_vsram_others_ldo_reg>;
+	regulator-coupled-max-spread = <6250>;
+};
+
+&mt6359_vpu_buck_reg {
+	regulator-name = "dvdd_adsp";
+	regulator-always-on;
+};
+
+&mt6359_vrf12_ldo_reg {
+	regulator-name = "va12_abb2_pmu";
+	regulator-always-on;
+};
+
+&mt6359_vsim1_ldo_reg {
+	regulator-name = "vsim1_pmu";
+	regulator-enable-ramp-delay = <480>;
+};
+
+&mt6359_vsram_others_ldo_reg {
+	/* The name "vsram_gpu" is required by mtk-regulator-coupler */
+	regulator-name = "vsram_gpu";
+	regulator-min-microvolt = <750000>;
+	regulator-max-microvolt = <800000>;
+	regulator-coupled-with = <&mt6359_vproc2_buck_reg>;
+	regulator-coupled-max-spread = <6250>;
+};
+
+&mt6359_vufs_ldo_reg {
+	regulator-name = "vufs18_pmu";
+	regulator-always-on;
+};
+
+&pio {
+
+	i2c1_pins: i2c1-pins {
+		pins {
+			pinmux = <PINMUX_GPIO58__FUNC_B1_SDA1>,
+				 <PINMUX_GPIO57__FUNC_B1_SCL1>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_011>;
+			drive-strength-microamp = <1000>;
+		};
+	};
+
+	mmc0_default_pins: mmc0-default-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO157__FUNC_B1_MSDC0_CLK>;
+			drive-strength = <6>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO161__FUNC_B1_MSDC0_DAT0>,
+				 <PINMUX_GPIO160__FUNC_B1_MSDC0_DAT1>,
+				 <PINMUX_GPIO159__FUNC_B1_MSDC0_DAT2>,
+				 <PINMUX_GPIO158__FUNC_B1_MSDC0_DAT3>,
+				 <PINMUX_GPIO154__FUNC_B1_MSDC0_DAT4>,
+				 <PINMUX_GPIO153__FUNC_B1_MSDC0_DAT5>,
+				 <PINMUX_GPIO152__FUNC_B1_MSDC0_DAT6>,
+				 <PINMUX_GPIO151__FUNC_B1_MSDC0_DAT7>,
+				 <PINMUX_GPIO156__FUNC_B1_MSDC0_CMD>;
+			input-enable;
+			drive-strength = <6>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-rst {
+			pinmux = <PINMUX_GPIO155__FUNC_O_MSDC0_RSTB>;
+			drive-strength = <6>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	mmc0_uhs_pins: mmc0-uhs-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO157__FUNC_B1_MSDC0_CLK>;
+			drive-strength = <8>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO161__FUNC_B1_MSDC0_DAT0>,
+				 <PINMUX_GPIO160__FUNC_B1_MSDC0_DAT1>,
+				 <PINMUX_GPIO159__FUNC_B1_MSDC0_DAT2>,
+				 <PINMUX_GPIO158__FUNC_B1_MSDC0_DAT3>,
+				 <PINMUX_GPIO154__FUNC_B1_MSDC0_DAT4>,
+				 <PINMUX_GPIO153__FUNC_B1_MSDC0_DAT5>,
+				 <PINMUX_GPIO152__FUNC_B1_MSDC0_DAT6>,
+				 <PINMUX_GPIO151__FUNC_B1_MSDC0_DAT7>,
+				 <PINMUX_GPIO156__FUNC_B1_MSDC0_CMD>;
+			input-enable;
+			drive-strength = <8>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-ds {
+			pinmux = <PINMUX_GPIO162__FUNC_B0_MSDC0_DSL>;
+			drive-strength = <8>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-rst {
+			pinmux = <PINMUX_GPIO155__FUNC_O_MSDC0_RSTB>;
+			drive-strength = <8>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+};
+
+&pmic {
+	interrupt-parent = <&pio>;
+	interrupts = <222 IRQ_TYPE_LEVEL_HIGH>;
+	interrupts-extended = <&pio 222 IRQ_TYPE_LEVEL_HIGH>;
+
+	keys {
+		compatible = "mediatek,mt6359-keys";
+		mediatek,long-press-mode = <1>;
+		power-off-time-sec = <0>;
+
+		power-key {
+			linux,keycodes = <KEY_POWER>;
+			wakeup-source;
+		};
+	};
+};
-- 
2.43.0



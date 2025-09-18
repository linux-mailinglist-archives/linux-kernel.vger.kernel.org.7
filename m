Return-Path: <linux-kernel+bounces-821879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC70AB828A3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77473327B8F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0116510957;
	Thu, 18 Sep 2025 01:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJzbzPGs"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C28322F177
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758159839; cv=none; b=ArGvxcgdxAzWdibbS21emAqfsWtQQKDVT3+9hdWK681B/L0ll/OWVb0isIjsIoswuEBYgXEucQMIJgvtNZVvEkUTVUorY2DgOgZlrD0Or+Nwee3sW7BsiVPemNdTseqNzwkbKec9B9ID+L8qen5XsdZ/RwQq1pOHKRcZFlGD0eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758159839; c=relaxed/simple;
	bh=bNzIyUpr5ia1L3tAZqbWsXhxKNm/ll0IVqDc+es+9c0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eoJfge/pXUIdZX2pddZMEhcGf5FWkKSQYuVasMypJF1eUj8l0fLCIGglMuZIgEByWf2tzaEnOKVQtGh6R+lIzaV5j6jadUmKqnnJDd5x+L7/ZEEHTgg9paiotiFTFONxLVkdrAHDEZA8W61JEX7iuEla5kmyVsZEZHY1JVv3F34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJzbzPGs; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-78e4056623fso3762816d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 18:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758159836; x=1758764636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuRqLTivCJEK+3lstpIebDv0AXkfsOSfdGRF0Dn2QDk=;
        b=HJzbzPGsV+y21VtQkaJzBT7d/2LDegGJVvwpZbqanegyNQn0HwlndC4xS/HltpVJvU
         S3opRgNaExM+mRmqML4Zfi2rfdrjUKd5hyjb3gVQ7SqLH5xdekPfMpGGhCwN4+V1W86Q
         DnYIyu8yKDF6H6ehhtcon+634URBRwK/LI/f/pEcuVZQQf5Q5BOUqHuVHRM5faffUIo0
         HYMdr2Ulbw82T6MaMbhScXpp2XROrblzJVv4hoR5doWm+7H2Nz38D73/VGWjlEWGeHAF
         ial7hY96CBmEkqH6+5gXU5U0F4WCu6pY8uTb+HoyoevPFemLcXpIo42IdXSm3D9f+oOU
         f7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758159836; x=1758764636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuRqLTivCJEK+3lstpIebDv0AXkfsOSfdGRF0Dn2QDk=;
        b=QUX1ProAYUqKKLVD0u+uC24IZMAS0buA4WWVLf/QEkdg3UJNpCntwQ10frGPNoiCH+
         sqc7mTNZTIN6irjbYFUXr84qeQL1rJG6O7pE9Ah3e8zETQLf8AZdQUQx0ozE97eW6zDn
         7TYaRBfNp4N2rtAMWgJwxsL4aZqyhEkgWXt9wrn7C9bBBXGkFDydysbwHkthMM77aSKn
         X+BmfLKTY/ArgUgLJYcCNsiA7vuMQ82dBQdpxePX7uNSYoyYZ9mq6D+2zELtnvBXjyMC
         Ncz3KhC+mCYCrMLf5fC2mYPj2aFI46Zs7nTjg65HTuwOp8s8utLqPsKvyPAuHSeVV9Ek
         +W/w==
X-Forwarded-Encrypted: i=1; AJvYcCV/YebPGYp2qYoZ0LSYbL/Z8Ly6CCJ1HaGwfqRXqx5lVToC6DG6c8rFxbqjxGwhfychVYAGF5ZKhd9PTgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrTILka0Qc3A0v2JigtGN0ykGJdCS5r3JGzdjwQTnCDPgwc4t0
	biUOJwKl9wHeCKS1PXt+urCv5BTj+sF+fxnFkeMMqju+M78gyxDZpKwY
X-Gm-Gg: ASbGncsWnhZw8XlYFKrsirWafM12Fp5PxJtRpa6zB8/lf9c1GIFdubTD8DZ6jySnD7S
	yerKjAM0Ox2HljeKagV1ung6tQ7Sr7TlDQS1woDIBmw6z9jRfwX6rSprohfUTimYGtyErEbK9nw
	a/CIqbHhRQU5FC6gEeCC5PZPTywi6Wu+X5nLkpSwp+1LHNIVeIkYEGmBwtvo3QcX2ZZpouqRQg0
	NiBwI068LoW6EnjS/A4tljgOGYq2pO+lRGhUXkfKRXSLwXEzhxJs8LJ4T8FQZGhRMNQ7GCFdHZI
	sQCdOJfvRe6ayfjUr4WZopZwY9Dc2M8WVyhMVI/CyUOgk/j/bWYtVA+4cqne4Wamrg3J2sG1By4
	zTLpqcyVD4tY+GwTJ5yNTVbEnCnb/YN28Kz2kzGKijNCCzjUNxaZ+RN7e2BA=
X-Google-Smtp-Source: AGHT+IEROA/m8D6W2SKvGkiml7WVml/VFJBm8Vna42pFHiXEvmWq8ZpLWaycYjvEyNUjVZ/JQLKZhQ==
X-Received: by 2002:ad4:5ec5:0:b0:786:8f81:43e with SMTP id 6a1803df08f44-78eceb32c77mr33955806d6.33.1758159835923;
        Wed, 17 Sep 2025 18:43:55 -0700 (PDT)
Received: from rogerio-laptop.home ([184.148.194.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-79346930bbesm5191506d6.17.2025.09.17.18.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:43:55 -0700 (PDT)
From: Rogerio Pimentel <rpimentel.silva@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	alexander.stein@ew.tq-group.com,
	dario.binacchi@amarulasolutions.com,
	marex@denx.de,
	Markus.Niebel@tq-group.com,
	y.moog@phytec.de,
	joao.goncalves@toradex.com,
	frieder.schrempf@kontron.de,
	josua@solid-run.com,
	francesco.dolcini@toradex.com,
	primoz.fiser@norik.com,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rogerio Pimentel <rpimentel.silva@gmail.com>
Subject: [PATCH 2/2] arm64: dts: add support for NXP i.MX8MP FRDM board
Date: Wed, 17 Sep 2025 21:40:53 -0400
Message-Id: <20250918014053.696710-2-rpimentel.silva@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250918014053.696710-1-rpimentel.silva@gmail.com>
References: <20250918014053.696710-1-rpimentel.silva@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FRDM-i.MX8MP is an NXP development platform based on the i.MX8M Plus
SoC, featuring a quad Cortex-A53, Cortex-M7 co-processor, 4GB LPDDR4,
32GB eMMC, Wi-Fi 6/Bluetooth 5.4/802.15.4 tri-radio, Ethernet, HDMI/MIPI
display interfaces, camera connectors, and standard expansion headers.

Based on the device tree found in the NXP repository at github
https://github.com/nxp-imx-support/meta-imx-frdm and on imx8mp-evk
board kernel mainline device tree.

This is a basic device tree supporting:

 - Quad Cortex-A53
 - 4GB LPDDR4 DRAM
 - PCA9450C PMIC with regulators
 - Two NXP PCAL6416 GPIO expanders
 - RGB LEDs via GPIO expander
 - I2C1, I2C2, I2C3 controllers
 - UART2 (console) and UART3 (with RTS/CTS)
 - USDHC3 (8-bit eMMC)
 - SNVS power key (onboard power button)

Signed-off-by: Rogerio Pimentel <rpimentel.silva@gmail.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 arch/arm64/boot/dts/freescale/imx8mp-frdm.dts | 351 ++++++++++++++++++
 2 files changed, 352 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-frdm.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 525ef180481d..d861e576779a 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -206,6 +206,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-pdk3.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-picoitx.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-edm-g-wb.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-frdm.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-hummingboard-mate.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-hummingboard-pro.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-hummingboard-pulse.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-frdm.dts b/arch/arm64/boot/dts/freescale/imx8mp-frdm.dts
new file mode 100644
index 000000000000..a10e458365c5
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-frdm.dts
@@ -0,0 +1,351 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/dts-v1/;
+
+#include "imx8mp.dtsi"
+
+/ {
+	model = "NXP i.MX8MPlus FRDM board";
+	compatible = "fsl,imx8mp-frdm", "fsl,imx8mp";
+
+	chosen {
+		stdout-path = &uart2;
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		red {
+			label = "led-0";
+			gpios = <&pcal6416 13 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		green {
+			label = "led-1";
+			gpios = <&pcal6416 14 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+
+		blue {
+			label = "led-2";
+			gpios = <&pcal6416 15 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x0 0x40000000 0 0xc0000000>,
+		      <0x1 0x00000000 0 0x40000000>;
+	};
+};
+
+&A53_0 {
+	cpu-supply = <&reg_arm>;
+};
+
+&A53_1 {
+	cpu-supply = <&reg_arm>;
+};
+
+&A53_2 {
+	cpu-supply = <&reg_arm>;
+};
+
+&A53_3 {
+	cpu-supply = <&reg_arm>;
+};
+
+&i2c1 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	pmic@25 {
+		compatible = "nxp,pca9450c";
+		reg = <0x25>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pmic>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+
+		regulators {
+			BUCK1 {
+				regulator-name = "BUCK1";
+				regulator-min-microvolt = <720000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			reg_arm: BUCK2 {
+				regulator-name = "BUCK2";
+				regulator-min-microvolt = <720000>;
+				regulator-max-microvolt = <1025000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+				nxp,dvs-run-voltage = <950000>;
+				nxp,dvs-standby-voltage = <850000>;
+			};
+
+			BUCK4 {
+				regulator-name = "BUCK4";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3600000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			reg_buck5: BUCK5 {
+				regulator-name = "BUCK5";
+				regulator-min-microvolt = <1650000>;
+				regulator-max-microvolt = <1950000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			BUCK6 {
+				regulator-name = "BUCK6";
+				regulator-min-microvolt = <1045000>;
+				regulator-max-microvolt = <1155000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			LDO1 {
+				regulator-name = "LDO1";
+				regulator-min-microvolt = <1650000>;
+				regulator-max-microvolt = <1950000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			LDO3 {
+				regulator-name = "LDO3";
+				regulator-min-microvolt = <1710000>;
+				regulator-max-microvolt = <1890000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			LDO5 {
+				regulator-name = "LDO5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+
+	pcal6416: gpio@20 {
+		compatible = "nxp,pcal6416";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pcal6416_int>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names = "CSI1_nRST",
+			"CSI2_nRST",
+			"DSI_CTP_RST",
+			"EXT_PWREN1",
+			"CAN_STBY",
+			"EXP_P0_5",
+			"EXP_P0_6",
+			"P0_7",
+			"LVDS0_BLT_EN",
+			"LVDS1_BLT_EN",
+			"LVDS0_CTP_RST",
+			"LVDS1_CTP_RST",
+			"SPK_PWREN",
+			"RLED_GPIO",
+			"GLED_GPIO",
+			"BLED_GPIO";
+	};
+
+	pcal6416_1: gpio@21 {
+		compatible = "nxp,pcal6416";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pcal6416_1_int>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names = "P0_0",
+			"P0_1",
+			"AUD_nINT",
+			"RTC_nINTA",
+			"USB1_SS_SEL",
+			"USB2_PWR_EN",
+			"SPI_EXP_SEL",
+			"P0_7",
+			"W2_HOST_WAKE_SD_3V3",
+			"W2_HOST_WAKE_BT_3V3",
+			"EXP_WIFI_BT_PDN_3V3",
+			"EXP_BT_RST_3V3",
+			"W2_RST_IND_3V3",
+			"SPI_nINT_3V3",
+			"KEYM_PCIE_nWAKE",
+			"P1_7";
+	};
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+};
+
+&i2c3 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+};
+
+&snvs_pwrkey {
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	assigned-clocks = <&clk IMX8MP_CLK_UART3>;
+	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_80M>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&usdhc3 {
+	assigned-clocks = <&clk IMX8MP_CLK_USDHC3>;
+	assigned-clock-rates = <400000000>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL	0x400001c2
+			MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA	0x400001c2
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL	0x400001c2
+			MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA	0x400001c2
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL	0x400001c2
+			MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA	0x400001c2
+		>;
+	};
+
+	pinctrl_pmic: pmicgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO03__GPIO1_IO03	0x000001c0
+		>;
+	};
+
+	pinctrl_pcal6416_int: pcal6416_int_grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16	0x146
+		>;
+	};
+
+	pinctrl_pcal6416_1_int: pcal6416_1_int_grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD1_STROBE__GPIO2_IO11	0x146
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX	0x140
+			MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX	0x140
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI1_SCLK__UART3_DCE_RX	0x140
+			MX8MP_IOMUXC_ECSPI1_MOSI__UART3_DCE_TX	0x140
+			MX8MP_IOMUXC_ECSPI1_SS0__UART3_DCE_RTS	0x140
+			MX8MP_IOMUXC_ECSPI1_MISO__UART3_DCE_CTS	0x140
+		>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x190
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d0
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d0
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d0
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d0
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d0
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d0
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d0
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d0
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d0
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x190
+		>;
+	};
+
+	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x194
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d4
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d4
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d4
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d4
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d4
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d4
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d4
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d4
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d4
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x194
+		>;
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x196
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d6
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d6
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d6
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d6
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d6
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d6
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d6
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d6
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d6
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x196
+		>;
+	};
+};
-- 
2.25.1



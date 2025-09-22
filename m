Return-Path: <linux-kernel+bounces-827976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36ECBB93919
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 01:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E4A43BB84E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5A6313535;
	Mon, 22 Sep 2025 23:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bu/UMA6N"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6FB2F90DE
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 23:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758583554; cv=none; b=bSdtmIeKYWXBIPoHX2laWPjnrYDCYaU+Rs9u84bScDzBl6B2IV/XxT+9Sa5R6ZuuLUM3MrWeDBJ+f5TJwNJ5cJa+/1RasMwyghjvmE5TkZ0qVRLEvxRcN9U9Tu61dSF1rcAnmf5svSb2EFxjBWg/Fw5xNKO63QlONA5+oJ4IRp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758583554; c=relaxed/simple;
	bh=2oXJdFS6bPx/EnfXZBBHIDEeYnIjEqZaxbLAXXpINgg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R/DfmsJCLjZ+Ctl4mhVc15YZF9d3+XTT4bN/wJrU3NEUQVDjmZ1eL4487g1kL2JrgbOUjPYauObEu9tEbRuMvgyzgUW2iUM9dbKRHjtWQ0/FjTMPp5LVKNI7hlWTU4DJocZAXjBE0DwMn5MXZeyiR0QHNVa030nnR4N3/j+annA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bu/UMA6N; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-78f15d5846dso56063816d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 16:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758583551; x=1759188351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqDcNUIBawkipTP5CkXmOKQLiiFN8B5Af0GuOgOepp8=;
        b=bu/UMA6N3u9wyiEQ+3sNK47BT49r4iFKuj3KQn1U+fG5sNEFhZzewSaGw9Dih5iD+4
         jf6OoeoeHXxOc2MpR9v32ExkscPSotGvGuBjJDzRn7Kq5UDhBwFfPz9rvz7Gsj0HtrM5
         +mSP4JuY6WElsg797J1tQdw2ITXEG5AuXh5BS1xYh3fWbJ80IrWoNSPFOE9nPMsVzM0I
         53VhqjJYB6l8k1LFBvqspplVBoS/UwyhJhy4t2JPEW4Jg7HVQpn7ryNO4LIyWJ7Vcyjq
         8cycKthxeyfVKam2M6bGmJgBIi0+mT4jcJE7NMK6idLMUFKcV2tGCFN8tkJRFZQw/v9Y
         yCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758583551; x=1759188351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QqDcNUIBawkipTP5CkXmOKQLiiFN8B5Af0GuOgOepp8=;
        b=S3WnR9A3Ohqff0HylVb042aRdHjFImOl3umfBtA1w3mI0kiMaw9GySECr1S1C7eJsa
         G/QbSoLQQZvG1kMXnLy60HV+1y1XjzlQeMuG+ug9Zgx3sLZ5hh5Y/SQQUNjvjOwQKqXl
         /I7gJadtJlpydc+BFdfJUMA5Epd4lA8GVFKhfVp1VUjbxNCFJWXDn5Qzmp0xPbYNjx55
         oi8f+HEzYvQ7lz9YNDZht8Q+5HFM/a3Y4nsm8M4AnABOFrYU/mZqbsnO+85hGkLK49HL
         Emsieou7+cbKsu2eqyD+EvRfun9zNbN8h/Doq+ga4rW6ltwPdzo+Nkg2BZwzfyecIuET
         zOLg==
X-Forwarded-Encrypted: i=1; AJvYcCXc9Ol39tOPN0+C9qaW159v4c4+hPQODJxY2WCVKMhXA0YOldJZWabeV5fc+TuRP9g4MznI3pwzL8yRZXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKPQ0lc2XpHrAF+nUTiSbz7+gP4M/wXb4XlMRZt+BJRG70ZKzy
	91HRvs8QcjMfJaTCbRnFb89jusx6jqRb5z0HtEaV+DUWWNh6InDjvxXy
X-Gm-Gg: ASbGncuVT6kcyBh1STJ4S+YejQGr4Af29Wtrlv3PWsp0l4u6lO/BvKSNuYlIER1+5cm
	DjVDjUFwGGRXJykhmRfO52QmjRCxVo2y/k04xYGcLrT5hk05sOC1iOYTeK1ty40avKO0vWAF6Yt
	4+hFPdObfxnlbPPfYYElfcPo260wtL5LI36mR3LN3ZVvVpJgKH7cIZeFU8KSBTP0MNxBseg3mVE
	u2MsjKJeIEV5IcjMq/lcUDc1UmKSP00Qho659+ZdxLDZFkw+sSzaTtm52GB5Km8ziUgtbTpKF6n
	hFlwlcltb4DOamyrQ46yIdy+G3YuMKp2mY6OsBEnkCdAvdgxOBao2CV1BXTToG3t5f8IBmzQt1e
	TMX9ez8y2zC1J1mChsRwILJvFPnouR9yNNR9zbANzewd7BKVhQ3s=
X-Google-Smtp-Source: AGHT+IGGKLhJ8kP1QE5HCy2Az2EbzFRWJVlyQUwKQa65vVNfRMnPcmZloRlZ6iw8ReNQXBizmtntOQ==
X-Received: by 2002:a05:6214:5287:b0:76f:6972:bb89 with SMTP id 6a1803df08f44-7e6ff32db1dmr6345156d6.9.1758583551023;
        Mon, 22 Sep 2025 16:25:51 -0700 (PDT)
Received: from rogerio-laptop.home ([184.148.194.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-793548c63desm79417226d6.57.2025.09.22.16.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 16:25:50 -0700 (PDT)
From: Rogerio Pimentel <rpimentel.silva@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: xiaofeng.wei@nxp.com,
	kernel@pengutronix.de,
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
	Rogerio Pimentel <rpimentel.silva@gmail.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v3 2/2] arm64: dts: add support for NXP i.MX8MP FRDM board
Date: Mon, 22 Sep 2025 19:25:23 -0400
Message-Id: <20250922232523.844633-2-rpimentel.silva@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250922232523.844633-1-rpimentel.silva@gmail.com>
References: <20250922232523.844633-1-rpimentel.silva@gmail.com>
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

Signed-off-by: Xiaofeng Wei <xiaofeng.wei@nxp.com>
Signed-off-by: Rogerio Pimentel <rpimentel.silva@gmail.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>

---

Changes in v3:

 - Removing the following tags and names added
 on v2 by mistake: 
 Reviewed-by: Daniel Baluta <daniel.baluta@gmail.com>
 Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
 Signed-off-by: Shawn Guo <shawnguo@kernel.org>

Changes in v2:

 - Fixed dt-binding schema warnings
 - Renamed nodes 'red, green and blue' to
   'led-0, led-1 and led-2'
 - Renamed led labels 'led-0, led-1 and led-2'
   to 'red, green and blue'
 - Added Reviewed-by and Signed-off-by tags
 
 
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 arch/arm64/boot/dts/freescale/imx8mp-frdm.dts | 355 ++++++++++++++++++
 2 files changed, 356 insertions(+)
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
index 000000000000..9138c65739aa
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-frdm.dts
@@ -0,0 +1,355 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2019 NXP
+ */
+
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
+		led-0 {
+			label = "red";
+			gpios = <&pcal6416 13 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led-1 {
+			label = "green";
+			gpios = <&pcal6416 14 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+
+		led-2 {
+			label = "blue";
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



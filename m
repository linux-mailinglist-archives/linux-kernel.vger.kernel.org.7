Return-Path: <linux-kernel+bounces-809087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB52B50852
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 23:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 590195639B0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62CA264619;
	Tue,  9 Sep 2025 21:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cExYLDtz"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C96125CC40;
	Tue,  9 Sep 2025 21:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757453899; cv=none; b=JcUix29nbkmeA/s0OJ2yEoaIcnDFT2N78h3KhpShSixIMu30IyRNsztEeMhJ6FwP2Mh48iHcPIeHOISeJTumOa3Cl3/3XxckVhnMERSCm/y6U8xipN9m7VZd3SLPelImR8+c4pIaLzRUX2aSyo82w+quFqu+SYr+db2TK25vIvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757453899; c=relaxed/simple;
	bh=1tve5L9l/WXmdrvOgSVw0B1SnxQ9F2fHCMn4BAVU6OA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YMThsvEJrwPtIEvutcvGhSbDM3vn0J9dkjcrQ8UPUa2f1egRrFv5ZaJV83x1RFJtKARQOjZezxBcXRhWj2rAx00tjnx2AYwOPwLJsGeAWa7HC68o3aGWtjK4mtIGz1HKxpuE61224Eu/+Nu18pDlKuyjxpwuFOrPKh6fOTA/AMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cExYLDtz; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45dec026c78so17529655e9.0;
        Tue, 09 Sep 2025 14:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757453895; x=1758058695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oc76nh6RCNtyyoFGHTzLc7SYIzzj/yp/UHrxWmPOq8=;
        b=cExYLDtz2UkqliEDQt3D/wkoiTKBnXyKJ/rkTUSTH7Ff2Ig4UgvImMYpPaw7R/dVxa
         MiWYYFYpq+JfhNWo01p5THCXv5ZorNEJ+m6dHWhaYRVkE6xmXE7jpv7hglcoSzfxezAg
         UxNHg33eNI8VDNjyIh+NAFdsyevnrmI4SrkcDavbTHn+sA5oWFbKllDWnbDfT80fGpr5
         UIC9V0+I1ezeBh2imbswjc/6+8URO438TdQ4Go9Pwb/MrUBBq7Ksjy0igL8M5JaPpR5e
         4R5Dxpo4LK3aZy4upsWTHeh14S0353GC/IaQTAKH84HCl93V85nMiTS4zFZ1AUIEzUTU
         5GzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757453895; x=1758058695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3oc76nh6RCNtyyoFGHTzLc7SYIzzj/yp/UHrxWmPOq8=;
        b=q2tbXmqvgZyrjkLhVS+6t+qRE1mJbSCAK/HFiTxKHFzVOYVdL5jZAjs03+VR/oiAlj
         ur0AOVpjFGQxlTNHJAtgg5udvhIUa/8UOiJLiJR7WeVDlX/n6nNy0WXGPrT8QPs45hut
         QmTJ9QrcvbMlEwEPrzC4DvVLCmLbsjM3E0YpCrFLDLoUIVX2dy/csAwfglcjRXJnKBxR
         XqW6o35+zC2ONnsZQfc75B54X/CnakAzSJBY4Zk9ugSolySrVdeIJIGNu60ILnFVhusP
         jXwLE/hPkGmYl2f7ctS6XVUXssJr82pymnUgibX0RzJHvDAE3r1pjn11v/w5xH/uQGYb
         Fq1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXkT8NRilBoD/edpOCM+2sqfggyn9CCUPBqXL6cndQb6ghMwXL2QboDAzlTCJd18PaDHDQDmbvfKgge3yI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUgq1uzkAK0OJ9qSAQaO04hRNMPnp/0Am71gKw4dplDdETQzEp
	PISpmWUsdhGgTpfrBFwRfrtJg7fzzRR+83sBjB+ipFuzQ38ds9tk+I1x0MONUC+O
X-Gm-Gg: ASbGnctJCVS/eNs48HD6XfUkNCDZ9tyGMl7Ac/Ght1bZFNH/NP/gsNWODQGoPRP/5Aq
	f6J90/Uucz7mBUlN3towhRxUZl80VzkmU61tukMs3DHlQlAK7qs+zfPFY0T8+PpM9Pt9KLj45jq
	7rTu45K7bgQsJPc8LmkUDmO/vZAPwC0rd7rtMkD6MvKzr5UKStws/jPcSTeQUmJGrAw25gtjlPg
	nZ7ZjFNI5UatNdtKudnyIpPHiLE/24In+4nejYgKK34bP655sBwiHkvL9LOHvro3LsCKe+Srsni
	RC0HlfS6PBd/jxqoYxiHbjCx5A6qj7SxBnHSnfZq16UkgJzXg8J9CXP+ZdEXmDE83OQCgldrAEV
	GJFZ81tbdzjx5ZatzUKwguV5DsXq7AQiavhsTT3HjjN9vR4kbgUPZ1pgAZw==
X-Google-Smtp-Source: AGHT+IH76919hAx94tywZ8SSIo23wGjEkmjmRg4ysRmzXl+yh4qPw4dZ8uRMShfqMC+BNS4n34fpUg==
X-Received: by 2002:a05:600c:5493:b0:45d:98be:ee9e with SMTP id 5b1f17b1804b1-45ddde6a3f0mr105795995e9.1.1757453894620;
        Tue, 09 Sep 2025 14:38:14 -0700 (PDT)
Received: from localhost.localdomain ([151.84.244.111])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df81cbb08sm2315165e9.2.2025.09.09.14.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 14:38:14 -0700 (PDT)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Stefano Radaelli <stefano.radaelli21@gmail.com>,
	Judith Mendez <jm@ti.com>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 3/3] arm64: dts: ti: var-som-am62p: Add support for Variscite Symphony Board
Date: Tue,  9 Sep 2025 23:37:41 +0200
Message-ID: <20250909213749.28098-4-stefano.radaelli21@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250909213749.28098-1-stefano.radaelli21@gmail.com>
References: <20250909213749.28098-1-stefano.radaelli21@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree support for the Variscite Symphony carrier board with
the VAR-SOM-AM62P system on module.

The Symphony board includes
- uSD Card support
- USB ports and OTG
- Additional Gigabit Ethernet interface
- Uart interfaces
- OV5640 Camera support
- GPIO Expander
- CAN, I2C and general purpose interfaces

Link: https://www.variscite.it/product/single-board-computers/symphony-board/

Signed-off-by: Stefano Radaelli <stefano.radaelli21@gmail.com>
Reviewed-by: Judith Mendez <jm@ti.com>
---
v6:
 - Fixed wrong pinmux for uSD, external pullup already mounted on DATA lines
v5:
 - Update to match up with coding guidelines for device tree
v4:
 - Moved every MCUs-related node into the SOM dtsi
v3:
 - Change compatible string to match existing mainline format
 - Fixed underscore typo
v2:
 - Fixed warnings and cleanup

 arch/arm64/boot/dts/ti/Makefile               |   1 +
 .../dts/ti/k3-am62p5-var-som-symphony.dts     | 500 ++++++++++++++++++
 2 files changed, 501 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dts

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index aad9177930e6..b11cbf33422d 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -38,6 +38,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62d2-evm.dtb
 
 # Boards with AM62Px SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am62p5-sk.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am62p5-var-som-symphony.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am62p5-verdin-nonwifi-dahlia.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am62p5-verdin-nonwifi-dev.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am62p5-verdin-nonwifi-ivy.dtb
diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dts b/arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dts
new file mode 100644
index 000000000000..4bb92fde6ab8
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dts
@@ -0,0 +1,500 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Variscite Symphony carrier board for VAR-SOM-AM62P
+ *
+ * Link: https://www.variscite.it/product/single-board-computers/symphony-board/
+ *
+ * Copyright (C) 2025 Variscite Ltd. - https://www.variscite.com/
+ *
+ */
+
+/dts-v1/;
+
+#include "k3-am62p5-var-som.dtsi"
+
+/ {
+	model = "Variscite VAR-SOM-AM62P on Symphony-Board";
+	compatible = "variscite,var-som-am62p-symphony", "variscite,var-som-am62p", "ti,am62p5";
+
+	aliases {
+		ethernet0 = &cpsw_port1;
+		ethernet1 = &cpsw_port2;
+		mmc0 = &sdhci0;
+		mmc1 = &sdhci1;
+		mmc2 = &sdhci2;
+		serial0 = &main_uart0;
+		serial2 = &main_uart2;
+		serial5 = &main_uart5;
+		serial6 = &main_uart6;
+		spi5 = &main_spi2;
+		usb0 = &usb0;
+		usb1 = &usb1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	clk_ov5640_fixed: clock-24000000 {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		button-back {
+			label = "Back";
+			linux,code = <KEY_BACK>;
+			gpios = <&pca9534 1 GPIO_ACTIVE_LOW>;
+		};
+
+		button-home {
+			label = "Home";
+			linux,code = <KEY_HOME>;
+			gpios = <&pca9534 2 GPIO_ACTIVE_LOW>;
+		};
+
+		button-menu {
+			label = "Menu";
+			linux,code = <KEY_MENU>;
+			gpios = <&pca9534 3 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		led-heartbeat {
+			label = "Heartbeat";
+			linux,default-trigger = "heartbeat";
+			gpios = <&pca9534 0 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	reg_2p8v: regulator-2p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "2P8V";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		vin-supply = <&reg_3v3>;
+		regulator-always-on;
+	};
+
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "1P8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&reg_3v3>;
+		regulator-always-on;
+	};
+
+	reg_1p5v: regulator-1p5v {
+		compatible = "regulator-fixed";
+		regulator-name = "1P5V";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+		vin-supply = <&reg_3v3>;
+		regulator-always-on;
+	};
+
+	reg_sdhc1_vmmc: regulator-sdhc1 {
+		compatible = "regulator-fixed";
+		regulator-name = "+V3.3_SD";
+		vin-supply = <&reg_sdhc1_vmmc_int>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&main_gpio0 30 GPIO_ACTIVE_HIGH>;
+		bootph-all;
+	};
+
+	reg_sdhc1_vmmc_int: regulator-sdhc1-int {
+		compatible = "regulator-fixed";
+		regulator-name = "+V3.3_SD_INT";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_sd1_vmmc>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&main_gpio0 53 GPIO_ACTIVE_HIGH>;
+		bootph-all;
+	};
+
+	reg_sdhc1_vqmmc: regulator-sdhci1-vqmmc {
+		compatible = "regulator-gpio";
+		regulator-name = "+V3.3_SD_VQMMC";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_sd1_vqmmc>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		gpios = <&main_gpio0 56 GPIO_ACTIVE_HIGH>;
+		states = <1800000 0x0>,
+			 <3300000 0x1>;
+		bootph-all;
+	};
+
+	reg_ov5640_buf_en: regulator-camera-buf-en {
+		compatible = "regulator-fixed";
+		regulator-name = "ov5640_buf_en";
+		gpios = <&main_gpio0 21 GPIO_ACTIVE_HIGH>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	transceiver1: can-phy {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+	};
+
+	connector {
+		compatible = "gpio-usb-b-connector", "usb-b-connector";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_extcon>;
+		label = "USB-C";
+		id-gpios = <&main_gpio1 12 GPIO_ACTIVE_HIGH>;
+		status = "okay";
+
+		port {
+			usb_con_hs: endpoint {
+				remote-endpoint = <&typec_hs>;
+			};
+		};
+	};
+};
+
+&cdns_csi2rx0 {
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		csi0_port0: port@0 {
+			reg = <0>;
+			status = "okay";
+
+			csi2rx0_in_sensor: endpoint {
+				remote-endpoint = <&csi2_cam0>;
+				bus-type = <4>; /* CSI2 DPHY. */
+				clock-lanes = <0>;
+				data-lanes = <1 2>;
+			};
+		};
+	};
+};
+
+&cpsw3g {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii1>,
+		    <&pinctrl_rgmii2>;
+	status = "okay";
+};
+
+&cpsw3g_mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mdio1>;
+	status = "okay";
+
+	cpsw3g_phy1: ethernet-phy@5 {
+		compatible = "ethernet-phy-id0283.bc30";
+		reg = <5>;
+		reset-gpios = <&pca9534 5 GPIO_ACTIVE_LOW>;
+		reset-assert-us = <10000>;
+		reset-deassert-us = <100000>;
+	};
+};
+
+&cpsw_port2 {
+	/*
+	 * The required RGMII TX and RX 2ns delays are implemented directly
+	 * in hardware via passive delay elements on the Symphony PCB.
+	 * No delay configuration is needed in software via PHY driver.
+	 */
+	phy-mode = "rgmii";
+	phy-handle = <&cpsw3g_phy1>;
+	status = "okay";
+};
+
+&dphy0 {
+	status = "okay";
+};
+
+&main_i2c0{
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c0>;
+	clock-frequency = <400000>;
+	status = "okay";
+
+	ov5640: camera@3c {
+		compatible = "ovti,ov5640";
+		reg = <0x3c>;
+		clocks = <&clk_ov5640_fixed>;
+		clock-names = "xclk";
+		AVDD-supply = <&reg_2p8v>;
+		DOVDD-supply = <&reg_1p8v>;
+		DVDD-supply = <&reg_1p5v>;
+		powerdown-gpios = <&main_gpio0 10 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&main_gpio0 22 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ov5640>;
+
+		port {
+			csi2_cam0: endpoint {
+				remote-endpoint = <&csi2rx0_in_sensor>;
+				clock-lanes = <0>;
+				data-lanes = <1 2>;
+			};
+		};
+	};
+
+	/* GPIO expander */
+	pca9534: gpio@20 {
+		compatible = "nxp,pca9534";
+		reg = <0x20>;
+		gpio-controller;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pca9534>;
+		interrupt-parent = <&main_gpio1>;
+		interrupts = <30 IRQ_TYPE_EDGE_FALLING>;
+		#gpio-cells = <2>;
+		status = "okay";
+
+		usb3-sel-hog {
+			gpio-hog;
+			gpios = <4 0>;
+			output-low;
+			line-name = "usb3_sel";
+		};
+
+		eth-som-vselect-hog {
+			gpio-hog;
+			gpios = <6 0>;
+			output-low;
+			line-name = "eth-vselect";
+		};
+
+		eth-mdio-enable-hog {
+			gpio-hog;
+			gpios = <7 0>;
+			output-high;
+			line-name = "eth-mdio-enable";
+		};
+	};
+};
+
+&main_i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	clock-frequency = <400000>;
+	status = "okay";
+
+	rtc@68 {
+		compatible = "dallas,ds1337";
+		reg = <0x68>;
+	};
+};
+
+&main_mcan0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mcan0>;
+	phys = <&transceiver1>;
+	status = "okay";
+};
+
+&main_pmx0 {
+	pinctrl_extcon: main-extcon-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x01a8, PIN_INPUT, 7) /* (F25) MCASP0_AFSX.GPIO1_12 */
+		>;
+	};
+
+	pinctrl_i2c0: main-i2c0-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x01e0, PIN_INPUT_PULLUP, 0) /* (B25) I2C0_SCL */
+			AM62PX_IOPAD(0x01e4, PIN_INPUT_PULLUP, 0) /* (A24) I2C0_SDA */
+		>;
+	};
+
+	pinctrl_i2c1: main-i2c1-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x01e8, PIN_INPUT_PULLUP, 0) /* (C24) I2C1_SCL */
+			AM62PX_IOPAD(0x01ec, PIN_INPUT_PULLUP, 0) /* (B24) I2C1_SDA */
+		>;
+		bootph-all;
+	};
+
+	pinctrl_mcan0: main-mcan0-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x01dc, PIN_INPUT, 0) /* (F20) MCAN0_RX */
+			AM62PX_IOPAD(0x01d8, PIN_OUTPUT, 0) /* (B23) MCAN0_TX */
+		>;
+	};
+
+	pinctrl_mmc1: main-mmc1-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x023c, PIN_INPUT, 0) /* (H20) MMC1_CMD */
+			AM62PX_IOPAD(0x0234, PIN_OUTPUT, 0) /* (J24) MMC1_CLK */
+			AM62PX_IOPAD(0x0230, PIN_INPUT, 0) /* (H21) MMC1_DAT0 */
+			AM62PX_IOPAD(0x022c, PIN_INPUT, 0) /* (H23) MMC1_DAT1 */
+			AM62PX_IOPAD(0x0228, PIN_INPUT, 0) /* (H22) MMC1_DAT2 */
+			AM62PX_IOPAD(0x0224, PIN_INPUT, 0) /* (H25) MMC1_DAT3 */
+			AM62PX_IOPAD(0x0240, PIN_INPUT, 0) /* (D23) MMC1_SDCD */
+		>;
+		bootph-all;
+	};
+
+	pinctrl_rgmii2: main-rgmii2-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0184, PIN_INPUT, 0) /* (E19) RGMII2_RD0 */
+			AM62PX_IOPAD(0x0188, PIN_INPUT, 0) /* (E16) RGMII2_RD1 */
+			AM62PX_IOPAD(0x018c, PIN_INPUT, 0) /* (E17) RGMII2_RD2 */
+			AM62PX_IOPAD(0x0190, PIN_INPUT, 0) /* (C19) RGMII2_RD3 */
+			AM62PX_IOPAD(0x0180, PIN_INPUT, 0) /* (D19) RGMII2_RXC */
+			AM62PX_IOPAD(0x017c, PIN_INPUT, 0) /* (F19) RGMII2_RX_CTL */
+			AM62PX_IOPAD(0x016c, PIN_INPUT, 0) /* (B19) RGMII2_TD0 */
+			AM62PX_IOPAD(0x0170, PIN_INPUT, 0) /* (A21) RGMII2_TD1 */
+			AM62PX_IOPAD(0x0174, PIN_INPUT, 0) /* (D17) RGMII2_TD2 */
+			AM62PX_IOPAD(0x0178, PIN_INPUT, 0) /* (A19) RGMII2_TD3 */
+			AM62PX_IOPAD(0x0168, PIN_INPUT_PULLDOWN, 0) /* (D16) RGMII2_TXC */
+			AM62PX_IOPAD(0x0164, PIN_INPUT, 0) /* (A20) RGMII2_TX_CTL */
+		>;
+	};
+
+	pinctrl_spi2: main-spi2-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x01b0, PIN_INPUT, 1) /* (G20) MCASP0_ACLKR.SPI2_CLK */
+			AM62PX_IOPAD(0x0194, PIN_OUTPUT, 1) /* (D25) MCASP0_AXR3.SPI2_D0 */
+			AM62PX_IOPAD(0x0198, PIN_INPUT, 1) /* (E25) MCASP0_AXR2.SPI2_D1 */
+			AM62PX_IOPAD(0x01ac, PIN_OUTPUT, 7) /* (G23) MCASP0_AFSR.GPIO1_13 */
+		>;
+	};
+
+	pinctrl_uart0: main-uart0-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x1c8, PIN_INPUT, 0)	/* (A22) UART0_RXD */
+			AM62PX_IOPAD(0x1cc, PIN_OUTPUT, 0)	/* (B22) UART0_TXD */
+		>;
+		bootph-all;
+	};
+
+	pinctrl_uart2: main-uart2-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x005c, PIN_INPUT_PULLUP, 2) /* (AC25) GPMC0_AD8.UART2_RXD */
+			AM62PX_IOPAD(0x0060, PIN_OUTPUT, 2) /* (AB25) GPMC0_AD9.UART2_TXD */
+		>;
+	};
+
+	pinctrl_uart6: main-uart6-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x009c, PIN_INPUT_PULLUP, 3) /* (AD24) GPMC0_WAIT1.UART6_RXD */
+			AM62PX_IOPAD(0x0244, PIN_OUTPUT, 1) /* (D24) MMC1_SDWP.UART6_TXD */
+		>;
+	};
+
+	pinctrl_usb1: main-usb1-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0258, PIN_OUTPUT, 0) /* (G21) USB1_DRVVBUS */
+		>;
+	};
+
+	pinctrl_ov5640: main-ov5640-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0028, PIN_OUTPUT, 7) /* (N20) OSPI0_D7.GPIO0_10 */
+			AM62PX_IOPAD(0x0054, PIN_OUTPUT, 7) /* (V24) GPMC0_AD6.GPIO0_21 */
+			AM62PX_IOPAD(0x0058, PIN_OUTPUT, 7) /* (W25) GPMC0_AD7.GPIO0_22 */
+		>;
+	};
+
+	pinctrl_pca9534: main-pca9534-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x01f0, PIN_INPUT, 7) /* (C25) EXT_REFCLK1.GPIO1_30 */
+		>;
+	};
+
+	pinctrl_sd1_vmmc: main-sd1-vmmc-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0078, PIN_OUTPUT, 7) /* (AC24) GPMC0_AD15.GPIO0_30 */
+			AM62PX_IOPAD(0x00d8, PIN_OUTPUT, 7) /* (AE22) VOUT0_DATA8.GPIO0_53 */
+		>;
+		bootph-all;
+	};
+
+	pinctrl_sd1_vqmmc: main-sd1-vqmmc-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x00e4, PIN_OUTPUT, 7) /* (AE21) VOUT0_DATA11.GPIO0_56 */
+		>;
+		bootph-all;
+	};
+};
+
+&main_spi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi2>;
+	ti,pindir-d0-out-d1-in;
+	cs-gpios = <&main_gpio1 13 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&main_uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart0>;
+	status = "okay";
+};
+
+&main_uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
+};
+
+&main_uart6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart6>;
+	status = "okay";
+};
+
+&sdhci1 {
+	/* SD Card */
+	vmmc-supply = <&reg_sdhc1_vmmc>;
+	vqmmc-supply = <&reg_sdhc1_vqmmc>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mmc1>;
+	disable-wp;
+	bootph-all;
+	status="okay";
+};
+
+&ti_csi2rx0 {
+	status = "okay";
+};
+
+&usb0 {
+	usb-role-switch;
+	status = "okay";
+
+	port {
+		typec_hs: endpoint {
+			remote-endpoint = <&usb_con_hs>;
+		};
+	};
+};
+
+&usb1 {
+	dr_mode = "host";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb1>;
+	status = "okay";
+};
+
+&usbss0 {
+	status = "okay";
+};
+
+&usbss1 {
+	status = "okay";
+};
-- 
2.47.3



Return-Path: <linux-kernel+bounces-722232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C86AFD6B5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CA8E567FFC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21CA2E717D;
	Tue,  8 Jul 2025 18:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kd5p1e2t"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96862E6D08;
	Tue,  8 Jul 2025 18:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752000581; cv=none; b=nx77/xhF5tZ0ycHc8NhXdJYXAnKrubwLXQttKKZCHfBJDzKX1ocWkIjNFv1WpyBigKGa1h1vPYcGq0ZtmZYUKGDk5JXe6X/g1fuXzwCPZkA6n3I64EXR4oW+tZw7y6VM5DCIHHlURPVDOG+2qQB4Vvoy+8H71IStvdtu19gskcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752000581; c=relaxed/simple;
	bh=PwyaCFr71X9n1o0eUnzO2CpSDgsXcedd+OuVe7dQlMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=id5SIP2THyhWGRWejFy7Hn5z2VZ0H4Nyve7wdPP86ZbcBLsaiBmGFgcDCY0o4G7zQjmwAKTtJHJDc3uqSRRaAxr9XZ3e9gLScqyJWnO8OtR1EkICu33qJRT9EyYSB+S4b9O86wdDyh7cFtxWx8kK1CsnSKFqdfxVvjo3Oj+hLKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kd5p1e2t; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so9322386a12.3;
        Tue, 08 Jul 2025 11:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752000577; x=1752605377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BW+6DigMiX1xK6x4e8wd4JGcTc5pbIcjHouAtLTwptQ=;
        b=kd5p1e2tnuNqZiTiCYneqDtzUVrkNfNZ0ELVfyGY3bVm4kVbLW3ik5feZd1jPPYxrQ
         4Hi4hx24AX/DOTYE+wWJ2Xsl2QXNcpQPYFLK8p6AkSmyTe6r3dla4Sv5e+udqZ4BJaRK
         s+bCv12QsOi40wE7JhtEEXpvYWXZXkNslNCKNzJltvH5lok7e/wOmVdJVhE7X1f7HICz
         ebWGYfnOro32HHxNeMwxB0fh1DQAWp0HGqJbn6OITSiRTO5s5y0kFv9dqjgGbxl03heB
         X7BAsIXZCOOcztb+N2u84TWO3doab1ei9tvh5YlvhtVO27Xzs6/dIBXSbLMm01vzfJUX
         q0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752000577; x=1752605377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BW+6DigMiX1xK6x4e8wd4JGcTc5pbIcjHouAtLTwptQ=;
        b=Sedv3vaaY7X15jQaOb+SyxHIKmOjcKhjWyB6p1tAAU+DJSpIT8mpeBLfupOKLHZKYT
         01L6sgE9BPtDnBW6kF7fbG5wi9dl8Mpo90wbm19MuWHXxRkbAdk3hTb62l2PRMFSkp9U
         9tjDTxsGcbZUqCY8zoVA5Bp/m/ucnlGpJDosCm6vW25hAyyFvmKFNxjLhbcA5BhpcAhB
         vo7MEFCFCSPnB95x8lZaslDn6HpHdc0YZLcFYXrpvPh1AQZQSYwfpuXbPu4H/PeQdOD7
         A2nflB+/iMjD/l6MK2mGXrqiIoxreGeSvC7n/xI9iTx/Rs2KuzR/GvboglnDUQWu7+ys
         juZw==
X-Forwarded-Encrypted: i=1; AJvYcCWbfssI9uurCH0IYKXobeM+Vfo+j7ox9FObRvggjzwhC+R+egAGyqYfHeYQ8poKKdc4BEsI6v6nTWc3CRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YykBjDMHnYrzAmC3xqNejUEMSVwF6TIkNWwQdVQhIv0XnD2sYju
	XbVkyPEl0NacyTYAJbz0rK7MEnt+2iGMAy7JPXL2Hee1RQgDfoDnSZQiiFDTJKNy
X-Gm-Gg: ASbGncvVQMe30ckPZeyHvPZ63DbC1Z0pTfgzmHEcBqZwCYKWEhW1VzkNJNGEgNKVo04
	wzJgRZsxsZ3fZwfHnsAPbWJ/MQ0py40SpppK78LpWAd5LJTRw2kqStdvjdGcWyMWlYl3SDIQDeU
	uFfSmH26niadEr1SLjhprqr2LVbe8XcsqzUBp7gAxZ3hRri0AYEt8Pg15UATI4OYMp4zhhz5/5Z
	LznhGjX9znXn4V0RdKXG2YaYTWCOxIfQ3LUxGMgLlZ0bWA5k2M/5aSAxB1rqaiU8iReWPp3Ln6Z
	nFspdKbszLNR2VJGZYHJHgmXw/vwTWSmKqUBbd7ANf/fFEE6g2VueKXxJzzsZZkwEKszdD+psbR
	brNfgQzNDGnJe2Wvr3dnBSH5Fkzjpja1uyba8lJWqVOCgpE1mSQZFpIWAPQ==
X-Google-Smtp-Source: AGHT+IGrVMu72BOqYGD+gxMcfdjOkjFiT3MSHpOU1c6aGiVEP/nfbRDU7uFIhp387SnYia+Nge1jog==
X-Received: by 2002:a17:907:3c90:b0:ae3:bb4a:91fb with SMTP id a640c23a62f3a-ae3fe791ef6mr1813021166b.59.1752000576660;
        Tue, 08 Jul 2025 11:49:36 -0700 (PDT)
Received: from Lord-Beerus.tastitalia.local (net-93-70-53-177.cust.vodafonedsl.it. [93.70.53.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6baaaedsm944884666b.173.2025.07.08.11.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 11:49:36 -0700 (PDT)
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
Subject: [PATCH v1 3/3] arm64: dts: ti: Add support for Variscite VAR-SOM-AM62P Symphony Board
Date: Tue,  8 Jul 2025 20:48:35 +0200
Message-ID: <20250708184841.72933-4-stefano.radaelli21@gmail.com>
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
---
 .../dts/ti/k3-am62p5-var-som-symphony.dts     | 545 ++++++++++++++++++
 1 file changed, 545 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dts

diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dts b/arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dts
new file mode 100644
index 000000000000..ec6bdd28d57f
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dts
@@ -0,0 +1,545 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Variscite Symphony carrier board for VAR-SOM-AM62P
+ *
+ * Copyright (C) 2021-2022 Texas Instruments Incorporated - https://www.ti.com/
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
+		bootargs = "console=ttyS0,115200n8 earlycon=ns16550a,mmio32,0x02800000";
+	};
+
+	clk_ov5640_fixed: clock {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		status = "okay";
+		back {
+			label = "Back";
+			linux,code = <KEY_BACK>;
+			gpios = <&pca9534 1 GPIO_ACTIVE_LOW>;
+		};
+
+		home {
+			label = "Home";
+			linux,code = <KEY_HOME>;
+			gpios = <&pca9534 2 GPIO_ACTIVE_LOW>;
+		};
+
+		menu {
+			label = "Menu";
+			linux,code = <KEY_MENU>;
+			gpios = <&pca9534 3 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+		status = "okay";
+
+		heartbeat {
+			label = "Heartbeat";
+			linux,default-trigger = "heartbeat";
+			gpios = <&pca9534 0 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	ov5640_buf_en: ov5640-buf-en {
+		compatible = "regulator-fixed";
+		regulator-name = "ov5640_buf_en";
+		gpios = <&main_gpio0 21 GPIO_ACTIVE_HIGH>;
+		regulator-always-on;
+		regulator-boot-on;
+		status="okay";
+	};
+
+	transceiver1: can-phy0 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+	};
+
+	vdd_mmc1: regulator-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "sd_ext_rst";
+		vin-supply = <&vdd_mmc1_int>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&main_gpio0 30 GPIO_ACTIVE_HIGH>;
+		bootph-all;
+	};
+
+	vdd_mmc1_int: regulator-2 {
+		compatible = "regulator-fixed";
+		regulator-name = "sd_int_rst";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vdd_mmc1_pins_default>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&main_gpio0 53 GPIO_ACTIVE_HIGH>;
+		bootph-all;
+	};
+
+	vdd_sd_dv: regulator-3 {
+		compatible = "regulator-gpio";
+		regulator-name = "vdd_sd_vio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vdd_sd_dv_pins_default>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		gpios = <&main_gpio0 56 GPIO_ACTIVE_HIGH>;
+		states = <1800000 0x0>,
+			 <3300000 0x1>;
+		bootph-all;
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
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_rgmii1_pins_default>,
+		    <&main_rgmii2_pins_default>;
+};
+
+&cpsw3g_mdio {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mdio1_pins_default>;
+
+	cpsw3g_phy1: ethernet-phy@5 {
+		reg = <5>;
+		compatible = "ethernet-phy-id0283.bc30";
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
+&mailbox0_cluster0 {
+	mbox_r5_0: mbox-r5-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+};
+
+&mailbox0_cluster1 {
+	mbox_mcu_r5_0: mbox-mcu-r5-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+};
+
+&main_i2c0{
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c0_pins_default>;
+	clock-frequency = <400000>;
+
+	ov5640: camera@3c {
+		compatible = "ovti,ov5640";
+		reg = <0x3c>;
+		clocks = <&clk_ov5640_fixed>;
+		clock-names = "xclk";
+		powerdown-gpios = <&main_gpio0 10 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&main_gpio0 22 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ov5640_pins_default>;
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
+		pinctrl-0 = <&pca9534_irq_default>;
+		interrupt-parent = <&main_gpio1>;
+		interrupts = <30 IRQ_TYPE_EDGE_FALLING>;
+		#gpio-cells = <2>;
+		status = "okay";
+
+		usb3_sel_hog {
+			gpio-hog;
+			gpios = <4 0>;
+			output-low;
+			line-name = "usb3_sel";
+		};
+
+		eth_som_vselect_hog {
+			gpio-hog;
+			gpios = <6 0>;
+			output-low;
+			line-name = "eth-vselect";
+		};
+
+		eth_mdio_enable_hog {
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
+	pinctrl-0 = <&main_i2c1_pins_default>;
+	clock-frequency = <400000>;
+	status = "okay";
+
+	/* DS1337 RTC module */
+	rtc@68 {
+		compatible = "dallas,ds1337";
+		reg = <0x68>;
+		status = "okay";
+	};
+};
+
+&main_mcan0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcan0_pins_default>;
+	phys = <&transceiver1>;
+};
+
+&main_pmx0 {
+	extcon_pins_default: extcon-pins-default {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x01a8, PIN_INPUT, 7) /* (F25) MCASP0_AFSX.GPIO1_12 */
+		>;
+	};
+
+	main_i2c0_pins_default: main-i2c0-pins-default {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x01e0, PIN_INPUT_PULLUP, 0) /* (B25) I2C0_SCL */
+			AM62PX_IOPAD(0x01e4, PIN_INPUT_PULLUP, 0) /* (A24) I2C0_SDA */
+		>;
+	};
+
+	main_i2c1_pins_default: main-i2c1-pins-default {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x01e8, PIN_INPUT_PULLUP, 0) /* (C24) I2C1_SCL */
+			AM62PX_IOPAD(0x01ec, PIN_INPUT_PULLUP, 0) /* (B24) I2C1_SDA */
+		>;
+		bootph-all;
+	};
+
+	main_mcan0_pins_default: main-mcan0-pins-default {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x01dc, PIN_INPUT, 0) /* (F20) MCAN0_RX */
+			AM62PX_IOPAD(0x01d8, PIN_OUTPUT, 0) /* (B23) MCAN0_TX */
+		>;
+	};
+
+	main_mmc1_pins_default: main-mmc1-pins-default {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x023c, PIN_INPUT, 0) /* (H20) MMC1_CMD */
+			AM62PX_IOPAD(0x0234, PIN_OUTPUT, 0) /* (J24) MMC1_CLK */
+			AM62PX_IOPAD(0x0230, PIN_INPUT, 0) /* (H21) MMC1_DAT0 */
+			AM62PX_IOPAD(0x022c, PIN_INPUT_PULLUP, 0) /* (H23) MMC1_DAT1 */
+			AM62PX_IOPAD(0x0228, PIN_INPUT_PULLUP, 0) /* (H22) MMC1_DAT2 */
+			AM62PX_IOPAD(0x0224, PIN_INPUT_PULLUP, 0) /* (H25) MMC1_DAT3 */
+			AM62PX_IOPAD(0x0240, PIN_INPUT, 0) /* (D23) MMC1_SDCD */
+		>;
+		bootph-all;
+	};
+
+	main_rgmii2_pins_default: main-rgmii2-pins-default {
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
+	main_spi2_pins_default: main_spi2-pins-default {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x01b0, PIN_INPUT, 1) /* (G20) MCASP0_ACLKR.SPI2_CLK */
+			AM62PX_IOPAD(0x0194, PIN_OUTPUT, 1) /* (D25) MCASP0_AXR3.SPI2_D0 */
+			AM62PX_IOPAD(0x0198, PIN_INPUT, 1) /* (E25) MCASP0_AXR2.SPI2_D1 */
+			AM62PX_IOPAD(0x01ac, PIN_OUTPUT, 7) /* (G23) MCASP0_AFSR.GPIO1_13 */
+		>;
+	};
+
+	main_uart0_pins_default: main-uart0-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x1c8, PIN_INPUT, 0)	/* (A22) UART0_RXD */
+			AM62PX_IOPAD(0x1cc, PIN_OUTPUT, 0)	/* (B22) UART0_TXD */
+		>;
+		bootph-all;
+	};
+
+	main_uart2_pins_default: main-uart2-pins-default {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x005c, PIN_INPUT_PULLUP, 2) /* (AC25) GPMC0_AD8.UART2_RXD */
+			AM62PX_IOPAD(0x0060, PIN_OUTPUT, 2) /* (AB25) GPMC0_AD9.UART2_TXD */
+		>;
+	};
+
+	main_uart6_pins_default: main-uart6-pins-default {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x009c, PIN_INPUT_PULLUP, 3) /* (AD24) GPMC0_WAIT1.UART6_RXD */
+			AM62PX_IOPAD(0x0244, PIN_OUTPUT, 1) /* (D24) MMC1_SDWP.UART6_TXD */
+		>;
+	};
+
+	main_usb1_pins_default: main-usb1-pins-default {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0258, PIN_OUTPUT, 0) /* (G21) USB1_DRVVBUS */
+		>;
+	};
+
+	ov5640_pins_default: ov5640-pins-default {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0028, PIN_OUTPUT, 7) /* (N20) OSPI0_D7.GPIO0_10 */
+			AM62PX_IOPAD(0x0054, PIN_OUTPUT, 7) /* (V24) GPMC0_AD6.GPIO0_21 */
+			AM62PX_IOPAD(0x0058, PIN_OUTPUT, 7) /* (W25) GPMC0_AD7.GPIO0_22 */
+		>;
+	};
+
+	pca9534_irq_default: pca9534_irq_default {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x01f0, PIN_INPUT, 7) /* (C25) EXT_REFCLK1.GPIO1_30 */
+		>;
+	};
+
+	vdd_mmc1_pins_default: vdd-mmc1-pins-default {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0078, PIN_OUTPUT, 7) /* (AC24) GPMC0_AD15.GPIO0_30 */
+			AM62PX_IOPAD(0x00d8, PIN_OUTPUT, 7) /* (AE22) VOUT0_DATA8.GPIO0_53 */
+		>;
+		bootph-all;
+	};
+
+	vdd_sd_dv_pins_default: vdd-sd-dv-pins-default {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x00e4, PIN_OUTPUT, 7) /* (AE21) VOUT0_DATA11.GPIO0_56 */
+		>;
+		bootph-all;
+	};
+};
+
+&main_spi2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_spi2_pins_default>;
+	ti,pindir-d0-out-d1-in = <1>;
+	cs-gpios = <&main_gpio1 13 GPIO_ACTIVE_HIGH>;
+};
+
+&main_uart0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart0_pins_default>;
+};
+
+&main_uart1 {
+	/* Main UART1 is used by TIFS firmware */
+	status = "reserved";
+};
+
+&main_uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart2_pins_default>;
+	status = "okay";
+};
+
+&main_uart6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart6_pins_default>;
+	status = "okay";
+};
+
+&mcu_gpio0 {
+	status = "reserved";
+};
+
+&mcu_gpio_intr {
+	status = "reserved";
+};
+
+&mcu_r5fss0 {
+	status = "okay";
+};
+
+&mcu_r5fss0_core0 {
+	mboxes = <&mailbox0_cluster1 &mbox_mcu_r5_0>;
+	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
+			<&mcu_r5fss0_core0_memory_region>;
+};
+
+&sdhci1 {
+	/* SD Card */
+	vmmc-supply = <&vdd_mmc1>;
+	vqmmc-supply = <&vdd_sd_dv>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mmc1_pins_default>;
+	disable-wp;
+	status="okay";
+	bootph-all;
+};
+
+&ti_csi2rx0 {
+	status = "okay";
+};
+
+&usb0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	usb-role-switch;
+	status="okay";
+
+	port@0 {
+		reg = <0>;
+
+		typec_hs: endpoint {
+			remote-endpoint = <&usb_con_hs>;
+		};
+	};
+};
+
+&usb1 {
+	dr_mode = "host";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_usb1_pins_default>;
+	status="okay";
+};
+
+&usbss0 {
+	status = "okay";
+
+	connector {
+		compatible = "gpio-usb-b-connector","usb-c-connector";
+		pinctrl-names = "default";
+		pinctrl-0 = <&extcon_pins_default>;
+		label = "USB-C";
+		id-gpios = <&main_gpio1 12 GPIO_ACTIVE_HIGH>;
+		status = "okay";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				usb_con_hs: endpoint {
+					remote-endpoint = <&typec_hs>;
+				};
+			};
+		};
+	};
+};
+
+&usbss1 {
+	status = "okay";
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
+};
+
+&wkup_rtc0 {
+	status = "disabled";
+};
+
+&wkup_rti0 {
+	/* WKUP RTI0 is used by DM firmware */
+	status = "reserved";
+};
+
+&wkup_uart0 {
+	/* WKUP UART0 is used by DM firmware */
+	status = "reserved";
+};
-- 
2.43.0



Return-Path: <linux-kernel+bounces-724567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0C2AFF46B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C95A964394B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AD4253950;
	Wed,  9 Jul 2025 22:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Io1iFW0R"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEAA25393C;
	Wed,  9 Jul 2025 22:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752098892; cv=none; b=rqAhNEWxd+W7wJs4S1vFUSsaqQ4T/maoRy9yKiJFwJGfqkgSolCxT/46abuj9pWgmB/zAiKX3lgaOLjLNuHVAcRus3HUQH1yO4OKdMJbuEvFTK5x/fCzN/6jaIiHFQrIW6mNcYUikYbT6x28U54yNbs7vCoitQU8AS74xyFxUzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752098892; c=relaxed/simple;
	bh=P3/U62NP6JBJFwzwIQMsdyoN8XaKzfknet1jmlB4Txs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tiz1Qnv+QCpk4eg/IojySPw88rkFFN4YYe4hH9qRwtAMG/WveBHoDmp/Runn3BfyRiuNN3o8xEZe/fTZJPS2/pEB15EEVISsZ5c1/Pk1DxOHZqlSPof/efR0pQ1wUwM4nwUvMKKi7OslJKNeTFTFW7z38jBPRGfQBjCJLhTegW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Io1iFW0R; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae3c5f666bfso47321866b.3;
        Wed, 09 Jul 2025 15:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752098888; x=1752703688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kIH0FvUst38strgAqAwO4LslgL+w1rD7BPEeGk36lY=;
        b=Io1iFW0RlgC9xXWjLn/5twS/kCeCOBxBwi5ZL2cHj8Vu/lgiJ4r+6a9PlcwyZmEuCU
         BwUPdDwCOU6zhi5rX9tLMC6Tuxu1s9nQGS8Gs5gBx8vTqDco+N4LKEMrHJBMKPbKIDhO
         IWWvsi7UuYC64Gdv/54N/Pp3Y8fKgBT/NA2VJbe5CKTbeO6GA/g/sT+82wVUsl7NOovd
         s6Sx64OCaT1a3W1ycQ0/bbvpLfRY+K4XXVbdRqJ/TLQpsh1IhsU9WO/9+nHwmCaXyAa1
         jYQ9jPu9ZjCY3T+vuO/kgD0SSXNoqGUABrdtM+ES3AitsOv08d3PSRZrwqpCPTp/HDZS
         gzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752098888; x=1752703688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8kIH0FvUst38strgAqAwO4LslgL+w1rD7BPEeGk36lY=;
        b=UJNA63rDJ1sA1H3A1glWIhrytlfPCvEfn+pdG3dIUO83JUh5f2w8NsTWXFcKsXmpgH
         Gdh/+Rw53gtQoY11gv08X89dEZevut+aLYZxmXzk0AeoVvhbnoadjNIf1+pOEVSxd9Wl
         gRgt+LlM80mjMPrEcSL6mvo6lsw2BtgmK62kFrWFWPzEbxjjF/MuoaDzHhwqB4e0vbgE
         EMKQWaaAH1d4xIHoT9YQjftRspenVQl3ZtWV8J8vieZv2zXKoEwWsRj8kPuwYITvZdew
         FqCI0tXjIoAXn+P6YT3OWenphrjAgX8J0FPUPN/Bwu07LfQ8nmUtdswNGZcQW1FPl4nl
         S5rw==
X-Forwarded-Encrypted: i=1; AJvYcCVYPVMPPwODosB2BPIYlAvznJaXR+stEC9cloycwXWaMwb3hwYkhErmPKd4hQm7Cswf/4FEsqEYM7TusXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2VFBHlV7Heh9nzNH5ugEThWFdQwlttK/7hQTWTXwoiYgjmsCc
	5Tj+14gnt+c9Bml+OaU5phacQEKq45fr3q6T7Kit+J5JsThSEM7A+eb8ZnjlVwnG
X-Gm-Gg: ASbGncuQSlI5SBvH9v5lWXHqNAR2AWsnhayWYMoTA6iicmLIaHrU5II8dZ9U6R+v599
	ZKO5babbdbObFC8ra20tAcT4NluBMgDtIKJvpWZLsPFjqNuCoxoVTKwP5x0TabFpQ5FKa103Nwj
	M2eel7T8MRwZOopcnO8xfMYzUCnyJSHsKJOo8V5Cs9MeUgjTVJv3DV410M9h+aVZXMYbJuJPzBj
	myE7GBvMARqrRq6C8Fc+KEgHS74RwD6dzV2MPGHXQSRKWCvtkNa9Em+Ns+U7mwQ6rWH485CGEmx
	eWOadfkPsHMieaHbqhLz0JQyz+pLk3S/Sh6bInFc1qTWfmAlRADTfPB3vPHtSL0kDojaFWeV086
	pR5Qg8gobPzW1M/Mx3+jpavtVjNEXOJ7wWv6EMgcg9knr6A==
X-Google-Smtp-Source: AGHT+IEVaztWxyCPmnWA2QlJcO1+/QR7Gfg0M8GtpKmyP796XZy3AXCMevgeemhffcoXQTRBKo6uMw==
X-Received: by 2002:a17:907:7215:b0:ae0:cae0:cb35 with SMTP id a640c23a62f3a-ae6cf7639efmr432617866b.37.1752098887617;
        Wed, 09 Jul 2025 15:08:07 -0700 (PDT)
Received: from Lord-Beerus.station (net-93-70-53-177.cust.vodafonedsl.it. [93.70.53.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8264fbcsm10520666b.75.2025.07.09.15.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 15:08:07 -0700 (PDT)
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
Subject: [PATCH v2 3/3] arm64: dts: ti: var-som-am62p: Add support for Variscite Symphony Board
Date: Thu, 10 Jul 2025 00:07:06 +0200
Message-ID: <20250709220714.85697-4-stefano.radaelli21@gmail.com>
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
v2:
 - Fixed warnings and cleanup

 arch/arm64/boot/dts/ti/Makefile               |   1 +
 .../dts/ti/k3-am62p5-var-som-symphony.dts     | 563 ++++++++++++++++++
 2 files changed, 564 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dts

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index c6171de9fe88..f8b1ed3cbdfa 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -35,6 +35,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62a7-phyboard-lyra-rdk.dtb
 
 # Boards with AM62Px SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am62p5-sk.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am62p5-var-som-symphony.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am62p5-verdin-nonwifi-dahlia.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am62p5-verdin-nonwifi-dev.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am62p5-verdin-nonwifi-ivy.dtb
diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dts b/arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dts
new file mode 100644
index 000000000000..99c8fd15cf64
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-var-som-symphony.dts
@@ -0,0 +1,563 @@
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
+	compatible = "variscite,am62p-var-som-symphony", "variscite,am62p-var-som", "ti,am62p5";
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
+	reg_ov5640_buf_en: regulator-ov5640-buf-en {
+		compatible = "regulator-fixed";
+		regulator-name = "ov5640_buf_en";
+		gpios = <&main_gpio0 21 GPIO_ACTIVE_HIGH>;
+		regulator-always-on;
+		regulator-boot-on;
+		status="okay";
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
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii1>,
+		    <&pinctrl_rgmii2>;
+};
+
+&cpsw3g_mdio {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mdio1>;
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
+	pinctrl-0 = <&pinctrl_i2c0>;
+	clock-frequency = <400000>;
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
+	pinctrl-0 = <&pinctrl_mcan0>;
+	phys = <&transceiver1>;
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
+			AM62PX_IOPAD(0x022c, PIN_INPUT_PULLUP, 0) /* (H23) MMC1_DAT1 */
+			AM62PX_IOPAD(0x0228, PIN_INPUT_PULLUP, 0) /* (H22) MMC1_DAT2 */
+			AM62PX_IOPAD(0x0224, PIN_INPUT_PULLUP, 0) /* (H25) MMC1_DAT3 */
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
+	pinctrl_spi2: main_spi2-default-pins {
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
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi2>;
+	ti,pindir-d0-out-d1-in;
+	cs-gpios = <&main_gpio1 13 GPIO_ACTIVE_HIGH>;
+};
+
+&main_uart0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart0>;
+};
+
+&main_uart1 {
+	/* Main UART1 is used by TIFS firmware */
+	status = "reserved";
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
+	vmmc-supply = <&reg_sdhc1_vmmc>;
+	vqmmc-supply = <&reg_sdhc1_vqmmc>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mmc1>;
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



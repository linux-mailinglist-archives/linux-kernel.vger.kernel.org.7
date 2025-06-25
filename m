Return-Path: <linux-kernel+bounces-701751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E44FAE78D4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 09:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A913F3A2672
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 07:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5ED0213248;
	Wed, 25 Jun 2025 07:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFcu2M9G"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45734212B02;
	Wed, 25 Jun 2025 07:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750837144; cv=none; b=rxPdYMHZGFx7PNmQY86rjvz+s4sbdJ2Qa3WhMucWrBKG09MeKPAEu1mc0TJ3UIDmaNB4BnMl/FxVV2loCDWzx+zcmxw9yYbWKynDEd+0mVHGtJztzLtKzTf5RLFuChR5c2UJEjwQwKoptQCoeAZZQcdkPYxCz4WcwfzEVgHL5oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750837144; c=relaxed/simple;
	bh=HiN0bKROQOAe//zvojKUbetp7GkK0COzl/aBH1wE3oQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrsj3oFw3pvyyQIzzYMS1AMCVoEYSkuR+BJJT7Mag1UnWD5V/2uPu2AkVP+ojFthMrK7L8fxxHz2mMpHg1V5sUacEBHeFHGuGLrati1Gz9jgvYUenBEqHMQLLx/vOHhppFjAvOsqsaavLGcz4bwCsBsqcb4Qpquhrctl5udh0Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFcu2M9G; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2360ff7ac1bso11494385ad.3;
        Wed, 25 Jun 2025 00:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750837141; x=1751441941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uV/u/GQsS0aw819kPMZ+u5xOeTEDM8CBu7aJLLLB674=;
        b=RFcu2M9GRle4QRGY89AvmIk6GGoFFEimUCCrhqkjYsChGuCm0bL8NNL9f4GzuofHs3
         aOW9csCUYZj/kGn70+10Wj8xEHvCen84V7wdWX8XoFwuhLb0Kmu4436IJLDZOroOGvBH
         MGzsEP77b4tEScPnmUwcf9IcnG0aEwO54lL7+axzAaf9nr5iYauo0HbXvnGDG/Q2FHJf
         8IY+wExym3yHzBXectWnEa5HVvgo2qOyNygEOp4rkAYoB71NVVKagISel65UFLiDLY9g
         j7Iptmmv8fAcZaFBJkmiQmGX9n8MMs+h08bxzrEFytv5Xm6KdGmsyjokmd0xUIYU3Ib+
         tUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750837141; x=1751441941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uV/u/GQsS0aw819kPMZ+u5xOeTEDM8CBu7aJLLLB674=;
        b=cmfleiyw0ohIKeMcuKOEkIjVc/u+xDLnooPGq5oEzMXvuQpNizhLeB+UVl71OiNbVz
         fgP9POPAgum0ClOlIBmvMgpHoQUraTxh+LPtO/04wYOLdRGyjUB9trbYpTaVl1srhnQZ
         bWU8jyE21rpeF+RbU3WRMxEtAxKk2YYVQzqmnjTNN35FYfmZMWyyothVof+amwV9laA/
         UWFQrZhNA5DPV8/FeT5+gDRt5eotrPFTxcJM3qFfwZmetHeLL2QfafDz/pq7+LCpGC1X
         jE04Y7wG46qSOpJKHis4DrEqMsHVnMHQmUJ3RADNw9vlTz6gX8SzDHM3elhi90CDOEJG
         YyTg==
X-Forwarded-Encrypted: i=1; AJvYcCW+4R9kLkIP2rgWOSW0AssVQVVhSagyuVvw7XSo/P5HhYDyQ7Zbb36wIaNJ1LF4Yw8QlPKXDYFxhD84@vger.kernel.org, AJvYcCWkUQcRk8L4flAfpFTxDtb9LdAufLE1P5qn+1OCzMUUbGjzLDSBMNbE2pFys2xV18k6EOxT68TS7mXt43HU@vger.kernel.org
X-Gm-Message-State: AOJu0YxbmmbM+W7nD24X/jU/cEpMO/EydAAmq6GSDfSVjxs82uzj/xWO
	wPkU41xRGwcbl/yZ9kJyI8RjvEBDumdllEnGVFvz4UseWPN3yhOOW4d7
X-Gm-Gg: ASbGncuiwmAPBb75+s2Zn9oXQEFB3Ws8+1eFV+bz1H7uEzc1pV87iwPoYkBeO/J6WTk
	X+MjCs9/YPCYIgAoKd5FDyIdU55pNFZ+ecibGwwd+14zoq0kyjDKrzjOTVSRFMx7BdIvasoyZK3
	PqINxyWzYTLPKo75GJ6cWRo7+w1GsyySDNgzavm1+VK2ppW4rZ/S+l0ri4scJMGc7MBRYwQMr9j
	Cxawkbn42yCmy3OMjD7b3oletS7zc9mCY/nxEyi/k4/Ke5SSClP9MExrEPqIF1xc7TcDpTtYoT5
	P/Bp5/odUR8KIG5iuf1VqE/8GAiGfjE4ro+3u4RxqDrcqTmZwdBLxyjCyJ5MDyL5SnQDwCJTF5d
	MFlqVledk3bzHWCSuZ344UGN7zAtMqnrHXWqE1M3FDg1VAgUaGGhhhrMfN0ZkNWerfFLe74zbaX
	PP878d4Eo1qW2NuQ==
X-Google-Smtp-Source: AGHT+IH9caQOl8jrsTigz/nwuYc4o2WCP87GOsj2gss0ourfXDnSiB+0Q/DfCA7TkgfKd258ugqDWw==
X-Received: by 2002:a17:902:e843:b0:235:e8da:8d1 with SMTP id d9443c01a7336-2382454560emr28535695ad.8.1750837141328;
        Wed, 25 Jun 2025 00:39:01 -0700 (PDT)
Received: from fred-System-Product-Name.. (2001-b400-e389-b6b2-29b2-bfd3-aa15-d345.emome-ip6.hinet.net. [2001:b400:e389:b6b2:29b2:bfd3:aa15:d345])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d86a3083sm125374285ad.195.2025.06.25.00.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 00:39:01 -0700 (PDT)
From: Fred Chen <fredchen.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ARM: dts: aspeed: santabarbara: Add Meta Santabarbara BMC
Date: Wed, 25 Jun 2025 15:38:38 +0800
Message-ID: <20250625073847.4054971-3-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250625073847.4054971-1-fredchen.openbmc@gmail.com>
References: <20250625073847.4054971-1-fredchen.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add linux device tree entry related to the Meta (Facebook) compute node
system using an AST2600 BMC.

This node is named "Santabarbara". It is a compute node with accelerator
module. The system monitors voltage and temperature for the CPU, switch,
and NIC components on the motherboard and switch board.

Signed-off-by: Fred Chen <fredchen.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed-bmc-facebook-santabarbara.dts      | 982 ++++++++++++++++++
 2 files changed, 983 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index 2e5f4833a073..6a8fb3addf0f 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -27,6 +27,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-facebook-harma.dtb \
 	aspeed-bmc-facebook-minerva.dtb \
 	aspeed-bmc-facebook-minipack.dtb \
+	aspeed-bmc-facebook-santabarbara.dtb \
 	aspeed-bmc-facebook-tiogapass.dtb \
 	aspeed-bmc-facebook-wedge40.dtb \
 	aspeed-bmc-facebook-wedge100.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
new file mode 100644
index 000000000000..ee93a971c500
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -0,0 +1,982 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright 2025 Facebook Inc.
+
+/dts-v1/;
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/i2c/i2c.h>
+
+/ {
+	model = "Facebook Santabarbara BMC";
+	compatible = "facebook,santabarbara-bmc", "aspeed,ast2600";
+
+	aliases {
+		serial0 = &uart1;
+		serial2 = &uart3;
+		serial3 = &uart4;
+		serial4 = &uart5;
+		i2c16 = &i2c4mux0ch0;
+		i2c17 = &i2c4mux0ch1;
+		i2c18 = &i2c4mux0ch2;
+		i2c19 = &i2c4mux0ch3;
+		i2c20 = &i2c4mux0ch4;
+		i2c21 = &i2c4mux0ch5;
+		i2c22 = &i2c4mux0ch6;
+		i2c23 = &i2c4mux0ch7;
+		i2c24 = &i2c5mux0ch0;
+		i2c25 = &i2c5mux0ch1;
+		i2c26 = &i2c5mux0ch2;
+		i2c27 = &i2c5mux0ch3;
+		i2c28 = &i2c5mux1ch0;
+		i2c29 = &i2c5mux1ch1;
+		i2c30 = &i2c5mux1ch2;
+		i2c31 = &i2c5mux1ch3;
+		i2c32 = &i2c12mux0ch0;
+		i2c33 = &i2c12mux0ch1;
+		i2c34 = &i2c12mux0ch2;
+		i2c35 = &i2c12mux0ch3;
+		i2c36 = &i2c12mux0ch4;
+		i2c37 = &i2c12mux0ch5;
+		i2c38 = &i2c12mux0ch6;
+		i2c39 = &i2c12mux0ch7;
+	};
+
+	chosen {
+		stdout-path = "serial4:57600n8";
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
+			      <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
+			      <&adc1 2>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			label = "bmc_heartbeat_amber";
+			gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		led-1 {
+			label = "fp_id_amber";
+			default-state = "off";
+			gpios = <&gpio0 ASPEED_GPIO(B, 5) GPIO_ACTIVE_HIGH>;
+		};
+
+		led-2 {
+			label = "power_blue";
+			default-state = "off";
+			gpios = <&gpio0 ASPEED_GPIO(P, 4) GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
+	};
+
+	p3v3_bmc_aux: regulator-p3v3-bmc-aux {
+		compatible = "regulator-fixed";
+		regulator-name = "p3v3_bmc_aux";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	spi_gpio: spi {
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		sck-gpios = <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
+		mosi-gpios = <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
+		miso-gpios = <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH>;
+		num-chipselects = <1>;
+		cs-gpios = <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
+		status = "okay";
+
+		tpm@0 {
+			compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
+			spi-max-frequency = <33000000>;
+			reg = <0>;
+		};
+	};
+};
+
+&adc0 {
+	aspeed,int-vref-microvolt = <2500000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
+		&pinctrl_adc2_default &pinctrl_adc3_default
+		&pinctrl_adc4_default &pinctrl_adc5_default
+		&pinctrl_adc6_default &pinctrl_adc7_default>;
+	status = "okay";
+};
+
+&adc1 {
+	aspeed,int-vref-microvolt = <2500000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc10_default>;
+	status = "okay";
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&fmc {
+	status = "okay";
+
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc";
+		spi-max-frequency = <50000000>;
+#include "openbmc-flash-layout-128.dtsi"
+	};
+
+	flash@1 {
+		status = "okay";
+		m25p,fast-read;
+		label = "alt-bmc";
+		spi-max-frequency = <50000000>;
+	};
+};
+
+&gpio0 {
+	gpio-line-names =
+	/*A0-A7*/	"","","","","","","","",
+	/*B0-B7*/	"rtc-battery-voltage-read-enable","","","BMC_READY",
+			"","led-identify","","",
+	/*C0-C7*/	"","","","","","","","",
+	/*D0-D7*/	"","","","","","","","",
+	/*E0-E7*/	"","","","","","","","",
+	/*F0-F7*/	"","","","","","","","",
+	/*G0-G7*/	"FM_MUX1_SEL_R","","","","","","","",
+	/*H0-H7*/	"","","","","","","","",
+	/*I0-I7*/	"","","","","","","","",
+	/*J0-J7*/	"","","","","","","","",
+	/*K0-K7*/	"","","","","","","","",
+	/*L0-L7*/	"","","","","","","","",
+	/*M0-M7*/	"","","","","","","","",
+	/*N0-N7*/	"led-postcode-0","led-postcode-1",
+			"led-postcode-2","led-postcode-3",
+			"led-postcode-4","led-postcode-5",
+			"led-postcode-6","led-postcode-7",
+	/*O0-O7*/	"","","","","","","","",
+	/*P0-P7*/	"power-button","","reset-button","",
+			"led-power","","","",
+	/*Q0-Q7*/	"","","","","","","","",
+	/*R0-R7*/	"","","","","","","","",
+	/*S0-S7*/	"","","power-host-control","","","","","",
+	/*T0-T7*/	"","","","","","","","",
+	/*U0-U7*/	"","","","","","","","",
+	/*V0-V7*/	"","","","","","","","",
+	/*W0-W7*/	"","","","","","","","",
+	/*X0-X7*/	"","","","","","","","",
+	/*Y0-Y7*/	"","","","","","","","",
+	/*Z0-Z7*/	"","","","","","","","";
+};
+
+&gpio1 {
+	gpio-line-names =
+	/*18A0-18A7*/	"","","","","","","","",
+	/*18B0-18B7*/	"","","","",
+				"FM_BOARD_BMC_REV_ID0","FM_BOARD_BMC_REV_ID1",
+				"FM_BOARD_BMC_REV_ID2","",
+	/*18C0-18C7*/	"SPI_BMC_BIOS_ROM_IRQ0_R_N","","","","","","","",
+	/*18D0-18D7*/	"","","","","","","","",
+	/*18E0-18E3*/	"FM_BMC_PROT_LS_EN","AC_PWR_BMC_BTN_R_N","","";
+};
+
+&i2c0 {
+	status = "okay";
+
+	// MB FRU
+	eeprom@53 {
+		compatible = "atmel,24c128";
+		reg = <0x53>;
+	};
+
+	rtc@68 {
+		compatible = "dallas,ds1339";
+		reg = <0x68>;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+
+	gpio@20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&sgpiom0>;
+		interrupts = <112 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names =
+			"FM_NIC_PPS_IN_OE_N","FM_NIC_PPS_OUT_OE_N",
+			"FM_CPU0_TRIGGERTSC_OE_N","FM_NIC_PPS_IN_MUX_OE_N",
+			"FM_CPU0_CORETYPE0","FM_CPU0_CORETYPE1",
+			"FM_CPU0_CORETYPE2","FM_NIC_PPS_OUT_MUX_OE",
+			"CLKMUX_INPUT_LOSS_U45_R_N","FM_CPU0_SP7R1",
+			"FM_CPU0_SP7R2","FM_CPU0_SP7R3",
+			"FM_CPU0_SP7R4","",
+			"FM_NIC_PPS_IN_S0_R","FM_NIC_PPS_IN_S1_R";
+	};
+
+	fan-controller@21{
+		compatible = "maxim,max31790";
+		reg = <0x21>;
+	};
+
+	gpio@22 {
+		compatible = "nxp,pca9555";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&sgpiom0>;
+		interrupts = <116 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names =
+			"FM_CBL_PRSNT_0A_N","FM_CBL_PRSNT_0B_N",
+			"FM_CBL_PRSNT_1A_N","FM_CBL_PRSNT_1B_N",
+			"FM_MODULE_PWRGD_0A","FM_MODULE_PWRGD_0B",
+			"CLKMUX_INPUT_LOSS_U88_R_N","FM_MODULE_PWRGD_1B",
+			"","",
+			"CLKMUX_INPUT_LOSS_U83_R_N","CLKMUX_INPUT_LOSS_U84_R_N",
+			"FM_P3V3_E1S_0_FAULT_R_N","FM_P3V3_E1S_1_FAULT_R_N",
+			"E1S_0_P12V_ADC_R_ALERT","E1S_1_P12V_ADC_R_ALERT";
+	};
+
+	gpio@24 {
+		compatible = "nxp,pca9555";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&sgpiom0>;
+		interrupts = <114 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names =
+			"FM_CBL_PRSNT_2A_N","FM_CBL_PRSNT_2B_N",
+			"FM_CBL_PRSNT_3A_N","FM_CBL_PRSNT_3B_N",
+			"FM_CBL_PRSNT_4A_N","FM_CBL_PRSNT_4B_N",
+			"FM_P3V3_NIC_400G_FAULT_R_N","FM_MODULE_PWRGD_2B",
+			"OCP_SFF_P12V_ADC_R_ALERT","FM_MODULE_PWRGD_3B",
+			"FM_THERMAL_ALERT_R_N","FM_MODULE_PWRGD_4B",
+			"FM_CBL_PRSNT_OSFP_A_N","FM_CBL_PRSNT_OSFP_B_N",
+			"FM_JTAG_MCIO_MUX_S0","FM_JTAG_MCIO_MUX_S1";
+	};
+
+	gpio@26 {
+		compatible = "nxp,pca9555";
+		reg = <0x26>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&sgpiom0>;
+		interrupts = <118 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names =
+			"FAN_0_PRSNT_R1_N","FAN_1_PRSNT_R1_N",
+			"FAN_2_PRSNT_R1_N","FAN_3_PRSNT_R1_N",
+			"P12V_FAN_0_ADC_ALERT","P12V_FAN_1_ADC_ALERT",
+			"P12V_FAN_2_ADC_ALERT","P12V_FAN_3_ADC_ALERT",
+			"P12V_FAN0_PWRGD_R","P12V_FAN1_PWRGD_R",
+			"P12V_FAN2_PWRGD_R","P12V_FAN3_PWRGD_R",
+			"","","","";
+	};
+};
+
+&i2c4 {
+	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9548";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c4mux0ch0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			// HPM Board ID EEPROM
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			// SCM Board ID EEPROM
+			eeprom@53 {
+				compatible = "atmel,24c128";
+				reg = <0x53>;
+			};
+		};
+		i2c4mux0ch1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c4mux0ch2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c4mux0ch3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			power-monitor@40 {
+				compatible = "ti,ina230";
+				reg = <0x40>;
+				shunt-resistor = <2000>;
+			};
+
+			power-monitor@42 {
+				compatible = "ti,ina230";
+				reg = <0x42>;
+				shunt-resistor = <2000>;
+			};
+
+			power-monitor@44 {
+				compatible = "ti,ina230";
+				reg = <0x44>;
+				shunt-resistor = <2000>;
+			};
+
+			power-monitor@46 {
+				compatible = "ti,ina230";
+				reg = <0x46>;
+				shunt-resistor = <2000>;
+			};
+
+			voltage-sensor@48 {
+				compatible = "ti,ads7830";
+				reg = <0x48>;
+				vref-supply = <&p3v3_bmc_aux>;
+			};
+
+			voltage-sensor@4a {
+				compatible = "ti,ads7830";
+				reg = <0x4a>;
+				vref-supply = <&p3v3_bmc_aux>;
+			};
+
+			temperature-sensor@4c {
+				compatible = "ti,tmp75";
+				reg = <0x4c>;
+			};
+
+			temperature-sensor@4e {
+				compatible = "ti,tmp75";
+				reg = <0x4e>;
+			};
+		};
+		i2c4mux0ch4: i2c@4 {
+			reg = <4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c4mux0ch5: i2c@5 {
+			reg = <5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c4mux0ch6: i2c@6 {
+			reg = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			power-monitor@40 {
+				compatible = "ti,ina230";
+				reg = <0x40>;
+				shunt-resistor = <2000>;
+			};
+
+			power-monitor@42 {
+				compatible = "ti,ina230";
+				reg = <0x42>;
+				shunt-resistor = <2000>;
+			};
+
+			power-monitor@44 {
+				compatible = "ti,ina230";
+				reg = <0x44>;
+				shunt-resistor = <2000>;
+			};
+
+			power-monitor@46 {
+				compatible = "ti,ina230";
+				reg = <0x46>;
+				shunt-resistor = <2000>;
+			};
+
+			voltage-sensor@48 {
+				compatible = "ti,ads7830";
+				reg = <0x48>;
+			};
+		};
+		i2c4mux0ch7: i2c@7 {
+			reg = <7>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			temperature-sensor@4b {
+				compatible = "ti,tmp75";
+				reg = <0x4b>;
+			};
+
+			temperature-sensor@4f {
+				compatible = "ti,tmp75";
+				reg = <0x4f>;
+			};
+
+			// FIO FRU
+			eeprom@53 {
+				compatible = "atmel,24c512";
+				reg = <0x53>;
+			};
+		};
+	};
+};
+
+&i2c5 {
+	status = "okay";
+
+	// E1S BP FRU
+	eeprom@52 {
+		compatible = "atmel,24c64";
+		reg = <0x52>;
+	};
+
+	i2c-mux@71 {
+		compatible = "nxp,pca9546";
+		reg = <0x71>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c5mux0ch0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c5mux0ch1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c5mux0ch2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c5mux0ch3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
+	i2c-mux@72 {
+		compatible = "nxp,pca9546";
+		reg = <0x72>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c5mux1ch0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			voltage-sensor@48 {
+				compatible = "ti,ads7830";
+				reg = <0x48>;
+			};
+		};
+		i2c5mux1ch1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			temperature-sensor@48 {
+				compatible = "ti,tmp75";
+				reg = <0x48>;
+			};
+		};
+		i2c5mux1ch2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			power-monitor@40 {
+				compatible = "ti,ina230";
+				reg = <0x40>;
+				shunt-resistor = <2000>;
+			};
+
+			power-monitor@41 {
+				compatible = "ti,ina230";
+				reg = <0x41>;
+				shunt-resistor = <2000>;
+			};
+
+			power-monitor@44 {
+				compatible = "ti,ina230";
+				reg = <0x44>;
+				shunt-resistor = <2000>;
+			};
+
+			power-monitor@45 {
+				compatible = "ti,ina230";
+				reg = <0x45>;
+				shunt-resistor = <2000>;
+			};
+		};
+		i2c5mux1ch3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			gpio@74 {
+				compatible = "nxp,pca9539";
+				reg = <0x74>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-line-names =
+					"P12V_E1S_ADC_ALERT","BUFF0_100M_LOSB_PLD",
+					"E1S_BP_SKU_ID0","E1S_BP_SKU_ID1",
+					"E1S_BP_SKU_ID2","E1S_BP_REV_ID0",
+					"E1S_BP_REV_ID1","E1S_BP_REV_ID2",
+					"P3V3_E1S_1_FAULT_R_N","P3V3_E1S_2_FAULT_R_N",
+					"P3V3_E1S_3_FAULT_R_N","P3V3_E1S_4_FAULT_R_N",
+					"P12V_E1S_1_FAULT_R_N","P12V_E1S_2_FAULT_R_N",
+					"P12V_E1S_3_FAULT_R_N","P12V_E1S_4_FAULT_R_N";
+			};
+		};
+	};
+};
+
+&i2c6 {
+	status = "okay";
+
+	// Rainbow0 FRU
+	eeprom@52 {
+		compatible = "atmel,24c256";
+		reg = <0x52>;
+	};
+};
+
+&i2c7 {
+	status = "okay";
+};
+
+&i2c8 {
+	status = "okay";
+
+	// Rainbow2 FRU
+	eeprom@52 {
+		compatible = "atmel,24c256";
+		reg = <0x52>;
+	};
+};
+
+&i2c9 {
+	status = "okay";
+
+	temperature-sensor@4b {
+		compatible = "ti,tmp75";
+		reg = <0x4b>;
+	};
+
+	// SCM FRU
+	eeprom@50 {
+		compatible = "atmel,24c128";
+		reg = <0x50>;
+	};
+
+	// BSM FRU
+	eeprom@56 {
+		compatible = "atmel,24c64";
+		reg = <0x56>;
+	};
+};
+
+&i2c10 {
+	status = "okay";
+
+	// Rainbow3 FRU
+	eeprom@52 {
+		compatible = "atmel,24c256";
+		reg = <0x52>;
+	};
+};
+
+&i2c11 {
+	status = "okay";
+
+	// OCP NIC TEMP
+	temperature-sensor@1f {
+		compatible = "ti,tmp421";
+		reg = <0x1f>;
+	};
+
+	// OCP NIC FRU
+	eeprom@50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+	};
+};
+
+&i2c12 {
+	status = "okay";
+
+	// SWB FRU
+	eeprom@52 {
+		compatible = "atmel,24c64";
+		reg = <0x52>;
+	};
+
+	i2c-mux@72 {
+		compatible = "nxp,pca9548";
+		reg = <0x72>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c12mux0ch0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			temperature-sensor@48 {
+				compatible = "ti,tmp75";
+				reg = <0x48>;
+			};
+		};
+		i2c12mux0ch1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			power-monitor@42 {
+				compatible = "mps,mp2971";
+				reg = <0x42>;
+			};
+
+			power-monitor@43 {
+				compatible = "mps,mp2971";
+				reg = <0x43>;
+			};
+		};
+		i2c12mux0ch2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			power-monitor@40 {
+				compatible = "ti,ina230";
+				reg = <0x40>;
+				shunt-resistor = <2000>;
+			};
+
+			power-monitor@41 {
+				compatible = "ti,ina230";
+				reg = <0x41>;
+				shunt-resistor = <2000>;
+			};
+		};
+		i2c12mux0ch3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			power-monitor@44 {
+				compatible = "ti,ina230";
+				reg = <0x44>;
+				shunt-resistor = <2000>;
+			};
+
+			power-monitor@45 {
+				compatible = "ti,ina230";
+				reg = <0x45>;
+				shunt-resistor = <2000>;
+			};
+		};
+		i2c12mux0ch4: i2c@4 {
+			reg = <4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			voltage-sensor@49 {
+				compatible = "ti,ads7830";
+				reg = <0x49>;
+			};
+		};
+		i2c12mux0ch5: i2c@5 {
+			reg = <5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c12mux0ch6: i2c@6 {
+			reg = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+		i2c12mux0ch7: i2c@7 {
+			reg = <7>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+&i2c13 {
+	status = "okay";
+
+	// Rainbow1 FRU
+	eeprom@52 {
+		compatible = "atmel,24c256";
+		reg = <0x52>;
+	};
+};
+
+&i2c14 {
+	status = "okay";
+};
+
+&i2c15 {
+	status = "okay";
+};
+
+&kcs2 {
+	aspeed,lpc-io-reg = <0xca8>;
+	status = "okay";
+};
+
+&kcs3 {
+	aspeed,lpc-io-reg = <0xca2>;
+	status = "okay";
+};
+
+&mac2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii3_default>;
+	use-ncsi;
+	status = "okay";
+};
+
+&mac3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii4_default>;
+	use-ncsi;
+	status = "okay";
+};
+
+&sgpiom0 {
+	ngpios = <128>;
+	bus-frequency = <2000000>;
+	gpio-line-names =
+	/*in - out - in - out */
+	/*A0-A3 line 0-7*/
+	"PDB1_HSC_PWR_OK","power-chassis-control",
+	"PDB2_HSC_PWR_OK","FM_MODULE_PWRGD_0A_OUT",
+	"PWRGD_P12V_MEM","FM_MODULE_PWRGD_0B_OUT",
+	"PWRGD_P12V_SCM","FM_MODULE_PWRGD_1B_OUT",
+	/*A4-A7 line 8-15*/
+	"PWRGD_P12V_FAN","FM_MODULE_PWRGD_2B_OUT",
+	"PWRGD_P5V_AUX","FM_MODULE_PWRGD_3B_OUT",
+	"power-chassis-good","FM_MODULE_PWRGD_4B_OUT",
+	"PWRGD_P1V8_LDO","FM_CBL_PRSNT_0A_N_OUT",
+	/*B0-B3 line 16-23*/
+	"PWRGD_P1V_LDO","FM_CBL_PRSNT_0B_N_OUT",
+	"PWRGD_PVDD33_S5","FM_CBL_PRSNT_1A_N_OUT",
+	"PWRGD_PVDD18_S5_P0","FM_CBL_PRSNT_1B_N_OUT",
+	"CPU0_SLP_S5_N","FM_CBL_PRSNT_2A_N_OUT",
+	/*B4-B7 line 24-31*/
+	"PWRGD_PVDDIO_MEM_S3_P0","FM_CBL_PRSNT_2B_N_OUT",
+	"CPU0_SLP_S3_N","FM_CBL_PRSNT_3A_N_OUT",
+	"FM_MODULE_PWRGD_1B","FM_CBL_PRSNT_3B_N_OUT",
+	"FM_MODULE_PWRGD_2B","FM_CBL_PRSNT_4A_N_OUT",
+	/*C0-C3 line 32-39*/
+	"FM_MODULE_PWRGD_3B","FM_CBL_PRSNT_4B_N_OUT",
+	"FM_MODULE_PWRGD_4B","P12V_FAN0_PWRGD_OUT",
+	"FM_MODULE_PWRGD_0B","P12V_FAN1_PWRGD_OUT",
+	"PWRGD_PVDDIO_P0","P12V_FAN2_PWRGD_OUT",
+	/*C4-C7 line 40-47*/
+	"PWRGD_PVDDCR_SOC_P0","P12V_FAN3_PWRGD_OUT",
+	"PWRGD_PVDDCR_CPU0_P0","P12V_FAN4_PWRGD_OUT",
+	"PWRGD_PVDDCR_CPU1_P0","P12V_FAN5_PWRGD_OUT",
+	"FM_CPU0_PWR_GOOD","P12V_FAN6_PWRGD_OUT",
+	/*D0-D3 line 48-55*/
+	"host0-ready","P12V_FAN7_PWRGD_OUT",
+	"FM_PWRGD_CPU0_PWROK","FAN_0_PRSNT_R1_N_OUT",
+	"FM_RST_CPU0_RESETL_N","FAN_1_PRSNT_R1_N_OUT",
+	"RST_CPU0_PERST0_R_N","FAN_2_PRSNT_R1_N_OUT",
+	/*D4-D7 line 56-63*/
+	"RST_CPU0_PERST1_R_N","FAN_3_PRSNT_R1_N_OUT",
+	"BIOS_POST_CMPLT","FAN_4_PRSNT_R1_N_OUT",
+	"","FAN_5_PRSNT_R1_N_OUT",
+	"","FAN_6_PRSNT_R1_N_OUT",
+	/*E0-E3 line 64-71*/
+	"FM_PWRGD_CHAD_CPU0","FAN_7_PRSNT_R1_N_OUT",
+	"FM_PWRGD_CHEH_CPU0","TRAY_SLOT_ID0_OUT",
+	"FM_PWRGD_CHIL_CPU0","TRAY_SLOT_ID1_OUT",
+	"FM_PWRGD_CHMP_CPU0","TRAY_SLOT_ID2_OUT",
+	/*E4-E7 line 72-79*/
+	"P12V_E1S_0_PWRGD","TRAY_SLOT_ID3_OUT",
+	"P12V_E1S_1_PWRGD","TRAY_SLOT_ID4_OUT",
+	"P3V3_E1S_0_PWRGD","SCM_JTAG_MUX_S0_R",
+	"P3V3_E1S_1_PWRGD","SCM_JTAG_MUX_S1_R",
+	/*F0-F3 line 80-87*/
+	"FM_MODULE_PWRGD_0A","BMC_SGPIO_READY",
+	"OCP_V3_1_P3V3_PLD_R_PWRGD","CPU0_SYS_RESET_N",
+	"P12V_OCP_V3_1_PLD_PWRGD","RST_CPU0_KBRST_N",
+	"PWRGD_OCP_SFF_PWR_GOOD","BIOS_DEBUG_MODE",
+	/*F4-F7 line 88-95*/
+	"","CLR_CMOS",
+	"","I3C_SPD_MUX_FORCE_SEL",
+	"","FM_JTAG_HOST_SEL",
+	"","TRAY_PRESENT_N",
+	/*G0-G3 line 96-103*/
+	"MB_REV_ID_0","UART_BMC_SEL0",
+	"MB_REV_ID_1","UART_BMC_SEL1",
+	"MB_REV_ID_2","SCM_USB_SEL",
+	"MB_SKU_ID_0","FORCE_ALL_PWRON",
+	/*G4-G7 line 104-111*/
+	"MB_SKU_ID_1","PASSWORD_CLEAR",
+	"MB_SKU_ID_2","",
+	"MB_SKU_ID_3","",
+	"","BIOS_DEBUG_MODE",
+	/*H0-H3 line 112-119*/
+	"FM_IOEXP_U538_INT_N","",
+	"FM_IOEXP_U539_INT_N","",
+	"FM_IOEXP_U540_INT_N","",
+	"FM_IOEXP_U541_INT_N","",
+	/*H4-H7 line 120-127*/
+	"FM_IOEXP_PDB2_U1003_INT_N","",
+	"","","","","","",
+	/*I0-I3 line 128-135*/
+	"","","","",
+	"PDB_IRQ_PMBUS_ALERT_ISO_R_N","",
+	"PDB_UV_ALERT_ISO_R_N","",
+	/*I4-I7 line 136-143*/
+	"P12V_SCM_ADC_ALERT","",
+	"CPU0_REGS_I2C_ALERT_N","",
+	"FM_RTC_ALERT_N","",
+	"APML_CPU0_ALERT_R_N","",
+	/*J0-J3 line 144-151*/
+	"SMB_RJ45_FIO_TMP_ALERT","",
+	"FM_SMB_ALERT_MCIO_0A_N","",
+	"I3C_MCIO_0B_ALERT_ISO_R_N","",
+	"FM_SMB_ALERT_MCIO_1A_N","",
+	/*J4-J7 line 152-159*/
+	"I3C_MCIO_1B_ALERT_ISO_R_N","",
+	"FM_SMB_ALERT_MCIO_2A_N","",
+	"I3C_MCIO_2B_ALERT_ISO_R_N","",
+	"FM_SMB_ALERT_MCIO_3A_N","",
+	/*K0-K3 line 160-167*/
+	"I3C_MCIO_3B_ALERT_ISO_R_N","",
+	"FM_SMB_ALERT_MCIO_4A_N","",
+	"I3C_MCIO_4B_ALERT_ISO_R_N","",
+	"","",
+	/*K4-K7 line 168-175*/
+	"","","","","","","","",
+	/*L0-L3 line 176-183*/
+	"FM_CPU0_THERMTRIP_N","",
+	"FM_CPU0_PROCHOT_N","",
+	"FM_CPU0_SMERR_N","",
+	"FM_PVDDCR_CPU0_P0_OCP_N","",
+	/*L4-L7 line 184-191*/
+	"FM_PVDDCR_CPU1_P0_OCP_N","",
+	"FM_PVDDCR_SOC_P0_OCP_N","",
+	"FM_OCP_PWRBRK_R_N","",
+	"PMIC_ERROR_N","",
+	/*M0-M3 line 192-199*/
+	"","","","","","","","",
+	/*M4-M7 line 200-207*/
+	"","","","","","","","",
+	/*N0-N3 line 208-215*/
+	"FM_PRSNT_CPU0_N","",
+	"OCP_SFF_PRSNT_N","",
+	"E1S_0_PRSNT_R_N","",
+	"E1S_BP_0_PRSNT_R_N","",
+	/*N4-N7 line 216-223*/
+	"E1S_BP_1_PRSNT_R_N","",
+	"E1S_BP_2_PRSNT_R_N","",
+	"E1S_BP_3_PRSNT_R_N","",
+	"PDB_PRSNT_J311_N","",
+	/*O0-O3 line 224-231*/
+	"PDB_PRSNT_J312_N","",
+	"PDB_PRSNT_J313_N","",
+	"PDB_PRSNT_J314_N","",
+	"PRSNT_RJ45_FIO_N_R","",
+	/*O4-O7 line 232-239*/
+	"PRSNT_LEAK_CABLE_1_R_N","",
+	"PRSNT_LEAK_CABLE_2_R_N","",
+	"PRSNT_HDT_N","",
+	"","",
+	/*P0-P3 line 240-247*/
+	"","","","","","","","",
+	/*P4-P7 line 248-255*/
+	"","","","","","","","";
+	status = "okay";
+};
+
+// BIOS Flash
+&spi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi2_default>;
+	status = "okay";
+
+	flash@0 {
+		m25p,fast-read;
+		label = "pnor";
+		spi-max-frequency = <12000000>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
+		status = "okay";
+	};
+};
+
+// HOST BIOS Debug
+&uart1 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&uart4 {
+	status = "okay";
+};
+
+// BMC Debug Console
+&uart5 {
+	status = "okay";
+};
+
+&uart_routing {
+	status = "okay";
+};
+
+&wdt1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdtrst1_default>;
+	aspeed,reset-type = "soc";
+	aspeed,external-signal;
+	aspeed,ext-push-pull;
+	aspeed,ext-active-high;
+	aspeed,ext-pulse-duration = <256>;
+	status = "okay";
+};
-- 
2.49.0



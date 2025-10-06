Return-Path: <linux-kernel+bounces-842765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0B7BBD81E
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 11:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41DE1895829
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 09:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E314212546;
	Mon,  6 Oct 2025 09:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="cO81gOx+"
Received: from mx-relay95-hz2.antispameurope.com (mx-relay95-hz2.antispameurope.com [94.100.136.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCA020E029
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.136.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759744329; cv=pass; b=P7yz6xFItNE2hx8y7x4fPDFrTBh8EhxM/oknfX/Rd/JEd462UIqrKmrMNwMpUmgBiZo8eqeSCRBoxIDpIhH+f1J91nhWk7yOhvKvl/b2ykbJvDQEKseBi6HXiK2gkIcuiuN1Bf+fUCEtlYv2SqkKy4xX+5I6iz3/0vxqw/NPerk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759744329; c=relaxed/simple;
	bh=j3WCsairq1WgCQgA3EtS8OrUwtY6E+K5lC9wJPKVWtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AWYB2PsHiygH3tvyQCP2XkJtixf2Rdrgl7kvdbJgFv6/qDBaK4Qyw/vuRSSybp84BiS6sIXVlHK28pZOQBuOVgKXgBywHRn15exTQG3itY79r7oqi26kxdS65hkqi0dlcwYCNbY41VPXmWWz9rcpmcx2QKi/NYJfCFj0E/Q338Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=cO81gOx+; arc=pass smtp.client-ip=94.100.136.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate95-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out01-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=ZrFYIzPuk9rtzNXWXOQAERqhNp/BdwtufnfrutqIGq8=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1759744267;
 b=tYJM+b180EDN05jFxtJUWQQA6QpvNfgtwz1rIiSCs9rxurn2n6boE0Zh3RdDTbLYpXf6/5EL
 rjuPIcFHlwRI3cEMsD8awcV9FEbUDWS42hUcWvjiYriIxkoyumrpPJZtu+GHXmERuDbNUlGFnL0
 eiy9tzXz/5FaB6Gv2ZQuK7iL1Ta7ArWo7IN0ppL+wS/7iuEM0RkVQuK/0qTfEkYrAxYdwNZjxW1
 zgJblAuaqq8YNyDYcHGSX+MTlKvsFVtxm9pd8Oq0qYpqEjl/m6lBxpKyLbWAfhq3U7vE1fD0RVn
 lwJcj6pOcQegkwn5V4CoNr2vrqix2Scohe3fhnvwjfnlg==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1759744267;
 b=CA3HIx173xeflG2FE0IRZwMgy+a9N2Qh3CsvVMgHWpycMWfNEDCBdMm6+BdxguBsoLppP4NI
 TvfZs+f9dM4kQugOb7pmTsiA7WzHBR3j97Ji2pBq3beIJLSYXJJMhLOWUqbojnxTpEYeMH3HhUx
 UCZh9TqmRUU95ApghjifbGsT5Zc32NvAFo3FMP4J53I0Ox3COKPcx0WN3oiLSqTlan7uuvjhSzx
 X4STB909fXLPtDmbsPDayEoYWnHS40X+5S9inBcA+UZUuyE/4EJsvUyTCAr4N3FVf4X5ZreQInb
 C9HEDMnFTR7tVjcurlTriz6YmncLD7us7Ml9Dxn4xei0w==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay95-hz2.antispameurope.com;
 Mon, 06 Oct 2025 11:51:07 +0200
Received: from schifferm-ubuntu.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: matthias.schiffer@ew.tq-group.com)
	by smtp-out01-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 279CFA4070E;
	Mon,  6 Oct 2025 11:50:57 +0200 (CEST)
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH] arm64: dts: ti: k3-am642-tqma64xxl: add boot phase tags
Date: Mon,  6 Oct 2025 11:50:36 +0200
Message-ID: <20251006095036.16367-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:matthias.schiffer@ew.tq-group.com
X-cloud-security-recipient:linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: matthias.schiffer@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay95-hz2.antispameurope.com with 4cgDzj62dxz2Dj9k
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:a80b39d10b8b7722f74fa46e8949e3b1
X-cloud-security:scantime:1.793
DKIM-Signature: a=rsa-sha256;
 bh=ZrFYIzPuk9rtzNXWXOQAERqhNp/BdwtufnfrutqIGq8=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1759744267; v=1;
 b=cO81gOx+H6KRj+7k5PztZPs3fmZLaAAZbgsAcE20N+3855VCtM8VqzdEWKXolDG0iM60lNYr
 UXcKQ09otfbQaRWwXvKivti4Q6X5B3VwdBdKql0drhaK3KlZqAAJBY1wLHY7yCa3875sYGudAkG
 vcC5qUDj2iEoYXTpCHIHF5VUo2/My5khC9XM58sqX/uXewGzlhGTkkf8IBY6DnxW7eX0HIfi2Kt
 p7hu6Rz0Kjd+LomSTXA7MTXh/3cG5FmgVg0RRFXUUEmJHUMhwjhCqm856BQqJy9CRsqjuarw5/3
 9+XyaRP/QKTUjm+iXHRnmobreAy5p09LRl+ikmc03JqTw==

Similar to other AM64x-based boards, add boot phase tags to make the
Device Trees usable for firmware/bootloaders without modification.

Supported boot devices are eMMC/SD card, SPI-NOR and USB (both mass
storage and DFU). The I2C EEPROM is included to allow the firmware to
select the correct RAM configuration for different TQMa64xxL variants.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 .../dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts     | 18 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi | 12 ++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
index 8f64d6272b1ba..81e9e047281fd 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
@@ -167,6 +167,7 @@ reg_pwm_fan: regulator-pwm-fan {
 	};
 
 	reg_sd: regulator-sd {
+		bootph-all;
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
 		pinctrl-0 = <&main_mmc1_reg_pins>;
@@ -245,6 +246,7 @@ icssg1_phy0c: ethernet-phy@c {
 
 
 &main_gpio0 {
+	bootph-all;
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_gpio0_digital_pins>,
 		    <&main_gpio0_hog_pins>;
@@ -263,6 +265,7 @@ &main_gpio0 {
 };
 
 &main_gpio1 {
+	bootph-all;
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_gpio1_hog_pins>,
 		    <&main_gpio1_pru_pins>;
@@ -332,6 +335,7 @@ &main_spi0 {
 
 /* UART/USB adapter port 1 */
 &main_uart0 {
+	bootph-pre-ram;
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart0_pins>;
 	status = "okay";
@@ -492,11 +496,17 @@ &mcu_uart1 {
 };
 
 &serdes_ln_ctrl {
+	bootph-all;
 	idle-states = <AM64_SERDES0_LANE0_USB>;
 };
 
+&serdes_refclk {
+	bootph-all;
+};
+
 &serdes0 {
 	serdes0_usb_link: phy@0 {
+		bootph-all;
 		reg = <0>;
 		#phy-cells = <0>;
 		resets = <&serdes_wiz0 1>;
@@ -506,6 +516,7 @@ serdes0_usb_link: phy@0 {
 };
 
 &sdhci1 {
+	bootph-all;
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc1_pins>;
 	bus-width = <4>;
@@ -524,6 +535,7 @@ adc {
 };
 
 &usb0 {
+	bootph-all;
 	/*
 	 * The CDNS USB driver currently doesn't support overcurrent GPIOs,
 	 * so there is no overcurrent detection. The OC pin is configured
@@ -538,6 +550,7 @@ &usb0 {
 };
 
 &usbss0 {
+	bootph-all;
 	ti,vbus-divider;
 };
 
@@ -621,6 +634,7 @@ AM64X_IOPAD(0x00ac, PIN_INPUT, 7)
 	};
 
 	main_gpio0_hog_pins: main-gpio0-hog-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			/* (P19) GPMC0_CSn2.GPIO0_43 - MMC1_CTRL */
 			AM64X_IOPAD(0x00b0, PIN_OUTPUT, 7)
@@ -730,6 +744,7 @@ AM64X_IOPAD(0x0258, PIN_OUTPUT, 0)
 	};
 
 	main_mmc1_pins: main-mmc1-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			/* (J19) MMC1_CMD */
 			AM64X_IOPAD(0x0294, PIN_INPUT, 0)
@@ -751,6 +766,7 @@ AM64X_IOPAD(0x0290, PIN_INPUT, 0)
 	};
 
 	main_mmc1_reg_pins: main-mmc1-reg-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			/* (C13) SPI0_CS1.GPIO1_43 - MMC1_SD_EN */
 			AM64X_IOPAD(0x020c, PIN_OUTPUT, 7)
@@ -791,6 +807,7 @@ AM64X_IOPAD(0x026c, PIN_INPUT, 7)
 	};
 
 	main_uart0_pins: main-uart0-pins {
+		bootph-pre-ram;
 		pinctrl-single,pins = <
 			/* (D15) UART0_RXD */
 			AM64X_IOPAD(0x0230, PIN_INPUT, 0)
@@ -861,6 +878,7 @@ AM64X_IOPAD(0x0088, PIN_OUTPUT, 2)
 	};
 
 	main_usb0_pins: main-usb0-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			/* (E19) USB0_DRVVBUS */
 			AM64X_IOPAD(0x02a8, PIN_OUTPUT, 0)
diff --git a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi
index ff3b2e0b8dd45..a78297b9fa57e 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi
@@ -14,6 +14,7 @@ aliases {
 	};
 
 	memory@80000000 {
+		bootph-pre-ram;
 		device_type = "memory";
 		/* 1G RAM - default variant */
 		reg = <0x00000000 0x80000000 0x00000000 0x40000000>;
@@ -54,7 +55,12 @@ reg_1v8: regulator-1v8 {
 	};
 };
 
+&fss {
+	bootph-all;
+};
+
 &main_i2c0 {
+	bootph-pre-ram;
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c0_pins>;
 	clock-frequency = <400000>;
@@ -67,6 +73,7 @@ tmp1075: temperature-sensor@4a {
 	};
 
 	eeprom0: eeprom@50 {
+		bootph-pre-ram;
 		compatible = "st,24c02", "atmel,24c02";
 		reg = <0x50>;
 		vcc-supply = <&reg_1v8>;
@@ -89,11 +96,13 @@ eeprom1: eeprom@54 {
 };
 
 &ospi0 {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&ospi0_pins>;
 
 	flash@0 {
+		bootph-all;
 		compatible = "jedec,spi-nor";
 		reg = <0>;
 		spi-tx-bus-width = <8>;
@@ -116,6 +125,7 @@ partitions {
 };
 
 &sdhci0 {
+	bootph-all;
 	status = "okay";
 	non-removable;
 	disable-wp;
@@ -126,6 +136,7 @@ &sdhci0 {
 
 &main_pmx0 {
 	main_i2c0_pins: main-i2c0-pins {
+		bootph-pre-ram;
 		pinctrl-single,pins = <
 			/* (A18) I2C0_SCL */
 			AM64X_IOPAD(0x0260, PIN_INPUT_PULLUP, 0)
@@ -135,6 +146,7 @@ AM64X_IOPAD(0x0264, PIN_INPUT_PULLUP, 0)
 	};
 
 	ospi0_pins: ospi0-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			/* (N20) OSPI0_CLK */
 			AM64X_IOPAD(0x0000, PIN_OUTPUT, 0)
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/



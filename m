Return-Path: <linux-kernel+bounces-735721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAEEB0930A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 19:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A93171C46FA0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA5C2FE32F;
	Thu, 17 Jul 2025 17:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netcube.li header.i=@netcube.li header.b="pa0nwHqA"
Received: from mail.netcube.li (mail.netcube.li [173.249.15.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9C92FA63E;
	Thu, 17 Jul 2025 17:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.249.15.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752772880; cv=none; b=sfvk08yYFEp4XHO7+2ahJnNe9ZxktkN6ij+BwAdko//UletK17OlTbw+iM0i2asPyG/Hpp4SPHKxcuMUaQP8PsPirWgjl8xFZQ4O5FEJF2bPdoLQ5vgKAQ48gbG2Zfogru/h4WSIxW1ncG5Kv6PDR097Z3+9Wix3y1UoIAQd7Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752772880; c=relaxed/simple;
	bh=u8HWWK+cIlmI9xD/XNX3oMG5IA/Gt33mfqYl3j4tvYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=scLqCQs2BD/G9rIXEpe38dWl8+tvq6OMxeThZ9XcPZQg2MXimfw4UkLXmRQnfYymZ7prwpQPk4dt1RYN3iwYmdMhQMYXwDGw3On43Uqa4FptOPup3a/Cd5gKa02hNFI8qpSXhGbefMJ62W+namGR5HMb6b/f9LM+epSmsORSYyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=netcube.li; spf=pass smtp.mailfrom=netcube.li; dkim=pass (1024-bit key) header.d=netcube.li header.i=@netcube.li header.b=pa0nwHqA; arc=none smtp.client-ip=173.249.15.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netcube.li
dkim-signature: v=1; a=rsa-sha256; d=netcube.li; s=s1;
	c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding:In-Reply-To:References;
	bh=5WZGm3DqwxRv0CSswNQ1C9zLs39frvEzhKCCop31TMg=;
	b=pa0nwHqA99bEkXelMX30JcOrEzUi9pkgXy5lhhRxO0ZN2RUMZ3uIRupPigI70KnxDF2wJIG077dKwDEWHZPb7UG3DPZbrmQ5agP2U8KIseF2Bpixf20Qj2v5RcPcW0jfdW0efGj5yORdVcYXtUxUTT7HfY0FCl9Ra2p/ceg3mKg=
Received: from lukas-hpz440workstation.lan.sk100508.local (cm70-231.liwest.at [212.241.70.231])
	by mail.netcube.li with ESMTPA
	; Thu, 17 Jul 2025 19:21:04 +0200
From: Lukas Schmid <lukas.schmid@netcube.li>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Maxime Ripard <mripard@kernel.org>
Cc: Lukas Schmid <lukas.schmid@netcube.li>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v5 3/5] ARM: dts: sunxi: add support for NetCube Systems Nagami SoM
Date: Thu, 17 Jul 2025 19:20:30 +0200
Message-Id: <20250717172035.3508831-4-lukas.schmid@netcube.li>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250717172035.3508831-1-lukas.schmid@netcube.li>
References: <20250717172035.3508831-1-lukas.schmid@netcube.li>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NetCube Systems Nagami SoM is a module based around the Allwinner T113s
SoC. It includes the following features and interfaces:

- 128MB DDR3 included in SoC
- 10/100 Mbps Ethernet using LAN8720A phy
- One USB-OTG interface
- One USB-Host interface
- One I2S interface with in and output support
- Two CAN interfaces
- ESP32 over SDIO
- One SPI interface
- I2C EEPROM for MAC address
- One QWIIC I2C Interface with dedicated interrupt pin shared with EEPROM
- One external I2C interface
- SD interface for external SD-Card

Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
---
 .../allwinner/sun8i-t113s-netcube-nagami.dtsi | 242 ++++++++++++++++++
 1 file changed, 242 insertions(+)
 create mode 100644 arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-nagami.dtsi

diff --git a/arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-nagami.dtsi b/arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-nagami.dtsi
new file mode 100644
index 000000000..ac5d22db7
--- /dev/null
+++ b/arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-nagami.dtsi
@@ -0,0 +1,242 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2025 Lukas Schmid <lukas.schmid@netcube.li>
+ */
+
+/dts-v1/;
+#include "sun8i-t113s.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	model = "NetCube Systems Nagami SoM";
+	compatible = "netcube,nagami", "allwinner,sun8i-t113s";
+
+	aliases {
+		serial1 = &uart1; // ESP32 Bootloader UART
+		serial3 = &uart3; // Console UART on Card Edge
+		ethernet0 = &emac;
+	};
+
+	chosen {
+		stdout-path = "serial3:115200n8";
+	};
+
+	/* module wide 3.3V supply directly from the card edge */
+	reg_vcc3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	/* SY8008 DC/DC regulator on the board, also supplying VDD-SYS */
+	reg_vcc_core: regulator-core {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-core";
+		regulator-min-microvolt = <880000>;
+		regulator-max-microvolt = <880000>;
+		vin-supply = <&reg_vcc3v3>;
+	};
+
+	/* Reset of ESP32 */
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&pio 6 9 GPIO_ACTIVE_LOW>; /* PG9 */
+		post-power-on-delay-ms = <1500>;
+		power-off-delay-us = <200>;
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&reg_vcc_core>;
+};
+
+&cpu1 {
+	cpu-supply = <&reg_vcc_core>;
+};
+
+&dcxo {
+	clock-frequency = <24000000>;
+};
+
+&emac {
+	nvmem-cells = <&eth0_macaddress>;
+	nvmem-cell-names = "mac-address";
+	phy-handle = <&lan8720a>;
+	phy-mode = "rmii";
+	pinctrl-0 = <&rmii_pe_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+/* Default I2C Interface on Card-Edge */
+&i2c2 {
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-names = "default";
+	status = "disabled";
+};
+
+/* Exposed as the QWIIC connector and used by the internal EEPROM */
+&i2c3 {
+	pinctrl-0 = <&i2c3_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	eeprom0: eeprom@50 {
+		compatible = "atmel,24c02";		/* actually it's a 24AA02E48 */
+		reg = <0x50>;
+		pagesize = <16>;
+		read-only;
+		vcc-supply = <&reg_vcc3v3>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		eth0_macaddress: macaddress@fa {
+			reg = <0xfa 0x06>;
+		};
+	};
+};
+
+/* Default I2S Interface on Card-Edge */
+&i2s1 {
+	pinctrl-0 = <&i2s1_pins>, <&i2s1_din_pins>, <&i2s1_dout_pins>;
+	pinctrl-names = "default";
+	status = "disabled";
+};
+
+/* Phy is on SoM. MDI signals pre-magentics are on the card edge */
+&mdio {
+	lan8720a: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+	};
+};
+
+/* Default SD Interface on Card-Edge */
+&mmc0 {
+	pinctrl-0 = <&mmc0_pins>;
+	pinctrl-names = "default";
+	status = "disabled";
+};
+
+/* Connected to the on-board ESP32 */
+&mmc1 {
+	pinctrl-0 = <&mmc1_pins>;
+	pinctrl-names = "default";
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	non-removable;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	status = "okay";
+};
+
+/* Connected to the on-board eMMC */
+&mmc2 {
+	pinctrl-0 = <&mmc2_pins>;
+	pinctrl-names = "default";
+	vmmc-supply = <&reg_vcc3v3>;
+	vqmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+};
+
+&pio {
+	vcc-pb-supply = <&reg_vcc3v3>;
+	vcc-pc-supply = <&reg_vcc3v3>;
+	vcc-pd-supply = <&reg_vcc3v3>;
+	vcc-pe-supply = <&reg_vcc3v3>;
+	vcc-pf-supply = <&reg_vcc3v3>;
+	vcc-pg-supply = <&reg_vcc3v3>;
+
+	gpio-line-names = "", "", "", "", // PA
+					  "", "", "", "",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "", "", "CAN0_TX", "CAN0_RX", // PB
+					  "CAN1_TX", "CAN1_RX", "UART3_TX", "UART3_RX",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "", "", "eMMC_CLK", "eMMC_CMD", // PC
+					  "eMMC_D2", "eMMC_D1", "eMMC_D0", "eMMC_D3",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "", "", "", "", // PD
+					  "", "", "", "",
+					  "", "", "SPI1_CS", "SPI1_CLK",
+					  "SPI1_MOSI", "SPI1_MISO", "SPI1_HOLD", "SPI1_WP",
+					  "PD16", "", "", "",
+					  "I2C2_SCL", "I2C2_SDA", "PD22", "",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "ETH_CRSDV", "ETH_RXD0", "ETH_RXD1", "ETH_TXCK", // PE
+					  "ETH_TXD0", "ETH_TXD1", "ETH_TXEN", "",
+					  "ETH_MDC", "ETH_MDIO", "QWIIC_nINT", "",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "SD_D1", "SD_D0", "SD_CLK", "SD_CLK", // PF
+					  "SD_D3", "SD_D2", "PF6", "",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "ESP_CLK", "ESP_CMD", "ESP_D0", "ESP_D1", // PG
+					  "ESP_D2", "ESP_D3", "UART1_TXD", "UART1_RXD",
+					  "ESP_nBOOT", "ESP_nRST", "I2C3_SCL", "I2C3_SDA",
+					  "I2S1_WS", "I2S1_CLK", "I2S1_DIN0", "I2S1_DOUT0",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "", "", "", "";
+};
+
+/* Remove the unused CK pin from the pinctl as it is unconnected */
+&rmii_pe_pins {
+	pins = "PE0", "PE1", "PE2", "PE3", "PE4",
+		   "PE5", "PE6", "PE8", "PE9";
+};
+
+/* Default SPI Interface on Card-Edge */
+&spi1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-0 = <&spi1_pins>, <&spi1_hold_pin>, <&spi1_wp_pin>;
+	pinctrl-names = "default";
+	cs-gpios = <0>;
+	status = "disabled";
+};
+
+/* Connected to the Bootloader/Console of the ESP32 */
+&uart1 {
+	pinctrl-0 = <&uart1_pg6_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+/* Console/Debug UART on Card-Edge */
+&uart3 {
+	pinctrl-0 = <&uart3_pb_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
-- 
2.39.5




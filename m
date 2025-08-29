Return-Path: <linux-kernel+bounces-791754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A51DB3BB81
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C72246858A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DF131814F;
	Fri, 29 Aug 2025 12:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netcube.li header.i=@netcube.li header.b="RkiczppI"
Received: from mail.netcube.li (mail.netcube.li [173.249.15.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D2331A062;
	Fri, 29 Aug 2025 12:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.249.15.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756471140; cv=none; b=lFaFmcgBS7AOJaPLhhiu2AYuVSk0fgmo+Vqgtj9lPBapvbwbfnjrlQgegvc7Vkb5kS8i25xS4jgqHj2+NkH0s5brENSJCuWOynyMW/CV1Rs372MfPeunh7hOCLjHJdvVtW0k+a4fi8iwdP1TggKT8hxrTz2QyhndjYy0gwhH3HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756471140; c=relaxed/simple;
	bh=UM0Ob5X3U7bd0isypH7RhF7H5j0ZyNHGHE3iIVfmTzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gV2K5WkvTPkD7eOn0yDphlGBUOWuFddnQC4uhWFwy/XB7GxZibXCi/Y6VCVhqgVM1qDriLHSDvbwxrhn/gYf+slGccSB5Ie+8VLYdv3sNxiMYOascp0jgAnoOCYjNK9A0Sdo45a8KVWzfh9E7Ql9QbsPDf/sMVLu3uTaqUymkP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=netcube.li; spf=pass smtp.mailfrom=netcube.li; dkim=pass (1024-bit key) header.d=netcube.li header.i=@netcube.li header.b=RkiczppI; arc=none smtp.client-ip=173.249.15.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netcube.li
dkim-signature: v=1; a=rsa-sha256; d=netcube.li; s=s1;
	c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding:In-Reply-To:References;
	bh=5Ggm6PMeqjU+1XcTgES3L//60Y59E2YjEZXU2MPxGOI=;
	b=RkiczppIfhodj3P2QAZX6W4ogWx3eLxbL9d5igL88DZWLs4SzENIvbFfvwPuia5smrrEn9xB7uZFaOIj0XKHisrDNmgpTGDRbNI/0rqfP2B5WMJere+HDheoYU9SuagbHG9SmBh1z9ltFSLMei52bWDFKr32uruO40T+Mw06C7k=
Received: from lukas-hpz440workstation.lan.sk100508.local (cm70-231.liwest.at [212.241.70.231])
	by mail.netcube.li with ESMTPA
	; Fri, 29 Aug 2025 14:38:39 +0200
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
Subject: [PATCH v6 5/5] ARM: dts: sunxi: add support for NetCube Systems Nagami Keypad Carrier
Date: Fri, 29 Aug 2025 14:37:58 +0200
Message-Id: <20250829123800.1232645-6-lukas.schmid@netcube.li>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250829123800.1232645-1-lukas.schmid@netcube.li>
References: <20250829123800.1232645-1-lukas.schmid@netcube.li>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NetCube Systems Nagami Keypad Carrier uses the Nagami SoM and contains
a TCA8418 connected to a 4x4 matrix keypad. The I2C2 interface is connected
to said TCA8418 and also a header for an PN532 NFC-Module. It also provides
a pin-header for a bi-color status led. Ethernet with PoE support is
available on a screwterminal after magnetics.

Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
---
 arch/arm/boot/dts/allwinner/Makefile          |   1 +
 ...8i-t113s-netcube-nagami-keypad-carrier.dts | 129 ++++++++++++++++++
 2 files changed, 130 insertions(+)
 create mode 100644 arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-nagami-keypad-carrier.dts

diff --git a/arch/arm/boot/dts/allwinner/Makefile b/arch/arm/boot/dts/allwinner/Makefile
index af287bb32..a2137bbe2 100644
--- a/arch/arm/boot/dts/allwinner/Makefile
+++ b/arch/arm/boot/dts/allwinner/Makefile
@@ -259,6 +259,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-s3-pinecube.dtb \
 	sun8i-t113s-mangopi-mq-r-t113.dtb \
 	sun8i-t113s-netcube-nagami-basic-carrier.dtb \
+	sun8i-t113s-netcube-nagami-keypad-carrier.dtb \
 	sun8i-t3-cqa3t-bv3.dtb \
 	sun8i-v3-sl631-imx179.dtb \
 	sun8i-v3s-anbernic-rg-nano.dtb \
diff --git a/arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-nagami-keypad-carrier.dts b/arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-nagami-keypad-carrier.dts
new file mode 100644
index 000000000..fe3a3267d
--- /dev/null
+++ b/arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-nagami-keypad-carrier.dts
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2025 Lukas Schmid <lukas.schmid@netcube.li>
+ */
+
+/dts-v1/;
+#include "sun8i-t113s-netcube-nagami.dtsi"
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "NetCube Systems Nagami Keypad Carrier Board";
+	compatible = "netcube,nagami-keypad-carrier", "netcube,nagami",
+				 "allwinner,sun8i-t113s";
+
+	leds {
+		compatible = "gpio-leds";
+
+		led_status_red: led-status-red {
+			gpios = <&pio 3 16 GPIO_ACTIVE_HIGH>;  /* PD16 */
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_STATUS;
+		};
+
+		led_status_green: led-status-green {
+			gpios = <&pio 3 22 GPIO_ACTIVE_HIGH>;  /* PD22 */
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_STATUS;
+		};
+	};
+};
+
+&i2c2 {
+	status = "okay";
+
+	tca8418: keypad@34 {
+		compatible = "ti,tca8418";
+		reg = <0x34>;
+		interrupts-extended = <&pio 5 6 IRQ_TYPE_EDGE_FALLING>;  /* PF6 */
+		linux,keymap = <MATRIX_KEY(0x03, 0x00, KEY_NUMERIC_A)
+						MATRIX_KEY(0x03, 0x01, KEY_NUMERIC_1)
+						MATRIX_KEY(0x03, 0x02, KEY_NUMERIC_2)
+						MATRIX_KEY(0x03, 0x03, KEY_NUMERIC_3)
+						MATRIX_KEY(0x02, 0x00, KEY_NUMERIC_B)
+						MATRIX_KEY(0x02, 0x01, KEY_NUMERIC_4)
+						MATRIX_KEY(0x02, 0x02, KEY_NUMERIC_5)
+						MATRIX_KEY(0x02, 0x03, KEY_NUMERIC_6)
+						MATRIX_KEY(0x01, 0x00, KEY_NUMERIC_C)
+						MATRIX_KEY(0x01, 0x01, KEY_NUMERIC_7)
+						MATRIX_KEY(0x01, 0x02, KEY_NUMERIC_8)
+						MATRIX_KEY(0x01, 0x03, KEY_NUMERIC_9)
+						MATRIX_KEY(0x00, 0x00, KEY_NUMERIC_D)
+						MATRIX_KEY(0x00, 0x01, KEY_CLEAR)
+						MATRIX_KEY(0x00, 0x02, KEY_NUMERIC_0)
+						MATRIX_KEY(0x00, 0x03, KEY_OK)
+		>;
+		keypad,num-rows = <4>;
+		keypad,num-columns = <4>;
+	};
+};
+
+&pio {
+	gpio-line-names = "", "", "", "", // PA
+					  "", "", "", "",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "", "", "", "", // PB
+					  "", "", "UART3_TX", "UART3_RX",
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
+					  "", "USB_SEC_EN", "", "",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "LED_STATUS_RED", "", "", "",
+					  "I2C2_SCL", "I2C2_SDA", "LED_STATUS_GREEN", "",
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
+					  "", "", "", "", // PF
+					  "", "", "KEY_nINT", "",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "ESP_CLK", "ESP_CMD", "ESP_D0", "ESP_D1", // PG
+					  "ESP_D2", "ESP_D3", "UART1_TXD", "UART1_RXD",
+					  "ESP_nBOOT", "ESP_nRST", "I2C3_SCL", "I2C3_SDA",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "", "", "", "",
+					  "", "", "", "";
+};
+
+&usb_otg {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&usbphy {
+	status = "okay";
+};
-- 
2.39.5




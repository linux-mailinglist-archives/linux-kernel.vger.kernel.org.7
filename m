Return-Path: <linux-kernel+bounces-898234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BBDC54A6E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1EC91348906
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC572E9EB1;
	Wed, 12 Nov 2025 21:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="03K0jtFL"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DC62E339B;
	Wed, 12 Nov 2025 21:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762983751; cv=none; b=Td2dZJ8PdCw+2mxN6O/8L2pGT4odBwqnFRuSDyyqx5h3H7H/qY1lM1o/Iz4qQUP2edaX4nEt3rYMlTjozsB7EjdvYYp+iZL6+kc9Z3NN78rVFWBBSCXgWTzumw8WmoddNDeAceax5EyhxEyC3pDxkXNxmm6XPe37oDtvMXdzyIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762983751; c=relaxed/simple;
	bh=suOMxoxsrDn9Qbk3yoCOOCXl2JF9jd0Jq5wWPUwICPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f0IiJ1EgvE0Cvo+/WqnrUF3IAkIGXZAB9wAvOs86AR4v0ZaWL4/9ARCr6zLVMfmhXxmEw7Y6BFk7r3BRdNoE+hH4HilhWIYwH1MzMN9eeoxfgK3IfBpIpYqjVHywkbb34rfkx+lNlV0j2lYA7FMtcs52bW0MGwi5izIiCyUAjQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=03K0jtFL; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=zIMvkc+aUVzHtiIWLt+CuErIrmOBVHtQG23gZ5btGGw=; b=03K0jtFLU3fIFAIX/D9cUYTXAX
	NSV/viXR3UHmkrp5fEQ8NDk6v2M07kqK1nLXh+r2oYNXkzrt90zh+b0eaLzu5ABZtb1xmGq4zdOo+
	XVHoA+2CHDH5cYLrqoAtN2frn5aFssIRlC+L/btG3fi0qHYM6rcgqhK1TadOuPC6H6M9tZ9658Rts
	S9dm8MUeuNONdrGWTRmxsLOfdLJiF8FYCe/w16Rug+3Ph4J2NvY9iHnQ6exsFqrpsyYT+YcABkzUU
	ywC1koskohmoY/yc52teo39XNzKMTuPSLQO+VWhZ4LRRL2xIk4+kDgaMbNWkdpkS6zvtlSDebnUFy
	kpaRZNkw==;
Received: from i53875b63.versanet.de ([83.135.91.99] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vJIba-0003tg-Lj; Wed, 12 Nov 2025 22:42:18 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ukleinek@debian.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v2 5/5] arm64: dts: rockchip: add QNAP TS233 devicetree
Date: Wed, 12 Nov 2025 22:42:06 +0100
Message-ID: <20251112214206.423244-6-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251112214206.423244-1-heiko@sntech.de>
References: <20251112214206.423244-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TS233 is a 2 bay NAS similar to the TS433. Architecture-wise it really
seems to be the same minus the additional PCIe connected components the
TS433 has.

So it just uses two of the SoCs SATA ports and the SoC's gigabit ethernet.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3568-qnap-ts233.dts   | 131 ++++++++++++++++++
 2 files changed, 132 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-qnap-ts233.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index ad684e3831bc..d1d384df00b7 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -142,6 +142,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-nanopi-r5c.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-nanopi-r5s.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-odroid-m1.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-photonicat.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-qnap-ts233.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-qnap-ts433.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-radxa-e25.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-roc-pc.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts233.dts b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts233.dts
new file mode 100644
index 000000000000..f16d1c628793
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts233.dts
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
+ * Copyright (c) 2024 Heiko Stuebner <heiko@sntech.de>
+ */
+
+/dts-v1/;
+
+#include "rk3568-qnap-tsx33.dtsi"
+
+/ {
+	model = "Qnap TS-233-2G NAS System 2-Bay";
+	compatible = "qnap,ts233", "rockchip,rk3568";
+
+	aliases {
+		ethernet0 = &gmac0;
+	};
+};
+
+/* connected to sata2 */
+&combphy2 {
+	status = "okay";
+};
+
+&gmac0 {
+	assigned-clocks = <&cru SCLK_GMAC0_RX_TX>, <&cru SCLK_GMAC0>;
+	assigned-clock-parents = <&cru SCLK_GMAC0_RGMII_SPEED>, <&cru CLK_MAC0_2TOP>;
+	assigned-clock-rates = <0>, <125000000>;
+	clock_in_out = "output";
+	phy-handle = <&rgmii_phy0>;
+	phy-mode = "rgmii-id";
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac0_miim
+		     &gmac0_tx_bus2
+		     &gmac0_rx_bus2
+		     &gmac0_rgmii_clk
+		     &gmac0_rgmii_bus>;
+	status = "okay";
+};
+
+&i2c1 {
+	/* eeprom for vital-product-data on the backplane */
+	eeprom@56 {
+		compatible = "giantec,gt24c04a", "atmel,24c04";
+		reg = <0x56>;
+		label = "VPD_BP";
+		num-addresses = <2>;
+		pagesize = <16>;
+		read-only;
+	};
+};
+
+&leds {
+	led-1 {
+		color = <LED_COLOR_ID_GREEN>;
+		function = LED_FUNCTION_DISK;
+		gpios = <&gpio1 RK_PD6 GPIO_ACTIVE_LOW>;
+		label = "hdd2:green:disk";
+		linux,default-trigger = "disk-activity";
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdd2_led_pin>;
+	};
+};
+
+&mcu {
+	compatible = "qnap,ts233-mcu";
+};
+
+&mdio0 {
+	rgmii_phy0: ethernet-phy@3 {
+		/* Motorcomm YT8521 phy */
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x3>;
+		pinctrl-0 = <&eth_phy0_reset_pin>;
+		pinctrl-names = "default";
+		reset-assert-us = <10000>;
+		reset-gpios = <&gpio0 RK_PC6 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&pinctrl {
+	gmac0 {
+		eth_phy0_reset_pin: eth-phy0-reset-pin {
+			rockchip,pins = <0 RK_PC6 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	leds {
+		hdd2_led_pin: hdd2-led-pin {
+			rockchip,pins = <1 RK_PD6 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+};
+
+&sata2 {
+	status = "okay";
+};
+
+&usb2phy1 {
+	status = "okay";
+};
+
+/* connected to usb_host1_ehci/ohci */
+&usb2phy1_host {
+	phy-supply = <&vcc5v0_host>;
+	status = "okay";
+};
+
+/* connected to usb_host0_ehci/ohci */
+&usb2phy1_otg {
+	phy-supply = <&vcc5v0_host>;
+	status = "okay";
+};
+
+/* right port backside */
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
+
+/* left port backside */
+&usb_host1_ehci {
+	status = "okay";
+};
+
+&usb_host1_ohci {
+	status = "okay";
+};
-- 
2.47.2



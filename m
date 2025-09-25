Return-Path: <linux-kernel+bounces-832119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A49B9E624
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F18DE7A5710
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9942ED860;
	Thu, 25 Sep 2025 09:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="nPvMcsWY"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676C12ECD20;
	Thu, 25 Sep 2025 09:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792650; cv=none; b=L2bp95uq6YcUGtdvr5xnZRCbY1DJX6Tiu80P6v3oBhO6MafYCG+dJQExLCKEY3RiD6G0UnVvfs7ar8XmZDJO1ulq4p43exumMCjw9V/V3VlC519coAwpjrIVV+lbzqBEjcZMSCdWorrzYURPMwrsXE3Ks3G+OAsa0vDcTCeuwzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792650; c=relaxed/simple;
	bh=ZUnSoFvkD7jeSi0Clyvp1ZQehZbK4M/+E+0Ag46T6eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eSxHGfevaHjleWusgZX4dVxNWgtq2viTU56X50e88VCZexgkmjZ4FjBigYg6WsjdTq9ZjjjuPe8b0E46Lr1aj+2fibxzid07F+InZxP9YrkAkwoBwCgdwEqKwsGPoozd42FYQ/qMfz+ACWBF+NYN7XbJdzNhHaLcdfnFLRpVi0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=nPvMcsWY; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=pJh0xYZn4Fs8ezjT/CyryQ1lBic3vITlPb+szGNSqx0=; b=nPvMcsWYWsJUGpkTQscv/3+uyS
	KufzznPaeuEo7X4b5pigg9fUYnHFUSpbhUDscCGngqEgHjaM+RMaCOjgnMKtLOqfifl8aVnSh901T
	+Y41MD/qnZI8r+SiWn2MRCJbNrfgpJ0bwVDQrq18fzkkIvyvynNpYwTgk0cwMZ4uNv3KazUBs3Gb/
	KQykKEN+7wxZit2z0LIGSH50JVE7IIlqHQGPQR2iq+c7eCJY4Tpgmat/L9HMmEUHGZlK5b70Wqx7T
	LqjQnWuNVWDlC5eAwYgzSDtX/1eevs0uIWn/XW4b6hvDYadUclwRFxg/dLknFUGve2JUFm006f0kF
	VgfYMGkg==;
Received: from i53875a54.versanet.de ([83.135.90.84] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1v1iJH-0001Nz-Ok; Thu, 25 Sep 2025 11:30:43 +0200
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
Subject: [PATCH 6/6] arm64: dts: rockchip: add QNAP TS233 devicetree
Date: Thu, 25 Sep 2025 11:29:23 +0200
Message-ID: <20250925092923.2184187-7-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250925092923.2184187-1-heiko@sntech.de>
References: <20250925092923.2184187-1-heiko@sntech.de>
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
 .../boot/dts/rockchip/rk3568-qnap-ts233.dts   | 133 ++++++++++++++++++
 2 files changed, 134 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-qnap-ts233.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 099520962ffb..f1b7917ae22b 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -136,6 +136,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-nanopi-r5c.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-nanopi-r5s.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-odroid-m1.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-photonicat.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-qnap-ts233.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-qnap-ts433.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-radxa-e25.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-roc-pc.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts233.dts b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts233.dts
new file mode 100644
index 000000000000..29181de1bd26
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts233.dts
@@ -0,0 +1,133 @@
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
+	rx_delay = <0x15>;
+	tx_delay = <0x21>;
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



Return-Path: <linux-kernel+bounces-744020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEA7B10702
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99379542966
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0C425B1D5;
	Thu, 24 Jul 2025 09:50:29 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5492571C2;
	Thu, 24 Jul 2025 09:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753350629; cv=none; b=Kw07Kh12yjxfsqayZkUn3HWZi8zdWkwTncV1wf8/tmLV5pN+mHIzbs1s+I6JE5xiUUiSrlReV24j9G2UumJrYa4S5nnB5WJ0i2h0d71dqeThuSWExinpedPlZQPHZ+Y4g96mpPl3afTXZ5j0cQRpPdhVQyBtogwlRRHpOcVNG0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753350629; c=relaxed/simple;
	bh=h6Bgo2bklDJST7hHhH+86aEXeQqWnZDVYkoiDw0DffE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V90d2gLzJdMMBwOOxqafQRIBrfU392N1CdPhTtL2hiTvEv7E+gNys8SzgzU41XpCT7ryu50r3JBgxKY2GQp8PkPxOydOL2AoJw82DMQ2S9pCjKTTtxdPVCC/UlIxzVUPl3ExQy3mzEy8lCcFgeXZgnPX8BBpHCYtmqG+/rfdvqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 89C6EB4D0D91;
	Thu, 24 Jul 2025 11:50:23 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Emil Renner Berthing <kernel@esmil.dk>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	E Shattow <e@freeshell.de>,
	linux-riscv@lists.infradead.org
Subject: [PATCH v1 4/4] riscv: dts: starfive: add Milk-V Mars CM Lite system-on-module
Date: Thu, 24 Jul 2025 02:48:47 -0700
Message-ID: <20250724094912.253723-5-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250724094912.253723-1-e@freeshell.de>
References: <20250724094912.253723-1-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Milk-V Mars CM Lite is a System-on-Module based on the Milk-V Mars CM
without the onboard eMMC storage component populated and configured
instead for SD3.0 Card Slot on that interface via 100-pin connector.

Link to Milk-V Mars CM Lite schematics: https://github.com/milkv-mars/mars-files/tree/main/Mars-CM_Hardware_Schematices
Link to StarFive JH7110 Technical Reference Manual: https://doc-en.rvspace.org/JH7110/TRM/index.html
Link to Raspberry Pi CM4IO datasheet: https://datasheets.raspberrypi.com/cm4io/cm4io-datasheet.pdf

Add the devicetree file to make use of StarFive JH7110 common supported
features PMIC, EEPROM, UART, I2C, GPIO, PCIe, QSPI Flash, PWM, and
Ethernet. Also configure the eMMC interface mmc0 for SD Card use and
configure the common SD Card interface mmc1 for onboard SDIO BT+WiFi.

Signed-off-by: E Shattow <e@freeshell.de>
---
 arch/riscv/boot/dts/starfive/Makefile         |   1 +
 .../dts/starfive/jh7110-milkv-marscm-lite.dts | 176 ++++++++++++++++++
 2 files changed, 177 insertions(+)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-lite.dts

diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/starfive/Makefile
index 79742617ddab..62b659f89ba7 100644
--- a/arch/riscv/boot/dts/starfive/Makefile
+++ b/arch/riscv/boot/dts/starfive/Makefile
@@ -11,6 +11,7 @@ dtb-$(CONFIG_ARCH_STARFIVE) += jh7100-starfive-visionfive-v1.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-deepcomputing-fml13v01.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-mars.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-marscm-emmc.dtb
+dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-marscm-lite.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-pine64-star64.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.2a.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.3b.dtb
diff --git a/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-lite.dts b/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-lite.dts
new file mode 100644
index 000000000000..e110146f0b76
--- /dev/null
+++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-lite.dts
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2025 E Shattow <e@freeshell.de>
+ */
+
+/dts-v1/;
+#include <dt-bindings/pinctrl/starfive,jh7110-pinctrl.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "jh7110-common.dtsi"
+
+/ {
+	model = "Milk-V Mars CM Lite";
+	compatible = "milkv,marscm-lite", "starfive,jh7110";
+
+	aliases {
+		i2c1 = &i2c1;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		serial3 = &uart3;
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&sysgpio 33 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&gmac0 {
+	assigned-clocks = <&aoncrg JH7110_AONCLK_GMAC0_TX>;
+	assigned-clock-parents = <&aoncrg JH7110_AONCLK_GMAC0_RMII_RTX>;
+	starfive,tx-use-rgmii-clk;
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "disabled";
+};
+
+&i2c6 {
+	status = "disabled";
+};
+
+&mmc0 {
+	bus-width = <4>;
+	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
+};
+
+&mmc0_pins {
+	pwren-pins {
+		pinmux = <GPIOMUX(22, GPOUT_HIGH,
+				      GPOEN_ENABLE,
+				      GPI_NONE)>;
+	};
+};
+
+&mmc1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	mmc-pwrseq = <&sdio_pwrseq>;
+	non-removable;
+	status = "okay";
+
+	ap6256: wifi@1 {
+		compatible = "brcm,bcm43456-fmac", "brcm,bcm4329-fmac";
+		reg = <1>;
+		interrupt-parent = <&sysgpio>;
+		interrupts = <34 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "host-wake";
+		pinctrl-0 = <&wifi_host_wake_irq>;
+		pinctrl-names = "default";
+	};
+};
+
+&pcie0 {
+	status = "okay";
+};
+
+&phy0 {
+	rx-internal-delay-ps = <1500>;
+	tx-internal-delay-ps = <1500>;
+	motorcomm,rx-clk-drv-microamp = <3970>;
+	motorcomm,rx-data-drv-microamp = <2910>;
+	motorcomm,tx-clk-10-inverted;
+	motorcomm,tx-clk-100-inverted;
+	motorcomm,tx-clk-1000-inverted;
+	motorcomm,tx-clk-adj-enabled;
+};
+
+&pwm {
+	status = "okay";
+};
+
+&spi0 {
+	status = "okay";
+};
+
+&sysgpio {
+	uart1_pins: uart1-0 {
+		tx-pins {
+			pinmux = <GPIOMUX(16, GPOUT_SYS_UART1_TX,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			bias-disable;
+			drive-strength = <12>;
+			input-disable;
+			input-schmitt-disable;
+		};
+
+		rx-pins {
+			pinmux = <GPIOMUX(17, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_SYS_UART1_RX)>;
+			bias-pull-up;
+			input-enable;
+			input-schmitt-enable;
+		};
+
+		cts-pins {
+			pinmux = <GPIOMUX(3, GPOUT_LOW,
+					     GPOEN_DISABLE,
+					     GPI_SYS_UART1_CTS)>;
+			bias-disable;
+			input-enable;
+			input-schmitt-enable;
+		};
+
+		rts-pins {
+			pinmux = <GPIOMUX(2, GPOUT_SYS_UART1_RTS,
+					     GPOEN_ENABLE,
+					     GPI_NONE)>;
+			bias-disable;
+			input-disable;
+			input-schmitt-disable;
+		};
+	};
+
+	usb0_pins: usb0-0 {
+		vbus-pins {
+			pinmux = <GPIOMUX(25, GPOUT_SYS_USB_DRIVE_VBUS,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			bias-disable;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+	};
+
+	wifi_host_wake_irq: wifi-host-wake-irq {
+		wake-pins {
+			pinmux = <GPIOMUX(34, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_NONE)>;
+			input-enable;
+		};
+	};
+};
+
+&uart1 {
+	uart-has-rtscts;
+	pinctrl-0 = <&uart1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&usb0 {
+	dr_mode = "host";
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_pins>;
+	status = "okay";
+};
-- 
2.50.0



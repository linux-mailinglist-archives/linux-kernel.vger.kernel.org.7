Return-Path: <linux-kernel+bounces-795741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A52D7B3F73E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 810B717EB98
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22CB2E9EC6;
	Tue,  2 Sep 2025 07:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Jrk8NtMD"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101C62E8E0D;
	Tue,  2 Sep 2025 07:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756799811; cv=none; b=hcB6QYOoG2QVngSpcniDNT8Kpu7OoHNyH28DGbVGRa/PmjTsvQuzP5iWlaUB1YyCucx5rT+nEHAskFLTT7bj3sfR3Pnn24YGFmh99d3c9t8o9BnNVJBmddpHOYTeyoLl4RbpnK1rm0lfoWJa46M4wnL2KdHDX59SPt/+kUnOUSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756799811; c=relaxed/simple;
	bh=9KGyJP3LK1ZL09XdXf4HfRGf+ddPpA8Rj5qXmoNg/yY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G22AsL8pYy8536G7zCCBt6fgoKwO5hecchoYM9gF2b9acxV/dehAxD0if8V9ge/lZ5hItfZzJLvSEds9hfIIicCSFl+Olz3osJUxA4FHuDfokg3cAYS+6VvVxYf/Q2zuoVR4+To1qtVQope1bSnLNNRfW5meLkffu6t7D78nn5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Jrk8NtMD; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756799809; x=1788335809;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9KGyJP3LK1ZL09XdXf4HfRGf+ddPpA8Rj5qXmoNg/yY=;
  b=Jrk8NtMDohBp76ebKWtj6VC8f6al6IpyQsXQ8S0VGzvnj+TLZvr0dbAA
   SjRapQoXhIDaE8Bat4iiy1HUBBLCDW79AvMVUJq0qJuCRmrecvrCCHa3q
   b9v0XnAwqC1PwE7ySLJzZtfOEldjChNp+PIYggHMSgv8xs/afnp4/W6A8
   Y6bpQveYdvTx+kwv9Tpe5YAT7lfkjUyKxNoMszb/Y0UhTvmCNJnJlKJWT
   vt9ah8xOeA1y62Xw9G92B+AYZzd3vBaXyvxRe6qCvAlJ7gZV+PBxvWExZ
   I/iHOg003oYhKIAVF9HAsRcGznXFnpLsvNq/oe+t0hgHr4RGSek8UgWKp
   w==;
X-CSE-ConnectionGUID: I0e7JmeXSliqGe+ljgjh1Q==
X-CSE-MsgGUID: IEx/DkbGRSK6X41AU2uX1A==
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="45916750"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2025 00:56:46 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 2 Sep 2025 00:56:21 -0700
Received: from valentina.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 2 Sep 2025 00:56:19 -0700
From: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
To: <conor.dooley@microchip.com>, <daire.mcnamara@microchip.com>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<valentina.fernandezalanis@microchip.com>
CC: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v2 5/5] riscv: dts: microchip: add a device tree for Discovery Kit
Date: Tue, 2 Sep 2025 08:55:48 +0100
Message-ID: <20250902075548.1967613-6-valentina.fernandezalanis@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902075548.1967613-1-valentina.fernandezalanis@microchip.com>
References: <20250902075548.1967613-1-valentina.fernandezalanis@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add a minimal device tree for the Microchip PolarFire SoC Discovery Kit.
The Discovery Kit is a cost-optimized board based on PolarFire SoC
MPFS095T and features:

- 1 GB DDR4x16
- 1x Gigabit Ethernet
- 3x UARTs
- Raspberry Pi connector
- mikroBus connector
- microSD card connector

Link: https://www.microchip.com/en-us/development-tool/mpfs-disco-kit
Signed-off-by: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
---
 arch/riscv/boot/dts/microchip/Makefile        |   1 +
 .../dts/microchip/mpfs-disco-kit-fabric.dtsi  |  58 ++++++
 .../boot/dts/microchip/mpfs-disco-kit.dts     | 190 ++++++++++++++++++
 3 files changed, 249 insertions(+)
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-disco-kit-fabric.dtsi
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-disco-kit.dts

diff --git a/arch/riscv/boot/dts/microchip/Makefile b/arch/riscv/boot/dts/microchip/Makefile
index 1e2f4e41bf0d..345ed7a48cc1 100644
--- a/arch/riscv/boot/dts/microchip/Makefile
+++ b/arch/riscv/boot/dts/microchip/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-beaglev-fire.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-disco-kit.dtb
 dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-icicle-kit.dtb
 dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-icicle-kit-prod.dtb
 dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-m100pfsevp.dtb
diff --git a/arch/riscv/boot/dts/microchip/mpfs-disco-kit-fabric.dtsi b/arch/riscv/boot/dts/microchip/mpfs-disco-kit-fabric.dtsi
new file mode 100644
index 000000000000..03900e634fe2
--- /dev/null
+++ b/arch/riscv/boot/dts/microchip/mpfs-disco-kit-fabric.dtsi
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* Copyright (c) 2020-2025 Microchip Technology Inc */
+
+/ {
+	core_pwm0: pwm@40000000 {
+		compatible = "microchip,corepwm-rtl-v4";
+		reg = <0x0 0x40000000 0x0 0xF0>;
+		microchip,sync-update-mask = /bits/ 32 <0>;
+		#pwm-cells = <3>;
+		clocks = <&ccc_sw CLK_CCC_PLL0_OUT3>;
+		status = "disabled";
+	};
+
+	i2c2: i2c@40000200 {
+		compatible = "microchip,corei2c-rtl-v7";
+		reg = <0x0 0x40000200 0x0 0x100>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&ccc_sw CLK_CCC_PLL0_OUT3>;
+		interrupt-parent = <&plic>;
+		interrupts = <122>;
+		clock-frequency = <100000>;
+		status = "disabled";
+	};
+
+	ihc: mailbox {
+		compatible = "microchip,sbi-ipc";
+		interrupt-parent = <&plic>;
+		interrupts = <180>, <179>, <178>, <177>;
+		interrupt-names = "hart-1", "hart-2", "hart-3", "hart-4";
+		#mbox-cells = <1>;
+		status = "disabled";
+	};
+
+	mailbox@50000000 {
+		compatible = "microchip,miv-ihc-rtl-v2";
+		reg = <0x0 0x50000000 0x0 0x1c000>;
+		interrupt-parent = <&plic>;
+		interrupts = <180>, <179>, <178>, <177>;
+		interrupt-names = "hart-1", "hart-2", "hart-3", "hart-4";
+		#mbox-cells = <1>;
+		microchip,ihc-chan-disabled-mask = /bits/ 16 <0>;
+		status = "disabled";
+	};
+
+	refclk_ccc: cccrefclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+	};
+};
+
+&ccc_sw {
+	clocks = <&refclk_ccc>, <&refclk_ccc>, <&refclk_ccc>, <&refclk_ccc>,
+		 <&refclk_ccc>, <&refclk_ccc>;
+	clock-names = "pll0_ref0", "pll0_ref1", "pll1_ref0", "pll1_ref1",
+		      "dll0_ref", "dll1_ref";
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/microchip/mpfs-disco-kit.dts b/arch/riscv/boot/dts/microchip/mpfs-disco-kit.dts
new file mode 100644
index 000000000000..c068b9bb5bfd
--- /dev/null
+++ b/arch/riscv/boot/dts/microchip/mpfs-disco-kit.dts
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* Copyright (c) 2020-2025 Microchip Technology Inc */
+
+/dts-v1/;
+
+#include "mpfs.dtsi"
+#include "mpfs-disco-kit-fabric.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "Microchip PolarFire-SoC Discovery Kit";
+	compatible = "microchip,mpfs-disco-kit-reference-rtl-v2507",
+		     "microchip,mpfs-disco-kit",
+		     "microchip,mpfs";
+
+	aliases {
+		ethernet0 = &mac0;
+		serial4 = &mmuart4;
+	};
+
+	chosen {
+		stdout-path = "serial4:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-1 {
+			gpios = <&gpio2 17 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_AMBER>;
+			label = "led1";
+		};
+
+		led-2 {
+			gpios = <&gpio2 18 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_RED>;
+			label = "led2";
+		};
+
+		led-3 {
+			gpios = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_AMBER>;
+			label = "led3";
+		};
+
+		led-4 {
+			gpios = <&gpio2 20 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_RED>;
+			label = "led4";
+		};
+
+		led-5 {
+			gpios = <&gpio2 21 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_AMBER>;
+			label = "led5";
+		};
+
+		led-6 {
+			gpios = <&gpio2 22 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_RED>;
+			label = "led6";
+		};
+
+		led-7 {
+			gpios = <&gpio2 23 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_AMBER>;
+			label = "led7";
+		};
+
+		led-8 {
+			gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_RED>;
+			label = "led8";
+		};
+	};
+
+	ddrc_cache_lo: memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x40000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		hss_payload: region@bfc00000 {
+			reg = <0x0 0xbfc00000 0x0 0x400000>;
+			no-map;
+		};
+	};
+};
+
+&core_pwm0 {
+	status = "okay";
+};
+
+&gpio1 {
+	interrupts = <27>, <28>, <29>, <30>,
+		     <31>, <32>, <33>, <47>,
+		     <35>, <36>, <37>, <38>,
+		     <39>, <40>, <41>, <42>,
+		     <43>, <44>, <45>, <46>,
+		     <47>, <48>, <49>, <50>;
+	status = "okay";
+};
+
+&gpio2 {
+	interrupts = <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>;
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&ihc {
+	status = "okay";
+};
+
+&mac0 {
+	phy-mode = "sgmii";
+	phy-handle = <&phy0>;
+	status = "okay";
+
+	phy0: ethernet-phy@b {
+		reg = <0xb>;
+	};
+};
+
+&mbox {
+	status = "okay";
+};
+
+&mmc {
+	bus-width = <4>;
+	disable-wp;
+	cap-sd-highspeed;
+	cap-mmc-highspeed;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	no-1-8-v;
+	status = "okay";
+};
+
+&mmuart1 {
+	status = "okay";
+};
+
+&mmuart4 {
+	status = "okay";
+};
+
+&refclk {
+	clock-frequency = <125000000>;
+};
+
+&refclk_ccc {
+	clock-frequency = <50000000>;
+};
+
+&rtc {
+	status = "okay";
+};
+
+&spi0 {
+	status = "okay";
+};
+
+&spi1 {
+	status = "okay";
+};
+
+&syscontroller {
+	status = "okay";
+};
-- 
2.34.1



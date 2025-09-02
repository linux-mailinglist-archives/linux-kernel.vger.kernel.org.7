Return-Path: <linux-kernel+bounces-795732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32704B3F72B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E37B48669E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C732E7F35;
	Tue,  2 Sep 2025 07:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="haoLTgX8"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683832E7F15;
	Tue,  2 Sep 2025 07:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756799794; cv=none; b=DCAQg/lKLWFz++duYjfCEae4Cg9Yaof6NWRGbu7KTNWGJjnL/2FWc8Do25ghO9KJwti5kOESvNNUEga/HQ27YO2LIgdiauhEOqpRMUpddxDFQc3JUvRlFQDX/JinwrPlL4Pou1iBcTqc2YoefVvd1GDC31k7mQ5JpffSOLOuoak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756799794; c=relaxed/simple;
	bh=TB1dOd76PEJ5mgVTi3H1IPzDArXUmTgjE1tKSSsdtws=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xnro2pL4w04byO+oScWqKz41q8mlZ4t4wtXxuZWazWENOkHQmgrsRxgiM5qAaBO+UNq2++MOwUOB1d1+hI5V3fAmMiAVTrol07hbTWFPU1xDaM/C7PnKfkagtBYwMmfgrp94zTDDf15QQMZ8O3ERhXN+MMSYGHgxfOm0R65G4bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=haoLTgX8; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756799792; x=1788335792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TB1dOd76PEJ5mgVTi3H1IPzDArXUmTgjE1tKSSsdtws=;
  b=haoLTgX8xZNYEZ2gen4IHT9QVaJmT4AZ0uPn0zhL86aDd93kHJB26kcr
   a+DtV7wyUAVyZoFD8uhsN8BNMnuyi0g0k0ukhCOQaQuasveJiXRyE8Ir0
   ZRlzrGArPt/NJ2SNtHL299hKNZi5rVJOSUX9DpCgLys74w6ui6e4NaXY3
   aLW0iMVpk4+nn0W+gews7QJQGi0gCDHrZRar7PbowhDnfCpf12GwWU04Z
   jyLqZPH3emYpC+03tUpkxhY6X+UMt8cYEyyv9XsfgpKm2Nm7dZg9iqjph
   B9ehhCXU1YSqlAd7GmdZgiUTrRhAdhfP0Mh/eXsotqGSDnSCa6F5YzyMp
   w==;
X-CSE-ConnectionGUID: Oo81X4TNRaaQSutmf5DBgg==
X-CSE-MsgGUID: IMFoVAFOTfCHdTNldPpJnA==
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="46488626"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2025 00:56:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 2 Sep 2025 00:56:11 -0700
Received: from valentina.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 2 Sep 2025 00:56:09 -0700
From: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
To: <conor.dooley@microchip.com>, <daire.mcnamara@microchip.com>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<valentina.fernandezalanis@microchip.com>
CC: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v2 1/5] riscv: dts: microchip: add common board dtsi for icicle kit variants
Date: Tue, 2 Sep 2025 08:55:44 +0100
Message-ID: <20250902075548.1967613-2-valentina.fernandezalanis@microchip.com>
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

In preparation for supporting the Icicle Kit with production silicon,
add a common board dtsi for the icicle kit with hardware shared by both
the engineering sample and production versions.

Signed-off-by: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
---
 .../dts/microchip/mpfs-icicle-kit-common.dtsi | 247 ++++++++++++++++++
 .../boot/dts/microchip/mpfs-icicle-kit.dts    | 241 +----------------
 2 files changed, 248 insertions(+), 240 deletions(-)
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-icicle-kit-common.dtsi

diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-common.dtsi b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-common.dtsi
new file mode 100644
index 000000000000..eafea3b69cd7
--- /dev/null
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-common.dtsi
@@ -0,0 +1,247 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* Copyright (c) 2025 Microchip Technology Inc */
+
+/dts-v1/;
+
+#include "mpfs.dtsi"
+#include "mpfs-icicle-kit-fabric.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	aliases {
+		ethernet0 = &mac1;
+		serial0 = &mmuart0;
+		serial1 = &mmuart1;
+		serial2 = &mmuart2;
+		serial3 = &mmuart3;
+		serial4 = &mmuart4;
+	};
+
+	chosen {
+		stdout-path = "serial1:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-1 {
+			gpios = <&gpio2 16 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_RED>;
+			label = "led1";
+		};
+
+		led-2 {
+			gpios = <&gpio2 17 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_RED>;
+			label = "led2";
+		};
+
+		led-3 {
+			gpios = <&gpio2 18 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_AMBER>;
+			label = "led3";
+		};
+
+		led-4 {
+			gpios = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_AMBER>;
+			label = "led4";
+		};
+	};
+
+	ddrc_cache_lo: memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x40000000>;
+		status = "okay";
+	};
+
+	ddrc_cache_hi: memory@1040000000 {
+		device_type = "memory";
+		reg = <0x10 0x40000000 0x0 0x40000000>;
+		status = "okay";
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		hss_payload: region@BFC00000 {
+			reg = <0x0 0xBFC00000 0x0 0x400000>;
+			no-map;
+		};
+	};
+};
+
+&core_pwm0 {
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
+&i2c1 {
+	status = "okay";
+
+	power-monitor@10 {
+		compatible = "microchip,pac1934";
+		reg = <0x10>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		channel@1 {
+			reg = <0x1>;
+			shunt-resistor-micro-ohms = <10000>;
+			label = "VDDREG";
+		};
+
+		channel@2 {
+			reg = <0x2>;
+			shunt-resistor-micro-ohms = <10000>;
+			label = "VDDA25";
+		};
+
+		channel@3 {
+			reg = <0x3>;
+			shunt-resistor-micro-ohms = <10000>;
+			label = "VDD25";
+		};
+
+		channel@4 {
+			reg = <0x4>;
+			shunt-resistor-micro-ohms = <10000>;
+			label = "VDDA_REG";
+		};
+	};
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&mac0 {
+	phy-mode = "sgmii";
+	phy-handle = <&phy0>;
+	status = "okay";
+};
+
+&mac1 {
+	phy-mode = "sgmii";
+	phy-handle = <&phy1>;
+	status = "okay";
+
+	phy1: ethernet-phy@9 {
+		reg = <9>;
+	};
+
+	phy0: ethernet-phy@8 {
+		reg = <8>;
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
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	status = "okay";
+};
+
+&mmuart1 {
+	status = "okay";
+};
+
+&mmuart2 {
+	status = "okay";
+};
+
+&mmuart3 {
+	status = "okay";
+};
+
+&mmuart4 {
+	status = "okay";
+};
+
+&pcie {
+	status = "okay";
+};
+
+&qspi {
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
+
+&syscontroller_qspi {
+	/*
+	 * The flash *is* there, but Icicle kits that have engineering sample
+	 * silicon (write?) access to this flash to non-functional. The system
+	 * controller itself can actually access it, but the MSS cannot write
+	 * an image there. Instantiating a coreQSPI in the fabric & connecting
+	 * it to the flash instead should work though. Pre-production or later
+	 * silicon does not have this issue.
+	 */
+	status = "disabled";
+
+	sys_ctrl_flash: flash@0 { // MT25QL01GBBB8ESF-0SIT
+		compatible = "jedec,spi-nor";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <20000000>;
+		spi-rx-bus-width = <1>;
+		reg = <0>;
+	};
+};
+
+&usb {
+	status = "okay";
+	dr_mode = "host";
+};
diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
index f80df225f72b..2cb08ed0946d 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
@@ -3,249 +3,10 @@
 
 /dts-v1/;
 
-#include "mpfs.dtsi"
-#include "mpfs-icicle-kit-fabric.dtsi"
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/leds/common.h>
+#include "mpfs-icicle-kit-common.dtsi"
 
 / {
 	model = "Microchip PolarFire-SoC Icicle Kit";
 	compatible = "microchip,mpfs-icicle-reference-rtlv2210", "microchip,mpfs-icicle-kit",
 		     "microchip,mpfs";
-
-	aliases {
-		ethernet0 = &mac1;
-		serial0 = &mmuart0;
-		serial1 = &mmuart1;
-		serial2 = &mmuart2;
-		serial3 = &mmuart3;
-		serial4 = &mmuart4;
-	};
-
-	chosen {
-		stdout-path = "serial1:115200n8";
-	};
-
-	leds {
-		compatible = "gpio-leds";
-
-		led-1 {
-			gpios = <&gpio2 16 GPIO_ACTIVE_HIGH>;
-			color = <LED_COLOR_ID_RED>;
-			label = "led1";
-		};
-
-		led-2 {
-			gpios = <&gpio2 17 GPIO_ACTIVE_HIGH>;
-			color = <LED_COLOR_ID_RED>;
-			label = "led2";
-		};
-
-		led-3 {
-			gpios = <&gpio2 18 GPIO_ACTIVE_HIGH>;
-			color = <LED_COLOR_ID_AMBER>;
-			label = "led3";
-		};
-
-		led-4 {
-			gpios = <&gpio2 19 GPIO_ACTIVE_HIGH>;
-			color = <LED_COLOR_ID_AMBER>;
-			label = "led4";
-		};
-	};
-
-	ddrc_cache_lo: memory@80000000 {
-		device_type = "memory";
-		reg = <0x0 0x80000000 0x0 0x40000000>;
-		status = "okay";
-	};
-
-	ddrc_cache_hi: memory@1040000000 {
-		device_type = "memory";
-		reg = <0x10 0x40000000 0x0 0x40000000>;
-		status = "okay";
-	};
-
-	reserved-memory {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		hss_payload: region@BFC00000 {
-			reg = <0x0 0xBFC00000 0x0 0x400000>;
-			no-map;
-		};
-	};
-};
-
-&core_pwm0 {
-	status = "okay";
-};
-
-&gpio2 {
-	interrupts = <53>, <53>, <53>, <53>,
-		     <53>, <53>, <53>, <53>,
-		     <53>, <53>, <53>, <53>,
-		     <53>, <53>, <53>, <53>,
-		     <53>, <53>, <53>, <53>,
-		     <53>, <53>, <53>, <53>,
-		     <53>, <53>, <53>, <53>,
-		     <53>, <53>, <53>, <53>;
-	status = "okay";
-};
-
-&i2c0 {
-	status = "okay";
-};
-
-&i2c1 {
-	status = "okay";
-
-	power-monitor@10 {
-		compatible = "microchip,pac1934";
-		reg = <0x10>;
-
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		channel@1 {
-			reg = <0x1>;
-			shunt-resistor-micro-ohms = <10000>;
-			label = "VDDREG";
-		};
-
-		channel@2 {
-			reg = <0x2>;
-			shunt-resistor-micro-ohms = <10000>;
-			label = "VDDA25";
-		};
-
-		channel@3 {
-			reg = <0x3>;
-			shunt-resistor-micro-ohms = <10000>;
-			label = "VDD25";
-		};
-
-		channel@4 {
-			reg = <0x4>;
-			shunt-resistor-micro-ohms = <10000>;
-			label = "VDDA_REG";
-		};
-	};
-};
-
-&i2c2 {
-	status = "okay";
-};
-
-&mac0 {
-	phy-mode = "sgmii";
-	phy-handle = <&phy0>;
-	status = "okay";
-};
-
-&mac1 {
-	phy-mode = "sgmii";
-	phy-handle = <&phy1>;
-	status = "okay";
-
-	phy1: ethernet-phy@9 {
-		reg = <9>;
-	};
-
-	phy0: ethernet-phy@8 {
-		reg = <8>;
-	};
-};
-
-&mbox {
-	status = "okay";
-};
-
-&mmc {
-	bus-width = <4>;
-	disable-wp;
-	cap-sd-highspeed;
-	cap-mmc-highspeed;
-	mmc-ddr-1_8v;
-	mmc-hs200-1_8v;
-	sd-uhs-sdr12;
-	sd-uhs-sdr25;
-	sd-uhs-sdr50;
-	sd-uhs-sdr104;
-	status = "okay";
-};
-
-&mmuart1 {
-	status = "okay";
-};
-
-&mmuart2 {
-	status = "okay";
-};
-
-&mmuart3 {
-	status = "okay";
-};
-
-&mmuart4 {
-	status = "okay";
-};
-
-&pcie {
-	status = "okay";
-};
-
-&qspi {
-	status = "okay";
-};
-
-&refclk {
-	clock-frequency = <125000000>;
-};
-
-&refclk_ccc {
-	clock-frequency = <50000000>;
-};
-
-&rtc {
-	status = "okay";
-};
-
-&spi0 {
-	status = "okay";
-};
-
-&spi1 {
-	status = "okay";
-};
-
-&syscontroller {
-	status = "okay";
-};
-
-&syscontroller_qspi {
-	/*
-	 * The flash *is* there, but Icicle kits that have engineering sample
-	 * silicon (write?) access to this flash to non-functional. The system
-	 * controller itself can actually access it, but the MSS cannot write
-	 * an image there. Instantiating a coreQSPI in the fabric & connecting
-	 * it to the flash instead should work though. Pre-production or later
-	 * silicon does not have this issue.
-	 */
-	status = "disabled";
-
-	sys_ctrl_flash: flash@0 { // MT25QL01GBBB8ESF-0SIT
-		compatible = "jedec,spi-nor";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		spi-max-frequency = <20000000>;
-		spi-rx-bus-width = <1>;
-		reg = <0>;
-	};
-};
-
-&usb {
-	status = "okay";
-	dr_mode = "host";
 };
-- 
2.34.1



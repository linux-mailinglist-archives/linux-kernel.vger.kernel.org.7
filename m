Return-Path: <linux-kernel+bounces-606145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EC1A8ABAE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 01:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B8F019035DD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 23:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EDE2C374F;
	Tue, 15 Apr 2025 22:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIYCpdsu"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052202C2ACB;
	Tue, 15 Apr 2025 22:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744757990; cv=none; b=MxhzvnMJJ5MapGe9RkUi0CjVt0sBrWQCHpEKYxF8N/680/xxFfJmPBfrocBt8VXDxCYGKTTpu/zMqIZNRnekzGl4xhdkhrmPg/4HFGWGuQBhZezM0SJROZRVPRIS7SifCNVt8jZOD435wlXeXEb+WJLhPNYtemduwhDhjKplh+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744757990; c=relaxed/simple;
	bh=jc9N03k1QfgtPfW9d9hzwd7WCh2/6f8pEQfg0YWGMlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJ41nnsm3vWW/Yszk2ybD4m1h/B7FCqGF5pQUuX5H5cLob8lEx32LNW+aubeoqSah5TDWnOox0j+DYEVwlakvmc30yVV+Rl9D31/YEclbRm7nq4AILG8An+FDtoONDzMxD8VM/j5qSLcLrRHtDBT1rz9/TpyOyp2KYhceas7/Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIYCpdsu; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3d46fddf43aso44719785ab.3;
        Tue, 15 Apr 2025 15:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744757987; x=1745362787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JD5gqJgl0o904ungOO+PQFcT58GKy6PoIttE79uySS8=;
        b=FIYCpdsu3CWjiVpTTxoDVY0gPT0GSFUDc07ZtMwdpuVPZAbC1ea2SJ18AbHWVBmt2L
         zZego+KHey6C7seuPTTVs/1unPWQ51mgcQG8APYqGAIII11QUHazJPdEtGyreOklKWZ2
         HD+i+vRhUtT+LBkZgOx186RHppcDCw0yvrckU0Vio8vbBs106qExOnP0qWXcVLL0NjmC
         KbJwNg8lAPo0ssTGpncIjzUT4Ylm79MoSU2bPpUDMezY+lrsN6YFv0xYV1pdMyNs7JFm
         JWXjuycKsvjE8zYAaYQo+BRIZ2YN4HlNEwg3EqqpbwrQe6c2v1oOagE1tXbki6wZvJfo
         YQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744757987; x=1745362787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JD5gqJgl0o904ungOO+PQFcT58GKy6PoIttE79uySS8=;
        b=D/I+/8Uwl1F1Dq0CdpqW8SGfhqf35Cbqk8a2HthnyAuGOzeetOzOA5pC/paSI/IrAt
         v1tZW7w2XpM1aoYeS4tCSqhkZqKfzBkgmOFCBB3H6pRpz6Q/m9Qt/lj2gcPSRhIwTlEB
         oRS41dAbFp3b+PmXmS5CQfrphvycYMXqIgvmvKRCzLg/+E/JCi027kh64v9QP5ae1UB8
         vmsTMtsAJ6qjzAf+NYggJgh0MCh0ur/p6VyKD7aoPf8Frwdi0YJf3nI2dlT8ytvlT8O9
         +kdfRo2OpQhth9KhML42tU8D4mGbEI3xC6Q9K77+bhXEryHrqkdMZ8mj/LZ+FW9VHYoG
         sJ3g==
X-Forwarded-Encrypted: i=1; AJvYcCULSzKfB5/MnRw0tzVonIsx22OR3VM7UUrk2vtCqSWqOTN2TZKld6ms8TQsKbDetLgqgk5g46K/F1uJo49P@vger.kernel.org, AJvYcCXVaYDf5cpuHmwr3yT8TCaMEjmX8LOEPf+WM7tDrpPO+VqIs+DN+iDawHmahEqoRpggiqpGTNYZ13qx@vger.kernel.org
X-Gm-Message-State: AOJu0YzQYFr1DBLXGB238EyQg4f17AtXMTtKLZHN10yRgtqyvkBl2mPb
	WIhsDGJmkNxc7bKjxJEPLTirbmYKRFOQmy5DqmMzADOD3eH5W3F0
X-Gm-Gg: ASbGncsZKpKzGbOX74ZeqlDrac8Y29fW55Ogdw+V+yMCA9+eeVgPJ+2t1BrL8ie9MR2
	kO1nbJkw0kOMx/aTwd0DKvuNTijPPHVxWQxhI0HXHBkbnCAVpuE1WRfdSY/zfr4EfSOwohChvMQ
	sGAEhxWfMHI1CwqqD3rGWAXE5d5GWRC+Iezp+e5w0T62S87Sudo7A2hkjJO92QUcR1EG3q/ioWN
	noVBV7r+mYZqwejp2BTljl02LHPijn2vvUCFA6vT4JhB1xJndcIuiOywg/088zz0vZ7GflbsXWf
	V942etXpiURgrliH5DW3aM9zbhDTC7MkR2Fji+vBoPcSQzBZvE+HOk5IyjSdIzgUlLqEHaXeQX6
	F
X-Google-Smtp-Source: AGHT+IGpMiPfTzR40QNSAj6EDFVf4XLqvKGDcUTaU7AUhVx9rRQ5+OjTWJMgthJkRWXzj9Kjq0kMrw==
X-Received: by 2002:a05:6e02:1aad:b0:3cf:c9ad:46a1 with SMTP id e9e14a558f8ab-3d812546cdfmr11947175ab.13.1744757987052;
        Tue, 15 Apr 2025 15:59:47 -0700 (PDT)
Received: from hestia.. (24-220-158-153-dynamic.midco.net. [24.220.158.153])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505d175edsm3382356173.55.2025.04.15.15.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 15:59:46 -0700 (PDT)
From: Robert Nelson <robertcnelson@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Robert Nelson <robertcnelson@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Nishanth Menon <nm@ti.com>,
	Andrew Davis <afd@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Judith Mendez <jm@ti.com>,
	Andrei Aldea <a-aldea@ti.com>,
	Dhruva Gole <d-gole@ti.com>,
	Jason Kridner <jkridner@beagleboard.org>,
	Deepak Khatri <lorforlinux@beagleboard.org>,
	Ayush Singh <ayush@beagleboard.org>
Subject: [PATCH v3 2/2] arm64: dts: ti: Add k3-am62-pocketbeagle2
Date: Tue, 15 Apr 2025 17:59:40 -0500
Message-ID: <20250415225940.3899486-2-robertcnelson@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250415225940.3899486-1-robertcnelson@gmail.com>
References: <20250415225940.3899486-1-robertcnelson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BeagleBoard.org PocketBeagle 2 is an upgraded version of the popular
PocketBeagle.  It is based on Texas Instruments AM6232 or AM6254 SoC.
Its dual or quad A53 cores can provide higher performance than classic
PocketBeagle. The new design comes with pre-soldered headers, a 3-pin
JST-SH 1.00mm UART debug port, a USB-C port, Texas Instruments
MSPM0L1105 Cortex-M0+ MCU for ADC, 512MB RAM, and a LiPo Battery charger.

MSPM0L1105 firmware source: https://openbeagle.org/pocketbeagle/mspm0-adc-eeprom
* EEPROM 24c32 emulation
* ADC ad7291 emulation

https://www.beagleboard.org/boards/pocketbeagle-2
https://openbeagle.org/pocketbeagle/pocketbeagle-2

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
CC: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>
CC: Nishanth Menon <nm@ti.com>
CC: Andrew Davis <afd@ti.com>
CC: Roger Quadros <rogerq@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>
CC: Judith Mendez <jm@ti.com>
CC: Andrei Aldea <a-aldea@ti.com>
CC: Dhruva Gole <d-gole@ti.com>
CC: Jason Kridner <jkridner@beagleboard.org>
CC: Deepak Khatri <lorforlinux@beagleboard.org>
CC: Ayush Singh <ayush@beagleboard.org>
---
Changes since v2:
 - cleanup unused serial aliases
 - cleanup unused sdhci0 (un-populated) aliases
 - cleanup unused main_i2c1 (un-populated) aliases
 - add missing main_i2c0 aliases
 - fix bootph, function, color, gpios order in leds nodes
 - drop local cpsw disable, needs to be moved to k3-am62-main
 - MSPM0L1105 add firmware source and note where emulated
 - usb0 add note about Type-C connector, but only wired for USB 2.0
 - usb1 add compatible note with original PocketBeagle expansion boards
Changes since v1:
 - fix '_' in main-i2c2-default-pins
 - aliases i2c match original pocketbeagle
 - add mcu_m4fss with reseved memory and mailbox
 - drop unused main_gpio0_pins_default pinmux
 - drop unused main_gpio1_pins_default pinmux
 - drop unused main_spi2_pins_gpio pinmux
 - Reserve 128MiB of global CMA
---
 arch/arm64/boot/dts/ti/Makefile               |   1 +
 .../boot/dts/ti/k3-am62-pocketbeagle2.dts     | 518 ++++++++++++++++++
 2 files changed, 519 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 03d4cecfc001..4f8fcb69a2c1 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -27,6 +27,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-yavia.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am62x-phyboard-lyra-gpio-fan.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk-nand.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am62-pocketbeagle2.dtb
 
 # Boards with AM62Ax SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am62a7-sk.dtb
diff --git a/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts b/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts
new file mode 100644
index 000000000000..50d8d9a076a0
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts
@@ -0,0 +1,518 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * https://www.beagleboard.org/boards/pocketbeagle-2
+ *
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2025 Robert Nelson, BeagleBoard.org Foundation
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include "k3-am625.dtsi"
+
+/ {
+	compatible = "beagle,am62-pocketbeagle2", "ti,am625";
+	model = "BeagleBoard.org PocketBeagle2";
+
+	aliases {
+		serial0 = &wkup_uart0;
+		serial1 = &main_uart1;
+		serial2 = &main_uart6;
+		serial3 = &main_uart0;
+		mmc1 = &sdhci1;
+		usb0 = &usb0;
+		usb1 = &usb1;
+		i2c0 = &main_i2c0;
+		i2c2 = &main_i2c2;
+		i2c3 = &wkup_i2c0;
+	};
+
+	chosen {
+		stdout-path = &main_uart6;
+	};
+
+	memory@80000000 {
+		/* 512MB RAM */
+		reg = <0x00000000 0x80000000 0x00000000 0x20000000>;
+		device_type = "memory";
+		bootph-pre-ram;
+	};
+
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* global cma region */
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x00 0x8000000>;
+			linux,cma-default;
+		};
+
+		mcu_m4fss_dma_memory_region: m4f-dma-memory@9cb00000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9cb00000 0x00 0x100000>;
+			no-map;
+		};
+
+		mcu_m4fss_memory_region: m4f-memory@9cc00000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9cc00000 0x00 0xe00000>;
+			no-map;
+		};
+
+		secure_tfa_ddr: tfa@9e780000 {
+			reg = <0x00 0x9e780000 0x00 0x80000>;
+			alignment = <0x1000>;
+			no-map;
+		};
+
+		secure_ddr: optee@9e800000 {
+			reg = <0x00 0x9e800000 0x00 0x01800000>;
+			alignment = <0x1000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9db00000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9db00000 0x00 0xc00000>;
+			no-map;
+		};
+	};
+
+	vsys_5v0: regulator-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "vsys_5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		regulator-boot-on;
+		bootph-all;
+	};
+
+	vdd_3v3: regulator-2 {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vsys_5v0>;
+		regulator-always-on;
+		regulator-boot-on;
+		bootph-all;
+	};
+
+	vdd_mmc1: regulator-3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_mmc1";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vdd_3v3_sd_pins_default>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		enable-active-high;
+		regulator-always-on;
+		vin-supply = <&vdd_3v3>;
+		gpio = <&main_gpio0 0 GPIO_ACTIVE_HIGH>;
+		bootph-all;
+	};
+
+	vdd_sd_dv: regulator-4 {
+		compatible = "regulator-gpio";
+		regulator-name = "sd_hs200_switch";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vdd_sd_dv_pins_default>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		vin-supply = <&vdd_3v3>;
+		gpios = <&main_gpio1 49 GPIO_ACTIVE_HIGH>;
+		states = <1800000 0x0>,
+			 <3300000 0x1>;
+		bootph-all;
+	};
+
+	adc_vref: regulator-5 {
+		compatible = "regulator-fixed";
+		regulator-name = "default";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins_default>;
+		bootph-all;
+
+		led-1 {
+			function = LED_FUNCTION_HEARTBEAT;
+			color = <LED_COLOR_ID_GREEN>;
+			linux,default-trigger = "heartbeat";
+			gpios = <&main_gpio0 6 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+			bootph-all;
+		};
+
+		led-2 {
+			function = LED_FUNCTION_DISK_ACTIVITY;
+			color = <LED_COLOR_ID_GREEN>;
+			linux,default-trigger = "mmc1";
+			gpios = <&main_gpio0 5 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+			bootph-all;
+		};
+
+		led-3 {
+			function = LED_FUNCTION_INDICATOR;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&main_gpio0 4 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+			bootph-all;
+		};
+
+		led-4 {
+			function = LED_FUNCTION_INDICATOR;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&main_gpio0 3 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+			bootph-all;
+		};
+	};
+};
+
+&main_pmx0 {
+	led_pins_default: led-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x000c, PIN_OUTPUT, 7) /* (E25) OSPI0_D0.GPIO0_3 */
+			AM62X_IOPAD(0x0010, PIN_OUTPUT, 7) /* (G24) OSPI0_D1.GPIO0_4 */
+			AM62X_IOPAD(0x0014, PIN_OUTPUT, 7) /* (F25) OSPI0_D2.GPIO0_5 */
+			AM62X_IOPAD(0x0018, PIN_OUTPUT, 7) /* (F24) OSPI0_D3.GPIO0_6 */
+		>;
+		bootph-all;
+	};
+
+	main_i2c0_pins_default: main-i2c0-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x01e0, PIN_INPUT_PULLUP, 0) /* (B16) I2C0_SCL */
+			AM62X_IOPAD(0x01e4, PIN_INPUT_PULLUP, 0) /* (A16) I2C0_SDA */
+		>;
+		bootph-all;
+	};
+
+	main_i2c2_pins_default: main-i2c2-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x00b0, PIN_INPUT_PULLUP, 1) /* (K22) GPMC0_CSn2.I2C2_SCL */
+			AM62X_IOPAD(0x00b4, PIN_INPUT_PULLUP, 1) /* (K24) GPMC0_CSn3.I2C2_SDA */
+		>;
+		bootph-all;
+	};
+
+	main_uart0_pins_default: main-uart0-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x1c8, PIN_INPUT, 0) /* (D14/A13) UART0_RXD */
+			AM62X_IOPAD(0x1cc, PIN_OUTPUT, 0) /* (E14/E11) UART0_TXD */
+		>;
+		bootph-all;
+	};
+
+	main_uart1_pins_default: main-uart1-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x194, PIN_INPUT, 2) /* (B19/B18) MCASP0_AXR3.UART1_CTSn */
+			AM62X_IOPAD(0x198, PIN_OUTPUT, 2) /* (A19/B17) MCASP0_AXR2.UART1_RTSn */
+			AM62X_IOPAD(0x1ac, PIN_INPUT, 2) /* (E19/D15) MCASP0_AFSR.UART1_RXD */
+			AM62X_IOPAD(0x1b0, PIN_OUTPUT, 2) /* (A20/D16) MCASP0_ACLKR.UART1_TXD */
+		>;
+		bootph-all;
+	};
+
+	main_uart6_pins_default: main-uart6-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x001c, PIN_INPUT, 3) /* (J23) OSPI0_D4.UART6_RXD */
+			AM62X_IOPAD(0x0020, PIN_OUTPUT, 3) /* (J25) OSPI0_D5.UART6_TXD */
+		>;
+	};
+
+	main_mmc1_pins_default: main-mmc1-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x23c, PIN_INPUT, 0) /* (A21/C18) MMC1_CMD */
+			AM62X_IOPAD(0x234, PIN_INPUT, 0) /* (B22/A20) MMC1_CLK */
+			AM62X_IOPAD(0x230, PIN_INPUT, 0) /* (A22/A19) MMC1_DAT0 */
+			AM62X_IOPAD(0x22c, PIN_INPUT, 0) /* (B21/B19) MMC1_DAT1 */
+			AM62X_IOPAD(0x228, PIN_INPUT, 0) /* (C21/B20) MMC1_DAT2 */
+			AM62X_IOPAD(0x224, PIN_INPUT, 0) /* (D22/C19) MMC1_DAT3 */
+			AM62X_IOPAD(0x240, PIN_INPUT, 7) /* (D17/C15) MMC1_SDCD.GPIO1_48 */
+		>;
+		bootph-all;
+	};
+
+	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x0244, PIN_OUTPUT, 7) /* (P25) GPMC0_CLK.GPIO1_49 */
+		>;
+		bootph-all;
+	};
+
+	pmic_irq_pins_default: pmic-irq-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x01f4, PIN_INPUT_PULLUP, 0) /* (D16) EXTINTn */
+		>;
+		bootph-all;
+	};
+
+	vdd_3v3_sd_pins_default: vdd-3v3-sd-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x0000, PIN_OUTPUT, 7) /* (H24) OSPI0_CLK.GPIO0_0 */
+		>;
+		bootph-all;
+	};
+
+	usb1_pins_default: usb1-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x0258, PIN_INPUT, 0) /* (F18) USB1_DRVVBUS */
+		>;
+		bootph-all;
+	};
+
+	epwm2_pins_default: epwm2-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x01e8, PIN_OUTPUT, 8) /* (B17) I2C1_SCL.EHRPWM2_A */
+		>;
+	};
+};
+
+&epwm2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&epwm2_pins_default>;
+};
+
+&mailbox0_cluster0 {
+	mbox_m4_0: mbox-m4-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+};
+
+&main_uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart0_pins_default>;
+	bootph-all;
+	status = "okay";
+};
+
+&main_uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart1_pins_default>;
+	bootph-pre-ram;
+	status = "reserved";
+};
+
+&main_uart6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart6_pins_default>;
+	bootph-all;
+	status = "okay";
+};
+
+&main_i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c0_pins_default>;
+	clock-frequency = <400000>;
+	bootph-all;
+	status = "okay";
+
+	ad7291: adc@20 {
+		/* Emulated with MSPM0L1105 */
+		compatible = "adi,ad7291";
+		reg = <0x20>;
+		vref-supply = <&adc_vref>;
+	};
+
+	eeprom: eeprom@50 {
+		/* Emulated with MSPM0L1105 */
+		compatible = "atmel,24c32";
+		reg = <0x50>;
+	};
+};
+
+&main_i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c2_pins_default>;
+	clock-frequency = <400000>;
+	bootph-all;
+	status = "okay";
+};
+
+&mcu_m4fss {
+	mboxes = <&mailbox0_cluster0 &mbox_m4_0>;
+	memory-region = <&mcu_m4fss_dma_memory_region>,
+			<&mcu_m4fss_memory_region>;
+	status = "okay";
+};
+
+&mcu_pmx0 {
+	wkup_uart0_pins_default: wkup-uart0-default-pins {
+		pinctrl-single,pins = <
+			AM62X_MCU_IOPAD(0x02c, PIN_INPUT, 0)	/* (C6/A7) WKUP_UART0_CTSn */
+			AM62X_MCU_IOPAD(0x030, PIN_OUTPUT, 0)	/* (A4/B4) WKUP_UART0_RTSn */
+			AM62X_MCU_IOPAD(0x024, PIN_INPUT, 0)	/* (B4/B5) WKUP_UART0_RXD */
+			AM62X_MCU_IOPAD(0x028, PIN_OUTPUT, 0)	/* (C5/C6) WKUP_UART0_TXD */
+		>;
+		bootph-all;
+	};
+
+	wkup_i2c0_pins_default: wkup-i2c0-default-pins {
+		pinctrl-single,pins = <
+			AM62X_MCU_IOPAD(0x004c, PIN_INPUT_PULLUP, 0)	/* (B9) WKUP_I2C0_SCL */
+			AM62X_MCU_IOPAD(0x0050, PIN_INPUT_PULLUP, 0)	/* (A9) WKUP_I2C0_SDA */
+		>;
+		bootph-all;
+	};
+};
+
+&sdhci1 {
+	/* SD/MMC */
+	vmmc-supply = <&vdd_mmc1>;
+	vqmmc-supply = <&vdd_sd_dv>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mmc1_pins_default>;
+	disable-wp;
+	cd-gpios = <&main_gpio1 48 GPIO_ACTIVE_LOW>;
+	cd-debounce-delay-ms = <100>;
+	bootph-all;
+	ti,fails-without-test-cd;
+	status = "okay";
+};
+
+&usbss0 {
+	bootph-all;
+	ti,vbus-divider;
+	status = "okay";
+};
+
+&usb0 {
+	/* This is a Type-C socket, but wired as USB 2.0 */
+	dr_mode = "peripheral";
+	bootph-all;
+};
+
+&usbss1 {
+	ti,vbus-divider;
+	status = "okay";
+};
+
+&usb1 {
+	/* Compatible with original PocketBeagle, expansion boards assumed this was pre-setup as host */
+	dr_mode = "host";
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb1_pins_default>;
+};
+
+&wkup_uart0 {
+	/* WKUP UART0 is used by Device Manager firmware */
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_uart0_pins_default>;
+	bootph-all;
+	status = "reserved";
+};
+
+&wkup_i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_i2c0_pins_default>;
+	clock-frequency = <100000>;
+	bootph-all;
+	status = "okay";
+
+	tps65219: pmic@30 {
+		compatible = "ti,tps65219";
+		reg = <0x30>;
+		buck1-supply = <&vsys_5v0>;
+		buck2-supply = <&vsys_5v0>;
+		buck3-supply = <&vsys_5v0>;
+		ldo1-supply = <&vdd_3v3>;
+		ldo2-supply = <&buck2_reg>;
+		ldo3-supply = <&vdd_3v3>;
+		ldo4-supply = <&vdd_3v3>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_irq_pins_default>;
+		interrupt-parent = <&gic500>;
+		interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		bootph-all;
+		system-power-controller;
+		ti,power-button;
+
+		regulators {
+			buck1_reg: buck1 {
+				regulator-name = "VDD_CORE";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck2_reg: buck2 {
+				regulator-name = "VDD_1V8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck3_reg: buck3 {
+				regulator-name = "VDD_1V2";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1_reg: ldo1 {
+				/*
+				 * Regulator is left as is unused, vdd_sd
+				 * is controlled via GPIO with bypass config
+				 * as per the NVM configuration
+				 */
+				regulator-name = "VDD_SD_3V3";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-allow-bypass;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo2_reg: ldo2 {
+				regulator-name = "VDDA_0V85";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo3_reg: ldo3 {
+				regulator-name = "VDDA_1V8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4_reg: ldo4 {
+				regulator-name = "VDD_2V5";
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <2500000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+};
-- 
2.47.2



Return-Path: <linux-kernel+bounces-812988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17332B53F4A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 01:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F4873B9683
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80912EBDE3;
	Thu, 11 Sep 2025 23:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GU9grEF5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F232D0C7B;
	Thu, 11 Sep 2025 23:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757634732; cv=none; b=EhBwLXKN7/zvRKCRQ+OQfc++u0isl4eb0dEwYlF0snlBVqLn4/jLIE2ZqrrRdSRvhmyabx9jZumL9FbFzP0EpXr/WsUy1vf/dXynZdiOm7WhnjZN/PxqHHASyng8MmjMUkgh3arkKnwXDtLWW8Ll9RWXb9an5KGsZZ/xNWwhAQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757634732; c=relaxed/simple;
	bh=h/jtlcQP6dxt5AXXkjpgAA85nbV3awGZg9MiPorU3Zk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=loknylq7mReZUQjEPOy6B9nBHma10GhGfdlTf70JRzNWMss5ojt4mvinNXqjFVR2+3EKh671qBIK2ZTjNi/Bk3iK7ICxBec/r7T/+VsYSw/bAmDKkmuo6osx3Tjuuf38EjBo99tZrzLc/V0TyLDAPieDgXxIaDGW1WPQqHxknik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GU9grEF5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DAA5C4CEF8;
	Thu, 11 Sep 2025 23:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757634732;
	bh=h/jtlcQP6dxt5AXXkjpgAA85nbV3awGZg9MiPorU3Zk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GU9grEF5P1VCrdcMwZeSM6WFlJcso8w4ZAw+R1SesvOp8BfXuvkP2v1r5YkOcrkL9
	 dwltbz3wj9yHCgxlbaZrGlKntGygxykY5XyOOChvavrpjnANUaMamcpbZV0iIn0RcA
	 l0dpFF/BrJHimKoonDpzPDm6c0wRYvoYtqoSeqOrLhTwYp3FKVy9lbhsq9rpVzbBQI
	 cqtFSSu3O+XYMa+erF7tR7I/NvYU0hvFsh2Pe0Dt1l3KH9uxkga60+6b+4diHvn5sx
	 +6EKD4kFehmtqjCK2WQ1yvUzx9w6AahhlIiZ3MN5FRYaGQyssWMFXoxhDi5zqt22vJ
	 TRBNYU2R5AhVw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A562CAC587;
	Thu, 11 Sep 2025 23:52:12 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Fri, 12 Sep 2025 01:52:10 +0200
Subject: [PATCH 2/2] arm64: dts: allwinner: h313: Add Amediatech X96Q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250912-x96q-v1-2-8471daaf39db@posteo.net>
References: <20250912-x96q-v1-0-8471daaf39db@posteo.net>
In-Reply-To: <20250912-x96q-v1-0-8471daaf39db@posteo.net>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757634731; l=7483;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=yL82j4z4vPXiCzLYTueKfwn+Z802nasSWVsK16fQRU4=;
 b=fr2Y7KV+LY2ybRfaZOP4SZcRg3JxcszvMdnEj5w5NNmb9VuQlTieWM82IRk8JER/RIHvCpmni
 aEVyfuCJDnDCgqAfYGeWZRWajHGnJSeVRPamYCR45bh84iveBmpBwVf
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

The X96Q is a set-top box with an H313 SoC, AXP305 PMIC, 1 or 2 GiB RAM,
8 or 16 GiB eMMC flash, 2x USB A, Micro-SD, HDMI, Ethernet, audio/video
output, and infrared input.

  https://x96mini.com/products/x96q-tv-box-android-10-set-top-box

Tested, works:
- debug UART
- status LED
- USB ports in host mode
- MicroSD
- eMMC
- recovery button hidden behind audio/video port
- analog audio (line out)

Does not work:
- Ethernet (requires AC200 MFD/EPHY driver)
- analog video output (requires AC200 driver)
- HDMI audio/video output

Untested:
- "OTG" USB port in device mode
- built-in IR receiver
- external IR receiver
- WLAN (requires out-of-tree XRadio driver)

Table of regulators on the downstream kernel, for reference:

 vcc-5v      1   15      0 unknown  5000mV     0mA  5000mV  5000mV
    dcdca    0    0      0 unknown   900mV     0mA     0mV     0mV
    dcdcb    0    0      0 unknown  1350mV     0mA     0mV     0mV
    dcdcc    0    0      0 unknown   900mV     0mA     0mV     0mV
    dcdcd    0    0      0 unknown  1500mV     0mA     0mV     0mV
    dcdce    0    0      0 unknown  3300mV     0mA     0mV     0mV
    aldo1    0    0      0 unknown  3300mV     0mA     0mV     0mV
    aldo2    0    0      0 unknown   700mV     0mA     0mV     0mV
    aldo3    0    0      0 unknown   700mV     0mA     0mV     0mV
    bldo1    0    0      0 unknown  1800mV     0mA     0mV     0mV
    bldo2    0    0      0 unknown  1800mV     0mA     0mV     0mV
    bldo3    0    0      0 unknown   700mV     0mA     0mV     0mV
    bldo4    0    0      0 unknown   700mV     0mA     0mV     0mV
    cldo1    0    0      0 unknown  2500mV     0mA     0mV     0mV
    cldo2    0    0      0 unknown   700mV     0mA     0mV     0mV
    cldo3    0    0      0 unknown   700mV     0mA     0mV     0mV

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
 arch/arm64/boot/dts/allwinner/Makefile             |   1 +
 arch/arm64/boot/dts/allwinner/sun50i-h313-x96q.dts | 235 +++++++++++++++++++++
 2 files changed, 236 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index 780aeba0f3a4e14d69c9602e37b8d299165507b9..2edfa7bf4ab31c4aa934da98e5e042edc9aaf600 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -41,6 +41,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-model-b.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6-mini.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h313-tanix-tx1.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h313-x96q.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-bigtreetech-cb1-manta.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-bigtreetech-pi.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h313-x96q.dts b/arch/arm64/boot/dts/allwinner/sun50i-h313-x96q.dts
new file mode 100644
index 0000000000000000000000000000000000000000..9534eb03b89557f2545af5af7cf43390be722cf0
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h313-x96q.dts
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (C) 2025 J. Neuschäfer <j.ne@posteo.net>
+ */
+
+/dts-v1/;
+
+#include "sun50i-h616.dtsi"
+#include "sun50i-h616-cpu-opp.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "X96Q";
+	compatible = "amediatech,x96q", "allwinner,sun50i-h616";
+
+	aliases {
+		mmc0 = &mmc0;
+		mmc1 = &mmc1;
+		mmc2 = &mmc2;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	reg_vcc5v: vcc5v {
+		/* board wide 5V supply directly from the DC input */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		key-recovery {
+			label = "Recovery";
+			linux,code = <KEY_VENDOR>;
+			gpios = <&pio 7 9 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			color = <LED_COLOR_ID_BLUE>;
+			gpios = <&pio 7 6 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+		};
+	};
+};
+
+&codec {
+	allwinner,audio-routing = "Line Out", "LINEOUT";
+	status = "okay";
+};
+
+&cpu0 {
+	cpu-supply = <&reg_dcdca>;
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci3 {
+	status = "okay";
+};
+
+/* TODO: EMAC1 connected to AC200 PHY */
+
+&gpu {
+	mali-supply = <&reg_dcdcc>;
+	status = "okay";
+};
+
+&ir {
+	status = "okay";
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_aldo1>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
+	disable-wp;
+	bus-width = <4>;
+	max-frequency = <150000000>;
+	status = "okay";
+	/* µSD */
+};
+
+&mmc1 {
+	/* TODO: XRadio XR819 WLAN */
+};
+
+&mmc2 {
+	vmmc-supply = <&reg_aldo1>;
+	vqmmc-supply = <&reg_bldo1>;
+	non-removable;
+	cap-mmc-hw-reset;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	bus-width = <8>;
+	max-frequency = <100000000>;
+	status = "okay";
+	/* eMMC */
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&ohci3 {
+	status = "okay";
+};
+
+&r_i2c {
+	status = "okay";
+
+	axp305: pmic@36 {
+		compatible = "x-powers,axp305", "x-powers,axp805",
+			     "x-powers,axp806";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		reg = <0x36>;
+
+		x-powers,self-working-mode;
+		vina-supply = <&reg_vcc5v>;
+		vinb-supply = <&reg_vcc5v>;
+		vinc-supply = <&reg_vcc5v>;
+		vind-supply = <&reg_vcc5v>;
+		vine-supply = <&reg_vcc5v>;
+		aldoin-supply = <&reg_vcc5v>;
+		bldoin-supply = <&reg_vcc5v>;
+		cldoin-supply = <&reg_vcc5v>;
+
+		regulators {
+			reg_dcdca: dcdca {
+				regulator-always-on;
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-name = "vdd-cpu";
+			};
+
+			dcdcb {
+				/* unused */
+			};
+
+			reg_dcdcc: dcdcc {
+				regulator-always-on;
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <990000>;
+				regulator-name = "vdd-gpu-sys";
+			};
+
+			dcdcd {
+				regulator-always-on;
+				regulator-min-microvolt = <1500000>;
+				regulator-max-microvolt = <1500000>;
+			};
+
+			dcdce {
+				/* unused */
+			};
+
+			reg_aldo1: aldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc3v3";
+			};
+
+			aldo2 {
+				/* unused */
+			};
+
+			aldo3 {
+				/* unused */
+			};
+
+			reg_bldo1: bldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc1v8";
+			};
+
+			bldo2 {
+				/* unused */
+			};
+
+			bldo3 {
+				/* unused */
+			};
+
+			bldo4 {
+				/* unused */
+			};
+
+			cldo1 {
+				/* unused */
+			};
+
+			cldo2 {
+				/* unused */
+			};
+
+			cldo3 {
+				/* unused */
+			};
+		};
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_ph_pins>;
+	status = "okay";
+};
+
+&usbotg {
+	dr_mode = "host";	/* USB A type receptacle */
+	status = "okay";
+};
+
+&usbphy {
+	status = "okay";
+};

-- 
2.48.0.rc1.219.gb6b6757d772




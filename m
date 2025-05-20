Return-Path: <linux-kernel+bounces-656228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4E2ABE337
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 20:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3DD51BC2211
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 18:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A74283684;
	Tue, 20 May 2025 18:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="h+/BqKf/"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5AE283125;
	Tue, 20 May 2025 18:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747767051; cv=pass; b=hL+MUeYZ/4K6XcIgtd21eX5/jpxn813Md7KOHVzUBtHMcrLUCxtL5OqWhhPraYVkw5R4E0OMfZvFZbtOha/mXgag5VjkwTPS/8Mia2OsaieCiZkrbjRV2TYbxyVpreZHvdUq1EpST4LFc8YtA2GIJdmfV+Vzogu5yZskKXI5Tbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747767051; c=relaxed/simple;
	bh=alsTNaUa84b7DQ3tcD8z3obAKGiee5QVHlDO27r8J4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IJL/zJCXeoc1RoF+xjBOVO8d9ky3PUwdeXHfa2T6Ij4ZONPNprgd56gq9OF5TnuaL7LgrhUfdQ2tzqTctGhSu+i4XwG2S3xVL5STAUvS0oKsJyJHEOvg2paMclf6awWDhnecBjHk+fJ2lOKNo6/PSfWlgWp7irAuusC0AzKAJ0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=h+/BqKf/; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1747767036; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RUA2Ii0Wc4kuYHfzWle5axCPrwJ48rqOhqr6Z8btYVmv9Zn3BznPC4Ex1OsfA66tXWAGkXIm5/+J55yr9EVZfL5xee50OiJ2f5pL7uIttwnKGFQTdqhIQ5mgtSp1mVyVsl316h6xf1XDopdVD/HIeSyELcTrZyDQOBWAD4ktW04=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1747767036; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5Xw0kdbz8O8LMKi97j86EeCiDV5fCtGAH+d1/bTAu+8=; 
	b=lFm96HUsVSPr8Do1tilztd79WwQjrCrQMgOGGlJq0vlVvtP+bpNZThtFXivmm8PSRT3q8KTBS24MIc+RHX2+i4m+kqW37e8EQA0jHvwQOEmCKR7ScnsQtnYFJCmWvBiiTk92O+TqIlfjluNWl5rfrEXKcb9N1J5GxUTo+SW60KU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1747767036;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=5Xw0kdbz8O8LMKi97j86EeCiDV5fCtGAH+d1/bTAu+8=;
	b=h+/BqKf/xBp6L5Hp3BrqbbtBA79Fh+T1DhfhbyuvGdltoIvkL8259Or6N0S7uUtN
	e7cKfkUGkmQSKAcpZ9c2qQdM4q+8FzjDDWZcj6YKbHwcBhmCrEKBt8+gUOpUmtGsxSV
	VymcuY3Tf872b64o04Rfo2Ntv6J1PM+bbZSEHNbU=
Received: by mx.zohomail.com with SMTPS id 1747767034812633.9551351417898;
	Tue, 20 May 2025 11:50:34 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Tue, 20 May 2025 20:50:10 +0200
Subject: [PATCH v2 3/4] arm64: dts: rockchip: move common ROCK 5B/+ nodes
 into own tree
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-add-rock5t-v2-3-1f1971850a20@collabora.com>
References: <20250520-add-rock5t-v2-0-1f1971850a20@collabora.com>
In-Reply-To: <20250520-add-rock5t-v2-0-1f1971850a20@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

A few device tree nodes are shared between ROCK 5B and ROCK 5B+ that are
not shared with ROCK 5T.

Move them into their own device tree include.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 .../boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi   | 69 +----------------
 .../boot/dts/rockchip/rk3588-rock-5b-plus.dts      |  2 +-
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts    |  2 +-
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtsi   | 86 ++++++++++++++++++++++
 4 files changed, 89 insertions(+), 70 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi
index 6052787d2560978d2bae6cfbeea5fc1d419d583a..973d39a7e0e09897ee72a89c836ecdc6e2cf91b5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi
@@ -18,23 +18,6 @@ chosen {
 		stdout-path = "serial2:1500000n8";
 	};
 
-	analog-sound {
-		compatible = "audio-graph-card";
-		label = "rk3588-es8316";
-
-		widgets = "Microphone", "Mic Jack",
-			  "Headphone", "Headphones";
-
-		routing = "MIC2", "Mic Jack",
-			  "Headphones", "HPOL",
-			  "Headphones", "HPOR";
-
-		dais = <&i2s0_8ch_p0>;
-		hp-det-gpios = <&gpio1 RK_PD5 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&hp_detect>;
-	};
-
 	hdmi0-con {
 		compatible = "hdmi-connector";
 		type = "a";
@@ -57,19 +40,6 @@ hdmi1_con_in: endpoint {
 		};
 	};
 
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led_rgb_b>;
-
-		led_rgb_b {
-			function = LED_FUNCTION_STATUS;
-			color = <LED_COLOR_ID_BLUE>;
-			gpios = <&gpio0 RK_PB7 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "heartbeat";
-		};
-	};
-
 	fan: pwm-fan {
 		compatible = "pwm-fan";
 		cooling-levels = <0 120 150 180 210 240 255>;
@@ -78,13 +48,6 @@ fan: pwm-fan {
 		#cooling-cells = <2>;
 	};
 
-	rfkill {
-		compatible = "rfkill-gpio";
-		label = "rfkill-m2-wlan";
-		radio-type = "wlan";
-		shutdown-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
-	};
-
 	rfkill-bt {
 		compatible = "rfkill-gpio";
 		label = "rfkill-m2-bt";
@@ -95,9 +58,6 @@ rfkill-bt {
 	vcc3v3_pcie2x1l0: regulator-vcc3v3-pcie2x1l0 {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpios = <&gpio1 RK_PD2 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pcie2_0_vcc3v3_en>;
 		regulator-name = "vcc3v3_pcie2x1l0";
 		regulator-always-on;
 		regulator-boot-on;
@@ -105,6 +65,7 @@ vcc3v3_pcie2x1l0: regulator-vcc3v3-pcie2x1l0 {
 		regulator-max-microvolt = <3300000>;
 		startup-delay-us = <50000>;
 		vin-supply = <&vcc5v0_sys>;
+		status = "disabled";
 	};
 
 	vcc3v3_pcie2x1l2: regulator-vcc3v3-pcie2x1l2 {
@@ -255,10 +216,8 @@ &hdmi_receiver_cma {
 };
 
 &hdmi_receiver {
-	hpd-gpios = <&gpio1 RK_PC6 GPIO_ACTIVE_LOW>;
 	pinctrl-0 = <&hdmim1_rx_cec &hdmim1_rx_hpdin &hdmim1_rx_scl &hdmim1_rx_sda &hdmirx_hpd>;
 	pinctrl-names = "default";
-	status = "okay";
 };
 
 &hdptxphy0 {
@@ -434,39 +393,17 @@ &pd_gpu {
 };
 
 &pinctrl {
-	hdmirx {
-		hdmirx_hpd: hdmirx-5v-detection {
-			rockchip,pins = <1 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
 	hym8563 {
 		hym8563_int: hym8563-int {
 			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
 
-	leds {
-		led_rgb_b: led-rgb-b {
-			rockchip,pins = <0 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	sound {
-		hp_detect: hp-detect {
-			rockchip,pins = <1 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
 	pcie2 {
 		pcie2_0_rst: pcie2-0-rst {
 			rockchip,pins = <4 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 
-		pcie2_0_vcc3v3_en: pcie2-0-vcc-en {
-			rockchip,pins = <1 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-
 		pcie2_2_rst: pcie2-2-rst {
 			rockchip,pins = <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
@@ -918,10 +855,6 @@ &usb_host1_xhci {
 	status = "okay";
 };
 
-&usb_host2_xhci {
-	status = "okay";
-};
-
 &vop {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-plus.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-plus.dts
index 22c0745eae4eeafdbe4ac5654dd1def15a0cad74..74c7b6502e4dda4b774f43c704ebaee350703c0d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b-plus.dts
@@ -2,7 +2,7 @@
 
 /dts-v1/;
 
-#include "rk3588-rock-5b-5bp-5t.dtsi"
+#include "rk3588-rock-5b.dtsi"
 
 / {
 	model = "Radxa ROCK 5B+";
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index 206198c22aa6c388c5321a4503fb0ae7bf376af8..9407a7c9910ada1f6c803d2e15785a9cbd9bd655 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -2,7 +2,7 @@
 
 /dts-v1/;
 
-#include "rk3588-rock-5b-5bp-5t.dtsi"
+#include "rk3588-rock-5b.dtsi"
 
 / {
 	model = "Radxa ROCK 5B";
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..e5c474e4d02a6582efc3bd704d95df95bf9fb0ee
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtsi
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include "rk3588-rock-5b-5bp-5t.dtsi"
+
+/ {
+	analog-sound {
+		compatible = "audio-graph-card";
+		label = "rk3588-es8316";
+
+		widgets = "Microphone", "Mic Jack",
+			  "Headphone", "Headphones";
+
+		routing = "MIC2", "Mic Jack",
+			  "Headphones", "HPOL",
+			  "Headphones", "HPOR";
+
+		dais = <&i2s0_8ch_p0>;
+		hp-det-gpios = <&gpio1 RK_PD5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hp_detect>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_rgb_b>;
+
+		led_rgb_b {
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_BLUE>;
+			gpios = <&gpio0 RK_PB7 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	rfkill {
+		compatible = "rfkill-gpio";
+		label = "rfkill-m2-wlan";
+		radio-type = "wlan";
+		shutdown-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&hdmi_receiver {
+	hpd-gpios = <&gpio1 RK_PC6 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&pinctrl {
+	hdmirx {
+		hdmirx_hpd: hdmirx-5v-detection {
+			rockchip,pins = <1 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	leds {
+		led_rgb_b: led-rgb-b {
+			rockchip,pins = <0 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	pcie2 {
+		pcie2_0_vcc3v3_en: pcie2-0-vcc-en {
+			rockchip,pins = <1 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	sound {
+		hp_detect: hp-detect {
+			rockchip,pins = <1 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&usb_host2_xhci {
+	status = "okay";
+};
+
+&vcc3v3_pcie2x1l0 {
+	gpios = <&gpio1 RK_PD2 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie2_0_vcc3v3_en>;
+	status = "okay";
+};

-- 
2.49.0



Return-Path: <linux-kernel+bounces-606953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BF5A8B60D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 11:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE1713BEC0C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 09:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EBC238165;
	Wed, 16 Apr 2025 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="r4GdzMaT"
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CA6230D0D;
	Wed, 16 Apr 2025 09:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744797269; cv=none; b=o44l4OQCRGgYDgpEN3AIssptvZWyDybYh6M+NmhPbdcfjLLFW0soQCuSr+ALd/5XB7+80ley22UFy0hGlNuBWpuHGiGAj9qfQ0S6lguktHmWJK475oRfjSJv/cJ9D/FyYcR5QBiWXojG6Bz3E1iyDMMBipuQn8sAXKD9as74gC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744797269; c=relaxed/simple;
	bh=8Ex2lcPaWyMoD5DSDLzCq9Rm6A4uKmz4zrIcnbP4Cf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KyV6kVJSObOlBeqL11SW0WSGyn6Vb1XeNtZNu4E2VWxcr9XNkS5j4iYQoZjkt9ORCRacHqIDDISt+XtGF+vYc6LqsFAVxiW7RIMsCIKjwlAEwquBnYL+9sBH7/GZHxbYi2z8qxiD4tBDOE3IXTd44VTKQP/cF5JsXtrmjql7Nj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=r4GdzMaT; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout2.routing.net (Postfix) with ESMTP id 6C8055FD8A;
	Wed, 16 Apr 2025 09:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1744797258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iFAGcEVJkLP8sDenQY2ZgVlMc8wIv5T+oxuNVRNuQbw=;
	b=r4GdzMaTkyCpTki1ceqKpYY14MZZQaqDnWeN+E7VFnr04yBvtpeEvmwgQ0QjiNSamwGkms
	dQ9NkI2e+8q4Wlymsr/5WE4c34vqgjSmS96qV6cRYN5bOzkB1tjwclzNvUeKG9ZyA+vkos
	QQxqj2tKT6CSWMAGvXcIwr1IqPK3Z9Q=
Received: from frank-u24.. (fttx-pool-80.245.72.47.bambit.de [80.245.72.47])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 76238360084;
	Wed, 16 Apr 2025 09:54:17 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Daniel Golle <daniel@makrotopia.org>,
	Sean Wang <sean.wang@mediatek.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-phy@lists.infradead.org
Subject: [PATCH v3 2/8] arm64: dts: mediatek: mt7988a-bpi-r4: allow hw variants of bpi-r4
Date: Wed, 16 Apr 2025 11:53:54 +0200
Message-ID: <20250416095402.90543-3-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250416095402.90543-1-linux@fw-web.de>
References: <20250416095402.90543-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 690c7d62-ab4d-42ff-8053-2107e812bea6

From: Frank Wunderlich <frank-w@public-files.de>

Sinovoip has released other variants of Bananapi-R4 board.
The known changes affecting only the LAN SFP+ slot which is replaced
by a 2.5G phy with optional PoE.

Just move the common parts to a new dtsi and keep differences (only
i2c for lan-sfp) in dts.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v3:
- move compatible to dts
- added own compatible for 2g5 variant
- update information in board model
v2:
- added basic dts for 2g5 variant
- moved i2c used for sfp-lan to board dts
---
 arch/arm64/boot/dts/mediatek/Makefile         |   2 +
 .../mediatek/mt7988a-bananapi-bpi-r4-2g5.dts  |  11 +
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dts  | 400 +-----------------
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi | 399 +++++++++++++++++
 4 files changed, 417 insertions(+), 395 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-2g5.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 58484e830063..a1ebc9aa4ba6 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -22,6 +22,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sd.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-rfb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986b-rfb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7988a-bananapi-bpi-r4.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt7988a-bananapi-bpi-r4-2g5.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7988a-bananapi-bpi-r4-emmc.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7988a-bananapi-bpi-r4-sd.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8167-pumpkin.dtb
@@ -107,4 +108,5 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
 DTC_FLAGS_mt7986a-bananapi-bpi-r3 := -@
 DTC_FLAGS_mt7986a-bananapi-bpi-r3-mini := -@
 DTC_FLAGS_mt7988a-bananapi-bpi-r4 := -@
+DTC_FLAGS_mt7988a-bananapi-bpi-r4-2g5 := -@
 DTC_FLAGS_mt8395-radxa-nio-12l := -@
diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-2g5.dts b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-2g5.dts
new file mode 100644
index 000000000000..53de9c113f60
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-2g5.dts
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+
+/dts-v1/;
+
+#include "mt7988a-bananapi-bpi-r4.dtsi"
+
+/ {
+	compatible = "bananapi,bpi-r4-2g5", "bananapi,bpi-r4", "mediatek,mt7988a";
+	model = "Banana Pi BPI-R4 (1x SFP+, 1x 2.5GbE)";
+	chassis-type = "embedded";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
index 6623112c24c7..36bd1ef2efab 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
@@ -2,408 +2,18 @@
 
 /dts-v1/;
 
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/regulator/richtek,rt5190a-regulator.h>
-
-#include "mt7988a.dtsi"
+#include "mt7988a-bananapi-bpi-r4.dtsi"
 
 / {
 	compatible = "bananapi,bpi-r4", "mediatek,mt7988a";
-	model = "Banana Pi BPI-R4";
+	model = "Banana Pi BPI-R4 (2x SFP+)";
 	chassis-type = "embedded";
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	reg_1p8v: regulator-1p8v {
-		compatible = "regulator-fixed";
-		regulator-name = "fixed-1.8V";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-boot-on;
-		regulator-always-on;
-	};
-
-	reg_3p3v: regulator-3p3v {
-		compatible = "regulator-fixed";
-		regulator-name = "fixed-3.3V";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-boot-on;
-		regulator-always-on;
-	};
 };
 
-&cpu0 {
-	proc-supply = <&rt5190_buck3>;
-};
-
-&cpu1 {
-	proc-supply = <&rt5190_buck3>;
-};
-
-&cpu2 {
-	proc-supply = <&rt5190_buck3>;
-};
-
-&cpu3 {
-	proc-supply = <&rt5190_buck3>;
-};
-
-&cpu_thermal {
-	trips {
-		cpu_trip_hot: hot {
-			temperature = <120000>;
-			hysteresis = <2000>;
-			type = "hot";
-		};
-
-		cpu_trip_active_high: active-high {
-			temperature = <115000>;
-			hysteresis = <2000>;
-			type = "active";
-		};
-
-		cpu_trip_active_med: active-med {
-			temperature = <85000>;
-			hysteresis = <2000>;
-			type = "active";
-		};
-
-		cpu_trip_active_low: active-low {
-			temperature = <40000>;
-			hysteresis = <2000>;
-			type = "active";
-		};
-	};
-};
-
-&i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
-	status = "okay";
-
-	rt5190a_64: rt5190a@64 {
-		compatible = "richtek,rt5190a";
-		reg = <0x64>;
-		vin2-supply = <&rt5190_buck1>;
-		vin3-supply = <&rt5190_buck1>;
-		vin4-supply = <&rt5190_buck1>;
-
-		regulators {
-			rt5190_buck1: buck1 {
-				regulator-name = "rt5190a-buck1";
-				regulator-min-microvolt = <5090000>;
-				regulator-max-microvolt = <5090000>;
-				regulator-allowed-modes =
-				<RT5190A_OPMODE_AUTO>, <RT5190A_OPMODE_FPWM>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-			buck2 {
-				regulator-name = "vcore";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <1400000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-			rt5190_buck3: buck3 {
-				regulator-name = "vproc";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <1400000>;
-				regulator-boot-on;
-			};
-			buck4 {
-				regulator-name = "rt5190a-buck4";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-allowed-modes =
-				<RT5190A_OPMODE_AUTO>, <RT5190A_OPMODE_FPWM>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-			ldo {
-				regulator-name = "rt5190a-ldo";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-		};
-	};
-};
-
-&i2c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_1_pins>;
-	status = "okay";
-
-	pca9545: i2c-mux@70 {
-		compatible = "nxp,pca9545";
-		reg = <0x70>;
-		reset-gpios = <&pio 5 GPIO_ACTIVE_LOW>;
+&pca9545 {
+	i2c_sfp2: i2c@2 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-
-		i2c@0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0>;
-
-			pcf8563: rtc@51 {
-				compatible = "nxp,pcf8563";
-				reg = <0x51>;
-				#clock-cells = <0>;
-			};
-
-			eeprom@57 {
-				compatible = "atmel,24c02";
-				reg = <0x57>;
-				size = <256>;
-			};
-
-		};
-
-		i2c_sfp1: i2c@1 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <1>;
-		};
-
-		i2c_sfp2: i2c@2 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <2>;
-		};
-	};
-};
-
-/* mPCIe SIM2 */
-&pcie0 {
-	status = "okay";
-};
-
-/* mPCIe SIM3 */
-&pcie1 {
-	status = "okay";
-};
-
-/* M.2 key-B SIM1 */
-&pcie2 {
-	status = "okay";
-};
-
-/* M.2 key-M SSD */
-&pcie3 {
-	status = "okay";
-};
-
-&pio {
-	mdio0_pins: mdio0-pins {
-		mux {
-			function = "eth";
-			groups = "mdc_mdio0";
-		};
-
-		conf {
-			pins = "SMI_0_MDC", "SMI_0_MDIO";
-			drive-strength = <8>;
-		};
-	};
-
-	i2c0_pins: i2c0-g0-pins {
-		mux {
-			function = "i2c";
-			groups = "i2c0_1";
-		};
-	};
-
-	i2c1_pins: i2c1-g0-pins {
-		mux {
-			function = "i2c";
-			groups = "i2c1_0";
-		};
-	};
-
-	i2c1_sfp_pins: i2c1-sfp-g0-pins {
-		mux {
-			function = "i2c";
-			groups = "i2c1_sfp";
-		};
-	};
-
-	i2c2_0_pins: i2c2-g0-pins {
-		mux {
-			function = "i2c";
-			groups = "i2c2_0";
-		};
+		reg = <2>;
 	};
-
-	i2c2_1_pins: i2c2-g1-pins {
-		mux {
-			function = "i2c";
-			groups = "i2c2_1";
-		};
-	};
-
-	gbe0_led0_pins: gbe0-led0-pins {
-		mux {
-			function = "led";
-			groups = "gbe0_led0";
-		};
-	};
-
-	gbe1_led0_pins: gbe1-led0-pins {
-		mux {
-			function = "led";
-			groups = "gbe1_led0";
-		};
-	};
-
-	gbe2_led0_pins: gbe2-led0-pins {
-		mux {
-			function = "led";
-			groups = "gbe2_led0";
-		};
-	};
-
-	gbe3_led0_pins: gbe3-led0-pins {
-		mux {
-			function = "led";
-			groups = "gbe3_led0";
-		};
-	};
-
-	gbe0_led1_pins: gbe0-led1-pins {
-		mux {
-			function = "led";
-			groups = "gbe0_led1";
-		};
-	};
-
-	gbe1_led1_pins: gbe1-led1-pins {
-		mux {
-			function = "led";
-			groups = "gbe1_led1";
-		};
-	};
-
-	gbe2_led1_pins: gbe2-led1-pins {
-		mux {
-			function = "led";
-			groups = "gbe2_led1";
-		};
-	};
-
-	gbe3_led1_pins: gbe3-led1-pins {
-		mux {
-			function = "led";
-			groups = "gbe3_led1";
-		};
-	};
-
-	i2p5gbe_led0_pins: 2p5gbe-led0-pins {
-		mux {
-			function = "led";
-			groups = "2p5gbe_led0";
-		};
-	};
-
-	i2p5gbe_led1_pins: 2p5gbe-led1-pins {
-		mux {
-			function = "led";
-			groups = "2p5gbe_led1";
-		};
-	};
-
-	mmc0_pins_emmc_45: mmc0-emmc-45-pins {
-		mux {
-			function = "flash";
-			groups = "emmc_45";
-		};
-	};
-
-	mmc0_pins_emmc_51: mmc0-emmc-51-pins {
-		mux {
-			function = "flash";
-			groups = "emmc_51";
-		};
-	};
-
-	mmc0_pins_sdcard: mmc0-sdcard-pins {
-		mux {
-			function = "flash";
-			groups = "sdcard";
-		};
-	};
-
-	uart0_pins: uart0-pins {
-		mux {
-			function = "uart";
-			groups =  "uart0";
-		};
-	};
-
-	snfi_pins: snfi-pins {
-		mux {
-			function = "flash";
-			groups = "snfi";
-		};
-	};
-
-	spi0_pins: spi0-pins {
-		mux {
-			function = "spi";
-			groups = "spi0";
-		};
-	};
-
-	spi0_flash_pins: spi0-flash-pins {
-		mux {
-			function = "spi";
-			groups = "spi0", "spi0_wp_hold";
-		};
-	};
-
-	spi1_pins: spi1-pins {
-		mux {
-			function = "spi";
-			groups = "spi1";
-		};
-	};
-
-	spi2_pins: spi2-pins {
-		mux {
-			function = "spi";
-			groups = "spi2";
-		};
-	};
-
-	spi2_flash_pins: spi2-flash-pins {
-		mux {
-			function = "spi";
-			groups = "spi2", "spi2_wp_hold";
-		};
-	};
-};
-
-&pwm {
-	status = "okay";
-};
-
-&serial0 {
-	status = "okay";
-};
-
-&ssusb1 {
-	status = "okay";
-};
-
-&tphy {
-	status = "okay";
-};
-
-&watchdog {
-	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
new file mode 100644
index 000000000000..0d332822971d
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
@@ -0,0 +1,399 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/regulator/richtek,rt5190a-regulator.h>
+
+#include "mt7988a.dtsi"
+
+/ {
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-1.8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
+
+&cpu0 {
+	proc-supply = <&rt5190_buck3>;
+};
+
+&cpu1 {
+	proc-supply = <&rt5190_buck3>;
+};
+
+&cpu2 {
+	proc-supply = <&rt5190_buck3>;
+};
+
+&cpu3 {
+	proc-supply = <&rt5190_buck3>;
+};
+
+&cpu_thermal {
+	trips {
+		cpu_trip_hot: hot {
+			temperature = <120000>;
+			hysteresis = <2000>;
+			type = "hot";
+		};
+
+		cpu_trip_active_high: active-high {
+			temperature = <115000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+
+		cpu_trip_active_med: active-med {
+			temperature = <85000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+
+		cpu_trip_active_low: active-low {
+			temperature = <40000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+	};
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+	status = "okay";
+
+	rt5190a_64: rt5190a@64 {
+		compatible = "richtek,rt5190a";
+		reg = <0x64>;
+		vin2-supply = <&rt5190_buck1>;
+		vin3-supply = <&rt5190_buck1>;
+		vin4-supply = <&rt5190_buck1>;
+
+		regulators {
+			rt5190_buck1: buck1 {
+				regulator-name = "rt5190a-buck1";
+				regulator-min-microvolt = <5090000>;
+				regulator-max-microvolt = <5090000>;
+				regulator-allowed-modes =
+				<RT5190A_OPMODE_AUTO>, <RT5190A_OPMODE_FPWM>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			buck2 {
+				regulator-name = "vcore";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <1400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			rt5190_buck3: buck3 {
+				regulator-name = "vproc";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <1400000>;
+				regulator-boot-on;
+			};
+			buck4 {
+				regulator-name = "rt5190a-buck4";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-allowed-modes =
+				<RT5190A_OPMODE_AUTO>, <RT5190A_OPMODE_FPWM>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			ldo {
+				regulator-name = "rt5190a-ldo";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_1_pins>;
+	status = "okay";
+
+	pca9545: i2c-mux@70 {
+		compatible = "nxp,pca9545";
+		reg = <0x70>;
+		reset-gpios = <&pio 5 GPIO_ACTIVE_LOW>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			pcf8563: rtc@51 {
+				compatible = "nxp,pcf8563";
+				reg = <0x51>;
+				#clock-cells = <0>;
+			};
+
+			eeprom@57 {
+				compatible = "atmel,24c02";
+				reg = <0x57>;
+				size = <256>;
+			};
+
+		};
+
+		i2c_sfp1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+	};
+};
+
+/* mPCIe SIM2 */
+&pcie0 {
+	status = "okay";
+};
+
+/* mPCIe SIM3 */
+&pcie1 {
+	status = "okay";
+};
+
+/* M.2 key-B SIM1 */
+&pcie2 {
+	status = "okay";
+};
+
+/* M.2 key-M SSD */
+&pcie3 {
+	status = "okay";
+};
+
+&pio {
+	mdio0_pins: mdio0-pins {
+		mux {
+			function = "eth";
+			groups = "mdc_mdio0";
+		};
+
+		conf {
+			pins = "SMI_0_MDC", "SMI_0_MDIO";
+			drive-strength = <8>;
+		};
+	};
+
+	i2c0_pins: i2c0-g0-pins {
+		mux {
+			function = "i2c";
+			groups = "i2c0_1";
+		};
+	};
+
+	i2c1_pins: i2c1-g0-pins {
+		mux {
+			function = "i2c";
+			groups = "i2c1_0";
+		};
+	};
+
+	i2c1_sfp_pins: i2c1-sfp-g0-pins {
+		mux {
+			function = "i2c";
+			groups = "i2c1_sfp";
+		};
+	};
+
+	i2c2_0_pins: i2c2-g0-pins {
+		mux {
+			function = "i2c";
+			groups = "i2c2_0";
+		};
+	};
+
+	i2c2_1_pins: i2c2-g1-pins {
+		mux {
+			function = "i2c";
+			groups = "i2c2_1";
+		};
+	};
+
+	gbe0_led0_pins: gbe0-led0-pins {
+		mux {
+			function = "led";
+			groups = "gbe0_led0";
+		};
+	};
+
+	gbe1_led0_pins: gbe1-led0-pins {
+		mux {
+			function = "led";
+			groups = "gbe1_led0";
+		};
+	};
+
+	gbe2_led0_pins: gbe2-led0-pins {
+		mux {
+			function = "led";
+			groups = "gbe2_led0";
+		};
+	};
+
+	gbe3_led0_pins: gbe3-led0-pins {
+		mux {
+			function = "led";
+			groups = "gbe3_led0";
+		};
+	};
+
+	gbe0_led1_pins: gbe0-led1-pins {
+		mux {
+			function = "led";
+			groups = "gbe0_led1";
+		};
+	};
+
+	gbe1_led1_pins: gbe1-led1-pins {
+		mux {
+			function = "led";
+			groups = "gbe1_led1";
+		};
+	};
+
+	gbe2_led1_pins: gbe2-led1-pins {
+		mux {
+			function = "led";
+			groups = "gbe2_led1";
+		};
+	};
+
+	gbe3_led1_pins: gbe3-led1-pins {
+		mux {
+			function = "led";
+			groups = "gbe3_led1";
+		};
+	};
+
+	i2p5gbe_led0_pins: 2p5gbe-led0-pins {
+		mux {
+			function = "led";
+			groups = "2p5gbe_led0";
+		};
+	};
+
+	i2p5gbe_led1_pins: 2p5gbe-led1-pins {
+		mux {
+			function = "led";
+			groups = "2p5gbe_led1";
+		};
+	};
+
+	mmc0_pins_emmc_45: mmc0-emmc-45-pins {
+		mux {
+			function = "flash";
+			groups = "emmc_45";
+		};
+	};
+
+	mmc0_pins_emmc_51: mmc0-emmc-51-pins {
+		mux {
+			function = "flash";
+			groups = "emmc_51";
+		};
+	};
+
+	mmc0_pins_sdcard: mmc0-sdcard-pins {
+		mux {
+			function = "flash";
+			groups = "sdcard";
+		};
+	};
+
+	uart0_pins: uart0-pins {
+		mux {
+			function = "uart";
+			groups =  "uart0";
+		};
+	};
+
+	snfi_pins: snfi-pins {
+		mux {
+			function = "flash";
+			groups = "snfi";
+		};
+	};
+
+	spi0_pins: spi0-pins {
+		mux {
+			function = "spi";
+			groups = "spi0";
+		};
+	};
+
+	spi0_flash_pins: spi0-flash-pins {
+		mux {
+			function = "spi";
+			groups = "spi0", "spi0_wp_hold";
+		};
+	};
+
+	spi1_pins: spi1-pins {
+		mux {
+			function = "spi";
+			groups = "spi1";
+		};
+	};
+
+	spi2_pins: spi2-pins {
+		mux {
+			function = "spi";
+			groups = "spi2";
+		};
+	};
+
+	spi2_flash_pins: spi2-flash-pins {
+		mux {
+			function = "spi";
+			groups = "spi2", "spi2_wp_hold";
+		};
+	};
+};
+
+&pwm {
+	status = "okay";
+};
+
+&serial0 {
+	status = "okay";
+};
+
+&ssusb1 {
+	status = "okay";
+};
+
+&tphy {
+	status = "okay";
+};
+
+&watchdog {
+	status = "okay";
+};
-- 
2.43.0



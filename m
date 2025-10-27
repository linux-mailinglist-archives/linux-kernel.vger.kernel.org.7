Return-Path: <linux-kernel+bounces-872015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 738E3C0F156
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 92D3D4F8563
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA2A30C378;
	Mon, 27 Oct 2025 15:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="fWC5hwV3"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD41422AE45
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579942; cv=none; b=uWJNn/Ggldgo1lb6AXxJjil9BKLwMTZGRxGGKBwWh94X3OiGM/dpC5y95PyCii2hZhgA1Z4vGUV5joY2DKPycloILtTkxnoHm5CA3COeFteoq9kDlgZnMn3qVQEtOo1DuLLHM7NcccdqNN7FVABOQvGJK/V7Iu+/LWfx/gsl9jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579942; c=relaxed/simple;
	bh=c5C74q6OL0kRs9iKCDAzElz9SQV/xAGSBmP0MOQKOfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OJO+aqM8d51KSAZuohGWCCRgUZZzy0XY2Vk8aM/EJfD/47tZqsopt/KQ2+b3dWO7fuHWGPq8KaxnKBrMyhQ43vTtEDvXwlrhRaYil3fDdopguvfUHnrwxPdMZ4eiFo+YWdJZnyoVGUclXk+h7dCkrJb1w9TXcjjGbeXkZZj9toU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=fWC5hwV3; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
	s=key1; t=1761579931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2nBf2AUbBqXG/HeLsmgzrC8vna7/jtP4efxtFz7mD9c=;
	b=fWC5hwV3jDmrMKewkK6IO85DVjCjy/h4jRpStWl+Yz39FJ+Eh8QIeqht9kBYs2meA3dV06
	KCbjiiU5jFJneXF7/jpukSa3ArIWMteg5aQeKf+D0Ky+vHKF3D40w3pbsL6SFIKmdJPL5O
	uQH/aavLB7n8LTYIEY9/zpkhp+OjJ/c2cikQrCehnI/deYACvV5iTwoel4yd2VyAi7lRRZ
	bjPYS7Pl1YvO4lPmZ9ETN0f7jF3vBi4E0o9iW32SpVCniSVls0RGEC2C9qru5Gc3j/vpdQ
	Uy/YsfLhrnMkeUI5jP5gMKc6V72FeAzzOhkT8cpgWtnwX1N1Dg5oLD3SfWlHAw==
From: Diederik de Haas <diederik@cknow-tech.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dragan Simic <dsimic@manjaro.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Diederik de Haas <diederik@cknow-tech.com>
Subject: [PATCH v2] arm64: dts: rockchip: Harmonize regulator formatting for Pine64 rk3566 devices
Date: Mon, 27 Oct 2025 16:39:53 +0100
Message-ID: <20251027154517.136976-1-diederik@cknow-tech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The regulator node properties in Pine64 rk3566 devices were formatted
rather inconsistently. To name a few:
- 'name' was sometimes put at the top of the list, while at other times
  it was (mostly) sorted in alphabetical order
- 'always-on' and 'boot-on' were sometimes at the top of the list,
  sometimes not
- 'state-mem' nodes sometimes had a preceding blank line, as they
  should, but sometimes not
- other properties seem to have been added to the end of the list, not
  in their alphabetical/natural order

So harmonize the formatting by making all properties sorted
alphabetically/naturally. And harmonize the formatting of the
'state-mem' nodes so they all have a preceding blank line. While at it,
also fix 2 incorrectly indented nodes.

No functional changes.

Signed-off-by: Diederik de Haas <diederik@cknow-tech.com>
---
No outright NACKs and one positive response (thanks!), so here's v2.

Changes in v2:
- Found more regulators at the beginning of the pinetab2 dtsi file
- Missed a 'regulator-always-on' on regulator-vcc3v3-sys in q64b dts
Link to v1:
https://lore.kernel.org/all/20251026153805.107774-1-diederik@cknow-tech.com/

 .../boot/dts/rockchip/rk3566-pinenote.dtsi    | 52 +++++++++---------
 .../boot/dts/rockchip/rk3566-pinetab2.dtsi    | 47 ++++++++++------
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 51 +++++++++++-------
 .../boot/dts/rockchip/rk3566-quartz64-b.dts   | 54 ++++++++++---------
 .../dts/rockchip/rk3566-soquartz-blade.dts    |  6 +--
 .../boot/dts/rockchip/rk3566-soquartz-cm4.dts |  6 +--
 .../dts/rockchip/rk3566-soquartz-model-a.dts  | 10 ++--
 .../boot/dts/rockchip/rk3566-soquartz.dtsi    | 43 ++++++++++-----
 8 files changed, 158 insertions(+), 111 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
index 5c6f8cc401c9..36aa39cc79e5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
@@ -133,46 +133,46 @@ link1_codec: codec {
 
 	vbat_4g: regulator-vbat-4g {
 		compatible = "regulator-fixed";
-		regulator-name = "vbat_4g";
 		regulator-min-microvolt = <3800000>;
 		regulator-max-microvolt = <3800000>;
+		regulator-name = "vbat_4g";
 		/* powered by vcc_bat, enabled by vbat_4g_en */
 		vin-supply = <&vbat_4g_en>;
 	};
 
 	vcc_1v8: regulator-vcc-1v8 {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc_1v8";
 		regulator-always-on;
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
+		regulator-name = "vcc_1v8";
 		/* powered by vcc_sys, enabled by vcc_1v8_en */
 		vin-supply = <&vcc_1v8_en>;
 	};
 
 	vcc_bat: regulator-vcc-bat {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc_bat";
 		regulator-always-on;
 		regulator-min-microvolt = <3800000>;
 		regulator-max-microvolt = <3800000>;
+		regulator-name = "vcc_bat";
 	};
 
 	vcc_hall_3v3: regulator-vcc-hall-3v3 {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc_hall_3v3";
 		regulator-always-on;
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		regulator-name = "vcc_hall_3v3";
 		vin-supply = <&vcc_sys>;
 	};
 
 	vcc_sys: regulator-vcc-sys {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc_sys";
 		regulator-always-on;
 		regulator-min-microvolt = <3800000>;
 		regulator-max-microvolt = <3800000>;
+		regulator-name = "vcc_sys";
 		vin-supply = <&vcc_bat>;
 	};
 
@@ -182,18 +182,18 @@ vcc_wl: regulator-vcc-wl {
 		gpio = <&gpio0 RK_PA0 GPIO_ACTIVE_HIGH>;
 		pinctrl-0 = <&vcc_wl_pin>;
 		pinctrl-names = "default";
-		regulator-name = "vcc_wl";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		regulator-name = "vcc_wl";
 		vin-supply = <&vcc_bat>;
 	};
 
 	vdda_0v9: regulator-vdda-0v9 {
 		compatible = "regulator-fixed";
-		regulator-name = "vdda_0v9";
 		regulator-always-on;
 		regulator-min-microvolt = <900000>;
 		regulator-max-microvolt = <900000>;
+		regulator-name = "vdda_0v9";
 		/* powered by vcc_sys, enabled by vcc_1v8_en */
 		vin-supply = <&vcc_1v8_en>;
 	};
@@ -222,11 +222,11 @@ vdd_cpu: regulator@1c {
 		compatible = "tcs,tcs4525";
 		reg = <0x1c>;
 		fcs,suspend-voltage-selector = <0>;
-		regulator-name = "vdd_cpu";
+		regulator-always-on;
 		regulator-min-microvolt = <712500>;
 		regulator-max-microvolt = <1390000>;
+		regulator-name = "vdd_cpu";
 		regulator-ramp-delay = <2300>;
-		regulator-always-on;
 		vin-supply = <&vcc_sys>;
 
 		regulator-state-mem {
@@ -262,12 +262,12 @@ rk817: pmic@20 {
 
 		regulators {
 			vdd_logic: DCDC_REG1 {
-				regulator-name = "vdd_logic";
 				regulator-always-on;
+				regulator-initial-mode = <0x2>;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
+				regulator-name = "vdd_logic";
 				regulator-ramp-delay = <6001>;
-				regulator-initial-mode = <0x2>;
 
 				regulator-state-mem {
 					regulator-off-in-suspend;
@@ -276,11 +276,11 @@ regulator-state-mem {
 			};
 
 			vdd_gpu_npu: DCDC_REG2 {
-				regulator-name = "vdd_gpu_npu";
+				regulator-initial-mode = <0x2>;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
+				regulator-name = "vdd_gpu_npu";
 				regulator-ramp-delay = <6001>;
-				regulator-initial-mode = <0x2>;
 
 				regulator-state-mem {
 					regulator-off-in-suspend;
@@ -288,9 +288,9 @@ regulator-state-mem {
 			};
 
 			vcc_ddr: DCDC_REG3 {
-				regulator-name = "vcc_ddr";
 				regulator-always-on;
 				regulator-initial-mode = <0x2>;
+				regulator-name = "vcc_ddr";
 
 				regulator-state-mem {
 					regulator-on-in-suspend;
@@ -298,11 +298,11 @@ regulator-state-mem {
 			};
 
 			vcc_3v3: DCDC_REG4 {
-				regulator-name = "vcc_3v3";
 				regulator-always-on;
+				regulator-initial-mode = <0x2>;
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
-				regulator-initial-mode = <0x2>;
+				regulator-name = "vcc_3v3";
 
 				regulator-state-mem {
 					regulator-off-in-suspend;
@@ -310,10 +310,10 @@ regulator-state-mem {
 			};
 
 			vcca_1v8_pmu: LDO_REG1 {
-				regulator-name = "vcca_1v8_pmu";
 				regulator-always-on;
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcca_1v8_pmu";
 
 				regulator-state-mem {
 					regulator-on-in-suspend;
@@ -322,9 +322,9 @@ regulator-state-mem {
 
 			/* unused */
 			vdda_0v9_ldo: LDO_REG2 {
-				regulator-name = "vdda_0v9_ldo";
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <900000>;
+				regulator-name = "vdda_0v9_ldo";
 
 				regulator-state-mem {
 					regulator-off-in-suspend;
@@ -332,10 +332,10 @@ regulator-state-mem {
 			};
 
 			vdda_0v9_pmu: LDO_REG3 {
-				regulator-name = "vdda_0v9_pmu";
 				regulator-always-on;
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <900000>;
+				regulator-name = "vdda_0v9_pmu";
 
 				regulator-state-mem {
 					regulator-on-in-suspend;
@@ -343,10 +343,10 @@ regulator-state-mem {
 			};
 
 			vccio_acodec: LDO_REG4 {
-				regulator-name = "vccio_acodec";
 				regulator-always-on;
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
+				regulator-name = "vccio_acodec";
 
 				regulator-state-mem {
 					regulator-off-in-suspend;
@@ -355,9 +355,9 @@ regulator-state-mem {
 
 			/* unused */
 			vccio_sd: LDO_REG5 {
-				regulator-name = "vccio_sd";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
+				regulator-name = "vccio_sd";
 
 				regulator-state-mem {
 					regulator-off-in-suspend;
@@ -365,10 +365,10 @@ regulator-state-mem {
 			};
 
 			vcc_3v3_pmu: LDO_REG6 {
-				regulator-name = "vcc_3v3_pmu";
 				regulator-always-on;
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc_3v3_pmu";
 
 				regulator-state-mem {
 					regulator-on-in-suspend;
@@ -376,9 +376,9 @@ regulator-state-mem {
 			};
 
 			vcc_1v8_en: LDO_REG7 {
-				regulator-name = "vcc_1v8_en";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc_1v8_en";
 
 				regulator-state-mem {
 					regulator-off-in-suspend;
@@ -386,9 +386,9 @@ regulator-state-mem {
 			};
 
 			vbat_4g_en: LDO_REG8 {
-				regulator-name = "vbat_4g_en";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
+				regulator-name = "vbat_4g_en";
 
 				regulator-state-mem {
 					regulator-off-in-suspend;
@@ -396,9 +396,9 @@ regulator-state-mem {
 			};
 
 			sleep_sta_ctl: LDO_REG9 {
-				regulator-name = "sleep_sta_ctl";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
+				regulator-name = "sleep_sta_ctl";
 
 				regulator-state-mem {
 					regulator-on-in-suspend;
@@ -406,9 +406,9 @@ regulator-state-mem {
 			};
 
 			dcdc_boost: BOOST {
-				regulator-name = "boost";
 				regulator-min-microvolt = <5000000>;
 				regulator-max-microvolt = <5000000>;
+				regulator-name = "boost";
 
 				regulator-state-mem {
 					regulator-off-in-suspend;
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi
index d0e38412d56a..3a4a94dbee67 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi
@@ -145,11 +145,11 @@ speaker_amp: speaker-amplifier {
 
 	vcc_3v3: regulator-vcc-3v3 {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc_3v3";
 		regulator-always-on;
 		regulator-boot-on;
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		regulator-name = "vcc_3v3";
 		vin-supply = <&vcc3v3_sys>;
 	};
 
@@ -159,9 +159,9 @@ vcc3v3_minipcie: regulator-vcc3v3-minipcie {
 		gpio = <&gpio4 RK_PC3 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pcie_pwren_h>;
-		regulator-name = "vcc3v3_minipcie";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		regulator-name = "vcc3v3_minipcie";
 		vin-supply = <&vcc_sys>;
 	};
 
@@ -170,9 +170,9 @@ vcc3v3_sd: regulator-vcc3v3-sd {
 		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sdmmc_pwren_l>;
-		regulator-name = "vcc3v3_sd";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		regulator-name = "vcc3v3_sd";
 		vin-supply = <&vcc3v3_sys>;
 	};
 
@@ -182,9 +182,9 @@ vcc5v0_flashled: regulator-vcc5v0-flashled {
 		gpio = <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&flash_led_en_h>;
-		regulator-name = "vcc5v0_flashled";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
+		regulator-name = "vcc5v0_flashled";
 		vin-supply = <&vcc5v_midu>;
 	};
 
@@ -194,9 +194,9 @@ vcc5v0_usb_host0: regulator-vcc5v0-usb-host0 {
 		gpio = <&gpio4 RK_PC4 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&usb_host_pwren1_h>;
-		regulator-name = "vcc5v0_usb_host0";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
+		regulator-name = "vcc5v0_usb_host0";
 		vin-supply = <&vcc5v_midu>;
 	};
 
@@ -206,32 +206,32 @@ vcc5v0_usb_host2: regulator-vcc5v0-usb-host2 {
 		gpio = <&gpio4 RK_PC5 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&usb_host_pwren2_h>;
-		regulator-name = "vcc5v0_usb_host2";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
+		regulator-name = "vcc5v0_usb_host2";
 		vin-supply = <&vcc5v_midu>;
 	};
 
 	vcc_bat: regulator-vcc-bat {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc_bat";
 		regulator-always-on;
 		regulator-boot-on;
+		regulator-name = "vcc_bat";
 	};
 
 	vcc_sys: regulator-vcc-sys {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc_sys";
 		regulator-always-on;
 		regulator-boot-on;
+		regulator-name = "vcc_sys";
 		vin-supply = <&vcc_bat>;
 	};
 
 	vdd1v2_dvp: regulator-vdd1v2-dvp {
 		compatible = "regulator-fixed";
-		regulator-name = "vdd1v2_dvp";
 		regulator-min-microvolt = <1200000>;
 		regulator-max-microvolt = <1200000>;
+		regulator-name = "vdd1v2_dvp";
 		vin-supply = <&vcc_3v3>;
 	};
 };
@@ -344,12 +344,12 @@ vdd_cpu: regulator@1c {
 		compatible = "tcs,tcs4525";
 		reg = <0x1c>;
 		fcs,suspend-voltage-selector = <1>;
-		regulator-name = "vdd_cpu";
+		regulator-always-on;
+		regulator-boot-on;
 		regulator-min-microvolt = <800000>;
 		regulator-max-microvolt = <1150000>;
+		regulator-name = "vdd_cpu";
 		regulator-ramp-delay = <2300>;
-		regulator-always-on;
-		regulator-boot-on;
 		vin-supply = <&vcc_sys>;
 
 		regulator-state-mem {
@@ -388,22 +388,24 @@ regulators {
 			vdd_logic: DCDC_REG1 {
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-initial-mode = <0x2>;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
 				regulator-ramp-delay = <6001>;
-				regulator-initial-mode = <0x2>;
 				regulator-name = "vdd_logic";
+
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
 			};
 
 			vdd_gpu_npu: DCDC_REG2 {
+				regulator-initial-mode = <0x2>;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
-				regulator-ramp-delay = <6001>;
-				regulator-initial-mode = <0x2>;
 				regulator-name = "vdd_gpu_npu";
+				regulator-ramp-delay = <6001>;
+
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
@@ -414,6 +416,7 @@ vcc_ddr: DCDC_REG3 {
 				regulator-boot-on;
 				regulator-initial-mode = <0x2>;
 				regulator-name = "vcc_ddr";
+
 				regulator-state-mem {
 					regulator-on-in-suspend;
 				};
@@ -422,10 +425,11 @@ regulator-state-mem {
 			vcc3v3_sys: DCDC_REG4 {
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-initial-mode = <0x2>;
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
-				regulator-initial-mode = <0x2>;
 				regulator-name = "vcc3v3_sys";
+
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
@@ -437,6 +441,7 @@ vcca1v8_pmu: LDO_REG1 {
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-name = "vcca1v8_pmu";
+
 				regulator-state-mem {
 					regulator-on-in-suspend;
 				};
@@ -448,6 +453,7 @@ vdda_0v9_p: LDO_REG2 {
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <900000>;
 				regulator-name = "vdda_0v9_p";
+
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
@@ -459,6 +465,7 @@ vdda0v9_pmu: LDO_REG3 {
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <900000>;
 				regulator-name = "vdda0v9_pmu";
+
 				regulator-state-mem {
 					regulator-on-in-suspend;
 				};
@@ -470,6 +477,7 @@ vccio_acodec: LDO_REG4 {
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-name = "vccio_acodec";
+
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
@@ -481,6 +489,7 @@ vccio_sd: LDO_REG5 {
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-name = "vccio_sd";
+
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
@@ -492,6 +501,7 @@ vcc3v3_pmu: LDO_REG6 {
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-name = "vcc3v3_pmu";
+
 				regulator-state-mem {
 					regulator-on-in-suspend;
 				};
@@ -503,6 +513,7 @@ vcc_1v8: LDO_REG7 {
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-name = "vcc_1v8";
+
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
@@ -514,6 +525,7 @@ vcc1v8_dvp: LDO_REG8 {
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-name = "vcc1v8_dvp";
+
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
@@ -525,6 +537,7 @@ vcc2v8_dvp: LDO_REG9 {
 				regulator-min-microvolt = <2800000>;
 				regulator-max-microvolt = <2800000>;
 				regulator-name = "vcc2v8_dvp";
+
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
@@ -536,6 +549,7 @@ vcc5v_midu: BOOST {
 				regulator-min-microvolt = <5000000>;
 				regulator-max-microvolt = <5000000>;
 				regulator-name = "boost";
+
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
@@ -545,6 +559,7 @@ vbus: OTG_SWITCH {
 				regulator-min-microvolt = <5000000>;
 				regulator-max-microvolt = <5000000>;
 				regulator-name = "otg_switch";
+
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
index a9021c524afb..210be62f66a7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
@@ -120,11 +120,11 @@ simple-audio-card,codec {
 
 	vcc12v_dcin: regulator-vcc12v-dcin {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc12v_dcin";
 		regulator-always-on;
 		regulator-boot-on;
 		regulator-min-microvolt = <12000000>;
 		regulator-max-microvolt = <12000000>;
+		regulator-name = "vcc12v_dcin";
 	};
 
 	/* vbus feeds the rk817 usb input.
@@ -133,11 +133,11 @@ vcc12v_dcin: regulator-vcc12v-dcin {
 	 */
 	vbus: regulator-vbus {
 		compatible = "regulator-fixed";
-		regulator-name = "vbus";
 		regulator-always-on;
 		regulator-boot-on;
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
+		regulator-name = "vbus";
 		vin-supply = <&vcc12v_dcin>;
 	};
 
@@ -147,19 +147,19 @@ vcc3v3_pcie_p: regulator-vcc3v3-pcie-p {
 		gpio = <&gpio0 RK_PC6 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pcie_enable_h>;
-		regulator-name = "vcc3v3_pcie_p";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		regulator-name = "vcc3v3_pcie_p";
 		vin-supply = <&vcc_3v3>;
 	};
 
 	vcc5v0_usb: regulator-vcc5v0-usb {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0_usb";
 		regulator-always-on;
 		regulator-boot-on;
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
+		regulator-name = "vcc5v0_usb";
 		vin-supply = <&vcc12v_dcin>;
 	};
 
@@ -173,9 +173,9 @@ vcc5v0_usb20_host: regulator-vcc5v0-usb20-host {
 		gpio = <&gpio4 RK_PB5 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&vcc5v0_usb20_host_en>;
-		regulator-name = "vcc5v0_usb20_host";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
+		regulator-name = "vcc5v0_usb20_host";
 		vin-supply = <&vcc5v0_usb>;
 	};
 
@@ -183,9 +183,9 @@ vcc5v0_usb20_otg: regulator-vcc5v0-usb20-otg {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio4 RK_PB5 GPIO_ACTIVE_HIGH>;
-		regulator-name = "vcc5v0_usb20_otg";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
+		regulator-name = "vcc5v0_usb20_otg";
 		vin-supply = <&dcdc_boost>;
 	};
 
@@ -195,31 +195,31 @@ vcc3v3_sd: regulator-vcc3v3-sd {
 		pinctrl-names = "default";
 		pinctrl-0 = <&vcc_sd_h>;
 		regulator-boot-on;
-		regulator-name = "vcc3v3_sd";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		regulator-name = "vcc3v3_sd";
 		vin-supply = <&vcc_3v3>;
 	};
 
 	/* sourced from vbus and vcc_bat+ via rk817 sw5 */
 	vcc_sys: regulator-vcc-sys {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc_sys";
 		regulator-always-on;
 		regulator-boot-on;
 		regulator-min-microvolt = <4400000>;
 		regulator-max-microvolt = <4400000>;
+		regulator-name = "vcc_sys";
 		vin-supply = <&vbus>;
 	};
 
 	/* sourced from vcc_sys, sdio module operates internally at 3.3v */
 	vcc_wl: regulator-vcc-wl {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc_wl";
 		regulator-always-on;
 		regulator-boot-on;
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		regulator-name = "vcc_wl";
 		vin-supply = <&vcc_sys>;
 	};
 };
@@ -326,12 +326,12 @@ vdd_cpu: regulator@1c {
 		compatible = "tcs,tcs4525";
 		reg = <0x1c>;
 		fcs,suspend-voltage-selector = <1>;
-		regulator-name = "vdd_cpu";
+		regulator-always-on;
+		regulator-boot-on;
 		regulator-min-microvolt = <800000>;
 		regulator-max-microvolt = <1150000>;
+		regulator-name = "vdd_cpu";
 		regulator-ramp-delay = <2300>;
-		regulator-always-on;
-		regulator-boot-on;
 		vin-supply = <&vcc_sys>;
 
 		regulator-state-mem {
@@ -370,11 +370,12 @@ regulators {
 			vdd_logic: DCDC_REG1 {
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-initial-mode = <0x2>;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
-				regulator-ramp-delay = <6001>;
-				regulator-initial-mode = <0x2>;
 				regulator-name = "vdd_logic";
+				regulator-ramp-delay = <6001>;
+
 				regulator-state-mem {
 					regulator-on-in-suspend;
 					regulator-suspend-microvolt = <900000>;
@@ -384,12 +385,13 @@ regulator-state-mem {
 			vdd_gpu: DCDC_REG2 {
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-initial-mode = <0x2>;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
-				regulator-ramp-delay = <6001>;
-				regulator-initial-mode = <0x2>;
 				regulator-name = "vdd_gpu";
-					regulator-state-mem {
+				regulator-ramp-delay = <6001>;
+
+				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
 			};
@@ -399,6 +401,7 @@ vcc_ddr: DCDC_REG3 {
 				regulator-boot-on;
 				regulator-initial-mode = <0x2>;
 				regulator-name = "vcc_ddr";
+
 				regulator-state-mem {
 					regulator-on-in-suspend;
 				};
@@ -407,10 +410,11 @@ regulator-state-mem {
 			vcc_3v3: DCDC_REG4 {
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-initial-mode = <0x2>;
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
-				regulator-initial-mode = <0x2>;
 				regulator-name = "vcc_3v3";
+
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
@@ -422,6 +426,7 @@ vcca1v8_pmu: LDO_REG1 {
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-name = "vcca1v8_pmu";
+
 				regulator-state-mem {
 					regulator-on-in-suspend;
 					regulator-suspend-microvolt = <1800000>;
@@ -434,6 +439,7 @@ vdda_0v9: LDO_REG2 {
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <900000>;
 				regulator-name = "vdda_0v9";
+
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
@@ -445,6 +451,7 @@ vdda0v9_pmu: LDO_REG3 {
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <900000>;
 				regulator-name = "vdda0v9_pmu";
+
 				regulator-state-mem {
 					regulator-on-in-suspend;
 					regulator-suspend-microvolt = <900000>;
@@ -457,6 +464,7 @@ vccio_acodec: LDO_REG4 {
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-name = "vccio_acodec";
+
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
@@ -468,6 +476,7 @@ vccio_sd: LDO_REG5 {
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-name = "vccio_sd";
+
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
@@ -479,6 +488,7 @@ vcc3v3_pmu: LDO_REG6 {
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-name = "vcc3v3_pmu";
+
 				regulator-state-mem {
 					regulator-on-in-suspend;
 					regulator-suspend-microvolt = <3300000>;
@@ -491,6 +501,7 @@ vcc_1v8: LDO_REG7 {
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-name = "vcc_1v8";
+
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
@@ -502,6 +513,7 @@ vcc1v8_dvp: LDO_REG8 {
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-name = "vcc1v8_dvp";
+
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
@@ -513,6 +525,7 @@ vcc2v8_dvp: LDO_REG9 {
 				regulator-min-microvolt = <2800000>;
 				regulator-max-microvolt = <2800000>;
 				regulator-name = "vcc2v8_dvp";
+
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
@@ -524,6 +537,7 @@ dcdc_boost: BOOST {
 				regulator-min-microvolt = <5000000>;
 				regulator-max-microvolt = <5000000>;
 				regulator-name = "boost";
+
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
@@ -531,6 +545,7 @@ regulator-state-mem {
 
 			otg_switch: OTG_SWITCH {
 				regulator-name = "otg_switch";
+
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
index f8cf03380636..cc666ae916b5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
@@ -87,43 +87,42 @@ vcc3v3_pcie_p: regulator-vcc3v3-pcie-p {
 		gpio = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pcie_enable_h>;
-		regulator-name = "vcc3v3_pcie_p";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		regulator-name = "vcc3v3_pcie_p";
 		vin-supply = <&vcc_3v3>;
 	};
 
 	vcc5v0_in: regulator-vcc5v0-in {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0_in";
 		regulator-always-on;
 		regulator-boot-on;
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
+		regulator-name = "vcc5v0_in";
 	};
 
 	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
 		regulator-boot-on;
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
+		regulator-name = "vcc5v0_sys";
 		vin-supply = <&vcc5v0_in>;
 	};
 
 	vcc3v3_sys: regulator-vcc3v3-sys {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc3v3_sys";
+		regulator-always-on;
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
+		regulator-name = "vcc3v3_sys";
 		vin-supply = <&vcc5v0_sys>;
 	};
 
 	vcc5v0_usb30_host: regulator-vcc5v0-usb30-host {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0_usb30_host";
 		enable-active-high;
 		gpio = <&gpio0 RK_PC5 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
@@ -131,12 +130,12 @@ vcc5v0_usb30_host: regulator-vcc5v0-usb30-host {
 		regulator-always-on;
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
+		regulator-name = "vcc5v0_usb30_host";
 		vin-supply = <&vcc5v0_sys>;
 	};
 
 	vcc5v0_usb_otg: regulator-vcc5v0-usb-otg {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0_usb_otg";
 		enable-active-high;
 		gpio = <&gpio0 RK_PC6 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
@@ -144,6 +143,7 @@ vcc5v0_usb_otg: regulator-vcc5v0-usb-otg {
 		regulator-always-on;
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
+		regulator-name = "vcc5v0_usb_otg";
 		vin-supply = <&vcc5v0_sys>;
 	};
 };
@@ -233,12 +233,12 @@ vdd_cpu: regulator@1c {
 		compatible = "tcs,tcs4525";
 		reg = <0x1c>;
 		fcs,suspend-voltage-selector = <1>;
-		regulator-name = "vdd_cpu";
+		regulator-always-on;
+		regulator-boot-on;
 		regulator-min-microvolt = <800000>;
 		regulator-max-microvolt = <1150000>;
+		regulator-name = "vdd_cpu";
 		regulator-ramp-delay = <2300>;
-		regulator-always-on;
-		regulator-boot-on;
 		vin-supply = <&vcc5v0_sys>;
 
 		regulator-state-mem {
@@ -276,11 +276,11 @@ rk809: pmic@20 {
 
 		regulators {
 			vdd_log: DCDC_REG1 {
-				regulator-name = "vdd_log";
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
+				regulator-name = "vdd_log";
 				regulator-ramp-delay = <6001>;
 
 				regulator-state-mem {
@@ -290,11 +290,11 @@ regulator-state-mem {
 			};
 
 			vdd_gpu: DCDC_REG2 {
-				regulator-name = "vdd_gpu";
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
+				regulator-name = "vdd_gpu";
 				regulator-ramp-delay = <6001>;
 
 				regulator-state-mem {
@@ -304,31 +304,33 @@ regulator-state-mem {
 			};
 
 			vcc_ddr: DCDC_REG3 {
-				regulator-name = "vcc_ddr";
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-initial-mode = <0x2>;
+				regulator-name = "vcc_ddr";
+
 				regulator-state-mem {
 					regulator-on-in-suspend;
 				};
 			};
 
 			vdd_npu: DCDC_REG4 {
-				regulator-name = "vdd_npu";
+				regulator-initial-mode = <0x2>;
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <1350000>;
-				regulator-initial-mode = <0x2>;
+				regulator-name = "vdd_npu";
+
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
 			};
 
 			vcc_1v8: DCDC_REG5 {
-				regulator-name = "vcc_1v8";
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc_1v8";
 
 				regulator-state-mem {
 					regulator-on-in-suspend;
@@ -337,11 +339,11 @@ regulator-state-mem {
 			};
 
 			vdda0v9_image: LDO_REG1 {
-				regulator-name = "vdda0v9_image";
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <900000>;
+				regulator-name = "vdda0v9_image";
 
 				regulator-state-mem {
 					regulator-on-in-suspend;
@@ -350,11 +352,11 @@ regulator-state-mem {
 			};
 
 			vdda_0v9: LDO_REG2 {
-				regulator-name = "vdda_0v9";
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <900000>;
+				regulator-name = "vdda_0v9";
 
 				regulator-state-mem {
 					regulator-on-in-suspend;
@@ -363,11 +365,12 @@ regulator-state-mem {
 			};
 
 			vdda0v9_pmu: LDO_REG3 {
-				regulator-name = "vdda0v9_pmu";
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <900000>;
+				regulator-name = "vdda0v9_pmu";
+
 				regulator-state-mem {
 					regulator-on-in-suspend;
 					regulator-suspend-microvolt = <900000>;
@@ -375,25 +378,24 @@ regulator-state-mem {
 			};
 
 			vccio_acodec: LDO_REG4 {
-				regulator-name = "vccio_acodec";
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
+				regulator-name = "vccio_acodec";
 
 				regulator-state-mem {
 					regulator-on-in-suspend;
 					regulator-suspend-microvolt = <3300000>;
-
 				};
 			};
 
 			vccio_sd: LDO_REG5 {
-				regulator-name = "vccio_sd";
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
+				regulator-name = "vccio_sd";
 
 				regulator-state-mem {
 					regulator-on-in-suspend;
@@ -402,11 +404,11 @@ regulator-state-mem {
 			};
 
 			vcc3v3_pmu: LDO_REG6 {
-				regulator-name = "vcc3v3_pmu";
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc3v3_pmu";
 
 				regulator-state-mem {
 					regulator-on-in-suspend;
@@ -415,11 +417,11 @@ regulator-state-mem {
 			};
 
 			vcca_1v8: LDO_REG7 {
-				regulator-name = "vcca_1v8";
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcca_1v8";
 
 				regulator-state-mem {
 					regulator-on-in-suspend;
@@ -428,11 +430,11 @@ regulator-state-mem {
 			};
 
 			vcca1v8_pmu: LDO_REG8 {
-				regulator-name = "vcca1v8_pmu";
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcca1v8_pmu";
 
 				regulator-state-mem {
 					regulator-on-in-suspend;
@@ -441,11 +443,11 @@ regulator-state-mem {
 			};
 
 			vcca1v8_image: LDO_REG9 {
-				regulator-name = "vcca1v8_image";
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcca1v8_image";
 
 				regulator-state-mem {
 					regulator-on-in-suspend;
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-blade.dts b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-blade.dts
index b64d0c957ef6..d0d7fa5823a5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-blade.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-blade.dts
@@ -20,32 +20,32 @@ aliases {
 	/* labeled VCC3V0_SD in schematic to not conflict with PMIC regulator */
 	vcc3v0_sd: regulator-vcc3v0-sd {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc3v0_sd";
 		regulator-always-on;
 		regulator-boot-on;
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		regulator-name = "vcc3v0_sd";
 		vin-supply = <&vcc3v3_sys>;
 	};
 
 	/* labeled VCC_SSD in schematic */
 	vcc3v3_pcie_p: regulator-vcc3v3-pcie {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc3v3_pcie_p";
 		regulator-always-on;
 		regulator-boot-on;
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		regulator-name = "vcc3v3_pcie_p";
 		vin-supply = <&vbus>;
 	};
 
 	vcc5v_dcin: regulator-vcc5v-dcin {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc5v_dcin";
 		regulator-always-on;
 		regulator-boot-on;
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
+		regulator-name = "vcc5v_dcin";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
index 38155316846d..7cae7f100324 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
@@ -15,31 +15,31 @@ aliases {
 	/* labeled +12v in schematic */
 	vcc12v_dcin: regulator-vcc12v-dcin {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc12v_dcin";
 		regulator-always-on;
 		regulator-boot-on;
 		regulator-min-microvolt = <12000000>;
 		regulator-max-microvolt = <12000000>;
+		regulator-name = "vcc12v_dcin";
 	};
 
 	/* labeled +5v in schematic */
 	vcc_5v: regulator-vcc-5v {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc_5v";
 		regulator-always-on;
 		regulator-boot-on;
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
+		regulator-name = "vcc_5v";
 		vin-supply = <&vcc12v_dcin>;
 	};
 
 	vcc_sd_pwr: regulator-vcc-sd-pwr {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc_sd_pwr";
 		regulator-always-on;
 		regulator-boot-on;
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		regulator-name = "vcc_sd_pwr";
 		vin-supply = <&vcc3v3_sys>;
 	};
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-model-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-model-a.dts
index 2e130eef54df..f9b0bac522ab 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-model-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-model-a.dts
@@ -15,20 +15,20 @@ aliases {
 	/* labeled DCIN_12V in schematic */
 	vcc12v_dcin: regulator-vcc12v-dcin {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc12v_dcin";
 		regulator-always-on;
 		regulator-boot-on;
 		regulator-min-microvolt = <12000000>;
 		regulator-max-microvolt = <12000000>;
+		regulator-name = "vcc12v_dcin";
 	};
 
 	vcc5v0_usb: regulator-vcc5v0-usb {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0_usb";
 		regulator-always-on;
 		regulator-boot-on;
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
+		regulator-name = "vcc5v0_usb";
 		vin-supply = <&vcc12v_dcin>;
 	};
 
@@ -38,31 +38,31 @@ vcc5v0_usb: regulator-vcc5v0-usb {
 	 */
 	vcc3v0_sd: regulator-vcc3v0-sd {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc3v0_sd";
 		regulator-always-on;
 		regulator-boot-on;
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		regulator-name = "vcc3v0_sd";
 		vin-supply = <&vcc3v3_sys>;
 	};
 
 	vcc3v3_pcie: regulator-vcc3v3-pcie {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc3v3_pcie";
 		regulator-always-on;
 		regulator-boot-on;
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		regulator-name = "vcc3v3_pcie";
 		vin-supply = <&vcc12v_dcin>;
 	};
 
 	vcc12v_pcie: regulator-vcc12v-pcie {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc12v_pcie";
 		regulator-always-on;
 		regulator-boot-on;
 		regulator-min-microvolt = <12000000>;
 		regulator-max-microvolt = <12000000>;
+		regulator-name = "vcc12v_pcie";
 		vin-supply = <&vcc12v_dcin>;
 	};
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
index 6b9aa0e1ad21..3a6277a38a7b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
@@ -76,31 +76,31 @@ sdio_pwrseq: sdio-pwrseq {
 
 	vbus: regulator-vbus {
 		compatible = "regulator-fixed";
-		regulator-name = "vbus";
 		regulator-always-on;
 		regulator-boot-on;
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
+		regulator-name = "vbus";
 	};
 
 	/* sourced from vbus, vbus is provided by the carrier board */
 	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
 		regulator-boot-on;
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
+		regulator-name = "vcc5v0_sys";
 		vin-supply = <&vbus>;
 	};
 
 	vcc3v3_sys: regulator-vcc3v3-sys {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc3v3_sys";
 		regulator-always-on;
 		regulator-boot-on;
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		regulator-name = "vcc3v3_sys";
 		vin-supply = <&vcc5v0_sys>;
 	};
 };
@@ -191,12 +191,12 @@ vdd_cpu: regulator@1c {
 		compatible = "tcs,tcs4525";
 		reg = <0x1c>;
 		fcs,suspend-voltage-selector = <1>;
-		regulator-name = "vdd_cpu";
+		regulator-always-on;
+		regulator-boot-on;
 		regulator-min-microvolt = <800000>;
 		regulator-max-microvolt = <1150000>;
+		regulator-name = "vdd_cpu";
 		regulator-ramp-delay = <2300>;
-		regulator-always-on;
-		regulator-boot-on;
 		vin-supply = <&vcc5v0_sys>;
 
 		regulator-state-mem {
@@ -228,13 +228,14 @@ rk809: pmic@20 {
 
 		regulators {
 			vdd_logic: DCDC_REG1 {
-				regulator-name = "vdd_logic";
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-initial-mode = <0x2>;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
+				regulator-name = "vdd_logic";
 				regulator-ramp-delay = <6001>;
-				regulator-initial-mode = <0x2>;
+
 				regulator-state-mem {
 					regulator-on-in-suspend;
 					regulator-suspend-microvolt = <900000>;
@@ -242,14 +243,15 @@ regulator-state-mem {
 			};
 
 			vdd_gpu: DCDC_REG2 {
-				regulator-name = "vdd_gpu";
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-initial-mode = <0x2>;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
+				regulator-name = "vdd_gpu";
 				regulator-ramp-delay = <6001>;
-				regulator-initial-mode = <0x2>;
-					regulator-state-mem {
+
+				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
 			};
@@ -259,6 +261,7 @@ vcc_ddr: DCDC_REG3 {
 				regulator-boot-on;
 				regulator-initial-mode = <0x2>;
 				regulator-name = "vcc_ddr";
+
 				regulator-state-mem {
 					regulator-on-in-suspend;
 				};
@@ -267,21 +270,23 @@ regulator-state-mem {
 			vdd_npu: DCDC_REG4 {
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-initial-mode = <0x2>;
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <1350000>;
-				regulator-initial-mode = <0x2>;
 				regulator-name = "vdd_npu";
+
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
 			};
 
 			vcc_1v8: DCDC_REG5 {
-				regulator-name = "vcc_1v8";
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc_1v8";
+
 				regulator-state-mem {
 					regulator-on-in-suspend;
 					regulator-suspend-microvolt = <1800000>;
@@ -294,6 +299,7 @@ vdda0v9_image: LDO_REG1 {
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <900000>;
 				regulator-name = "vdda0v9_image";
+
 				regulator-state-mem {
 					regulator-on-in-suspend;
 					regulator-suspend-microvolt = <900000>;
@@ -306,6 +312,7 @@ vdda_0v9: LDO_REG2 {
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <900000>;
 				regulator-name = "vdda_0v9";
+
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
@@ -317,6 +324,7 @@ vdda0v9_pmu: LDO_REG3 {
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <900000>;
 				regulator-name = "vdda0v9_pmu";
+
 				regulator-state-mem {
 					regulator-on-in-suspend;
 					regulator-suspend-microvolt = <900000>;
@@ -329,6 +337,7 @@ vccio_acodec: LDO_REG4 {
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-name = "vccio_acodec";
+
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
@@ -340,6 +349,7 @@ vccio_sd: LDO_REG5 {
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-name = "vccio_sd";
+
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
@@ -351,6 +361,7 @@ vcc3v3_pmu: LDO_REG6 {
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-name = "vcc3v3_pmu";
+
 				regulator-state-mem {
 					regulator-on-in-suspend;
 					regulator-suspend-microvolt = <3300000>;
@@ -363,6 +374,7 @@ vcca_1v8: LDO_REG7 {
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-name = "vcca_1v8";
+
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
@@ -374,6 +386,7 @@ vcca1v8_pmu: LDO_REG8 {
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-name = "vcca1v8_pmu";
+
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
@@ -385,6 +398,7 @@ vcca1v8_image: LDO_REG9 {
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-name = "vcca1v8_image";
+
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
@@ -392,6 +406,7 @@ regulator-state-mem {
 
 			vcc_3v3: SWITCH_REG1 {
 				regulator-name = "vcc_3v3";
+
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
@@ -400,11 +415,11 @@ regulator-state-mem {
 			vcc3v3_sd: SWITCH_REG2 {
 				regulator-name = "vcc3v3_sd";
 				status = "disabled";
+
 				regulator-state-mem {
 					regulator-on-in-suspend;
 				};
 			};
-
 		};
 	};
 };
-- 
2.51.0



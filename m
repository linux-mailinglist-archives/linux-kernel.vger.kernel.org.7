Return-Path: <linux-kernel+bounces-815298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B29DDB56258
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 19:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E9E81BC13EC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 17:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2218B1DFE09;
	Sat, 13 Sep 2025 17:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEQ1S9aI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6261862;
	Sat, 13 Sep 2025 17:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757784917; cv=none; b=AAWlFsDi/qIzROpK0HfkFJzqiyOSyyR1q0zUIgQBaZfTNZzmU8mn4tfvUaVv8/KqrygHz0pptDmGasM8poekp3xbxjUHLl/2MSiLma8Jr5h13m82qjsUg+BqsEQdJPGnf6HBjT7cWV9EhfVxXAe3Wf1/uSkxrTPKYwrfw1TDKEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757784917; c=relaxed/simple;
	bh=EB8xc61kzrIv+z81Dy4COQVDMHHSAI5YL2MIUoN6alo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GrWYe0aSi9kq86fYpWZ+EommlC5U4QUsSQ3PWql+5knmJFHFhTPMkuCVtnXFxTAAL9sd9UINLu7XiVa0PWBsr7XtTjZJWThNjjfB3yqJ+1ShHZIH14jWr+/nHRko3YH4K4BCAhN5VEVNWy9LVoB6vV+yymAbv5r1i6SOFmB4OFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEQ1S9aI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9884CC4CEEB;
	Sat, 13 Sep 2025 17:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757784915;
	bh=EB8xc61kzrIv+z81Dy4COQVDMHHSAI5YL2MIUoN6alo=;
	h=From:To:Cc:Subject:Date:From;
	b=jEQ1S9aIQi9bvZCnhSRPNwTv8I+E+88imr1YvNOT89RGBZxwvsw1OZPHAPjugyN5q
	 zVRhzIUY/UibL0+Y/dnn/XjGYR9Myx6q6cqyANGgyBy5SCsAoSt40a/ifb21og9Zkg
	 vVkR6p6cZwAxukrVR8XCNsm21X0Gz/wLe3sUDinp7NfZ2mnZQ452kJRlMGD45fUaF3
	 0ByL3gX/Ks2zXZS7+miHqpwS2oY1GWmdq7b2sYRnLFAY1RgZvBYVligdOgP1zdZ6G8
	 mIWVqkHQua7GjiKjpu/oNywMtcRbOcD6t79aUyOt4L5uwb5xn22hYS9jo8omqiuviy
	 9Rg+F4NAAsd5Q==
Received: by wens.tw (Postfix, from userid 1000)
	id DAECB5FE35; Sun, 14 Sep 2025 01:35:11 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>
Cc: linux-sunxi@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: allwinner: sun55i: Complete AXP717A sub-functions
Date: Sun, 14 Sep 2025 01:35:11 +0800
Message-Id: <20250913173511.4064176-1-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

When the AXP717A PMIC is missing nodes for the sub-functions, the kernel
complains about not found nodes.

Add all the remaining nodes corresponding to the defined functions for
the dev boards, which have publicly available schematics to base this
change on. The battery charger on all of them are disabled. Also add
an "iio-hwmon" node to express some of the ADC channels as hwmon
sensors.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../dts/allwinner/sun55i-a527-cubie-a5e.dts   | 21 +++++++++++++++++
 .../dts/allwinner/sun55i-t527-avaota-a1.dts   | 23 +++++++++++++++++++
 .../dts/allwinner/sun55i-t527-orangepi-4a.dts | 23 +++++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts b/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
index d3c12a0854b4..e333bbaf01d3 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
@@ -42,6 +42,12 @@ use-led {
 		};
 	};
 
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&axp717_adc 3>, /* vsys_v */
+			      <&axp717_adc 4>; /* pmic_temp */
+	};
+
 	reg_vcc5v: vcc5v {
 		/* board wide 5V supply from the USB-C connector */
 		compatible = "regulator-fixed";
@@ -171,6 +177,17 @@ axp717: pmic@34 {
 		bldoin-supply = <&reg_vcc5v>;
 		cldoin-supply = <&reg_vcc5v>;
 
+		axp717_adc: adc {
+			compatible = "x-powers,axp717-adc";
+			#io-channel-cells = <1>;
+		};
+
+		battery-power {
+			compatible = "x-powers,axp717-battery-power-supply";
+			/* charger mode design but has no battery terminal */
+			status = "disabled";
+		};
+
 		regulators {
 			/* Supplies the "little" cluster (1.4 GHz cores) */
 			reg_dcdc1: dcdc1 {
@@ -276,6 +293,10 @@ reg_cpusldo: cpusldo {
 				regulator-name = "vdd-cpus";
 			};
 		};
+
+		usb-power {
+			compatible = "x-powers,axp717-usb-power-supply";
+		};
 	};
 
 	axp323: pmic@36 {
diff --git a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts b/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
index 7e3d71505744..054d0357c139 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
@@ -28,6 +28,12 @@ ext_osc32k: ext-osc32k-clk {
 		clock-output-names = "ext_osc32k";
 	};
 
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&axp717_adc 3>, /* vsys_v */
+			      <&axp717_adc 4>; /* pmic_temp */
+	};
+
 	reg_vcc12v: vcc12v {
 		/* DC input jack */
 		compatible = "regulator-fixed";
@@ -171,6 +177,17 @@ axp717: pmic@35 {
 		bldoin-supply = <&reg_vcc5v>;
 		cldoin-supply = <&reg_vcc5v>;
 
+		axp717_adc: adc {
+			compatible = "x-powers,axp717-adc";
+			#io-channel-cells = <1>;
+		};
+
+		battery-power {
+			compatible = "x-powers,axp717-battery-power-supply";
+			/* no battery; output used for dcdc4 instead */
+			status = "disabled";
+		};
+
 		regulators {
 			/* Supplies the "little" cluster (1.4 GHz cores) */
 			reg_dcdc1: dcdc1 {
@@ -277,6 +294,12 @@ reg_cpusldo: cpusldo {
 				regulator-name = "vdd-cpus";
 			};
 		};
+
+		usb-power {
+			compatible = "x-powers,axp717-usb-power-supply";
+			/* 12V-5V buck converter can supply up to 5A */
+			input-current-limit-microamp = <3250000>;
+		};
 	};
 
 	axp323: pmic@36 {
diff --git a/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts b/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
index 0a611caa5465..f71860db83d3 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
@@ -41,6 +41,13 @@ led {
 		};
 	};
 
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&axp717_adc 3>, /* vsys_v */
+			      <&axp717_adc 4>, /* pmic_temp */
+			      <&axp717_adc 7>; /* bkup_batt_v */
+	};
+
 	wifi_pwrseq: pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 1 1 GPIO_ACTIVE_LOW>; /* PM1 */
@@ -198,6 +205,17 @@ axp717: pmic@35 {
 		bldoin-supply = <&reg_vcc5v>;
 		cldoin-supply = <&reg_vcc5v>;
 
+		axp717_adc: adc {
+			compatible = "x-powers,axp717-adc";
+			#io-channel-cells = <1>;
+		};
+
+		battery-power {
+			compatible = "x-powers,axp717-battery-power-supply";
+			/* no battery; output used for dcdc4 instead */
+			status = "disabled";
+		};
+
 		regulators {
 			/* Supplies the "little" cluster (1.4 GHz cores) */
 			reg_dcdc1: dcdc1 {
@@ -312,6 +330,11 @@ reg_cpusldo: cpusldo {
 				regulator-name = "vdd-cpus-usb-0v9";
 			};
 		};
+
+		usb-power {
+			compatible = "x-powers,axp717-usb-power-supply";
+			input-current-limit-microamp = <3000000>;
+		};
 	};
 
 	axp323: pmic@36 {
-- 
2.39.5



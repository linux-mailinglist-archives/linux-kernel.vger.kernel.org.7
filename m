Return-Path: <linux-kernel+bounces-815982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24211B56DE7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 03:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFDDE3BBF8C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 01:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3281F3FF8;
	Mon, 15 Sep 2025 01:32:31 +0000 (UTC)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE9916132F;
	Mon, 15 Sep 2025 01:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757899949; cv=none; b=Nscq71gbyKwvBXgoK1sMhORqAcoYbSqSpI8bq3sNC87ycTGdYPVnDtkoszVAQna6CE1PWaXiBA2ucwgs3nK0XUXfM5CoFN3ENAlw3af6i+52SjSZ8dYXXqMEMaYscj9qmKJGgZ6f+/WjcKm5spG6fz5uaLFie9uje+m8NdZ+2Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757899949; c=relaxed/simple;
	bh=q0hl9+HiYO1l8xKcuxfXWUjLBgZZyYQh66so9rdqdkg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=knH97D5y1Woh5YRFCe8qVzByLT3HqVmKpVF+eg92oMDg0oy24cqul961BAETGC7jE8BnN6lYqIkPc0yW02q1Pt7Wwybb1kD5jWPE2/9cZQpGqpcXmpQvyPOW7fm5OLujEhKc61bJrKiOEKJqgHrpfK62CN044BeQ/NN/QacUFJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip4t1757899921t7e843822
X-QQ-Originating-IP: 6E4PpOE9tTwGYmlNY3+a7LG5En3QKmKjUrlgjX3OWaQ=
Received: from [192.168.30.36] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 15 Sep 2025 09:32:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2364366561469396295
EX-QQ-RecipientCnt: 9
From: Xilin Wu <sophon@radxa.com>
Date: Mon, 15 Sep 2025 09:31:44 +0800
Subject: [PATCH v3 2/2] arm64: dts: qcom: qcs6490: Introduce Radxa Dragon
 Q6A
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-radxa-dragon-q6a-v3-2-a6c32d988ed7@radxa.com>
References: <20250915-radxa-dragon-q6a-v3-0-a6c32d988ed7@radxa.com>
In-Reply-To: <20250915-radxa-dragon-q6a-v3-0-a6c32d988ed7@radxa.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757899915; l=24333;
 i=sophon@radxa.com; s=20240424; h=from:subject:message-id;
 bh=q0hl9+HiYO1l8xKcuxfXWUjLBgZZyYQh66so9rdqdkg=;
 b=BFNPqf79oDk6EPy52A9nHXOHiLqxoZeIcWEZf4ZHkCKgeO527uXLKmRvixvM6fqNTsthGJ+pZ
 7ykAn8XqAz0DDLT8u+um8kTbPBJaK5lGylYbD78yfhyMHcxDlU/P5Xr
X-Developer-Key: i=sophon@radxa.com; a=ed25519;
 pk=vPnxeJnlD/PfEbyQPZzaay5ezxI/lMrke7qXy31lSM8=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N2bAIxLK0elnmb6ddLVMynBUz/qisQxQBH/W2nibgLFG5ZJm9lrBu0QZ
	yXJzzonT5jY1wlwqWne+tsbFzXEgwxY52NdTp0gGyFu0RXkHz/Nt8zd6/1kHaa/7EMF5Dr7
	f+HASgLCP0+i1+7w6661K0wjhwrwj7NHJMomelCcrnqcxvxsHTrHO15MbKItTBCQ5ViyDR1
	v38sgJ/lh9O1lUC2KA3xhw+Ol6L2BhcDIuFYRTp1pif1SnEgi6mT59LLpN8KY99R5ygoBKS
	aStFQWxlpekgy+CHFlv+lVJdNIZ4B1ydMX+i3mm/DNwbbOZCL6VDoB3hz1w7fbyUR3Ckcyc
	MvVFJ/oR74LeY1iO2TX+qNNUNkpRrPOD8HEXap4zKVBJCwkKyPBq1hT31d1ZCVViFLKzus5
	qAwq9so4KSeMxFgBPipFQRnkBqwJTuZX+kzso8Bg+CmbjfH8rewikyNGAcnIVpunMTDrUqC
	QJVwQdNvR5x8YxmBTT2n1W4c1rWHWz6ks8VCPSwSVngs/yFsAGe2jPkeZZHaQWKY5PXhND+
	Eolnqo6n9tMNhPMK55bHqKbARL+1x5xngMiug0hAzvLP9r8Kn+8XE81x/9uMKtQ37R9yC/S
	voygEtsKymtk3rp92UZhMzyH0UZDqRCLL+hXAryFN2GotSTn5XicViy2d1Iv9deJPVT8821
	TEepBEulZrlX2XTdbK2i3dVFi6PxDWpG/kszwbjaPsktCvU8uBmBQe3Rws+opDfn5KfN8sV
	m+VWaZaXGn6SIo1N9hp9vDgXGxUnsYr1MtpkX7lFtOo7S79rp7ek9gj2rSNk1SvA7lX1Zac
	xDIE4ATYlvnHztyrNCSmc/3LN97px0kJVModsoVkh+wiiMt+04/5seCwLGoqK8JoPwZ9l++
	GnPCw3KbQnTpPdyWlvljyFFEQaXP73CglljL+Dx/ju1ZW8xNQnQgq7lzTwxMYXE6t4mv54C
	+x4nU5gdWVJrBV6X6Mx910O3pwF04N/c2T++Q5FeKlpV4wuYR/+ZQyEdD
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Radxa Dragon Q6A is a single board computer, based on the Qualcomm
QCS6490 platform.

Features enabled and working:

- Three USB-A 2.0 ports
- RTL8111K Ethernet connected to PCIe0
- eMMC module
- SD card
- M.2 M-Key 2230 PCIe 3.0 x2
- Headphone jack
- Onboard thermal sensors
- QSPI controller for updating boot firmware
- ADSP remoteproc (Type-C and charging features disabled in firmware)
- CDSP remoteproc (for AI applications using QNN)
- Venus video encode and decode accelerator

Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 arch/arm64/boot/dts/qcom/Makefile                  |   1 +
 .../boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts     | 961 +++++++++++++++++++++
 2 files changed, 962 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 5b52f9e4e5f31ac5a398d0762337a0a31af1f4dd..3a246adb0c435d7b08dda404ed2bcb2a9c8c48b0 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -120,6 +120,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcm6490-shift-otter.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs615-ride.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-radxa-dragon-q6a.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-rb3gen2.dtb
 
 qcs6490-rb3gen2-vision-mezzanine-dtbs := qcs6490-rb3gen2.dtb qcs6490-rb3gen2-vision-mezzanine.dtbo
diff --git a/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts b/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
new file mode 100644
index 0000000000000000000000000000000000000000..85465702279efb7ab324baea0663bdbdbd5fb5ac
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
@@ -0,0 +1,961 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2025 Radxa Computer (Shenzhen) Co., Ltd.
+ */
+
+/dts-v1/;
+
+/* PM7250B is configured to use SID8/9 */
+#define PM7250B_SID 8
+#define PM7250B_SID1 9
+
+#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
+#include <dt-bindings/iio/qcom,spmi-adc7-pm7325.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include "sc7280.dtsi"
+#include "pm7250b.dtsi"
+#include "pm7325.dtsi"
+#include "pm8350c.dtsi" /* PM7350C */
+#include "pmk8350.dtsi" /* PMK7325 */
+#include "qcs6490-audioreach.dtsi"
+
+/delete-node/ &adsp_mem;
+/delete-node/ &cdsp_mem;
+/delete-node/ &ipa_fw_mem;
+/delete-node/ &mpss_mem;
+/delete-node/ &remoteproc_mpss;
+/delete-node/ &remoteproc_wpss;
+/delete-node/ &rmtfs_mem;
+/delete-node/ &video_mem;
+/delete-node/ &wifi;
+/delete-node/ &wlan_ce_mem;
+/delete-node/ &wlan_fw_mem;
+/delete-node/ &wpss_mem;
+/delete-node/ &xbl_mem;
+
+/ {
+	model = "Radxa Dragon Q6A";
+	compatible = "radxa,dragon-q6a", "qcom,qcm6490";
+	chassis-type = "embedded";
+
+	aliases {
+		mmc0 = &sdhc_1;
+		mmc1 = &sdhc_2;
+		serial0 = &uart5;
+	};
+
+	wcd938x: audio-codec {
+		compatible = "qcom,wcd9380-codec";
+
+		pinctrl-0 = <&wcd_default>;
+		pinctrl-names = "default";
+
+		reset-gpios = <&tlmm 83 GPIO_ACTIVE_LOW>;
+
+		vdd-rxtx-supply = <&vreg_l18b_1p8>;
+		vdd-io-supply = <&vreg_l18b_1p8>;
+		vdd-buck-supply = <&vreg_l17b_1p8>;
+		vdd-mic-bias-supply = <&vreg_bob_3p296>;
+
+		qcom,micbias1-microvolt = <1800000>;
+		qcom,micbias2-microvolt = <1800000>;
+		qcom,micbias3-microvolt = <1800000>;
+		qcom,micbias4-microvolt = <1800000>;
+		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
+		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
+		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
+		qcom,rx-device = <&wcd_rx>;
+		qcom,tx-device = <&wcd_tx>;
+
+		qcom,hphl-jack-type-normally-closed;
+
+		#sound-dai-cells = <1>;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		pinctrl-0 = <&user_led>;
+		pinctrl-names = "default";
+
+		user-led {
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_HEARTBEAT;
+			gpios = <&tlmm 42 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	reserved-memory {
+		xbl_mem: xbl@80700000 {
+			reg = <0x0 0x80700000 0x0 0x100000>;
+			no-map;
+		};
+
+		cdsp_secure_heap_mem: cdsp-secure-heap@81800000 {
+			reg = <0x0 0x81800000 0x0 0x1e00000>;
+			no-map;
+		};
+
+		camera_mem: camera@84300000 {
+			reg = <0x0 0x84300000 0x0 0x500000>;
+			no-map;
+		};
+
+		adsp_mem: adsp@84800000 {
+			reg = <0x0 0x84800000 0x0 0x2800000>;
+			no-map;
+		};
+
+		cdsp_mem: cdsp@87000000 {
+			reg = <0x0 0x87000000 0x0 0x1e00000>;
+			no-map;
+		};
+
+		video_mem: video@88e00000 {
+			reg = <0x0 0x88e00000 0x0 0x700000>;
+			no-map;
+		};
+
+		cvp_mem: cvp@89500000 {
+			reg = <0x0 0x89500000 0x0 0x500000>;
+			no-map;
+		};
+
+		gpu_microcode_mem: gpu-microcode@89a00000 {
+			reg = <0x0 0x89a00000 0x0 0x2000>;
+			no-map;
+		};
+
+		tz_stat_mem: tz-stat@c0000000 {
+			reg = <0x0 0xc0000000 0x0 0x100000>;
+			no-map;
+		};
+
+		tags_mem: tags@c0100000 {
+			reg = <0x0 0xc0100000 0x0 0x1200000>;
+			no-map;
+		};
+
+		qtee_mem: qtee@c1300000 {
+			reg = <0x0 0xc1300000 0x0 0x500000>;
+			no-map;
+		};
+
+		trusted_apps_mem: trusted-apps@c1800000 {
+			reg = <0x0 0xc1800000 0x0 0x1c00000>;
+			no-map;
+		};
+
+		debug_vm_mem: debug-vm@d0600000 {
+			reg = <0x0 0xd0600000 0x0 0x100000>;
+			no-map;
+		};
+	};
+
+	thermal-zones {
+		msm-skin-thermal {
+			polling-delay-passive = <0>;
+			thermal-sensors = <&pmk8350_adc_tm 2>;
+		};
+
+		quiet-thermal {
+			polling-delay-passive = <0>;
+			thermal-sensors = <&pmk8350_adc_tm 1>;
+		};
+
+		ufs-thermal {
+			polling-delay-passive = <0>;
+			thermal-sensors = <&pmk8350_adc_tm 3>;
+		};
+
+		xo-thermal {
+			polling-delay-passive = <0>;
+			thermal-sensors = <&pmk8350_adc_tm 0>;
+		};
+	};
+
+	vcc_1v8: regulator-vcc-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_5v_peri>;
+
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	vcc_3v3: regulator-vcc-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_5v_peri>;
+
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	vcc_5v_peri: regulator-vcc-5v-peri {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_5v_peri";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vph_pwr>;
+
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	vph_pwr: regulator-vph-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
+
+&apps_rsc {
+	regulators-0 {
+		compatible = "qcom,pm7325-rpmh-regulators";
+		qcom,pmic-id = "b";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+		vdd-s7-supply = <&vph_pwr>;
+		vdd-s8-supply = <&vph_pwr>;
+		vdd-l1-l4-l12-l15-supply = <&vreg_s7b_0p536>;
+		vdd-l2-l7-supply = <&vreg_bob_3p296>;
+		vdd-l3-supply = <&vreg_s2b_0p572>;
+		vdd-l5-supply = <&vreg_s2b_0p572>;
+		vdd-l6-l9-l10-supply = <&vreg_s8b_1p2>;
+		vdd-l8-supply = <&vreg_s7b_0p536>;
+		vdd-l11-l17-l18-l19-supply = <&vreg_s1b_1p84>;
+		vdd-l13-supply = <&vreg_s7b_0p536>;
+		vdd-l14-l16-supply = <&vreg_s8b_1p2>;
+
+		vreg_s1b_1p84: smps1 {
+			regulator-name = "vreg_s1b_1p84";
+			regulator-min-microvolt = <1840000>;
+			regulator-max-microvolt = <2040000>;
+		};
+
+		vreg_s2b_0p572: smps2 {
+			regulator-name = "vreg_s2b_0p572";
+			regulator-min-microvolt = <572000>;
+			regulator-max-microvolt = <1048000>;
+		};
+
+		vreg_s7b_0p536: smps7 {
+			regulator-name = "vreg_s7b_0p536";
+			regulator-min-microvolt = <536000>;
+			regulator-max-microvolt = <1120000>;
+		};
+
+		vreg_s8b_1p2: smps8 {
+			regulator-name = "vreg_s8b_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1496000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_RET>;
+		};
+
+		vreg_l1b_0p912: ldo1 {
+			regulator-name = "vreg_l1b_0p912";
+			regulator-min-microvolt = <832000>;
+			regulator-max-microvolt = <920000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+							RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2b_3p072: ldo2 {
+			regulator-name = "vreg_l2b_3p072";
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <3544000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+							RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l6b_1p2: ldo6 {
+			regulator-name = "vreg_l6b_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1256000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+							RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7b_2p96: ldo7 {
+			regulator-name = "vreg_l7b_2p96";
+			regulator-min-microvolt = <2960000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+							RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l9b_1p2: ldo9 {
+			regulator-name = "vreg_l9b_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l17b_1p8: ldo17 {
+			regulator-name = "vreg_l17b_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1896000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l18b_1p8: ldo18 {
+			regulator-name = "vreg_l18b_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
+		};
+
+		vreg_l19b_1p8: ldo19 {
+			regulator-name = "vreg_l19b_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-1 {
+		compatible = "qcom,pm8350c-rpmh-regulators";
+		qcom,pmic-id = "c";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+		vdd-s7-supply = <&vph_pwr>;
+		vdd-s8-supply = <&vph_pwr>;
+		vdd-s9-supply = <&vph_pwr>;
+		vdd-s10-supply = <&vph_pwr>;
+		vdd-l1-l12-supply = <&vreg_s1b_1p84>;
+		vdd-l2-l8-supply = <&vreg_s1b_1p84>;
+		vdd-l3-l4-l5-l7-l13-supply = <&vreg_bob_3p296>;
+		vdd-l6-l9-l11-supply = <&vreg_bob_3p296>;
+		vdd-l10-supply = <&vreg_s7b_0p536>;
+		vdd-bob-supply = <&vph_pwr>;
+
+		vreg_l1c_1p8: ldo1 {
+			regulator-name = "vreg_l1c_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1976000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l6c_2p96: ldo6 {
+			regulator-name = "vreg_l6c_2p96";
+			regulator-min-microvolt = <1650000>;
+			regulator-max-microvolt = <3544000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l9c_2p96: ldo9 {
+			regulator-name = "vreg_l9c_2p96";
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <3544000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l10c_0p88: ldo10 {
+			regulator-name = "vreg_l10c_0p88";
+			regulator-min-microvolt = <720000>;
+			regulator-max-microvolt = <1048000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_bob_3p296: bob {
+			regulator-name = "vreg_bob_3p296";
+			regulator-min-microvolt = <3032000>;
+			regulator-max-microvolt = <3960000>;
+		};
+	};
+};
+
+&gcc {
+	protected-clocks = <GCC_CFG_NOC_LPASS_CLK>,
+			   <GCC_MSS_CFG_AHB_CLK>,
+			   <GCC_MSS_GPLL0_MAIN_DIV_CLK_SRC>,
+			   <GCC_MSS_OFFLINE_AXI_CLK>,
+			   <GCC_MSS_Q6SS_BOOT_CLK_SRC>,
+			   <GCC_MSS_Q6_MEMNOC_AXI_CLK>,
+			   <GCC_MSS_SNOC_AXI_CLK>,
+			   <GCC_SEC_CTRL_CLK_SRC>,
+			   <GCC_WPSS_AHB_BDG_MST_CLK>,
+			   <GCC_WPSS_AHB_CLK>,
+			   <GCC_WPSS_RSCP_CLK>;
+};
+
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/qcs6490/a660_zap.mbn";
+};
+
+&lpass_audiocc {
+	compatible = "qcom,qcm6490-lpassaudiocc";
+	/delete-property/ power-domains;
+};
+
+&lpass_rx_macro {
+	status = "okay";
+};
+
+&lpass_tx_macro {
+	status = "okay";
+};
+
+&lpass_va_macro {
+	status = "okay";
+};
+
+&pcie0 {
+	perst-gpios = <&tlmm 87 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 89 GPIO_ACTIVE_HIGH>;
+
+	pinctrl-0 = <&pcie0_clkreq_n>, <&pcie0_reset_n>, <&pcie0_wake_n>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&pcie0_phy {
+	vdda-phy-supply = <&vreg_l10c_0p88>;
+	vdda-pll-supply = <&vreg_l6b_1p2>;
+
+	status = "okay";
+};
+
+&pcie1 {
+	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 3 GPIO_ACTIVE_HIGH>;
+
+	pinctrl-0 = <&pcie1_clkreq_n>, <&pcie1_reset_n>, <&pcie1_wake_n>;
+	pinctrl-names = "default";
+
+	/* Support for QPS615 PCIe switch */
+	iommu-map = <0x0 &apps_smmu 0x1c80 0x1>,
+		    <0x100 &apps_smmu 0x1c81 0x1>,
+		    <0x208 &apps_smmu 0x1c84 0x1>,
+		    <0x210 &apps_smmu 0x1c85 0x1>,
+		    <0x218 &apps_smmu 0x1c86 0x1>,
+		    <0x300 &apps_smmu 0x1c87 0x1>,
+		    <0x400 &apps_smmu 0x1c88 0x1>,
+		    <0x500 &apps_smmu 0x1c89 0x1>,
+		    <0x501 &apps_smmu 0x1c90 0x1>;
+
+	status = "okay";
+};
+
+&pcie1_phy {
+	vdda-phy-supply = <&vreg_l10c_0p88>;
+	vdda-pll-supply = <&vreg_l6b_1p2>;
+
+	status = "okay";
+};
+
+&pm7325_gpios {
+	pm7325_adc_default: adc-default-state {
+		pins = "gpio2";
+		function = PMIC_GPIO_FUNC_NORMAL;
+		bias-high-impedance;
+	};
+};
+
+&pm7325_temp_alarm {
+	io-channels = <&pmk8350_vadc PM7325_ADC7_DIE_TEMP>;
+	io-channel-names = "thermal";
+};
+
+&pmk8350_adc_tm {
+	status = "okay";
+
+	xo-therm@0 {
+		reg = <0>;
+		io-channels = <&pmk8350_vadc PMK8350_ADC7_AMUX_THM1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+
+	quiet-therm@1 {
+		reg = <1>;
+		io-channels = <&pmk8350_vadc PM7325_ADC7_AMUX_THM1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+
+	msm-skin-therm@2 {
+		reg = <2>;
+		io-channels = <&pmk8350_vadc PM7325_ADC7_AMUX_THM3_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+
+	ufs-therm@3 {
+		reg = <3>;
+		io-channels = <&pmk8350_vadc PM7325_ADC7_GPIO1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+};
+
+&pmk8350_vadc {
+	pinctrl-0 = <&pm7325_adc_default>;
+	pinctrl-names = "default";
+
+	channel@3 {
+		reg = <PMK8350_ADC7_DIE_TEMP>;
+		label = "pmk7325_die_temp";
+		qcom,pre-scaling = <1 1>;
+	};
+
+	channel@44 {
+		reg = <PMK8350_ADC7_AMUX_THM1_100K_PU>;
+		label = "xo_therm";
+		qcom,hw-settle-time = <200>;
+		qcom,pre-scaling = <1 1>;
+		qcom,ratiometric;
+	};
+
+	channel@103 {
+		reg = <PM7325_ADC7_DIE_TEMP>;
+		label = "pm7325_die_temp";
+		qcom,pre-scaling = <1 1>;
+	};
+
+	channel@144 {
+		reg = <PM7325_ADC7_AMUX_THM1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,pre-scaling = <1 1>;
+		label = "quiet_therm";
+	};
+
+	channel@146 {
+		reg = <PM7325_ADC7_AMUX_THM3_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,pre-scaling = <1 1>;
+		label = "msm_skin_therm";
+	};
+
+	channel@14a {
+		/* According to datasheet, 0x4a = AMUX1_GPIO = GPIO_02 */
+		reg = <PM7325_ADC7_GPIO1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,pre-scaling = <1 1>;
+		label = "ufs_therm";
+	};
+};
+
+&pon_pwrkey {
+	status = "okay";
+};
+
+&qspi {
+	/* It's not possible to use QSPI with iommu */
+	/* due to an error in qcom_smmu_write_s2cr */
+	/delete-property/ iommus;
+
+	pinctrl-0 = <&qspi_clk>, <&qspi_cs0>, <&qspi_data0>,
+				<&qspi_data1>, <&qspi_data23>;
+	pinctrl-1 = <&qspi_sleep>;
+	pinctrl-names = "default", "sleep";
+
+	status = "okay";
+
+	spi_flash: flash@0 {
+		compatible = "winbond,w25q256", "jedec,spi-nor";
+		reg = <0>;
+
+		spi-max-frequency = <104000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
+&qupv3_id_0 {
+	status = "okay";
+};
+
+&remoteproc_adsp {
+	firmware-name = "qcom/qcs6490/radxa/dragon-q6a/adsp.mbn";
+	status = "okay";
+};
+
+&remoteproc_cdsp {
+	firmware-name = "qcom/qcs6490/radxa/dragon-q6a/cdsp.mbn";
+	status = "okay";
+};
+
+&sdhc_1 {
+	non-removable;
+	no-sd;
+	no-sdio;
+
+	vmmc-supply = <&vreg_l7b_2p96>;
+	vqmmc-supply = <&vreg_l19b_1p8>;
+
+	status = "okay";
+};
+
+&sdhc_2 {
+	pinctrl-0 = <&sdc2_clk>, <&sdc2_cmd>, <&sdc2_data>, <&sd_cd>;
+	pinctrl-1 = <&sdc2_clk_sleep>, <&sdc2_cmd_sleep>, <&sdc2_data_sleep>, <&sd_cd>;
+
+	vmmc-supply = <&vreg_l9c_2p96>;
+	vqmmc-supply = <&vreg_l6c_2p96>;
+
+	cd-gpios = <&tlmm 91 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&sound {
+	compatible = "qcom,qcs6490-rb3gen2-sndcard";
+	model = "QCS6490-Radxa-Dragon-Q6A";
+
+	audio-routing =
+		"IN1_HPHL", "HPHL_OUT",
+		"IN2_HPHR", "HPHR_OUT",
+		"AMIC2", "MIC BIAS2",
+		"TX SWR_ADC1", "ADC2_OUTPUT";
+
+	wcd-playback-dai-link {
+		link-name = "WCD Playback";
+
+		codec {
+			sound-dai = <&wcd938x 0>, <&swr0 0>, <&lpass_rx_macro 0>;
+		};
+
+		cpu {
+			sound-dai = <&q6apmbedai RX_CODEC_DMA_RX_0>;
+		};
+
+		platform {
+			sound-dai = <&q6apm>;
+		};
+	};
+
+	wcd-capture-dai-link {
+		link-name = "WCD Capture";
+
+		codec {
+			sound-dai = <&wcd938x 1>, <&swr1 0>, <&lpass_tx_macro 0>;
+		};
+
+		cpu {
+			sound-dai = <&q6apmbedai TX_CODEC_DMA_TX_3>;
+		};
+
+		platform {
+			sound-dai = <&q6apm>;
+		};
+	};
+};
+
+&swr0 {
+	status = "okay";
+
+	wcd_rx: codec@0,4 {
+		compatible = "sdw20217010d00";
+		reg = <0 4>;
+		qcom,rx-port-mapping = <1 2 3 4 5>;
+	};
+};
+
+&swr1 {
+	status = "okay";
+
+	wcd_tx: codec@0,3 {
+		compatible = "sdw20217010d00";
+		reg = <0 3>;
+		qcom,tx-port-mapping = <1 1 2 3>;
+	};
+};
+
+&tlmm {
+	gpio-line-names =
+		/* GPIO_0 ~ GPIO_3 */
+		"PIN_13", "PIN_15", "", "",
+		/* GPIO_4 ~ GPIO_7 */
+		"", "", "", "",
+		/* GPIO_8 ~ GPIO_11 */
+		"PIN_27", "PIN_28", "", "",
+		/* GPIO_12 ~ GPIO_15 */
+		"", "", "", "",
+		/* GPIO_16 ~ GPIO_19 */
+		"", "", "", "",
+		/* GPIO_20 ~ GPIO_23 */
+		"", "", "PIN_8", "PIN_10",
+		/* GPIO_24 ~ GPIO_27 */
+		"PIN_3", "PIN_5", "PIN_16", "PIN_27",
+		/* GPIO_28 ~ GPIO_31 */
+		"PIN_31", "PIN_11", "PIN_32", "PIN_29",
+		/* GPIO_32 ~ GPIO_35 */
+		"", "", "", "",
+		/* GPIO_36 ~ GPIO_39 */
+		"", "", "", "",
+		/* GPIO_40 ~ GPIO_43 */
+		"", "", "", "",
+		/* GPIO_44 ~ GPIO_47 */
+		"", "", "", "",
+		/* GPIO_48 ~ GPIO_51 */
+		"PIN_21", "PIN_19", "PIN_23", "PIN_24",
+		/* GPIO_52 ~ GPIO_55 */
+		"", "", "", "PIN_26",
+		/* GPIO_56 ~ GPIO_59 */
+		"PIN_33", "PIN_22", "PIN_37", "PIN_36",
+		/* GPIO_60 ~ GPIO_63 */
+		"", "", "", "",
+		/* GPIO_64 ~ GPIO_67 */
+		"", "", "", "",
+		/* GPIO_68 ~ GPIO_71 */
+		"", "", "", "",
+		/* GPIO_72 ~ GPIO_75 */
+		"", "", "", "",
+		/* GPIO_76 ~ GPIO_79 */
+		"", "", "", "",
+		/* GPIO_80 ~ GPIO_83 */
+		"", "", "", "",
+		/* GPIO_84 ~ GPIO_87 */
+		"", "", "", "",
+		/* GPIO_88 ~ GPIO_91 */
+		"", "", "", "",
+		/* GPIO_92 ~ GPIO_95 */
+		"", "", "", "",
+		/* GPIO_96 ~ GPIO_99 */
+		"PIN_7", "PIN_12", "PIN_38", "PIN_40",
+		/* GPIO_100 ~ GPIO_103 */
+		"PIN_35", "", "", "",
+		/* GPIO_104 ~ GPIO_107 */
+		"", "", "", "",
+		/* GPIO_108 ~ GPIO_111 */
+		"", "", "", "",
+		/* GPIO_112 ~ GPIO_115 */
+		"", "", "", "",
+		/* GPIO_116 ~ GPIO_119 */
+		"", "", "", "",
+		/* GPIO_120 ~ GPIO_123 */
+		"", "", "", "",
+		/* GPIO_124 ~ GPIO_127 */
+		"", "", "", "",
+		/* GPIO_128 ~ GPIO_131 */
+		"", "", "", "",
+		/* GPIO_132 ~ GPIO_135 */
+		"", "", "", "",
+		/* GPIO_136 ~ GPIO_139 */
+		"", "", "", "",
+		/* GPIO_140 ~ GPIO_143 */
+		"", "", "", "",
+		/* GPIO_144 ~ GPIO_147 */
+		"", "", "", "",
+		/* GPIO_148 ~ GPIO_151 */
+		"", "", "", "",
+		/* GPIO_152 ~ GPIO_155 */
+		"", "", "", "",
+		/* GPIO_156 ~ GPIO_159 */
+		"", "", "", "",
+		/* GPIO_160 ~ GPIO_163 */
+		"", "", "", "",
+		/* GPIO_164 ~ GPIO_167 */
+		"", "", "", "",
+		/* GPIO_168 ~ GPIO_171 */
+		"", "", "", "",
+		/* GPIO_172 ~ GPIO_174 */
+		"", "", "";
+
+	pcie0_reset_n: pcie0-reset-n-state {
+		pins = "gpio87";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	pcie0_wake_n: pcie0-wake-n-state {
+		pins = "gpio89";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
+	pcie1_reset_n: pcie1-reset-n-state {
+		pins = "gpio2";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	pcie1_wake_n: pcie1-wake-n-state {
+		pins = "gpio3";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
+	qspi_sleep: qspi-sleep-state {
+		pins = "gpio12", "gpio13", "gpio14", "gpio15", "gpio16", "gpio17";
+		function = "gpio";
+		output-disable;
+	};
+
+	sd_cd: sd-cd-state {
+		pins = "gpio91";
+		function = "gpio";
+		bias-pull-up;
+	};
+
+	user_led: user-led-state {
+		pins = "gpio42";
+		function = "gpio";
+		bias-pull-up;
+	};
+
+	wcd_default: wcd-reset-n-active-state {
+		pins = "gpio83";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+		output-low;
+	};
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&usb_2 {
+	dr_mode = "host";
+
+	status = "okay";
+};
+
+&usb_2_hsphy {
+	status = "okay";
+
+	vdda-pll-supply = <&vreg_l10c_0p88>;
+	vdda33-supply = <&vreg_l2b_3p072>;
+	vdda18-supply = <&vreg_l1c_1p8>;
+};
+
+&venus {
+	status = "okay";
+};
+
+/* PINCTRL - additions to nodes defined in sc7280.dtsi */
+&pcie0_clkreq_n {
+	bias-pull-up;
+	drive-strength = <2>;
+};
+
+&pcie1_clkreq_n {
+	bias-pull-up;
+	drive-strength = <2>;
+};
+
+&qspi_clk {
+	bias-disable;
+	drive-strength = <16>;
+};
+
+&qspi_cs0 {
+	bias-disable;
+	drive-strength = <8>;
+};
+
+&qspi_data0 {
+	bias-disable;
+	drive-strength = <8>;
+};
+
+&qspi_data1 {
+	bias-disable;
+	drive-strength = <8>;
+};
+
+&qspi_data23 {
+	bias-disable;
+	drive-strength = <8>;
+};
+
+&sdc1_clk {
+	bias-disable;
+	drive-strength = <16>;
+};
+
+&sdc1_cmd {
+	bias-pull-up;
+	drive-strength = <10>;
+};
+
+&sdc1_data {
+	bias-pull-up;
+	drive-strength = <10>;
+};
+
+&sdc1_rclk {
+	bias-pull-down;
+};
+
+&sdc2_clk {
+	bias-disable;
+	drive-strength = <16>;
+};
+
+&sdc2_cmd {
+	bias-pull-up;
+	drive-strength = <10>;
+};
+
+&sdc2_data {
+	bias-pull-up;
+	drive-strength = <10>;
+};

-- 
2.51.0



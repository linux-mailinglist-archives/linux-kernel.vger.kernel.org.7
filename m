Return-Path: <linux-kernel+bounces-785878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB76B35215
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 05:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D331E1A8338F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 03:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891402D061F;
	Tue, 26 Aug 2025 03:11:03 +0000 (UTC)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FA32D0610;
	Tue, 26 Aug 2025 03:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756177862; cv=none; b=HTSNRa20IVbIpeLRCLwNfT6C/PR6B64wfAR2zbUTYngRJIahgbZN1JQFo8eIlLXX6tTtr0sqoRvjNO0afyOhu4y+VeDNLBKHSuQIQL2/pyJIEktiXjkb5bNUIruUjQaH/qJUMKnhEl99KdG+QTdMnZr8vJomN+yMkS2ulZm87OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756177862; c=relaxed/simple;
	bh=YzJMLDxAushpAlNsIMfY5BrMNazimipz05GS6VIYCDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JdlCcrjqJVdAnKwXFDvm1nD4z6n/D6JgDtREqYriaLzCayfzXzOjTTaaqWfQ04BKesoSoIDRHx+tXhqq6+jWTa+ifvHCf+kxR3xa8+aEmi1AayPYSWlonnllr6Q24IzSvmpIqCbq87jFbAtgtrf1Tg+ri6oQjBIuLGwNZeXRUM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chainsx.cn; spf=pass smtp.mailfrom=chainsx.cn; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chainsx.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chainsx.cn
X-QQ-mid: zesmtpip4t1756177713t2f806c7e
X-QQ-Originating-IP: CFY/VlRAp4XP+vNcw8zDMKLS9Bbn27r7iYO3W50w2z4=
Received: from chainsx-ubuntu-server.lan ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 26 Aug 2025 11:08:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6620851631864477297
EX-QQ-RecipientCnt: 11
From: Hsun Lai <i@chainsx.cn>
To: Fred Bloggs <f.blogs@napier.co.nz>
Cc: Hsun Lai <i@chainsx.cn>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v2 2/2] arm64: dts: rockchip: add DTs for 100ASK DShanPi A1
Date: Tue, 26 Aug 2025 11:08:17 +0800
Message-Id: <20250826030818.3485927-3-i@chainsx.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826030818.3485927-1-i@chainsx.cn>
References: <20250826030818.3485927-1-i@chainsx.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:chainsx.cn:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NWbLsQpranWg40Aupnu7LVJ/n+uzxUr2lH7h60t4dt7VLX7TY7xSYRAR
	cl48sPh0KWjiByBg3jkoK3equK+ZJEuufdoVRBjRQZUg783p19/v0sjynCEDVQWZxMRBNBx
	XJLGaAsKM/gkujWbc560IfUsX6EJstWweRSq0UsoW5rqmA5macUXfLcle44DgjtKWj4c+fD
	FPb0T68jdlUCKEedIFr30Lj173DBT2e68AlCbYs1aYPZHc9y0FBk+aIHtYBOk4gdsUf7dMw
	b53vlPlzDYQLqxm+t+nq9YX3gur9ji35tl5JMalPD5uE93l/1EmLhG55RJQsNxgwUJ9XX5W
	uZYE+b2MvLBVzCUO24KSG4AW6TMPej3StgMJY+2D9pa/1ZeF6NjtGa3jSS/P7I//7YDrg0h
	4xVojv9GJAu59w6Dhhar5ptS+DvTRmqMYntFGOujY5+i+DueHBYM1pZcPpOlJvI/jhDf2L8
	pr3Kgw32YjiM6TpW2bdKkE1bS1xI6yOJPt0DWgcyFoVg6g1DyF1ao8BAWfn1pY2KRuknYMT
	TWR9Tb6BHuVhSNb98UXOHF9XlS1W/8vOEu4stKVbEq+zXelunfmc5rryzThm2oUujaoX5l+
	dHHB97SZ2PnrJflMb3yjI0I9tt2tAzfZv2IHNtB2axocZg3zKzwE6XXv5xPujVXTaFX82Xg
	w2TqIIF6eGb4JbD1cdNLyc0Lx46PpecmsX24Oh32R9Scqpk1TooDeI90pSDoYfuN5FY6vU6
	77ZOoyVnL+A0amg34fgJ2+9UtMakQUqkRVZmBXqz04tGIg5cfM9ErqlaFEITQKVAxaYcuDV
	G9JpIsjZIaKON+8MFJlIDj8uNwteKgc28awPoI3kXUwaNv40zrZ4ByHh1rWQUxsGPpElsFm
	+MDO998wkmUHeyIT7JdVLTEJXM7Zj93IpAZWDUJk5DKyQJ2RB3778XLrxBAxk9cLqBEgWj9
	EbGzqr6EyQFz+HwUxBBFdDr4pnONljTSRH9IfIseIu/EJyTsImYvdAwC0ZQXh9QGMlanVSZ
	9axERdjsYFkxwY/4rlFY50AJgQLFKFU0dGB3oyLlbdQKEbNQJnTfvZO9YkDAFvL5aqf0g6t
	F1TEH1fjEgMmUUiXYlPASA=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Add device tree for 100ASK DShanPi A1 with Rockchip RK3576 SoC
(4x Cortex-A72, 4x Cortex-A53, Mali-G52 MC3 GPU, 6 TOPS NPU). Enables
basic booting and connectivity.

Link: https://wiki.dshanpi.org/en/docs/DshanPi-A1/intro/

The device contains the following hardware that is tested/working:
 - 32 or 64GB eMMC
 - SDMMC card slot
 - M.2 WiFi slot
 - 4 or 8GB of RAM
 - 2x 1Gbps Ethernet
 - 2x USB 3.2 Gen 1 Type-A ports
 - USB 3.0 port
 - HDMI port
 - RTC with HYM8563TS

Signed-off-by: Hsun Lai <i@chainsx.cn>

---

Changes in v2:
- Delete the pwm include file (Chukun Pan, v1)
- Fix vcc3v3_pcie gpios (Chukun Pan, v1)
- Adjust the order of some nodes (Chukun Pan, v1)
- Fix sdmmc (Chukun Pan, v1)
- Add phy-supply for u2phy0_otg (Chukun Pan, v1)

Changes in v1:
- Add support for 100ASK DShanPi A1

 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../dts/rockchip/rk3576-100ask-dshanpi-a1.dts | 838 ++++++++++++++++++
 2 files changed, 839 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 099520962..2a8a8f263 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -144,6 +144,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-rock-3b.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5-display-vz.dtbo
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5-io-expander.dtbo
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-100ask-dshanpi-a1.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-armsom-sige5.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-armsom-sige5-v1.2-wifibt.dtbo
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-evb1-v10.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dts b/arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dts
new file mode 100644
index 000000000..4c4e17d2f
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dts
@@ -0,0 +1,838 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2024 Rockchip Electronics Co., Ltd.
+ *
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/soc/rockchip,vop2.h>
+#include "rk3576.dtsi"
+
+/ {
+	model = "100ASK DshanPi A1 board";
+	compatible = "100ask,dshanpi-a1", "rockchip,rk3576";
+
+	aliases {
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
+	};
+
+	chosen {
+		stdout-path = "serial0:1500000n8";
+	};
+
+	es8388_sound: es8388-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,mclk-fs = <256>;
+		simple-audio-card,name = "On-board Analog ES8388";
+		simple-audio-card,widgets = "Microphone", "Headphone Mic",
+					    "Microphone", "Mic Pads",
+					    "Headphone", "Headphone",
+					    "Line Out", "Line Out";
+		simple-audio-card,routing = "Headphone", "LOUT1",
+					    "Headphone", "ROUT1",
+					    "Line Out", "LOUT2",
+					    "Line Out", "ROUT2",
+					    "RINPUT1", "Headphone Mic",
+					    "LINPUT2", "Mic Pads",
+					    "RINPUT2", "Mic Pads";
+		simple-audio-card,pin-switches = "Headphone", "Line Out";
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai1>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&es8388>;
+			system-clock-frequency = <12288000>;
+		};
+	};
+
+	hdmi-con {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
+	vcc_12v0_dcin: regulator-vcc-12v0-dcin {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_12v0_dcin";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+	};
+
+	vcc_1v1_nldo_s3: regulator-vcc-1v1-nldo-s3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_1v1_nldo_s3";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1100000>;
+		regulator-max-microvolt = <1100000>;
+		vin-supply = <&vcc_5v0_sys>;
+	};
+
+	vcc_1v2_ufs_vccq_s0: regulator-vcc-1v2-ufs-vccq-s0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_1v2_ufs_vccq_s0";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		vin-supply = <&vcc_5v0_sys>;
+	};
+
+	vcc_1v8_s0: regulator-vcc-1v8-s0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_1v8_s0";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_1v8_s3>;
+	};
+
+	vcc_1v8_ufs_vccq2_s0: regulator-vcc-1v8-ufs-vccq2-s0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_1v8_ufs_vccq2_s0";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_1v8_s3>;
+	};
+
+	vcc_2v0_pldo_s3: regulator-vcc-2v0-pldo-s3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_2v0_pldo_s3";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <2000000>;
+		regulator-max-microvolt = <2000000>;
+		vin-supply = <&vcc_5v0_sys>;
+	};
+
+	vcc3v3_pcie: regulator-vcc3v3-pcie {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio1 RK_PB7 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pcie_pwren_h>;
+		regulator-name = "vcc3v3_pcie";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <5000>;
+		vin-supply = <&vcc_12v0_dcin>;
+	};
+
+	vcc_3v3_rtc_s5: regulator-vcc-3v3-rtc-s5 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_3v3_rtc_s5";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_5v0_sys>;
+	};
+
+	vcc_3v3_s0: regulator-vcc-3v3-s0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_3v3_s0";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_3v3_s3>;
+	};
+
+	vcc_5v0_sys: regulator-vcc-5v0-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_5v0_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc_12v0_dcin>;
+	};
+
+	vcc_5v0_device: regulator-vcc-5v0-device {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_5v0_device";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc_12v0_dcin>;
+	};
+
+	vcc_5v0_typec0: regulator-vcc-5v0-typec0 {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio1 RK_PC1 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb_otg0_pwren>;
+		regulator-name = "vcc_5v0_typec0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc_5v0_device>;
+	};
+
+	vcc_5v0_usbhost: regulator-vcc-5v0-usbhost {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio0 RK_PC7 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb_host_pwren>;
+		regulator-name = "vcc_5v0_usbhost";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc_5v0_device>;
+	};
+
+	vcc_3v3_ufs_s0: regulator-vcc-ufs-s0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_3v3_ufs_s0";
+		regulator-boot-on;
+		regulator-always-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_5v0_sys>;
+	};
+};
+
+&combphy0_ps {
+	status = "okay";
+};
+
+&combphy1_psu {
+	status = "okay";
+};
+
+&cpu_b0 {
+	cpu-supply = <&vdd_cpu_big_s0>;
+};
+
+&cpu_b1 {
+	cpu-supply = <&vdd_cpu_big_s0>;
+};
+
+&cpu_b2 {
+	cpu-supply = <&vdd_cpu_big_s0>;
+};
+
+&cpu_b3 {
+	cpu-supply = <&vdd_cpu_big_s0>;
+};
+
+&cpu_l0 {
+	cpu-supply = <&vdd_cpu_lit_s0>;
+};
+
+&cpu_l1 {
+	cpu-supply = <&vdd_cpu_lit_s0>;
+};
+
+&cpu_l2 {
+	cpu-supply = <&vdd_cpu_lit_s0>;
+};
+
+&cpu_l3 {
+	cpu-supply = <&vdd_cpu_lit_s0>;
+};
+
+&gmac0 {
+	clock_in_out = "output";
+	phy-mode = "rgmii-id";
+	phy-handle = <&rgmii_phy0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&eth0m0_miim
+		     &eth0m0_tx_bus2
+		     &eth0m0_rx_bus2
+		     &eth0m0_rgmii_clk
+		     &eth0m0_rgmii_bus>;
+	status = "okay";
+};
+
+&gmac1 {
+	clock_in_out = "output";
+	phy-mode = "rgmii-id";
+	phy-handle = <&rgmii_phy1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&eth1m0_miim
+		     &eth1m0_tx_bus2
+		     &eth1m0_rx_bus2
+		     &eth1m0_rgmii_clk
+		     &eth1m0_rgmii_bus
+		     &ethm0_clk1_25m_out>;
+	status = "okay";
+};
+
+&gpu {
+	mali-supply = <&vdd_gpu_s0>;
+	status = "okay";
+};
+
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_in {
+	hdmi_in_vp0: endpoint {
+		remote-endpoint = <&vp0_out_hdmi>;
+	};
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
+&hdmi_sound {
+	status = "okay";
+};
+
+&hdptxphy {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+
+	pmic@23 {
+		compatible = "rockchip,rk806";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <6 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_pins
+			     &rk806_dvs1_null
+			     &rk806_dvs2_null
+			     &rk806_dvs3_null>;
+		system-power-controller;
+		vcc1-supply = <&vcc_5v0_sys>;
+		vcc2-supply = <&vcc_5v0_sys>;
+		vcc3-supply = <&vcc_5v0_sys>;
+		vcc4-supply = <&vcc_5v0_sys>;
+		vcc5-supply = <&vcc_5v0_sys>;
+		vcc6-supply = <&vcc_5v0_sys>;
+		vcc7-supply = <&vcc_5v0_sys>;
+		vcc8-supply = <&vcc_5v0_sys>;
+		vcc9-supply = <&vcc_5v0_sys>;
+		vcc10-supply = <&vcc_5v0_sys>;
+		vcc11-supply = <&vcc_2v0_pldo_s3>;
+		vcc12-supply = <&vcc_5v0_sys>;
+		vcc13-supply = <&vcc_1v1_nldo_s3>;
+		vcc14-supply = <&vcc_1v1_nldo_s3>;
+		vcca-supply = <&vcc_5v0_sys>;
+
+		rk806_dvs1_null: dvs1-null-pins {
+			pins = "gpio_pwrctrl1";
+			function = "pin_fun0";
+		};
+
+		rk806_dvs2_null: dvs2-null-pins {
+			pins = "gpio_pwrctrl2";
+			function = "pin_fun0";
+		};
+
+		rk806_dvs3_null: dvs3-null-pins {
+			pins = "gpio_pwrctrl3";
+			function = "pin_fun0";
+		};
+
+		rk806_dvs1_slp: dvs1-slp-pins {
+			pins = "gpio_pwrctrl1";
+			function = "pin_fun1";
+		};
+
+		rk806_dvs1_pwrdn: dvs1-pwrdn-pins {
+			pins = "gpio_pwrctrl1";
+			function = "pin_fun2";
+		};
+
+		rk806_dvs1_rst: dvs1-rst-pins {
+			pins = "gpio_pwrctrl1";
+			function = "pin_fun3";
+		};
+
+		rk806_dvs2_slp: dvs2-slp-pins {
+			pins = "gpio_pwrctrl2";
+			function = "pin_fun1";
+		};
+
+		rk806_dvs2_pwrdn: dvs2-pwrdn-pins {
+			pins = "gpio_pwrctrl2";
+			function = "pin_fun2";
+		};
+
+		rk806_dvs2_rst: dvs2-rst-pins {
+			pins = "gpio_pwrctrl2";
+			function = "pin_fun3";
+		};
+
+		rk806_dvs2_dvs: dvs2-dvs-pins {
+			pins = "gpio_pwrctrl2";
+			function = "pin_fun4";
+		};
+
+		rk806_dvs2_gpio: dvs2-gpio-pins {
+			pins = "gpio_pwrctrl2";
+			function = "pin_fun5";
+		};
+
+		rk806_dvs3_slp: dvs3-slp-pins {
+			pins = "gpio_pwrctrl3";
+			function = "pin_fun1";
+		};
+
+		rk806_dvs3_pwrdn: dvs3-pwrdn-pins {
+			pins = "gpio_pwrctrl3";
+			function = "pin_fun2";
+		};
+
+		rk806_dvs3_rst: dvs3-rst-pins {
+			pins = "gpio_pwrctrl3";
+			function = "pin_fun3";
+		};
+
+		rk806_dvs3_dvs: dvs3-dvs-pins {
+			pins = "gpio_pwrctrl3";
+			function = "pin_fun4";
+		};
+
+		rk806_dvs3_gpio: dvs3-gpio-pins {
+			pins = "gpio_pwrctrl3";
+			function = "pin_fun5";
+		};
+
+		regulators {
+			vdd_cpu_big_s0: dcdc-reg1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <550000>;
+				regulator-max-microvolt = <950000>;
+				regulator-ramp-delay = <12500>;
+				regulator-name = "vdd_cpu_big_s0";
+				regulator-enable-ramp-delay = <400>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_npu_s0: dcdc-reg2 {
+				regulator-boot-on;
+				regulator-min-microvolt = <550000>;
+				regulator-max-microvolt = <950000>;
+				regulator-ramp-delay = <12500>;
+				regulator-name = "vdd_npu_s0";
+				regulator-enable-ramp-delay = <400>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_cpu_lit_s0: dcdc-reg3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <550000>;
+				regulator-max-microvolt = <950000>;
+				regulator-ramp-delay = <12500>;
+				regulator-name = "vdd_cpu_lit_s0";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <750000>;
+				};
+			};
+
+			vcc_3v3_s3: dcdc-reg4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc_3v3_s3";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vdd_gpu_s0: dcdc-reg5 {
+				regulator-boot-on;
+				regulator-min-microvolt = <550000>;
+				regulator-max-microvolt = <900000>;
+				regulator-ramp-delay = <12500>;
+				regulator-name = "vdd_gpu_s0";
+				regulator-enable-ramp-delay = <400>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <850000>;
+				};
+			};
+
+			vddq_ddr_s0: dcdc-reg6 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-name = "vddq_ddr_s0";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_logic_s0: dcdc-reg7 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <550000>;
+				regulator-max-microvolt = <800000>;
+				regulator-name = "vdd_logic_s0";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_1v8_s3: dcdc-reg8 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc_1v8_s3";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vdd2_ddr_s3: dcdc-reg9 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-name = "vdd2_ddr_s3";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vdd_ddr_s0: dcdc-reg10 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <550000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-name = "vdd_ddr_s0";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcca_1v8_s0: pldo-reg1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcca_1v8_s0";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcca1v8_pldo2_s0: pldo-reg2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcca1v8_pldo2_s0";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdda_1v2_s0: pldo-reg3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-name = "vdda_1v2_s0";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcca_3v3_s0: pldo-reg4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcca_3v3_s0";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vccio_sd_s0: pldo-reg5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vccio_sd_s0";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcca1v8_pldo6_s3: pldo-reg6 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcca1v8_pldo6_s3";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vdd_0v75_s3: nldo-reg1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <750000>;
+				regulator-name = "vdd_0v75_s3";
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <750000>;
+				};
+			};
+
+			vdda_ddr_pll_s0: nldo-reg2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-name = "vdda_ddr_pll_s0";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdda0v75_hdmi_s0: nldo-reg3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <837500>;
+				regulator-max-microvolt = <837500>;
+				regulator-name = "vdda0v75_hdmi_s0";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdda_0v85_s0: nldo-reg4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-name = "vdda_0v85_s0";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdda_0v75_s0: nldo-reg5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <750000>;
+				regulator-name = "vdda_0v75_s0";
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+		};
+	};
+};
+
+&i2c2 {
+	status = "okay";
+
+	hym8563: rtc@51 {
+		compatible = "haoyu,hym8563";
+		reg = <0x51>;
+		clock-output-names = "hym8563";
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA0 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hym8563_int>;
+		wakeup-source;
+		#clock-cells = <0>;
+	};
+};
+
+&i2c4 {
+	status = "okay";
+
+	es8388: audio-codec@10 {
+		compatible = "everest,es8388", "everest,es8328";
+		reg = <0x10>;
+		clocks = <&cru CLK_SAI1_MCLKOUT_TO_IO>;
+		AVDD-supply = <&vcca_3v3_s0>;
+		DVDD-supply = <&vcc_3v3_s0>;
+		HPVDD-supply = <&vcca_3v3_s0>;
+		PVDD-supply = <&vcc_3v3_s0>;
+		assigned-clocks = <&cru CLK_SAI1_MCLKOUT_TO_IO>;
+		assigned-clock-rates = <12288000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sai1m0_mclk>;
+		#sound-dai-cells = <0>;
+	};
+};
+
+&mdio0 {
+	rgmii_phy0: phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x1>;
+		clocks = <&cru REFCLKO25M_GMAC0_OUT>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&gmac0_rst>;
+		reset-assert-us = <20000>;
+		reset-deassert-us = <100000>;
+		reset-gpios = <&gpio0 RK_PC2 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&mdio1 {
+	rgmii_phy1: phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x1>;
+		clocks = <&cru REFCLKO25M_GMAC1_OUT>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&gmac1_rst>;
+		reset-assert-us = <20000>;
+		reset-deassert-us = <100000>;
+		reset-gpios = <&gpio0 RK_PC5 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&pinctrl {
+	gmac {
+		gmac0_rst: gmac0-rst {
+			rockchip,pins = <0 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		gmac1_rst: gmac1-rst {
+			rockchip,pins = <0 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	headphone {
+		hp_det: hp-det {
+			rockchip,pins = <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	hym8563 {
+		hym8563_int: hym8563-int {
+			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	pcie {
+		pcie_pwren_h: pcie-pwren-h {
+			rockchip,pins = <1 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	usb {
+		usb_host_pwren: usb-host-pwren {
+			rockchip,pins = <0 RK_PC7 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		usb_otg0_pwren: usb-otg0-pwren {
+			rockchip,pins = <1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&sai1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sai1m0_lrck
+		     &sai1m0_sclk
+		     &sai1m0_sdi0
+		     &sai1m0_sdo0>;
+	status = "okay";
+};
+
+&sai6 {
+	status = "okay";
+};
+
+&sdhci {
+	bus-width = <8>;
+	full-pwr-cycle-in-suspend;
+	max-frequency = <200000000>;
+	mmc-hs400-1_8v;
+	mmc-hs400-enhanced-strobe;
+	no-sdio;
+	no-sd;
+	non-removable;
+	status = "okay";
+};
+
+&sdmmc {
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	disable-wp;
+	max-frequency = <200000000>;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vcc_3v3_s3>;
+	vqmmc-supply = <&vccio_sd_s0>;
+	status = "okay";
+};
+
+&u2phy0 {
+	status = "okay";
+};
+
+&u2phy0_otg {
+	phy-supply = <&vcc_5v0_typec0>;
+	status = "okay";
+};
+
+&u2phy1 {
+	status = "okay";
+};
+
+&u2phy1_otg {
+	phy-supply = <&vcc_5v0_usbhost>;
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-0 = <&uart0m0_xfer>;
+	status = "okay";
+};
+
+&vop {
+	status = "okay";
+};
+
+&vop_mmu {
+	status = "okay";
+};
+
+&vp0 {
+	vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
+		reg = <ROCKCHIP_VOP2_EP_HDMI0>;
+		remote-endpoint = <&hdmi_in_vp0>;
+	};
+};
-- 
2.34.1



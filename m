Return-Path: <linux-kernel+bounces-895901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8132EC4F39E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 293593BC91E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B57393DDB;
	Tue, 11 Nov 2025 17:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rootcommit.com header.i=@rootcommit.com header.b="NyMwhXq+"
Received: from slategray.cherry.relay.mailchannels.net (slategray.cherry.relay.mailchannels.net [23.83.223.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B139733468B;
	Tue, 11 Nov 2025 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762881636; cv=pass; b=heXk/0aTIp2pyTfat75ms88DJGsdjp16N0bZbDyNDjeNRJYutuzPl3DmWV/sv9Y9FNzmkLHHpjDZURyt+Ghm43Z+THEt9Txwx2DvIHvfNcNxbFKDNFuBAtt8rtCeQOyQVK4JbMTEDenSCvSCZ5f2S00e37NuIMhbJ08hj62TjGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762881636; c=relaxed/simple;
	bh=AIurUDJPDIB8IXFJdZKoC6TqumnvXrbGAX/Fs+rFEM0=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Date; b=W/nAC/lLLvZPKb559Cv6Y8O5Pyc/5e7+Fu2rCwBtJok8RO/AET8kybeeAJoWowh3iuukTvZ4Rusqp+cBnVY21fYVG2KwHl11g7VzJ2APBL9Q1DVPXXAojwTXwCQMTC2jVYdBCkJaxXnJQQYSzTuKmAO2wzyoZped/Fr/CeWLQzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rootcommit.com; spf=pass smtp.mailfrom=rootcommit.com; dkim=pass (2048-bit key) header.d=rootcommit.com header.i=@rootcommit.com header.b=NyMwhXq+; arc=pass smtp.client-ip=23.83.223.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rootcommit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id ACF088A0DFB;
	Tue, 11 Nov 2025 17:20:27 +0000 (UTC)
Received: from fr-int-smtpout26.hostinger.io (trex-green-6.trex.outbound.svc.cluster.local [100.124.9.98])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 73B958A2E16;
	Tue, 11 Nov 2025 17:20:25 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1762881626; a=rsa-sha256;
	cv=none;
	b=MmW2O320Cg1W4C08+oDpjXH60KRkARJYnkpDNwHxl8/wqhVmUtn5782LfFV6TihYXC7wPv
	dZiFZh/eowKa+VsyO3Sk4hlWthx0VTkZ5ViW4XUMFd5+qS+iLcRjczbT0THP53YXbgqfmh
	pSyaDX9XLX5vVskw7tpk4nXzpwr/WVRjqiQBN8s+3dVNSdyLF0JqvvCn+4atq5PAOcg22s
	nFMJsHNyicMhgumxNYJ6KQ53ZWPcsmJuG0gUotFbJ651tcVI3D3irZQGd0AFjx89FHKShx
	5coOcpVpHi5yB8LAgrbuYbHTQwSft+hJcBEsr19k4UawoBKHNn/qmrlbRNWmdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1762881626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=iYfCBJxgQMj+VhBJDRiGrOo8VjM1cxFnBM7Ks63dkWw=;
	b=eiFLm4XPbOzcj5eM2/O5ahyUaef9tHYX4dpef2IfYpqBa5Sj7+hwWSEwMIoCoqh8PlC8DS
	OK0+d6sKCYJ2JqdxbZEPWOOodyOCopNTA7/izeWbbG09JmqFO2Ogy/UnKTn0vF02zy1cy1
	owrGY0gJrQV+Z2xWPUC0FPsBLmtEC/xlAfVkhz7kDilCZzKqwhELTYGjwXFlf8H3kUknYs
	Uyrfv/LQOuWVXNdZhjjycYWESWoHpA8lMLjmpGDbDUIuc0LDRV0ZhG5MXDqk3qc1oPPSiq
	ckYNK9QibIEBeBrjknUc1hD68EUKPnA+zv2kLRLHpATujlmJwa2aYoTKzwZD1A==
ARC-Authentication-Results: i=1;
	rspamd-768b565cdb-f69nt;
	auth=pass smtp.auth=hostingeremail
 smtp.mailfrom=michael.opdenacker@rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MC-Relay: Neutral
X-MailChannels-SenderId:
 hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MailChannels-Auth-Id: hostingeremail
X-Descriptive-Relation: 2f3df20b433747df_1762881627268_242208729
X-MC-Loop-Signature: 1762881627268:2668246351
X-MC-Ingress-Time: 1762881627268
Received: from fr-int-smtpout26.hostinger.io (fr-int-smtpout26.hostinger.io
 [148.222.54.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.124.9.98 (trex/7.1.3);
	Tue, 11 Nov 2025 17:20:27 +0000
Received: from localhost.localdomain (unknown [IPv6:2001:861:4450:d360:c518:3c38:613e:ee54])
	(Authenticated sender: michael.opdenacker@rootcommit.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4d5YFg3VZTz1xnM;
	Tue, 11 Nov 2025 17:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rootcommit.com;
	s=hostingermail-a; t=1762881623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iYfCBJxgQMj+VhBJDRiGrOo8VjM1cxFnBM7Ks63dkWw=;
	b=NyMwhXq+GI6ib8Tdp614RCw41hitFGCA6PIjcw9VP0wGkh5Ku2fS5R1Q2RRODcbvqrh0+w
	lCn7Pdvo8d6PTVDkyt6PWfd/wKl7TWe48dGhEEOpX1L7YGS+XLrmDElkg5fSEbDOhBYDtz
	OrZbT2+3kIfk0o9iXhXfq5XZmJtTHHcTByGnD1D1q6NfYJwQe3Gr/gI2mW9ehg4pgEIQm/
	csDZPXpNrk0irB3NzmmrEid5E3PLcE/5KQl9cIzCabRb7mLaEIQvZcm6SFbrXyipEl19kd
	MVy1onssi3i6fclYaQtc8Qhj9F3+aUePzWmNwXE0W/C3Ib9G1ill5IAY8w1ImA==
From: michael.opdenacker@rootcommit.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: rockchip: add Tinkerboard 3 and 3S device tree
Message-ID: <20251111172003.2324525-3-michael.opdenacker@rootcommit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251111172003.2324525-1-michael.opdenacker@rootcommit.com>
References: <20251111172003.2324525-1-michael.opdenacker@rootcommit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Date: Tue, 11 Nov 2025 17:20:23 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=NuiDcNdJ c=1 sm=1 tr=0 ts=69137057 a=4Ac7OKPmaT9y8oRpUfBUJQ==:617 a=xqWC_Br6kY4A:10 a=-Yt9tNsTAAAA:8 a=d70CFdQeAAAA:8 a=c5J05wBQCKpdwD8Cx1EA:9 a=qPQde0g9OtMA:10 a=HTceBwxjnJgA:10 a=NcxpMcIZDGm-g932nG_k:22
X-CM-Envelope: MS4xfGM/J1hHt5ZYMkqoyesU57Z4T+VLHl/lCfD5/gzH8XsyupHibNPluJjb3iftLxJUwAh9Fmq+FmxwdOY1jUu/Xwk4gT3yu4EkfuPPvI+ioxWCj0mFiYic L7yzyAUHeZdAWM5AAPRwS3Kl8tCnqFrxC7W48pxM2bFjQ5cn4CRluRx/tzLJU2KKXK6q/rHx73o8oUg7vduy9Cp1TYk9ct0+CIpiCOr2nWW385ToPf49wfP1 IJ6t4xVxU4v+qaAHAdiWrlmsGUfyBhKq35Q71fo72zwSW2bzt/AH8SKwejUoONwkD6OqA8rfX3bZyv1n/phguE9syHXuiNrgIkh8sCTPnhsNGhiAvZa8eAFm 51zeut4dQ99Paob2I2+jZ96BaZyKATBDQYLTFlw6X6UHE/UhBkWWfmuglLL54FG6zpUhI0YS7JSv1aRtn/0R2Noe3lJlLQDnkk+fAt0FfLAhOcEcpybDxbXv b9mROOS1RszuJxk0lsbkRJs62cXJ8X62UkojXlxUUDk2OMir0zioU54Idfs0fePWpWWeniEjoULmgZz9nv3kcBT8AwAXWuv68k1UT4FqFLDxw5C7nnPY/DwK a4Y=
X-AuthUser: michael.opdenacker@rootcommit.com

From: Michael Opdenacker <michael.opdenacker@rootcommit.com>

Add initial device tree support for Asus Tinkerboard 3 [1] and 3S [2],
which are SBCs based on the Rockchip 3566 SoC.

The "3S" version ("S" for "storage") just adds a 16 GB eMMC
and a "mask ROM" DIP switch (to mask the eMMC and enter "Mask ROM"
mode for recovery) to the "3" version.

This adds support for:
- Debug UART (/dev/ttyS2)
- SD card (/dev/mmcblk1)
- eMMC (/dev/mmcblk0, only on Tinkerboard 3S)
- I2C:
  - i2c0 (internal bus with a PMIC and regulators)
  - i2c2 (internal bus with an at24 eeprom and an RTC device)
- USB 2.0 ports
- 2 GPIO LEDS

Link: https://tinker-board.asus.com/series/tinker-board-3.html [1]
Link: https://tinker-board.asus.com/series/tinker-board-3s.html [2]
Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
---
 arch/arm64/boot/dts/rockchip/Makefile         |   2 +
 .../boot/dts/rockchip/rk3566-tinker-3.dts     |  14 +
 .../boot/dts/rockchip/rk3566-tinker-3.dtsi    | 264 ++++++++++++++++++
 .../boot/dts/rockchip/rk3566-tinker-3s.dts    |  30 ++
 4 files changed, 310 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-tinker-3.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-tinker-3.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-tinker-3s.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index ad684e3831bc..381831cab20c 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -130,6 +130,8 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-lubancat-1.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-nanopi-r3s.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-bigtreetech-cb2-manta.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-bigtreetech-pi2.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-tinker-3.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-tinker-3s.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-bpi-r2-pro.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-evb1-v10.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-fastrhino-r66s.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-tinker-3.dts b/arch/arm64/boot/dts/rockchip/rk3566-tinker-3.dts
new file mode 100644
index 000000000000..938af35b9004
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3566-tinker-3.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2025 Michael Opdenacker <michael.opdenacker@rootcommit.com>
+ */
+
+/dts-v1/;
+
+#include "rk3566-tinker-3.dtsi"
+
+/ {
+	model = "Rockchip RK3566 Asus Tinker Board 3";
+	compatible = "asus,rk3566-tinker-3", "rockchip,rk3566";
+};
+
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-tinker-3.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-tinker-3.dtsi
new file mode 100644
index 000000000000..45269d33b0cb
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3566-tinker-3.dtsi
@@ -0,0 +1,264 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2025 Michael Opdenacker <michael.opdenacker@rootcommit.com>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/soc/rockchip,vop2.h>
+#include "rk3566.dtsi"
+
+/ {
+	aliases {
+		serial2 = &uart2;
+		mmc1 = &sdmmc0;
+		i2c0 = &i2c0;
+		i2c2 = &i2c2;
+	};
+
+	chosen {
+		stdout-path = "serial2:1500000n8";
+	};
+
+	vcc3v3_sys: regulator-3v3-vcc-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc5v0_sys: regulator-5v0-vcc-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	vcc5v0_usb_host: regulator-5v0-vcc-usb-host {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb_host_pwren_h>;
+		regulator-name = "vcc5v0_usb_host";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	gpio_leds: gpio-leds {
+		compatible = "gpio-leds";
+
+		act-led {
+			gpios = <&gpio0 RK_PD4 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger="mmc1";
+};
+
+		rsv-led {
+			gpios = <&gpio0 RK_PD6 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger="none";
+		};
+	};
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	rk809: pmic@20 {
+		compatible = "rockchip,rk809";
+		reg = <0x20>;
+		assigned-clocks = <&cru I2S1_MCLKOUT_TX>;
+		assigned-clock-parents = <&cru CLK_I2S1_8CH_TX>;
+		#clock-cells = <1>;
+		clocks = <&cru I2S1_MCLKOUT_TX>;
+		clock-names = "mclk";
+		clock-output-names = "rk809-clkout1", "rk809-clkout2";
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_int_l>, <&i2s1m0_mclk>;
+		#sound-dai-cells = <0>;
+		system-power-controller;
+		wakeup-source;
+
+		vcc1-supply = <&vcc3v3_sys>;
+		vcc2-supply = <&vcc3v3_sys>;
+		vcc3-supply = <&vcc3v3_sys>;
+		vcc4-supply = <&vcc3v3_sys>;
+		vcc5-supply = <&vcc3v3_sys>;
+		vcc6-supply = <&vcc3v3_sys>;
+		vcc7-supply = <&vcc3v3_sys>;
+		vcc8-supply = <&vcc3v3_sys>;
+		vcc9-supply = <&vcc3v3_sys>;
+
+		regulators {
+			vcc_1v8: DCDC_REG5 {
+				regulator-name = "vcc_1v8";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc3v3_sd: SWITCH_REG2 {
+				regulator-name = "vcc3v3_sd";
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vccio_sd: LDO_REG5 {
+				regulator-name = "vccio_sd";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_3v3: SWITCH_REG1 {
+				regulator-name = "vcc_3v3";
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+		};
+	};
+
+	vdd_cpu: regulator@40 {
+		compatible = "silergy,syr827";
+		reg = <0x40>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-name = "vdd_cpu";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <830000>;
+		regulator-max-microvolt = <1200000>;
+		regulator-ramp-delay = <2300>;
+		vin-supply = <&vcc3v3_sys>;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+};
+
+&i2c2 {
+	status = "okay";
+
+	m24c08@50 {
+		compatible = "atmel,24c08";
+		reg = <0x50>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&tb3_eeprom>;
+		status = "okay";
+	};
+
+	rtc_isl1208: rtc@6f {
+		compatible = "isil,isl1208";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_externalrtc_reg>;
+		interrupt-names = "irq";
+		interrupts-extended = <&gpio0 RK_PD3 IRQ_TYPE_EDGE_FALLING>;
+		reg = <0x6f>;
+		status = "okay";
+	};
+};
+
+&sdmmc0 {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	disable-wp;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
+	vmmc-supply = <&vcc3v3_sd>;
+	vqmmc-supply = <&vccio_sd>;
+	status = "okay";
+};
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
+
+&usb_host1_ehci {
+	status = "okay";
+};
+
+&usb_host1_ohci {
+	status = "okay";
+};
+
+&usb2phy0 {
+	status = "okay";
+};
+
+&usb2phy0_host {
+	phy-supply = <&vcc5v0_usb_host>;
+	status = "okay";
+};
+
+&usb2phy1 {
+	status = "okay";
+};
+
+&usb2phy1_host {
+	phy-supply = <&vcc5v0_usb_host>;
+	status = "okay";
+};
+
+&pinctrl {
+	pmic {
+		pmic_int_l: pmic-int-l {
+			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	usb {
+		usb_host_pwren_h: usb-host-pwren-h {
+			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		usb_otg_pwren_h: usb-otg-pwren-h {
+			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	rtc {
+		pinctrl_externalrtc_reg: externalrtcreggrp {
+			rockchip,pins = <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	eeprom {
+		tb3_eeprom: tb3-eeprom {
+			rockchip,pins = <3 RK_PC1 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-tinker-3s.dts b/arch/arm64/boot/dts/rockchip/rk3566-tinker-3s.dts
new file mode 100644
index 000000000000..ba7efd702050
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3566-tinker-3s.dts
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2025 Michael Opdenacker <michael.opdenacker@rootcommit.com>
+ */
+
+/dts-v1/;
+
+#include "rk3566-tinker-3.dtsi"
+
+/ {
+	model = "Rockchip RK3566 Asus Tinker Board 3S";
+	compatible = "asus,rk3566-tinker-3s", "asus,rk3566-tinker-3", "rockchip,rk3566";
+
+	aliases {
+		mmc0 = &sdhci;
+	};
+};
+
+&sdhci {
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	max-frequency = <200000000>;
+	mmc-hs200-1_8v;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&vcc_1v8>;
+	status = "okay";
+};


Return-Path: <linux-kernel+bounces-831762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C48B9D81D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C9DB1B26C05
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10792E8B9B;
	Thu, 25 Sep 2025 05:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIac4CXf"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4AB2E8B8C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 05:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758779970; cv=none; b=XIU3jBHJwnoJ75PqXcQv6R1Chtdfkan9yu4LhuOlJMruIqqaEzB+R7GXaeGvlKxIrX5RV81wlIOoAJQMtGZ8cEDFjC87rFsh+j4XMzep0siYrZ9XsKXgPqhrynx1ag2sP9PqLke66uo00diMS52BthW+SqUIxAGTOHt/6lYxfnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758779970; c=relaxed/simple;
	bh=flSXnaCsY4GuI2Xi7jjPPjECKv2vhHOiQuDklXGu7ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJ4mbWf/G8qPx0RsfhIYi2VuuUuRdQtHrXbyyX7EyRCFrFaj01q8nZYlCOR+dUWcVNr6nCtDJMYqZCp94oscBlZ0vFSngbTJcLA31/WwjH8VS13u85z4hut+SvuTnv5UrHQ3j+HzmCwmRb4FDQOiPcqy+XwKKslrQAusTYbIPqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NIac4CXf; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77c1814ca1dso498894b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 22:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758779968; x=1759384768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XtavhOsQwF08dyhxTuSlB3SJ6xxUQQjoptkIUo1P2H0=;
        b=NIac4CXf9s7YiRnvUOJnkGU+3hj9bOIB/ZCBd/SnkLFinzsqppo+Sx2yLID50QhtN9
         ociAYHAQQ3KlRRCf6hDVG1xeVcJ1OvvTKu1O5gHU/OiZVc4cN62Rg5sNYDtAgwS8z38o
         /ewrJcd971KCqKTlI38ttXsBM9CCcj6Bz6lYQYngo/h//Mavza+CMGpi6YGxQdUKDqk2
         c5Ctbc7dPb7EXDJ/Q08SrhJnZVF2shjqxTc89cVw1HSePqdY/9JkJY02rU0hm8YzCFY8
         WnklJNIFUJ2KwRA0lXlBds5BKzcENzmBH376Tn5DzT+cn+wZ9jH0DW+ilwWpVBbZYzkX
         XfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758779968; x=1759384768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XtavhOsQwF08dyhxTuSlB3SJ6xxUQQjoptkIUo1P2H0=;
        b=ljLgb3viopBJhh3X5MC1L+51fWCxR+2SBlrX1trdxRon4y4Ue5DO+Hz981Cv/LS0fP
         kSTbHF+VQ1kx/KJdTfi5MXobDTbCLLa9P9Fsityqhd7S9spPi7impHH90ks5HzzXQAdI
         lvvcVZtI4SDFlmwJi+HD43XjTssK4jhY2JEdRaL/yz2hPpBf1mUZRmv+SfmhohowgWVF
         X27pf7mr3+yr3wZlawJVJ4CzhrCCXvOJ+9t2rqtbi5zFTTOVnzuxxN7JU+bs4xNdw4eh
         wull0OLZsN53af8HNYHxmXrL1R8DK5BYo6AxHnbEKajGwLDCSsD5x3PKJD/cNbteAL0p
         XOpA==
X-Forwarded-Encrypted: i=1; AJvYcCVn02W2lQ0Y+7qSxTVkWvvfsD5h5Y4EqdzxhEalfOC/WcDFs5/LPfTh7aAPPrS19aHARVe7M7i51so1ANI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/0SfSapx7NFLUH068vX3hr7x8p4H4w8bZ/5MfEES28E8BJ1af
	G9YYJcFK0006WX3AUXc/F4ui8yMDFqcrxkKV9SXxCVr52KFulTN9vYWK
X-Gm-Gg: ASbGnctdsj2o7ppsfGLYguVOLhnxO/bZibpxEZxjMUlm6lwHLHAvz7UADgBgltSn9Ge
	R6GcIprpNscAcbBwg4lByxQxohJbIr2Gn9W53gsbWFJ/ZPTqcmwCBkyTSGcv5yJw0Jsfm4PHQB5
	vugO9GAS+IO5aXDKL0ENPr0Z6u1KoMl6lkdKPqNaS5Zl8eResEw8dFfKWJTD8921V5mCXA7tJmC
	ph8cCqzLirZliSj/UOBjuK1XTPJMNTMgKyYnlHA80+r6oX85+TzSnGQznAzBuYYYZ6km+bOd9sS
	1wINVOlPBojdkRF6CI7c/qPNxtqzxuG/EAVbVuEfTqTRPDjRGeTE4KeGQ2zSWS9acZBw8n27Snq
	EfrJJetGx8IXodJ3YSRJa
X-Google-Smtp-Source: AGHT+IH0KeuvbDEDawkIcCaPX2Sayqc/yRlC7UDQx0lpMFNkquEwx4BK9EJRbPVaFFYWxRUjrCyRtw==
X-Received: by 2002:a05:6a20:9192:b0:277:f962:3163 with SMTP id adf61e73a8af0-2e7c29376b1mr2916281637.19.1758779967608;
        Wed, 24 Sep 2025 22:59:27 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:3981:16dc::247:77])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102b231ebsm866478b3a.52.2025.09.24.22.59.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 24 Sep 2025 22:59:27 -0700 (PDT)
From: Liangbin Lian <jjm2473@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	quentin.schulz@cherry.de,
	kever.yang@rock-chips.com,
	naoki@radxa.com,
	honyuenkwun@gmail.com,
	inindev@gmail.com,
	ivan8215145640@gmail.com,
	neil.armstrong@linaro.org,
	mani@kernel.org,
	dsimic@manjaro.org,
	pbrobinson@gmail.com,
	alchark@gmail.com,
	didi.debian@cknow.org,
	jjm2473@gmail.com,
	jbx6244@gmail.com
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: rockchip: add LinkEase EasePi R1
Date: Thu, 25 Sep 2025 13:59:06 +0800
Message-ID: <20250925055906.83375-3-jjm2473@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925055906.83375-1-jjm2473@gmail.com>
References: <20250925055906.83375-1-jjm2473@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LinkEase EasePi R1 [1] is a high-performance mini router.

Specification:
- Rockchip RK3568
- 2GB/4GB LPDDR4 RAM
- 16GB on-board eMMC
- 1x M.2 key for 2280 NVMe (PCIe 3.0)
- 1x USB 3.0 Type-A
- 1x USB 2.0 Type-C (for USB flashing)
- 2x 1000 Base-T (native, RTL8211F)
- 2x 2500 Base-T (PCIe, RTL8125B)
- 1x HDMI 2.0 Output
- 12v DC Jack
- 1x Power key connected to PMIC
- 2x LEDs (one static power supplied, one GPIO controlled)

[1] https://doc.linkease.com/zh/guide/easepi-r1/hardware.html

Signed-off-by: Liangbin Lian <jjm2473@gmail.com>
---
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3568-easepi-r1.dts    | 692 ++++++++++++++++++
 2 files changed, 693 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-easepi-r1.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 099520962ffb..7646ffd7f309 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -127,6 +127,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-nanopi-r3s.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-bigtreetech-cb2-manta.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-bigtreetech-pi2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-bpi-r2-pro.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-easepi-r1.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-evb1-v10.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-fastrhino-r66s.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-fastrhino-r68s.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-easepi-r1.dts b/arch/arm64/boot/dts/rockchip/rk3568-easepi-r1.dts
new file mode 100644
index 000000000000..09e0dc4af794
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3568-easepi-r1.dts
@@ -0,0 +1,692 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/soc/rockchip,vop2.h>
+#include "rk3568.dtsi"
+
+/ {
+	model = "LinkEase EasePi R1";
+	compatible = "linkease,easepi-r1", "rockchip,rk3568";
+
+	aliases {
+		mmc0 = &sdmmc0;
+		mmc1 = &sdhci;
+		mmc2 = &sdmmc2;
+
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
+	};
+
+	chosen: chosen {
+		stdout-path = "serial2:1500000n8";
+	};
+
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 0>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1800000>;
+
+		button-recovery {
+			label = "Recovery";
+			linux,code = <KEY_VENDOR>;
+			press-threshold-microvolt = <1750>;
+		};
+	};
+
+	dc_12v: regulator-dc-12v {
+		compatible = "regulator-fixed";
+		regulator-name = "dc_12v";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+	};
+
+	vcc5v0_sys: regulator-vcc5v0-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&dc_12v>;
+	};
+
+	vcc3v3_sys: regulator-vcc3v3-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&dc_12v>;
+	};
+
+	pcie30_avdd0v9: regulator-pcie30-avdd0v9 {
+		compatible = "regulator-fixed";
+		regulator-name = "pcie30_avdd0v9";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <900000>;
+		vin-supply = <&vcc3v3_sys>;
+	};
+
+	pcie30_avdd1v8: regulator-pcie30-avdd1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "pcie30_avdd1v8";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc3v3_sys>;
+	};
+
+	regulator-vdd0v95-25glan {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwr_25g_pin>;
+		enable-active-high;
+		gpio = <&gpio3 RK_PB1 GPIO_ACTIVE_HIGH>;
+		regulator-name = "vdd0v95_25glan";
+		regulator-min-microvolt = <950000>;
+		regulator-max-microvolt = <950000>;
+		regulator-boot-on;
+		regulator-always-on;
+		vin-supply = <&vcc3v3_sys>;
+	};
+
+	vcc3v3_nvme: regulator-vcc3v3-nvme {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_nvme";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&dc_12v>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc3v3_nvme_en>;
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&rk809 1>;
+		clock-names = "ext_clock";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_enable_h>;
+		post-power-on-delay-ms = <200>;
+		reset-gpios = <&gpio3 RK_PD5 GPIO_ACTIVE_LOW>;
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
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&status_led_pin>;
+
+		status_led: led-status {
+			gpios = <&gpio2 RK_PD7 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_STATUS;
+			label = "green:status";
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+};
+
+&gmac0 {
+	phy-mode = "rgmii";
+	clock_in_out = "input";
+
+	assigned-clocks = <&cru SCLK_GMAC0_RX_TX>, <&cru SCLK_GMAC0>;
+	assigned-clock-parents = <&cru SCLK_GMAC0_RGMII_SPEED>;
+	assigned-clock-rates = <0>, <125000000>;
+	phy-handle = <&rgmii_phy0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac0_miim
+		     &gmac0_tx_bus2
+		     &gmac0_rx_bus2
+		     &gmac0_rgmii_clk
+		     &gmac0_rgmii_bus>;
+
+	tx_delay = <0x3c>;
+	rx_delay = <0x2f>;
+
+	status = "okay";
+};
+
+&gmac1 {
+	phy-mode = "rgmii";
+	clock_in_out = "input";
+
+	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
+	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>;
+	assigned-clock-rates = <0>, <125000000>;
+	phy-handle = <&rgmii_phy1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac1m1_miim
+		     &gmac1m1_tx_bus2
+		     &gmac1m1_rx_bus2
+		     &gmac1m1_rgmii_clk
+		     &gmac1m1_rgmii_bus>;
+
+	tx_delay = <0x4f>;
+	rx_delay = <0x26>;
+
+	status = "okay";
+};
+
+&mdio0 {
+	rgmii_phy0: ethernet-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x1>;
+		pinctrl-0 = <&eth_phy0_reset_pin>;
+		pinctrl-names = "default";
+		reset-assert-us = <20000>;
+		reset-deassert-us = <100000>;
+		reset-gpios = <&gpio2 RK_PD3 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&mdio1 {
+	rgmii_phy1: ethernet-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x1>;
+		pinctrl-0 = <&eth_phy1_reset_pin>;
+		pinctrl-names = "default";
+		reset-assert-us = <20000>;
+		reset-deassert-us = <100000>;
+		reset-gpios = <&gpio2 RK_PD1 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&combphy0 {
+	status = "okay";
+};
+
+&combphy1 {
+	status = "okay";
+};
+
+&combphy2 {
+	status = "okay";
+};
+
+&cpu0 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu1 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu2 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu3 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&gpu {
+	mali-supply = <&vdd_gpu>;
+	status = "okay";
+};
+
+&hdmi {
+	avdd-0v9-supply = <&vdda0v9_image>;
+	avdd-1v8-supply = <&vcca1v8_image>;
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
+&i2c0 {
+	status = "okay";
+
+	vdd_cpu: regulator@1c {
+		compatible = "tcs,tcs4525";
+		reg = <0x1c>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-name = "vdd_cpu";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <800000>;
+		regulator-max-microvolt = <1150000>;
+		regulator-ramp-delay = <2300>;
+		vin-supply = <&vcc5v0_sys>;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+
+	rk809: pmic@20 {
+		compatible = "rockchip,rk809";
+		reg = <0x20>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_LOW>;
+		#clock-cells = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_int>;
+		rockchip,system-power-controller;
+		vcc1-supply = <&vcc3v3_sys>;
+		vcc2-supply = <&vcc3v3_sys>;
+		vcc3-supply = <&vcc3v3_sys>;
+		vcc4-supply = <&vcc3v3_sys>;
+		vcc5-supply = <&vcc3v3_sys>;
+		vcc6-supply = <&vcc3v3_sys>;
+		vcc7-supply = <&vcc3v3_sys>;
+		vcc8-supply = <&vcc3v3_sys>;
+		vcc9-supply = <&vcc3v3_sys>;
+		wakeup-source;
+
+		regulators {
+			vdd_logic: DCDC_REG1 {
+				regulator-name = "vdd_logic";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-initial-mode = <0x2>;
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_gpu: DCDC_REG2 {
+				regulator-name = "vdd_gpu";
+				regulator-always-on;
+				regulator-initial-mode = <0x2>;
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_ddr: DCDC_REG3 {
+				regulator-name = "vcc_ddr";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-initial-mode = <0x2>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vdd_npu: DCDC_REG4 {
+				regulator-name = "vdd_npu";
+				regulator-initial-mode = <0x2>;
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
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
+			vdda0v9_image: LDO_REG1 {
+				regulator-name = "vdda0v9_image";
+				regulator-min-microvolt = <950000>;
+				regulator-max-microvolt = <950000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdda_0v9: LDO_REG2 {
+				regulator-name = "vdda_0v9";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdda0v9_pmu: LDO_REG3 {
+				regulator-name = "vdda0v9_pmu";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <900000>;
+				};
+			};
+
+			vccio_acodec: LDO_REG4 {
+				regulator-name = "vccio_acodec";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vccio_sd: LDO_REG5 {
+				regulator-name = "vccio_sd";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc3v3_pmu: LDO_REG6 {
+				regulator-name = "vcc3v3_pmu";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vcca_1v8: LDO_REG7 {
+				regulator-name = "vcca_1v8";
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
+			vcca1v8_pmu: LDO_REG8 {
+				regulator-name = "vcca1v8_pmu";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vcca1v8_image: LDO_REG9 {
+				regulator-name = "vcca1v8_image";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
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
+		};
+
+	};
+};
+
+&i2s0_8ch {
+	status = "okay";
+};
+
+/* ETH3 */
+&pcie2x1 {
+	reset-gpios = <&gpio3 RK_PA4 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&pcie30phy {
+	data-lanes = <1 2>;
+	status = "okay";
+};
+
+/* ETH2 */
+&pcie3x1 {
+	num-lanes = <1>;
+	reset-gpios = <&gpio3 RK_PA3 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+/* M.2 Key for 2280 NVMe */
+&pcie3x2 {
+	num-lanes = <1>;
+	reset-gpios = <&gpio2 RK_PD6 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_nvme>;
+	status = "okay";
+};
+
+&pinctrl {
+	gmac0 {
+		eth_phy0_reset_pin: eth-phy0-reset-pin {
+			rockchip,pins = <2 RK_PD3 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+	gmac1 {
+		eth_phy1_reset_pin: eth-phy1-reset-pin {
+			rockchip,pins = <2 RK_PD1 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	gpio-leds {
+		status_led_pin: status-led-pin {
+			rockchip,pins =
+				<2 RK_PD7 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	pmic {
+		pmic_int: pmic-int {
+			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	pcie-nic {
+		pwr_25g_pin: pwr-25g-pin {
+			rockchip,pins = <3 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	nvme {
+		vcc3v3_nvme_en: vcc3v3-nvme-en {
+			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	sdio-pwrseq {
+		wifi_enable_h: wifi-enable-h {
+			rockchip,pins = <3 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+};
+
+&pmu_io_domains {
+	pmuio1-supply = <&vcc3v3_pmu>;
+	pmuio2-supply = <&vcc3v3_pmu>;
+	vccio1-supply = <&vccio_acodec>;
+	vccio3-supply = <&vccio_sd>;
+	vccio4-supply = <&vcc_1v8>;
+	vccio5-supply = <&vcc_3v3>;
+	vccio6-supply = <&vcc_1v8>;
+	vccio7-supply = <&vcc_3v3>;
+	status = "okay";
+};
+
+&saradc {
+	vref-supply = <&vcca_1v8>;
+	status = "okay";
+};
+
+&sdhci {
+	bus-width = <8>;
+	max-frequency = <200000000>;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
+	status = "okay";
+};
+
+/* Micro SD card slot is not mounted */
+&sdmmc0 {
+	max-frequency = <150000000>;
+	no-sdio;
+	no-mmc;
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	disable-wp;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
+	vmmc-supply = <&vcc3v3_sd>;
+	vqmmc-supply = <&vccio_sd>;
+	status = "disable";
+};
+
+/* Wifi module is not mounted */
+&sdmmc2 {
+	max-frequency = <150000000>;
+	bus-width = <4>;
+	disable-wp;
+	cap-sd-highspeed;
+	cap-sdio-irq;
+	keep-power-in-suspend;
+	mmc-pwrseq = <&sdio_pwrseq>;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc2m0_bus4 &sdmmc2m0_cmd &sdmmc2m0_clk>;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vcc3v3_sys>;
+	vqmmc-supply = <&vcc_1v8>;
+	status = "disable";
+};
+
+&tsadc {
+	rockchip,hw-tshut-mode = <1>;
+	rockchip,hw-tshut-polarity = <0>;
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+/* OTG Only USB2.0, Only device mode */
+&usb_host0_xhci {
+	phys = <&usb2phy0_otg>;
+	phy-names = "usb2-phy";
+	extcon = <&usb2phy0>;
+	maximum-speed = "high-speed";
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&usb_host1_xhci {
+	status = "okay";
+};
+
+&usb2phy0 {
+	status = "okay";
+};
+
+&usb2phy0_host {
+	phy-supply = <&vcc5v0_sys>;
+	status = "okay";
+};
+
+&usb2phy0_otg {
+	status = "okay";
+};
+
+&vop {
+	assigned-clocks = <&cru DCLK_VOP0>, <&cru DCLK_VOP1>;
+	assigned-clock-parents = <&pmucru PLL_HPLL>, <&cru PLL_VPLL>;
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
2.51.0



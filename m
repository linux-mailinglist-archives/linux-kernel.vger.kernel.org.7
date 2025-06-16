Return-Path: <linux-kernel+bounces-689092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0987CADBBE4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 23:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F10BB3B5C37
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 21:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DEC218ACC;
	Mon, 16 Jun 2025 21:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFsL3ByE"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED0221C179;
	Mon, 16 Jun 2025 21:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750108946; cv=none; b=dUDJ6bTpUWv8el/FXhp4qYLTPKcdV3qMJ2zqhJYgn2Quvk7sonPh3RNCi8WyZ0KDelYIQhBajNy9UKiaK8KZ/x9X9ZMC9DSmZfEJ7KTXNswgHSt69qjBPhwySOzEW0x3jf/xhJQrmJG6rQAI2qxLfkC6mG/8ucmzTfgOic5FyPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750108946; c=relaxed/simple;
	bh=cZ2MeYhWZPAnKzSMVcoXRqTjZDC6Di7whC6XLfwSQos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VQAwLdYnukpD6GgFbGFbM4C/XIVJi1N3JFPhjFAOS36KBtjYrSSPwrcLStKswoBOyq698yTo1aQEmeeETYEI0CEJ5zVxQuPK1FyLiDOW67GfaqIqQNu27VxROydqK7jrejHA2OIbKZCEZZGzfePmJTGQKm48MNwqHLTMnTc/4z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFsL3ByE; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71173646662so30599327b3.2;
        Mon, 16 Jun 2025 14:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750108943; x=1750713743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvQn+1TbEfDE4ooQ/SlX0ICE7KlQ/7LEuQY+vsTPXU4=;
        b=DFsL3ByErjDRponQs1Ee3nuvUVcge45lAoHG2WLkxKWO9MfFq6lNgXvbqaxnYkVu3O
         Ekqi3cIy8VJjnuPtSMEGZgXF73lHCAAZd3BVKM4NV45zS9Mx+m/MxvuId/nGAaOM0ByD
         ZRQrEHPhO/QIoxJdOS76RRIRxYKn5wTpaT38jq+Uiqtf1lPpH0qCCEnhJO2vdMnbWCh3
         gIaNTWyih/dqrYaUAOShmQPk+ih+AS3eyabTPrlC2ezMn+uYXmFFKDA5/opt5hQznQsi
         C2+nnl8cpbwChX0Rli38zrkfman+JuVnxm3zHVPzBNVM5mCCyxnq3H+7OiDnj59BJM4x
         pOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750108943; x=1750713743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvQn+1TbEfDE4ooQ/SlX0ICE7KlQ/7LEuQY+vsTPXU4=;
        b=Y5ggRqO0MfuZOMOJSm/XIHXvVauA7NgPDkc41qE6Icqm9VvmnWz+ZVsgn3WkglCt7s
         mneed7lPD/YWFPZnN7NBTwlp+07xD5QFDucYO7F0bvYpZm2uUz5LNvAR1LY/xDQRWjvV
         7OJnBaEWUa5vzOAQ2PdDwb0VZSM0cjClDcgFjZeAosr7ZJP4wDbtnGE3XeoweJAJzepo
         QvOyJtQoUWzWxCLHJJMdRa3VewCRvUWreo/AUCTyPvzo3zTdUTy//pUJgS/wV3300ATM
         C3MQMbN9DJ81AfcQY3xK7J4YEw/v7R7OI4TnZI9krUsU5Yrey67wG2KhkDY0dT14MCE0
         MnZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSD9b4baIjPC6NI5MpVH9eWfjfxZg39I0RYFU76ySV2RCkE15I1VpRR5aNFTXWOy9Qtd1Ho+ILX8dr@vger.kernel.org, AJvYcCX51Pvg6FclifC2nftm1ju0/kKa+70hdaDGwKcpG3QwlBPqWG3kplOSjiFYqzI0pOfZ96uwY12oIUUoM9A9@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0LubhSXhyjXI7wUhdU74thZmpcHEIJ9iKAsEff9cCVG1ZOomE
	q7X4z6gux8PYww9jJoTfyVETor1+sheYRal1JrqTTRsV6QHsddPO1HRk
X-Gm-Gg: ASbGnctjQYd1mam5VQuPISXKztLt8bv4OUqHisfUkJ3MHtuUTRXlMDL/PVF7H0l9JdD
	U0S4062jaR0bj5Ha/Uw78/tejUbjtlbhXIMHIJhYqc1Q8Jkm6/mecn1UOT7nWrSSSubn71e94GL
	TDP+ywS8yUszH99eKqmTLwguQCE3uMS3HUESgfG4hN4RY6EbgrRpEilSSRd3iH1Iu0bD84jY1YM
	AOR2wRGyPUuxn82KCmRcN2oliw2BlfiYAH496H4Sf+qgahbGVjGBCsZk/8zkmnEYavi6X/Em5Yi
	BwVWhYJ2IRBX3VdXi0yWiHpe3Hs3L7tYDt/tm9afkRGu+CQFbZlKCFYCvlKN8/bHRa96IcY=
X-Google-Smtp-Source: AGHT+IGpFz/Q3p0sRXB2oRHdMs4EeBp8/ZiFSJkNDMRZCOxC/Ubhm/09pNPvWWih+vx7VaAhyLplSA==
X-Received: by 2002:a05:690c:c11:b0:702:d85:5347 with SMTP id 00721157ae682-7117555004bmr150011637b3.36.1750108943284;
        Mon, 16 Jun 2025 14:22:23 -0700 (PDT)
Received: from localhost.localdomain ([192.34.165.40])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7117bc177d3sm10418837b3.44.2025.06.16.14.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 14:22:22 -0700 (PDT)
From: John Clark <inindev@gmail.com>
To: heiko@sntech.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Clark <inindev@gmail.com>
Subject: [PATCH v1 2/2] arm64: dts: rockchip: Add FriendlyElec NanoPi M5 support
Date: Mon, 16 Jun 2025 17:22:14 -0400
Message-Id: <20250616212214.139585-3-inindev@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250616212214.139585-1-inindev@gmail.com>
References: <20250616212214.139585-1-inindev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree for FriendlyElec NanoPi M5 with Rockchip RK3576 SoC
(4x Cortex-A72, 4x Cortex-A53, Mali-G52 MC3 GPU, 6 TOPS NPU). Enables
basic booting and connectivity.

Supported features:
- RK3576 SoC
- 4GB/8GB/16GB LPDDR4X/LPDDR5 RAM
- 16MB SPI Nor Flash
- 2x 1Gbps Ethernet
- 2x USB 3.2 Gen 1 Type-A ports
- microSD UHS-I
- M.2 M-Key PCIe 2.1 x1 NVMe support
- HDMI 1.4/2.0 (up to 4096x2304@60Hz)
- 30-pin GPIO (2x SPI, 4x UART, 3x I2C, 5x PWM, 20x GPIO)
- Debug UART
- RTC with HYM8563TS
- Power via USB-C (PD, 6V~20V)

Signed-off-by: John Clark <inindev@gmail.com>
---
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3576-nanopi-m5.dts    | 969 ++++++++++++++++++
 2 files changed, 970 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index b813866ba283..2c731890d18b 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -147,6 +147,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5-io-expander.dtbo
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-armsom-sige5.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-evb1-v10.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-luckfox-omni3576.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-nanopi-m5.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-roc-pc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3576-rock-4d.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3582-radxa-e52c.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dts b/arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dts
new file mode 100644
index 000000000000..373c1237b41b
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3576-nanopi-m5.dts
@@ -0,0 +1,969 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2025 FriendlyElec Computer Tech. Co., Ltd.
+ * Copyright (c) 2025 John Clark <inindev@gmail.com>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/pwm/pwm.h>
+#include <dt-bindings/soc/rockchip,vop2.h>
+#include <dt-bindings/usb/pd.h>
+#include "rk3576.dtsi"
+
+/ {
+	model = "FriendlyElec NanoPi M5";
+	compatible = "friendlyarm,nanopi-m5", "rockchip,rk3576";
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
+	gpio_keys: gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&key1_pin>;
+
+		button@1 {
+			debounce-interval = <50>;
+			gpios = <&gpio1 RK_PA0 GPIO_ACTIVE_LOW>;
+			label = "K1";
+			linux,code = <BTN_1>;
+			wakeup-source;
+		};
+	};
+
+	gpio_leds: gpio-leds {
+		compatible = "gpio-leds";
+
+		sys_led: led-0 {
+			gpios = <&gpio2 RK_PB3 GPIO_ACTIVE_HIGH>;
+			label = "sys_led";
+			linux,default-trigger = "heartbeat";
+			pinctrl-names = "default";
+			pinctrl-0 = <&sys_led_pin>;
+		};
+
+		lan_led: led-1 {
+			gpios = <&gpio2 RK_PB0 GPIO_ACTIVE_HIGH>;
+			label = "lan_led";
+			pinctrl-names = "default";
+			pinctrl-0 = <&lan_led_pin>;
+		};
+
+		wan_led: led-2 {
+			gpios = <&gpio4 RK_PC5 GPIO_ACTIVE_HIGH>;
+			label = "wan_led";
+			pinctrl-names = "default";
+			pinctrl-0 = <&wan_led_pin>;
+		};
+	};
+
+	hdmi-con {
+		compatible = "hdmi-connector";
+		hdmi-pwr-supply = <&vcc_5v0_hdmi>;
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		pinctrl-names = "default";
+		pinctrl-0 = <&hp_det>;
+
+		simple-audio-card,format = "i2s";
+		simple-audio-card,hp-det-gpios = <&gpio2 RK_PD6 GPIO_ACTIVE_LOW>;
+		simple-audio-card,mclk-fs = <256>;
+		simple-audio-card,name = "realtek,rt5616-codec";
+
+		simple-audio-card,routing =
+			"Headphones", "HPOL",
+			"Headphones", "HPOR",
+			"IN1P", "Microphone Jack";
+		simple-audio-card,widgets =
+			"Headphone", "Headphone Jack",
+			"Microphone", "Microphone Jack";
+
+		simple-audio-card,codec {
+			sound-dai = <&rt5616>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai2>;
+		};
+	};
+
+	vcc_12v_dcin: regulator-vcc-12v-dcin {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		regulator-name = "vcc_12v_dcin";
+		regulator-state-mem {
+			regulator-on-in-suspend;
+		};
+	};
+
+	vcc_1v1_nldo_s3: regulator-vcc-1v1-nldo-s3 {
+		compatible = "regulator-fixed";
+		regulator-boot-on;
+		regulator-always-on;
+		regulator-min-microvolt = <1100000>;
+		regulator-max-microvolt = <1100000>;
+		regulator-name = "vcc_1v1_nldo_s3";
+		vin-supply = <&vcc_5v0_sys>;
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+
+	vcc_2v0_pldo_s3: regulator-vcc-2v0-pldo-s3 {
+		compatible = "regulator-fixed";
+		regulator-boot-on;
+		regulator-always-on;
+		regulator-min-microvolt = <2000000>;
+		regulator-max-microvolt = <2000000>;
+		regulator-name = "vcc_2v0_pldo_s3";
+		vin-supply = <&vcc_5v0_sys>;
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+
+	vcc_3v3_m2_keym: regulator-vcc-3v3-m2_keym {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio0 RK_PD3 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pcie_m2_pwren>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-name = "vcc_3v3_m2_keym";
+		vin-supply = <&vcc_5v0_sys>;
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+
+	vcc_3v3_s0: regulator-vcc-3v3-s0 {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-name = "vcc_3v3_s0";
+		vin-supply = <&vcc_3v3_s3>;
+		regulator-state-mem {
+			regulator-on-in-suspend;
+		};
+	};
+
+	vcc_3v3_sd_s0: regulator-vcc-3v3-sd-s0 {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio0 RK_PB6 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sd_s0_pwren>;
+		regulator-boot-on;
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3000000>;
+		regulator-name = "vcc_3v3_sd_s0";
+		vin-supply = <&vcc_3v3_s3>;
+		regulator-state-mem {
+			regulator-on-in-suspend;
+		};
+	};
+
+	vcc_5v0_device: regulator-vcc-5v0-device {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-name = "vcc_5v0_device";
+		vin-supply = <&vcc_12v_dcin>;
+		regulator-state-mem {
+			regulator-on-in-suspend;
+		};
+	};
+
+	vcc_5v0_hdmi: regulator-vcc-5v0-hdmi {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio4 RK_PC6 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdmi_con_en>;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-name = "vcc_5v0_hdmi";
+		vin-supply = <&vcc_5v0_sys>;
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+
+	vcc_5v0_host: regulator-vcc-5v0-host {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio0 RK_PC7 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb_host_pwren>;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-name = "vcc_5v0_host";
+		vin-supply = <&vcc_5v0_device>;
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+
+	vcc_5v0_otg: regulator-vcc-5v0-otg {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio0 RK_PD1 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb_otg0_pwren>;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-name = "vcc_5v0_otg";
+		vin-supply = <&vcc_5v0_device>;
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+
+	vcc_5v0_sys: regulator-vcc-5v0-sys {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-name = "vcc_5v0_sys";
+		vin-supply = <&vcc_12v_dcin>;
+		regulator-state-mem {
+			regulator-on-in-suspend;
+		};
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
+&fspi1m1_pins {
+	rockchip,pins =
+		/* clk, d0~4 */
+		<1 RK_PD5 3 &pcfg_pull_none>,
+		<1 RK_PC4 3 &pcfg_pull_none>,
+		<1 RK_PC5 3 &pcfg_pull_none>,
+		<1 RK_PC6 3 &pcfg_pull_none>,
+		<1 RK_PC7 3 &pcfg_pull_none>;
+};
+
+&gmac0 {
+	clock_in_out = "output";
+	phy-handle = <&rgmii_phy0>;
+	phy-mode = "rgmii-id";
+	phy-supply = <&vcc_3v3_s3>;
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
+	phy-handle = <&rgmii_phy1>;
+	phy-mode = "rgmii-id";
+	phy-supply = <&vcc_3v3_s3>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&eth1m0_miim
+		     &eth1m0_tx_bus2
+		     &eth1m0_rx_bus2
+		     &eth1m0_rgmii_clk
+		     &eth1m0_rgmii_bus>;
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
+		#gpio-cells = <2>;
+		gpio-controller;
+		interrupt-parent = <&gpio0>;
+		interrupts = <6 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
+			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
+		system-power-controller;
+
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
+		rk806_dvs1_null: rk806_dvs1_null {
+			pins = "gpio_pwrctrl1";
+			function = "pin_fun0";
+		};
+
+		rk806_dvs1_slp: rk806_dvs1_slp {
+			pins = "gpio_pwrctrl1";
+			function = "pin_fun1";
+		};
+
+		rk806_dvs1_pwrdn: rk806_dvs1_pwrdn {
+			pins = "gpio_pwrctrl1";
+			function = "pin_fun2";
+		};
+
+		rk806_dvs1_rst: rk806_dvs1_rst {
+			pins = "gpio_pwrctrl1";
+			function = "pin_fun3";
+		};
+
+		rk806_dvs2_null: rk806_dvs2_null {
+			pins = "gpio_pwrctrl2";
+			function = "pin_fun0";
+		};
+
+		rk806_dvs2_slp: rk806_dvs2_slp {
+			pins = "gpio_pwrctrl2";
+			function = "pin_fun1";
+		};
+
+		rk806_dvs2_pwrdn: rk806_dvs2_pwrdn {
+			pins = "gpio_pwrctrl2";
+			function = "pin_fun2";
+		};
+
+		rk806_dvs2_rst: rk806_dvs2_rst {
+			pins = "gpio_pwrctrl2";
+			function = "pin_fun3";
+		};
+
+		rk806_dvs2_dvs: rk806_dvs2_dvs {
+			pins = "gpio_pwrctrl2";
+			function = "pin_fun4";
+		};
+
+		rk806_dvs2_gpio: rk806_dvs2_gpio {
+			pins = "gpio_pwrctrl2";
+			function = "pin_fun5";
+		};
+
+		rk806_dvs3_null: rk806_dvs3_null {
+			pins = "gpio_pwrctrl3";
+			function = "pin_fun0";
+		};
+
+		rk806_dvs3_slp: rk806_dvs3_slp {
+			pins = "gpio_pwrctrl3";
+			function = "pin_fun1";
+		};
+
+		rk806_dvs3_pwrdn: rk806_dvs3_pwrdn {
+			pins = "gpio_pwrctrl3";
+			function = "pin_fun2";
+		};
+
+		rk806_dvs3_rst: rk806_dvs3_rst {
+			pins = "gpio_pwrctrl3";
+			function = "pin_fun3";
+		};
+
+		rk806_dvs3_dvs: rk806_dvs3_dvs {
+			pins = "gpio_pwrctrl3";
+			function = "pin_fun4";
+		};
+
+		rk806_dvs3_gpio: rk806_dvs3_gpio {
+			pins = "gpio_pwrctrl3";
+			function = "pin_fun5";
+		};
+
+		regulators {
+			vdd_cpu_big_s0: dcdc-reg1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-enable-ramp-delay = <400>;
+				regulator-min-microvolt = <550000>;
+				regulator-max-microvolt = <950000>;
+				regulator-name = "vdd_cpu_big_s0";
+				regulator-ramp-delay = <12500>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_npu_s0: dcdc-reg2 {
+				regulator-boot-on;
+				regulator-enable-ramp-delay = <400>;
+				regulator-min-microvolt = <550000>;
+				regulator-max-microvolt = <950000>;
+				regulator-name = "vdd_npu_s0";
+				regulator-ramp-delay = <12500>;
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
+				regulator-name = "vdd_cpu_lit_s0";
+				regulator-ramp-delay = <12500>;
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
+				regulator-enable-ramp-delay = <400>;
+				regulator-min-microvolt = <550000>;
+				regulator-max-microvolt = <900000>;
+				regulator-name = "vdd_gpu_s0";
+				regulator-ramp-delay = <12500>;
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
+	hym8563: hym8563@51 {
+		compatible = "haoyu,hym8563";
+		reg = <0x51>;
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "hym8563";
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA5 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hym8563_int>;
+		wakeup-source;
+	};
+};
+
+&i2c5 {
+	clock-frequency = <200000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c5m3_xfer>;
+	status = "okay";
+
+	rt5616: audio-codec@1b {
+		compatible = "realtek,rt5616";
+		reg = <0x1b>;
+		assigned-clocks = <&cru CLK_SAI2_MCLKOUT>;
+		assigned-clock-rates = <12288000>;
+		clocks = <&cru CLK_SAI2_MCLKOUT>;
+		clock-names = "mclk";
+		#sound-dai-cells = <0>;
+	};
+};
+
+&mdio0 {
+	rgmii_phy0: phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x1>;
+		clocks = <&cru REFCLKO25M_GMAC0_OUT>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <RK_PB1 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&gmac0_int>;
+		reset-assert-us = <20000>;
+		reset-deassert-us = <100000>;
+		reset-gpios = <&gpio2 RK_PB5 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&mdio1 {
+	rgmii_phy1: phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x1>;
+		clocks = <&cru REFCLKO25M_GMAC1_OUT>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <RK_PA2 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&gmac1_int>;
+		reset-assert-us = <20000>;
+		reset-deassert-us = <100000>;
+		reset-gpios = <&gpio3 RK_PA3 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&pcie0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_m2_reset>;
+	reset-gpios = <&gpio2 RK_PB4 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc_3v3_m2_keym>;
+	status = "okay";
+};
+
+&pinctrl {
+	gpio-key {
+		key1_pin: key1-pin {
+			rockchip,pins = <4 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	gpio-leds {
+		sys_led_pin: sys-led-pin {
+			rockchip,pins = <2 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+		lan_led_pin: lan-led-pin {
+			rockchip,pins = <2 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+		wan_led_pin: wan-led-pin {
+			rockchip,pins = <4 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	gmac {
+		gmac0_int: gmac0-int {
+			rockchip,pins = <2 RK_PB1 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+		gmac0_rst: gmac0-rst {
+			rockchip,pins = <2 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+		gmac1_int: gmac1-int {
+			rockchip,pins = <3 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+		gmac1_rst: gmac1-rst {
+			rockchip,pins = <3 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	hdmi {
+		hdmi_con_en: hdmi-con-en {
+			rockchip,pins = <4 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	headphone {
+		hp_det: hp-det {
+			rockchip,pins = <2 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	hym8563 {
+		hym8563_int: hym8563-int {
+			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	pcie {
+		pcie_m2_pwren: pcie-m2-pwren {
+			rockchip,pins = <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+		pcie_m2_reset: pcie-m2-reset {
+			rockchip,pins = <2 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	sdmmc {
+		sd_s0_pwren: sd-s0-pwren {
+			rockchip,pins = <0 RK_PB6 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	usb {
+		usb_host_pwren: usb-host-pwren {
+			rockchip,pins = <0 RK_PC7 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+		usb_otg0_pwren: usb-otg0-pwren {
+			rockchip,pins = <0 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&rng {
+	status = "okay";
+};
+
+&sai2 {
+	status = "okay";
+};
+
+&saradc {
+	status = "okay";
+	vref-supply = <&vcca_1v8_s0>;
+};
+
+&sdmmc {
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	disable-wp;
+	no-mmc;
+	no-sdio;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc0_clk &sdmmc0_cmd &sdmmc0_det &sdmmc0_bus4>;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vcc_3v3_s3>;
+	vqmmc-supply = <&vcc_3v3_sd_s0>;
+	status = "okay";
+};
+
+&sfc1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&fspi1m1_csn0 &fspi1m1_pins>;
+	status = "okay";
+
+	spi-nor@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		m25p,fast-read;
+		spi-max-frequency = <20000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <1>;
+		vcc-supply = <&vcc_1v8_s3>;
+	};
+};
+
+&u2phy0 {
+	status = "okay";
+};
+
+&u2phy0_otg {
+	phy-supply = <&vcc_5v0_otg>;
+	status = "okay";
+};
+
+&u2phy1 {
+	status = "okay";
+};
+
+&u2phy1_otg {
+	phy-supply = <&vcc_5v0_host>;
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&usbdp_phy {
+	status = "okay";
+};
+
+&usb_drd0_dwc3 {
+	dr_mode = "otg";
+	extcon = <&u2phy0>;
+	status = "okay";
+};
+
+&usb_drd1_dwc3 {
+	dr_mode = "host";
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
+
+&wdt {
+	status= "okay";
+};
-- 
2.39.5



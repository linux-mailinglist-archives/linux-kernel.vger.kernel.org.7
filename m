Return-Path: <linux-kernel+bounces-862340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B6EBF508F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AD9B4F6DCF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A390E292938;
	Tue, 21 Oct 2025 07:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="FknXXbVc"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F5128488D;
	Tue, 21 Oct 2025 07:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032614; cv=none; b=SAE/uZ3VXOXWNrmI9ML+PDP/Q8M8ymdKV+hFQAPJ2gvx1v5Xhw0wHBi67ieH0+lk+A6F53Njf3S1N6dFuBA+YDDECEmHYW425a63d/2rrCrsBmaFvkC1ZiAys6+B99ZOffhfayvnyjzr3rsD10XEyuelU3cQQJjCKg4IxQS/olI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032614; c=relaxed/simple;
	bh=YjVPqwonj1/rJ828kwmhAUxbBCmMqwjbewzqyVCGYiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDH8vctvSGoctUWg05F9J9ShEKoOuhVoVUn75Id1h0KFBkKOvw8hbYUmmrD+ATxD2WpXtw9UjL+DUBtg+j1m/J7uj2busHOdjM95a1+9f3eq7wXgIlyTlYxYnm5tNOaK6FOI57HsjukN8MJIT9gKUNuhPhjGEnqemm/xdvofkWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=FknXXbVc; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=OUNye3HxeUTkEv5mR8T9fjHeXru/yz+Ueb4MLuCjw/U=; b=FknXXbVc+AL84Jf0OleZjxYmRq
	25eomfdtP+fEGs33x3mvXmhvS019aKYeMy9GK9b6FlMkkh5I05TD8FpM209gLcqvFzpLREUxqtgEH
	2VwR9I21xYiqe4AWMSmerkE+WMdf/AMPRmtOAlrmGV3N7gwsmue9HNml+g3VhFvaGGvDB3PIXELzq
	Q0rwvy4UrbUUhHY7JeqEv5iok+MkeI3vcOLk/hBPyu87mAp73+NYMPVHbYagFHI8P250DzKy9UQfb
	HAkcPYsfCJ3VH4aYFJ8tFyLKptc9KTv+d+UzHBTPJ27/k6jNAYyEw6s5/J+t1CiydgVCMxWIB2JbU
	QPKbWVLQ==;
Received: from [212.111.240.218] (helo=phil.guestnet.ukdd.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vB71Q-0000uy-70; Tue, 21 Oct 2025 09:43:08 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	quentin.schulz@cherry.de,
	andy.yan@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	cn.liweihao@gmail.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH v2 9/9] arm64: dts: rockchip: Add the Video-Demo overlay for Lion Haikou
Date: Tue, 21 Oct 2025 09:42:54 +0200
Message-ID: <20251021074254.87065-10-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251021074254.87065-1-heiko@sntech.de>
References: <20251021074254.87065-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The video-demo adapter also works on the Lion SoM when running
on a Haikou baseboard, so add an overlay for it.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 arch/arm64/boot/dts/rockchip/Makefile         |   5 +
 .../rk3368-lion-haikou-video-demo.dtso        | 174 ++++++++++++++++++
 2 files changed, 179 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3368-lion-haikou-video-demo.dtso

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index ad684e3831bc..494fdd685a5c 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -42,6 +42,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-evb-act8846.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-geekbox.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-lba3368.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-lion-haikou.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-lion-haikou-video-demo.dtbo
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-orion-r68-meta.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-px5-evb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-r88.dtb
@@ -231,6 +232,10 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-ringneck-haikou-haikou-video-demo.dtb
 px30-ringneck-haikou-haikou-video-demo-dtbs := px30-ringneck-haikou.dtb \
 	px30-ringneck-haikou-video-demo.dtbo
 
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-lion-haikou-haikou-video-demo.dtb
+rk3368-lion-haikou-haikou-video-demo-dtbs := rk3368-lion-haikou.dtb \
+	rk3368-lion-haikou-video-demo.dtbo
+
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou-haikou-video-demo.dtb
 rk3399-puma-haikou-haikou-video-demo-dtbs := rk3399-puma-haikou.dtb \
 	rk3399-puma-haikou-video-demo.dtbo
diff --git a/arch/arm64/boot/dts/rockchip/rk3368-lion-haikou-video-demo.dtso b/arch/arm64/boot/dts/rockchip/rk3368-lion-haikou-video-demo.dtso
new file mode 100644
index 000000000000..e7767c008144
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3368-lion-haikou-video-demo.dtso
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2025 Cherry Embedded Solutions GmbH
+ *
+ * DEVKIT ADDON CAM-TS-A01
+ * https://embedded.cherry.de/product/development-kit/
+ *
+ * DT-overlay for the camera / DSI demo appliance for Haikou boards.
+ * In the flavour for use with a Puma system-on-module.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/clock/rk3368-cru.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+
+&{/} {
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		power-supply = <&dc_12v>;
+		pwms = <&pwm1 0 25000 0>;
+	};
+
+	cam_afvdd_2v8: regulator-cam-afvdd-2v8 {
+		compatible = "regulator-fixed";
+		gpio = <&pca9670 2 GPIO_ACTIVE_LOW>;
+		regulator-max-microvolt = <2800000>;
+		regulator-min-microvolt = <2800000>;
+		regulator-name = "cam-afvdd-2v8";
+		vin-supply = <&vcc2v8_video>;
+	};
+
+	cam_avdd_2v8: regulator-cam-avdd-2v8 {
+		compatible = "regulator-fixed";
+		gpio = <&pca9670 4 GPIO_ACTIVE_LOW>;
+		regulator-max-microvolt = <2800000>;
+		regulator-min-microvolt = <2800000>;
+		regulator-name = "cam-avdd-2v8";
+		vin-supply = <&vcc2v8_video>;
+	};
+
+	cam_dovdd_1v8: regulator-cam-dovdd-1v8 {
+		compatible = "regulator-fixed";
+		gpio = <&pca9670 3 GPIO_ACTIVE_LOW>;
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "cam-dovdd-1v8";
+		vin-supply = <&vcc1v8_video>;
+	};
+
+	cam_dvdd_1v2: regulator-cam-dvdd-1v2 {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&pca9670 5 GPIO_ACTIVE_HIGH>;
+		regulator-max-microvolt = <1200000>;
+		regulator-min-microvolt = <1200000>;
+		regulator-name = "cam-dvdd-1v2";
+		vin-supply = <&vcc3v3_baseboard>;
+	};
+
+	vcc1v8_video: regulator-vcc1v8-video {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "vcc1v8-video";
+		vin-supply = <&vcc3v3_baseboard>;
+	};
+
+	vcc2v8_video: regulator-vcc2v8-video {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <2800000>;
+		regulator-min-microvolt = <2800000>;
+		regulator-name = "vcc2v8-video";
+		vin-supply = <&vcc3v3_baseboard>;
+	};
+
+	video-adapter-leds {
+		compatible = "gpio-leds";
+
+		video-adapter-led {
+			color = <LED_COLOR_ID_BLUE>;
+			gpios = <&pca9670 7 GPIO_ACTIVE_HIGH>;
+			label = "video-adapter-led";
+			linux,default-trigger = "none";
+		};
+	};
+};
+
+&dphy {
+	status = "okay";
+};
+
+&i2c_gp2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	/* OV5675, GT911, DW9714 are limited to 400KHz */
+	clock-frequency = <400000>;
+
+	touchscreen@14 {
+		compatible = "goodix,gt911";
+		reg = <0x14>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <RK_PB5 IRQ_TYPE_LEVEL_LOW>;
+		irq-gpios = <&gpio1 RK_PB5 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&touch_int>;
+		pinctrl-names = "default";
+		reset-gpios = <&pca9670 1 GPIO_ACTIVE_HIGH>;
+		AVDD28-supply = <&vcc2v8_video>;
+		VDDIO-supply = <&vcc3v3_baseboard>;
+	};
+
+	pca9670: gpio@27 {
+		compatible = "nxp,pca9670";
+		reg = <0x27>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		pinctrl-0 = <&pca9670_resetn>;
+		pinctrl-names = "default";
+		reset-gpios = <&gpio1 RK_PA5 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&mipi_dsi {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	panel@0 {
+		compatible = "leadtek,ltk050h3148w";
+		reg = <0>;
+		backlight = <&backlight>;
+		iovcc-supply = <&vcc1v8_video>;
+		reset-gpios = <&pca9670 0 GPIO_ACTIVE_LOW>;
+		vci-supply = <&vcc2v8_video>;
+
+		port {
+			mipi_in_panel: endpoint {
+				remote-endpoint = <&mipi_out_panel>;
+			};
+		};
+	};
+};
+
+&mipi_out {
+	mipi_out_panel: endpoint {
+		remote-endpoint = <&mipi_in_panel>;
+	};
+};
+
+&pinctrl {
+	pca9670 {
+		pca9670_resetn: pca9670-resetn {
+			rockchip,pins = <1 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	touch {
+		touch_int: touch-int {
+			rockchip,pins = <1 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&pwm1 {
+	status = "okay";
+};
\ No newline at end of file
-- 
2.47.2



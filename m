Return-Path: <linux-kernel+bounces-847541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B39BCB253
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 00:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B26A4F2031
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 22:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCAD2874E9;
	Thu,  9 Oct 2025 22:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="wbVu8Qlh"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21453286D5D;
	Thu,  9 Oct 2025 22:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760050273; cv=none; b=QD3T1kcZzhn5QhpLrQVA+yk6veRjFHD/J6tql/h8SN/45iLTbUx1qdmndKDyhy+iIQw6YaCncc3rn1WYhNtQ++Y58BogQHbDMRbEbsczDhOfSUiE7xd1wlipCbfv6LzcBhK9Bq/IdbJur/42m/mycp3scnpuEMshxf+o+jBgM2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760050273; c=relaxed/simple;
	bh=IgnJBxZEUSCvlO0lpVIttFhzmmW+v7dZz/9Sn5YUF7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fB9STFXoU32fg1lSPL9Ex/y7db6EjKZtnyNNPBgooU1a0Kl5LEfT1hGycWPeDH24sGhv+vFOY9TZdb2JzEVwJnl28vEb31kcBismIqYXO2CXRLG3iWeyWpyPbINLEno2YbMi5PiRFGdT+BDDGa/RVEayeHeeb44Hg990AgdbFes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=wbVu8Qlh; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=Mz4zW/8ybo2FVuF3EvnWzYzX2g9pikplV9oTmQ+OqzI=; b=wbVu8QlhXoKKI/AWKJVvhQ5bRf
	yd7Bb9B0qyEUjyBj4N4QNkgUAkbsZeeaaV+rD45tbd9pDvehoGUuPMpQSBAJLuQ/O7tNIhzfOjpwj
	iojH1TcJwBlHsG2Ecae5PIwyBAc4QbuLRAd0PVoFkjC+2NV2zPl+gJLUobjZE9t8Yh/WvuN0wBkNe
	SMJtAI06HQglZsJn3r3gXjJnTVQ5St0FJAk1eyDUZksHC0WAxRlEGPAnxAt+fudhkEg/Nc8dzQ0xD
	9t+mStmY/FejRRzslAoiKR9srTohjg6NGxV399a1LhYc8fbuEfZeVAOM0HV2aY7VpFY2XmdPwhfdi
	iTVkQmGw==;
Received: from i53875bdd.versanet.de ([83.135.91.221] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1v6zTT-0007iZ-54; Fri, 10 Oct 2025 00:51:03 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	quentin.schulz@cherry.de,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	damon.ding@rock-chips.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH v4 2/2] arm64: dts: rockchip: add RK3588 DP carrier from Theobroma Systems
Date: Fri, 10 Oct 2025 00:50:50 +0200
Message-ID: <20251009225050.88192-3-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251009225050.88192-1-heiko@sntech.de>
References: <20251009225050.88192-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The DisplayPort carrier is a very simple baseboard only providing serial,
ethernet and a displayport output.

But its main functionality is that it routes the Analogix eDP controller
to this DisplayPort output, which allows to test that controller simply
by hooking it up to a suitable monitor.

The Analogix-DP controller supports eDP 1.3 and DP 1.2, so can drive
both eDP displays as well as full DP monitors. It does not support DP+
so passive DP-to-HDMI adapters won't work.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
Link: https://lore.kernel.org/r/20250723190904.37792-3-heiko@sntech.de
---
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../rk3588-tiger-displayport-carrier.dts      | 119 ++++++++++++++++++
 2 files changed, 120 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-tiger-displayport-carrier.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index ad684e3831bc..3a1739b8f167 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -188,6 +188,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b-pcie-ep.dtbo
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b-pcie-srns.dtbo
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b-plus.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5t.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-tiger-displayport-carrier.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-tiger-haikou.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-tiger-haikou-video-demo.dtbo
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-toybrick-x0.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger-displayport-carrier.dts b/arch/arm64/boot/dts/rockchip/rk3588-tiger-displayport-carrier.dts
new file mode 100644
index 000000000000..c14718bc4fda
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger-displayport-carrier.dts
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2024 Cherry Embedded Solutions GmbH
+ */
+
+/dts-v1/;
+#include <dt-bindings/soc/rockchip,vop2.h>
+#include "rk3588-tiger.dtsi"
+
+/ {
+	model = "Theobroma Systems RK3588-Q7 SoM on Tiger Displayport Carrier v1";
+	compatible = "tsd,rk3588-tiger-displayport-carrier", "tsd,rk3588-tiger", "rockchip,rk3588";
+
+	aliases {
+		ethernet0 = &gmac0;
+	};
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+
+	dp-connector {
+		compatible = "dp-connector";
+		dp-pwr-supply = <&vcc3v3_baseboard>;
+		label = "dp0";
+		type = "full-size";
+
+		port {
+			dp_con_in: endpoint {
+				remote-endpoint = <&edp0_out_con>;
+			};
+		};
+	};
+
+	vcc3v3_baseboard: regulator-vcc3v3-baseboard {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_baseboard";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc5v0_baseboard>;
+	};
+
+	vcc5v0_baseboard: regulator-vcc5v0-baseboard {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_baseboard";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+};
+
+&edp0 {
+	/*
+	 * Q7_DP_HPD# but Q7_HDMI_HPD# could be used too
+	 *
+	 * HPD handling in the Analogix-DP not in dp-connector, because
+	 * "Detecting the monitor for DisplayPort targets is more
+	 *  complicated than just reading the HPD pin level" so the
+	 * "actual DP driver (should) perform detection".
+	 * For reference see commit cb640b2ca546 ("drm/bridge:
+	 * display-connector: don't set OP_DETECT for DisplayPorts")
+	 * in the Linux-kernel.
+	 */
+	hpd-gpios = <&gpio4 RK_PB5 GPIO_ACTIVE_LOW>;
+	pinctrl-0 = <&edp0_hpd_l>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&edp0_in {
+	edp0_in_vp2: endpoint {
+		remote-endpoint = <&vp2_out_edp0>;
+	};
+};
+
+&edp0_out {
+	edp0_out_con: endpoint {
+		remote-endpoint = <&dp_con_in>;
+	};
+};
+
+&gmac0 {
+	status = "okay";
+};
+
+&hdptxphy0 {
+	status = "okay";
+};
+
+&pinctrl {
+	edp0 {
+		edp0_hpd_l: edp0-hpd-l-pin {
+			rockchip,pins = <4 RK_PB5 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+};
+
+&uart2 {
+	pinctrl-0 = <&uart2m2_xfer>;
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
+&vp2 {
+	vp2_out_edp0: endpoint@ROCKCHIP_VOP2_EP_EDP0 {
+		reg = <ROCKCHIP_VOP2_EP_EDP0>;
+		remote-endpoint = <&edp0_in_vp2>;
+	};
+};
-- 
2.47.2



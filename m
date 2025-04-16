Return-Path: <linux-kernel+bounces-604419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2C0A89438
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 08:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441DA189CAB1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 06:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED87E27A92E;
	Tue, 15 Apr 2025 06:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIokKPYK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CEA275852;
	Tue, 15 Apr 2025 06:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744700068; cv=none; b=Q1hfrPKsPKmUDs1pAJvAkIkpM1iqZB0OpWKAaYHgfNBJ3Cum22kzO43GD8v88k1xaL/7hUdJfKwSrp7NYtj87kyxdy+0SoEru1XpzVo+40rUymhq71+gDPM9LATk/qkH1YHgamCAq8piw9c7ayyznGutGrGhKSv5FVFXt58F3pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744700068; c=relaxed/simple;
	bh=t81Qw4Tdq4zyeXM0XoGcLedwtexGRTgw9YTa5p4hlw4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SLWm4t1TuXVXlJKsQMq1NbWNrLLcuyo6hQBzKd6YJN7z7BR+lTnxEV9BccqoZP8GjKJ7tNSI9xyfCyLRs/ZnYPS1Y932XZG9UBkN+wdiPQnOqg7vXSbui7fCNFkCpxwZY80YNzb3b/pKkODgMtnS/p0/htXNvn6sCafpIfjkbHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIokKPYK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6050AC4AF16;
	Tue, 15 Apr 2025 06:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744700068;
	bh=t81Qw4Tdq4zyeXM0XoGcLedwtexGRTgw9YTa5p4hlw4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TIokKPYKzdIES7LeXP29mDsm5n5p7xYJblY/c+wpKozb+CYnNScGRUlo+cd1G5hD8
	 Jwjlq52Hg34hylva+JbMcEstRnOYanLVh7gJizIH96g1TxhL8mWniIffExaoUb62C5
	 rXkhhpQ+OZVg98t0v5RXJ5nMLae9QeLrtydx00N9kkRkQyPpdezkY15v2Un44qIF/D
	 2lmtX3v4vZTb9GvWauwSz1HPAr0JS2Mk9ZmkZQ34jybf8YF++rwQbfmIgDQ0T1k+sd
	 i0o4j9OxZf6fSyUfsPFKgPdh8cXoltmxgJvsKuiPsaFKVFTPueZ67b9aoindGnzlGl
	 EkkNcAeVWNdtA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571E5C369B9;
	Tue, 15 Apr 2025 06:54:28 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Tue, 15 Apr 2025 08:54:30 +0200
Subject: [PATCH v5 7/8] arm64: dts: freescale: Add the BOE av101hdt-a10
 variant of the Moduline Display
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-initial_display-v5-7-f309f8d71499@gocontroll.com>
References: <20250415-initial_display-v5-0-f309f8d71499@gocontroll.com>
In-Reply-To: <20250415-initial_display-v5-0-f309f8d71499@gocontroll.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Maud Spierings <maudspierings@gocontroll.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744700066; l=4109;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=s+YSWWHZ/qWjR5g3Aj0fP/WU0u7E8mEW6X2vsCVzyKY=;
 b=w4aTIeB1PGcNKrtNZlrn6+QEL/R5AfdfAIuUND5G1muYX3zbuwVOEzhx+wpxdqp9p+b8FUr8l
 DjcCsD8C7JrBCvpsCUa/O8OVCvqIMPByAIPUVXLtpm0Hj1iKWrb6ZyF
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

Add the BOE av101hdt-a10 variant of the Moduline Display, this variant
comes with a 10.1 1280x720 display with a touchscreen (not working in
mainline).

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>

---
Currently the backlight driver is not available, this will be upstreamed
in a future patch series. It is a Maxim max25014atg.

The touchscreen has a Cypress CYAT81658-64AS48 controller which as far as
I know is not supported upstream, the driver we currently use for this is
a mess and I doubt we will be able to get it in an upstreamable state.
---
 arch/arm64/boot/dts/freescale/Makefile             |  5 ++
 ...x8p-ml81-moduline-display-106-av101hdt-a10.dtso | 94 ++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index b6d3fe26d621234ab84353165d20af9d2536f839..ca3255aa9e18187b33d54c836992aca5dd5d0465 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -214,6 +214,11 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revc-bd500.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-skov-revc-tian-g07017.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-tqma8mpql-mba8mpxl.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-tqma8mpql-mba8mp-ras314.dtb
+
+imx8mp-tx8p-ml81-moduline-display-106-av101hdt-a10-dtbs += imx8mp-tx8p-ml81-moduline-display-106.dtb \
+	imx8mp-tx8p-ml81-moduline-display-106-av101hdt-a10.dtbo
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-tx8p-ml81-moduline-display-106-av101hdt-a10.dtb
+
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-var-som-symphony.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw71xx-2x.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw72xx-2x.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-tx8p-ml81-moduline-display-106-av101hdt-a10.dtso b/arch/arm64/boot/dts/freescale/imx8mp-tx8p-ml81-moduline-display-106-av101hdt-a10.dtso
new file mode 100644
index 0000000000000000000000000000000000000000..b3bbbd69f671493c809bbf043807a22adda5024a
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-tx8p-ml81-moduline-display-106-av101hdt-a10.dtso
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2025 GOcontroll B.V.
+ * Author: Maud Spierings <maudspierings@gocontroll.com>
+ */
+
+#include <dt-bindings/clock/imx8mp-clock.h>
+#include <dt-bindings/gpio/gpio.h>
+
+#include "imx8mp-pinfunc.h"
+
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	model = "GOcontroll Moduline Display with BOE av101hdt-a10 display";
+
+	panel {
+		compatible = "boe,av101hdt-a10";
+		enable-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&pinctrl_panel>;
+		pinctrl-names = "default";
+		power-supply = <&reg_3v3_per>;
+		reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
+
+		port {
+			panel_lvds_in: endpoint {
+				remote-endpoint = <&ldb_lvds_ch0>;
+			};
+		};
+	};
+
+	reg_vbus: regulator-vbus {
+		compatible = "regulator-fixed";
+		power-supply = <&reg_6v4>;
+		regulator-always-on;
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "usb-c-vbus";
+	};
+};
+
+&iomuxc {
+	pinctrl_panel: panelgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO07__GPIO1_IO07
+			MX8MP_DSE_X1
+			MX8MP_IOMUXC_GPIO1_IO09__GPIO1_IO09
+			MX8MP_DSE_X1
+		>;
+	};
+};
+
+&lcdif2 {
+	status = "okay";
+};
+
+&lvds_bridge {
+	assigned-clocks = <&clk IMX8MP_CLK_MEDIA_LDB>, <&clk IMX8MP_VIDEO_PLL1>;
+	/* IMX8MP_VIDEO_PLL1 = IMX8MP_CLK_MEDIA_DISP2_PIX * 2 * 7 */
+	assigned-clock-rates = <0>, <1054620000>;
+	status = "okay";
+
+	ports {
+		port@1 {
+			ldb_lvds_ch0: endpoint {
+				remote-endpoint = <&panel_lvds_in>;
+			};
+		};
+	};
+};
+
+&usb_dwc3_1 {
+	dr_mode = "host";
+
+	connector {
+		compatible = "usb-c-connector";
+		data-role = "host";
+		pd-disable;
+		vbus-supply = <&reg_vbus>;
+
+		port {
+			high_speed_ep: endpoint {
+				remote-endpoint = <&usb1_hs_ep>;
+			};
+		};
+	};
+
+	port {
+		usb1_hs_ep: endpoint {
+			remote-endpoint = <&high_speed_ep>;
+		};
+	};
+};

-- 
2.49.0




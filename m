Return-Path: <linux-kernel+bounces-654999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3734ABCF79
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 08:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7457A7AC0F4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 06:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED83B25E829;
	Tue, 20 May 2025 06:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUE8XaKC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CFB25D209;
	Tue, 20 May 2025 06:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747722894; cv=none; b=PG1ssELsoJwYBHajVRGbDIdTFCtZx4eW+BarKwtl6A1+cvFYQtp9ZscNjA8T0wxkN8RT8y4GbIC8BRT1qIfsQB1TbDTOdj3CyTlfHMvngJDdKDhTGQ8BLv/4ugiP+62ajBF06tSApqQ5z1OKXRiIP5XWMFyAOAZ5oWBeYypk8o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747722894; c=relaxed/simple;
	bh=XNZwlIgBkETjMefqm5oN+G/jvU1gUxJXmVuGN6RmC18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F5ytVIUvLHRwBftfbW8akKM+XqNakhOa3WR21JtbS/HHTVXWbf2WlPOrXOPXr7joB0hfZUDdQZBkYqW1hbr/OGTrc+9LlDMIu23gal0APSGb856VzPvdDFEazKbzcsNO3Xe/JRUpvTl8rciYCwhWGU++L+QrWY1HxGqw9NH4Vqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUE8XaKC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2292DC4CEF9;
	Tue, 20 May 2025 06:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747722894;
	bh=XNZwlIgBkETjMefqm5oN+G/jvU1gUxJXmVuGN6RmC18=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RUE8XaKCcX/fLXciPr5NkbkaFOHp6t+r1CarXo28/oVOO5+5SHOx3JXRBr6UqtLEc
	 6ImfOVb3n+x+hw+9XFSSzyr/TeyDin9VbFf0c+W9vBkD9l0F+nvDv/ON/XY/fDDrcV
	 un7L7I9O2AjZdNbmC+e5gLarCLNH2rtENCJQAcHytmlVNZuWbO5UT4v5AD0iB+yA6P
	 b3alc5bJPaWrn5LkQmCi5qxRP52LjGEc4bqqSW0v8DqkvF8E1dHSYOKKiK8/8SygPJ
	 BNWXqfq24YkIzR564yVc52w3QM9sVOjRHlhfIJTeDPXewuLKwf3qIi7rGCq2JWNPLi
	 djGpM1D2taUqg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184F6C3DA6D;
	Tue, 20 May 2025 06:34:54 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Tue, 20 May 2025 08:34:57 +0200
Subject: [PATCH v7 8/8] arm64: dts: freescale: Add the BOE av123z7m-n17
 variant of the Moduline Display
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-initial_display-v7-8-a8f0195420aa@gocontroll.com>
References: <20250520-initial_display-v7-0-a8f0195420aa@gocontroll.com>
In-Reply-To: <20250520-initial_display-v7-0-a8f0195420aa@gocontroll.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Maud Spierings <maudspierings@gocontroll.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747722892; l=4679;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=I/kM7mq422c2Dzz64Wk+UlUYxhJAYXnl08GlpuY0xJQ=;
 b=Em3JcLOF+AZcj/cesIFFGxpJJRk1UgQymUG4lIianmNrvpJdleBXisY/97A6ncutLANGLCgje
 /8fANl3HpxyDoezIs2hkH7J1pTVoxnZF4KnEZ+YGOWhI1AOuFtuhHMZ
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

Add the BOE av123z7m-n17 variant of the Moduline Display, this variant
comes with a 12.3" 1920x720 display.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>

---
Currently the backlight driver is not available, this will be upstreamed
in a future patch series. It is a Maxim max25014atg.
---
 arch/arm64/boot/dts/freescale/Makefile             |   3 +
 ...x8p-ml81-moduline-display-106-av123z7m-n17.dtso | 139 +++++++++++++++++++++
 2 files changed, 142 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index ca3255aa9e18187b33d54c836992aca5dd5d0465..c821f9eda332abd1db1867dab196c09929316728 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -217,7 +217,10 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-tqma8mpql-mba8mp-ras314.dtb
 
 imx8mp-tx8p-ml81-moduline-display-106-av101hdt-a10-dtbs += imx8mp-tx8p-ml81-moduline-display-106.dtb \
 	imx8mp-tx8p-ml81-moduline-display-106-av101hdt-a10.dtbo
+imx8mp-tx8p-ml81-moduline-display-106-av123z7m-n17-dtbs += imx8mp-tx8p-ml81-moduline-display-106.dtb \
+	imx8mp-tx8p-ml81-moduline-display-106-av123z7m-n17.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-tx8p-ml81-moduline-display-106-av101hdt-a10.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-tx8p-ml81-moduline-display-106-av123z7m-n17.dtb
 
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-var-som-symphony.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw71xx-2x.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-tx8p-ml81-moduline-display-106-av123z7m-n17.dtso b/arch/arm64/boot/dts/freescale/imx8mp-tx8p-ml81-moduline-display-106-av123z7m-n17.dtso
new file mode 100644
index 0000000000000000000000000000000000000000..3eb665ce9d5d2a1c742ffb4feca046e406e29956
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-tx8p-ml81-moduline-display-106-av123z7m-n17.dtso
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2025 GOcontroll B.V.
+ * Author: Maud Spierings <maudspierings@gocontroll.com>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+#include "imx8mp-pinfunc.h"
+
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	model = "GOcontroll Moduline Display with BOE av123z7m-n17 display";
+
+	panel {
+		compatible = "boe,av123z7m-n17";
+		enable-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&pinctrl_panel>;
+		pinctrl-names = "default";
+		power-supply = <&reg_3v3_per>;
+		reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				dual-lvds-odd-pixels;
+
+				panel_in0: endpoint {
+					remote-endpoint = <&lvds1_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				dual-lvds-even-pixels;
+
+				panel_in1: endpoint {
+					remote-endpoint = <&lvds0_out>;
+				};
+			};
+		};
+	};
+};
+
+&i2c4 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* sn65dsi85 */
+	bridge@2d {
+		compatible = "ti,sn65dsi84";
+		reg = <0x2d>;
+		enable-gpios = <&gpio4 14 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&pinctrl_lvds_bridge>;
+		pinctrl-names = "default";
+		vcc-supply = <&reg_1v8_per>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				dsi_lvds_bridge_in: endpoint {
+					data-lanes = <1 2 3 4>;
+					remote-endpoint = <&mipi_dsi_out>;
+				};
+			};
+
+			port@2 {
+				reg = <2>;
+
+				lvds0_out: endpoint {
+					remote-endpoint = <&panel_in1>;
+				};
+			};
+
+			port@3 {
+				reg = <3>;
+
+				lvds1_out: endpoint {
+					remote-endpoint = <&panel_in0>;
+				};
+			};
+		};
+	};
+
+	/* max25014 @ 0x6f */
+};
+
+&iomuxc {
+	pinctrl_lvds_bridge: lvdsbridgegrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI1_TXD2__GPIO4_IO14
+				MX8MP_DSE_X1
+		>;
+	};
+
+	pinctrl_panel: panelgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO07__GPIO1_IO07
+				MX8MP_DSE_X1
+			MX8MP_IOMUXC_GPIO1_IO09__GPIO1_IO09
+				MX8MP_DSE_X1
+		>;
+	};
+};
+
+&lcdif1 {
+	status = "okay";
+};
+
+&mipi_dsi {
+	/*
+	 * burst has to be at least 2x dsi clock that the sn65dsi85 expects
+	 * display pixelclock * bpp / lanes / 2 = dsi clock
+	 * 88.000.000 * 24 / 4 / 2 = 264.000.000
+	 * range gets rounded up to 265.000.000 - 270.000.000
+	 * 267.500.000 * 2 = 535.000.000
+	 */
+	samsung,burst-clock-frequency = <535000000>;
+	samsung,esc-clock-frequency = <12000000>;
+	status = "okay";
+
+	ports {
+		port@1 {
+			mipi_dsi_out: endpoint {
+				data-lanes = <1 2 3 4>;
+				remote-endpoint = < &dsi_lvds_bridge_in>;
+			};
+		};
+	};
+};

-- 
2.49.0




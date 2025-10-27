Return-Path: <linux-kernel+bounces-871378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60816C0D0EF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C39A319A1573
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D01830275C;
	Mon, 27 Oct 2025 11:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="RPEN8XP9"
Received: from mx-relay140-hz1.antispameurope.com (mx-relay140-hz1.antispameurope.com [94.100.133.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC272FB0B4
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.133.186
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761563169; cv=pass; b=NR15x8w0WPlavhOsCA9DvyoN5smpKIavAGJrmgDjk3O4mxGifaoS0juTRh8wkmPYaQ/NgSRVZsLfvoCEmnchk4uOQYHmi9VGbAIsjmEVcejBvNvAXY4prQG9mLQf/j8qC1iEFSeEUSw3YFqR8GxyNdTcepNqetFs/fZZKyJoPyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761563169; c=relaxed/simple;
	bh=wEI5yXUOF+CACfKM0NOh04u6P7yihtxZ3/bDAk6k00c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJdKmibCe1rnlTHrQP5g5KMWg80XBXgcMgnmcxIDSDHw+dpMqTgir4/4ICOJKb9HDgi2XXYFj3JKyC2dYZ9Unq6+nyuEqEADuRZLrB1wNTXf6w4P+E9EQcVRSKoP4XGmmggcedsT/q3MCmn4dfSB6TzW9akPMXPNGAhatVWzTF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=RPEN8XP9; arc=pass smtp.client-ip=94.100.133.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate140-hz1.hornetsecurity.com 1;
 spf=pass reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out01-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=IYf62MQfhNufk5EphjjlWX+U17K5L3FC8NuKHzs3uy4=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1761563138;
 b=EAPrJdZbg1xq9vAD3WVdwQu0Z3XGCKodT3lshNxS92AQpfVcCBUfD1we9tC9l4zhy+U4YN8w
 UN3ktjtbaWWta4WNVS1doXOQjz2oX7Ltgh0WM88Pv28pR94XXdvIfah41FNUxEm9YFS27vpKY/S
 ytqLpktr/fUzqmms6JCk+/Womp6xWRSCD6YVUuSd5yYTXkiIRPj3oS8/cC6+PvY3unShG5TDMhL
 AQrec4q3I15e8rW4GZnpuGX64yQKSD/N7d2j3jD7rD4aKU4lhi4eqYDztjaloBhGJG/TPciCvsq
 DKRGgS4MaohtHeW8E/JoAzSV6z8NJ6qfYwW73yyCvxKUA==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1761563138;
 b=QGEAhZccyZuxyD2vU4HgYjRFtq/TC5ZtDzuepc6dHtIIEJAlJCglPx0PxTi6TXWgEZ1DxTsP
 noVUGImKNAt8Ngaue2RhN0K1+Gd6d9jQm8WEmUxOPKBsUOofRrORowmgBO6srah/WCmce6xRlj1
 je/rBXe/cGK5Oh0JdOta4bkMSPohCvQKYouyg8+XxYvWP+NlmPLNJBHRjzCiVzakVxG4UFVzcFl
 Hy8G2+5+RcgqLOLGt6KUI9TidPDS/WZNOx67S9KivfcxwUI2rJ9vuhveHk4Cx+DhXv9+05RlBhM
 WNzR2NxwvXsfHSEEz4VwqEirarPY0KuNAiPqX+lmMxOkg==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay140-hz1.antispameurope.com;
 Mon, 27 Oct 2025 12:05:37 +0100
Received: from steina-w.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by smtp-out01-hz1.hornetsecurity.com (Postfix) with ESMTPSA id D4212A40644;
	Mon, 27 Oct 2025 12:05:12 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Gregor Herburger <gregor.herburger@tq-group.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH v3 2/2] arm64: dts: ls1028a: Add mbls1028a and mbls1028a-ind devicetrees
Date: Mon, 27 Oct 2025 12:04:56 +0100
Message-ID: <20251027110459.420857-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251027110459.420857-1-alexander.stein@ew.tq-group.com>
References: <20251027110459.420857-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:alexander.stein@ew.tq-group.com
X-cloud-security-recipient:linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.stein@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay140-hz1.antispameurope.com with 4cw9dj604xz1HFHh
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:1144241538d731ec762d85418104f796
X-cloud-security:scantime:2.617
DKIM-Signature: a=rsa-sha256;
 bh=IYf62MQfhNufk5EphjjlWX+U17K5L3FC8NuKHzs3uy4=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1761563137; v=1;
 b=RPEN8XP9DoyXtmDm64HRuAMksteLeD/aSeMlQE5oIAsh4rQ4c5jHRv4YGVp019i4x+AFNm86
 AxnuPGD4rvqtOxnhpmL5FsHoctTR3SLoU3iG3nJJxHCz7p21ZvQQ4xClVUwDXuDxtyZnJbMul9L
 9EtAfakYt7HuYtQ4KzaSwrR6gcvnOu4JiDZs6AV+XPkDk8K5742i0f7DXd4WzrXxukcnXHbVz4e
 qUNYYe2jCgEOdvsc7nHk/HcAKIYaP5BiFbxIriqwrUz8+D9YXItGFFuknRarfUNYIFWxKwtM+1H
 n8HrIeK3bJMHfjKOCcWkQ3wyIsIEZJRIF80f0H/8p+BGA==

From: Gregor Herburger <gregor.herburger@tq-group.com>

Add device trees for the MBLS1028A and the MBLS1028A-IND and the SoM
TQMLS1028A.

Signed-off-by: Gregor Herburger <gregor.herburger@tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Changes in v3:
* Fix ethernet PHY interrupt polarity
* Remove downstream properties

Changes in v2:
* Sort node and properties alphabetically
* Add clock-frequency to i2c nodes
* Add eMMC supplies
* Add comment about unused TMU

 arch/arm64/boot/dts/freescale/Makefile        |   2 +
 .../fsl-ls1028a-tqmls1028a-mbls1028a-ind.dts  |  68 ++++
 .../fsl-ls1028a-tqmls1028a-mbls1028a.dts      | 118 +++++++
 .../fsl-ls1028a-tqmls1028a-mbls1028a.dtsi     | 290 ++++++++++++++++++
 .../dts/freescale/fsl-ls1028a-tqmls1028a.dtsi | 124 ++++++++
 5 files changed, 602 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-tqmls1028a-mbls1028a-ind.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-tqmls1028a-mbls1028a.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-tqmls1028a-mbls1028a.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-tqmls1028a.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index ca6cf40dd00be..59d3d76a3194c 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -16,6 +16,8 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-kontron-sl28-var3-ads2.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-kontron-sl28-var4.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-rdb.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-tqmls1028a-mbls1028a.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-tqmls1028a-mbls1028a-ind.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1043a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1043a-rdb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1043a-tqmls1043a-mbls10xxa.dtb
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-tqmls1028a-mbls1028a-ind.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-tqmls1028a-mbls1028a-ind.dts
new file mode 100644
index 0000000000000..571b801c4f145
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-tqmls1028a-mbls1028a-ind.dts
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright 2019-2025 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Michael Krummsdorf
+ * Author: Matthias Schiffer
+ * Author: Alexander Stein
+ */
+
+/dts-v1/;
+
+#include "fsl-ls1028a-tqmls1028a-mbls1028a.dtsi"
+
+/ {
+	model = "MBLS1028A-IND starterkit";
+	compatible = "tq,ls1028a-tqmls1028a-mbls1028a-ind", "tq,ls1028a-tqmls1028a", "fsl,ls1028a";
+};
+
+&i2c5 {
+	gpio_exp_3v3: gpio@71 {
+		compatible = "nxp,pca9538";
+		reg = <0x71>;
+		#gpio-cells = <2>;
+		gpio-controller;
+
+		clk-intn-hog {
+			gpio-hog;
+			gpios = <0 GPIO_ACTIVE_HIGH>;
+			input;
+			line-name = "CLK_INT#";
+		};
+
+		mpcie-waken-hog {
+			gpio-hog;
+			gpios = <2 GPIO_ACTIVE_HIGH>;
+			input;
+			line-name = "MPCIE_WAKE#";
+		};
+
+		mpcie-disn-hog {
+			gpio-hog;
+			gpios = <3 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "MPCIE_DIS#";
+		};
+
+		mpcie-rstn-hog {
+			gpio-hog;
+			gpios = <4 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "MPCIE_RST#";
+		};
+
+		sata-perstn-hog {
+			gpio-hog;
+			gpios = <6 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "SATA_PERST#";
+		};
+
+		dcdc-reset-hog {
+			gpio-hog;
+			gpios = <7 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "DCDC_RESET";
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-tqmls1028a-mbls1028a.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-tqmls1028a-mbls1028a.dts
new file mode 100644
index 0000000000000..02563f982ff81
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-tqmls1028a-mbls1028a.dts
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright 2019-2025 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Michael Krummsdorf
+ * Author: Matthias Schiffer
+ * Author: Alexander Stein
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include "fsl-ls1028a-tqmls1028a-mbls1028a.dtsi"
+
+/ {
+	model = "MBLS1028A starterkit";
+	compatible = "tq,ls1028a-tqmls1028a-mbls1028a", "tq,ls1028a-tqmls1028a", "fsl,ls1028a";
+
+	gpio-beeper {
+		compatible = "gpio-beeper";
+		gpios = <&gpio_exp_3v3 15 GPIO_ACTIVE_HIGH>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		autorepeat;
+
+		button-0 {
+			label = "S4";
+			linux,code = <BTN_0>;
+			gpios = <&gpio_exp_3v3 11 GPIO_ACTIVE_LOW>;
+		};
+
+		button-1 {
+			label = "S5";
+			linux,code = <BTN_1>;
+			gpios = <&gpio_exp_3v3 12 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		led-1 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_STATUS;
+			function-enumerator = <1>;
+			gpios = <&gpio_exp_3v3 14 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-on";
+		};
+
+		led-2 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_HEARTBEAT;
+			gpios = <&gpio_exp_3v3 13 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&gpio_exp_1v8 {
+	dcdc-reset-hog {
+		gpio-hog;
+		gpios = <6 GPIO_ACTIVE_HIGH>;
+		line-name = "DCDC_RESET";
+		output-low;
+	};
+};
+
+&i2c5 {
+	gpio_exp_3v3: gpio@25 {
+		compatible = "nxp,pca9555";
+		reg = <0x25>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		interrupt-parent = <&gpio1>;
+		interrupts = <30 IRQ_TYPE_LEVEL_LOW>;
+		vcc-supply = <&reg_3p3v>;
+
+		clk-intn-hog {
+			gpio-hog;
+			gpios = <0 GPIO_ACTIVE_HIGH>;
+			input;
+			line-name = "CLK_INT#";
+		};
+
+		mpcie-waken-hog {
+			gpio-hog;
+			gpios = <2 GPIO_ACTIVE_HIGH>;
+			input;
+			line-name = "MPCIE_WAKE#";
+		};
+
+		mpcie-disn-hog {
+			gpio-hog;
+			gpios = <3 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "MPCIE_DIS#";
+		};
+
+		mpcie-rstn-hog {
+			gpio-hog;
+			gpios = <4 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "MPCIE_RST#";
+		};
+
+		sata-perstn-hog {
+			gpio-hog;
+			gpios = <6 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "SATA_PERST#";
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-tqmls1028a-mbls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a-tqmls1028a-mbls1028a.dtsi
new file mode 100644
index 0000000000000..8f9dc0f138a63
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-tqmls1028a-mbls1028a.dtsi
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright 2019-2025 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Michael Krummsdorf
+ * Author: Matthias Schiffer
+ * Author: Alexander Stein
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/net/ti-dp83867.h>
+#include "fsl-ls1028a-tqmls1028a.dtsi"
+
+/ {
+	aliases {
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+
+		crypto = &crypto;
+
+		mmc0 = &esdhc; /* SD-Card */
+		mmc1 = &esdhc1; /* eMMC */
+
+		serial0 = &duart0;
+		serial1 = &duart1;
+	};
+
+	chosen {
+		stdout-path = &duart0;
+	};
+
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "V_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "V_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* global autoconfigured region for contiguous allocations */
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			/* 256 MiB */
+			size = <0 0x10000000>;
+			linux,cma-default;
+		};
+	};
+};
+
+&can0 {
+	status = "okay";
+};
+
+&can1 {
+	status = "okay";
+};
+
+&dspi2 {
+	bus-num = <2>;
+	status = "okay";
+};
+
+&duart0 {
+	status = "okay";
+};
+
+&duart1 {
+	status = "okay";
+};
+
+&esdhc {
+	cd-gpios = <&gpio1 31 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	no-mmc;
+	no-sdio;
+	no-1-8-v;
+	bus-width = <4>;
+	status = "okay";
+};
+
+/* When switched to baseboard-internal i2c bus,
+ * IIC5 has access to the following devices.
+ */
+&i2c4 {
+	/* TUSB8041 only supports 100 KHz, but it is not connected */
+	clock-frequency = <400000>;
+	status = "okay";
+
+	/* SI5338 - set up in U-Boot */
+	/* clockgen@70 */
+};
+
+&i2c5 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	gpio_exp_1v8: gpio@70 {
+		compatible = "nxp,pca9538";
+		reg = <0x70>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		interrupt-parent = <&gpio1>;
+		interrupts = <30 IRQ_TYPE_LEVEL_LOW>;
+		vcc-supply = <&reg_1p8v>;
+
+		ec1-intn-hog {
+			gpio-hog;
+			gpios = <0 0>;
+			input;
+			line-name = "EC1_INT#";
+		};
+
+		sgmii-intn-hog {
+			gpio-hog;
+			gpios = <2 0>;
+			input;
+			line-name = "SGMII_INT#";
+		};
+
+		qsgmii-intn-hog {
+			gpio-hog;
+			gpios = <4 0>;
+			input;
+			line-name = "QSGMII_INT#";
+		};
+
+		qsgmii-rstn-hog {
+			gpio-hog;
+			gpios = <5 0>;
+			output-high;
+			line-name = "QSGMII_RESET#";
+		};
+	};
+};
+
+&enetc_mdio_pf3 {
+	mdio0_rgmii_phy00: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x00>;
+		reset-gpios = <&gpio_exp_1v8 1 GPIO_ACTIVE_LOW>;
+		reset-assert-us = <1>;
+		reset-deassert-us = <200>;
+		interrupt-parent = <&gpio_exp_1v8>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_50_NS>;
+		ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+	};
+
+	mdio0_sgmii_phy03: ethernet-phy@3 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x03>;
+		reset-gpios = <&gpio_exp_1v8 3 GPIO_ACTIVE_LOW>;
+		/*
+		 * Long reset to work around PHY incorrect strap pin sampling
+		 * due to external capacitors for SGMII
+		 */
+		reset-assert-us = <2500>;
+		reset-deassert-us = <200>;
+		interrupt-parent = <&gpio_exp_1v8>;
+		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+		ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+	};
+
+	qsgmii_phy1: ethernet-phy@1c {
+		reg = <0x1c>;
+	};
+
+	qsgmii_phy2: ethernet-phy@1d {
+		reg = <0x1d>;
+	};
+
+	qsgmii_phy3: ethernet-phy@1e {
+		reg = <0x1e>;
+	};
+
+	qsgmii_phy4: ethernet-phy@1f {
+		reg = <0x1f>;
+	};
+};
+
+&enetc_port0 {
+	phy-handle = <&mdio0_sgmii_phy03>;
+	phy-mode = "sgmii";
+	managed = "in-band-status";
+	status = "okay";
+};
+
+&enetc_port1 {
+	phy-handle = <&mdio0_rgmii_phy00>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+};
+
+&enetc_port2 {
+	status = "okay";
+};
+
+&mscc_felix {
+	status = "okay";
+};
+
+/* l2switch ports */
+&mscc_felix_port0 {
+	phy-handle = <&qsgmii_phy1>;
+	phy-mode = "qsgmii";
+	status = "okay";
+};
+
+&mscc_felix_port1 {
+	phy-handle = <&qsgmii_phy2>;
+	phy-mode = "qsgmii";
+	status = "okay";
+};
+
+&mscc_felix_port2 {
+	phy-handle = <&qsgmii_phy3>;
+	phy-mode = "qsgmii";
+	status = "okay";
+};
+
+&mscc_felix_port3 {
+	phy-handle = <&qsgmii_phy4>;
+	phy-mode = "qsgmii";
+	status = "okay";
+};
+
+&mscc_felix_port4 {
+	ethernet = <&enetc_port2>;
+	status = "okay";
+};
+
+&pcie2 {
+	status = "okay";
+};
+
+&sata {
+	status = "okay";
+};
+
+&usb0 {
+	/* dual role is implemented, but not a full featured OTG */
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usb1 {
+	dr_mode = "host";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	hub_2_0: hub@1 {
+		compatible = "usb451,8142";
+		reg = <1>;
+		peer-hub = <&hub_3_0>;
+		reset-gpios = <&gpio_exp_3v3 1 GPIO_ACTIVE_LOW>;
+		vdd-supply = <&reg_3p3v>;
+	};
+
+	hub_3_0: hub@2 {
+		compatible = "usb451,8140";
+		reg = <2>;
+		peer-hub = <&hub_2_0>;
+		reset-gpios = <&gpio_exp_3v3 1 GPIO_ACTIVE_LOW>;
+		vdd-supply = <&reg_3p3v>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-tqmls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a-tqmls1028a.dtsi
new file mode 100644
index 0000000000000..dbf24dbc043b7
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-tqmls1028a.dtsi
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright 2019-2025 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Michael Krummsdorf
+ * Author: Matthias Schiffer
+ * Author: Alexander Stein
+ */
+
+#include "fsl-ls1028a.dtsi"
+
+/ {
+	compatible = "tq,ls1028a-tqmls1028a", "fsl,ls1028a";
+
+	reg_1p8v_som: regulator-1p8v-som {
+		compatible = "regulator-fixed";
+		regulator-name = "1P8V_SOM";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	reg_3p3v_som: regulator-3p3v-som {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V_SOM";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	thermal-zones {
+		/*
+		 * TQMLS1028A uses an external temperature sensor
+		 * instead of TMU
+		 */
+		/delete-node/ ddr-controller;
+
+		cluster-thermal {
+			thermal-sensors = <&sa56004_4c 1>;
+		};
+	};
+};
+
+&esdhc1 {
+	no-sdio;
+	no-sd;
+	non-removable;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	mmc-ddr-1_8v;
+	bus-width = <8>;
+	vmmc-supply = <&reg_3p3v_som>;
+	vqmmc-supply = <&reg_1p8v_som>;
+	status = "okay";
+};
+
+&fspi {
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <100000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+		vcc-supply = <&reg_1p8v_som>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+	};
+};
+
+&i2c0 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	js42_18: temperature-sensor@18 {
+		compatible = "nxp,se97b", "jedec,jc-42.4-temp";
+		reg = <0x18>;
+	};
+
+	sa56004_4c: temperature-sensor@4c {
+		compatible = "nxp,sa56004";
+		reg = <0x4c>;
+		#thermal-sensor-cells = <1>;
+		vcc-supply = <&reg_3p3v_som>;
+	};
+
+	se97_50: eeprom@50 {
+		compatible = "nxp,se97b", "atmel,24c02";
+		read-only;
+		reg = <0x50>;
+		pagesize = <16>;
+		vcc-supply = <&reg_3p3v_som>;
+	};
+
+	rtc1: rtc@51 {
+		compatible = "nxp,pcf85063a";
+		reg = <0x51>;
+		quartz-load-femtofarads = <12500>;
+	};
+
+	m24c256_57: eeprom@57 {
+		compatible = "atmel,24c256";
+		reg = <0x57>;
+		pagesize = <32>;
+		vcc-supply = <&reg_3p3v_som>;
+	};
+};
+
+/*
+ * We use a separate sensor IC to measure core temperature. Disable the TMU
+ * as its driver can cause log spam outside of its measurement range (0-125C).
+ *
+ * Will have to be reevaluated if this DTS is ported to a mainline kernel,
+ * as both sensors of the TMU are referenced by the default LS1028A
+ * thermal-zones definitions there.
+ */
+&tmu {
+	status = "disabled";
+};
-- 
2.43.0



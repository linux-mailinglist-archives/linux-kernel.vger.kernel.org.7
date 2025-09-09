Return-Path: <linux-kernel+bounces-808988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD0BB5072D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44771C24852
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF0D35FC1B;
	Tue,  9 Sep 2025 20:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQv2U/Ue"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274D2362068;
	Tue,  9 Sep 2025 20:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757450058; cv=none; b=kAfquH3WWl+s3r73DgkBpoZo4Woz+c3zifO2xITd7tGdoqm1hVUqHm0F795WCXAjIxmv8ijmnN1LA7wTsLau5d8IEHOfM+TX3UddJvqgXivJZ4F5lW/NietjsLNGczK5EnJbI3MDUw7YP7LriA26AfysxQDy5zQ+/kb4x5ckcVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757450058; c=relaxed/simple;
	bh=hdwNKGl7lx7063eJ2yiIHblOsSgC/pR1LbJ6lLkBads=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qIC2I14rD7wuVhR3z9VvB3T7oaerfp4GqUZuZ0VtGoeJt++qC08uDx206nzGGEjeQstrIqkK9xerrsuM4Gvw2VlpjnJd/L2S/1A/qjbOs2VQxvA0q98d+ZI1VNqsfQfM1UBJ7E9HHZhJL71gTOX+f+Ekx+KGH1q+0T+g5PeUV08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQv2U/Ue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903FDC4CEF8;
	Tue,  9 Sep 2025 20:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757450057;
	bh=hdwNKGl7lx7063eJ2yiIHblOsSgC/pR1LbJ6lLkBads=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eQv2U/UeE/bjEFK3vU+6qVQEwjGD5nim1L/4Ln1UhO1QwHC6X1buEhiHGQchxU4y7
	 B3pWVa7H4Xw/8YeAB9G9qACjvy7X/VYIb7F+OfJG4cy71yeVK57Zl8DVCLaCOD8FYF
	 vg/p0hKqAm4WJs0JIVZUVO4MvDGwqtSPtnEPcikDkFUrNfSajUas1M3FP196j/4/XQ
	 oc5UdPl7n80sfgL1HzFMh1I/E/OZOAHn7TaZubs9ncVz7vF7Ns3XBbfqaDrEw/llvp
	 9NxwRtann1qA6WN9hyEfVCjJO1gj4jBxH9dsTt0rG5D48Ck0PtPdY4m000YycaJRUt
	 p2xCh4D8CEvwQ==
From: Andreas Kemnade <akemnade@kernel.org>
Date: Tue, 09 Sep 2025 22:33:04 +0200
Subject: [PATCH v2 3/3] ARM: dts: imx: e70k02: add sy7636
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-sy7636-rsrc-v2-3-cfd9f44fd259@kernel.org>
References: <20250909-sy7636-rsrc-v2-0-cfd9f44fd259@kernel.org>
In-Reply-To: <20250909-sy7636-rsrc-v2-0-cfd9f44fd259@kernel.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alistair Francis <alistair@alistair23.me>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Andreas Kemnade <akemnade@kernel.org>
X-Mailer: b4 0.15-dev-50721
X-Developer-Signature: v=1; a=openpgp-sha256; l=4885; i=akemnade@kernel.org;
 h=from:subject:message-id; bh=hdwNKGl7lx7063eJ2yiIHblOsSgC/pR1LbJ6lLkBads=;
 b=owGbwMvMwCEm/rzkS6lq2x3G02pJDBkH+q1PF74+IVA/1cjcZWn60ncPOTUqjoRejfhrtHhnl
 tOXn7uOdJSyMIhxMMiKKbL8slZw+6TyLDd4aoQ9zBxWJpAhDFycAjCR/jxGhikzDa5xJmX66kwK
 cNzEUVnkebjgiZvS1/4lqtuUz5nxz2b475O0zmqpflyX5n7LTn2uZ9/X70/acE2iLk5V/9utHdm
 qnAA=
X-Developer-Key: i=akemnade@kernel.org; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

Add the EPD PMIC for the e70k02 based devices as a step towards full EPD
support.

Signed-off-by: Andreas Kemnade <akemnade@kernel.org>
Acked-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/boot/dts/nxp/imx/e70k02.dtsi              | 25 +++++++++++++++++++++-
 .../arm/boot/dts/nxp/imx/imx6sl-tolino-vision5.dts | 24 +++++++++++++++++++++
 .../arm/boot/dts/nxp/imx/imx6sll-kobo-librah2o.dts | 24 +++++++++++++++++++++
 3 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/e70k02.dtsi b/arch/arm/boot/dts/nxp/imx/e70k02.dtsi
index dcc3c9d488a88..b4f42f71c6c49 100644
--- a/arch/arm/boot/dts/nxp/imx/e70k02.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/e70k02.dtsi
@@ -69,6 +69,14 @@ memory@80000000 {
 		reg = <0x80000000 0x20000000>;
 	};
 
+	epd_pmic_supply: regulator-epd-pmic-in {
+		compatible = "regulator-fixed";
+		regulator-name = "epd_pmic_supply";
+		gpio = <&gpio2 14 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <20000>;
+		enable-active-high;
+	};
+
 	reg_wifi: regulator-wifi {
 		compatible = "regulator-fixed";
 		regulator-name = "SD3_SPWR";
@@ -133,7 +141,22 @@ touchscreen@24 {
 		vdd-supply = <&ldo5_reg>;
 	};
 
-	/* TODO: SY7636 PMIC for E Ink at 0x62 */
+	sy7636: pmic@62 {
+		compatible = "silergy,sy7636a";
+		reg = <0x62>;
+		enable-gpios = <&gpio2 8 GPIO_ACTIVE_HIGH>;
+		vcom-en-gpios = <&gpio2 3 GPIO_ACTIVE_HIGH>;
+		epd-pwr-good-gpios = <&gpio2 13 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&epd_pmic_supply>;
+
+		#thermal-sensor-cells = <0>;
+
+		regulators {
+			reg_epdpmic: vcom {
+				regulator-name = "vcom";
+			};
+		};
+	};
 
 };
 
diff --git a/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-vision5.dts b/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-vision5.dts
index a2534c422a522..f8709a9524093 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-vision5.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-vision5.dts
@@ -26,6 +26,11 @@ / {
 	compatible = "kobo,tolino-vision5", "fsl,imx6sl";
 };
 
+&epd_pmic_supply {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_epd_pmic_supply>;
+};
+
 &gpio_keys {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpio_keys>;
@@ -59,6 +64,12 @@ MX6SL_PAD_FEC_RXD1__GPIO4_IO18          0x10059 /* TP_RST */
 		>;
 	};
 
+	pinctrl_epd_pmic_supply: epd-pmic-supplygrp {
+		fsl,pins = <
+			MX6SL_PAD_EPDC_PWRWAKEUP__GPIO2_IO14    0x40010059
+		>;
+	};
+
 	pinctrl_gpio_keys: gpio-keysgrp {
 		fsl,pins = <
 			MX6SL_PAD_FEC_CRS_DV__GPIO4_IO25	0x17059	/* PWR_SW */
@@ -159,6 +170,14 @@ MX6SL_PAD_KEY_COL2__GPIO3_IO28		0x1b8b1 /* ricoh619 bat_low_int */
 		>;
 	};
 
+	pinctrl_sy7636_gpio: sy7636-gpiogrp {
+		fsl,pins = <
+			MX6SL_PAD_EPDC_VCOM0__GPIO2_IO03        0x40010059 /* VCOM_CTRL */
+			MX6SL_PAD_EPDC_PWRCTRL1__GPIO2_IO08     0x40010059 /* EN */
+			MX6SL_PAD_EPDC_PWRSTAT__GPIO2_IO13      0x17059 /* PWR_GOOD */
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX6SL_PAD_UART1_TXD__UART1_TX_DATA 0x1b0b1
@@ -329,6 +348,11 @@ &ricoh619 {
 	pinctrl-0 = <&pinctrl_ricoh_gpio>;
 };
 
+&sy7636 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sy7636_gpio>;
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6sll-kobo-librah2o.dts b/arch/arm/boot/dts/nxp/imx/imx6sll-kobo-librah2o.dts
index 660620d226f71..19bbe60331b36 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sll-kobo-librah2o.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6sll-kobo-librah2o.dts
@@ -36,6 +36,11 @@ &cpu0 {
 	soc-supply = <&dcdc1_reg>;
 };
 
+&epd_pmic_supply {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_epd_pmic_supply>;
+};
+
 &gpio_keys {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpio_keys>;
@@ -69,6 +74,12 @@ MX6SLL_PAD_GPIO4_IO18__GPIO4_IO18	0x10059 /* TP_RST */
 		>;
 	};
 
+	pinctrl_epd_pmic_supply: epd-pmic-supplygrp {
+		fsl,pins = <
+			MX6SLL_PAD_EPDC_PWR_WAKE__GPIO2_IO14    0x40010059
+		>;
+	};
+
 	pinctrl_gpio_keys: gpio-keysgrp {
 		fsl,pins = <
 			MX6SLL_PAD_GPIO4_IO25__GPIO4_IO25	0x17059	/* PWR_SW */
@@ -169,6 +180,14 @@ MX6SLL_PAD_KEY_COL2__GPIO3_IO28		0x1b8b1 /* ricoh619 bat_low_int */
 		>;
 	};
 
+	pinctrl_sy7636_gpio: sy7636-gpiogrp {
+		fsl,pins = <
+			MX6SLL_PAD_EPDC_VCOM0__GPIO2_IO03       0x40010059 /* VCOM_CTRL */
+			MX6SLL_PAD_EPDC_PWR_CTRL1__GPIO2_IO08   0x40010059 /* EN */
+			MX6SLL_PAD_EPDC_PWR_STAT__GPIO2_IO13    0x17059 /* PWR_GOOD */
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX6SLL_PAD_UART1_TXD__UART1_DCE_TX 0x1b0b1
@@ -319,6 +338,11 @@ &ricoh619 {
 	pinctrl-0 = <&pinctrl_ricoh_gpio>;
 };
 
+&sy7636 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sy7636_gpio>;
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;

-- 
2.39.5



Return-Path: <linux-kernel+bounces-820118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AE6B7C76E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D7E624E261C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 07:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1832F60CE;
	Wed, 17 Sep 2025 07:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3LPwGpB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E062F5A02;
	Wed, 17 Sep 2025 07:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758093306; cv=none; b=eA5ACjfLFGDnmLtZ6lq1kc1t2b1hpcPMlRJlskrQ8EzCuF7f8ZGltogRyWFpJC9inoyJBtQH9Zlf6qeSHjWnQPqQt39z0ipZWT8E68afiK1wuoz10i8y+Qrk71BgCgJCvSv+068fvTIM5fIxnm/bfQ8h/VxZrjXtucMOFWq2DFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758093306; c=relaxed/simple;
	bh=RQIZLcbzug1xd2axJkwuNTLQ6QIKbtdJhsLxlQHH2Pg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZyebvT6G9Gqh0QBKQPQnPK+7A4gBNag4/PtzLw+Jg1aC18/Y9obpeLU/MnxPJe78Dma/z/S3kiI8+9W7PBN7YoEaAZ8O0zIyl9jvabAmqhCu5kisFwSE8EzKeu1+oRbgMoYdIuUtUyeWbWOjU/qpowBetcPBEG51uTVB+sVGvQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3LPwGpB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79813C4CEF5;
	Wed, 17 Sep 2025 07:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758093306;
	bh=RQIZLcbzug1xd2axJkwuNTLQ6QIKbtdJhsLxlQHH2Pg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P3LPwGpBGkFBUu+NmlLc/L0GWtUBvjYm207/AG6CqVkEonQsP8+29nPORDKq1ufT9
	 lv65t74pBC4870dlewl5lE4VVCFLL/0NbN9YEZvfLk9fBQawMtS0Ut2SIfc1aI9D5s
	 BOoLMKMNU+uBchlg/nmlgvhX5Mv4p81lAvcwxxa6W/NXbDAwVUlpt2NUrwsxulGU6k
	 d9aWmC0R1vYnM1bvVajEShpl9wUpe8+fKLy0Vda2fftczgV4wEjZla3gf+e0y2T/aj
	 OoW2GXhTnFwcVIaf6E8saxAe5CYZ9jvw94KNaRoQC9bX1egmV05rTKDaDo+LwXaGSH
	 WJ2Ip4MGt/Hrg==
From: Andreas Kemnade <akemnade@kernel.org>
Date: Wed, 17 Sep 2025 09:14:31 +0200
Subject: [PATCH v3 3/3] ARM: dts: imx: e70k02: add sy7636
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-sy7636-rsrc-v3-3-331237d507a2@kernel.org>
References: <20250917-sy7636-rsrc-v3-0-331237d507a2@kernel.org>
In-Reply-To: <20250917-sy7636-rsrc-v3-0-331237d507a2@kernel.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alistair Francis <alistair@alistair23.me>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.li@nxp.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Andreas Kemnade <akemnade@kernel.org>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15-dev-50721
X-Developer-Signature: v=1; a=openpgp-sha256; l=4927; i=akemnade@kernel.org;
 h=from:subject:message-id; bh=RQIZLcbzug1xd2axJkwuNTLQ6QIKbtdJhsLxlQHH2Pg=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDBmn4l+GtR14bW3btCyjWm9m3cTCGRYTMxWsD7LWeSyub
 DLu/MHfUcrCIMbFICumyPLLWsHtk8qz3OCpEfYwc1iZQIYwcHEKwETMXBgZdjieZwj8sm3FeV2Z
 lNfbOlVcuqummMWwdne0cFQueLxvKyND06Pmkx+m5s7hvfJort77q2ti/m827LBf9meDy3mVrB0
 fOAE=
X-Developer-Key: i=akemnade@kernel.org; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

Add the EPD PMIC for the e70k02 based devices as a step towards full EPD
support.

Acked-by: Alistair Francis <alistair@alistair23.me>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Andreas Kemnade <akemnade@kernel.org>
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
2.47.3



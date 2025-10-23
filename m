Return-Path: <linux-kernel+bounces-866736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 487A1C00870
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29BA01A06DBC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE9C30BF59;
	Thu, 23 Oct 2025 10:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="Pwxz1Y/+"
Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B6830BB9D;
	Thu, 23 Oct 2025 10:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.12.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215678; cv=none; b=tK8DNhHQOsX9RoEGlOpoZKmOGtrWhEUfRKUDcqbU9/RuFhMXXRjnBW+10DBpgaXrrPnw02jkwf7uJ+K6d8R58zYW09FgUnF3W2cz+pWFxnPiUAUp0UCAGwzc1pBcCkKkxwI/vBXvb0dxkKWU/AvIzI3paWV7t7FC63QIsrQKyFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215678; c=relaxed/simple;
	bh=Y5gZ6y04Xfgv8k6L6tGBT5KEu8DOqE2OSkRStOZ898Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BAA3+VPwQ31T3phHXgC9TDxXB1CfvW9NLJQ9II439heBCNuA3UonafpGq5y3UIM5p1nVHABXKth4Y6BUGLPEQDGjGjGccEBa+zF03Ntxog+aw58DiEuIHmIQ227UDL/cQK6IctEkZC9iBHWeENQ4U2O4G0yFpoavaQTmns0NuZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=Pwxz1Y/+; arc=none smtp.client-ip=46.19.12.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=KaIqVjC080ehs+M4YMocjMvAP2vggOM8cTfTrGcUD3Q=; b=Pwxz1Y/+dhLSy+qAY3X3bmHxPN
	QiGy/MseMEXz9E5ficRSjb/d/H8V7O1eShNSVWlbru+ZRf5xZKjvFRSLGz2AAlZKjQESOoRRSqWvq
	ujokKs9FhOG3GOj2ChcReOxgpBzMzoYrgnKvD8nBxDUT8fmDb2mmzdZBgmafxuII4wV/hjxlI/bD0
	+HOnUgv/cAeqgPVXfPrR2uCdMjqnrw9U4qQC8MeajGTvIPAwDv3gXk3pKlDhi8hpwiWP+Z3aAtcP6
	yracWIgsq4nVba7PAGhItOI+7vGXYw1wEhGq3mDBnYSyIjIY8ZnGdxV/OMnwLcfbT0Fso2OeOarCc
	kGpwiYuw==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:50686 helo=localhost.localdomain)
	by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1vBseN-00000005s0B-0vOg;
	Thu, 23 Oct 2025 12:34:27 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: [PATCH] arm64: dts: freescale: imx93-phy{core,board}: Add i2c bus recovery
Date: Thu, 23 Oct 2025 12:34:26 +0200
Message-Id: <20251023103426.3606647-1-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp2.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cp2.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cp2.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Add bus recovery feature for I2C buses on the PHYTEC phyCORE-i.MX93 SoM
based boards (that is phyBOARD-Nash-i.MX93 and phyBOARD-Segin-i.MX93).
This enables the i2c-imx-lpi2c driver to recover the stuck I2C bus by
switching the SCL and SDA pinmuxing and do the I2C bus bit-banging.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 .../arm64/boot/dts/freescale/imx93-phyboard-nash.dts | 12 +++++++++++-
 .../boot/dts/freescale/imx93-phyboard-segin.dts      | 12 +++++++++++-
 arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi | 12 +++++++++++-
 3 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-phyboard-nash.dts b/arch/arm64/boot/dts/freescale/imx93-phyboard-nash.dts
index 5599e296919f..96c58cf13754 100644
--- a/arch/arm64/boot/dts/freescale/imx93-phyboard-nash.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-phyboard-nash.dts
@@ -128,8 +128,11 @@ &flexcan1 {
 /* I2C2 */
 &lpi2c2 {
 	clock-frequency = <400000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_lpi2c2>;
+	pinctrl-1 = <&pinctrl_lpi2c2_gpio>;
+	scl-gpios = <&gpio1 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio1 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 
 	/* RTC */
@@ -253,6 +256,13 @@ MX93_PAD_I2C2_SDA__LPI2C2_SDA		0x40000b9e
 		>;
 	};
 
+	pinctrl_lpi2c2_gpio: lpi2c2gpiogrp {
+		fsl,pins = <
+			MX93_PAD_I2C2_SCL__GPIO1_IO02		0x31e
+			MX93_PAD_I2C2_SDA__GPIO1_IO03		0x31e
+		>;
+	};
+
 	pinctrl_lpspi6: lpspi6grp {
 		fsl,pins = <
 			MX93_PAD_GPIO_IO00__GPIO2_IO00		0x386
diff --git a/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts b/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
index 802d96b19e4c..1850a93dbaa4 100644
--- a/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
@@ -132,8 +132,11 @@ &flexcan1 {
 /* I2C2 */
 &lpi2c2 {
 	clock-frequency = <400000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_lpi2c2>;
+	pinctrl-1 = <&pinctrl_lpi2c2_gpio>;
+	scl-gpios = <&gpio1 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio1 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 
 	/* Codec */
@@ -238,6 +241,13 @@ MX93_PAD_I2C2_SDA__LPI2C2_SDA		0x40000b9e
 		>;
 	};
 
+	pinctrl_lpi2c2_gpio: lpi2c2gpiogrp {
+		fsl,pins = <
+			MX93_PAD_I2C2_SCL__GPIO1_IO02		0x31e
+			MX93_PAD_I2C2_SDA__GPIO1_IO03		0x31e
+		>;
+	};
+
 	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
 		fsl,pins = <
 			MX93_PAD_SD2_RESET_B__GPIO3_IO07	0x31e
diff --git a/arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi b/arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi
index 3f069905cf0b..ebc57841f27f 100644
--- a/arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi
@@ -93,8 +93,11 @@ ethphy1: ethernet-phy@1 {
 /* I2C3 */
 &lpi2c3 {
 	clock-frequency = <400000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_lpi2c3>;
+	pinctrl-1 = <&pinctrl_lpi2c3_gpio>;
+	scl-gpios = <&gpio2 29 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio2 28 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 
 	pmic@25 {
@@ -234,6 +237,13 @@ MX93_PAD_GPIO_IO29__LPI2C3_SCL		0x40000b9e
 		>;
 	};
 
+	pinctrl_lpi2c3_gpio: lpi2c3gpiogrp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO28__GPIO2_IO28		0x31e
+			MX93_PAD_GPIO_IO29__GPIO2_IO29		0x31e
+		>;
+	};
+
 	pinctrl_pmic: pmicgrp {
 		fsl,pins = <
 			MX93_PAD_ENET2_RD3__GPIO4_IO27		0x31e
-- 
2.34.1



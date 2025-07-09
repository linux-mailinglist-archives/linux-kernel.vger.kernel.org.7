Return-Path: <linux-kernel+bounces-724607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F36AFF4CC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14D3D58850A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1C525B30D;
	Wed,  9 Jul 2025 22:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="o5arJryF"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE46024DCE8;
	Wed,  9 Jul 2025 22:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752100560; cv=none; b=JPCeZmFnS7IBpkWieITP9NQo50nkS0WNotKakHBCrQqflSu/J2g2MbHtD00wia/TThRcuikELdjaHQNWcpesa2fWsronC84lQEe8vI/4upOzLRo4gN2Tg6P0+oRkeS6V7Rtz5gSbgyDGDumc4GOjIAKuV05aylgGRBYVZVGmVAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752100560; c=relaxed/simple;
	bh=bt4X9r72r6rI1ELQrvh8+CGDgf398vlVmIs10sdnrrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=QlyCI/QJGjr1exXyMkXQWkhxOT8NAnwTPEWZSE0mtCibhmk2wIEqbTAjD0KzEL6zsyMhsa8m9JdwewonFFuI6scVb7Qm3RlBEap5H19uc+427mwtpydAlUvjiSiMnG6y/ABjdM1fxia5S7D0xSgdXaCFSeVaPst/bTHGJP7GSpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=o5arJryF; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 569MZoE0952190;
	Wed, 9 Jul 2025 17:35:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752100551;
	bh=Olm4mSIpu4FebWepzFV2T6KFHpND3n+3YfGovDjUUVU=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=o5arJryFbenrTNRAWTVSCVj9Iq3z2lIj+HnKqbtxqHK8KTZ7gLTpE+/YWQJ2JAXgH
	 ovqW8SCaQBApuldfAVgcEfqgFtdPPT/oKNGG8BjCxCTx0FAmVbj5fXAro6+4MEFiCZ
	 RCYTvBSQisjFrTrcZnU0sge9tRlP8L2WMfNntSaE=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 569MZo623753491
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 9 Jul 2025 17:35:50 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 9
 Jul 2025 17:35:50 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 9 Jul 2025 17:35:50 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 569MZotI520530;
	Wed, 9 Jul 2025 17:35:50 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Wed, 9 Jul 2025 17:35:44 -0500
Subject: [PATCH 2/2] arm64: dts: ti: k3-am654-base-board: add boot phase
 tags
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250709-65-boot-phases-v1-2-e1f89d97a931@ti.com>
References: <20250709-65-boot-phases-v1-0-e1f89d97a931@ti.com>
In-Reply-To: <20250709-65-boot-phases-v1-0-e1f89d97a931@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.14.2
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The 'bootph-all' tag was added to the dt-schema to describe the various
nodes used during the different phases of bootup with DT. Add the
bootph-all tag to all nodes that are used in the bootloader for the
AM654 reference board.

UARTs used as a console, the SD and eMMC nodes along with the needed
regulators for UHS modes, and the needed nodes for OSPI boot are all
marked with 'bootph-all' to handle the various boot modes the board is
capable of

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts | 17 +++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am654-pcie-usb2.dtso |  1 +
 arch/arm64/boot/dts/ti/k3-am654-pcie-usb3.dtso |  1 +
 3 files changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index c30425960398ebb75ebda44726ed90cd78947d58..e589690c7c8213d5e4989942735fa53825e610f5 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -144,6 +144,7 @@ vtt_supply: regulator-3 {
 		regulator-boot-on;
 		vin-supply = <&vcc3v3_io>;
 		gpio = <&wkup_gpio0 28 GPIO_ACTIVE_HIGH>;
+		bootph-all;
 	};
 };
 
@@ -155,12 +156,14 @@ AM65X_WKUP_IOPAD(0x00a4, PIN_OUTPUT, 0)	/* (AB5) WKUP_UART0_TXD */
 			AM65X_WKUP_IOPAD(0x00c8, PIN_INPUT, 1)	/* (AC2) WKUP_GPIO0_6.WKUP_UART0_CTSn */
 			AM65X_WKUP_IOPAD(0x00cc, PIN_OUTPUT, 1)	/* (AC1) WKUP_GPIO0_7.WKUP_UART0_RTSn */
 		>;
+		bootph-all;
 	};
 
 	ddr_vtt_pins_default: ddr-vtt-default-pins {
 		pinctrl-single,pins = <
 			AM65X_WKUP_IOPAD(0x0040, PIN_OUTPUT_PULLUP, 7)	/* WKUP_GPIO0_28 */
 		>;
+		bootph-all;
 	};
 
 	wkup_i2c0_pins_default: wkup-i2c0-default-pins {
@@ -168,6 +171,7 @@ wkup_i2c0_pins_default: wkup-i2c0-default-pins {
 			AM65X_WKUP_IOPAD(0x00e0, PIN_INPUT, 0) /* (AC7) WKUP_I2C0_SCL */
 			AM65X_WKUP_IOPAD(0x00e4, PIN_INPUT, 0) /* (AD6) WKUP_I2C0_SDA */
 		>;
+		bootph-all;
 	};
 
 	push_button_pins_default: push-button-default-pins {
@@ -191,6 +195,7 @@ AM65X_WKUP_IOPAD(0x0024, PIN_INPUT, 0)  /* (R2) MCU_OSPI0_D6 */
 			AM65X_WKUP_IOPAD(0x0028, PIN_INPUT, 0)  /* (R3) MCU_OSPI0_D7 */
 			AM65X_WKUP_IOPAD(0x002c, PIN_OUTPUT, 0) /* (R4) MCU_OSPI0_CSn0 */
 		>;
+		bootph-all;
 	};
 
 	wkup_pca554_default: wkup-pca554-default-pins {
@@ -206,6 +211,7 @@ AM65X_WKUP_IOPAD(0x0048, PIN_OUTPUT, 4)	/* (P5) MCU_OSPI1_D2.MCU_UART0_TXD */
 			AM65X_WKUP_IOPAD(0x004C, PIN_INPUT, 4)	/* (P1) MCU_OSPI1_D3.MCU_UART0_CTSn */
 			AM65X_WKUP_IOPAD(0x0054, PIN_OUTPUT, 4)	/* (N3) MCU_OSPI1_CSn1.MCU_UART0_RTSn */
 		>;
+		bootph-all;
 	};
 
 	mcu_cpsw_pins_default: mcu-cpsw-default-pins {
@@ -248,6 +254,7 @@ AM65X_IOPAD(0x01e8, PIN_OUTPUT, 0)	/* (AE11) UART0_TXD */
 			AM65X_IOPAD(0x01ec, PIN_INPUT, 0)	/* (AG11) UART0_CTSn */
 			AM65X_IOPAD(0x01f0, PIN_OUTPUT, 0)	/* (AD11) UART0_RTSn */
 		>;
+		bootph-all;
 	};
 
 	main_i2c2_pins_default: main-i2c2-default-pins {
@@ -281,6 +288,7 @@ AM65X_IOPAD(0x0188, PIN_INPUT_PULLUP, 0) /* (D25) MMC0_DAT7 */
 			AM65X_IOPAD(0x01b4, PIN_INPUT_PULLUP, 0) /* (A23) MMC0_SDCD */
 			AM65X_IOPAD(0x01b0, PIN_INPUT, 0) /* (C25) MMC0_DS */
 		>;
+		bootph-all;
 	};
 
 	main_mmc1_pins_default: main-mmc1-default-pins {
@@ -294,6 +302,7 @@ AM65X_IOPAD(0x02c4, PIN_INPUT_PULLUP, 0) /* (D27) MMC1_DAT3 */
 			AM65X_IOPAD(0x02dc, PIN_INPUT_PULLUP, 0) /* (B24) MMC1_SDCD */
 			AM65X_IOPAD(0x02e0, PIN_INPUT, 0) /* (C24) MMC1_SDWP */
 		>;
+		bootph-all;
 	};
 
 	usb1_pins_default: usb1-default-pins {
@@ -343,6 +352,7 @@ &main_uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart0_pins_default>;
 	power-domains = <&k3_pds 146 TI_SCI_PD_SHARED>;
+	bootph-all;
 };
 
 &wkup_i2c0 {
@@ -368,6 +378,7 @@ vdd_mpu: regulator@60 {
 		ti,vsel0-state-high;
 		ti,vsel1-state-high;
 		ti,enable-vout-discharge;
+		bootph-all;
 	};
 
 	gpio@38 {
@@ -456,6 +467,7 @@ &sdhci0 {
 	bus-width = <8>;
 	non-removable;
 	ti,driver-strength-ohm = <50>;
+	bootph-all;
 };
 
 /*
@@ -470,6 +482,7 @@ &sdhci1 {
 	pinctrl-0 = <&main_mmc1_pins_default>;
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
+	bootph-all;
 };
 
 &usb1 {
@@ -630,3 +643,7 @@ &cpsw_port1 {
 &dss {
 	status = "disabled";
 };
+
+&wkup_gpio0 {
+	bootph-all;
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am654-pcie-usb2.dtso b/arch/arm64/boot/dts/ti/k3-am654-pcie-usb2.dtso
index c3cb752f8cd79459d6d321dfdf0644748514a48d..d04dd7a44008205301ea3fb3d0a883b6a6a2562b 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-pcie-usb2.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am654-pcie-usb2.dtso
@@ -46,6 +46,7 @@ AM65X_IOPAD(0x02bc, PIN_OUTPUT, 0) /* (AD9) USB0_DRVVBUS */
 
 &dwc3_0 {
 	status = "okay";
+	bootph-all;
 };
 
 &usb0_phy {
diff --git a/arch/arm64/boot/dts/ti/k3-am654-pcie-usb3.dtso b/arch/arm64/boot/dts/ti/k3-am654-pcie-usb3.dtso
index 333e423e8bb6b033f5f45c782ef0095d29983158..04393f21d712ebd95ce1a411e2ac13a56e63e57b 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-pcie-usb3.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am654-pcie-usb3.dtso
@@ -45,6 +45,7 @@ &dwc3_0 {
 	<&k3_clks 151 8>;      /* set PIPE3_TXB_CLK to WIZ8B2M4VSB */
 	phys = <&serdes0 PHY_TYPE_USB3 0>;
 	phy-names = "usb3-phy";
+	bootph-all;
 };
 
 &usb0 {

-- 
2.49.0



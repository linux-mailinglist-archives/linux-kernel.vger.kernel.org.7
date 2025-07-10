Return-Path: <linux-kernel+bounces-725916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AB2B00575
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66A11C869BB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442872749C0;
	Thu, 10 Jul 2025 14:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rcmj3u8e"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD84271474;
	Thu, 10 Jul 2025 14:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752158355; cv=none; b=YZEdbMZFHe+fq20fv5B27eC/2288VgtaT7mY3z2QAa/7o5Zd9npNfi8+RmYGniJYMfmQLelQSx8nkN7OQQSaHwImzIDenDf2WY7TXv/ttx5DCZYp2JyHq+Y/o8oL/Sf7pREL1PsDQOGyoPNl9DA2re1WbgWLjw2UB4B8sntevkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752158355; c=relaxed/simple;
	bh=bt4X9r72r6rI1ELQrvh8+CGDgf398vlVmIs10sdnrrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=W8M+njCef6D9YZg3sU3BMk0PMsaFP/L3wzCOgX5uJ9hx88/cM6fh0TeCzAaamxwxzsEetDvgjUGDSg7l5eM4Kh1kgbf8n3/EfqM6RIM6w03GNQsvkcyiLe7njlTvnorOdVQzUJku/uHGd0FHJWt0kcmJzOgmuXN4EpiIBrx6dAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rcmj3u8e; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56AEd5Yx1799654;
	Thu, 10 Jul 2025 09:39:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752158345;
	bh=Olm4mSIpu4FebWepzFV2T6KFHpND3n+3YfGovDjUUVU=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=rcmj3u8eaZurXOW/s+Uu77TG3lAzY9iB5kczFo+kRsohHrCj1vWE191HHp5mdx8WU
	 A850VfgOkWrUA+d575Uez3ylsx7338kv8FMrX0jyow2mrvfD9MlrxwrI26/DuL0Qox
	 2mRVZeeZJOnpxNRSquYYv+0GCd9GolMnN6D5nN6E=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56AEd5SQ256407
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 10 Jul 2025 09:39:05 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 10
 Jul 2025 09:39:05 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 10 Jul 2025 09:39:05 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56AEd4u51816956;
	Thu, 10 Jul 2025 09:39:04 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Thu, 10 Jul 2025 09:39:00 -0500
Subject: [PATCH v2 2/2] arm64: dts: ti: k3-am654-base-board: add boot phase
 tags
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250710-65-boot-phases-v2-2-d431deb88783@ti.com>
References: <20250710-65-boot-phases-v2-0-d431deb88783@ti.com>
In-Reply-To: <20250710-65-boot-phases-v2-0-d431deb88783@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5322; i=bb@ti.com;
 h=from:subject:message-id; bh=bt4X9r72r6rI1ELQrvh8+CGDgf398vlVmIs10sdnrrM=;
 b=owNCWmg5MUFZJlNZ41Wj+wAAZ/////7dX3s7fvy168f//dXfbbr/++1/vGZ9yPv/zp77+NWwA
 RsYjtQAAAAAMgAGmgGjQGgA9QAZDQyANBoA0Gh6gAGgaaGg0NDE8pvSYkDk0A9TQNAeoAABo0Gm
 QaAA9RpoD1AAaaaDIaGjRkaHqBoaaGmjaj1DI0GhpoyaAeoOQyBkAGTINABo0xBiGg0aaMgANAw
 BADIDEaaBppiaNNADEyA0wjQADAQLDCWYPEgIiFiVmReDBiXJgaSakQsXW9bj1OU7GOEhwFZv0B
 AKBVaLionFiqwckWJNLxrFR82oXp5AFn5UBcAJeNOvwRgVHaFmssACnyUaBC2LGeyTU/AqTvHOW
 SxadLqoz36A0V+gKK9Tn4H3LYfOQ6oYpmyN641rnkio8JrE1ZrVaiJMQI4Ie31NGKir2zot0jGA
 AQeEpkpjWx1QJeNOawYfpVwZGlxYMarbj3E0Iei5if7Uyr2AtHHJpeWLVxS1Qg2bdMnWOOd7lvy
 W7l3kaR+hWogM3A5L00hUahuTO4eweg4HHVKVaSpGhz9WIIny0p/wXyY5Qd02sBYwX4kDwxZYIK
 59RiCCn+2OAA59Baxyo437AvH+yMDEhPCWt/qReUXBqsXRSkMvYd6QjYAiC5qEIY4pDJr4f1l5k
 R/4EOmJAf4u5IpwoSHGq0f2
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
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



Return-Path: <linux-kernel+bounces-808602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD88B50228
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FB444E8055
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6581433437D;
	Tue,  9 Sep 2025 16:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0mtn3BHD"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9F02EDD52;
	Tue,  9 Sep 2025 16:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757434107; cv=none; b=VRxec2n+5uFonT6w3S6BtoGRKIJNY3ybfLh7voD3Z4aPB5pEmEdBKIPH88CHjpaGDtGECHCJG3fv0v3c4UZoy9zLD5xWIqEHIpppMCUSsvxF5E0HUiTaAEx69hkqMM2/UD2b26uBukrT1YveasYlAvLmqRD5TJ9fdyf2YZgryVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757434107; c=relaxed/simple;
	bh=cA9M2c+NwIj2R5SNaIYS+Uj81/D0soHwTzFXUWCg/9c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fYzjAxih5Ni3xUIN1BGmwjzG+MnYRtxf4U+recS0/yeYJ3EQERuyS6M0PccPpiCI//jBWbTLvOSpS1RzkqHdY5SyOX3CN+1SeoHkURtJDKVdxXqlj8SdpVsqvH6c3giskLv7b1uIJZDigMLCNqwKLlfOT3Fc/sdU2GW5/60/dZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0mtn3BHD; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757434106; x=1788970106;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cA9M2c+NwIj2R5SNaIYS+Uj81/D0soHwTzFXUWCg/9c=;
  b=0mtn3BHDvXBdLSoHILRObME1FvConHbfJpLX5Iz0yr1lNS9qtSBZpGXf
   fZ/iqNU16yCS0DKy1JVQrzZWldCKbw3NDxrH6eV6OLRLnzIF9Ed2g+OTS
   L1BK2RY8OT29qG2UtnEqRYlVTun3Q/bwzKWgu5ZcFCwwT02lsZQR4bgHn
   fPQWSHLYAdATiu5jKHhx+BVL1Vv0q7LcDE1ncL1ocFnfqRZONW7qgYWuM
   3p4Vg5peFTY2Zq6Er1X+CgW+WP4xqgRvm6kTVtmjnp0k/C4QvfXRKPCs9
   kBPDv9PK7iIzB8Ifku2Hu7ybQrf7OwPPVAv2avR6L9y4mRpfmQJqILMRM
   A==;
X-CSE-ConnectionGUID: U3r+KmqaRGWFfKqUCS3uWA==
X-CSE-MsgGUID: IXZNLDIGTJK36sEJeagksA==
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="277647069"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 09:08:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 9 Sep 2025 09:07:55 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 9 Sep 2025 09:07:55 -0700
From: <Ryan.Wanner@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH] ARM: dts: microchip: sama7d65: Add GPIO buttons and LEDs
Date: Tue, 9 Sep 2025 09:08:38 -0700
Message-ID: <20250909160842.392075-1-Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Add the USER button as a GPIO input as well as add the LEDs and enable
the blue LED as a heartbeat.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 .../dts/microchip/at91-sama7d65_curiosity.dts | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
index f091cc40a9f0..2fe34c59d942 100644
--- a/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
@@ -11,6 +11,7 @@
 #include "sama7d65-pinfunc.h"
 #include "sama7d65.dtsi"
 #include <dt-bindings/mfd/atmel-flexcom.h>
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/at91.h>
 
 / {
@@ -26,6 +27,42 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_key_gpio_default>;
+
+		button {
+			label = "PB_USER";
+			gpios = <&pioa PIN_PC10 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_PROG1>;
+			wakeup-source;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_led_gpio_default>;
+
+		led-red {
+			label = "red";
+			gpios = <&pioa PIN_PB17 GPIO_ACTIVE_HIGH>; /* Conflict with pwm. */
+		};
+
+		led-green {
+			label = "green";
+			gpios = <&pioa PIN_PB15 GPIO_ACTIVE_HIGH>; /* Conflict with pwm. */
+		};
+
+		led-blue {
+			label = "blue";
+			gpios = <&pioa PIN_PA21 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
 	memory@60000000 {
 		device_type = "memory";
 		reg = <0x60000000 0x40000000>;
@@ -352,6 +389,18 @@ pinctrl_i2c10_default: i2c10-default {
 		bias-pull-up;
 	};
 
+	pinctrl_key_gpio_default: key-gpio-default {
+		pinmux = <PIN_PC10__GPIO>;
+		bias-pull-up;
+	};
+
+	pinctrl_led_gpio_default: led-gpio-default {
+		pinmux = <PIN_PB15__GPIO>,
+			 <PIN_PB17__GPIO>,
+			 <PIN_PA21__GPIO>;
+		bias-pull-up;
+	};
+
 	pinctrl_sdmmc1_default: sdmmc1-default {
 		cmd-data {
 			pinmux = <PIN_PB22__SDMMC1_CMD>,
-- 
2.43.0



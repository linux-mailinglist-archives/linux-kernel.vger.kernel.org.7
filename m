Return-Path: <linux-kernel+bounces-728934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA02B02F30
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 09:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2ABA16CAC8
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 07:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235781EF39F;
	Sun, 13 Jul 2025 07:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d58BI9DE"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27161DE2DE;
	Sun, 13 Jul 2025 07:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752391142; cv=none; b=SwCfy1GSd8nE5Y37up5oKjS8JS9dNJAfXKvlIQi6fMj0vi93AaarmkzYp7Wmw7j+nhSi6dvsYyCeatwy4gEQRTf1c7RWfqND1jmLIPhoaQHPUcGTc18pvMLLAN8zwLyjo1rngLbGyMFN81ElCfX4BnCDzHU8tCQYVPH94g2YSpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752391142; c=relaxed/simple;
	bh=pi1nRKY48CjejoxDCAP7B6hXUe8AuXw0NVJMjVEE6fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aE1ALx6PIbjhXZoaGqCxJvf2azGxV7jJROlYtaVQ53NYWcBNnGGrs5ZczmuM7hC/b6tIoMv9yPdK0kHOTtZr/S+ANGTUvOZKYX9Z7X/s6fnoQ297orK+tPZa+md3VMvEKKNvd8pErhxySy/8avj5VtkkSXfkOQZr80RbFZ8El+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d58BI9DE; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23dea2e01e4so33299975ad.1;
        Sun, 13 Jul 2025 00:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752391140; x=1752995940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5F1ZO24wNNY+5sou67j5rv4c9r5fzLMbsPh7vrdpai0=;
        b=d58BI9DEVrErvXtSCHdsuOyGrh8u6JgT18qedLvYpFNTR1BGWotLne7Tv0F4I3Kbtu
         bxd5J9q8dTzy0pXUStbCe6lC59/351pkAWZj45hTTRdOJ7FQbP0KTxBKUFIeZie9rcUI
         J91ivfyAUghG2hQvTVzLcCUuoWCNEAPfJfqT8/ed9rBrQJY6DWHnRG9TAFWQNGUoUAYQ
         JenPitmtCi3nseJs82sgAAC0tpA1FYyea5WS8GQXMj3+iYYoe13GtUbHbBacvMVXo0Gt
         8c2dNLhc49KWOtZ/wq2dVonVMJcOlKsuRSQjW4k5ex1T6IcNUF0NA2Oh+iUh4IKAitfJ
         rRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752391140; x=1752995940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5F1ZO24wNNY+5sou67j5rv4c9r5fzLMbsPh7vrdpai0=;
        b=hI2U4qjeVEJSPREo0goz70nP7rNhe/7GH6tTKFicnGtlZiWank4sv8XOpIVzUgXBtf
         8RtVTyi9uTcZxeF2eR0HMBLhm4sjVZysamMfwtJJCjhZOwj/EosdRYgewEkKcRM5+DM3
         rwyVaQviq1R4VzswddDHtYBaeDJQ2BiwTaEzndPPd4h7YpsltFIytnEPmU96cR2Hu5Ms
         nmdVgUTBNhiDYLo/Y1sQ6lpE1zlrgZTk90QIk32mRqLvHpgCi+YSMMFuvJ+ijbFWPu7q
         Hi0UVNoMJlisGHvvRzZVRkSa0/D9DDSC752ACV+ZH5cyhHFnWl9aD1JuR4B50Y2zQwLv
         ntgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUc8v0x8OE6XvAt8LNn/IMW1N0sfDcrGpR4Faz35cwbKGG1S5AL4mpWguHC+tVQ4rE0OJr/JT25rIKh@vger.kernel.org, AJvYcCVpmQu0Oe5PNDW+jGWBUQSMVZ9SBhTtZhwdZlMFMNldS7C4TE92sLjQsxgAwSYRIjaVimrJtroGyCoRwnPP@vger.kernel.org
X-Gm-Message-State: AOJu0YzUv3GmztrdCJ/wO5J9imrtx2QVO2zffb0cJ5Mc9fY5V/RmNth/
	mg2sm5UQH9DOSpiz1JtDQpYxpZLo3upfEWBxUCwXZyIsXzyt73FO7pcA
X-Gm-Gg: ASbGncvHUssiC5GVTvBmM3nVU6QZvo71q8KGswi1naOC+KuBWV7PWAo8GbFDMpG2tl7
	s27SLTsmqGXbAuyadoNW8SZNr5rAjesXr0idn1Llgqy91aOGyPjyufCttMgmXwNKsvpYL28EwTT
	I9TqM52xrEo14SHULNJxI236muG8EZZQMO6hXQc5NVirLGOdg1UIeKVjmcUtSz19WmaY27p858V
	zJxxD7WJID/aBAzNm4tfLyZj9KFWD6pr+fLvjKwWxL5OyFxyjU0O53ub+yUAmErRsB+wQeem4zQ
	uylPEEsUhS8UCF/LdAr6JXR8SOyXQiUqe2x5XeNtd0yKAzWTXARBuJUK2ADTSzut/yfxGcCB2pW
	es8pI3X/y39CxZtCEgSC/HOpbRg==
X-Google-Smtp-Source: AGHT+IGtfwjhV2H9OBfrlIM3+l+YVqFoInY2+1bUWH5A+M0gen9iQq7FCd1GpdQVaexjxABbsRCv0g==
X-Received: by 2002:a17:902:ce10:b0:21f:1202:f2f5 with SMTP id d9443c01a7336-23dede2dff2mr131512825ad.8.1752391140178;
        Sun, 13 Jul 2025 00:19:00 -0700 (PDT)
Received: from ubu24.. ([2400:2410:dfca:c200:3d5e:f962:c950:134e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4322db2sm75239065ad.100.2025.07.13.00.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 00:18:59 -0700 (PDT)
From: Taishi Shimizu <s.taishi14142@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Rafal Milecki <zajec5@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Taishi Shimizu <s.taishi14142@gmail.com>
Subject: [PATCH v2 2/2] ARM: dts: BCM5301X: Add support for Buffalo WXR-1750DHP
Date: Sun, 13 Jul 2025 16:18:25 +0900
Message-ID: <20250713071826.726682-3-s.taishi14142@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250713071826.726682-1-s.taishi14142@gmail.com>
References: <20250713071826.726682-1-s.taishi14142@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial device tree support for the Buffalo WXR-1750DHP, a consumer Wi-Fi
router based on the Broadcom BCM4708A0 SoC.

Hardware specifications:
* Processor: Broadcom BCM4708A0 dual-core @ 800 MHz
* RAM: DDR3 256 MB
* Ethernet Switch: Broadcom BCM53011 integrated via SRAB
* NAND Flash: 128 MB (8-bit ECC)
* SPI Flash: None
* Ports: 4 LAN Ports, 1 WAN Port
* USB: 1x USB 3.0 Type-A port

Signed-off-by: Taishi Shimizu <s.taishi14142@gmail.com>
---
 arch/arm/boot/dts/broadcom/Makefile           |   1 +
 .../broadcom/bcm4708-buffalo-wxr-1750dhp.dts  | 138 ++++++++++++++++++
 2 files changed, 139 insertions(+)
 create mode 100644 arch/arm/boot/dts/broadcom/bcm4708-buffalo-wxr-1750dhp.dts

diff --git a/arch/arm/boot/dts/broadcom/Makefile b/arch/arm/boot/dts/broadcom/Makefile
index 71062ff9adbe..2552e11b5e31 100644
--- a/arch/arm/boot/dts/broadcom/Makefile
+++ b/arch/arm/boot/dts/broadcom/Makefile
@@ -51,6 +51,7 @@ dtb-$(CONFIG_ARCH_BCMBCA) += \
 dtb-$(CONFIG_ARCH_BCM_5301X) += \
 	bcm4708-asus-rt-ac56u.dtb \
 	bcm4708-asus-rt-ac68u.dtb \
+	bcm4708-buffalo-wxr-1750dhp.dtb \
 	bcm4708-buffalo-wzr-1750dhp.dtb \
 	bcm4708-buffalo-wzr-1166dhp.dtb \
 	bcm4708-buffalo-wzr-1166dhp2.dtb \
diff --git a/arch/arm/boot/dts/broadcom/bcm4708-buffalo-wxr-1750dhp.dts b/arch/arm/boot/dts/broadcom/bcm4708-buffalo-wxr-1750dhp.dts
new file mode 100644
index 000000000000..f5c95c9a712e
--- /dev/null
+++ b/arch/arm/boot/dts/broadcom/bcm4708-buffalo-wxr-1750dhp.dts
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Author: Taishi Shimizu <s.taishi14142@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "bcm4708.dtsi"
+#include "bcm5301x-nand-cs0-bch8.dtsi"
+#include <dt-bindings/leds/common.h>
+
+/ {
+	compatible = "buffalo,wxr-1750dhp", "brcm,bcm4708";
+	model = "Buffalo WXR-1750DHP";
+
+	memory@0 {
+		reg = <0x00000000 0x08000000>,
+		      <0x88000000 0x08000000>;
+		device_type = "memory";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		button-aoss {
+			gpios = <&chipcommon 2 GPIO_ACTIVE_LOW>;
+			label = "AOSS";
+			linux,code = <KEY_WPS_BUTTON>;
+		};
+
+		/* GPIO 3 is a switch button with AUTO / MANUAL. */
+		button-manual {
+			gpios = <&chipcommon 3 GPIO_ACTIVE_HIGH>;
+			label = "MANUAL";
+			linux,code = <BTN_0>;
+			linux,input-type = <EV_SW>;
+		};
+
+		button-restart {
+			gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
+			label = "Reset";
+			linux,code = <KEY_RESTART>;
+		};
+
+		/* GPIO 8 and 9 are a tri-state switch button with
+		 * ROUTER / AP / WB.
+		 */
+		button-router {
+			gpios = <&chipcommon 8 GPIO_ACTIVE_LOW>;
+			label = "ROUTER";
+			linux,code = <BTN_1>;
+			linux,input-type = <EV_SW>;
+		};
+
+		button-wb {
+			gpios = <&chipcommon 9 GPIO_ACTIVE_LOW>;
+			label = "WB";
+			linux,code = <BTN_2>;
+			linux,input-type = <EV_SW>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-internet {
+			color = <LED_COLOR_ID_WHITE>;
+			function = "internet";
+			gpios = <&chipcommon 7 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-power0 {
+			color = <LED_COLOR_ID_AMBER>;
+			function = LED_FUNCTION_POWER;
+			gpios = <&chipcommon 6 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-power1 {
+			color = <LED_COLOR_ID_WHITE>;
+			function = LED_FUNCTION_POWER;
+			gpios = <&chipcommon 5 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-router0 {
+			color = <LED_COLOR_ID_AMBER>;
+			function = "router";
+			gpios = <&chipcommon 14 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-router1 {
+			color = <LED_COLOR_ID_WHITE>;
+			function = "router";
+			gpios = <&chipcommon 15 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-usb {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_USB;
+			gpios = <&chipcommon 4 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "usbport";
+			trigger-sources = <&xhci_port1 &ehci_port1 &ohci_port1>;
+		};
+	};
+};
+
+&srab {
+	status = "okay";
+
+	ports {
+		port@0 {
+			label = "wan";
+		};
+
+		port@1 {
+			label = "lan4";
+		};
+
+		port@2 {
+			label = "lan3";
+		};
+
+		port@3 {
+			label = "lan2";
+		};
+
+		port@4 {
+			label = "lan1";
+		};
+	};
+};
+
+&usb3 {
+	vcc-gpio = <&chipcommon 10 GPIO_ACTIVE_HIGH>;
+};
+
+&usb3_phy {
+	status = "okay";
+};
-- 
2.43.0



Return-Path: <linux-kernel+bounces-798467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9E2B41E5D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A03560008
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373532FD7D0;
	Wed,  3 Sep 2025 12:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lubyOxMj"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2562FD1D3;
	Wed,  3 Sep 2025 12:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756901175; cv=none; b=ScT0SX4Wr6mSayH6kxshXqjenzDLndsqT7BPQ2ktGUe+Rm6lQusHVXjKNI2PjeJ69z754QqMUSvF/Tvh0arjDyqbNPiOSrgGoohlsDHGL7JXbJLVSg314gB31N41vVlkBNqjgCfHJWEtU33ZX6SakLdt+/gBf06OT57+3DY0eiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756901175; c=relaxed/simple;
	bh=rfwT0lSjHPT0sHGm6VUEpNiExAH+3kOxkFCP7VRdtjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cY6ZtejAKx61149qS9OMP5ubbmMVZCnhXG9BDyEXaSK1XCkmB37S45ZgSS/fcSvcYsFfo6b9vWon9LYPSMpHQ+Psw/INS5DajhiJX/ubMcuHcnYyUVB5aF0bhgI75JPAUWnyObCtNPoRd7qTN+7F90Kc1pk5d9jbaWP9u0Eh5L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lubyOxMj; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7726c7ff7e5so2005352b3a.3;
        Wed, 03 Sep 2025 05:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756901172; x=1757505972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmVmOqREG/tUFzTXWdlmLI36ExmLR6+mOJtNlgY2VXE=;
        b=lubyOxMjExpAB3aoClbPfUErpPFgtq5QE2P4a9U9SM77CMWtUyUUPxtequbrWEBDcz
         2cHzYZv04Asbi3iD/U1UEvRMT+FFL2gj6ABt26jNN7aMbqqJXOL6xf4utPosaJhMa1Sm
         N44Y71K3rchSViNOJVPJgW1AGet4o24qrxtNKkrr3XZN92G2lHD0mNIUDhfB2wlte8mK
         +UFJ74v/l9xSLKZcu+w/gWF+nJCP5cCDxNp8eKCBLspwc4d3GslypM9wAdSSksyvmde1
         4TOCziwrdu/a2L/DoU+cVU7m76sc/Aksygil4S5HUjQ5v2xjCCb7isWkvZK8sEf2AwCE
         bHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756901172; x=1757505972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmVmOqREG/tUFzTXWdlmLI36ExmLR6+mOJtNlgY2VXE=;
        b=B6VVF3qXLS/g+qp32zyk18djlfOFyjDxhSDvp3Y4wyKlpogt9Y3vSP+0vjf/Z4uE9z
         pclF12y/h5lzEvKNKQrrviLHWwf33K5bSHtV354/75G5994fcRN6FbacUzcLM+1toi3r
         x8633jNplibjAoe5hJNDlha7cAKqwMeGODRxbifY7hcWWlzOg/sG0ziR7ijg051wuZyo
         IdF1aUpnS7/5kL4AuoRxOJeBHfvzA9TmyK80JKP51Zl2bUGoZehEicoQpEomYvq0saqJ
         rbzHbnuPDW3ts54D5shviUbsw9u/cD5PMhhXRNmjDqGyVN74btEWE0IMVNqA/8Libxbf
         7tXw==
X-Forwarded-Encrypted: i=1; AJvYcCWK44FaR1QUJJhcF48ytwBu37cEkfI589fQCnTPbUSq5ImYrXD1NJidclaBBTjVL+SL9KDXTlGcA3T9@vger.kernel.org, AJvYcCX6IYAfISvfZdss5iqQCmNwuKYHjMOMn3QYnnXajUzYHAPSm81f57ADFAMaF840eLST7l6B7iCoaK6DpHVz@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Nw7LOgb2tGAZ/Mh2ezV7bJgtuDffI6aLyxRFLRVp5p/4fgYN
	4RVt9iUBpgVlHCe15NXp0jHWngtyi+s8POlKhL+Meo7zw3BTWyVKGbGB
X-Gm-Gg: ASbGncvdZRt5AXcZokIWkzbNH96ynQawD0X5WAuELdh3CgcNpuPddmk3eLvQo7jspt6
	0c+hXySHtTma3PcGccZOibChzwqKZCakRuYxtu8Kk5i2iWMvUhAU5LyKtftGhRxsT+Lz7ExYXPM
	FjXXTnjbig6HA/ofhyvt7Dt3Zmc5RSnHyFDa+WdKEPi5ahidgnHULkWGvHU1zm8UEX5b4rWuQsM
	V5JXG5cJA1T/saGJ/FlOw4fTT2a/N1ALF6jiyQp+iWydDittAWTYGhOE3HCA1bPNXn4Def05FO4
	6aeBvNc6R6tFTUQwsljlIk6EKXPMhXS0ssnapkfehhhSS7pw1C9S9VU5gy1vnuJ1whmjXm7BNBO
	xUsJq5s40RvND9AdE5Y4vD1OmvOtHum5Sw8RTYx7yiQt2534S6qlwla5H2Cb3MUeb9yuTnu/nFL
	ynDSI5UdtI
X-Google-Smtp-Source: AGHT+IFnbxGpmbZWqTBYQqiVeRxYDMczV8bOpTzUgM/t17IytEpQWfeVudqjktm+zNceU5YRTI6a1w==
X-Received: by 2002:a17:902:e751:b0:248:a054:e1c4 with SMTP id d9443c01a7336-249448f8ad8mr182023025ad.23.1756901170537;
        Wed, 03 Sep 2025 05:06:10 -0700 (PDT)
Received: from pk-pc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490648c89bsm160905185ad.109.2025.09.03.05.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 05:06:10 -0700 (PDT)
From: "P.K. Lee" <pkleequanta@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	patrick@stwcx.xyz
Cc: Jerry.Lin@quantatw.com,
	Jason-Hsu@quantatw.com,
	yang.chen@quantatw.com,
	p.k.lee@quantatw.com
Subject: [PATCH v11 2/2] ARM: dts: aspeed: ventura: add Meta Ventura BMC
Date: Wed,  3 Sep 2025 20:06:00 +0800
Message-ID: <20250903120600.632041-3-pkleequanta@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250903120600.632041-1-pkleequanta@gmail.com>
References: <20250903120600.632041-1-pkleequanta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Linux device tree related to Meta (Facebook) Ventura specific
devices connected to the BMC (AST2600) SoC. The purpose of Ventura is to
detect liquid leakage from all compute trays, switch trays and rack
sensors within the rack, log the events, and take necessary actions
accordingly.

Signed-off-by: P.K. Lee <pkleequanta@gmail.com>
---
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-facebook-ventura.dts    | 1578 +++++++++++++++++
 2 files changed, 1579 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dts

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index 0f0b5b707654..476eea83445b 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -32,6 +32,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-facebook-minipack.dtb \
 	aspeed-bmc-facebook-santabarbara.dtb \
 	aspeed-bmc-facebook-tiogapass.dtb \
+	aspeed-bmc-facebook-ventura.dts \
 	aspeed-bmc-facebook-wedge40.dtb \
 	aspeed-bmc-facebook-wedge100.dtb \
 	aspeed-bmc-facebook-wedge400-data64.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dts
new file mode 100644
index 000000000000..e00993100027
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dts
@@ -0,0 +1,1578 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2023 Facebook Inc.
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/i2c/i2c.h>
+#include <dt-bindings/gpio/aspeed-gpio.h>
+
+/ {
+	model = "Facebook ventura RMC";
+	compatible = "facebook,ventura-rmc", "aspeed,ast2600";
+
+	aliases {
+		serial4 = &uart5;
+		i2c16 = &i2c3mux0ch3;
+		i2c17 = &i2c3mux0ch4;
+		i2c18 = &i2c3mux0ch5;
+		i2c19 = &i2c3mux0ch6;
+		i2c20 = &i2c3mux0ch0;
+		i2c21 = &i2c3mux0ch1;
+		i2c22 = &i2c3mux0ch2;
+		i2c23 = &i2c3mux0ch7;
+		i2c24 = &i2c0mux0ch0;
+		i2c25 = &i2c0mux0ch1;
+		i2c26 = &i2c0mux0ch2;
+		i2c27 = &i2c0mux0ch3;
+		i2c28 = &i2c0mux0ch4;
+		i2c29 = &i2c0mux0ch5;
+		i2c30 = &i2c0mux0ch6;
+		i2c31 = &i2c0mux0ch7;
+		i2c32 = &i2c1mux0ch0;
+		i2c33 = &i2c1mux0ch1;
+		i2c34 = &i2c1mux0ch2;
+		i2c35 = &i2c1mux0ch3;
+		i2c36 = &i2c1mux0ch4;
+		i2c37 = &i2c1mux0ch5;
+		i2c38 = &i2c1mux0ch6;
+		i2c39 = &i2c1mux0ch7;
+		i2c40 = &i2c2mux0ch0;
+		i2c41 = &i2c2mux0ch1;
+		i2c42 = &i2c2mux0ch2;
+		i2c43 = &i2c2mux0ch3;
+		i2c44 = &i2c2mux0ch4;
+		i2c45 = &i2c2mux0ch5;
+		i2c46 = &i2c2mux0ch6;
+		i2c47 = &i2c2mux0ch7;
+	};
+
+	chosen {
+		stdout-path = "serial4:57600n8";
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
+			<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
+			<&adc1 2>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			label = "bmc_heartbeat_amber";
+			gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		led-1 {
+			label = "fp_id_amber";
+			default-state = "off";
+			gpios = <&gpio0 ASPEED_GPIO(B, 5) GPIO_ACTIVE_HIGH>;
+		};
+
+		led-2 {
+			label = "bmc_ready_noled";
+			default-state = "on";
+			gpios = <&gpio0 ASPEED_GPIO(B, 3) (GPIO_ACTIVE_HIGH|GPIO_TRANSITORY)>;
+		};
+
+		led-3 {
+			label = "power_blue";
+			default-state = "off";
+			gpios = <&gpio0 ASPEED_GPIO(P, 4) GPIO_ACTIVE_HIGH>;
+		};
+
+		led-4 {
+			label = "compute1_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g5_gpio 0 GPIO_ACTIVE_LOW>;
+		};
+
+		led-5 {
+			label = "compute1_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 15 GPIO_ACTIVE_LOW>;
+		};
+
+		led-6 {
+			label = "compute1_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 14 GPIO_ACTIVE_LOW>;
+		};
+
+		led-7 {
+			label = "compute2_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 11 GPIO_ACTIVE_LOW>;
+		};
+
+		led-8 {
+			label = "compute2_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 10 GPIO_ACTIVE_LOW>;
+		};
+
+		led-9 {
+			label = "compute2_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 9 GPIO_ACTIVE_LOW>;
+		};
+
+		led-10 {
+			label = "compute3_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 8 GPIO_ACTIVE_LOW>;
+		};
+
+		led-11 {
+			label = "compute3_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 7 GPIO_ACTIVE_LOW>;
+		};
+
+		led-12 {
+			label = "compute3_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 6 GPIO_ACTIVE_LOW>;
+		};
+
+		led-13 {
+			label = "compute4_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 1 GPIO_ACTIVE_LOW>;
+		};
+
+		led-14 {
+			label = "compute4_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 0 GPIO_ACTIVE_LOW>;
+		};
+
+		led-15 {
+			label = "compute4_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 15 GPIO_ACTIVE_LOW>;
+		};
+
+		led-16 {
+			label = "compute5_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 14 GPIO_ACTIVE_LOW>;
+		};
+
+		led-17 {
+			label = "compute5_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 13 GPIO_ACTIVE_LOW>;
+		};
+
+		led-18 {
+			label = "compute5_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 12 GPIO_ACTIVE_LOW>;
+		};
+
+		led-19 {
+			label = "compute6_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 7 GPIO_ACTIVE_LOW>;
+		};
+
+		led-20 {
+			label = "compute6_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 6 GPIO_ACTIVE_LOW>;
+		};
+
+		led-21 {
+			label = "compute6_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 5 GPIO_ACTIVE_LOW>;
+		};
+
+		led-22 {
+			label = "compute7_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 4 GPIO_ACTIVE_LOW>;
+		};
+
+		led-23 {
+			label = "compute7_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 3 GPIO_ACTIVE_LOW>;
+		};
+
+		led-24 {
+			label = "compute7_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 2 GPIO_ACTIVE_LOW>;
+		};
+
+		led-25 {
+			label = "compute8_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 13 GPIO_ACTIVE_LOW>;
+		};
+
+		led-26 {
+			label = "compute8_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 12 GPIO_ACTIVE_LOW>;
+		};
+
+		led-27 {
+			label = "compute8_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 11 GPIO_ACTIVE_LOW>;
+		};
+
+		led-28 {
+			label = "nvs1_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 10 GPIO_ACTIVE_LOW>;
+		};
+
+		led-29 {
+			label = "nvs1_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 9 GPIO_ACTIVE_LOW>;
+		};
+
+		led-30 {
+			label = "nvs1_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 8 GPIO_ACTIVE_LOW>;
+		};
+
+		led-31 {
+			label = "nvs2_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 3 GPIO_ACTIVE_LOW>;
+		};
+
+		led-32 {
+			label = "nvs2_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 2 GPIO_ACTIVE_LOW>;
+		};
+
+		led-33 {
+			label = "nvs2_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 1 GPIO_ACTIVE_LOW>;
+		};
+
+		led-34 {
+			label = "nvs3_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 0 GPIO_ACTIVE_LOW>;
+		};
+
+		led-35 {
+			label = "nvs3_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 15 GPIO_ACTIVE_LOW>;
+		};
+
+		led-36 {
+			label = "nvs3_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g4_gpio 14 GPIO_ACTIVE_LOW>;
+		};
+
+		led-37 {
+			label = "nvs4_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 9 GPIO_ACTIVE_LOW>;
+		};
+
+		led-38 {
+			label = "nvs4_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 8 GPIO_ACTIVE_LOW>;
+		};
+
+		led-39 {
+			label = "nvs4_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 7 GPIO_ACTIVE_LOW>;
+		};
+
+		led-40 {
+			label = "nvs5_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 6 GPIO_ACTIVE_LOW>;
+		};
+
+		led-41 {
+			label = "nvs5_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 5 GPIO_ACTIVE_LOW>;
+		};
+
+		led-42 {
+			label = "nvs5_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 4 GPIO_ACTIVE_LOW>;
+		};
+
+		led-43 {
+			label = "nvs6_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 15 GPIO_ACTIVE_LOW>;
+		};
+
+		led-44 {
+			label = "nvs6_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 14 GPIO_ACTIVE_LOW>;
+		};
+
+		led-45 {
+			label = "nvs6_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 13 GPIO_ACTIVE_LOW>;
+		};
+
+		led-46 {
+			label = "nvs7_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 12 GPIO_ACTIVE_LOW>;
+		};
+
+		led-47 {
+			label = "nvs7_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 11 GPIO_ACTIVE_LOW>;
+		};
+
+		led-48 {
+			label = "nvs7_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g3_gpio 10 GPIO_ACTIVE_LOW>;
+		};
+
+		led-49 {
+			label = "nvs8_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 5 GPIO_ACTIVE_LOW>;
+		};
+
+		led-50 {
+			label = "nvs8_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 4 GPIO_ACTIVE_LOW>;
+		};
+
+		led-51 {
+			label = "nvs8_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 3 GPIO_ACTIVE_LOW>;
+		};
+
+		led-52 {
+			label = "nvs9_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 2 GPIO_ACTIVE_LOW>;
+		};
+
+		led-53 {
+			label = "nvs9_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 1 GPIO_ACTIVE_LOW>;
+		};
+
+		led-54 {
+			label = "nvs9_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 0 GPIO_ACTIVE_LOW>;
+		};
+
+		led-55 {
+			label = "compute9_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 11 GPIO_ACTIVE_LOW>;
+		};
+
+		led-56 {
+			label = "compute9_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 10 GPIO_ACTIVE_LOW>;
+		};
+
+		led-57 {
+			label = "compute9_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 9 GPIO_ACTIVE_LOW>;
+		};
+
+		led-58 {
+			label = "compute10_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 8 GPIO_ACTIVE_LOW>;
+		};
+
+		led-59 {
+			label = "compute10_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 7 GPIO_ACTIVE_LOW>;
+		};
+
+		led-60 {
+			label = "compute10_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 6 GPIO_ACTIVE_LOW>;
+		};
+
+		led-61 {
+			label = "compute11_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 1 GPIO_ACTIVE_LOW>;
+		};
+
+		led-62 {
+			label = "compute11_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 0 GPIO_ACTIVE_LOW>;
+		};
+
+		led-63 {
+			label = "compute11_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 15 GPIO_ACTIVE_LOW>;
+		};
+
+		led-64 {
+			label = "compute12_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 14 GPIO_ACTIVE_LOW>;
+		};
+
+		led-65 {
+			label = "compute12_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 13 GPIO_ACTIVE_LOW>;
+		};
+
+		led-66 {
+			label = "compute12_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g6_gpio 12 GPIO_ACTIVE_LOW>;
+		};
+
+		led-67 {
+			label = "compute13_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 7 GPIO_ACTIVE_LOW>;
+		};
+
+		led-68 {
+			label = "compute13_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 6 GPIO_ACTIVE_LOW>;
+		};
+
+		led-69 {
+			label = "compute13_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 5 GPIO_ACTIVE_LOW>;
+		};
+
+		led-70 {
+			label = "compute14_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 4 GPIO_ACTIVE_LOW>;
+		};
+
+		led-71 {
+			label = "compute14_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 3 GPIO_ACTIVE_LOW>;
+		};
+
+		led-72 {
+			label = "compute14_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 2 GPIO_ACTIVE_LOW>;
+		};
+
+		led-73 {
+			label = "compute15_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 13 GPIO_ACTIVE_LOW>;
+		};
+
+		led-74 {
+			label = "compute15_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 12 GPIO_ACTIVE_LOW>;
+		};
+
+		led-75 {
+			label = "compute15_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 11 GPIO_ACTIVE_LOW>;
+		};
+
+		led-76 {
+			label = "compute16_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 10 GPIO_ACTIVE_LOW>;
+		};
+
+		led-77 {
+			label = "compute16_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 9 GPIO_ACTIVE_LOW>;
+		};
+
+		led-78 {
+			label = "compute16_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g2_gpio 8 GPIO_ACTIVE_LOW>;
+		};
+
+		led-79 {
+			label = "compute17_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 5 GPIO_ACTIVE_LOW>;
+		};
+
+		led-80 {
+			label = "compute17_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 4 GPIO_ACTIVE_LOW>;
+		};
+
+		led-81 {
+			label = "compute17_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 3 GPIO_ACTIVE_LOW>;
+		};
+
+		led-82 {
+			label = "compute18_led_switch";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 2 GPIO_ACTIVE_LOW>;
+		};
+
+		led-83 {
+			label = "compute18_led_blue";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 1 GPIO_ACTIVE_LOW>;
+		};
+
+		led-84 {
+			label = "compute18_led_amber";
+			default-state = "off";
+			gpios = <&tray_leds_g1_gpio 0 GPIO_ACTIVE_LOW>;
+		};
+
+		led-85 {
+			label = "fan0_ledd1_blue";
+			default-state = "off";
+			gpios = <&fan_leds_g1_gpio 0 GPIO_ACTIVE_LOW>;
+		};
+
+		led-86 {
+			label = "fan0_ledd2_blue";
+			default-state = "off";
+			gpios = <&fan_leds_g1_gpio 1 GPIO_ACTIVE_LOW>;
+		};
+
+		led-87 {
+			label = "fan0_ledd1_amber";
+			default-state = "off";
+			gpios = <&fan_leds_g1_gpio 4 GPIO_ACTIVE_LOW>;
+		};
+
+		led-88 {
+			label = "fan0_ledd2_amber";
+			default-state = "off";
+			gpios = <&fan_leds_g1_gpio 5 GPIO_ACTIVE_LOW>;
+		};
+
+		led-89 {
+			label = "fan1_ledd1_blue";
+			default-state = "off";
+			gpios = <&fan_leds_g2_gpio 0 GPIO_ACTIVE_LOW>;
+		};
+
+		led-90 {
+			label = "fan1_ledd2_blue";
+			default-state = "off";
+			gpios = <&fan_leds_g2_gpio 1 GPIO_ACTIVE_LOW>;
+		};
+
+		led-91 {
+			label = "fan1_ledd1_amber";
+			default-state = "off";
+			gpios = <&fan_leds_g2_gpio 4 GPIO_ACTIVE_LOW>;
+		};
+
+		led-92 {
+			label = "fan1_ledd2_amber";
+			default-state = "off";
+			gpios = <&fan_leds_g2_gpio 5 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
+	};
+
+	p1v8_bmc_aux: regulator-p1v8-bmc-aux {
+		compatible = "regulator-fixed";
+		regulator-name = "p1v8_bmc_aux";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	p2v5_bmc_aux: regulator-p2v5-bmc-aux {
+		compatible = "regulator-fixed";
+		regulator-name = "p2v5_bmc_aux";
+		regulator-min-microvolt = <2500000>;
+		regulator-max-microvolt = <2500000>;
+		regulator-always-on;
+	};
+
+	spi1_gpio: spi {
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		sck-gpios = <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
+		mosi-gpios = <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
+		miso-gpios = <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH>;
+		cs-gpios = <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
+		num-chipselects = <1>;
+
+		tpm@0 {
+			compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
+			spi-max-frequency = <33000000>;
+			reg = <0>;
+		};
+	};
+};
+
+&fmc {
+	status = "okay";
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc";
+		spi-max-frequency = <50000000>;
+#include "openbmc-flash-layout-128.dtsi"
+	};
+	flash@1 {
+		status = "okay";
+		m25p,fast-read;
+		label = "alt-bmc";
+		spi-max-frequency = <50000000>;
+	};
+};
+
+&mdio0 {
+	status = "okay";
+};
+
+&mac3 {
+	status = "okay";
+	phy-mode = "rmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii4_default>;
+	fixed-link {
+		speed = <100>;
+		full-duplex;
+	};
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&uhci {
+	status = "okay";
+};
+
+&adc0 {
+	vref-supply = <&p1v8_bmc_aux>;
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
+		&pinctrl_adc2_default &pinctrl_adc3_default
+		&pinctrl_adc4_default &pinctrl_adc5_default
+		&pinctrl_adc6_default &pinctrl_adc7_default>;
+};
+
+&adc1 {
+	vref-supply = <&p2v5_bmc_aux>;
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc10_default>;
+};
+
+&gpio0 {
+	gpio-line-names =
+	/*A0-A7*/	"","","","","","","","",
+	/*B0-B7*/	"BATTERY_DETECT","","","BMC_READY","","","","",
+	/*C0-C7*/	"","","","","","","","",
+	/*D0-D7*/	"","","","","","","","",
+	/*E0-E7*/	"","","","","","","","",
+	/*F0-F7*/	"","","","","","","","",
+	/*G0-G7*/	"","","","","","","","",
+	/*H0-H7*/	"","","","","","","","",
+	/*I0-I7*/	"","","","","","","","",
+	/*J0-J7*/	"","","","","","","","",
+	/*K0-K7*/	"","","","","","","","",
+	/*L0-L7*/	"","","","","","","","",
+	/*M0-M7*/	"","","","","","","","",
+	/*N0-N7*/	"","","","","","","","",
+	/*O0-O7*/	"","","","","","","","USBDBG_IPMI_EN_L",
+	/*P0-P7*/	"","","","","","","","",
+	/*Q0-Q7*/	"","","","","","FM_MDIO_SW_SEL","","",
+	/*R0-R7*/	"","","","","","","","",
+	/*S0-S7*/	"","","","","","","","",
+	/*T0-T7*/	"","","","","","","","",
+	/*U0-U7*/	"","","","","","","","",
+	/*V0-V7*/	"","","","","","","","",
+	/*W0-W7*/	"","","","","","","","",
+	/*X0-X7*/	"","","","","","","","",
+	/*Y0-Y7*/	"","","","","","","","",
+	/*Z0-Z7*/	"","","","","","","","";
+};
+
+&sgpiom0 {
+	status = "okay";
+	ngpios = <128>;
+	bus-frequency = <2000000>;
+
+	gpio-line-names =
+	/*"input pin","output pin"*/
+	/*A0 - A7*/
+	"power-chassis-good","power-chassis-control",
+	"host0-ready","WATER_VALVE_CLOSED_N",
+	"wPRSNT_RETURN_PLD_R_N","FM_MDIO_SW_SEL_PLD",
+	"wPRSNT_SUPPLY_PLD_R_N","FM_88E6393X_BIN_UPDATE_EN_N",
+	"LEAK3_DETECT","",
+	"LEAK4_DETECT","",
+	"RETURN_CNTL_FB_D_R","",
+	"SUPPLY_CNTL_FB_D_R","",
+	/*B0 - B7*/
+	"IOEXP0_INT_N","",
+	"IOEXP11_INT_N","",
+	"IOEXP10_INT_N","",
+	"IOEXP9_INT_N","",
+	"RPU_2_READY_SPARE_PLD_R","",
+	"RPU_2_READY_PLD_R","",
+	"RPU_READY_SPARE_PLD_R","",
+	"RPU_READY_PLD_R","",
+	/*C0 - C7*/
+	"wAALC_RPU_READY","",
+	"LEAK0_DETECT","",
+	"LEAK1_DETECT","",
+	"LEAK2_DETECT","",
+	"PRSNT_COMPUTE_TRAY1_N","",
+	"PRSNT_COMPUTE_TRAY2_N","",
+	"PRSNT_COMPUTE_TRAY3_N","",
+	"PRSNT_COMPUTE_TRAY4_N","",
+	/*D0 - D7*/
+	"PRSNT_COMPUTE_TRAY5_N","",
+	"PRSNT_COMPUTE_TRAY6_N","",
+	"PRSNT_COMPUTE_TRAY7_N","",
+	"PRSNT_COMPUTE_TRAY8_N","",
+	"PRSNT_NVS_TRAY1_N","",
+	"PRSNT_NVS_TRAY2_N","",
+	"PRSNT_COMPUTE_TRAY11_N","",
+	"PRSNT_COMPUTE_TRAY12_N","",
+	/*E0 - E7*/
+	"PRSNT_COMPUTE_TRAY13_N","",
+	"PRSNT_COMPUTE_TRAY14_N","",
+	"PRSNT_COMPUTE_TRAY15_N","",
+	"PRSNT_COMPUTE_TRAY16_N","",
+	"PRSNT_COMPUTE_TRAY17_N","",
+	"PRSNT_COMPUTE_TRAY18_N","",
+	"PRSNT_NVS_TRAY3_N","",
+	"PRSNT_NVS_TRAY4_N","",
+	/*F0 - F7*/
+	"PRSNT_NVS_TRAY5_N","",
+	"PRSNT_NVS_TRAY6_N","",
+	"PRSNT_NVS_TRAY7_N","",
+	"PRSNT_NVS_TRAY8_N","",
+	"PRSNT_NVS_TRAY9_N","",
+	"PRSNT_COMPUTE_TRAY9_N","",
+	"PRSNT_COMPUTE_TRAY10_N","",
+	"SMALL_LEAK_COMPUTE_TRAY1_N","",
+	/*G0 - G7*/
+	"SMALL_LEAK_COMPUTE_TRAY2_N","",
+	"SMALL_LEAK_COMPUTE_TRAY3_N","",
+	"SMALL_LEAK_COMPUTE_TRAY4_N","",
+	"SMALL_LEAK_COMPUTE_TRAY5_N","",
+	"SMALL_LEAK_COMPUTE_TRAY6_N","",
+	"SMALL_LEAK_COMPUTE_TRAY7_N","",
+	"SMALL_LEAK_COMPUTE_TRAY8_N","",
+	"SMALL_LEAK_NVS_TRAY1_N","",
+	/*H0 - H7*/
+	"SMALL_LEAK_NVS_TRAY2_N","",
+	"SMALL_LEAK_COMPUTE_TRAY11_N","",
+	"SMALL_LEAK_COMPUTE_TRAY12_N","",
+	"SMALL_LEAK_COMPUTE_TRAY13_N","",
+	"SMALL_LEAK_COMPUTE_TRAY14_N","",
+	"SMALL_LEAK_COMPUTE_TRAY15_N","",
+	"SMALL_LEAK_COMPUTE_TRAY16_N","",
+	"SMALL_LEAK_COMPUTE_TRAY17_N","",
+	/*I0 - I7*/
+	"SMALL_LEAK_COMPUTE_TRAY18_N","",
+	"SMALL_LEAK_NVS_TRAY3_N","",
+	"SMALL_LEAK_NVS_TRAY4_N","",
+	"SMALL_LEAK_NVS_TRAY5_N","",
+	"SMALL_LEAK_NVS_TRAY6_N","",
+	"SMALL_LEAK_NVS_TRAY7_N","",
+	"SMALL_LEAK_NVS_TRAY8_N","",
+	"SMALL_LEAK_NVS_TRAY9_N","",
+	/*J0 - J7*/
+	"SMALL_LEAK_COMPUTE_TRAY9_N","",
+	"SMALL_LEAK_COMPUTE_TRAY10_N","",
+	"PWRGD_COMPUTE_TRAY1_N","",
+	"PWRGD_COMPUTE_TRAY2_N","",
+	"PWRGD_COMPUTE_TRAY3_N","",
+	"PWRGD_COMPUTE_TRAY4_N","",
+	"PWRGD_COMPUTE_TRAY5_N","",
+	"PWRGD_COMPUTE_TRAY6_N","",
+	/*K0 - K7*/
+	"PWRGD_COMPUTE_TRAY7_N","",
+	"PWRGD_COMPUTE_TRAY8_N","",
+	"PWRGD_NVS_TRAY1_PWROK_N","",
+	"PWRGD_NVS_TRAY2_PWROK_N","",
+	"PWRGD_COMPUTE_TRAY11_N","",
+	"PWRGD_COMPUTE_TRAY12_N","",
+	"PWRGD_COMPUTE_TRAY13_N","",
+	"PWRGD_COMPUTE_TRAY14_N","",
+	/*L0 - L7*/
+	"PWRGD_COMPUTE_TRAY15_N","",
+	"PWRGD_COMPUTE_TRAY16_N","",
+	"PWRGD_COMPUTE_TRAY17_N","",
+	"PWRGD_COMPUTE_TRAY18_N","",
+	"PWRGD_NVS_TRAY3_PWROK_N","",
+	"PWRGD_NVS_TRAY4_PWROK_N","",
+	"PWRGD_NVS_TRAY5_PWROK_N","",
+	"PWRGD_NVS_TRAY6_PWROK_N","",
+	/*M0 - M7*/
+	"PWRGD_NVS_TRAY7_PWROK_N","",
+	"PWRGD_NVS_TRAY8_PWROK_N","",
+	"PWRGD_NVS_TRAY9_PWROK_N","",
+	"PWRGD_COMPUTE_TRAY9_N","",
+	"PWRGD_COMPUTE_TRAY10_N","",
+	"LEAK_DETECT_COMPUTE_TRAY1_N","",
+	"LEAK_DETECT_COMPUTE_TRAY2_N","",
+	"LEAK_DETECT_COMPUTE_TRAY3_N","",
+	/*N0 - N7*/
+	"LEAK_DETECT_COMPUTE_TRAY4_N","",
+	"LEAK_DETECT_COMPUTE_TRAY5_N","",
+	"LEAK_DETECT_COMPUTE_TRAY6_N","",
+	"LEAK_DETECT_COMPUTE_TRAY7_N","",
+	"LEAK_DETECT_COMPUTE_TRAY8_N","",
+	"LEAK_DETECT_NVS_TRAY1_N","",
+	"LEAK_DETECT_NVS_TRAY2_N","",
+	"LEAK_DETECT_COMPUTE_TRAY11_N","",
+	/*O0 - O7*/
+	"LEAK_DETECT_COMPUTE_TRAY12_N","",
+	"LEAK_DETECT_COMPUTE_TRAY13_N","",
+	"LEAK_DETECT_COMPUTE_TRAY14_N","",
+	"LEAK_DETECT_COMPUTE_TRAY15_N","",
+	"LEAK_DETECT_COMPUTE_TRAY16_N","",
+	"LEAK_DETECT_COMPUTE_TRAY17_N","",
+	"LEAK_DETECT_COMPUTE_TRAY18_N","",
+	"LEAK_DETECT_NVS_TRAY3_N","",
+	/*P0 - P7*/
+	"LEAK_DETECT_NVS_TRAY4_N","",
+	"LEAK_DETECT_NVS_TRAY5_N","",
+	"LEAK_DETECT_NVS_TRAY6_N","",
+	"LEAK_DETECT_NVS_TRAY7_N","",
+	"LEAK_DETECT_NVS_TRAY8_N","",
+	"LEAK_DETECT_NVS_TRAY9_N","",
+	"LEAK_DETECT_COMPUTE_TRAY9_N","",
+	"LEAK_DETECT_COMPUTE_TRAY10_N","";
+};
+
+&wdt1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdtrst1_default>;
+	aspeed,reset-type = "soc";
+	aspeed,external-signal;
+	aspeed,ext-push-pull;
+	aspeed,ext-active-high;
+	aspeed,ext-pulse-duration = <256>;
+};
+
+&i2c0 {
+	status = "okay";
+
+	i2c-mux@77 {
+		compatible = "nxp,pca9548";
+		reg = <0x77>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c0mux0ch0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			status = "okay";
+		};
+
+		i2c0mux0ch1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			status = "okay";
+		};
+
+		i2c0mux0ch2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			status = "okay";
+		};
+
+		i2c0mux0ch3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			status = "okay";
+		};
+
+		i2c0mux0ch4: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+			status = "okay";
+		};
+
+		i2c0mux0ch5: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+			status = "okay";
+		};
+
+		i2c0mux0ch6: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+			status = "okay";
+		};
+
+		i2c0mux0ch7: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+			status = "okay";
+		};
+	};
+};
+
+&i2c1 {
+	status = "okay";
+
+	i2c-mux@77 {
+		compatible = "nxp,pca9548";
+		reg = <0x77>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c1mux0ch0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			status = "okay";
+		};
+
+		i2c1mux0ch1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			status = "okay";
+		};
+
+		i2c1mux0ch2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			status = "okay";
+		};
+
+		i2c1mux0ch3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			status = "okay";
+		};
+
+		i2c1mux0ch4: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+			status = "okay";
+		};
+
+		i2c1mux0ch5: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+			status = "okay";
+		};
+
+		i2c1mux0ch6: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+			status = "okay";
+		};
+
+		i2c1mux0ch7: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+			status = "okay";
+		};
+	};
+};
+
+&i2c2 {
+	status = "okay";
+
+	i2c-mux@77 {
+		compatible = "nxp,pca9548";
+		reg = <0x77>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c2mux0ch0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			status = "okay";
+		};
+
+		i2c2mux0ch1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			status = "okay";
+		};
+
+		i2c2mux0ch2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			status = "okay";
+		};
+
+		i2c2mux0ch3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			status = "okay";
+		};
+
+		i2c2mux0ch4: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+			status = "okay";
+		};
+
+		i2c2mux0ch5: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+			status = "okay";
+		};
+
+		i2c2mux0ch6: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+			status = "okay";
+		};
+
+		i2c2mux0ch7: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+			status = "okay";
+		};
+	};
+};
+
+&i2c3 {
+	status = "okay";
+
+	i2c-mux@77 {
+		compatible = "nxp,pca9548";
+		reg = <0x77>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c3mux0ch0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			status = "okay";
+		};
+
+		i2c3mux0ch1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			status = "okay";
+		};
+
+		i2c3mux0ch2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			status = "okay";
+		};
+
+		i2c3mux0ch3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+
+			adc@1f {
+				compatible = "ti,adc128d818";
+				reg = <0x1f>;
+				ti,mode = /bits/ 8 <1>;
+			};
+
+			fan_leds_g1_gpio: gpio@21 {
+				compatible = "nxp,pca9555";
+				reg = <0x21>;
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				gpio-line-names =
+				"", "",
+				"", "",
+				"", "",
+				"", "",
+				"FAN0_PRSNT", "FAN1_PRSNT",
+				"", "",
+				"", "",
+				"", "";
+			};
+
+			adc@35 {
+				compatible = "maxim,max11617";
+				reg = <0x35>;
+			};
+
+			// Fan Board 0 FRU
+			eeprom@56 {
+				compatible = "atmel,24c128";
+				reg = <0x56>;
+			};
+		};
+
+		i2c3mux0ch4: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+
+			adc@1f {
+				compatible = "ti,adc128d818";
+				reg = <0x1f>;
+				ti,mode = /bits/ 8 <1>;
+			};
+
+			fan_leds_g2_gpio: gpio@21 {
+				compatible = "nxp,pca9555";
+				reg = <0x21>;
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				gpio-line-names =
+				"", "",
+				"", "",
+				"", "",
+				"", "",
+				"FAN2_PRSNT", "FAN3_PRSNT",
+				"", "",
+				"", "",
+				"", "";
+			};
+
+			adc@35 {
+				compatible = "maxim,max11617";
+				reg = <0x35>;
+			};
+
+			// Fan Board 1 FRU
+			eeprom@56 {
+				compatible = "atmel,24c128";
+				reg = <0x56>;
+			};
+		};
+
+		i2c3mux0ch5: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+
+			pwm@20 {
+				compatible = "max31790";
+				reg = <0x20>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				channel@2 {
+					reg = <2>;
+					sensor-type = "TACH";
+				};
+				channel@5 {
+					reg = <5>;
+					sensor-type = "TACH";
+				};
+			};
+
+			hwmon: hwmon@23 {
+				compatible = "nuvoton,nct7363";
+				reg = <0x23>;
+				#pwm-cells = <2>;
+
+				//fan 0 IL
+				fan-0 {
+					pwms = <&hwmon 0 20000>;
+					tach-ch = /bits/ 8 <0x09>;
+				};
+
+				//fan 0 OL
+				fan-1 {
+					pwms = <&hwmon 0 20000>;
+					tach-ch = /bits/ 8 <0x0B>;
+				};
+
+				//fan 1 IL
+				fan-2 {
+					pwms = <&hwmon 4 20000>;
+					tach-ch = /bits/ 8 <0x0A>;
+				};
+
+				//fan 1 OL
+				fan-3 {
+					pwms = <&hwmon 4 20000>;
+					tach-ch = /bits/ 8 <0x0D>;
+				};
+
+				//fan 2 IL
+				fan-4 {
+					pwms = <&hwmon 6 20000>;
+					tach-ch = /bits/ 8 <0x0F>;
+				};
+
+				//fan 2 OL
+				fan-5 {
+					pwms = <&hwmon 6 20000>;
+					tach-ch = /bits/ 8 <0x01>;
+				};
+
+				//fan 3 IL
+				fan-6 {
+					pwms = <&hwmon 10 20000>;
+					tach-ch = /bits/ 8 <0x00>;
+				};
+
+				//fan 3 OL
+				fan-7 {
+					pwms = <&hwmon 10 20000>;
+					tach-ch = /bits/ 8 <0x03>;
+				};
+			};
+		};
+
+		i2c3mux0ch6: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+
+			// REAR-IO Board FRU
+			eeprom@56 {
+				compatible = "atmel,24c128";
+				reg = <0x56>;
+			};
+		};
+
+		i2c3mux0ch7: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+			status = "okay";
+		};
+	};
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&i2c5 {
+	status = "okay";
+
+	// VR TEMP U399
+	temperature-sensor@4c {
+		compatible = "ti,tmp75";
+		reg = <0x4c>;
+	};
+
+	// VR TEMP U397
+	temperature-sensor@4d {
+		compatible = "ti,tmp75";
+		reg = <0x4d>;
+	};
+
+	// BRICK TEMP U398
+	temperature-sensor@4e {
+		compatible = "ti,tmp75";
+		reg = <0x4e>;
+	};
+
+	temperature-sensor@4f {
+		compatible = "ti,tmp75";
+		reg = <0x4f>;
+	};
+
+	// RMC FRU
+	eeprom@54 {
+		compatible = "atmel,24c128";
+		reg = <0x54>;
+	};
+};
+
+&i2c6 {
+	status = "okay";
+
+	gpio@20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@21 {
+		compatible = "nxp,pca9555";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@22 {
+		compatible = "nxp,pca9555";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	rtc@51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+	};
+};
+
+&i2c7 {
+	status = "okay";
+	bus-frequency = <100000>;
+	multi-master;
+	i2c-scl-clk-low-timeout-us = <31744>;
+
+	//USB Debug Connector
+	ipmb@10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		i2c-protocol;
+	};
+};
+
+&i2c9 {
+	status = "okay";
+
+	// SCM TEMP SENSOR
+	temperature-sensor@4b {
+		compatible = "ti,tmp75";
+		reg = <0x4b>;
+	};
+
+	// SCM FRU EEPROM
+	eeprom@50 {
+		compatible = "atmel,24c128";
+		reg = <0x50>;
+	};
+
+	// BSM FRU EEPROM
+	eeprom@56 {
+		compatible = "atmel,24c64";
+		reg = <0x56>;
+	};
+};
+
+&i2c10 {
+	status = "okay";
+
+	gpio@10 {
+		compatible = "nxp,pca9555";
+		reg = <0x10>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&sgpiom0>;
+		interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
+
+		gpio-line-names =
+		"IT_STOP_PUMP_SPARE_2", "IT_STOP_PUMP_2",
+		"IT_STOP_PUMP_SPARE", "IT_STOP_PUMP",
+		"", "",
+		"", "",
+		"", "",
+		"", "",
+		"", "",
+		"", "";
+	};
+
+	power-monitor@14 {
+		compatible = "infineon,xdp710";
+		reg = <0x14>;
+	};
+
+	gpio@19 {
+		compatible = "nxp,pca9555";
+		reg = <0x19>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&sgpiom0>;
+		interrupts = <22 IRQ_TYPE_LEVEL_LOW>;
+
+		gpio-line-names =
+		"", "",
+		"", "",
+		"", "",
+		"", "",
+		"wIT_GEAR_RPU_2_LINK_PRSNT_SPARE_N_R", "wIT_GEAR_RPU_2_LINK_PRSNT_N_R",
+		"wIT_GEAR_RPU_LINK_PRSNT_SPARE_N_R", "wIT_GEAR_RPU_LINK_PRSNT_N_R",
+		"", "",
+		"", "";
+	};
+
+	gpio@1a {
+		compatible = "nxp,pca9555";
+		reg = <0x1a>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&sgpiom0>;
+		interrupts = <20 IRQ_TYPE_LEVEL_LOW>;
+
+		gpio-line-names =
+		"wPRSNT_LEAK1_SENSOR_R_PLD_N", "wPRSNT_LEAK0_SENSOR_R_PLD_N",
+		"", "",
+		"", "",
+		"", "",
+		"", "",
+		"", "",
+		"", "",
+		"", "wPRSNT_LEAK2_SENSOR_R_PLD_N";
+	};
+
+	gpio@1b {
+		compatible = "nxp,pca9555";
+		reg = <0x1b>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&sgpiom0>;
+		interrupts = <18 IRQ_TYPE_LEVEL_LOW>;
+
+		gpio-line-names =
+		"", "",
+		"", "",
+		"", "wPRSNT_LEAK4_SENSOR_R_PLD_N",
+		"wPRSNT_LEAK3_SENSOR_R_PLD_N", "",
+		"", "",
+		"", "",
+		"", "",
+		"", "";
+	};
+
+	power-monitor@44 {
+		compatible = "lltc,ltc4286";
+		reg = <0x44>;
+	};
+
+	power-monitor@69 {
+		compatible = "pmbus";
+		reg = <0x69>;
+	};
+};
+
+&i2c14 {
+	status = "okay";
+};
+
+&i2c15 {
+	status = "okay";
+
+	tray_leds_g1_gpio: gpio@20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	tray_leds_g2_gpio: gpio@21 {
+		compatible = "nxp,pca9555";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	tray_leds_g3_gpio: gpio@22 {
+		compatible = "nxp,pca9555";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	tray_leds_g4_gpio: gpio@24 {
+		compatible = "nxp,pca9555";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	tray_leds_g5_gpio: gpio@25 {
+		compatible = "nxp,pca9555";
+		reg = <0x25>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	tray_leds_g6_gpio: gpio@26 {
+		compatible = "nxp,pca9555";
+		reg = <0x26>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	// LED Board FRU
+	eeprom@56 {
+		compatible = "atmel,24c128";
+		reg = <0x56>;
+	};
+};
-- 
2.43.0



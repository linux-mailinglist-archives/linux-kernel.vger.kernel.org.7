Return-Path: <linux-kernel+bounces-747497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 769A7B1347F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881B53B3A8A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 05:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD05253F03;
	Mon, 28 Jul 2025 05:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkEjlZYI"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239B12517A5;
	Mon, 28 Jul 2025 05:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753682206; cv=none; b=OP7KdlfV7yVDgzwATRRAke8l+qPYXl+hVu4hq7uNJ1WUca2ywiDZrKM+3xK5zPa5o4txf9UqhskwJbVUALIqhYOMUrukXgaPmoTDcKgnbxoY+bSBIK3fWNIcShBIOc0welfIEcDtRq+J8to8fcSBipKvLweSnOPDTknzeTlDwbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753682206; c=relaxed/simple;
	bh=TPZgCgjAkax5i2/pB1EewOK8U5/Ji+0ZtO9LqIpr2vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UpCcb0Iu5YDDLayZBYOZByC39F86np2L7HubMozPhanwgCznyu1DIyJgFPKDec5WqPVTZjTtDCeV09+hRyhS0hotPlCKPiv9kXgjvstasnO1Lrxy3Bx4AfbAyN/Mw9FoCSmMAw+ocHy+hFRKt232yWX7t0tkUniaJF7SaZofDXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UkEjlZYI; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23ffa7b3b30so8704495ad.1;
        Sun, 27 Jul 2025 22:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753682204; x=1754287004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+hROFZIJ4zafnbkZoU/ntEvBJYn2g7xzj4eJTsFhmI=;
        b=UkEjlZYIG15+mXH4rHlq7aijfZvgZW2aG6mtvq4hmQtbN0hnnlD8MTrdgBeADBdq3S
         uqS77zZirNQZNWxF3USSnH3LUDDXxKDwEsXp19Ra4BMHM7c/WaJKD7ncucM1xv2SwT80
         moYceNNsYCVrXZD6zRON5g/AdJ2oMU2Bu9Be+oZYhFFFiKZ8JdmodDyVdU78NVyiJbKr
         HTtf8MgyvOsYeU71yPzCTLzgeu44vaIVjuHbl0/4PlcH4htshlT76ZIIe3Bu55bJeEGV
         QkkjmMoorn8u8vTcBqGCVd7nZswPd6SFRvop7xOUi0PYMNEhORL8MyA6MSliymeI+fze
         zw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753682204; x=1754287004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+hROFZIJ4zafnbkZoU/ntEvBJYn2g7xzj4eJTsFhmI=;
        b=WOIi3ivuJBqJ2drwtCVMUEzUldbfehrUBbo92TB06LlPRYiUh6wNi/cACUkUm0DhvX
         8a/Sx0XCfHUrb0OGGO/VwU4PG5BTjoeozcSxV/LuobO7fa53RJZcc0OKjsIPI30KTXt4
         wuK2HXeJGSl4gmVyoXeiYbwidSnImluhi337D6maTE1QLN4mvw7M9MGUzA8q0OEXbKc5
         RgFylcfl+H/hx6LHY3nlYVjotTShZoAGFJwsxNcWDUWlCULP3t7RfdK3iUhX5oYHKFhn
         PKcvmCZGhYhIqqFD+6HFbHZmID4hL1z4nU6eDeMSSv2jK513+F7MRU/Wjj1q71gWo1X/
         RFzA==
X-Forwarded-Encrypted: i=1; AJvYcCV3QDPLCysSuxb6kUwRm/ng738EMe8Gh1IO9TDFK3T6E+46I4rIAk1Nabg2O6Ml01IEXgkbup11Klzl7Vmp@vger.kernel.org, AJvYcCWBvaShilqJzLbhFPI7iI44LpgsQ1nlwcSf2f1dDm8X1NL1dUbjOZCCq0YPVKJLBywSq5gkJq1Hml1A@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoo5SX639To5cKdezS9tv0MUHs6NqSKK7aUdxiyeTr1r/akrIL
	1vEVdKSKlAq9rZJoi2K3BJX5kr99c07q68vHl7KavZlVe+wD6Oyvgq8m
X-Gm-Gg: ASbGncsuDOgRmooDqPiclbDZyKFdluxr11yzMYkR6o+z7MpiUQNYp6SQ9PNvahaN2Kw
	1hVY1Zt3bikaIk8uIGBd4+zwv/px6wM5iI9jEG7Iie9BinyD3cnt5vIwm5rkbYiHoaTa/hhrmBD
	kkfORRwhRdhh75Jti8f4oVz08tBu/onIij4lvhHCTdRS0lyiSCecUu2WUC7lrQTOG3OtOoq4jYg
	MKUj7F1pEOXLTJk+j3f2vF3mcjC9/XbUyq+RMyyeKVKLYwCX1TNVKWNzsvS7a5Iknewq5W0bdwv
	LiEWlhsrI8FBclM/KhxwNVNFD/bYhsQgScqLWRcYmeGVve5Zs03WWJQ6VqruxfO4ddrWc4B4fbX
	GowtzIzw4qmr7iLpFFieoQOKVrj7vEK5UK+qqkZ8uaD3oH9SVOOAy/1WNXcS5NApAWYhr0EFueZ
	c=
X-Google-Smtp-Source: AGHT+IESYMV9/aCSq8+ZkMIq1xghfGxILNOdIuRhEeldG3+nYfcr3Y2QDDogE793q0IX8dW9AYzfjA==
X-Received: by 2002:a17:902:c409:b0:234:f4da:7eeb with SMTP id d9443c01a7336-23fb3051350mr152238685ad.7.1753682204352;
        Sun, 27 Jul 2025 22:56:44 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe514b59sm45091795ad.128.2025.07.27.22.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 22:56:43 -0700 (PDT)
From: rentao.bupt@gmail.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Tao Ren <taoren@meta.com>
Cc: Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v4 13/13] ARM: dts: aspeed: Add Facebook Darwin (AST2600) BMC
Date: Sun, 27 Jul 2025 22:56:15 -0700
Message-ID: <20250728055618.61616-14-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250728055618.61616-1-rentao.bupt@gmail.com>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Ren <rentao.bupt@gmail.com>

Add initial device tree for the Meta (Facebook) Darwin AST2600 BMC.

Darwin is Meta's rack switch platform with an AST2600 BMC integrated for
health monitoring purpose.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v4:
  - None.
Changes in v3:
  - Removed flash layout (use the "default" in common.dtsi).
Changes in v2:
  - Removed mac3 controller.
  - Fixed DTB warnings.

 arch/arm/boot/dts/aspeed/Makefile             |  1 +
 .../dts/aspeed/aspeed-bmc-facebook-darwin.dts | 72 +++++++++++++++++++
 2 files changed, 73 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dts

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index f6e714b7db2d..dce32ee0ace7 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -20,6 +20,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-facebook-bletchley.dtb \
 	aspeed-bmc-facebook-catalina.dtb \
 	aspeed-bmc-facebook-cmm.dtb \
+	aspeed-bmc-facebook-darwin.dtb \
 	aspeed-bmc-facebook-elbert.dtb \
 	aspeed-bmc-facebook-fuji-data64.dtb \
 	aspeed-bmc-facebook-fuji.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dts
new file mode 100644
index 000000000000..58c107a1b6cf
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dts
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2021 Facebook Inc.
+
+/dts-v1/;
+
+#include "ast2600-facebook-netbmc-common.dtsi"
+
+/ {
+	model = "Facebook Darwin BMC";
+	compatible = "facebook,darwin-bmc", "aspeed,ast2600";
+
+	aliases {
+		serial0 = &uart5;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+	};
+
+	chosen {
+		stdout-path = &uart5;
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
+			      <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
+			      <&adc1 0>, <&adc1 1>, <&adc1 2>, <&adc1 3>,
+			      <&adc1 4>, <&adc1 5>, <&adc1 6>, <&adc1 7>;
+	};
+
+	spi_gpio: spi {
+		num-chipselects = <1>;
+		cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
+	};
+};
+
+&i2c0 {
+	eeprom@50 {
+		compatible = "atmel,24c512";
+		reg = <0x50>;
+	};
+};
+
+&adc0 {
+	status = "okay";
+
+	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
+		     &pinctrl_adc2_default &pinctrl_adc3_default
+		     &pinctrl_adc4_default &pinctrl_adc5_default
+		     &pinctrl_adc6_default &pinctrl_adc7_default>;
+};
+
+&adc1 {
+	status = "okay";
+
+	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default
+		     &pinctrl_adc10_default &pinctrl_adc11_default
+		     &pinctrl_adc12_default &pinctrl_adc13_default
+		     &pinctrl_adc14_default &pinctrl_adc15_default>;
+};
+
+&emmc_controller {
+	status = "okay";
+};
+
+&emmc {
+	status = "okay";
+
+	non-removable;
+	max-frequency = <25000000>;
+	bus-width = <4>;
+};
-- 
2.47.3



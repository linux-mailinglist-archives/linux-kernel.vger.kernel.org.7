Return-Path: <linux-kernel+bounces-747492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 172A8B13475
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B74F317750B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 05:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6E423958F;
	Mon, 28 Jul 2025 05:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JihDJI9L"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07D523817E;
	Mon, 28 Jul 2025 05:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753682199; cv=none; b=Qwz8bAsK/fGVRZw1kogqin6HDRG8XSiTjC7Eje9qLCqPrU1JXb4jIMIaMvvRDBMgWtOgnq2vHow8Q6hvW0QJq6GW0kIT3i49JY8Lc7NMJFIrmWN4WtS9WlDRvcwhncOvsiLrka7lqEAzQM1lLyBg+Kozax9Di6ZMBDfSm3poG7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753682199; c=relaxed/simple;
	bh=J56QAK9nNNJ3pkJIznBWmk1bAJJPT1sW30A8Y7S+G3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FEU7zZulswPv6CSLzSKK07vwYb/85RVMpS8gDSqwC45dZ1GARNOjExu62Si4wjEZlVl1xvW0V83G+ZtY0nhgWWm55oHJ1bU24oBXBlJiHNY6iUqc5NQ0yacVvHaQjKYRenwHSet6ruwfdtF2CDZJmNqq46GCOkOQQOit9mofmlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JihDJI9L; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24014cd385bso9542885ad.0;
        Sun, 27 Jul 2025 22:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753682196; x=1754286996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hts95YB/ZjUXh8JubeUkj5tnYbtjKOGgkAFrza9S0yg=;
        b=JihDJI9L98xNMotw4wWYMiMWhCNOv4WMjBdU6zXP9r6g0+agDWsoitTYRP8ThBrtBX
         VshPVUfx/BZHs2sJk8zSE454FKG/BfoXyd1u+tzZjGEap8/SY5gFrBTgxwlRgjHqWAqI
         sSszz9O8Ho7a2B6gT2OSwdkKfCtCUTF7H/f1iBfNAfsESZoXXMwYhs/w24p+URR07rje
         y1N0enYGuJ4bHnXegnCht4c8vYZhRPbj9EoFaJWWF+q/y4/QsHqAuehRyO0dQv9EUaBm
         FfzmbidzUwU/DOwQmFwdnH+9i1Vhifx/GWLd79oqQQXiZxSqzSBHRLjRW57D/4HL3TRe
         0DMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753682196; x=1754286996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hts95YB/ZjUXh8JubeUkj5tnYbtjKOGgkAFrza9S0yg=;
        b=X19IHUYNjN0snWhf+HCxi1J/jOkajBeE5z8QZPcdPbkwszkUUEZ/gR5UJyT4rFq+Kv
         a4A17JX+r20m/J/dIBJI+ilOaXrkOiMWVy8yTEfo4dh3BZO0/PV7uQDGvR4zj308riIb
         8JQekzCBgmWHg8dZwShkEBvHqiiTqmd4/GIyBJTENk2LPiVoKU9IHodGLtD1quFh42ax
         rXEml54LmjsBlich/OKbkSvkO9RfJEHcsRKMqRSVqjfRD5D5PClI65kdBs4M8NTJk36H
         uXBk51jEtXiYr6GbxB/hLRxLYJZFb/OdM5LPR1YWQDRs3WxLDNu7OYqFH8d0F/cePail
         yfaA==
X-Forwarded-Encrypted: i=1; AJvYcCUDMbHfIAn8fo7RImfHke+6m4thPEdWjfKCj130U/d2GjYrPdE/dN0cIr8z9oWP93b+4SJ/WN2l6BNc@vger.kernel.org, AJvYcCWryqWlFxMTeSLFudeaxEMQ/HK0FQrVTGXWq+vL1OFCRsWGCYUHpDNLHzShfdAxyJDX8TeeD5NZG2Szqj8d@vger.kernel.org
X-Gm-Message-State: AOJu0YxM+dbkOa+DkheNkfQ4raPelXVasiykU8opN/Ogq8t5LHU3M/jx
	C01pQnFirZgvNzhb6MRRUwT92caYSz04ChRAcaQcCrTao4nyF7tc2ibP
X-Gm-Gg: ASbGncuMRYuGSJeP6uI2APRqN3mt4wPBZ9kNywuXyRKwy+KWubMYkuVLtjk2yD8bk2F
	wS8KHBTdGs2lcqdcCe6Gt01vrzBLujViGvqJ4z6uHNZedoeGXDtibg4kA3I3LkronzFGU4GJYE/
	N8TUM3NGCucdA1z/kL/nX+PSBhuTVGUVLX4DlJ0BxIEBTy04yvkhlNoHigjPjZLcJhsNhbMavaO
	5ZjIyXre9MWFEnrvmDtZbi+GbouoXXyjEAQ3hk5bUrdmeMM2hZvRY/8DcTYvOb3gg7BS4W1NtlP
	eCi+czzdT9vw2jZuaB77nksnIwaqXhTcz0jNitxeoxB3x4RylWHF4Qfovl+LOgYXsqsz47ASfXQ
	yg74VDd8wFjoo6VdPR5RUy1KACrX83Qqc6Op9c2g18LstKNkjThQai0GxQLX42PvbmWXpgn6mbj
	Uh7sUhgJmeeA==
X-Google-Smtp-Source: AGHT+IFP3tnIg6vILNX/jRsWfTC+IcuFHWpZZn8f55XY/hi2+oG+I/rcgv+3s7XDjIJi+OO27u1y4A==
X-Received: by 2002:a17:903:1a45:b0:235:f18f:2924 with SMTP id d9443c01a7336-23fb30caa26mr157779795ad.15.1753682195966;
        Sun, 27 Jul 2025 22:56:35 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe514b59sm45091795ad.128.2025.07.27.22.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 22:56:35 -0700 (PDT)
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
Subject: [PATCH v4 08/13] ARM: dts: aspeed: wedge400: Include wedge400-data64.dts
Date: Sun, 27 Jul 2025 22:56:10 -0700
Message-ID: <20250728055618.61616-9-rentao.bupt@gmail.com>
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

Include "wedge400-data64.dts" in wedge400 dts to avoid duplicated code.

Wedge400-data64 and Wedge400 are identical except the BMC flash layout.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v4:
  - None.
Changes in v3:
  - None (the patch is introduced in v3).

 .../aspeed/aspeed-bmc-facebook-wedge400.dts   | 366 +-----------------
 1 file changed, 2 insertions(+), 364 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
index 3e4d30f0884d..ef0cfc51cda4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
@@ -1,376 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0+
 // Copyright (c) 2019 Facebook Inc.
-/dts-v1/;
 
-#include <dt-bindings/gpio/aspeed-gpio.h>
-#include "ast2500-facebook-netbmc-common.dtsi"
+#include "aspeed-bmc-facebook-wedge400-data64.dts"
 
 / {
 	model = "Facebook Wedge 400 BMC";
 	compatible = "facebook,wedge400-bmc", "aspeed,ast2500";
-
-	aliases {
-		/*
-		 * PCA9548 (2-0070) provides 8 channels connecting to
-		 * SCM (System Controller Module).
-		 */
-		i2c16 = &imux16;
-		i2c17 = &imux17;
-		i2c18 = &imux18;
-		i2c19 = &imux19;
-		i2c20 = &imux20;
-		i2c21 = &imux21;
-		i2c22 = &imux22;
-		i2c23 = &imux23;
-
-		/*
-		 * PCA9548 (8-0070) provides 8 channels connecting to
-		 * SMB (Switch Main Board).
-		 */
-		i2c24 = &imux24;
-		i2c25 = &imux25;
-		i2c26 = &imux26;
-		i2c27 = &imux27;
-		i2c28 = &imux28;
-		i2c29 = &imux29;
-		i2c30 = &imux30;
-		i2c31 = &imux31;
-
-		/*
-		 * PCA9548 (11-0076) provides 8 channels connecting to
-		 * FCM (Fan Controller Module).
-		 */
-		i2c32 = &imux32;
-		i2c33 = &imux33;
-		i2c34 = &imux34;
-		i2c35 = &imux35;
-		i2c36 = &imux36;
-		i2c37 = &imux37;
-		i2c38 = &imux38;
-		i2c39 = &imux39;
-
-		spi2 = &spi_gpio;
-	};
-
-	chosen {
-		stdout-path = &uart1;
-		bootargs = "console=ttyS0,9600n8 root=/dev/ram rw";
-	};
-
-	ast-adc-hwmon {
-		compatible = "iio-hwmon";
-		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>, <&adc 4>,
-			      <&adc 5>, <&adc 6>, <&adc 7>, <&adc 8>;
-	};
-
-	/*
-	 * GPIO-based SPI Master is required to access SPI TPM, because
-	 * full-duplex SPI transactions are not supported by ASPEED SPI
-	 * Controllers.
-	 */
-	spi_gpio: spi {
-		status = "okay";
-		compatible = "spi-gpio";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cs-gpios = <&gpio ASPEED_GPIO(R, 2) GPIO_ACTIVE_LOW>;
-		sck-gpios = <&gpio ASPEED_GPIO(R, 3) GPIO_ACTIVE_HIGH>;
-		mosi-gpios = <&gpio ASPEED_GPIO(R, 4) GPIO_ACTIVE_HIGH>;
-		miso-gpios = <&gpio ASPEED_GPIO(R, 5) GPIO_ACTIVE_HIGH>;
-		num-chipselects = <1>;
-
-		tpm@0 {
-			compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
-			spi-max-frequency = <33000000>;
-			reg = <0>;
-		};
-	};
 };
 
-/*
- * Both firmware flashes are 128MB on Wedge400 BMC.
- */
 &fmc_flash0 {
+	/delete-node/partitions;
 #include "facebook-bmc-flash-layout-128.dtsi"
 };
-
-&fmc_flash1 {
-	partitions {
-		compatible = "fixed-partitions";
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		flash1@0 {
-			reg = <0x0 0x8000000>;
-			label = "flash1";
-		};
-	};
-};
-
-&uart2 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_txd2_default
-		     &pinctrl_rxd2_default>;
-};
-
-&uart4 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_txd4_default
-		     &pinctrl_rxd4_default>;
-};
-
-/*
- * I2C bus #0 is multi-master environment dedicated for BMC and Bridge IC
- * communication.
- */
-&i2c0 {
-	status = "okay";
-	multi-master;
-	bus-frequency = <1000000>;
-};
-
-&i2c1 {
-	status = "okay";
-};
-
-&i2c2 {
-	status = "okay";
-
-	i2c-mux@70 {
-		compatible = "nxp,pca9548";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x70>;
-		i2c-mux-idle-disconnect;
-
-		imux16: i2c@0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0>;
-		};
-
-		imux17: i2c@1 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <1>;
-		};
-
-		imux18: i2c@2 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <2>;
-		};
-
-		imux19: i2c@3 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <3>;
-		};
-
-		imux20: i2c@4 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <4>;
-		};
-
-		imux21: i2c@5 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <5>;
-		};
-
-		imux22: i2c@6 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <6>;
-		};
-
-		imux23: i2c@7 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <7>;
-		};
-	};
-};
-
-&i2c3 {
-	status = "okay";
-};
-
-&i2c4 {
-	status = "okay";
-};
-
-&i2c5 {
-	status = "okay";
-};
-
-&i2c6 {
-	status = "okay";
-};
-
-&i2c7 {
-	status = "okay";
-};
-
-&i2c8 {
-	status = "okay";
-
-	i2c-mux@70 {
-		compatible = "nxp,pca9548";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x70>;
-		i2c-mux-idle-disconnect;
-
-		imux24: i2c@0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0>;
-		};
-
-		imux25: i2c@1 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <1>;
-		};
-
-		imux26: i2c@2 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <2>;
-		};
-
-		imux27: i2c@3 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <3>;
-		};
-
-		imux28: i2c@4 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <4>;
-		};
-
-		imux29: i2c@5 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <5>;
-		};
-
-		imux30: i2c@6 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <6>;
-		};
-
-		imux31: i2c@7 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <7>;
-		};
-
-	};
-};
-
-&i2c9 {
-	status = "okay";
-};
-
-&i2c10 {
-	status = "okay";
-};
-
-&i2c11 {
-	status = "okay";
-
-	i2c-mux@76 {
-		compatible = "nxp,pca9548";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x76>;
-		i2c-mux-idle-disconnect;
-
-		imux32: i2c@0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0>;
-		};
-
-		imux33: i2c@1 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <1>;
-		};
-
-		imux34: i2c@2 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <2>;
-		};
-
-		imux35: i2c@3 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <3>;
-		};
-
-		imux36: i2c@4 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <4>;
-		};
-
-		imux37: i2c@5 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <5>;
-		};
-
-		imux38: i2c@6 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <6>;
-		};
-
-		imux39: i2c@7 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <7>;
-		};
-
-	};
-};
-
-&i2c12 {
-	status = "okay";
-};
-
-&i2c13 {
-	status = "okay";
-};
-
-&adc {
-	status = "okay";
-};
-
-&ehci1 {
-	status = "okay";
-};
-
-&uhci {
-	status = "okay";
-};
-
-&sdhci1 {
-	max-frequency = <25000000>;
-	/*
-	 * DMA mode needs to be disabled to avoid conflicts with UHCI
-	 * Controller in AST2500 SoC.
-	 */
-	sdhci-caps-mask = <0x0 0x580000>;
-};
-- 
2.47.3



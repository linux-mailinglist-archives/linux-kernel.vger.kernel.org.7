Return-Path: <linux-kernel+bounces-743359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37968B0FDA7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 01:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 596D05872AB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 23:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AE52750F9;
	Wed, 23 Jul 2025 23:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqPVpPql"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE00A2737E4;
	Wed, 23 Jul 2025 23:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753313435; cv=none; b=m0WxtAoQhAI16/MXPMbdc5O+63xM94SNudscbsrRjAe1eENQ1fLnmLJ2PJC9DzldQdgSvGRvQ9lJdg20+JB8L8qfa2PF8raM54GeSKglgxgjgDaVGYPujXKwt7Xnx7f8wKxJmlgAmpoujitgtxfdiOHYNylKjeqe2ieoX0nW08Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753313435; c=relaxed/simple;
	bh=TeYkv00okkGxdP75jxZRjFS4vluTqdtlks31E4jLwGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8SaB5SOmdLBAHyvyPp/g7Rrk/LGbNyx/xJMdql9v2g4p8jxO5A+JM0Hq7Ol4YSgZ6CqyIHs0nMcAiiJWhlkAYOlv++OM7RLDPaS+68BlaMnPebj0RxMRd3g7PWBvyI4iFlDYbUlUqRLvuaEexIfcMdIal/lEXkoc7gCnjK4l0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqPVpPql; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-234fcadde3eso4728765ad.0;
        Wed, 23 Jul 2025 16:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753313433; x=1753918233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpuI4weQQaay/ttiq5NTjlywcepu4aZ90xK0F7mRywY=;
        b=PqPVpPqlRP3vpOzv/HQSodqzDdkYv6aXFYThjmDWtLKXFZneU7GJk6FfIviJ14nui0
         wvc9qchuHSdFTpyNbOuXVF8hnRGJqSqxW3YMc1jO2ONi4HXCssAHZ6D8P3qvrVPIy8Sh
         jfyCB2DTR4m8iMd3jTiNeoZMKXPP8EW3/2amZxiNEsFbz26xmUr6I3Wg1B4vX9L0x/nh
         OBEhCAMKFvaEWffEhALmCNahFkOuBFGRccKeR/RCZytQ5WjW//JFi7nrn8tFAXh2jRbv
         OAqTPJCLjeBcE3kWRIn4WEHYruTYlRvzk5y4O2wyucswczQJPu9A0dYAzlZANakYTLC9
         6HaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753313433; x=1753918233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpuI4weQQaay/ttiq5NTjlywcepu4aZ90xK0F7mRywY=;
        b=vS6XBV6XOYhqfV/fKJkItJNdP6pGTilKRyIukeGXkzQNm/jIkP4uNzpGbEynpqEOmD
         CYyVAuXRI7ja0BBDk1D5uiPiQZlKqKJYB8HYzobTeKTbs498VLIjjWAiNCgkSW3DE0xc
         XlI+zuE5agNj7QblC3MFU6ium0i7shIe9QhDqpQrrVSagTDVj0TYaowl3RhUHbgfk4gR
         UkHPuuTvsyLlSvzfptau3MDdCnPEHEYZcy3lEzVmdE/0drgJQq3qLHI0SjYfy8MFiy4j
         UurOcOsPWo8lw9Qk/icLhTWhJIT6g+LdbajZ69mwI9JV5mVjuXWF6zxmcITrb7KEtSe0
         nxrw==
X-Forwarded-Encrypted: i=1; AJvYcCWrSQNikGRXVyaOCAZLjK1X0i+gq/U2hy6mAIgIr2LwVVYFnFTMVWQBGx/jCgcmRhcxDG7LNP4IDPLMtAz4@vger.kernel.org, AJvYcCXEjcEBaZUJ2asCYVPv4pu1p43GYhtLDEm5iOtIJomydnQeRB9iDZdeZwjTSCdCsPW/oSJZDEVZq72N@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuqn2W8Zfu+/G1OCUx7asY8BoB6GuyFAA5WxBvnK56TIR19ahd
	tWFPGx1wi5tnD94nnWnh5bXRVlE4VR7ba9LGloimPWea6wNCAncWJUpc
X-Gm-Gg: ASbGncuY8C9widHXExef4B6R+6WBeCyJc8Ufp3dacjFjzhxySxf1b2nmIErn65xxTDS
	IuNJ8a7MDr8OnQUHkBnPpLgpoHNXCamPysr3vDir4wQy9Y+9TKlRu+9z95H1NTrBcvKmIYpgv6Y
	1E+Od6QnHIplqMr3G+j6ZKFfHHzZLRRPupPRms6gqeHoOmTtKoVM23urLjP1asYcEzA9uWi8OFm
	LNvewBdOLjoxzU0MY4bKzlRKEYUX5dDz5q26uJkuFnXxTdEc2NTrkM8wuqMQJIE4oIfu2IK7olm
	NvHdSd0xL2uCoeMggNWQDS/1DSTB/PQqSAem/abLOZwRLL6D8Vgb39/0LYPqaUnFvK6OBWwOoTo
	pMgom9y7YrEKpJiA7BBsgofou1tPGH76W11F7VomfspDaySBrTgnTt5V/BrKc8fSHiKCZ3AS5eb
	s=
X-Google-Smtp-Source: AGHT+IHuSACp56R7JFjqqbbVOFl8naZeaEXMeCAJrwdR3oTcvhmsICZkUtW81MHhki1qJ/awwU9oug==
X-Received: by 2002:a17:903:198c:b0:234:d292:be83 with SMTP id d9443c01a7336-23f9812b3ddmr68861005ad.10.1753313433180;
        Wed, 23 Jul 2025 16:30:33 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bc6fbsm1260765ad.120.2025.07.23.16.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 16:30:32 -0700 (PDT)
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
Subject: [PATCH v3 08/13] ARM: dts: aspeed: wedge400: Include wedge400-data64.dts
Date: Wed, 23 Jul 2025 16:30:04 -0700
Message-ID: <20250723233013.142337-9-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250723233013.142337-1-rentao.bupt@gmail.com>
References: <20250723233013.142337-1-rentao.bupt@gmail.com>
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



Return-Path: <linux-kernel+bounces-747491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCD9B13472
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6ED918974A8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 05:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E95237163;
	Mon, 28 Jul 2025 05:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZhPY3Or"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED78D2343C9;
	Mon, 28 Jul 2025 05:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753682196; cv=none; b=ax4klSeoP5XkkfenONwRXkLYst5DNfSuUAqsOgBv9ul8CesoGuzQxcwxTwTNyVVVUtyDGan/Hq3sX02kWN+KwGcwE9bU1WLUB9aOT4LEVQE70Na7JmfXB6mbDzBHPnMnCUTALGkqE+SNG1Hz3pjiAe8r7bf+7PmXrglE9QxAeGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753682196; c=relaxed/simple;
	bh=6g2gUeEMhzpEF5QOq8+CLqpQFVqMrqoOjiFyA35VkYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHi/Oqt4Ko6a+snyo3aOKCS9UXU0SS5ZBYdS1+3DA63qFx7urH+m5Kzf8xzySjPeu1eB/qvqxKJzasZg1Gn4upkH7UFAywu7TiMHZNheapAZQkVV1+3NmHyHV8lFRBaZ4lAb4NvysGkTx7aGeZKFts57XVZWbac8xLG1vIXymXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZhPY3Or; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2403ca0313aso3194715ad.0;
        Sun, 27 Jul 2025 22:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753682194; x=1754286994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/YAuK9Y0oHVDDTSHah83w1CX27+EsYJX9fr2DChXv0=;
        b=QZhPY3OrSAoNmkBtg8lJv2tR5OrxBe6srnjgwInIKqpKd9Zm6ge+8Dkd+tXrlhwItp
         dbTKARe5hzKbnjJq1gos8IOeidq2wy3fUOQDNikyQ35gkOI+AHPse5/YBO7xffyvfmzY
         n/jCtuR84soW95/FawoQpAyi0OvvfFxx4ZrSmQ8fRhZN7fXffqICI1kNgmIrOX3M9FQJ
         0DtCMAlagt286W4JLJePQceJM2WAOtct2k4JUMZliNla2Gd0oJ2YvGfU4Muu73v6c+WZ
         aVsoFjqJUKOEqEqW+v9VMDfiXK5bNJfnfimVp5BhWMeUjHhX9TQIgYfTlHlgoZviV9x5
         0vow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753682194; x=1754286994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/YAuK9Y0oHVDDTSHah83w1CX27+EsYJX9fr2DChXv0=;
        b=Ntfpfvo/Tt1kT/9dEESap2Igdn2A2or/ZmZWeuB8k2kYXR99msOR54tz3wsC3yf/xO
         VD5be1pyrLDSI45189PSt3RoSKGpNiOaHOhpqSXJSOBa6d3kM7UVQei19u8EADSsy3jx
         gOYak+IYBCACnYr579UHr/z7A+GAGnalBU7buDGsbSl0aLpM2LYQTVi+sUcpTdFO50E8
         0LiiC6fjzJqzt/c5Noyo1AJv1vIye4aLITrREnOBnXMa4k+WCwmUrMhSdFLRfOcJRQiR
         ZABf4hRxWAs9oda4g6kOttL1Fkwtvwnf09KOLy8oXhxk//J2tsHdD/hOWEqGpxqNXYTf
         G0Sw==
X-Forwarded-Encrypted: i=1; AJvYcCUZc7DuKw+XkfqYhJBcr0PiMzlsUa3dp0cxtZB38em5IvR+2nPnOxRzHSPmSc6ngxiH/UxorPhmG6faXGl3@vger.kernel.org, AJvYcCWSYZNzT0hiENLZs+OV4IzMxb9lHiErSj/OLuENuUyaJ49BIa/wvyAmWu9gi9cBBxMEg0SnoRlIa8Dy@vger.kernel.org
X-Gm-Message-State: AOJu0Yw51PXQzjjtybekwrIugL2aTdzzkpAaWg7gPFQYjj7kBEfs1OMC
	KAv4Nj36gPeHjfBY78RtaVl9jK7FhBcvAqHCHsiZ4JzBXMJPU+gtMXWp
X-Gm-Gg: ASbGnct7hBBfbkTeEZanr+EwlyqJT9862cKdfd3PUt24IstfVsbR61gSQQo9kaomVCw
	aOsdVyTP+CNLazOWbNgEPWmd1gj3qF7INkCUwzZqklsZjiDz5pO6tUilRMGEPBQsE16Eprji7xU
	XBU1WNH1PeODJB9Bhp0vQS+jfvp8hvCMjDoi28QnD4JGVAmaf4S/Bge797kp0PmwNpWj2HSIrDi
	DmmnuLa7LelQPuB69KIYckSoiDMOrY0UotdckTV2hc2vpt4A/WHhL/dGDCmRzORLMI7cQrGzXej
	JoYh5n/SEAGXWnXZG9DgMDHpWlwzcJI7yXfwtDcfQd985wUO5XtuovmO0EhhsBWWHhoPVCiVgkq
	mAUJqbEt0T/SsOyv/DQZE4j+vBuLHwHErNgVZABAhr/6iRpyjjNQ/uNgNyUMCZ0hQNfbhHxcPWs
	4TRU6l4zYtYg==
X-Google-Smtp-Source: AGHT+IGckpl416r7tKZtEvLi84N6rVIZtXh8LmHNCYPgTxJOPIcTlDmrV6zCnV/8M+iaGU2K9uCPpA==
X-Received: by 2002:a17:902:d414:b0:23f:df36:5f17 with SMTP id d9443c01a7336-23fdf3662b3mr66552915ad.22.1753682194123;
        Sun, 27 Jul 2025 22:56:34 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe514b59sm45091795ad.128.2025.07.27.22.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 22:56:33 -0700 (PDT)
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
Subject: [PATCH v4 07/13] ARM: dts: aspeed: Add Facebook Wedge400-data64 (AST2500) BMC
Date: Sun, 27 Jul 2025 22:56:09 -0700
Message-ID: <20250728055618.61616-8-rentao.bupt@gmail.com>
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

Add wedge400-data64.dts to extend wedge400's data0 partition from 8MB to
64MB smoothly.

wedge400-data64.dts is copied from wedge400.dts with below changes:
  - updating model/compatible strings.
  - updating flash0 partition.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v4:
  - Removed redundant bootargs from dts.
Changes in v3:
  - None (the patch is introduced in v3).

 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed-bmc-facebook-wedge400-data64.dts   | 375 ++++++++++++++++++
 2 files changed, 376 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400-data64.dts

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index 2e5f4833a073..55be25acfc80 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -30,6 +30,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-facebook-tiogapass.dtb \
 	aspeed-bmc-facebook-wedge40.dtb \
 	aspeed-bmc-facebook-wedge100.dtb \
+	aspeed-bmc-facebook-wedge400-data64.dtb \
 	aspeed-bmc-facebook-wedge400.dtb \
 	aspeed-bmc-facebook-yamp.dtb \
 	aspeed-bmc-facebook-yosemitev2.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400-data64.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400-data64.dts
new file mode 100644
index 000000000000..1d46eaee8656
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400-data64.dts
@@ -0,0 +1,375 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2019 Facebook Inc.
+/dts-v1/;
+
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include "ast2500-facebook-netbmc-common.dtsi"
+
+/ {
+	model = "Facebook Wedge 400 BMC (64MB Datastore)";
+	compatible = "facebook,wedge400-data64-bmc", "aspeed,ast2500";
+
+	aliases {
+		/*
+		 * PCA9548 (2-0070) provides 8 channels connecting to
+		 * SCM (System Controller Module).
+		 */
+		i2c16 = &imux16;
+		i2c17 = &imux17;
+		i2c18 = &imux18;
+		i2c19 = &imux19;
+		i2c20 = &imux20;
+		i2c21 = &imux21;
+		i2c22 = &imux22;
+		i2c23 = &imux23;
+
+		/*
+		 * PCA9548 (8-0070) provides 8 channels connecting to
+		 * SMB (Switch Main Board).
+		 */
+		i2c24 = &imux24;
+		i2c25 = &imux25;
+		i2c26 = &imux26;
+		i2c27 = &imux27;
+		i2c28 = &imux28;
+		i2c29 = &imux29;
+		i2c30 = &imux30;
+		i2c31 = &imux31;
+
+		/*
+		 * PCA9548 (11-0076) provides 8 channels connecting to
+		 * FCM (Fan Controller Module).
+		 */
+		i2c32 = &imux32;
+		i2c33 = &imux33;
+		i2c34 = &imux34;
+		i2c35 = &imux35;
+		i2c36 = &imux36;
+		i2c37 = &imux37;
+		i2c38 = &imux38;
+		i2c39 = &imux39;
+
+		spi2 = &spi_gpio;
+	};
+
+	chosen {
+		stdout-path = &uart1;
+	};
+
+	ast-adc-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>, <&adc 4>,
+			      <&adc 5>, <&adc 6>, <&adc 7>, <&adc 8>;
+	};
+
+	/*
+	 * GPIO-based SPI Master is required to access SPI TPM, because
+	 * full-duplex SPI transactions are not supported by ASPEED SPI
+	 * Controllers.
+	 */
+	spi_gpio: spi {
+		status = "okay";
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cs-gpios = <&gpio ASPEED_GPIO(R, 2) GPIO_ACTIVE_LOW>;
+		sck-gpios = <&gpio ASPEED_GPIO(R, 3) GPIO_ACTIVE_HIGH>;
+		mosi-gpios = <&gpio ASPEED_GPIO(R, 4) GPIO_ACTIVE_HIGH>;
+		miso-gpios = <&gpio ASPEED_GPIO(R, 5) GPIO_ACTIVE_HIGH>;
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
+/*
+ * Both firmware flashes are 128MB on Wedge400 BMC.
+ */
+&fmc_flash0 {
+#include "facebook-bmc-flash-layout-128-data64.dtsi"
+};
+
+&fmc_flash1 {
+	partitions {
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		flash1@0 {
+			reg = <0x0 0x8000000>;
+			label = "flash1";
+		};
+	};
+};
+
+&uart2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd2_default
+		     &pinctrl_rxd2_default>;
+};
+
+&uart4 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd4_default
+		     &pinctrl_rxd4_default>;
+};
+
+/*
+ * I2C bus #0 is multi-master environment dedicated for BMC and Bridge IC
+ * communication.
+ */
+&i2c0 {
+	status = "okay";
+	multi-master;
+	bus-frequency = <1000000>;
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x70>;
+		i2c-mux-idle-disconnect;
+
+		imux16: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		imux17: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		imux18: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		imux19: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+
+		imux20: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+
+		imux21: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		imux22: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		imux23: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+	};
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&i2c5 {
+	status = "okay";
+};
+
+&i2c6 {
+	status = "okay";
+};
+
+&i2c7 {
+	status = "okay";
+};
+
+&i2c8 {
+	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x70>;
+		i2c-mux-idle-disconnect;
+
+		imux24: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		imux25: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		imux26: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		imux27: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+
+		imux28: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+
+		imux29: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		imux30: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		imux31: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+
+	};
+};
+
+&i2c9 {
+	status = "okay";
+};
+
+&i2c10 {
+	status = "okay";
+};
+
+&i2c11 {
+	status = "okay";
+
+	i2c-mux@76 {
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x76>;
+		i2c-mux-idle-disconnect;
+
+		imux32: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		imux33: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		imux34: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		imux35: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+
+		imux36: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+
+		imux37: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		imux38: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		imux39: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+
+	};
+};
+
+&i2c12 {
+	status = "okay";
+};
+
+&i2c13 {
+	status = "okay";
+};
+
+&adc {
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
+&sdhci1 {
+	max-frequency = <25000000>;
+	/*
+	 * DMA mode needs to be disabled to avoid conflicts with UHCI
+	 * Controller in AST2500 SoC.
+	 */
+	sdhci-caps-mask = <0x0 0x580000>;
+};
-- 
2.47.3



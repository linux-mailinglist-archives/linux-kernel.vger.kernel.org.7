Return-Path: <linux-kernel+bounces-743358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDCBB0FDA8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 01:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 256A39604D6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 23:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC8A274FFD;
	Wed, 23 Jul 2025 23:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkAKwYOX"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4550C274B5C;
	Wed, 23 Jul 2025 23:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753313433; cv=none; b=QIdmNR4cKMObBfRYRuBLDFM+EmY4MwJKBK/MH/Tf2N1NGuiQQuDKt0eKEz4UYvVcZAqBWrOjHCcLZcGFXzQ56D9OufLq/45dx3JpGGuFEJxGLmvYs8exjNRxtwa8EPAFv30Z2SrFW0oJHO1/OawXRcGOUG/r/Tpt1DudANXfqYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753313433; c=relaxed/simple;
	bh=mnTEVKcv+bQhcqPf2kA0m8mlAWDWGHwJt4W2ZTBbdXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MbiQcTWP7GcCnMDITI+OiJvgHsmQTV8XcphCaEF7ucGWG1dqG06fQmZqkxGGAv5oWBs9/42fNec5HcvpzxpJ48om0nt1mVix+8RwGAFtaPTVC/HVDBJ53dmGHiWx+SJLG1No2pRk6AlJuiRhLhB+m12W3avZAOfZAoteVJeivWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkAKwYOX; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-235f9e87f78so3705615ad.2;
        Wed, 23 Jul 2025 16:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753313432; x=1753918232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3mfssyA9l0C4/iGFnvM8hKQQolb/yTcaAf4qrrXcGs=;
        b=YkAKwYOXvtSDcxEZTI6lwO9i4+V1S1kKvygH3HXgh6Nhmo4TClpFE4LzrpbpuVZdc+
         6miyqBqAeBLBKrQ0SqRVwLciDFlnZXa5JblOZkul/mbM5UVX44MVqAFY0K8VJgvNEz47
         XDfwhXgxbHYg0Hx3q7Fn2+a9fjhC97tnp8ENv9c0wEKMf9iyeLKXf0PV4U9ZYjEll9Je
         XDykqGoTiXrN9a57gFo2RYhEhsm517L/T6STReq1Xle+uX8uEyIyxSNdIP4xlGYK935P
         UuyZ5bU+L5GzQBooCvqDbF126xC6pugwA9t2D5vBh9TIgdU5Bp28AsXxc0TvWGBGNDn7
         IjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753313432; x=1753918232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3mfssyA9l0C4/iGFnvM8hKQQolb/yTcaAf4qrrXcGs=;
        b=fopAcPedgIuEcoY1tFp7lfElRRpDiAjW7EK+isdNMl0VnCbJjoRTrvlqVKGohk5InU
         t4ccDcKPs6holQfXLN8jcbT6qgAErY1FYyGVHJFy46gyGld6FtP5RU1AwUSmDD4/jvOr
         czwmfY0MBTFuoWqvMb3vuWUdI4AjEsplSKI5hWLrYNgTRrSdNw9Wg77LRoyUmmu6/usn
         +0e22GDu4ejZIBzFAIVHN/7Xgliz5yCZUxx2SUhRAk7kwPdoZXQS7TXuv4gNsME3evrR
         ciZgUcYSyv4OaKaRrJtJA6fEGbZHIKdTDzzHl4YDXvlFchV8AJhlY5eApexzpEiW9dU0
         EmsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUo0A6JRay7a+bglicmss6h9GP2PVmATyvoIspjZ1v26729n3xdkmh4jJ4JFvQyjEa+IJS3IoARMMMh@vger.kernel.org, AJvYcCWovBBKBJ1qZfOz3agewSeUdytgzvruUqd53lAP4bx79+zFs/NazQQ+andRa7CLFmRKEA8Vo1M8skRO6U1R@vger.kernel.org
X-Gm-Message-State: AOJu0YwoKEVrjhsjjZ0m+U88RV5xA/BJa3l3REmxZRZDVTrSuNEuSd3K
	UxuYPzwg+l8FTadschNQuhIIwwxAraSv2KM07JeWiAsKOepvQfC2vXcI
X-Gm-Gg: ASbGncsPPV++NuMtbffCXNQqjXd6KMoRCciP2lyDEvJeUJHH5CxrYBQ/cRx6WTiOPg8
	AJjtzIgEt/TGg8G42TN2bOqhrwvxBvIycc3GJi1peKRdpVSQGnMkNBChPB938an7fHRZcHK2MJr
	3lEJCUaDDb8jPUJlqLpQZNjjM+gd480Jx9Pk6Y2wHVR3bpkGJZ1lSSMqHfLYWU1meykAyvELHLM
	l9DYxKydvKXvQUOJVgK9oanQHC2qm6CcSWhKcK3wKVNGhTb7Mv/Sn/yQ9xXHVZfHPJyT1W30dNI
	rGLFQ8fr5a++8MraGdMC2d/lb5FzVJzY6og2jk2EQ3eUqgMO2NdwcErvTD+uX/vJBWse1aJfWrm
	DfKV8+qpUmuBaIoBispOCMcsPOLo6G+dDmlb8eSBEuN+ryW3lS+SrUTk20JqTTOYBAfArccrPZm
	od/cvlWZnr6g==
X-Google-Smtp-Source: AGHT+IHgerWZl8WSYgEJrwJiKDedU1YTvFRBOUJRpz2obxy5mcxUEZF/C7p4IfnRVrHL4uiPcxOl1A==
X-Received: by 2002:a17:902:ce86:b0:23e:ea0:63c0 with SMTP id d9443c01a7336-23f981b6570mr65270225ad.41.1753313431554;
        Wed, 23 Jul 2025 16:30:31 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bc6fbsm1260765ad.120.2025.07.23.16.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 16:30:31 -0700 (PDT)
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
Subject: [PATCH v3 07/13] ARM: dts: aspeed: Add Facebook Wedge400-data64 (AST2500) BMC
Date: Wed, 23 Jul 2025 16:30:03 -0700
Message-ID: <20250723233013.142337-8-rentao.bupt@gmail.com>
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

Add wedge400-data64.dts to extend wedge400's data0 partition from 8MB to
64MB smoothly.

wedge400-data64.dts is copied from wedge400.dts with below changes:
  - updating model/compatible strings.
  - updating BMC flash layout.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v3:
  - None (the patch is introduced in v3).

 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed-bmc-facebook-wedge400-data64.dts   | 376 ++++++++++++++++++
 2 files changed, 377 insertions(+)
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
index 000000000000..5b23842f26a3
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400-data64.dts
@@ -0,0 +1,376 @@
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
+		bootargs = "console=ttyS0,9600n8 root=/dev/ram rw";
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



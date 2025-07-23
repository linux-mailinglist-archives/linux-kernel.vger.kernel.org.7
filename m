Return-Path: <linux-kernel+bounces-743364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0973B0FDAF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 01:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25354AA6C17
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 23:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0208D277815;
	Wed, 23 Jul 2025 23:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koi8+vKM"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620AB276038;
	Wed, 23 Jul 2025 23:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753313445; cv=none; b=kvxZp+rxPb9QPZTVWBAXqLq01B0vDj7UTCX3vtlH++HTEBD6aNH/aPZtBV8iMrGDBhulJu6bs8I35fFEssXdecT7Al10qL7YmTW/DnUsp6sNJLEFlmA4n4g7JGRx4rrj+Ep+tp12thCAI+NVVcv2fSdMOOY2H//6V6mougtslXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753313445; c=relaxed/simple;
	bh=Mlv/T6lwuWGECJtCisL2PL/Tqp5ceNvoJ7gk1fSnU+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXs9EGG17btp38Bf2APJ8mVT4Z409ugfqjb4F06TQk1zqQbp9VxpWt7DQCTptJXVB7HKlpWQTAXGlo2Cme7dvoj+cJmnJSEg3IJqjAa0P8LOgH/Cxf0UKMYQsWY1vwA5fS0EM31rKPhofxaLDzAlKyh2gOmmxMB30/wgzlH8ZqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koi8+vKM; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-237311f5a54so2542225ad.2;
        Wed, 23 Jul 2025 16:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753313442; x=1753918242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWNqqAntiLueNlOOvISn5Xu4T7d1LNy1Kt3fgDDvAVM=;
        b=koi8+vKMNq4jKZ5T7/0snu9fc0Gv3K2tmVd8cDnONY33e2yvHyfwra9Qe92ZefnTOz
         U5uc9DnnpJ6P2MibFznydiHhmQBoE2PWk+XvcTkHyjZkztBKJ5kRcS4E48dW4bvP0/kb
         x5TBlRvgZjK2CewYNowZ4sKVAcSD+Ww6zG+ZhLWOqbdljoUhwni+uVzUTQrKxkiUuHPU
         QlcI0Yne8oU2vM2UaeuMyMrXwbvBY1IuBxEMf/D6pIlw5OUPEZONyFY1XW1OpGkq70pf
         n0etoFH4xnLojKOgPESXAFDIEFOcMWXZRW/kf3+VgVxihky+MQJh1lJx1cyh/12nNQLt
         6jOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753313442; x=1753918242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWNqqAntiLueNlOOvISn5Xu4T7d1LNy1Kt3fgDDvAVM=;
        b=nxVf5dZ4uRLFiNSHb3imexDvO3qlJZnZY8SEqEcdkjcmzRLfGHzk1C2niEs1DtwuDX
         plYssB0kuAwCmAOwA7nN8dDJvCwgOcPggoZblxNYLG1DHdCPH0QrpTWemzmFa/icY3x4
         tiMjnGUBkSm72rHdA/yilB3PQgRYshlmUe+P5lFQ97Ueli1cFWAdsvq9/AfgKlZfWBii
         PKDiHV0S0MTit03fSqP9ri5vc3MKTzob0JDNh8jt1HHHSHkrvNVBVMtsHij6w8B1MpWG
         HVWsQsWm3qX3JBtnxUR+RDt9dtW06VO7jbpNK1g/Wr+frlMOKIEqU5M2bLk8P/EX5gmO
         qu5g==
X-Forwarded-Encrypted: i=1; AJvYcCUjId3CI/J/Yxqhnhb1Ki2Q6yVQx8bKrFSAHmsLV90qJ9v3m7JKeVZL/Qf2Y02p37nY7TIp7V1PclSNSJuP@vger.kernel.org, AJvYcCWLWyT78tllofYGku/L0bBpfYi91oiR89jkLZ+J0m756BqJLC1dlj7YmrA9sIuaH0lJwQxx9dljdFFG@vger.kernel.org
X-Gm-Message-State: AOJu0YxNh5fgBMhKJsKp4+NyeQhl21eNHroWj08UwEEdoJs88P+1V2T6
	CxZ0kSTrO0xgMztaPlBV/Bf3sy1LaorXXs+XrizKGNdEoiDk65xM4ae9
X-Gm-Gg: ASbGncvfPonr6F5a0aDw9SqKebc53rnU6KhT4lw7I4us7nPFZGB35zby3PUkhjsF167
	LePBdyOM9RDna4zpzycjGwield4bmTOCsXc+Da1F8H3C5CYm3/YiMwcizbPzTrbXTL5bSCCUn09
	6sw6je7G3/ZzS8ZwAedMw1HsHPrmHAoc7Cx4Jthqj6ggRXlw1WPHwapb6o/HwpgHGrVTiIMORZw
	Enniqe4Eo0y08daBDpaVChuF7+cw8n7/nOUGoAKJZb79C9SLuQPgMjY1NFWZpjQSzYKgn2yxPBB
	wy/mDSKkj+cg9kAAre+y23cnGwIhQRxV1psWX8q5km0Fmsuk6jtGzkSYBhS+U776Eyt5aSYMpce
	utjm4MRXoLIJfbTDmCYvcdq4OgFfxhiuS/tIU266ehAxVLfsbSw9z9+XZ3bpstN9isKuWili3p6
	Q=
X-Google-Smtp-Source: AGHT+IGMpmU9/y8jlws7TyyqNLtoPH3duLJVbY+xZiyyDKkZpeNxiVfJuwOA88XEZKJDN/jVR3l4cw==
X-Received: by 2002:a17:903:1aa6:b0:234:c5c1:9b63 with SMTP id d9443c01a7336-23f9814eb24mr64705765ad.18.1753313441648;
        Wed, 23 Jul 2025 16:30:41 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bc6fbsm1260765ad.120.2025.07.23.16.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 16:30:41 -0700 (PDT)
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
Subject: [PATCH v3 13/13] ARM: dts: aspeed: Add Facebook Darwin (AST2600) BMC
Date: Wed, 23 Jul 2025 16:30:09 -0700
Message-ID: <20250723233013.142337-14-rentao.bupt@gmail.com>
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

Add initial device tree for the Meta (Facebook) Darwin AST2600 BMC.

Darwin is Meta's rack switch platform with an AST2600 BMC integrated for
health monitoring purpose.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
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



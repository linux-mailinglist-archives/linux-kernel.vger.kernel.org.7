Return-Path: <linux-kernel+bounces-835195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C330BA67A6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 06:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1348C7A4107
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 04:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840F42877E2;
	Sun, 28 Sep 2025 04:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wTWKn+YC"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBEA2820DA
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 04:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759033074; cv=none; b=jt3jpvLbiTm21JlvSnChmG8ZDrg9455Bz1i957vwwELDj1MO1L1yJEUurlANRuoxPQP/CmZN8ua+eGgPNhyvypsZYLMf4wgQwLY+tUnW7BjEvFgYB2uFcMNmIhsaBdRXLuKpCf2set6jfyUFLEbBIJMs5Sc8kZG+2XcXOG8AknI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759033074; c=relaxed/simple;
	bh=Q88g6NgIDPzr29e3PY11KRgsjucACUTC2bTeL6Iy79A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j5cq49OtNGLhLgW3Zqz9pI9qcst2l8SC2WY1d41IR5K7gMZjAXNHRrYx1IVxj2JT7HqXACzn45JlucGWwqh8OiohuJCuH2XovOzyNeBtvu6F9Jw+q58BqYGtZ00Mp3/A2rbUtjZ4HkvePpVZV3MqA5xPpVNjEjm2t8yQeJLwAyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wTWKn+YC; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759033069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LHLyA/D7GeMbQihTSXEVxyGR+0Gp9mPa3CC/P6nTicQ=;
	b=wTWKn+YCTQKb9EI6/yOHvrede5gSBo+sHtErPVquFrPmPUzctwyTkHsfg0xCG/EkzS735q
	0yjcy0cgi6JnKCo2pT8yQk3jMOrrv2d7Wqdjv4gWsVO61O8aFcgyLw7l6GzU8R58cye/YR
	52dFhqhRQK3F2HZFmL2sch9xEgTpb/A=
From: Troy Mitchell <troy.mitchell@linux.dev>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@gentoo.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Yangyu Chen <cyy@cyyself.name>
Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] riscv: dts: spacemit: Add MusePi Pro board device tree
Date: Sun, 28 Sep 2025 12:16:49 +0800
Message-ID: <20250928-k1-musepi-pro-dts-v1-2-5efcca0ce3ae@linux.spacemit.com>
In-Reply-To: <20250928-k1-musepi-pro-dts-v1-0-64d0659dfdbc@linux.spacemit.com>
References: <20250928-k1-musepi-pro-dts-v1-0-64d0659dfdbc@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759032880; l=2324; i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id; bh=HhpEYQs9PHex0vdyfiwrT7aa5/e9NC5xTLrmbF8jh0k=; b=3S8d319lcZtW/kO06oIRVAaAlRpq1+Xmn+f9O2CHr+7DCN1+qlFH9bZYDzOzkj78xFzbXTJkx NZ+aKireMEXBWWl12r1LKaHPf0MJlSUQ6/twuBoPQmrADZIXVtLZgvi
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519; pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Troy Mitchell <troy.mitchell@linux.spacemit.com>

Add initial device tree support for the MusePi Pro board [1].
The board is using the SpacemiT K1/M1 SoC.

The device tree is adapted from the SpacemiT vendor tree [2].

This minimal device tree enables booting into a serial console with UART
output and a blinking LED.

Link:
https://developer.spacemit.com/documentation?token=YJtdwnvvViPVcmkoPDpcvwfVnrh&type=pdf [1]
https://gitee.com/bianbu-linux/linux-6.6/blob/k1-bl-v2.2.y/arch/riscv/boot/dts/spacemit/k1-x_MUSE-Pi-Pro.dts [2]

Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
 arch/riscv/boot/dts/spacemit/Makefile          |  1 +
 arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts | 40 ++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/Makefile b/arch/riscv/boot/dts/spacemit/Makefile
index 152832644870624d8fd77684ef33addb42b0baf3..76b98096e2a46c3192651d6d66af7742f740c635 100644
--- a/arch/riscv/boot/dts/spacemit/Makefile
+++ b/arch/riscv/boot/dts/spacemit/Makefile
@@ -2,3 +2,4 @@
 dtb-$(CONFIG_ARCH_SPACEMIT) += k1-bananapi-f3.dtb
 dtb-$(CONFIG_ARCH_SPACEMIT) += k1-milkv-jupiter.dtb
 dtb-$(CONFIG_ARCH_SPACEMIT) += k1-orangepi-rv2.dtb
+dtb-$(CONFIG_ARCH_SPACEMIT) += k1-musepi-pro.dtb
diff --git a/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
new file mode 100644
index 0000000000000000000000000000000000000000..3791186ce47b88887eab4321dcd7035668e7f02d
--- /dev/null
+++ b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
+ * Copyright (C) 2025 Troy Mitchell <troy.mitchell@linux.spacemit.com>
+ */
+
+/dts-v1/;
+
+#include "k1.dtsi"
+#include "k1-pinctrl.dtsi"
+
+/ {
+	model = "MusePi Pro";
+	compatible = "spacemit,musepi-pro", "spacemit,k1";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led1 {
+			label = "sys-led";
+			gpios = <&gpio K1_GPIO(96) GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			default-state = "on";
+		};
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_2_cfg>;
+	status = "okay";
+};

-- 
2.51.0



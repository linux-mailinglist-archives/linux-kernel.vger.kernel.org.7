Return-Path: <linux-kernel+bounces-803124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72114B45AC8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F1D85C4014
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248B5371EAD;
	Fri,  5 Sep 2025 14:43:13 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF241FDE19;
	Fri,  5 Sep 2025 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757083392; cv=none; b=jAX59ej6UxJGuDrfAGhjQvwduV3H3KgHI89nzrbx3zO85xd5A5Ejd4igJ54K6EEa5+lcr22h6j2GUIkbdc0RE6sjxI3Gr7K/iGTErOJsnUG7z8177+Alanrq4kvgLV8GnKzLZQ5usvHF/jsLg7urrRrP66TLz7DNue3gZVcEQWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757083392; c=relaxed/simple;
	bh=VC9vOI6hoGb5U04XGqPFyM6IVT00uHdpMfuneD2QaI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSi3Pf6ZgItzgxHdW3AOFDrT/nmoN0q7CV/4JWSbWHrB2cJC3Oxr6AgSj3ndnHj8P4FkBvFcBIPakpx4VSfXB/PGbBsaFbtEiETEQcohES7wAUQMFqeH6RPq13nWJCGUB1qU2maOPuXjosSlFQkjzdTmQDzPdFWvgODiBv8Un2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 98661B2200C5;
	Fri,  5 Sep 2025 16:43:06 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Emil Renner Berthing <kernel@esmil.dk>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	E Shattow <e@freeshell.de>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: [PATCH v3 5/5] riscv: dts: starfive: add Milk-V Mars CM Lite system-on-module
Date: Fri,  5 Sep 2025 07:39:43 -0700
Message-ID: <20250905144011.928332-6-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250905144011.928332-1-e@freeshell.de>
References: <20250905144011.928332-1-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Milk-V Mars CM Lite is a System-on-Module based on the Milk-V Mars CM
without the onboard eMMC storage component populated and configured
instead for SD3.0 Card Slot on that interface via 100-pin connector.

Link to Milk-V Mars CM Lite schematics: https://github.com/milkv-mars/mars-files/tree/main/Mars-CM_Hardware_Schematices
Link to StarFive JH7110 Technical Reference Manual: https://doc-en.rvspace.org/JH7110/TRM/index.html
Link to Raspberry Pi CM4IO datasheet: https://datasheets.raspberrypi.com/cm4io/cm4io-datasheet.pdf

Add the devicetree file to make use of StarFive JH7110 common supported
features PMIC, EEPROM, UART, I2C, GPIO, PCIe, QSPI Flash, PWM, and
Ethernet. Also configure the eMMC interface mmc0 for SD Card use and
configure the common SD Card interface mmc1 for onboard SDIO BT+WiFi.

Signed-off-by: E Shattow <e@freeshell.de>
---
 arch/riscv/boot/dts/starfive/Makefile         |  1 +
 .../dts/starfive/jh7110-milkv-marscm-lite.dts | 25 +++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-lite.dts

diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/starfive/Makefile
index 79742617ddab..62b659f89ba7 100644
--- a/arch/riscv/boot/dts/starfive/Makefile
+++ b/arch/riscv/boot/dts/starfive/Makefile
@@ -11,6 +11,7 @@ dtb-$(CONFIG_ARCH_STARFIVE) += jh7100-starfive-visionfive-v1.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-deepcomputing-fml13v01.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-mars.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-marscm-emmc.dtb
+dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-marscm-lite.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-pine64-star64.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.2a.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.3b.dtb
diff --git a/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-lite.dts b/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-lite.dts
new file mode 100644
index 000000000000..6c40d0ec4011
--- /dev/null
+++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-lite.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2025 E Shattow <e@freeshell.de>
+ */
+
+/dts-v1/;
+#include "jh7110-milkv-marscm.dtsi"
+
+/ {
+	model = "Milk-V Mars CM Lite";
+	compatible = "milkv,marscm-lite", "starfive,jh7110";
+};
+
+&mmc0 {
+	bus-width = <4>;
+	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
+};
+
+&mmc0_pins {
+	pwren-pins {
+		pinmux = <GPIOMUX(22, GPOUT_HIGH,
+				      GPOEN_ENABLE,
+				      GPI_NONE)>;
+	};
+};
-- 
2.50.0



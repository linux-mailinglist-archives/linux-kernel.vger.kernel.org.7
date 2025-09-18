Return-Path: <linux-kernel+bounces-793595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C61B3B3D5B2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 01:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB1754E143D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 23:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCA724DCF9;
	Sun, 31 Aug 2025 23:02:08 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAF120766E;
	Sun, 31 Aug 2025 23:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756681327; cv=none; b=gNeL/GewZ98/vnQgQA1xdUlan75+wO6b/OWQtFm9hIVIuFKowDB4zpwxujXxTBv10FoU1yXgt9cM4i+Re0BPYR+yIn8hzbFezH6w/Tf49dswZucG4rHJ5os7c3LzV8XYZG6kxG2koBP80CpDBDExfPhQ7AhZPcH2IkqlC3ETTTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756681327; c=relaxed/simple;
	bh=E9c9zmJDKxN6igMoDXkYVSRag/US251oyhqhXvjGBcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LsLlcZIz0YceW+fiMvYdN8IC/B1tAXKQcnEO2fPQoYCf0JbaUCEaDm/TrVQESiI4agq2FNV6Zg3dDme+Q7yyAcc4uQpT0rxQwR0kiBjvEMHU8zYIWn4EXVw3f2SsoW+d8dKknSQuZ1KMYvDzPEUrPS9kydER8k7lNpqigE5o0jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id B0401B220254;
	Mon,  1 Sep 2025 01:02:01 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Conor Dooley <conor@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	E Shattow <e@freeshell.de>
Subject: [PATCH v2 3/5] riscv: dts: starfive: add Milk-V Mars CM system-on-module
Date: Sun, 31 Aug 2025 15:59:28 -0700
Message-ID: <20250831225959.531393-4-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250831225959.531393-1-e@freeshell.de>
References: <20250831225959.531393-1-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Milk-V Mars CM is a System-on-Module based on the StarFive VisionFive 2
board and Radxa CM3 System-on-Module compatible with the Raspberry Pi
CM4IO Classic IO Board.

Mars CM SoM features:

- StarFive JH7110 System on Chip with RV64GC up to 1.5GHz
- AXP15060 Power Management Unit
- LPDDR4 2GB / 4GB / 8GB DRAM memory
- BL24C04F 4K bits (512 x 8) EEPROM
- GigaDevice 25LQ128EWIG QSPI NOR Flash 16M or SoC ROM UART loader for
  boot (selectable by GPIO)
- eMMC5.0 8GB / 16GB / 32GB flash storage onboard
- AP6256 via SDIO 2.0 onboard wireless connectivity WiFi 5 + Bluetooth
  5.2 (optional, present in models with WiFi feature)
- 1x Motorcomm YT8531C Gigabit Ethernet PHY
- IMG BXE-4-32 Integrated GPU with 3D Acceleration:
  - H.264 & H.265 4K@60fps Decoding
  - H.265 1080p@30fps Encoding
  - JPEG encoder / decoder

Additional features available via 2x 100-pin connectors for CM4IO Board:
- 1x HDMI 2.0
- 1x MIPI DSI (4-lanes)
- 1x 2CH Audio out (via GPIO)
- 1x MIPI CSI (2x2-lanes or 1x4-lanes)
- 1x USB 2.0
- 1x PCIe 1-lane Host, Gen 2 (5Gbps)
- Up to 28x GPIO, supporting 3.3V
- UART x6
- PWM x8
- I2C x7
- SPI
- I2S

Link to Milk-V Mars CM schematics: https://github.com/milkv-mars/mars-files/tree/main/Mars-CM_Hardware_Schematices
Link to StarFive JH7110 Technical Reference Manual: https://doc-en.rvspace.org/JH7110/TRM/index.html
Link to Raspberry Pi CM4IO datasheet: https://datasheets.raspberrypi.com/cm4io/cm4io-datasheet.pdf

Add the devicetree file to make use of StarFive JH7110 common supported
features PMIC, EEPROM, UART, I2C, GPIO, eMMC, PCIe, QSPI Flash, PWM, and
Ethernet. Also configure the common SD Card interface mmc1 for onboard
SDIO BT+WiFi.

Signed-off-by: E Shattow <e@freeshell.de>
---
 arch/riscv/boot/dts/starfive/Makefile               |  1 +
 .../boot/dts/starfive/jh7110-milkv-marscm-emmc.dts  | 13 +++++++++++++
 2 files changed, 14 insertions(+)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-emmc.dts

diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/starfive/Makefile
index b3bb12f78e7d..79742617ddab 100644
--- a/arch/riscv/boot/dts/starfive/Makefile
+++ b/arch/riscv/boot/dts/starfive/Makefile
@@ -10,6 +10,7 @@ dtb-$(CONFIG_ARCH_STARFIVE) += jh7100-starfive-visionfive-v1.dtb
 
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-deepcomputing-fml13v01.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-mars.dtb
+dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-marscm-emmc.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-pine64-star64.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.2a.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.3b.dtb
diff --git a/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-emmc.dts b/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-emmc.dts
new file mode 100644
index 000000000000..1cf8e52d4f65
--- /dev/null
+++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-emmc.dts
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2025 E Shattow <e@freeshell.de>
+ */
+
+/dts-v1/;
+#include "jh7110-milkv-marscm.dtsi"
+
+/ {
+	model = "Milk-V Mars CM";
+	compatible = "milkv,marscm-emmc", "starfive,jh7110";
+};
+
-- 
2.50.0



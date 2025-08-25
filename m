Return-Path: <linux-kernel+bounces-785179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9801DB3470F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0127A16895C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F142FF65B;
	Mon, 25 Aug 2025 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AnH0NDYZ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190502FF144;
	Mon, 25 Aug 2025 16:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756138872; cv=none; b=Dgl1PxdCI/xUU2VcX+5cWaTNZBFgX6/I+zUZfeLGSIIUd+B0GRKJf+0AlwRRJ8GuurkK+OXyGIah9lbh4GNyX2kg67020t9+It81/X9egjjXos9us+YmOWsZEGJfQJr0as4MSuKTdUv9tr868+cgoUZpJk5tCOdNiJA3BgZadnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756138872; c=relaxed/simple;
	bh=+l/3hV2LE6/3YbTfwtYVqhWFguZB2LbTah+JaBKElGg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aX0Mv5w4HmjqoPlDUIy/VkLEF1+H+foULgzzIVAwwllW3FFd/44E6EHZLre+pVA5ho3BHJMqxEE/H/C4jbSlOZUiWy9e+ocI1ACv+a858JxmNzCCONRzHg1FIOMs6AdCbPrI5+m1pzErqeOabjN95q7jCefifSMIlJ5SPxbtYiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AnH0NDYZ; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756138871; x=1787674871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+l/3hV2LE6/3YbTfwtYVqhWFguZB2LbTah+JaBKElGg=;
  b=AnH0NDYZrM/po7HHLvf+Any/stQEFiAbomyBceXKq5MhU7urCNw+FQY1
   DcJxpVoyS2+KON/MyoMO6jFNDEajY7hN8TLO4F5meY6/lC62HgniEqpa0
   92NoI+PVJczleXUIyB/KyRkVtQ2sLV+MSlonJ7IdVFBEUE1sXAFyYz4kx
   +24OarXB8vXKrpQsR5heBVHBK812opv/+QneP6G2kBwj2us/u0a9Ba2Pl
   vG5R9g4F2u4Ig9CpTQjOVybte7peAjP4GZSiz5Z+XIZIhrUZ71cNTRAEY
   6LmEsZm1luN7nv0kAH/KLWG+/o+5eV5Vnm3bAXR3jVDVFcTw9EBraAeKd
   A==;
X-CSE-ConnectionGUID: aOjtNZFgQlqEbp9cjaRbcw==
X-CSE-MsgGUID: XJFIKAbpSUWjzDkvubyJyg==
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="45617316"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2025 09:21:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 25 Aug 2025 09:20:49 -0700
Received: from valentina.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 25 Aug 2025 09:20:47 -0700
From: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
To: <conor.dooley@microchip.com>, <daire.mcnamara@microchip.com>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<valentina.fernandezalanis@microchip.com>
CC: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v1 3/5] riscv: dts: microchip: add icicle kit with production device
Date: Mon, 25 Aug 2025 17:19:50 +0100
Message-ID: <20250825161952.3902672-4-valentina.fernandezalanis@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825161952.3902672-1-valentina.fernandezalanis@microchip.com>
References: <20250825161952.3902672-1-valentina.fernandezalanis@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

With the introduction of the Icicle Kit using the production MPFS250T
device, it's necessary to distinguish it from the engineering sample
(-es) variant. Engineering samples cannot write to flash from the MSS,
as noted in the PolarFire SoC FPGA ES errata.

Add a new device tree (mpfs-icicle-kit-prod.dts) for the production
board which includes the icicle kit common dtsi and enable the system
controller SPI flash, which is only accessible on production silicon.

Remove redundant board compatible from fabric dtsi and update board
compatibles for v2025.07 release, which includes Mi-V IHC v2 for AMP
cluster communication.

Signed-off-by: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
---
 arch/riscv/boot/dts/microchip/Makefile        |  1 +
 .../dts/microchip/mpfs-icicle-kit-common.dtsi |  4 ++++
 .../dts/microchip/mpfs-icicle-kit-fabric.dtsi | 23 ++++++++++++++++---
 .../dts/microchip/mpfs-icicle-kit-prod.dts    | 23 +++++++++++++++++++
 .../boot/dts/microchip/mpfs-icicle-kit.dts    |  3 ++-
 5 files changed, 50 insertions(+), 4 deletions(-)
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-icicle-kit-prod.dts

diff --git a/arch/riscv/boot/dts/microchip/Makefile b/arch/riscv/boot/dts/microchip/Makefile
index f51aeeb9fd3b..1e2f4e41bf0d 100644
--- a/arch/riscv/boot/dts/microchip/Makefile
+++ b/arch/riscv/boot/dts/microchip/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-beaglev-fire.dtb
 dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-icicle-kit.dtb
+dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-icicle-kit-prod.dtb
 dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-m100pfsevp.dtb
 dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-polarberry.dtb
 dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-sev-kit.dtb
diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-common.dtsi b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-common.dtsi
index eafea3b69cd7..5c7a8ffad85b 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-common.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-common.dtsi
@@ -134,6 +134,10 @@ &i2c2 {
 	status = "okay";
 };
 
+&ihc {
+	status = "okay";
+};
+
 &mac0 {
 	phy-mode = "sgmii";
 	phy-handle = <&phy0>;
diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
index a6dda55a2d1d..92a49f91013e 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
@@ -2,9 +2,6 @@
 /* Copyright (c) 2020-2021 Microchip Technology Inc */
 
 / {
-	compatible = "microchip,mpfs-icicle-reference-rtlv2210", "microchip,mpfs-icicle-kit",
-		     "microchip,mpfs";
-
 	core_pwm0: pwm@40000000 {
 		compatible = "microchip,corepwm-rtl-v4";
 		reg = <0x0 0x40000000 0x0 0xF0>;
@@ -26,6 +23,26 @@ i2c2: i2c@40000200 {
 		status = "disabled";
 	};
 
+	ihc: mailbox {
+		compatible = "microchip,sbi-ipc";
+		interrupt-parent = <&plic>;
+		interrupts = <180>, <179>, <178>, <177>;
+		interrupt-names = "hart-1", "hart-2", "hart-3", "hart-4";
+		#mbox-cells = <1>;
+		status = "disabled";
+	};
+
+	mailbox@50000000 {
+		compatible = "microchip,miv-ihc-rtl-v2";
+		microchip,ihc-chan-disabled-mask = /bits/ 16 <0>;
+		reg = <0x0 0x50000000 0x0 0x1c000>;
+		interrupt-parent = <&plic>;
+		interrupts = <180>, <179>, <178>, <177>;
+		interrupt-names = "hart-1", "hart-2", "hart-3", "hart-4";
+		#mbox-cells = <1>;
+		status = "disabled";
+	};
+
 	pcie: pcie@3000000000 {
 		compatible = "microchip,pcie-host-1.0";
 		#address-cells = <0x3>;
diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-prod.dts b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-prod.dts
new file mode 100644
index 000000000000..8afedece89d1
--- /dev/null
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-prod.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* Copyright (c) 2025 Microchip Technology Inc */
+
+/dts-v1/;
+
+#include "mpfs-icicle-kit-common.dtsi"
+
+/ {
+	model = "Microchip PolarFire-SoC Icicle Kit (Production Silicon)";
+	compatible = "microchip,mpfs-icicle-prod-reference-rtl-v2507",
+		     "microchip,mpfs-icicle-kit-prod",
+		     "microchip,mpfs-icicle-kit",
+		     "microchip,mpfs-prod",
+		     "microchip,mpfs";
+};
+
+&syscontroller {
+	microchip,bitstream-flash = <&sys_ctrl_flash>;
+};
+
+&syscontroller_qspi {
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
index 2cb08ed0946d..556aa9638282 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
@@ -7,6 +7,7 @@
 
 / {
 	model = "Microchip PolarFire-SoC Icicle Kit";
-	compatible = "microchip,mpfs-icicle-reference-rtlv2210", "microchip,mpfs-icicle-kit",
+	compatible = "microchip,mpfs-icicle-es-reference-rtl-v2507",
+		     "microchip,mpfs-icicle-kit",
 		     "microchip,mpfs";
 };
-- 
2.34.1



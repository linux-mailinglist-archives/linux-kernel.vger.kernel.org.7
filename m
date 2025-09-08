Return-Path: <linux-kernel+bounces-806091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5F3B491CA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B0CE16386C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A760E313298;
	Mon,  8 Sep 2025 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lYhdSKgD"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E8B30C603;
	Mon,  8 Sep 2025 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341915; cv=none; b=lKTW5Xv5k2GeXTl7dxvGy4vQqtV0du0tBgNh47UnSNSjj1ldK+qAsNLtvPlBvtTYzb/JZCzHZeQaYaALiE/0ig4ZLClgB7AokCK0tWcayFmeeSEiSJ/QPw6KNGpGQJvoaZ4clIUmmgE+Y1BoIBYjT8AN3g70br0k7r+GLca+Egw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341915; c=relaxed/simple;
	bh=qqvLiOWphBmzKOVF2cjHpoDClBnWoaYIyM4jU5kOtRI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=obeY2zoyZ0sHH1AMqAz46N79lsfvzTaehLrthFJ+nEduhpoztVb4X2PZu5vr5mmwiTAX4CB0Qy3MYlAh3ISdteHkxe7/xWGOW8NoR2GO4x4Nwhl02As9JNjGHfScpR9dZINgMuG0muYOjDOaUTlZ06NTiQcVnN+Hzz97em19ABE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lYhdSKgD; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 588EVlZ3120887;
	Mon, 8 Sep 2025 09:31:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757341907;
	bh=sSuizfdlkq/bS4uuwNjXs5BlrTw0z8BBQfkjmr3VoWY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=lYhdSKgDgWSuazb3nmFZktLOTfj03GUruJUkXlhzpuevvGr5oBCK2OVNTddu2LTMN
	 DYjhbISji8sTdToSkklmgiIhnGQkjEGFUneEVslI5cqreY4OHBhTiGvYxTTa3vxb1G
	 1vkc3JRpcb+xaU0nMixkIEcnv7f7P0STZbrdHWM4=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 588EVkRR2466743
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 09:31:47 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 09:31:46 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 09:31:46 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 588ESedC1037553;
	Mon, 8 Sep 2025 09:31:41 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <d-gole@ti.com>, <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Diogo
 Ivo <diogo.ivo@siemens.com>,
        Li Hua Qian <huaqian.li@siemens.com>,
        Jan Kiszka
	<jan.kiszka@siemens.com>,
        Baocheng Su <baocheng.su@siemens.com>,
        Benedikt
 Niedermayr <benedikt.niedermayr@siemens.com>
Subject: [PATCH v4 34/34] arm64: dts: ti: k3-am65-ti-ipc-firmware: Refactor IPC cfg into new dtsi
Date: Mon, 8 Sep 2025 19:58:26 +0530
Message-ID: <20250908142826.1828676-35-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908142826.1828676-1-b-padhi@ti.com>
References: <20250908142826.1828676-1-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The TI K3 AM65 SoCs have multiple programmable remote processors like
R5Fs. The TI SDKs for AM65 SoCs offer sample firmwares which could be
run on these cores to demonstrate an "echo" IPC test. Those firmware
require certain memory carveouts to be reserved from system memory,
timers to be reserved, and certain mailbox configurations for interrupt
based messaging. These configurations could be different for a different
firmware.

While DT is not meant for system configurations, at least refactor these
configurations from board level DTS into a dtsi for now. This dtsi for
TI IPC firmware is board-independent and can be applied to all boards
from the same SoC Family. This gets rid of code duplication and allows
more freedom for users developing custom firmware (or no firmware) to
utilize system resources better; easily by swapping out this dtsi. To
maintain backward compatibility, the dtsi is included in all boards.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
Cc: Diogo Ivo <diogo.ivo@siemens.com>
Cc: Li Hua Qian <huaqian.li@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Baocheng Su <baocheng.su@siemens.com>
Cc: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
Requesting for review/test of this patch.

v4: Changelog:
1. Updated carveout node names to generic 'memory@addr'

Link to v3:
https://lore.kernel.org/all/20250905051846.1189612-34-b-padhi@ti.com/

v3: Changelog:
1. None

Link to v2:
https://lore.kernel.org/all/20250823160901.2177841-34-b-padhi@ti.com/

v2: Changelog:
1. Re-ordered patch from [PATCH 32/33] to [PATCH v2 33/33].

Link to v1:
https://lore.kernel.org/all/20250814223839.3256046-33-b-padhi@ti.com/

 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 62 ++----------------
 .../boot/dts/ti/k3-am65-ti-ipc-firmware.dtsi  | 64 +++++++++++++++++++
 .../arm64/boot/dts/ti/k3-am654-base-board.dts | 58 +----------------
 3 files changed, 72 insertions(+), 112 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-ti-ipc-firmware.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index df2eed0b4048..42ba3dab2fc1 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -59,24 +59,6 @@ mcu_r5fss0_core0_memory_region: memory@a0100000 {
 			no-map;
 		};
 
-		mcu_r5fss0_core1_dma_memory_region: memory@a1000000 {
-			compatible = "shared-dma-pool";
-			reg = <0 0xa1000000 0 0x100000>;
-			no-map;
-		};
-
-		mcu_r5fss0_core1_memory_region: memory@a1100000 {
-			compatible = "shared-dma-pool";
-			reg = <0 0xa1100000 0 0xf00000>;
-			no-map;
-		};
-
-		rtos_ipc_memory_region: memory@a2000000 {
-			reg = <0x00 0xa2000000 0x00 0x00200000>;
-			alignment = <0x1000>;
-			no-map;
-		};
-
 		/* To reserve the power-on(PON) reason for watchdog reset */
 		wdt_reset_memory_region: wdt-memory@a2200000 {
 			reg = <0x00 0xa2200000 0x00 0x1000>;
@@ -582,44 +564,6 @@ &pcie1_rc {
 	reset-gpios = <&wkup_gpio0 27 GPIO_ACTIVE_HIGH>;
 };
 
-&mailbox0_cluster0 {
-	status = "okay";
-	interrupts = <436>;
-
-	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
-		ti,mbox-tx = <1 0 0>;
-		ti,mbox-rx = <0 0 0>;
-	};
-};
-
-&mailbox0_cluster1 {
-	status = "okay";
-	interrupts = <432>;
-
-	mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
-		ti,mbox-tx = <1 0 0>;
-		ti,mbox-rx = <0 0 0>;
-	};
-};
-
-&mcu_r5fss0 {
-	status = "okay";
-};
-
-&mcu_r5fss0_core0 {
-	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
-			<&mcu_r5fss0_core0_memory_region>;
-	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core0>;
-	status = "okay";
-};
-
-&mcu_r5fss0_core1 {
-	memory-region = <&mcu_r5fss0_core1_dma_memory_region>,
-			<&mcu_r5fss0_core1_memory_region>;
-	mboxes = <&mailbox0_cluster1 &mbox_mcu_r5fss0_core1>;
-	status = "okay";
-};
-
 &mcu_rti1 {
 	memory-region = <&wdt_reset_memory_region>;
 };
@@ -692,3 +636,9 @@ &mcu_r5fss0 {
 	/* lock-step mode not supported on iot2050 boards */
 	ti,cluster-mode = <0>;
 };
+
+#include "k3-am65-ti-ipc-firmware.dtsi"
+
+&rtos_ipc_memory_region {
+	reg = <0x00 0xa2000000 0x00 0x00200000>;
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am65-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-am65-ti-ipc-firmware.dtsi
new file mode 100644
index 000000000000..61ab0357fc0d
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am65-ti-ipc-firmware.dtsi
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/**
+ * Device Tree Source for enabling IPC using TI SDK firmware on AM65 SoCs
+ *
+ * Copyright (C) 2016-2025 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+&reserved_memory {
+	mcu_r5fss0_core1_dma_memory_region: memory@a1000000 {
+		compatible = "shared-dma-pool";
+		reg = <0 0xa1000000 0 0x100000>;
+		no-map;
+	};
+
+	mcu_r5fss0_core1_memory_region: memory@a1100000 {
+		compatible = "shared-dma-pool";
+		reg = <0 0xa1100000 0 0xf00000>;
+		no-map;
+	};
+
+	rtos_ipc_memory_region: memory@a2000000 {
+		reg = <0x00 0xa2000000 0x00 0x00100000>;
+		alignment = <0x1000>;
+		no-map;
+	};
+};
+
+&mailbox0_cluster0 {
+	status = "okay";
+	interrupts = <436>;
+
+	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
+		ti,mbox-tx = <1 0 0>;
+		ti,mbox-rx = <0 0 0>;
+	};
+};
+
+&mailbox0_cluster1 {
+	status = "okay";
+	interrupts = <432>;
+
+	mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
+		ti,mbox-tx = <1 0 0>;
+		ti,mbox-rx = <0 0 0>;
+	};
+};
+
+&mcu_r5fss0 {
+	status = "okay";
+};
+
+&mcu_r5fss0_core0 {
+	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
+			<&mcu_r5fss0_core0_memory_region>;
+	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core0>;
+	status = "okay";
+};
+
+&mcu_r5fss0_core1 {
+	memory-region = <&mcu_r5fss0_core1_dma_memory_region>,
+			<&mcu_r5fss0_core1_memory_region>;
+	mboxes = <&mailbox0_cluster1 &mbox_mcu_r5fss0_core1>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index 3ca771a4f9c7..0c42c486d83a 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -61,24 +61,6 @@ mcu_r5fss0_core0_memory_region: memory@a0100000 {
 			reg = <0 0xa0100000 0 0xf00000>;
 			no-map;
 		};
-
-		mcu_r5fss0_core1_dma_memory_region: memory@a1000000 {
-			compatible = "shared-dma-pool";
-			reg = <0 0xa1000000 0 0x100000>;
-			no-map;
-		};
-
-		mcu_r5fss0_core1_memory_region: memory@a1100000 {
-			compatible = "shared-dma-pool";
-			reg = <0 0xa1100000 0 0xf00000>;
-			no-map;
-		};
-
-		rtos_ipc_memory_region: memory@a2000000 {
-			reg = <0x00 0xa2000000 0x00 0x00100000>;
-			alignment = <0x1000>;
-			no-map;
-		};
 	};
 
 	gpio-keys {
@@ -521,44 +503,6 @@ &serdes1 {
 	status = "disabled";
 };
 
-&mailbox0_cluster0 {
-	status = "okay";
-	interrupts = <436>;
-
-	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
-		ti,mbox-tx = <1 0 0>;
-		ti,mbox-rx = <0 0 0>;
-	};
-};
-
-&mailbox0_cluster1 {
-	status = "okay";
-	interrupts = <432>;
-
-	mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
-		ti,mbox-tx = <1 0 0>;
-		ti,mbox-rx = <0 0 0>;
-	};
-};
-
-&mcu_r5fss0 {
-	status = "okay";
-};
-
-&mcu_r5fss0_core0 {
-	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
-			<&mcu_r5fss0_core0_memory_region>;
-	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core0>;
-	status = "okay";
-};
-
-&mcu_r5fss0_core1 {
-	memory-region = <&mcu_r5fss0_core1_dma_memory_region>,
-			<&mcu_r5fss0_core1_memory_region>;
-	mboxes = <&mailbox0_cluster1 &mbox_mcu_r5fss0_core1>;
-	status = "okay";
-};
-
 &ospi0 {
 	status = "okay";
 	pinctrl-names = "default";
@@ -653,3 +597,5 @@ &dss {
 &wkup_gpio0 {
 	bootph-all;
 };
+
+#include "k3-am65-ti-ipc-firmware.dtsi"
-- 
2.34.1



Return-Path: <linux-kernel+bounces-806088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E82CEB491A7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD7B71B245BE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EF030F954;
	Mon,  8 Sep 2025 14:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IjcFm1Na"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A161F30F938;
	Mon,  8 Sep 2025 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341901; cv=none; b=NDOrQaEUEEAXtJp36wwT2iWLOenbEM64JXJrsZE/5ORx8Dvik4YxMNl2WTEqj0/JsAXGMvFogGzbpTlebXWrvOioDl+Sw2Mzje7HU22maViOd3vmsTY0vw/hpiBUsQUoSdSjeisTs3X6/qvXBuODHxwxmu/7V33UyW/jKgbjgNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341901; c=relaxed/simple;
	bh=e+frbV8iVyJj4q9h2e3zbt198W5glPK8qWzPVMkFpP4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AmcbYbYlvGzWNxoLqu/jOYrH3X4y7TI9T+1Yi/lbECH6zIuOTjNQAZkhjJOk/W8gZj07r/Nj8UMOuieC1mUXLC0m0yNOjFjHP59yL8/BjqDTNp5rOx7cCD7+KHFbH0qEfzCnVq1yw2i09c55Al2qwnIU+iW97SuhPt7OG+3/580=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IjcFm1Na; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 588EVVCi3811094;
	Mon, 8 Sep 2025 09:31:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757341891;
	bh=4u0lvHjlc8U/akjOeInsx86V+rcl7NsPZQywstkRW2I=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=IjcFm1NaNsZPlNdVHvgttM7ibIQnsmuVFvW4k7vfcsduYLn70SjMFCUiHJApxQtUE
	 J7nkylN7XTIf8AdwSJmeHa+90E7+ITi+dSq3LOnVIeDY/k6Gd/WPAvNIO0MIySZ4ke
	 fUra53o/B2TpTs3FDcaogB2wEQiPfLiI0nNBAQ00=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 588EVV6P3836106
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 09:31:31 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 09:31:30 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 09:31:30 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 588ESed91037553;
	Mon, 8 Sep 2025 09:31:26 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <d-gole@ti.com>, <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Wadim
 Egorov <w.egorov@phytec.de>
Subject: [PATCH v4 31/34] arm64: dts: ti: k3-am62-ti-ipc-firmware: Refactor IPC cfg into new dtsi
Date: Mon, 8 Sep 2025 19:58:23 +0530
Message-ID: <20250908142826.1828676-32-b-padhi@ti.com>
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

The TI K3 AM62 SoCs have multiple programmable remote processors like
R5F, M4F etc. The TI SDKs for AM62 SoCs offer sample firmwares which
could be run on these cores to demonstrate an "echo" IPC test. Those
firmware require certain memory carveouts to be reserved from system
memory, timers to be reserved, and certain mailbox configurations for
interrupt based messaging. These configurations could be different for a
different firmware.

While DT is not meant for system configurations, at least refactor these
configurations from board level DTS into a dtsi for now. This dtsi for
TI IPC firmware is board-independent and can be applied to all boards
from the same SoC Family. This gets rid of code duplication and allows
more freedom for users developing custom firmware (or no firmware) to
utilize system resources better; easily by swapping out this dtsi. To
maintain backward compatibility, the dtsi is included in all boards.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
Tested-by: Wadim Egorov <w.egorov@phytec.de> # phycore-am62x
Reviewed-by: Dhruva Gole <d-gole@ti.com>
---
v4: Changelog:
1. Updated node names to generic 'memory@addr'
2. Carried R/B tag.

Link to v3:
https://lore.kernel.org/all/20250905051846.1189612-31-b-padhi@ti.com/

v3: Changelog:
1. Changed memory node name to memory@addr. 
2. Carried R/B, T/B tags.

Link to v2:
https://lore.kernel.org/all/20250823160901.2177841-31-b-padhi@ti.com/

v2: Changelog:
1. Re-ordered patch from [PATCH 22/33] to [PATCH v2 30/33].

Link to v1:
https://lore.kernel.org/all/20250814223839.3256046-23-b-padhi@ti.com/

 .../boot/dts/ti/k3-am62-phycore-som.dtsi      | 44 +---------------
 .../boot/dts/ti/k3-am62-pocketbeagle2.dts     | 46 +---------------
 .../boot/dts/ti/k3-am62-ti-ipc-firmware.dtsi  | 52 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi    | 46 +---------------
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 46 +---------------
 5 files changed, 59 insertions(+), 175 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-ti-ipc-firmware.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
index 75b7e64f6659..eeca643fedbe 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
@@ -52,18 +52,6 @@ rtos_ipc_memory_region: memory@9c800000 {
 			no-map;
 		};
 
-		mcu_m4fss_dma_memory_region: memory@9cb00000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x9cb00000 0x00 0x100000>;
-			no-map;
-		};
-
-		mcu_m4fss_memory_region: memory@9cc00000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x9cc00000 0x00 0xe00000>;
-			no-map;
-		};
-
 		wkup_r5fss0_core0_dma_memory_region: memory@9da00000 {
 			compatible = "shared-dma-pool";
 			reg = <0x00 0x9da00000 0x00 0x100000>;
@@ -245,20 +233,6 @@ cpsw3g_phy1: ethernet-phy@1 {
 	};
 };
 
-&mailbox0_cluster0 {
-	status = "okay";
-
-	mbox_m4_0: mbox-m4-0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-
-	mbox_r5_0: mbox-r5-0 {
-		ti,mbox-rx = <2 0 0>;
-		ti,mbox-tx = <3 0 0>;
-	};
-};
-
 &main_pktdma {
 	bootph-all;
 };
@@ -364,13 +338,6 @@ i2c_som_rtc: rtc@52 {
 	};
 };
 
-&mcu_m4fss {
-	mboxes = <&mailbox0_cluster0 &mbox_m4_0>;
-	memory-region = <&mcu_m4fss_dma_memory_region>,
-			<&mcu_m4fss_memory_region>;
-	status = "okay";
-};
-
 &ospi0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&ospi0_pins_default>;
@@ -399,13 +366,4 @@ &sdhci0 {
 	status = "okay";
 };
 
-&wkup_r5fss0 {
-	status = "okay";
-};
-
-&wkup_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster0 &mbox_r5_0>;
-	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
-			<&wkup_r5fss0_core0_memory_region>;
-	status = "okay";
-};
+#include "k3-am62-ti-ipc-firmware.dtsi"
diff --git a/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts b/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts
index 621fb6c52db1..7a4cffc27bda 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts
@@ -54,18 +54,6 @@ linux,cma {
 			linux,cma-default;
 		};
 
-		mcu_m4fss_dma_memory_region: memory@9cb00000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x9cb00000 0x00 0x100000>;
-			no-map;
-		};
-
-		mcu_m4fss_memory_region: memory@9cc00000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x9cc00000 0x00 0xe00000>;
-			no-map;
-		};
-
 		secure_tfa_ddr: tfa@9e780000 {
 			reg = <0x00 0x9e780000 0x00 0x80000>;
 			alignment = <0x1000>;
@@ -298,20 +286,6 @@ &epwm2 {
 	pinctrl-0 = <&epwm2_pins_default>;
 };
 
-&mailbox0_cluster0 {
-	status = "okay";
-
-	mbox_m4_0: mbox-m4-0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-
-	mbox_r5_0: mbox-r5-0 {
-		ti,mbox-rx = <2 0 0>;
-		ti,mbox-tx = <3 0 0>;
-	};
-};
-
 &main_uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart0_pins_default>;
@@ -362,24 +336,6 @@ &main_i2c2 {
 	status = "okay";
 };
 
-&mcu_m4fss {
-	mboxes = <&mailbox0_cluster0 &mbox_m4_0>;
-	memory-region = <&mcu_m4fss_dma_memory_region>,
-			<&mcu_m4fss_memory_region>;
-	status = "okay";
-};
-
-&wkup_r5fss0 {
-	status = "okay";
-};
-
-&wkup_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster0 &mbox_r5_0>;
-	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
-			<&wkup_r5fss0_core0_memory_region>;
-	status = "okay";
-};
-
 &mcu_pmx0 {
 	wkup_uart0_pins_default: wkup-uart0-default-pins {
 		pinctrl-single,pins = <
@@ -543,3 +499,5 @@ ldo4_reg: ldo4 {
 		};
 	};
 };
+
+#include "k3-am62-ti-ipc-firmware.dtsi"
diff --git a/arch/arm64/boot/dts/ti/k3-am62-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-am62-ti-ipc-firmware.dtsi
new file mode 100644
index 000000000000..ea69fab9b52b
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62-ti-ipc-firmware.dtsi
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/**
+ * Device Tree Source for enabling IPC using TI SDK firmware on AM62 SoCs
+ *
+ * Copyright (C) 2021-2025 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+&reserved_memory {
+	mcu_m4fss_dma_memory_region: memory@9cb00000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0x9cb00000 0x00 0x100000>;
+		no-map;
+	};
+
+	mcu_m4fss_memory_region: memory@9cc00000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0x9cc00000 0x00 0xe00000>;
+		no-map;
+	};
+};
+
+&mailbox0_cluster0 {
+	status = "okay";
+
+	mbox_m4_0: mbox-m4-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+
+	mbox_r5_0: mbox-r5-0 {
+		ti,mbox-rx = <2 0 0>;
+		ti,mbox-tx = <3 0 0>;
+	};
+};
+
+&mcu_m4fss {
+	mboxes = <&mailbox0_cluster0 &mbox_m4_0>;
+	memory-region = <&mcu_m4fss_dma_memory_region>,
+			<&mcu_m4fss_memory_region>;
+	status = "okay";
+};
+
+&wkup_r5fss0 {
+	status = "okay";
+};
+
+&wkup_r5fss0_core0 {
+	mboxes = <&mailbox0_cluster0 &mbox_r5_0>;
+	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
+			<&wkup_r5fss0_core0_memory_region>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
index 5ecdd833587e..dc4b228a9fd7 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
@@ -206,18 +206,6 @@ secure_ddr: optee@9e800000 {
 			no-map;
 		};
 
-		mcu_m4fss_dma_memory_region: memory@9cb00000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x9cb00000 0x00 0x100000>;
-			no-map;
-		};
-
-		mcu_m4fss_memory_region: memory@9cc00000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x9cc00000 0x00 0xe00000>;
-			no-map;
-		};
-
 		wkup_r5fss0_core0_dma_memory_region: memory@9da00000 {
 			compatible = "shared-dma-pool";
 			reg = <0x00 0x9da00000 0x00 0x100000>;
@@ -1334,38 +1322,6 @@ &main_i2c3 {
 	status = "disabled";
 };
 
-&mailbox0_cluster0 {
-	status = "okay";
-
-	mbox_m4_0: mbox-m4-0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-
-	mbox_r5_0: mbox-r5-0 {
-		ti,mbox-rx = <2 0 0>;
-		ti,mbox-tx = <3 0 0>;
-	};
-};
-
-&mcu_m4fss {
-	mboxes = <&mailbox0_cluster0 &mbox_m4_0>;
-	memory-region = <&mcu_m4fss_dma_memory_region>,
-			<&mcu_m4fss_memory_region>;
-	status = "okay";
-};
-
-&wkup_r5fss0 {
-	status = "okay";
-};
-
-&wkup_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster0 &mbox_r5_0>;
-	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
-			<&wkup_r5fss0_core0_memory_region>;
-	status = "okay";
-};
-
 /* Verdin CAN_1 */
 &main_mcan0 {
 	pinctrl-names = "default";
@@ -1549,3 +1505,5 @@ &wkup_uart0 {
 	pinctrl-0 = <&pinctrl_wkup_uart0>;
 	status = "disabled";
 };
+
+#include "k3-am62-ti-ipc-firmware.dtsi"
diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index 05cba3cfc79e..241902fc1cf2 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -58,18 +58,6 @@ linux,cma {
 			linux,cma-default;
 		};
 
-		mcu_m4fss_dma_memory_region: memory@9cb00000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x9cb00000 0x00 0x100000>;
-			no-map;
-		};
-
-		mcu_m4fss_memory_region: memory@9cc00000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x9cc00000 0x00 0xe00000>;
-			no-map;
-		};
-
 		wkup_r5fss0_core0_dma_memory_region: memory@9da00000 {
 			compatible = "shared-dma-pool";
 			reg = <0x00 0x9da00000 0x00 0x100000>;
@@ -477,38 +465,6 @@ cpsw3g_phy0: ethernet-phy@0 {
 	};
 };
 
-&mailbox0_cluster0 {
-	status = "okay";
-
-	mbox_m4_0: mbox-m4-0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-
-	mbox_r5_0: mbox-r5-0 {
-		ti,mbox-rx = <2 0 0>;
-		ti,mbox-tx = <3 0 0>;
-	};
-};
-
-&mcu_m4fss {
-	mboxes = <&mailbox0_cluster0 &mbox_m4_0>;
-	memory-region = <&mcu_m4fss_dma_memory_region>,
-			<&mcu_m4fss_memory_region>;
-	status = "okay";
-};
-
-&wkup_r5fss0 {
-	status = "okay";
-};
-
-&wkup_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster0 &mbox_r5_0>;
-	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
-			<&wkup_r5fss0_core0_memory_region>;
-	status = "okay";
-};
-
 &usbss0 {
 	bootph-all;
 	status = "okay";
@@ -601,3 +557,5 @@ &epwm1 {
 	pinctrl-0 = <&main_epwm1_pins_default>;
 	status = "okay";
 };
+
+#include "k3-am62-ti-ipc-firmware.dtsi"
-- 
2.34.1



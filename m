Return-Path: <linux-kernel+bounces-802083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB13B44D77
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83E7F7BD4AB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 05:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B516A2E9ED4;
	Fri,  5 Sep 2025 05:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Phcet9x4"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E12272E51;
	Fri,  5 Sep 2025 05:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757049680; cv=none; b=UmfuZz/exhSsdYBDRkFY7JEKE/KKIG0t/8IVdXK+kYL4wVDc6uVkbHmsIygHV0d40+zDwIifzjhIFnhdptWmWEEWji+x9xvfdm+LIqRpFBjSPH9Ko23hxG6Rg/Ks8+z3E/+3/ABHkHnjm+e7xaw1sCakiWoxoXOw1k6g76B8wJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757049680; c=relaxed/simple;
	bh=2Sh4hPssa6S7VTwB7z1IIhBn+zZYhUtbVkp4Sjr17Us=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AM4g2KCtw9e72phye+u9Z7WATNAL/Umvjr2XQL+xyihKT4MBrEGb722l7Ali/3MBMgJzPOt0SuNq7xOLwnGl++RsBml1OR7jBS4xDOc3gjTG/LLrZFF3IL4m2XXgBsiOg0JBJwA7IETx4Bz/oyWV6uopMlXFzAOVKCTgUm5O2RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Phcet9x4; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5855LB913246656;
	Fri, 5 Sep 2025 00:21:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757049671;
	bh=7CcSBn1sieMh3wLMCvhjWJn/ZJZah8FAD6lzlnYyzRs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Phcet9x4fD5bzS3er92yxMJfWIu2Qx4e/8oUF5oge3XatyDL5CKC5jhH3RCFkuH84
	 GzdO6h5BU8sKOdwv0Mqjv11Hi2aJNXKPAoZcHJNi1cUmmnCvzm8ZcYxHOahtykapUg
	 tFIbv2boM0SfYMAEdW/Omv72NUXKQzW2vtZTcjXM=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5855LBTg1405980
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 5 Sep 2025 00:21:11 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 5
 Sep 2025 00:21:11 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 5 Sep 2025 00:21:10 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5855Ioix220581;
	Fri, 5 Sep 2025 00:21:07 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Wadim
 Egorov <w.egorov@phytec.de>
Subject: [PATCH v3 30/33] arm64: dts: ti: k3-am62-ti-ipc-firmware: Refactor IPC cfg into new dtsi
Date: Fri, 5 Sep 2025 10:48:43 +0530
Message-ID: <20250905051846.1189612-31-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250905051846.1189612-1-b-padhi@ti.com>
References: <20250905051846.1189612-1-b-padhi@ti.com>
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
---
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
index dcd22ff487ec..34b2e8d6bf80 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
@@ -52,18 +52,6 @@ rtos_ipc_memory_region: ipc-memories@9c800000 {
 			no-map;
 		};
 
-		mcu_m4fss_dma_memory_region: m4f-dma-memory@9cb00000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x9cb00000 0x00 0x100000>;
-			no-map;
-		};
-
-		mcu_m4fss_memory_region: m4f-memory@9cc00000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x9cc00000 0x00 0xe00000>;
-			no-map;
-		};
-
 		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9da00000 {
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
index 729901b2ca10..e634abe9e8e6 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts
@@ -54,18 +54,6 @@ linux,cma {
 			linux,cma-default;
 		};
 
-		mcu_m4fss_dma_memory_region: m4f-dma-memory@9cb00000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x9cb00000 0x00 0x100000>;
-			no-map;
-		};
-
-		mcu_m4fss_memory_region: m4f-memory@9cc00000 {
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
index 03b8e246d8c2..ec2685144558 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -58,18 +58,6 @@ linux,cma {
 			linux,cma-default;
 		};
 
-		mcu_m4fss_dma_memory_region: m4f-dma-memory@9cb00000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x9cb00000 0x00 0x100000>;
-			no-map;
-		};
-
-		mcu_m4fss_memory_region: m4f-memory@9cc00000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x9cc00000 0x00 0xe00000>;
-			no-map;
-		};
-
 		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9da00000 {
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



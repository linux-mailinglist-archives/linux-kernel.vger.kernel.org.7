Return-Path: <linux-kernel+bounces-769685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FF5B271E2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 00:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B035E2EEE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 22:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A1428506F;
	Thu, 14 Aug 2025 22:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LXagPES2"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6902D283C9C;
	Thu, 14 Aug 2025 22:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755211249; cv=none; b=dPSftmzzOZjB12n6Gp9PTmA7MIPDK4n19pKzZPfKqs3AOQyoxkqtt8nHmT9nvh6qkdkeU3k9q82oHWk/9b9h9pJwNe/Cpj1UuECqNlgfnmGsQG+kFPc6ElxiLpYt9cWVWm5IDjO7PjUtCWRtrRuGJkviIR2b8xrSr3ThUy5ttlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755211249; c=relaxed/simple;
	bh=Ag6bd9SQ6j8/9MIjt9jcOYZAcAFeCO/kozGCLeqJ6vQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TXnP9JOm7lckNnu6dSGW5WTCJtrGz2x2vr4L+fIobghlqQGoRGrliKErAR6YZLSL/Le7DWrP9g3xT/KwZhbtIT4illM5bCUg++Gr5NZosTJd/nHxi1Va63P4xAHc9VAgyWMdhVIIcyIrMzx+M7NTt2ncU63sLsvlt2w+9d/swao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LXagPES2; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57EMegdU1973625;
	Thu, 14 Aug 2025 17:40:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755211242;
	bh=eYmhEZDQT25jxtSnN0KjXmL0EKzlbtcSsh/plF6dlV8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=LXagPES2/cqpzMkQvOk0WxKzke02EVyBwDeY+QigdksFR80MtGEEc+rW9QqffroJY
	 woDUTkdNjbRPU009Zzi5WhAiflhko94+UBq9An1ieatPsovHLHf+K/cb1/7Vni0k68
	 fLxIG1yL632cEAoxoguHOXiHdSJVuylXB1P//7TI=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57EMegrZ2016225
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 14 Aug 2025 17:40:42 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 14
 Aug 2025 17:40:42 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 14 Aug 2025 17:40:42 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57EMcw4v096792;
	Thu, 14 Aug 2025 17:40:38 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 22/33] arm64: dts: ti: k3-am62-ti-ipc-firmware: Refactor IPC cfg into new dtsi
Date: Fri, 15 Aug 2025 04:08:28 +0530
Message-ID: <20250814223839.3256046-23-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250814223839.3256046-1-b-padhi@ti.com>
References: <20250814223839.3256046-1-b-padhi@ti.com>
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
---
 .../boot/dts/ti/k3-am62-phycore-som.dtsi      | 44 +---------------
 .../boot/dts/ti/k3-am62-pocketbeagle2.dts     | 45 +---------------
 .../boot/dts/ti/k3-am62-ti-ipc-firmware.dtsi  | 52 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi    | 33 +-----------
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 46 +---------------
 5 files changed, 59 insertions(+), 161 deletions(-)
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
index 2140e0cdec85..e634abe9e8e6 100644
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
@@ -298,19 +286,6 @@ &epwm2 {
 	pinctrl-0 = <&epwm2_pins_default>;
 };
 
-&mailbox0_cluster0 {
-	status = "okay";
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
@@ -361,24 +336,6 @@ &main_i2c2 {
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
@@ -542,3 +499,5 @@ ldo4_reg: ldo4 {
 		};
 	};
 };
+
+#include "k3-am62-ti-ipc-firmware.dtsi"
diff --git a/arch/arm64/boot/dts/ti/k3-am62-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-am62-ti-ipc-firmware.dtsi
new file mode 100644
index 000000000000..9376ae91a17f
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
+	mcu_m4fss_dma_memory_region: m4f-dma-memory@9cb00000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0x9cb00000 0x00 0x100000>;
+		no-map;
+	};
+
+	mcu_m4fss_memory_region: m4f-memory@9cc00000 {
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
index 1c44d17281dd..fd83dbc9f37b 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
@@ -1334,37 +1334,6 @@ &main_i2c3 {
 	status = "disabled";
 };
 
-&mailbox0_cluster0 {
-	status = "okay";
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
@@ -1548,3 +1517,5 @@ &wkup_uart0 {
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



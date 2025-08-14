Return-Path: <linux-kernel+bounces-769689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDBCB271E9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 00:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1A7D1CC7283
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 22:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F12283FD7;
	Thu, 14 Aug 2025 22:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hjSIhFwn"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F3129344F;
	Thu, 14 Aug 2025 22:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755211265; cv=none; b=uoxZYjQ1Jm2SXYvNd3fhP7TdbkRqNYa/ZJ3U+e3m/cVK0UyxfoFQ4kzCrmwSvMcYLNqPziWA7YvXhY5N+vJ8ZeyTTluHwXRcYRE/U2nXNpwfQ9K3C84TZdJDNjEoRBs26q+HRsH4fH9bu26HJIOvlvThxqsynWobrDDZNcVeQoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755211265; c=relaxed/simple;
	bh=hr/p770CPoGB86T5qDisH5Iwou0rdXW0R7BDy7/7QJo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CsnE9EnBZZotg4C5so/Zdd29BXPz4JEBUqaJZLVVcPRGircWWHBRCXXMbCHMNCq4poD/hHJmYZFUE3rUOS4aFf1KJWtG66zt1iDsd+C//a7HNHCH6KtWx9bwFHzC0NkY5qqEI4p0kHTxZhIm9vmGgB+e5p6YPrC5uAHQef/NDeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hjSIhFwn; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57EMetG32398923;
	Thu, 14 Aug 2025 17:40:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755211255;
	bh=lrtZVHXvikV585jAU8gZqXCPJEkYirYWV0WQ/ujMm20=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=hjSIhFwnlZ7mSFSxD/V8bArY81Z0KFyyFyQNUzmSjsSTiGEoFKhbV8yZcsWsTwZxq
	 ezO0qU1fPAaX1s9fbEWhX8n2lQWE+oa1CKDJ3PTwI6OQcyGJMqN/7g+y8XO1IAoN6C
	 be0KGfYqdOoRE/KC/sQlJC3XHaGbRfqQ7ClsFhoE=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57EMetC42016403
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 14 Aug 2025 17:40:55 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 14
 Aug 2025 17:40:54 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 14 Aug 2025 17:40:54 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57EMcw50096792;
	Thu, 14 Aug 2025 17:40:51 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 25/33] arm64: dts: ti: k3-am62a-ti-ipc-firmware: Refactor IPC cfg into new dtsi
Date: Fri, 15 Aug 2025 04:08:31 +0530
Message-ID: <20250814223839.3256046-26-b-padhi@ti.com>
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

The TI K3 AM62A SoCs have multiple programmable remote processors like
R5F, C7x etc. The TI SDKs for AM62A SoCs offer sample firmwares which
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
 .../boot/dts/ti/k3-am62a-phycore-som.dtsi     | 90 +----------------
 .../boot/dts/ti/k3-am62a-ti-ipc-firmware.dtsi | 98 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts       | 92 +----------------
 arch/arm64/boot/dts/ti/k3-am62d2-evm.dts      | 76 +-------------
 4 files changed, 102 insertions(+), 254 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a-ti-ipc-firmware.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi
index 3108e9b0c804..44c73ed637da 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi
@@ -59,30 +59,6 @@ linux,cma {
 			linux,cma-default;
 		};
 
-		c7x_0_dma_memory_region: c7x-dma-memory@99800000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x99800000 0x00 0x100000>;
-			no-map;
-		};
-
-		c7x_0_memory_region: c7x-memory@99900000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x99900000 0x00 0xf00000>;
-			no-map;
-		};
-
-		mcu_r5fss0_core0_dma_memory_region: r5f-dma-memory@9b800000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x9b800000 0x00 0x100000>;
-			no-map;
-		};
-
-		mcu_r5fss0_core0_memory_region: r5f-dma-memory@9b900000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x9b900000 0x00 0xf00000>;
-			no-map;
-		};
-
 		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9c800000 {
 			compatible = "shared-dma-pool";
 			reg = <0x00 0x9c800000 0x00 0x100000>;
@@ -209,13 +185,6 @@ opp-1400000000 {
 	};
 };
 
-&c7x_0 {
-	mboxes = <&mailbox0_cluster1 &mbox_c7x_0>;
-	memory-region = <&c7x_0_dma_memory_region>,
-			<&c7x_0_memory_region>;
-	status = "okay";
-};
-
 &cpsw3g {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_rgmii1_pins_default>;
@@ -246,33 +215,6 @@ &fss {
 	status = "okay";
 };
 
-&mailbox0_cluster0 {
-	status = "okay";
-
-	mbox_r5_0: mbox-r5-0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-};
-
-&mailbox0_cluster1 {
-	status = "okay";
-
-	mbox_c7x_0: mbox-c7x-0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-};
-
-&mailbox0_cluster2 {
-	status = "okay";
-
-	mbox_mcu_r5_0: mbox-mcu-r5-0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-};
-
 &main_i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c0_pins_default>;
@@ -388,27 +330,6 @@ &main_pktdma {
 	bootph-all;
 };
 
-/* main_rti4 is used by C7x DSP */
-&main_rti4 {
-	status = "reserved";
-};
-
-/* main_timer2 is used by C7x DSP */
-&main_timer2 {
-	status = "reserved";
-};
-
-&mcu_r5fss0 {
-	status = "okay";
-};
-
-&mcu_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster2 &mbox_mcu_r5_0>;
-	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
-			<&mcu_r5fss0_core0_memory_region>;
-	status = "okay";
-};
-
 &ospi0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&ospi0_pins_default>;
@@ -437,13 +358,4 @@ &sdhci0 {
 	status = "okay";
 };
 
-&wkup_r5fss0 {
-	status = "okay";
-};
-
-&wkup_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster0  &mbox_r5_0>;
-	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
-			<&wkup_r5fss0_core0_memory_region>;
-	status = "okay";
-};
+#include "k3-am62a-ti-ipc-firmware.dtsi"
diff --git a/arch/arm64/boot/dts/ti/k3-am62a-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-ti-ipc-firmware.dtsi
new file mode 100644
index 000000000000..91583cd23b12
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62a-ti-ipc-firmware.dtsi
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/**
+ * Device Tree Source for enabling IPC using TI SDK firmware on AM62A SoCs
+ *
+ * Copyright (C) 2022-2025 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+&reserved_memory {
+	c7x_0_dma_memory_region: c7x-dma-memory@99800000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0x99800000 0x00 0x100000>;
+		no-map;
+	};
+
+	c7x_0_memory_region: c7x-memory@99900000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0x99900000 0x00 0xf00000>;
+		no-map;
+	};
+
+	mcu_r5fss0_core0_dma_memory_region: r5f-dma-memory@9b800000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0x9b800000 0x00 0x100000>;
+		no-map;
+	};
+
+	mcu_r5fss0_core0_memory_region: r5f-dma-memory@9b900000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0x9b900000 0x00 0xf00000>;
+		no-map;
+	};
+};
+
+&mailbox0_cluster0 {
+	status = "okay";
+
+	mbox_r5_0: mbox-r5-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+};
+
+&mailbox0_cluster1 {
+	status = "okay";
+
+	mbox_c7x_0: mbox-c7x-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+};
+
+&mailbox0_cluster2 {
+	status = "okay";
+
+	mbox_mcu_r5_0: mbox-mcu-r5-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+};
+
+&wkup_r5fss0 {
+	status = "okay";
+};
+
+&wkup_r5fss0_core0 {
+	mboxes = <&mailbox0_cluster0>, <&mbox_r5_0>;
+	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
+			<&wkup_r5fss0_core0_memory_region>;
+	status = "okay";
+};
+
+&mcu_r5fss0 {
+	status = "okay";
+};
+
+&mcu_r5fss0_core0 {
+	mboxes = <&mailbox0_cluster2>, <&mbox_mcu_r5_0>;
+	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
+			<&mcu_r5fss0_core0_memory_region>;
+	status = "okay";
+};
+
+&c7x_0 {
+	mboxes = <&mailbox0_cluster1>, <&mbox_c7x_0>;
+	memory-region = <&c7x_0_dma_memory_region>,
+			<&c7x_0_memory_region>;
+	status = "okay";
+};
+
+/* main_rti4 is used by C7x DSP */
+&main_rti4 {
+	status = "reserved";
+};
+
+/* main_timer2 is used by C7x DSP */
+&main_timer2 {
+	status = "reserved";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index 7ebcfe8edfe1..ede03f449d65 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -53,30 +53,6 @@ linux,cma {
 			linux,cma-default;
 		};
 
-		c7x_0_dma_memory_region: c7x-dma-memory@99800000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x99800000 0x00 0x100000>;
-			no-map;
-		};
-
-		c7x_0_memory_region: c7x-memory@99900000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x99900000 0x00 0xf00000>;
-			no-map;
-		};
-
-		mcu_r5fss0_core0_dma_memory_region: r5f-dma-memory@9b800000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x9b800000 0x00 0x100000>;
-			no-map;
-		};
-
-		mcu_r5fss0_core0_memory_region: r5f-dma-memory@9b900000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x9b900000 0x00 0xf00000>;
-			no-map;
-		};
-
 		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9c800000 {
 			compatible = "shared-dma-pool";
 			reg = <0x00 0x9c800000 0x00 0x100000>;
@@ -713,11 +689,6 @@ &main_uart1 {
 	status = "reserved";
 };
 
-/* main_timer2 is used by C7x DSP */
-&main_timer2 {
-	status = "reserved";
-};
-
 &usbss0 {
 	status = "okay";
 	ti,vbus-divider;
@@ -835,67 +806,6 @@ &epwm1 {
 	status = "okay";
 };
 
-&mailbox0_cluster0 {
-	status = "okay";
-
-	mbox_r5_0: mbox-r5-0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-};
-
-&mailbox0_cluster1 {
-	status = "okay";
-
-	mbox_c7x_0: mbox-c7x-0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-};
-
-&mailbox0_cluster2 {
-	status = "okay";
-
-	mbox_mcu_r5_0: mbox-mcu-r5-0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-};
-
-&wkup_r5fss0 {
-	status = "okay";
-};
-
-&wkup_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster0>, <&mbox_r5_0>;
-	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
-			<&wkup_r5fss0_core0_memory_region>;
-	status = "okay";
-};
-
-&mcu_r5fss0 {
-	status = "okay";
-};
-
-&mcu_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster2>, <&mbox_mcu_r5_0>;
-	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
-			<&mcu_r5fss0_core0_memory_region>;
-	status = "okay";
-};
-
-&c7x_0 {
-	mboxes = <&mailbox0_cluster1>, <&mbox_c7x_0>;
-	memory-region = <&c7x_0_dma_memory_region>,
-			<&c7x_0_memory_region>;
-	status = "okay";
-};
-
-/* main_rti4 is used by C7x DSP */
-&main_rti4 {
-	status = "reserved";
-};
-
 &fss {
 	status = "okay";
 };
@@ -937,3 +847,5 @@ AM62AX_IOPAD(0x008, PIN_INPUT, 0) /* (J24) OSPI0_DQS */
 		>;
 	};
 };
+
+#include "k3-am62a-ti-ipc-firmware.dtsi"
diff --git a/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts b/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
index 41860ac42f3c..a57fc2362dfd 100644
--- a/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
@@ -58,30 +58,6 @@ secure_tfa_ddr: tfa@80000000 {
 			no-map;
 		};
 
-		c7x_0_dma_memory_region: c7x-dma-memory@99800000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x99800000 0x00 0x100000>;
-			no-map;
-		};
-
-		c7x_0_memory_region: c7x-memory@99900000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x99900000 0x00 0xf00000>;
-			no-map;
-		};
-
-		mcu_r5fss0_core0_dma_memory_region: r5f-dma-memory@9b800000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x9b800000 0x00 0x100000>;
-			no-map;
-		};
-
-		mcu_r5fss0_core0_memory_region: r5f-dma-memory@9b900000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x9b900000 0x00 0xf00000>;
-			no-map;
-		};
-
 		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9c800000 {
 			compatible = "shared-dma-pool";
 			reg = <0x00 0x9c800000 0x00 0x100000>;
@@ -551,66 +527,16 @@ cpsw3g_phy1: ethernet-phy@3 {
 	};
 };
 
-&mailbox0_cluster0 {
-	status = "okay";
-
-	mbox_r5_0: mbox-r5-0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-};
-
-&mailbox0_cluster1 {
-	status = "okay";
-
-	mbox_c7x_0: mbox-c7x-0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-};
-
-&mailbox0_cluster2 {
-	status = "okay";
-
-	mbox_mcu_r5_0: mbox-mcu-r5-0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-};
-
-&wkup_r5fss0 {
-	status = "okay";
-};
-
 &wkup_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster0 &mbox_r5_0>;
-	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
-			<&wkup_r5fss0_core0_memory_region>;
-	status = "okay";
 	bootph-pre-ram;
 };
 
-&mcu_r5fss0 {
-	status = "okay";
-};
-
 &mcu_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster2 &mbox_mcu_r5_0>;
-	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
-			<&mcu_r5fss0_core0_memory_region>;
 	firmware-name = "am62d-mcu-r5f0_0-fw";
-	status = "okay";
 };
 
 &c7x_0 {
-	mboxes = <&mailbox0_cluster1 &mbox_c7x_0>;
-	memory-region = <&c7x_0_dma_memory_region>,
-			<&c7x_0_memory_region>;
 	firmware-name = "am62d-c71_0-fw";
-	status = "okay";
 };
 
-/* main_rti4 is used by C7x DSP */
-&main_rti4 {
-	status = "reserved";
-};
+#include "k3-am62a-ti-ipc-firmware.dtsi"
-- 
2.34.1



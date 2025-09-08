Return-Path: <linux-kernel+bounces-806089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6A5B491BA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99BC316FD69
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE97030F958;
	Mon,  8 Sep 2025 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sO3lQ6dl"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA85E30AD1A;
	Mon,  8 Sep 2025 14:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341902; cv=none; b=oynuj5hxVCs83BloEe6vPKvxcHPe4rwidU92hMsN3r2r2EiYC6947eReZkoPOVG/5MO904DamOmJ1Cmre+OSM2++RdAOUKjnpxZ0YHnbFIxZ1J3OKgQv3V825yQr4zbHHeuCcutV8AgyU0MSCUI0hf3Od2D5xxjJRav2bkzxOxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341902; c=relaxed/simple;
	bh=XYqRJ9ygW/4IvrPV0U+yiDiicxUChlvPs8gSnG1OqwE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DwCw+Hr57CMikhaND33W6QkcjXeoTcX5piieQ0VFn6aBC3jIhBxtMrc1mKPSBxgfT5xToDqNK1G4HUBbXxHKvSPvzeZP6Z6+N/Rw3apxkaac1l1SWMs+BFQWi15pJ/E4mOttmZg2Goyv9gWPAknJSxE+kruAqpUpvui4CNCzfik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sO3lQ6dl; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 588EVZPI072058;
	Mon, 8 Sep 2025 09:31:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757341896;
	bh=ss6K1t9MZnVM3gGsKbFVajXPZjSX/r2LbzvJd/Ytpnk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=sO3lQ6dl6pXNl2oxVvVXGZzjyLsryoHTpZOgrWo6UH2HF84W6g/u95EQVc770+S8a
	 /VAE6s+ky7STb4cFzWVNsA4tIZ6u0ocVKC+UYsWZGoHB8hGMp95NG2ZNgec9zD2qm2
	 pbD/p2nWVskEyyDr/w3c+RJxl4oRLfjJdTKrPwKI=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 588EVZTi2466622
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 09:31:35 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 09:31:35 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 09:31:35 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 588ESedA1037553;
	Mon, 8 Sep 2025 09:31:31 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <d-gole@ti.com>, <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 32/34] arm64: dts: ti: k3-am62a-ti-ipc-firmware: Refactor IPC cfg into new dtsi
Date: Mon, 8 Sep 2025 19:58:24 +0530
Message-ID: <20250908142826.1828676-33-b-padhi@ti.com>
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
Tested-by: Judith Mendez <jm@ti.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
---
v4: Changelog:
1. Updated node names to generic 'memory@addr'
2. Carried R/B tag.

Link to v3:
https://lore.kernel.org/all/20250905051846.1189612-32-b-padhi@ti.com/

v3: Changelog:
1. Carried T/B tag.

Link to v2:
https://lore.kernel.org/all/20250823160901.2177841-32-b-padhi@ti.com/

v2: Changelog:
1. Re-ordered patch from [PATCH 25/33] to [PATCH v2 31/33].

Link to v1:
https://lore.kernel.org/all/20250814223839.3256046-26-b-padhi@ti.com/

 .../boot/dts/ti/k3-am62a-phycore-som.dtsi     | 90 +----------------
 .../boot/dts/ti/k3-am62a-ti-ipc-firmware.dtsi | 98 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts       | 92 +----------------
 arch/arm64/boot/dts/ti/k3-am62d2-evm.dts      | 76 +-------------
 4 files changed, 102 insertions(+), 254 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a-ti-ipc-firmware.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi
index 0406a43ff704..b3d012a5a26a 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi
@@ -59,30 +59,6 @@ linux,cma {
 			linux,cma-default;
 		};
 
-		c7x_0_dma_memory_region: memory@99800000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x99800000 0x00 0x100000>;
-			no-map;
-		};
-
-		c7x_0_memory_region: memory@99900000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x99900000 0x00 0xf00000>;
-			no-map;
-		};
-
-		mcu_r5fss0_core0_dma_memory_region: memory@9b800000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x9b800000 0x00 0x100000>;
-			no-map;
-		};
-
-		mcu_r5fss0_core0_memory_region: memory@9b900000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x9b900000 0x00 0xf00000>;
-			no-map;
-		};
-
 		wkup_r5fss0_core0_dma_memory_region: memory@9c800000 {
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
index 000000000000..950f4f37d477
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
+	c7x_0_dma_memory_region: memory@99800000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0x99800000 0x00 0x100000>;
+		no-map;
+	};
+
+	c7x_0_memory_region: memory@99900000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0x99900000 0x00 0xf00000>;
+		no-map;
+	};
+
+	mcu_r5fss0_core0_dma_memory_region: memory@9b800000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0x9b800000 0x00 0x100000>;
+		no-map;
+	};
+
+	mcu_r5fss0_core0_memory_region: memory@9b900000 {
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
index 312bdab28784..9f148b89e74d 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -53,30 +53,6 @@ linux,cma {
 			linux,cma-default;
 		};
 
-		c7x_0_dma_memory_region: memory@99800000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x99800000 0x00 0x100000>;
-			no-map;
-		};
-
-		c7x_0_memory_region: memory@99900000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x99900000 0x00 0xf00000>;
-			no-map;
-		};
-
-		mcu_r5fss0_core0_dma_memory_region: memory@9b800000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x9b800000 0x00 0x100000>;
-			no-map;
-		};
-
-		mcu_r5fss0_core0_memory_region: memory@9b900000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x9b900000 0x00 0xf00000>;
-			no-map;
-		};
-
 		wkup_r5fss0_core0_dma_memory_region: memory@9c800000 {
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
index 289f52b3481f..c958a1c4a657 100644
--- a/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
@@ -58,30 +58,6 @@ secure_tfa_ddr: tfa@80000000 {
 			no-map;
 		};
 
-		c7x_0_dma_memory_region: memory@99800000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x99800000 0x00 0x100000>;
-			no-map;
-		};
-
-		c7x_0_memory_region: memory@99900000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x99900000 0x00 0xf00000>;
-			no-map;
-		};
-
-		mcu_r5fss0_core0_dma_memory_region: memory@9b800000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x9b800000 0x00 0x100000>;
-			no-map;
-		};
-
-		mcu_r5fss0_core0_memory_region: memory@9b900000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x9b900000 0x00 0xf00000>;
-			no-map;
-		};
-
 		wkup_r5fss0_core0_dma_memory_region: memory@9c800000 {
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



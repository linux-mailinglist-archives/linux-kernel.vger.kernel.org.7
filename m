Return-Path: <linux-kernel+bounces-806086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FACB491AC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D84D33A8FC4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85882312832;
	Mon,  8 Sep 2025 14:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="c30Pbq03"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5724F3126DF;
	Mon,  8 Sep 2025 14:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341888; cv=none; b=bV84PAj0jRJVXT4HBTxAl/PiTm6aMXW5KSYNTV1su7WO6MBd73Sj06TqSQkYXY2RTmcA/fCcxU35+XXUGNtnhmVxG12z4hlsgrhEOojE9XVSHG3U/wHNOYKPqVcCiZV652fl/+lJoLp9/RrAgvUwli9Y1cv/ClgUvLNE6fdJ2eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341888; c=relaxed/simple;
	bh=EbP/EDxbxW/yL5c49HlPmvlMzF6hYl6nbUGwamDdGRI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HU792jH8GDEAs+9uRORv2JqYtCxF2gIBMvfsttjaNvr+9nEwlgZiStbH02HU4S7di0juyEHj+5OTsmGsLXHoERVardJHqgkejI8FMjCVZac/sv8Nlu3Zj+BlfRgAMfuui5nZA40bCbmc7syXIugvPvQPaQq/ih/UZFzkYZvX9Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=c30Pbq03; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 588EVLl43883869;
	Mon, 8 Sep 2025 09:31:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757341881;
	bh=ypxEjmrC0aBdHW5CEUp/mGXA9KkOvP+qMxKK2a+5ktA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=c30Pbq03kxMX/uuSO0I9rM95cwigBQR/CGCKmxY93oPgvcSCTIPTiRJXtNFBrVT/D
	 GkhkEzjwc5PKreJ/5W4gQmeT72xwldfHwh0/Jav9604dYqLed20cOxb+Tpjj4sBz0r
	 8OOl0uuvz93Lfb4CeXb2VC9d0stUFoyGB5s3cj6U=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 588EVLL83836029
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 09:31:21 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 09:31:21 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 09:31:21 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 588ESed71037553;
	Mon, 8 Sep 2025 09:31:16 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <d-gole@ti.com>, <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 29/34] arm64: dts: ti: k3-j722s-ti-ipc-firmware: Refactor IPC cfg into new dtsi
Date: Mon, 8 Sep 2025 19:58:21 +0530
Message-ID: <20250908142826.1828676-30-b-padhi@ti.com>
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

The TI K3 J722S SoCs have multiple programmable remote processors like
R5F, C7x etc. The TI SDKs for J722S SoCs offer sample firmwares which
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
v4: Changelog:
1. Updated carveout node names to 'memory@addr'

Link to v3:
https://lore.kernel.org/all/20250905051846.1189612-29-b-padhi@ti.com/

v3: Changelog:
1. None

Link to v2:
https://lore.kernel.org/all/20250823160901.2177841-29-b-padhi@ti.com/

v2: Changelog:
1. Re-ordered patch from [PATCH 14/33] to [PATCH v2 28/33].

Link to v1:
https://lore.kernel.org/all/20250814223839.3256046-15-b-padhi@ti.com/

 .../arm64/boot/dts/ti/k3-am67a-beagley-ai.dts | 155 +----------------
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts       | 157 +----------------
 .../boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi | 163 ++++++++++++++++++
 3 files changed, 166 insertions(+), 309 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts b/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts
index 85436ea5b4e7..b697035df04e 100644
--- a/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts
+++ b/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts
@@ -61,60 +61,6 @@ wkup_r5fss0_core0_memory_region: memory@a0100000 {
 			reg = <0x00 0xa0100000 0x00 0xf00000>;
 			no-map;
 		};
-
-		mcu_r5fss0_core0_dma_memory_region: memory@a1000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa1000000 0x00 0x100000>;
-			no-map;
-		};
-
-		mcu_r5fss0_core0_memory_region: memory@a1100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa1100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		main_r5fss0_core0_dma_memory_region: memory@a2000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa2000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss0_core0_memory_region: memory@a2100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa2100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		c7x_0_dma_memory_region: memory@a3000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa3000000 0x00 0x100000>;
-			no-map;
-		};
-
-		c7x_0_memory_region: memory@a3100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa3100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		c7x_1_dma_memory_region: memory@a4000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa4000000 0x00 0x100000>;
-			no-map;
-		};
-
-		c7x_1_memory_region: memory@a4100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa4100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		rtos_ipc_memory_region: memory@a5000000 {
-			reg = <0x00 0xa5000000 0x00 0x1c00000>;
-			alignment = <0x1000>;
-			no-map;
-		};
 	};
 
 	vsys_5v0: regulator-1 {
@@ -453,103 +399,4 @@ &sdhci1 {
 	status = "okay";
 };
 
-&mailbox0_cluster0 {
-	status = "okay";
-
-	mbox_wkup_r5_0: mbox-wkup-r5-0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-};
-
-&mailbox0_cluster1 {
-	status = "okay";
-
-	mbox_mcu_r5_0: mbox-mcu-r5-0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-};
-
-&mailbox0_cluster2 {
-	status = "okay";
-
-	mbox_c7x_0: mbox-c7x-0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-};
-
-&mailbox0_cluster3 {
-	status = "okay";
-
-	mbox_main_r5_0: mbox-main-r5-0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-
-	mbox_c7x_1: mbox-c7x-1 {
-		ti,mbox-rx = <2 0 0>;
-		ti,mbox-tx = <3 0 0>;
-	};
-};
-
-/* Timers are used by Remoteproc firmware */
-&main_timer0 {
-	status = "reserved";
-};
-
-&main_timer1 {
-	status = "reserved";
-};
-
-&main_timer2 {
-	status = "reserved";
-};
-
-&wkup_r5fss0 {
-	status = "okay";
-};
-
-&wkup_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster0 &mbox_wkup_r5_0>;
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
-	mboxes = <&mailbox0_cluster1 &mbox_mcu_r5_0>;
-	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
-			<&mcu_r5fss0_core0_memory_region>;
-	status = "okay";
-};
-
-&main_r5fss0 {
-	status = "okay";
-};
-
-&main_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster3 &mbox_main_r5_0>;
-	memory-region = <&main_r5fss0_core0_dma_memory_region>,
-			<&main_r5fss0_core0_memory_region>;
-	status = "okay";
-};
-
-&c7x_0 {
-	mboxes = <&mailbox0_cluster2 &mbox_c7x_0>;
-	memory-region = <&c7x_0_dma_memory_region>,
-			<&c7x_0_memory_region>;
-	status = "okay";
-};
-
-&c7x_1 {
-	mboxes = <&mailbox0_cluster3 &mbox_c7x_1>;
-	memory-region = <&c7x_1_dma_memory_region>,
-			<&c7x_1_memory_region>;
-	status = "okay";
-};
+#include "k3-j722s-ti-ipc-firmware.dtsi"
diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index d323284a30ab..a9b5d9a06241 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -63,60 +63,6 @@ wkup_r5fss0_core0_memory_region: memory@a0100000 {
 			reg = <0x00 0xa0100000 0x00 0xf00000>;
 			no-map;
 		};
-
-		mcu_r5fss0_core0_dma_memory_region: memory@a1000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa1000000 0x00 0x100000>;
-			no-map;
-		};
-
-		mcu_r5fss0_core0_memory_region: memory@a1100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa1100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		main_r5fss0_core0_dma_memory_region: memory@a2000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa2000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss0_core0_memory_region: memory@a2100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa2100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		c7x_0_dma_memory_region: memory@a3000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa3000000 0x00 0x100000>;
-			no-map;
-		};
-
-		c7x_0_memory_region: memory@a3100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa3100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		c7x_1_dma_memory_region: memory@a4000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa4000000 0x00 0x100000>;
-			no-map;
-		};
-
-		c7x_1_memory_region: memory@a4100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa4100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		rtos_ipc_memory_region: memory@a5000000 {
-			reg = <0x00 0xa5000000 0x00 0x1c00000>;
-			alignment = <0x1000>;
-			no-map;
-		};
 	};
 
 	vmain_pd: regulator-0 {
@@ -788,107 +734,6 @@ &sdhci1 {
 	bootph-all;
 };
 
-&mailbox0_cluster0 {
-	status = "okay";
-
-	mbox_wkup_r5_0: mbox-wkup-r5-0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-};
-
-&mailbox0_cluster1 {
-	status = "okay";
-
-	mbox_mcu_r5_0: mbox-mcu-r5-0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-};
-
-&mailbox0_cluster2 {
-	status = "okay";
-
-	mbox_c7x_0: mbox-c7x-0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-};
-
-&mailbox0_cluster3 {
-	status = "okay";
-
-	mbox_main_r5_0: mbox-main-r5-0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-
-	mbox_c7x_1: mbox-c7x-1 {
-		ti,mbox-rx = <2 0 0>;
-		ti,mbox-tx = <3 0 0>;
-	};
-};
-
-/* Timers are used by Remoteproc firmware */
-&main_timer0 {
-	status = "reserved";
-};
-
-&main_timer1 {
-	status = "reserved";
-};
-
-&main_timer2 {
-	status = "reserved";
-};
-
-&wkup_r5fss0 {
-	status = "okay";
-};
-
-&wkup_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster0 &mbox_wkup_r5_0>;
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
-	mboxes = <&mailbox0_cluster1 &mbox_mcu_r5_0>;
-	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
-			<&mcu_r5fss0_core0_memory_region>;
-	status = "okay";
-};
-
-&main_r5fss0 {
-	status = "okay";
-};
-
-&main_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster3 &mbox_main_r5_0>;
-	memory-region = <&main_r5fss0_core0_dma_memory_region>,
-			<&main_r5fss0_core0_memory_region>;
-	status = "okay";
-};
-
-&c7x_0 {
-	mboxes = <&mailbox0_cluster2 &mbox_c7x_0>;
-	memory-region = <&c7x_0_dma_memory_region>,
-			<&c7x_0_memory_region>;
-	status = "okay";
-};
-
-&c7x_1 {
-	mboxes = <&mailbox0_cluster3 &mbox_c7x_1>;
-	memory-region = <&c7x_1_dma_memory_region>,
-			<&c7x_1_memory_region>;
-	status = "okay";
-};
-
 &serdes_ln_ctrl {
 	idle-states = <J722S_SERDES0_LANE0_USB>,
 		      <J722S_SERDES1_LANE0_PCIE0_LANE0>;
@@ -999,3 +844,5 @@ &mcu_i2c0 {
 	clock-frequency = <400000>;
 	status = "okay";
 };
+
+#include "k3-j722s-ti-ipc-firmware.dtsi"
diff --git a/arch/arm64/boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi
new file mode 100644
index 000000000000..cb7cd385a165
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j722s-ti-ipc-firmware.dtsi
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/**
+ * Device Tree Source for enabling IPC using TI SDK firmware on J722S SoCs
+ *
+ * Copyright (C) 2024-2025 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+&reserved_memory {
+	mcu_r5fss0_core0_dma_memory_region: memory@a1000000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa1000000 0x00 0x100000>;
+		no-map;
+	};
+
+	mcu_r5fss0_core0_memory_region: memory@a1100000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa1100000 0x00 0xf00000>;
+		no-map;
+	};
+
+	main_r5fss0_core0_dma_memory_region: memory@a2000000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa2000000 0x00 0x100000>;
+		no-map;
+	};
+
+	main_r5fss0_core0_memory_region: memory@a2100000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa2100000 0x00 0xf00000>;
+		no-map;
+	};
+
+	c7x_0_dma_memory_region: memory@a3000000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa3000000 0x00 0x100000>;
+		no-map;
+	};
+
+	c7x_0_memory_region: memory@a3100000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa3100000 0x00 0xf00000>;
+		no-map;
+	};
+
+	c7x_1_dma_memory_region: memory@a4000000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa4000000 0x00 0x100000>;
+		no-map;
+	};
+
+	c7x_1_memory_region: memory@a4100000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa4100000 0x00 0xf00000>;
+		no-map;
+	};
+
+	rtos_ipc_memory_region: memory@a5000000 {
+		reg = <0x00 0xa5000000 0x00 0x1c00000>;
+		alignment = <0x1000>;
+		no-map;
+	};
+};
+
+&mailbox0_cluster0 {
+	status = "okay";
+
+	mbox_wkup_r5_0: mbox-wkup-r5-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+};
+
+&mailbox0_cluster1 {
+	status = "okay";
+
+	mbox_mcu_r5_0: mbox-mcu-r5-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+};
+
+&mailbox0_cluster2 {
+	status = "okay";
+
+	mbox_c7x_0: mbox-c7x-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+};
+
+&mailbox0_cluster3 {
+	status = "okay";
+
+	mbox_main_r5_0: mbox-main-r5-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+
+	mbox_c7x_1: mbox-c7x-1 {
+		ti,mbox-rx = <2 0 0>;
+		ti,mbox-tx = <3 0 0>;
+	};
+};
+
+/* Timers are used by Remoteproc firmware */
+&main_timer0 {
+	status = "reserved";
+};
+
+&main_timer1 {
+	status = "reserved";
+};
+
+&main_timer2 {
+	status = "reserved";
+};
+
+&wkup_r5fss0 {
+	status = "okay";
+};
+
+&wkup_r5fss0_core0 {
+	mboxes = <&mailbox0_cluster0 &mbox_wkup_r5_0>;
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
+	mboxes = <&mailbox0_cluster1 &mbox_mcu_r5_0>;
+	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
+			<&mcu_r5fss0_core0_memory_region>;
+	status = "okay";
+};
+
+&main_r5fss0 {
+	status = "okay";
+};
+
+&main_r5fss0_core0 {
+	mboxes = <&mailbox0_cluster3 &mbox_main_r5_0>;
+	memory-region = <&main_r5fss0_core0_dma_memory_region>,
+			<&main_r5fss0_core0_memory_region>;
+	status = "okay";
+};
+
+&c7x_0 {
+	mboxes = <&mailbox0_cluster2 &mbox_c7x_0>;
+	memory-region = <&c7x_0_dma_memory_region>,
+			<&c7x_0_memory_region>;
+	status = "okay";
+};
+
+&c7x_1 {
+	mboxes = <&mailbox0_cluster3 &mbox_c7x_1>;
+	memory-region = <&c7x_1_dma_memory_region>,
+			<&c7x_1_memory_region>;
+	status = "okay";
+};
-- 
2.34.1



Return-Path: <linux-kernel+bounces-802086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C792B44D78
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8426E3A49F8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 05:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776082EE61D;
	Fri,  5 Sep 2025 05:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hC6BfZRS"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74169283FD9;
	Fri,  5 Sep 2025 05:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757049690; cv=none; b=LULKYeAeXC1Xa0QtA/4hp3q2Toy7f+Mcd5KkxMLsikVoSEgZ6sdpZOEenHBVHUkj2ZMUYmgKP21KhOspDovtPjSJRjb9p6TZFBwsH0TCXlRoDFRZkdqcmick3rXzMzloighetRJ8bKBl92gy/JKTJZUHqtfiPGkbpgqeacw/go4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757049690; c=relaxed/simple;
	bh=WypF8MTKXs0xX04MvpaS3uRC3KIMiO4/gsa8THV5f2Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CaIL3sSwX3VPXmkYZ6C//jzgFpQTSdHXQDzUcYaMlszsQ3Esx6RXhi5NdQb2vZN9s44Sb8XUJ+8WkOlAwjEdvvZ/cxa0rurgHhECygqb9pn2ci4uXujpU23hN94UbTpiggCGsXky/70Uc6yxqgkngGNv6fK8cp1ZlRsO2lEAgLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hC6BfZRS; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5855LKYf3637733;
	Fri, 5 Sep 2025 00:21:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757049680;
	bh=MkYWzHpFQx56PCq0kzOmVnbtp46Z39Q5G8KktrMhdZs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=hC6BfZRSeI0PDWIo/DnHwYLs9iX37pVOtIvbH60KTLATkYZS2UhJGSz1j7Rt0Ies8
	 shF5aV8LVcE5m3FL7TBXKlsWQD8aTNVneKCJLxBuAjTufu43Lg6C1D+AnlA69BUwGY
	 StNJplh3rnq2yechEY4ILYxzR7/XwXHbXp4wSZnE=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5855LKrV689791
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 5 Sep 2025 00:21:20 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 5
 Sep 2025 00:21:19 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 5 Sep 2025 00:21:19 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5855Ioj1220581;
	Fri, 5 Sep 2025 00:21:15 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Wadim
 Egorov <w.egorov@phytec.de>
Subject: [PATCH v3 32/33] arm64: dts: ti: k3-am64-ti-ipc-firmware: Refactor IPC cfg into new dtsi
Date: Fri, 5 Sep 2025 10:48:45 +0530
Message-ID: <20250905051846.1189612-33-b-padhi@ti.com>
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

The TI K3 AM64 SoCs have multiple programmable remote processors like
R5F, M4F etc. The TI SDKs for AM64 SoCs offer sample firmwares which
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
Reviewed-by: Wadim Egorov <w.egorov@phytec.de> # phycore-am64x
Tested-by: Wadim Egorov <w.egorov@phytec.de> # phycore-am64x
Tested-by: Hari Nagalla <hnagalla@ti.com>
---
v3: Changelog:
1. Carried R/B, T/B tags.

Link to v2:
https://lore.kernel.org/all/20250823160901.2177841-33-b-padhi@ti.com/

v2: Changelog:
1. Re-ordered patch from [PATCH 30/33] to [PATCH v2 32/33].

Link to v1:
https://lore.kernel.org/all/20250814223839.3256046-31-b-padhi@ti.com/

 .../boot/dts/ti/k3-am64-phycore-som.dtsi      | 160 +----------------
 .../boot/dts/ti/k3-am64-ti-ipc-firmware.dtsi  | 162 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts       | 156 +----------------
 arch/arm64/boot/dts/ti/k3-am642-sk.dts        | 156 +----------------
 arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi   | 156 +----------------
 .../arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi | 156 +----------------
 6 files changed, 172 insertions(+), 774 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am64-ti-ipc-firmware.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
index 1efd547b2ba6..af0fed6124e2 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
@@ -52,60 +52,6 @@ main_r5fss0_core0_memory_region: r5f-memory@a0100000 {
 			reg = <0x00 0xa0100000 0x00 0xf00000>;
 			no-map;
 		};
-
-		main_r5fss0_core1_dma_memory_region: r5f-dma-memory@a1000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa1000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss0_core1_memory_region: r5f-memory@a1100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa1100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		main_r5fss1_core0_dma_memory_region: r5f-dma-memory@a2000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa2000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss1_core0_memory_region: r5f-memory@a2100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa2100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		main_r5fss1_core1_dma_memory_region: r5f-dma-memory@a3000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa3000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss1_core1_memory_region: r5f-memory@a3100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa3100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		mcu_m4fss_dma_memory_region: m4f-dma-memory@a4000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa4000000 0x00 0x100000>;
-			no-map;
-		};
-
-		mcu_m4fss_memory_region: m4f-memory@a4100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa4100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		rtos_ipc_memory_region: ipc-memories@a5000000 {
-			reg = <0x00 0xa5000000 0x00 0x00800000>;
-			alignment = <0x1000>;
-			no-map;
-		};
 	};
 
 	leds {
@@ -238,67 +184,6 @@ &cpsw_port1 {
 	status = "okay";
 };
 
-&mailbox0_cluster2 {
-	status = "okay";
-
-	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
-		ti,mbox-rx = <0 0 2>;
-		ti,mbox-tx = <1 0 2>;
-	};
-
-	mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
-		ti,mbox-rx = <2 0 2>;
-		ti,mbox-tx = <3 0 2>;
-	};
-};
-
-&mailbox0_cluster4 {
-	status = "okay";
-
-	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
-		ti,mbox-rx = <0 0 2>;
-		ti,mbox-tx = <1 0 2>;
-	};
-
-	mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
-		ti,mbox-rx = <2 0 2>;
-		ti,mbox-tx = <3 0 2>;
-	};
-};
-
-&mailbox0_cluster6 {
-	status = "okay";
-
-	mbox_m4_0: mbox-m4-0 {
-		ti,mbox-rx = <0 0 2>;
-		ti,mbox-tx = <1 0 2>;
-	};
-};
-
-/* main_timer8 is used by r5f0-0 */
-&main_timer8 {
-	status = "reserved";
-};
-
-/* main_timer9 is used by r5f0-1 */
-&main_timer9 {
-	status = "reserved";
-};
-
-/* main_timer10 is used by r5f1-0 */
-&main_timer10 {
-	status = "reserved";
-};
-
-/* main_timer11 is used by r5f1-1 */
-&main_timer11 {
-	status = "reserved";
-};
-
-&main_r5fss0 {
-	status = "okay";
-};
-
 &main_i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c0_pins_default>;
@@ -373,49 +258,6 @@ &main_pktdma {
 	bootph-all;
 };
 
-&main_r5fss0 {
-	status = "okay";
-};
-
-&main_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
-	memory-region = <&main_r5fss0_core0_dma_memory_region>,
-			<&main_r5fss0_core0_memory_region>;
-	status = "okay";
-};
-
-&main_r5fss0_core1 {
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core1>;
-	memory-region = <&main_r5fss0_core1_dma_memory_region>,
-			<&main_r5fss0_core1_memory_region>;
-	status = "okay";
-};
-
-&main_r5fss1 {
-	status = "okay";
-};
-
-&main_r5fss1_core0 {
-	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core0>;
-	memory-region = <&main_r5fss1_core0_dma_memory_region>,
-			<&main_r5fss1_core0_memory_region>;
-	status = "okay";
-};
-
-&main_r5fss1_core1 {
-	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core1>;
-	memory-region = <&main_r5fss1_core1_dma_memory_region>,
-			<&main_r5fss1_core1_memory_region>;
-	status = "okay";
-};
-
-&mcu_m4fss {
-	mboxes = <&mailbox0_cluster6 &mbox_m4_0>;
-	memory-region = <&mcu_m4fss_dma_memory_region>,
-			<&mcu_m4fss_memory_region>;
-	status = "okay";
-};
-
 &ospi0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&ospi0_pins_default>;
@@ -451,3 +293,5 @@ adc {
 		ti,adc-channels = <0 1 2 3 4 5 6 7>;
 	};
 };
+
+#include "k3-am64-ti-ipc-firmware.dtsi"
diff --git a/arch/arm64/boot/dts/ti/k3-am64-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-am64-ti-ipc-firmware.dtsi
new file mode 100644
index 000000000000..847495f76831
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am64-ti-ipc-firmware.dtsi
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/**
+ * Device Tree Source for enabling IPC using TI SDK firmware on AM64 SoCs
+ *
+ * Copyright (C) 2024-2025 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+&reserved_memory {
+	main_r5fss0_core1_dma_memory_region: r5f-dma-memory@a1000000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa1000000 0x00 0x100000>;
+		no-map;
+	};
+
+	main_r5fss0_core1_memory_region: r5f-memory@a1100000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa1100000 0x00 0xf00000>;
+		no-map;
+	};
+
+	main_r5fss1_core0_dma_memory_region: r5f-dma-memory@a2000000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa2000000 0x00 0x100000>;
+		no-map;
+	};
+
+	main_r5fss1_core0_memory_region: r5f-memory@a2100000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa2100000 0x00 0xf00000>;
+		no-map;
+	};
+
+	main_r5fss1_core1_dma_memory_region: r5f-dma-memory@a3000000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa3000000 0x00 0x100000>;
+		no-map;
+	};
+
+	main_r5fss1_core1_memory_region: r5f-memory@a3100000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa3100000 0x00 0xf00000>;
+		no-map;
+	};
+
+	mcu_m4fss_dma_memory_region: m4f-dma-memory@a4000000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa4000000 0x00 0x100000>;
+		no-map;
+	};
+
+	mcu_m4fss_memory_region: m4f-memory@a4100000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa4100000 0x00 0xf00000>;
+		no-map;
+	};
+
+	rtos_ipc_memory_region: ipc-memories@a5000000 {
+		reg = <0x00 0xa5000000 0x00 0x00800000>;
+		alignment = <0x1000>;
+		no-map;
+	};
+};
+
+&mailbox0_cluster2 {
+	status = "okay";
+
+	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
+		ti,mbox-rx = <0 0 2>;
+		ti,mbox-tx = <1 0 2>;
+	};
+
+	mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
+		ti,mbox-rx = <2 0 2>;
+		ti,mbox-tx = <3 0 2>;
+	};
+};
+
+&mailbox0_cluster4 {
+	status = "okay";
+
+	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
+		ti,mbox-rx = <0 0 2>;
+		ti,mbox-tx = <1 0 2>;
+	};
+
+	mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
+		ti,mbox-rx = <2 0 2>;
+		ti,mbox-tx = <3 0 2>;
+	};
+};
+
+&mailbox0_cluster6 {
+	status = "okay";
+
+	mbox_m4_0: mbox-m4-0 {
+		ti,mbox-rx = <0 0 2>;
+		ti,mbox-tx = <1 0 2>;
+	};
+};
+
+/* main_timer8 is used by r5f0-0 */
+&main_timer8 {
+	status = "reserved";
+};
+
+/* main_timer9 is used by r5f0-1 */
+&main_timer9 {
+	status = "reserved";
+};
+
+/* main_timer10 is used by r5f1-0 */
+&main_timer10 {
+	status = "reserved";
+};
+
+/* main_timer11 is used by r5f1-1 */
+&main_timer11 {
+	status = "reserved";
+};
+
+&main_r5fss0 {
+	status = "okay";
+};
+
+&main_r5fss0_core0 {
+	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
+	memory-region = <&main_r5fss0_core0_dma_memory_region>,
+			<&main_r5fss0_core0_memory_region>;
+	status = "okay";
+};
+
+&main_r5fss0_core1 {
+	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core1>;
+	memory-region = <&main_r5fss0_core1_dma_memory_region>,
+			<&main_r5fss0_core1_memory_region>;
+	status = "okay";
+};
+
+&main_r5fss1 {
+	status = "okay";
+};
+
+&main_r5fss1_core0 {
+	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core0>;
+	memory-region = <&main_r5fss1_core0_dma_memory_region>,
+			<&main_r5fss1_core0_memory_region>;
+	status = "okay";
+};
+
+&main_r5fss1_core1 {
+	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core1>;
+	memory-region = <&main_r5fss1_core1_dma_memory_region>,
+			<&main_r5fss1_core1_memory_region>;
+	status = "okay";
+};
+
+&mcu_m4fss {
+	mboxes = <&mailbox0_cluster6 &mbox_m4_0>;
+	memory-region = <&mcu_m4fss_dma_memory_region>,
+			<&mcu_m4fss_memory_region>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 7640c5efe9b8..05b7cdd25a8c 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -64,60 +64,6 @@ main_r5fss0_core0_memory_region: r5f-memory@a0100000 {
 			reg = <0x00 0xa0100000 0x00 0xf00000>;
 			no-map;
 		};
-
-		main_r5fss0_core1_dma_memory_region: r5f-dma-memory@a1000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa1000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss0_core1_memory_region: r5f-memory@a1100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa1100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		main_r5fss1_core0_dma_memory_region: r5f-dma-memory@a2000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa2000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss1_core0_memory_region: r5f-memory@a2100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa2100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		main_r5fss1_core1_dma_memory_region: r5f-dma-memory@a3000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa3000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss1_core1_memory_region: r5f-memory@a3100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa3100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		mcu_m4fss_dma_memory_region: m4f-dma-memory@a4000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa4000000 0x00 0x100000>;
-			no-map;
-		};
-
-		mcu_m4fss_memory_region: m4f-memory@a4100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa4100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		rtos_ipc_memory_region: ipc-memories@a5000000 {
-			reg = <0x00 0xa5000000 0x00 0x00800000>;
-			alignment = <0x1000>;
-			no-map;
-		};
 	};
 
 	evm_12v0: regulator-0 {
@@ -727,106 +673,6 @@ partition@3fc0000 {
 	};
 };
 
-&mailbox0_cluster2 {
-	status = "okay";
-
-	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
-		ti,mbox-rx = <0 0 2>;
-		ti,mbox-tx = <1 0 2>;
-	};
-
-	mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
-		ti,mbox-rx = <2 0 2>;
-		ti,mbox-tx = <3 0 2>;
-	};
-};
-
-&mailbox0_cluster4 {
-	status = "okay";
-
-	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
-		ti,mbox-rx = <0 0 2>;
-		ti,mbox-tx = <1 0 2>;
-	};
-
-	mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
-		ti,mbox-rx = <2 0 2>;
-		ti,mbox-tx = <3 0 2>;
-	};
-};
-
-&mailbox0_cluster6 {
-	status = "okay";
-
-	mbox_m4_0: mbox-m4-0 {
-		ti,mbox-rx = <0 0 2>;
-		ti,mbox-tx = <1 0 2>;
-	};
-};
-
-&main_r5fss0 {
-	status = "okay";
-};
-
-&main_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
-	memory-region = <&main_r5fss0_core0_dma_memory_region>,
-			<&main_r5fss0_core0_memory_region>;
-	status = "okay";
-};
-
-&main_r5fss0_core1 {
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core1>;
-	memory-region = <&main_r5fss0_core1_dma_memory_region>,
-			<&main_r5fss0_core1_memory_region>;
-	status = "okay";
-};
-
-&main_r5fss1 {
-	status = "okay";
-};
-
-&main_r5fss1_core0 {
-	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core0>;
-	memory-region = <&main_r5fss1_core0_dma_memory_region>,
-			<&main_r5fss1_core0_memory_region>;
-	status = "okay";
-};
-
-&main_r5fss1_core1 {
-	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core1>;
-	memory-region = <&main_r5fss1_core1_dma_memory_region>,
-			<&main_r5fss1_core1_memory_region>;
-	status = "okay";
-};
-
-&mcu_m4fss {
-	mboxes = <&mailbox0_cluster6 &mbox_m4_0>;
-	memory-region = <&mcu_m4fss_dma_memory_region>,
-			<&mcu_m4fss_memory_region>;
-	status = "okay";
-};
-
-/* main_timer8 is used by r5f0-0 */
-&main_timer8 {
-	status = "reserved";
-};
-
-/* main_timer9 is used by r5f0-1 */
-&main_timer9 {
-	status = "reserved";
-};
-
-/* main_timer10 is used by r5f1-0 */
-&main_timer10 {
-	status = "reserved";
-};
-
-/* main_timer11 is used by r5f1-1 */
-&main_timer11 {
-	status = "reserved";
-};
-
 &serdes_ln_ctrl {
 	idle-states = <AM64_SERDES0_LANE0_PCIE0>;
 };
@@ -890,3 +736,5 @@ &icssg1_iep0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&icssg1_iep0_pins_default>;
 };
+
+#include "k3-am64-ti-ipc-firmware.dtsi"
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index fb8bd66f2f94..cc1569a6519b 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -62,60 +62,6 @@ main_r5fss0_core0_memory_region: r5f-memory@a0100000 {
 			reg = <0x00 0xa0100000 0x00 0xf00000>;
 			no-map;
 		};
-
-		main_r5fss0_core1_dma_memory_region: r5f-dma-memory@a1000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa1000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss0_core1_memory_region: r5f-memory@a1100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa1100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		main_r5fss1_core0_dma_memory_region: r5f-dma-memory@a2000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa2000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss1_core0_memory_region: r5f-memory@a2100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa2100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		main_r5fss1_core1_dma_memory_region: r5f-dma-memory@a3000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa3000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss1_core1_memory_region: r5f-memory@a3100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa3100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		mcu_m4fss_dma_memory_region: m4f-dma-memory@a4000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa4000000 0x00 0x100000>;
-			no-map;
-		};
-
-		mcu_m4fss_memory_region: m4f-memory@a4100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa4100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		rtos_ipc_memory_region: ipc-memories@a5000000 {
-			reg = <0x00 0xa5000000 0x00 0x00800000>;
-			alignment = <0x1000>;
-			no-map;
-		};
 	};
 
 	vusb_main: regulator-0 {
@@ -642,106 +588,6 @@ partition@3fc0000 {
 	};
 };
 
-&mailbox0_cluster2 {
-	status = "okay";
-
-	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
-		ti,mbox-rx = <0 0 2>;
-		ti,mbox-tx = <1 0 2>;
-	};
-
-	mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
-		ti,mbox-rx = <2 0 2>;
-		ti,mbox-tx = <3 0 2>;
-	};
-};
-
-&mailbox0_cluster4 {
-	status = "okay";
-
-	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
-		ti,mbox-rx = <0 0 2>;
-		ti,mbox-tx = <1 0 2>;
-	};
-
-	mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
-		ti,mbox-rx = <2 0 2>;
-		ti,mbox-tx = <3 0 2>;
-	};
-};
-
-&mailbox0_cluster6 {
-	status = "okay";
-
-	mbox_m4_0: mbox-m4-0 {
-		ti,mbox-rx = <0 0 2>;
-		ti,mbox-tx = <1 0 2>;
-	};
-};
-
-&main_r5fss0 {
-	status = "okay";
-};
-
-&main_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
-	memory-region = <&main_r5fss0_core0_dma_memory_region>,
-			<&main_r5fss0_core0_memory_region>;
-	status = "okay";
-};
-
-&main_r5fss0_core1 {
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core1>;
-	memory-region = <&main_r5fss0_core1_dma_memory_region>,
-			<&main_r5fss0_core1_memory_region>;
-	status = "okay";
-};
-
-&main_r5fss1 {
-	status = "okay";
-};
-
-&main_r5fss1_core0 {
-	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core0>;
-	memory-region = <&main_r5fss1_core0_dma_memory_region>,
-			<&main_r5fss1_core0_memory_region>;
-	status = "okay";
-};
-
-&main_r5fss1_core1 {
-	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core1>;
-	memory-region = <&main_r5fss1_core1_dma_memory_region>,
-			<&main_r5fss1_core1_memory_region>;
-	status = "okay";
-};
-
-&mcu_m4fss {
-	mboxes = <&mailbox0_cluster6 &mbox_m4_0>;
-	memory-region = <&mcu_m4fss_dma_memory_region>,
-			<&mcu_m4fss_memory_region>;
-	status = "okay";
-};
-
-/* main_timer8 is used by r5f0-0 */
-&main_timer8 {
-	status = "reserved";
-};
-
-/* main_timer9 is used by r5f0-1 */
-&main_timer9 {
-	status = "reserved";
-};
-
-/* main_timer10 is used by r5f1-0 */
-&main_timer10 {
-	status = "reserved";
-};
-
-/* main_timer11 is used by r5f1-1 */
-&main_timer11 {
-	status = "reserved";
-};
-
 &ecap0 {
 	status = "okay";
 	/* PWM is available on Pin 1 of header J3 */
@@ -755,3 +601,5 @@ &eqep0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_eqep0_pins_default>;
 };
+
+#include "k3-am64-ti-ipc-firmware.dtsi"
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi b/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
index 8cb61f831734..ce23362b88c3 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
@@ -126,60 +126,6 @@ main_r5fss0_core0_memory_region: r5f-memory@a0100000 {
 			reg = <0x00 0xa0100000 0x00 0xf00000>;
 			no-map;
 		};
-
-		main_r5fss0_core1_dma_memory_region: r5f-dma-memory@a1000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa1000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss0_core1_memory_region: r5f-memory@a1100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa1100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		main_r5fss1_core0_dma_memory_region: r5f-dma-memory@a2000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa2000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss1_core0_memory_region: r5f-memory@a2100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa2100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		main_r5fss1_core1_dma_memory_region: r5f-dma-memory@a3000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa3000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss1_core1_memory_region: r5f-memory@a3100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa3100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		mcu_m4fss_dma_memory_region: m4f-dma-memory@a4000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa4000000 0x00 0x100000>;
-			no-map;
-		};
-
-		mcu_m4fss_memory_region: m4f-memory@a4100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa4100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		rtos_ipc_memory_region: ipc-memories@a5000000 {
-			reg = <0x00 0xa5000000 0x00 0x00800000>;
-			alignment = <0x1000>;
-			no-map;
-		};
 	};
 
 	vdd_mmc0: regulator-vdd-mmc0 {
@@ -281,63 +227,6 @@ ethernet_phy2: ethernet-phy@f {
 	};
 };
 
-&mailbox0_cluster2 {
-	status = "okay";
-
-	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
-		ti,mbox-rx = <0 0 2>;
-		ti,mbox-tx = <1 0 2>;
-	};
-
-	mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
-		ti,mbox-rx = <2 0 2>;
-		ti,mbox-tx = <3 0 2>;
-	};
-};
-
-&mailbox0_cluster4 {
-	status = "okay";
-
-	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
-		ti,mbox-rx = <0 0 2>;
-		ti,mbox-tx = <1 0 2>;
-	};
-
-	mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
-		ti,mbox-rx = <2 0 2>;
-		ti,mbox-tx = <3 0 2>;
-	};
-};
-
-&mailbox0_cluster6 {
-	status = "okay";
-
-	mbox_m4_0: mbox-m4-0 {
-		ti,mbox-rx = <0 0 2>;
-		ti,mbox-tx = <1 0 2>;
-	};
-};
-
-/* main_timer8 is used by r5f0-0 */
-&main_timer8 {
-	status = "reserved";
-};
-
-/* main_timer9 is used by r5f0-1 */
-&main_timer9 {
-	status = "reserved";
-};
-
-/* main_timer10 is used by r5f1-0 */
-&main_timer10 {
-	status = "reserved";
-};
-
-/* main_timer11 is used by r5f1-1 */
-&main_timer11 {
-	status = "reserved";
-};
-
 &main_i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c0_default_pins>;
@@ -535,49 +424,6 @@ AM64X_IOPAD(0x02a8, PIN_OUTPUT, 0) /* USB0_DRVVBUS.USB0_DRVVBUS */
 	};
 };
 
-&main_r5fss0 {
-	status = "okay";
-};
-
-&main_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
-	memory-region = <&main_r5fss0_core0_dma_memory_region>,
-			<&main_r5fss0_core0_memory_region>;
-	status = "okay";
-};
-
-&main_r5fss0_core1 {
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core1>;
-	memory-region = <&main_r5fss0_core1_dma_memory_region>,
-			<&main_r5fss0_core1_memory_region>;
-	status = "okay";
-};
-
-&main_r5fss1 {
-	status = "okay";
-};
-
-&main_r5fss1_core0 {
-	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core0>;
-	memory-region = <&main_r5fss1_core0_dma_memory_region>,
-			<&main_r5fss1_core0_memory_region>;
-	status = "okay";
-};
-
-&main_r5fss1_core1 {
-	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core1>;
-	memory-region = <&main_r5fss1_core1_dma_memory_region>,
-			<&main_r5fss1_core1_memory_region>;
-	status = "okay";
-};
-
-&mcu_m4fss {
-	mboxes = <&mailbox0_cluster6 &mbox_m4_0>;
-	memory-region = <&mcu_m4fss_dma_memory_region>,
-			<&mcu_m4fss_memory_region>;
-	status = "okay";
-};
-
 /* SoC default UART console */
 &main_uart0 {
 	pinctrl-names = "default";
@@ -656,3 +502,5 @@ &usbss0 {
 	ti,vbus-divider;
 	ti,usb2-only;
 };
+
+#include "k3-am64-ti-ipc-firmware.dtsi"
diff --git a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi
index 860b79aa5ef5..e752fc8b0a88 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi
@@ -42,60 +42,6 @@ main_r5fss0_core0_memory_region: r5f-memory@a0100000 {
 			reg = <0x00 0xa0100000 0x00 0xf00000>;
 			no-map;
 		};
-
-		main_r5fss0_core1_dma_memory_region: r5f-dma-memory@a1000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa1000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss0_core1_memory_region: r5f-memory@a1100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa1100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		main_r5fss1_core0_dma_memory_region: r5f-dma-memory@a2000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa2000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss1_core0_memory_region: r5f-memory@a2100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa2100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		main_r5fss1_core1_dma_memory_region: r5f-dma-memory@a3000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa3000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss1_core1_memory_region: r5f-memory@a3100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa3100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		mcu_m4fss_dma_memory_region: m4f-dma-memory@a4000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa4000000 0x00 0x100000>;
-			no-map;
-		};
-
-		mcu_m4fss_memory_region: m4f-memory@a4100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa4100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		rtos_ipc_memory_region: ipc-memories@a5000000 {
-			reg = <0x00 0xa5000000 0x00 0x00800000>;
-			alignment = <0x1000>;
-			no-map;
-		};
 	};
 
 	reg_1v8: regulator-1v8 {
@@ -142,106 +88,6 @@ eeprom1: eeprom@54 {
 	};
 };
 
-&mailbox0_cluster2 {
-	status = "okay";
-
-	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
-		ti,mbox-rx = <0 0 2>;
-		ti,mbox-tx = <1 0 2>;
-	};
-
-	mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
-		ti,mbox-rx = <2 0 2>;
-		ti,mbox-tx = <3 0 2>;
-	};
-};
-
-&mailbox0_cluster4 {
-	status = "okay";
-
-	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
-		ti,mbox-rx = <0 0 2>;
-		ti,mbox-tx = <1 0 2>;
-	};
-
-	mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
-		ti,mbox-rx = <2 0 2>;
-		ti,mbox-tx = <3 0 2>;
-	};
-};
-
-&mailbox0_cluster6 {
-	status = "okay";
-
-	mbox_m4_0: mbox-m4-0 {
-		ti,mbox-rx = <0 0 2>;
-		ti,mbox-tx = <1 0 2>;
-	};
-};
-
-/* main_timer8 is used by r5f0-0 */
-&main_timer8 {
-	status = "reserved";
-};
-
-/* main_timer9 is used by r5f0-1 */
-&main_timer9 {
-	status = "reserved";
-};
-
-/* main_timer10 is used by r5f1-0 */
-&main_timer10 {
-	status = "reserved";
-};
-
-/* main_timer11 is used by r5f1-1 */
-&main_timer11 {
-	status = "reserved";
-};
-
-&main_r5fss0 {
-	status = "okay";
-};
-
-&main_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
-	memory-region = <&main_r5fss0_core0_dma_memory_region>,
-			<&main_r5fss0_core0_memory_region>;
-	status = "okay";
-};
-
-&main_r5fss0_core1 {
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core1>;
-	memory-region = <&main_r5fss0_core1_dma_memory_region>,
-			<&main_r5fss0_core1_memory_region>;
-	status = "okay";
-};
-
-&main_r5fss1 {
-	status = "okay";
-};
-
-&main_r5fss1_core0 {
-	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core0>;
-	memory-region = <&main_r5fss1_core0_dma_memory_region>,
-			<&main_r5fss1_core0_memory_region>;
-	status = "okay";
-};
-
-&main_r5fss1_core1 {
-	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core1>;
-	memory-region = <&main_r5fss1_core1_dma_memory_region>,
-			<&main_r5fss1_core1_memory_region>;
-	status = "okay";
-};
-
-&mcu_m4fss {
-	mboxes = <&mailbox0_cluster6 &mbox_m4_0>;
-	memory-region = <&mcu_m4fss_dma_memory_region>,
-			<&mcu_m4fss_memory_region>;
-	status = "okay";
-};
-
 &ospi0 {
 	status = "okay";
 	pinctrl-names = "default";
@@ -315,3 +161,5 @@ AM64X_IOPAD(0x0008, PIN_INPUT, 0)
 		>;
 	};
 };
+
+#include "k3-am64-ti-ipc-firmware.dtsi"
-- 
2.34.1



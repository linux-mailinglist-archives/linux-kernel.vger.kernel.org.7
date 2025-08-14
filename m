Return-Path: <linux-kernel+bounces-769674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 075E1B271C6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 00:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 135D4A204B4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 22:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275D42877E3;
	Thu, 14 Aug 2025 22:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="p0nVTUp8"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850DC2877C3;
	Thu, 14 Aug 2025 22:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755211204; cv=none; b=eaPQOClCzrY4+KK0TLjsd84uBFdXkZPZqLo2XP806TSojFq0Bxbt/H3gMzK0PXQqV+iR4PDKr8tmMpVAe50GFIPy7lEMCdz737ntG/IbQS5ywDetK2cpGie9pDbHaQRosfZrBdPp2vf21tu5gf+4CjS84o2SbY9djQZeqq2WF+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755211204; c=relaxed/simple;
	bh=QJNU9PLIl8PI5W73M/n9+TiRQjRHK/Yrheek0TXGsuU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eZgF1V9gJVAIhK1OONsCQLewaxIgQx+daQMqxpWDTRswIuvzHuJkLGdudXhuuQyDkfpkUcxXABi0W0RWGC5gBbCjViVSi4r1tor7fuA5br3+AFGrEdsxivyFdP+8n+Wxh8361iQqGObhIq5Yz2yKctEZ//TK/RR4tNmwpLWh9r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=p0nVTUp8; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57EMdwkv2027460;
	Thu, 14 Aug 2025 17:39:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755211198;
	bh=rXdQcy/27Jq7Jq/L5vAhv4CZm/ydLyaRg1/p0QGJJjk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=p0nVTUp8O2hWlYj1e5OQ8Yy+faLK1lzeBSFQb9xgCD0HOXokPh5jLD3wO5la2o6h7
	 /8lIw93bLaMxqpMYTo8baOsk8Nhc4ueS2C9JkwKKzQxhio8yZXKwfWVrypjF3UC2xn
	 ApH95ARiN9CVPYS55gwy59PR5hTeIbMyMhJQXFeA=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57EMdwnt1158805
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 14 Aug 2025 17:39:58 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 14
 Aug 2025 17:39:57 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 14 Aug 2025 17:39:57 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57EMcw4l096792;
	Thu, 14 Aug 2025 17:39:53 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 12/33] arm64: dts: ti: k3-j784s4-ti-ipc-firmware: Refactor IPC cfg into new dtsi
Date: Fri, 15 Aug 2025 04:08:18 +0530
Message-ID: <20250814223839.3256046-13-b-padhi@ti.com>
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

The TI K3 J784S4 SoCs have multiple programmable remote processors like
R5F, C7x etc. The TI SDKs for J784S4 SoCs offer sample firmwares which
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

This patch only refactors the C71_3 remote processor related nodes into
the new dtsi. All other nodes have been refactored in the previous
commit as part of k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am69-sk.dts         | 27 +--------------
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      | 26 +-------------
 .../dts/ti/k3-j784s4-ti-ipc-firmware.dtsi     | 34 +++++++++++++++++++
 3 files changed, 36 insertions(+), 51 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-ti-ipc-firmware.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index 5e187e86a5d9..9a12b639209b 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -60,18 +60,6 @@ mcu_r5fss0_core0_memory_region: r5f-memory@a0100000 {
 			reg = <0x00 0xa0100000 0x00 0xf00000>;
 			no-map;
 		};
-
-		c71_3_dma_memory_region: c71-dma-memory@ab000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xab000000 0x00 0x100000>;
-			no-map;
-		};
-
-		c71_3_memory_region: c71-memory@ab100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xab100000 0x00 0xf00000>;
-			no-map;
-		};
 	};
 
 	vusb_main: regulator-vusb-main5v0 {
@@ -520,13 +508,6 @@ &phy_gmii_sel {
 	bootph-all;
 };
 
-&mailbox0_cluster5 {
-	mbox_c71_3: mbox-c71-3 {
-		ti,mbox-rx = <2 0 0>;
-		ti,mbox-tx = <3 0 0>;
-	};
-};
-
 &wkup_uart0 {
 	/* Firmware usage */
 	status = "reserved";
@@ -795,13 +776,6 @@ &mcu_cpsw_port1 {
 	bootph-all;
 };
 
-&c71_3 {
-	status = "okay";
-	mboxes = <&mailbox0_cluster5 &mbox_c71_3>;
-	memory-region = <&c71_3_dma_memory_region>,
-			<&c71_3_memory_region>;
-};
-
 &wkup_gpio_intr {
 	status = "okay";
 };
@@ -1078,3 +1052,4 @@ &usb0 {
 };
 
 #include "k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi"
+#include "k3-j784s4-ti-ipc-firmware.dtsi"
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index a84bde08f85e..6c7458c76f53 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -27,31 +27,7 @@ memory@80000000 {
 	reserved_memory: reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
-
-		c71_3_dma_memory_region: c71-dma-memory@ab000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xab000000 0x00 0x100000>;
-			no-map;
-		};
-
-		c71_3_memory_region: c71-memory@ab100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xab100000 0x00 0xf00000>;
-			no-map;
-		};
-	};
-};
-
-&mailbox0_cluster5 {
-	mbox_c71_3: mbox-c71-3 {
-		ti,mbox-rx = <2 0 0>;
-		ti,mbox-tx = <3 0 0>;
 	};
 };
 
-&c71_3 {
-	mboxes = <&mailbox0_cluster5 &mbox_c71_3>;
-	memory-region = <&c71_3_dma_memory_region>,
-			<&c71_3_memory_region>;
-	status = "okay";
-};
+#include "k3-j784s4-ti-ipc-firmware.dtsi"
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-ti-ipc-firmware.dtsi
new file mode 100644
index 000000000000..d19cb708379b
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-ti-ipc-firmware.dtsi
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/**
+ * Device Tree Source for enabling IPC using TI SDK firmware on J784S4 SoCs
+ *
+ * Copyright (C) 2022-2025 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+&reserved_memory {
+	c71_3_dma_memory_region: c71-dma-memory@ab000000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xab000000 0x00 0x100000>;
+		no-map;
+	};
+
+	c71_3_memory_region: c71-memory@ab100000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xab100000 0x00 0xf00000>;
+		no-map;
+	};
+};
+
+&mailbox0_cluster5 {
+	mbox_c71_3: mbox-c71-3 {
+		ti,mbox-rx = <2 0 0>;
+		ti,mbox-tx = <3 0 0>;
+	};
+};
+
+&c71_3 {
+	mboxes = <&mailbox0_cluster5 &mbox_c71_3>;
+	memory-region = <&c71_3_dma_memory_region>,
+			<&c71_3_memory_region>;
+	status = "okay";
+};
-- 
2.34.1



Return-Path: <linux-kernel+bounces-783213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FDCB32AC9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D96C5E3D88
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAAE2F49E4;
	Sat, 23 Aug 2025 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WHiCrhlm"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335402F3C21;
	Sat, 23 Aug 2025 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755965491; cv=none; b=cCKAKCfOuia6j0EFSG15n0LIZo91dVCYNytcO6bPOUY2oOVtq3w3UTZLoJWwCFuRiDx/aIq+uixVysmWzxbWqHIUaNq8+89oDZPxiov67Ps8VnNBemstRSki3gH1N97HrIBqfRw/I3xc2NLn++P/u/KIM7W+MACS0gZHXMBxkOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755965491; c=relaxed/simple;
	bh=bDmQCQ6jQOn6PH+5yePHUX11dsXtMtUgAVNhj/o6c4E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lyn7olV3T71O2Mb0MIE5n9wYo4Rh4SV8ZIdc4V0P3SygH2vLkQfuNtXRqchTy/FUeFBY4Au+h54iX66UOqIke03Ii8aiBS1bEaUIl7OXsL9W+hgSIPCDZJ12wXQipuMEqetHPV7CyBwG5usoaRs5hiOREtKpUq5meSXhBfV/Ppg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WHiCrhlm; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57NGBOSg468628;
	Sat, 23 Aug 2025 11:11:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755965484;
	bh=44NmWXrClGTXCN73D13sY4CMVuXE4PuKUGsdVKtYpxg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=WHiCrhlm7PHm2r3R39Y/oqlmOVef2BHMk16yDfRrDsRY2DhUysUlCm/Scl5cGuv0d
	 qMfKTMg95jdc0Q27evNmaNncUxWh7iiYZlmwKVTSXlIM7jM1ncKgPcJjyOvNU2Ku6R
	 Wkm1elNPU4kggyEFmnMJJca6fCqDIs2xd9Z0D/qY=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57NGBOuq240012
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Sat, 23 Aug 2025 11:11:24 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sat, 23
 Aug 2025 11:11:24 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Sat, 23 Aug 2025 11:11:24 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57NG9Exh1274978;
	Sat, 23 Aug 2025 11:11:20 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 27/33] arm64: dts: ti: k3-j784s4-ti-ipc-firmware: Refactor IPC cfg into new dtsi
Date: Sat, 23 Aug 2025 21:38:55 +0530
Message-ID: <20250823160901.2177841-28-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250823160901.2177841-1-b-padhi@ti.com>
References: <20250823160901.2177841-1-b-padhi@ti.com>
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
v2: Changelog:
1. Re-ordered patch from [PATCH 12/33] to [PATCH v2 27/33].

Link to v1:
https://lore.kernel.org/all/20250814223839.3256046-13-b-padhi@ti.com/

 arch/arm64/boot/dts/ti/k3-am69-sk.dts         | 27 +-------------
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      | 26 +-------------
 .../dts/ti/k3-j784s4-ti-ipc-firmware.dtsi     | 35 +++++++++++++++++++
 3 files changed, 37 insertions(+), 51 deletions(-)
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
index 000000000000..23020c0bbb28
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-ti-ipc-firmware.dtsi
@@ -0,0 +1,35 @@
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
+
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



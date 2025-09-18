Return-Path: <linux-kernel+bounces-783216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB010B32AC0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B13C41BC4867
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8B72F546C;
	Sat, 23 Aug 2025 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XSrWu8oA"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A98C2ED870;
	Sat, 23 Aug 2025 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755965502; cv=none; b=rYqXEhpAd9AAPuRDq6L0DP+dhuZKsolzJfpHd2Rh7bm91H2emkJFcwIam74Arfg5ZAkoKKkfdJpqP+7hSBvKPOSm0uA1JXhC/VH1qaaM7g02qpG+ssAAvnwiLDtdQPab2KDW0ZH67u9vUVrU3qngKaWpmnDzrU87Em62deSqE0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755965502; c=relaxed/simple;
	bh=UtgzDAoMIVxnQJ9rE++vTMYu7se2P4X+MSlTuFsHXvE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JcBLPkDu+59YRtkaELR5HXdx5dGY2QPGuJ9aSXqC7aa7bd43F0UFiFEtI4s0PdyHwcIypvyOCaEdtGbzUFX18nuitdjKmPxXj2U3AG5lEcgaTpAHCeYXfFJ72kBlvktnewFNKHq5VyJk2Z+h8a703YmBQqfYcuuVf5n/YldZleY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XSrWu8oA; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57NGBX6Q468640;
	Sat, 23 Aug 2025 11:11:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755965493;
	bh=nYC81kzz6wEEKM57Cs/xzmiRcdYeQlReAo3sPZEaGuM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=XSrWu8oAU2ZjhrpYosNDZRYrlwaxxYDNxn118HxgVS/440rzU0Nx/QQ2Vss3ndi8F
	 neriFMAib9hHE3qIIgWUDv5OeOiufl6n4qAYznJm8zF6QpOdcR6CILYU+SAcB3aPJT
	 //0CIlSsTOToYsTj/x2r6LUpJraw8iWGomIf2uCc=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57NGBXtk240061
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Sat, 23 Aug 2025 11:11:33 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sat, 23
 Aug 2025 11:11:32 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Sat, 23 Aug 2025 11:11:32 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57NG9Exj1274978;
	Sat, 23 Aug 2025 11:11:29 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 29/33] arm64: dts: ti: k3-am62p-ti-ipc-firmware: Refactor IPC cfg into new dtsi
Date: Sat, 23 Aug 2025 21:38:57 +0530
Message-ID: <20250823160901.2177841-30-b-padhi@ti.com>
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

The TI K3 AM62P SoCs have multiple programmable remote processors like
R5Fs. The TI SDKs for AM62P SoCs offer sample firmwares which could be
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
v2: Changelog:
1. Re-ordered patch from [PATCH 17/33] to [PATCH v2 29/33].

Link to v1:
https://lore.kernel.org/all/20250814223839.3256046-18-b-padhi@ti.com/

 .../boot/dts/ti/k3-am62p-ti-ipc-firmware.dtsi | 60 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi   | 42 +------------
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts       | 54 +----------------
 3 files changed, 64 insertions(+), 92 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p-ti-ipc-firmware.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-ti-ipc-firmware.dtsi
new file mode 100644
index 000000000000..5c0c42648cb5
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62p-ti-ipc-firmware.dtsi
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/**
+ * Device Tree Source for enabling IPC using TI SDK firmware on AM62P SoCs
+ *
+ * Copyright (C) 2023-2025 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+&reserved_memory {
+	mcu_r5fss0_core0_dma_memory_region: mcu-r5fss-dma-memory-region@9b800000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0x9b800000 0x00 0x100000>;
+		no-map;
+	};
+
+	mcu_r5fss0_core0_memory_region: mcu-r5fss-memory-region@9b900000 {
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
+	mboxes = <&mailbox0_cluster0 &mbox_r5_0>;
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
diff --git a/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi
index 0687debf3bbb..e2ab98e65fd5 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi
@@ -848,46 +848,6 @@ &epwm2 {
 	status = "disabled";
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
-	mboxes = <&mailbox0_cluster0 &mbox_r5_0>;
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
 &main0_alert {
 	temperature = <95000>;
 };
@@ -1466,3 +1426,5 @@ &wkup_uart0 {
 	uart-has-rtscts;
 	status = "disabled";
 };
+
+#include "k3-am62p-ti-ipc-firmware.dtsi"
diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
index c5b5b00c42b9..42886ecf1521 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
@@ -49,18 +49,6 @@ reserved_memory: reserved-memory {
 		#size-cells = <2>;
 		ranges;
 
-		mcu_r5fss0_core0_dma_memory_region: mcu-r5fss-dma-memory-region@9b800000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x9b800000 0x00 0x100000>;
-			no-map;
-		};
-
-		mcu_r5fss0_core0_memory_region: mcu-r5fss-memory-region@9b900000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0x9b900000 0x00 0xf00000>;
-			no-map;
-		};
-
 		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9c800000 {
 			compatible = "shared-dma-pool";
 			reg = <0x00 0x9c800000 0x00 0x100000>;
@@ -699,46 +687,6 @@ partition@3fc0000 {
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
-	mboxes = <&mailbox0_cluster0 &mbox_r5_0>;
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
 &main_uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart0_pins_default>;
@@ -810,3 +758,5 @@ &epwm1 {
 	pinctrl-0 = <&main_epwm1_pins_default>;
 	status = "okay";
 };
+
+#include "k3-am62p-ti-ipc-firmware.dtsi"
-- 
2.34.1



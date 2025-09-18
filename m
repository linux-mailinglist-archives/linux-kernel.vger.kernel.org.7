Return-Path: <linux-kernel+bounces-783210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D361B32AC5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B48915E2A94
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2801A2ECD10;
	Sat, 23 Aug 2025 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UeIx0s5Y"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5872F39DB;
	Sat, 23 Aug 2025 16:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755965480; cv=none; b=dsZDcx/QRedrbIOUv5VIRJKMPqv9PQBHvc3elHK9RRm+eGQ4wxfUUlLN1dhSCNPMsOrRxAycppius3RZFSPVJC9LFoB9fxSzdeyNtxVW2t/fOoe1BcB6XapgA6krlo5VgsykLBuI1xhr1N618SuQhgw22b5yFc9F7NoPq1SQENk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755965480; c=relaxed/simple;
	bh=OWX58mS4TSTtRoelKH2vIgvoUZ2Imi+HpdwCbFFBxaQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dDGRxBE+lOxLNxHV348egNWMKCaj+TRC8eywjzi/JDkBiAwZpEzCxyR/8VOtdVB8fWL9BbcPXKFXpWX1u3xu//4IaQ+shiFnPSWcRxBjsjR8A0h9rviVnvXntyFCLvc8RPb1vVWZlfwll6lJSaarqbcJWjp95lrHEjc85Qm78hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UeIx0s5Y; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57NGBC5U465320;
	Sat, 23 Aug 2025 11:11:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755965472;
	bh=tasiDi9LVXzcCeQ0TFnFBo/pGE+TjC7/rQyv4qnrWUc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=UeIx0s5Yu1v0ZqugaDFT7vxE8ehGFrk4s3T9ntWIt8qfNULNQpts9JZ0otcO5DjjZ
	 c+/NH4J2AROHxXb0jU7E6U+LPeFqBrV8021xb4YWrzWZyLGHDWzja40f1c9oZazqaO
	 4Hj6o9sJNQAgKIGFYOlBFxElAWI9jfUpFWMBXwNA=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57NGBCXP4080618
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Sat, 23 Aug 2025 11:11:12 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sat, 23
 Aug 2025 11:11:11 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Sat, 23 Aug 2025 11:11:11 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57NG9Exe1274978;
	Sat, 23 Aug 2025 11:11:07 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 24/33] arm64: dts: ti: k3-j721e-ti-ipc-firmware: Refactor IPC cfg into new dtsi
Date: Sat, 23 Aug 2025 21:38:52 +0530
Message-ID: <20250823160901.2177841-25-b-padhi@ti.com>
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

The TI K3 J721E SoCs have multiple programmable remote processors like
R5F, C6x, C7x etc. The TI SDKs for J721E SoCs offer sample firmwares
which could be run on these cores to demonstrate an "echo" IPC test.
Those firmware require certain memory carveouts to be reserved from
system memory, timers to be reserved, and certain mailbox configurations
for interrupt based messaging. These configurations could be different
for a different firmware.

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
1. Re-ordered patch from [PATCH 07/33] to [PATCH v2 24/33].

Link to v1:
https://lore.kernel.org/all/20250814223839.3256046-8-b-padhi@ti.com/

 .../boot/dts/ti/k3-j721e-beagleboneai64.dts   | 280 +----------------
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts        | 280 +----------------
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi   | 278 +----------------
 .../boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi | 288 ++++++++++++++++++
 4 files changed, 291 insertions(+), 835 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
index c7ac2b66ee0d..7fc014a3f4e4 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
@@ -62,110 +62,6 @@ mcu_r5fss0_core0_memory_region: r5f-memory@a0100000 {
 			reg = <0x00 0xa0100000 0x00 0xf00000>;
 			no-map;
 		};
-
-		mcu_r5fss0_core1_dma_memory_region: r5f-dma-memory@a1000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa1000000 0x00 0x100000>;
-			no-map;
-		};
-
-		mcu_r5fss0_core1_memory_region: r5f-memory@a1100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa1100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		main_r5fss0_core0_dma_memory_region: r5f-dma-memory@a2000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa2000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss0_core0_memory_region: r5f-memory@a2100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa2100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		main_r5fss0_core1_dma_memory_region: r5f-dma-memory@a3000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa3000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss0_core1_memory_region: r5f-memory@a3100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa3100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		main_r5fss1_core0_dma_memory_region: r5f-dma-memory@a4000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa4000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss1_core0_memory_region: r5f-memory@a4100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa4100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		main_r5fss1_core1_dma_memory_region: r5f-dma-memory@a5000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa5000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss1_core1_memory_region: r5f-memory@a5100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa5100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		/* Carveout locations are flipped due to caching */
-		c66_1_dma_memory_region: c66-dma-memory@a6000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa6000000 0x00 0x100000>;
-			no-map;
-		};
-
-		c66_0_memory_region: c66-memory@a6100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa6100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		/* Carveout locations are flipped due to caching */
-		c66_0_dma_memory_region: c66-dma-memory@a7000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa7000000 0x00 0x100000>;
-			no-map;
-		};
-
-		c66_1_memory_region: c66-memory@a7100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa7100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		c71_0_dma_memory_region: c71-dma-memory@a8000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa8000000 0x00 0x100000>;
-			no-map;
-		};
-
-		c71_0_memory_region: c71-memory@a8100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa8100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		rtos_ipc_memory_region: ipc-memories@aa000000 {
-			reg = <0x00 0xaa000000 0x00 0x01c00000>;
-			alignment = <0x1000>;
-			no-map;
-		};
 	};
 
 	gpio_keys: gpio-keys {
@@ -867,178 +763,4 @@ &ufs_wrapper {
 	status = "disabled";
 };
 
-&mailbox0_cluster0 {
-	status = "okay";
-	interrupts = <436>;
-
-	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-
-	mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
-		ti,mbox-rx = <2 0 0>;
-		ti,mbox-tx = <3 0 0>;
-	};
-};
-
-&mailbox0_cluster1 {
-	status = "okay";
-	interrupts = <432>;
-
-	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-
-	mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
-		ti,mbox-rx = <2 0 0>;
-		ti,mbox-tx = <3 0 0>;
-	};
-};
-
-&mailbox0_cluster2 {
-	status = "okay";
-	interrupts = <428>;
-
-	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-
-	mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
-		ti,mbox-rx = <2 0 0>;
-		ti,mbox-tx = <3 0 0>;
-	};
-};
-
-&mailbox0_cluster3 {
-	status = "okay";
-	interrupts = <424>;
-
-	mbox_c66_0: mbox-c66-0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-
-	mbox_c66_1: mbox-c66-1 {
-		ti,mbox-rx = <2 0 0>;
-		ti,mbox-tx = <3 0 0>;
-	};
-};
-
-&mailbox0_cluster4 {
-	status = "okay";
-	interrupts = <420>;
-
-	mbox_c71_0: mbox-c71-0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
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
-&main_timer12 {
-	status = "reserved";
-};
-
-&main_timer13 {
-	status = "reserved";
-};
-
-&main_timer14 {
-	status = "reserved";
-};
-
-&main_timer15 {
-	status = "reserved";
-};
-
-&mcu_r5fss0 {
-	status = "okay";
-};
-
-&mcu_r5fss0_core0 {
-	status = "okay";
-	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core0>;
-	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
-			<&mcu_r5fss0_core0_memory_region>;
-};
-
-&mcu_r5fss0_core1 {
-	status = "okay";
-	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core1>;
-	memory-region = <&mcu_r5fss0_core1_dma_memory_region>,
-			<&mcu_r5fss0_core1_memory_region>;
-};
-
-&main_r5fss0 {
-	ti,cluster-mode = <0>;
-	status = "okay";
-};
-
-&main_r5fss0_core0 {
-	status = "okay";
-	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core0>;
-	memory-region = <&main_r5fss0_core0_dma_memory_region>,
-			<&main_r5fss0_core0_memory_region>;
-};
-
-&main_r5fss0_core1 {
-	status = "okay";
-	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core1>;
-	memory-region = <&main_r5fss0_core1_dma_memory_region>,
-			<&main_r5fss0_core1_memory_region>;
-};
-
-&main_r5fss1 {
-	ti,cluster-mode = <0>;
-	status = "okay";
-};
-
-&main_r5fss1_core0 {
-	status = "okay";
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss1_core0>;
-	memory-region = <&main_r5fss1_core0_dma_memory_region>,
-			<&main_r5fss1_core0_memory_region>;
-};
-
-&main_r5fss1_core1 {
-	status = "okay";
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss1_core1>;
-	memory-region = <&main_r5fss1_core1_dma_memory_region>,
-			<&main_r5fss1_core1_memory_region>;
-};
-
-&c66_0 {
-	status = "okay";
-	mboxes = <&mailbox0_cluster3 &mbox_c66_0>;
-	memory-region = <&c66_0_dma_memory_region>,
-			<&c66_0_memory_region>;
-};
-
-&c66_1 {
-	status = "okay";
-	mboxes = <&mailbox0_cluster3 &mbox_c66_1>;
-	memory-region = <&c66_1_dma_memory_region>,
-			<&c66_1_memory_region>;
-};
-
-&c71_0 {
-	status = "okay";
-	mboxes = <&mailbox0_cluster4 &mbox_c71_0>;
-	memory-region = <&c71_0_dma_memory_region>,
-			<&c71_0_memory_region>;
-};
+#include "k3-j721e-ti-ipc-firmware.dtsi"
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 5d60aa9bc42b..6db3ad63b017 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -59,110 +59,6 @@ mcu_r5fss0_core0_memory_region: r5f-memory@a0100000 {
 			reg = <0x00 0xa0100000 0x00 0xf00000>;
 			no-map;
 		};
-
-		mcu_r5fss0_core1_dma_memory_region: r5f-dma-memory@a1000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa1000000 0x00 0x100000>;
-			no-map;
-		};
-
-		mcu_r5fss0_core1_memory_region: r5f-memory@a1100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa1100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		main_r5fss0_core0_dma_memory_region: r5f-dma-memory@a2000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa2000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss0_core0_memory_region: r5f-memory@a2100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa2100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		main_r5fss0_core1_dma_memory_region: r5f-dma-memory@a3000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa3000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss0_core1_memory_region: r5f-memory@a3100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa3100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		main_r5fss1_core0_dma_memory_region: r5f-dma-memory@a4000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa4000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss1_core0_memory_region: r5f-memory@a4100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa4100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		main_r5fss1_core1_dma_memory_region: r5f-dma-memory@a5000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa5000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss1_core1_memory_region: r5f-memory@a5100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa5100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		/* Carveout locations are flipped due to caching */
-		c66_1_dma_memory_region: c66-dma-memory@a6000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa6000000 0x00 0x100000>;
-			no-map;
-		};
-
-		c66_0_memory_region: c66-memory@a6100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa6100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		/* Carveout locations are flipped due to caching */
-		c66_0_dma_memory_region: c66-dma-memory@a7000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa7000000 0x00 0x100000>;
-			no-map;
-		};
-
-		c66_1_memory_region: c66-memory@a7100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa7100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		c71_0_dma_memory_region: c71-dma-memory@a8000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa8000000 0x00 0x100000>;
-			no-map;
-		};
-
-		c71_0_memory_region: c71-memory@a8100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa8100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		rtos_ipc_memory_region: ipc-memories@aa000000 {
-			reg = <0x00 0xaa000000 0x00 0x01c00000>;
-			alignment = <0x1000>;
-			no-map;
-		};
 	};
 
 	vusb_main: fixedregulator-vusb-main5v0 {
@@ -1281,178 +1177,4 @@ &ufs_wrapper {
 	status = "disabled";
 };
 
-&mailbox0_cluster0 {
-	status = "okay";
-	interrupts = <436>;
-
-	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-
-	mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
-		ti,mbox-rx = <2 0 0>;
-		ti,mbox-tx = <3 0 0>;
-	};
-};
-
-&mailbox0_cluster1 {
-	status = "okay";
-	interrupts = <432>;
-
-	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-
-	mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
-		ti,mbox-rx = <2 0 0>;
-		ti,mbox-tx = <3 0 0>;
-	};
-};
-
-&mailbox0_cluster2 {
-	status = "okay";
-	interrupts = <428>;
-
-	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-
-	mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
-		ti,mbox-rx = <2 0 0>;
-		ti,mbox-tx = <3 0 0>;
-	};
-};
-
-&mailbox0_cluster3 {
-	status = "okay";
-	interrupts = <424>;
-
-	mbox_c66_0: mbox-c66-0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-
-	mbox_c66_1: mbox-c66-1 {
-		ti,mbox-rx = <2 0 0>;
-		ti,mbox-tx = <3 0 0>;
-	};
-};
-
-&mailbox0_cluster4 {
-	status = "okay";
-	interrupts = <420>;
-
-	mbox_c71_0: mbox-c71-0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-};
-
-&mcu_r5fss0 {
-	status = "okay";
-};
-
-&mcu_r5fss0_core0 {
-	status = "okay";
-	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core0>;
-	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
-			<&mcu_r5fss0_core0_memory_region>;
-};
-
-&mcu_r5fss0_core1 {
-	status = "okay";
-	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core1>;
-	memory-region = <&mcu_r5fss0_core1_dma_memory_region>,
-			<&mcu_r5fss0_core1_memory_region>;
-};
-
-&main_r5fss0 {
-	ti,cluster-mode = <0>;
-	status = "okay";
-};
-
-&main_r5fss1 {
-	ti,cluster-mode = <0>;
-	status = "okay";
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
-&main_timer12 {
-	status = "reserved";
-};
-
-&main_timer13 {
-	status = "reserved";
-};
-
-&main_timer14 {
-	status = "reserved";
-};
-
-&main_timer15 {
-	status = "reserved";
-};
-
-&main_r5fss0_core0 {
-	status = "okay";
-	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core0>;
-	memory-region = <&main_r5fss0_core0_dma_memory_region>,
-			<&main_r5fss0_core0_memory_region>;
-};
-
-&main_r5fss0_core1 {
-	status = "okay";
-	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core1>;
-	memory-region = <&main_r5fss0_core1_dma_memory_region>,
-			<&main_r5fss0_core1_memory_region>;
-};
-
-&main_r5fss1_core0 {
-	status = "okay";
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss1_core0>;
-	memory-region = <&main_r5fss1_core0_dma_memory_region>,
-			<&main_r5fss1_core0_memory_region>;
-};
-
-&main_r5fss1_core1 {
-	status = "okay";
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss1_core1>;
-	memory-region = <&main_r5fss1_core1_dma_memory_region>,
-			<&main_r5fss1_core1_memory_region>;
-};
-
-&c66_0 {
-	status = "okay";
-	mboxes = <&mailbox0_cluster3 &mbox_c66_0>;
-	memory-region = <&c66_0_dma_memory_region>,
-			<&c66_0_memory_region>;
-};
-
-&c66_1 {
-	status = "okay";
-	mboxes = <&mailbox0_cluster3 &mbox_c66_1>;
-	memory-region = <&c66_1_dma_memory_region>,
-			<&c66_1_memory_region>;
-};
-
-&c71_0 {
-	status = "okay";
-	mboxes = <&mailbox0_cluster4 &mbox_c71_0>;
-	memory-region = <&c71_0_dma_memory_region>,
-			<&c71_0_memory_region>;
-};
+#include "k3-j721e-ti-ipc-firmware.dtsi"
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
index 795b041ee733..5848ca30524d 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
@@ -40,108 +40,6 @@ mcu_r5fss0_core0_memory_region: r5f-memory@a0100000 {
 			reg = <0x00 0xa0100000 0x00 0xf00000>;
 			no-map;
 		};
-
-		mcu_r5fss0_core1_dma_memory_region: r5f-dma-memory@a1000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa1000000 0x00 0x100000>;
-			no-map;
-		};
-
-		mcu_r5fss0_core1_memory_region: r5f-memory@a1100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa1100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		main_r5fss0_core0_dma_memory_region: r5f-dma-memory@a2000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa2000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss0_core0_memory_region: r5f-memory@a2100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa2100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		main_r5fss0_core1_dma_memory_region: r5f-dma-memory@a3000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa3000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss0_core1_memory_region: r5f-memory@a3100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa3100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		main_r5fss1_core0_dma_memory_region: r5f-dma-memory@a4000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa4000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss1_core0_memory_region: r5f-memory@a4100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa4100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		main_r5fss1_core1_dma_memory_region: r5f-dma-memory@a5000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa5000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss1_core1_memory_region: r5f-memory@a5100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa5100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		c66_1_dma_memory_region: c66-dma-memory@a6000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa6000000 0x00 0x100000>;
-			no-map;
-		};
-
-		c66_0_memory_region: c66-memory@a6100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa6100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		c66_0_dma_memory_region: c66-dma-memory@a7000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa7000000 0x00 0x100000>;
-			no-map;
-		};
-
-		c66_1_memory_region: c66-memory@a7100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa7100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		c71_0_dma_memory_region: c71-dma-memory@a8000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa8000000 0x00 0x100000>;
-			no-map;
-		};
-
-		c71_0_memory_region: c71-memory@a8100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa8100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		rtos_ipc_memory_region: ipc-memories@aa000000 {
-			reg = <0x00 0xaa000000 0x00 0x01c00000>;
-			alignment = <0x1000>;
-			no-map;
-		};
 	};
 };
 
@@ -484,178 +382,4 @@ partition@800000 {
 	};
 };
 
-&mailbox0_cluster0 {
-	status = "okay";
-	interrupts = <436>;
-
-	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-
-	mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
-		ti,mbox-rx = <2 0 0>;
-		ti,mbox-tx = <3 0 0>;
-	};
-};
-
-&mailbox0_cluster1 {
-	status = "okay";
-	interrupts = <432>;
-
-	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-
-	mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
-		ti,mbox-rx = <2 0 0>;
-		ti,mbox-tx = <3 0 0>;
-	};
-};
-
-&mailbox0_cluster2 {
-	status = "okay";
-	interrupts = <428>;
-
-	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-
-	mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
-		ti,mbox-rx = <2 0 0>;
-		ti,mbox-tx = <3 0 0>;
-	};
-};
-
-&mailbox0_cluster3 {
-	status = "okay";
-	interrupts = <424>;
-
-	mbox_c66_0: mbox-c66-0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-
-	mbox_c66_1: mbox-c66-1 {
-		ti,mbox-rx = <2 0 0>;
-		ti,mbox-tx = <3 0 0>;
-	};
-};
-
-&mailbox0_cluster4 {
-	status = "okay";
-	interrupts = <420>;
-
-	mbox_c71_0: mbox-c71-0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-};
-
-&mcu_r5fss0 {
-	status = "okay";
-};
-
-&mcu_r5fss0_core0 {
-	status = "okay";
-	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core0>;
-	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
-			<&mcu_r5fss0_core0_memory_region>;
-};
-
-&mcu_r5fss0_core1 {
-	status = "okay";
-	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core1>;
-	memory-region = <&mcu_r5fss0_core1_dma_memory_region>,
-			<&mcu_r5fss0_core1_memory_region>;
-};
-
-&main_r5fss0 {
-	status = "okay";
-	ti,cluster-mode = <0>;
-};
-
-&main_r5fss1 {
-	status = "okay";
-	ti,cluster-mode = <0>;
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
-&main_timer12 {
-	status = "reserved";
-};
-
-&main_timer13 {
-	status = "reserved";
-};
-
-&main_timer14 {
-	status = "reserved";
-};
-
-&main_timer15 {
-	status = "reserved";
-};
-
-&main_r5fss0_core0 {
-	status = "okay";
-	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core0>;
-	memory-region = <&main_r5fss0_core0_dma_memory_region>,
-			<&main_r5fss0_core0_memory_region>;
-};
-
-&main_r5fss0_core1 {
-	status = "okay";
-	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core1>;
-	memory-region = <&main_r5fss0_core1_dma_memory_region>,
-			<&main_r5fss0_core1_memory_region>;
-};
-
-&main_r5fss1_core0 {
-	status = "okay";
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss1_core0>;
-	memory-region = <&main_r5fss1_core0_dma_memory_region>,
-			<&main_r5fss1_core0_memory_region>;
-};
-
-&main_r5fss1_core1 {
-	status = "okay";
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss1_core1>;
-	memory-region = <&main_r5fss1_core1_dma_memory_region>,
-			<&main_r5fss1_core1_memory_region>;
-};
-
-&c66_0 {
-	status = "okay";
-	mboxes = <&mailbox0_cluster3 &mbox_c66_0>;
-	memory-region = <&c66_0_dma_memory_region>,
-			<&c66_0_memory_region>;
-};
-
-&c66_1 {
-	status = "okay";
-	mboxes = <&mailbox0_cluster3 &mbox_c66_1>;
-	memory-region = <&c66_1_dma_memory_region>,
-			<&c66_1_memory_region>;
-};
-
-&c71_0 {
-	status = "okay";
-	mboxes = <&mailbox0_cluster4 &mbox_c71_0>;
-	memory-region = <&c71_0_dma_memory_region>,
-			<&c71_0_memory_region>;
-};
+#include "k3-j721e-ti-ipc-firmware.dtsi"
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi
new file mode 100644
index 000000000000..5b3fa95aed76
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j721e-ti-ipc-firmware.dtsi
@@ -0,0 +1,288 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/**
+ * Device Tree Source for enabling IPC using TI SDK firmware on J721E SoCs
+ *
+ * Copyright (C) 2018-2025 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+&reserved_memory {
+	mcu_r5fss0_core1_dma_memory_region: r5f-dma-memory@a1000000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa1000000 0x00 0x100000>;
+		no-map;
+	};
+
+	mcu_r5fss0_core1_memory_region: r5f-memory@a1100000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa1100000 0x00 0xf00000>;
+		no-map;
+	};
+
+	main_r5fss0_core0_dma_memory_region: r5f-dma-memory@a2000000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa2000000 0x00 0x100000>;
+		no-map;
+	};
+
+	main_r5fss0_core0_memory_region: r5f-memory@a2100000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa2100000 0x00 0xf00000>;
+		no-map;
+	};
+
+	main_r5fss0_core1_dma_memory_region: r5f-dma-memory@a3000000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa3000000 0x00 0x100000>;
+		no-map;
+	};
+
+	main_r5fss0_core1_memory_region: r5f-memory@a3100000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa3100000 0x00 0xf00000>;
+		no-map;
+	};
+
+	main_r5fss1_core0_dma_memory_region: r5f-dma-memory@a4000000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa4000000 0x00 0x100000>;
+		no-map;
+	};
+
+	main_r5fss1_core0_memory_region: r5f-memory@a4100000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa4100000 0x00 0xf00000>;
+		no-map;
+	};
+
+	main_r5fss1_core1_dma_memory_region: r5f-dma-memory@a5000000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa5000000 0x00 0x100000>;
+		no-map;
+	};
+
+	main_r5fss1_core1_memory_region: r5f-memory@a5100000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa5100000 0x00 0xf00000>;
+		no-map;
+	};
+
+	/* Carveout locations are flipped due to caching */
+	c66_1_dma_memory_region: c66-dma-memory@a6000000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa6000000 0x00 0x100000>;
+		no-map;
+	};
+
+	c66_0_memory_region: c66-memory@a6100000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa6100000 0x00 0xf00000>;
+		no-map;
+	};
+
+	/* Carveout locations are flipped due to caching */
+	c66_0_dma_memory_region: c66-dma-memory@a7000000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa7000000 0x00 0x100000>;
+		no-map;
+	};
+
+	c66_1_memory_region: c66-memory@a7100000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa7100000 0x00 0xf00000>;
+		no-map;
+	};
+
+	c71_0_dma_memory_region: c71-dma-memory@a8000000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa8000000 0x00 0x100000>;
+		no-map;
+	};
+
+	c71_0_memory_region: c71-memory@a8100000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa8100000 0x00 0xf00000>;
+		no-map;
+	};
+
+	rtos_ipc_memory_region: ipc-memories@aa000000 {
+		reg = <0x00 0xaa000000 0x00 0x01c00000>;
+		alignment = <0x1000>;
+		no-map;
+	};
+};
+
+&mailbox0_cluster0 {
+	status = "okay";
+	interrupts = <436>;
+
+	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+
+	mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
+		ti,mbox-rx = <2 0 0>;
+		ti,mbox-tx = <3 0 0>;
+	};
+};
+
+&mailbox0_cluster1 {
+	status = "okay";
+	interrupts = <432>;
+
+	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+
+	mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
+		ti,mbox-rx = <2 0 0>;
+		ti,mbox-tx = <3 0 0>;
+	};
+};
+
+&mailbox0_cluster2 {
+	status = "okay";
+	interrupts = <428>;
+
+	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+
+	mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
+		ti,mbox-rx = <2 0 0>;
+		ti,mbox-tx = <3 0 0>;
+	};
+};
+
+&mailbox0_cluster3 {
+	status = "okay";
+	interrupts = <424>;
+
+	mbox_c66_0: mbox-c66-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+
+	mbox_c66_1: mbox-c66-1 {
+		ti,mbox-rx = <2 0 0>;
+		ti,mbox-tx = <3 0 0>;
+	};
+};
+
+&mailbox0_cluster4 {
+	status = "okay";
+	interrupts = <420>;
+
+	mbox_c71_0: mbox-c71-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
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
+&main_timer12 {
+	status = "reserved";
+};
+
+&main_timer13 {
+	status = "reserved";
+};
+
+&main_timer14 {
+	status = "reserved";
+};
+
+&main_timer15 {
+	status = "reserved";
+};
+
+&mcu_r5fss0 {
+	status = "okay";
+};
+
+&mcu_r5fss0_core0 {
+	status = "okay";
+	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core0>;
+	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
+			<&mcu_r5fss0_core0_memory_region>;
+};
+
+&mcu_r5fss0_core1 {
+	status = "okay";
+	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core1>;
+	memory-region = <&mcu_r5fss0_core1_dma_memory_region>,
+			<&mcu_r5fss0_core1_memory_region>;
+};
+
+&main_r5fss0 {
+	status = "okay";
+	ti,cluster-mode = <0>;
+};
+
+&main_r5fss0_core0 {
+	status = "okay";
+	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core0>;
+	memory-region = <&main_r5fss0_core0_dma_memory_region>,
+			<&main_r5fss0_core0_memory_region>;
+};
+
+&main_r5fss0_core1 {
+	status = "okay";
+	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core1>;
+	memory-region = <&main_r5fss0_core1_dma_memory_region>,
+			<&main_r5fss0_core1_memory_region>;
+};
+
+&main_r5fss1 {
+	status = "okay";
+	ti,cluster-mode = <0>;
+};
+
+&main_r5fss1_core0 {
+	status = "okay";
+	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss1_core0>;
+	memory-region = <&main_r5fss1_core0_dma_memory_region>,
+			<&main_r5fss1_core0_memory_region>;
+};
+
+&main_r5fss1_core1 {
+	status = "okay";
+	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss1_core1>;
+	memory-region = <&main_r5fss1_core1_dma_memory_region>,
+			<&main_r5fss1_core1_memory_region>;
+};
+
+&c66_0 {
+	status = "okay";
+	mboxes = <&mailbox0_cluster3 &mbox_c66_0>;
+	memory-region = <&c66_0_dma_memory_region>,
+			<&c66_0_memory_region>;
+};
+
+&c66_1 {
+	status = "okay";
+	mboxes = <&mailbox0_cluster3 &mbox_c66_1>;
+	memory-region = <&c66_1_dma_memory_region>,
+			<&c66_1_memory_region>;
+};
+
+&c71_0 {
+	status = "okay";
+	mboxes = <&mailbox0_cluster4 &mbox_c71_0>;
+	memory-region = <&c71_0_dma_memory_region>,
+			<&c71_0_memory_region>;
+};
-- 
2.34.1



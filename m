Return-Path: <linux-kernel+bounces-806083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8A2B491A2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B015A442A1A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C0330F928;
	Mon,  8 Sep 2025 14:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Us2+fJcR"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5C430F80D;
	Mon,  8 Sep 2025 14:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341875; cv=none; b=IovS/J2nxAvW/j+yLDfX4J5rqb9IC4RAL8dQpjp9YHzPwmgorhil7N8lXku+b6tZVSQ2WfcLgVi5QzuU3YWx0cz3SHr4YoeGQWjcPyR1Jqvtec9BSDrlKZjF9Y/yjkZGdtcH+QIcPj4D6bDsmW8vhGbcQNbqFMjlfjShFoWMQdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341875; c=relaxed/simple;
	bh=8sk9NBu/mORPG3xmvxzjVWZn7Q7auVhDqf7MBvjz4nw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cqmLt9UJvX6SzDtJpHpo6Zxa5YHWoiExe+uutxyaZuPE69FNilmxOz7zco2409SLwtCynL5L/+iivY3y+AqlxbuLSEsFyZQD81yn1GrCCN0smyMoQRBybTpJAwBOkhh0ySV1jEH8qcGO3vmwK4aerlbR7OqisGxS3Bsn2Kdc8A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Us2+fJcR; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 588EV7wV120788;
	Mon, 8 Sep 2025 09:31:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757341867;
	bh=sa7ziBvWuSpTEhnrDn0U4/Ct1WKocaZ48qqQlOTeToo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Us2+fJcRA+Y+96nX6Kd3c0yHDzjxUnLHN2Xvpo42Og4DQyghgGDqDaF+JSvn+6sPF
	 5C7PcffSZfoPIZzNAjaUKh55IM5WjwZhLcKQnPnEdLzZdYYszvqv/0Gn3v9doXdx+U
	 jCuMbWuar/fV40o4QqP+n9t7SnMmA00fhPEkdIoA=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 588EV7qU3021707
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 09:31:07 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 09:31:06 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 09:31:06 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 588ESed41037553;
	Mon, 8 Sep 2025 09:31:02 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <d-gole@ti.com>, <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 26/34] arm64: dts: ti: k3-j721s2-ti-ipc-firmware: Refactor IPC cfg into new dtsi
Date: Mon, 8 Sep 2025 19:58:18 +0530
Message-ID: <20250908142826.1828676-27-b-padhi@ti.com>
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

The TI K3 J721S2 SoCs have multiple programmable remote processors like
R5F, C7x etc. The TI SDKs for J721S2 SoCs offer sample firmwares which
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
1. Updated carveout node names to generic 'memory@addr'

Link to v3:
https://lore.kernel.org/all/20250905051846.1189612-26-b-padhi@ti.com/

v3: Changelog:
1. None

Link to v2:
https://lore.kernel.org/all/20250823160901.2177841-26-b-padhi@ti.com/

v2: Changelog:
1. Re-ordered patch from [PATCH 09/33] to [PATCH v2 25/33].

Link to v1:
https://lore.kernel.org/all/20250814223839.3256046-10-b-padhi@ti.com/

 .../boot/dts/ti/k3-am68-phycore-som.dtsi      | 247 +----------------
 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi    | 241 +----------------
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  | 243 +----------------
 .../dts/ti/k3-j721s2-ti-ipc-firmware.dtsi     | 253 ++++++++++++++++++
 4 files changed, 258 insertions(+), 726 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-ti-ipc-firmware.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-am68-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am68-phycore-som.dtsi
index b9c60e078d21..adef02bd8040 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am68-phycore-som.dtsi
@@ -60,96 +60,6 @@ mcu_r5fss0_core0_memory_region: memory@a0100000 {
 			reg = <0x00 0xa0100000 0x00 0xf00000>;
 			no-map;
 		};
-
-		mcu_r5fss0_core1_dma_memory_region: memory@a1000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa1000000 0x00 0x100000>;
-			no-map;
-		};
-
-		mcu_r5fss0_core1_memory_region: memory@a1100000 {
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
-		main_r5fss0_core1_dma_memory_region: memory@a3000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa3000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss0_core1_memory_region: memory@a3100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa3100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		main_r5fss1_core0_dma_memory_region: memory@a4000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa4000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss1_core0_memory_region: memory@a4100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa4100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		main_r5fss1_core1_dma_memory_region: memory@a5000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa5000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss1_core1_memory_region: memory@a5100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa5100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		c71_0_dma_memory_region: memory@a6000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa6000000 0x00 0x100000>;
-			no-map;
-		};
-
-		c71_0_memory_region: memory@a6100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa6100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		c71_1_dma_memory_region: memory@a7000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa7000000 0x00 0x100000>;
-			no-map;
-		};
-
-		c71_1_memory_region: memory@a7100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa7100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		rtos_ipc_memory_region: memory@a8000000 {
-			reg = <0x00 0xa8000000 0x00 0x01c00000>;
-			alignment = <0x1000>;
-			no-map;
-		};
 	};
 
 	vdd_sd_dv: regulator-sd {
@@ -243,80 +153,6 @@ J721S2_WKUP_IOPAD(0x09c, PIN_INPUT_PULLUP, 0) /* (H27) WKUP_I2C0_SDA */
 	};
 };
 
-&c71_0 {
-	mboxes = <&mailbox0_cluster4 &mbox_c71_0>;
-	memory-region = <&c71_0_dma_memory_region>,
-			<&c71_0_memory_region>;
-	status = "okay";
-};
-
-&c71_1 {
-	mboxes = <&mailbox0_cluster4 &mbox_c71_1>;
-	memory-region = <&c71_1_dma_memory_region>,
-			<&c71_1_memory_region>;
-	status = "okay";
-};
-
-&mailbox0_cluster0 {
-	interrupts = <436>;
-	status = "okay";
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
-	interrupts = <432>;
-	status = "okay";
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
-	interrupts = <428>;
-	status = "okay";
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
-&mailbox0_cluster4 {
-	interrupts = <420>;
-	status = "okay";
-
-	mbox_c71_0: mbox-c71-0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-
-	mbox_c71_1: mbox-c71-1 {
-		ti,mbox-rx = <2 0 0>;
-		ti,mbox-tx = <3 0 0>;
-	};
-};
-
 &main_cpsw {
 	pinctrl-names = "default";
 	pinctrl-0 = <&rgmii1_pins_default>;
@@ -367,34 +203,6 @@ &main_gpio0 {
 	status = "okay";
 };
 
-&main_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core0>;
-	memory-region = <&main_r5fss0_core0_dma_memory_region>,
-			<&main_r5fss0_core0_memory_region>;
-	status = "okay";
-};
-
-&main_r5fss0_core1 {
-	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core1>;
-	memory-region = <&main_r5fss0_core1_dma_memory_region>,
-			<&main_r5fss0_core1_memory_region>;
-	status = "okay";
-};
-
-&main_r5fss1_core0 {
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss1_core0>;
-	memory-region = <&main_r5fss1_core0_dma_memory_region>,
-			<&main_r5fss1_core0_memory_region>;
-	status = "okay";
-};
-
-&main_r5fss1_core1 {
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss1_core1>;
-	memory-region = <&main_r5fss1_core1_dma_memory_region>,
-			<&main_r5fss1_core1_memory_region>;
-	status = "okay";
-};
-
 /* eMMC */
 &main_sdhci0 {
 	non-removable;
@@ -409,59 +217,6 @@ &main_sdhci1 {
 	bootph-all;
 };
 
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
-&main_timer3 {
-	status = "reserved";
-};
-
-&main_timer4 {
-	status = "reserved";
-};
-
-&main_timer5 {
-	status = "reserved";
-};
-
-&mcu_r5fss0 {
-	status = "okay";
-};
-
-&mcu_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core0>;
-	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
-			<&mcu_r5fss0_core0_memory_region>;
-	status = "okay";
-};
-
-&mcu_r5fss0_core1 {
-	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core1>;
-	memory-region = <&mcu_r5fss0_core1_dma_memory_region>,
-			<&mcu_r5fss0_core1_memory_region>;
-	status = "okay";
-};
-
 &ospi0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
@@ -611,3 +366,5 @@ som_eeprom_opt: eeprom@51 {
 		pagesize = <32>;
 	};
 };
+
+#include "k3-j721s2-ti-ipc-firmware.dtsi"
diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi b/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
index c423b1443e0c..6a6dc816b658 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
@@ -38,96 +38,6 @@ mcu_r5fss0_core0_memory_region: memory@a0100000 {
 			reg = <0x00 0xa0100000 0x00 0xf00000>;
 			no-map;
 		};
-
-		mcu_r5fss0_core1_dma_memory_region: memory@a1000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa1000000 0x00 0x100000>;
-			no-map;
-		};
-
-		mcu_r5fss0_core1_memory_region: memory@a1100000 {
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
-		main_r5fss0_core1_dma_memory_region: memory@a3000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa3000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss0_core1_memory_region: memory@a3100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa3100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		main_r5fss1_core0_dma_memory_region: memory@a4000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa4000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss1_core0_memory_region: memory@a4100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa4100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		main_r5fss1_core1_dma_memory_region: memory@a5000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa5000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss1_core1_memory_region: memory@a5100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa5100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		c71_0_dma_memory_region: memory@a6000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa6000000 0x00 0x100000>;
-			no-map;
-		};
-
-		c71_0_memory_region: memory@a6100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa6100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		c71_1_dma_memory_region: memory@a7000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa7000000 0x00 0x100000>;
-			no-map;
-		};
-
-		c71_1_memory_region: memory@a7100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa7100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		rtos_ipc_memory_region: memory@a8000000 {
-			reg = <0x00 0xa8000000 0x00 0x01c00000>;
-			alignment = <0x1000>;
-			no-map;
-		};
 	};
 };
 
@@ -235,153 +145,4 @@ partition@3fc0000 {
 	};
 };
 
-&mailbox0_cluster0 {
-	status = "okay";
-	interrupts = <436>;
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
-&mailbox0_cluster4 {
-	status = "okay";
-	interrupts = <420>;
-	mbox_c71_0: mbox-c71-0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-
-	mbox_c71_1: mbox-c71-1 {
-		ti,mbox-rx = <2 0 0>;
-		ti,mbox-tx = <3 0 0>;
-	};
-};
-
-&mcu_r5fss0 {
-	status = "okay";
-};
-
-&mcu_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core0>;
-	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
-			<&mcu_r5fss0_core0_memory_region>;
-	status = "okay";
-};
-
-&mcu_r5fss0_core1 {
-	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core1>;
-	memory-region = <&mcu_r5fss0_core1_dma_memory_region>,
-			<&mcu_r5fss0_core1_memory_region>;
-	status = "okay";
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
-&main_timer3 {
-	status = "reserved";
-};
-
-&main_timer4 {
-	status = "reserved";
-};
-
-&main_timer5 {
-	status = "reserved";
-};
-
-&main_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core0>;
-	memory-region = <&main_r5fss0_core0_dma_memory_region>,
-			<&main_r5fss0_core0_memory_region>;
-	status = "okay";
-};
-
-&main_r5fss0_core1 {
-	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core1>;
-	memory-region = <&main_r5fss0_core1_dma_memory_region>,
-			<&main_r5fss0_core1_memory_region>;
-	status = "okay";
-};
-
-&main_r5fss1_core0 {
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss1_core0>;
-	memory-region = <&main_r5fss1_core0_dma_memory_region>,
-			<&main_r5fss1_core0_memory_region>;
-	status = "okay";
-};
-
-&main_r5fss1_core1 {
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss1_core1>;
-	memory-region = <&main_r5fss1_core1_dma_memory_region>,
-			<&main_r5fss1_core1_memory_region>;
-	status = "okay";
-};
-
-&c71_0 {
-	status = "okay";
-	mboxes = <&mailbox0_cluster4 &mbox_c71_0>;
-	memory-region = <&c71_0_dma_memory_region>,
-			<&c71_0_memory_region>;
-};
-
-&c71_1 {
-	status = "okay";
-	mboxes = <&mailbox0_cluster4 &mbox_c71_1>;
-	memory-region = <&c71_1_dma_memory_region>,
-			<&c71_1_memory_region>;
-};
+#include "k3-j721s2-ti-ipc-firmware.dtsi"
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
index ff5264d4c2da..12a38dd1514b 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
@@ -42,96 +42,6 @@ mcu_r5fss0_core0_memory_region: memory@a0100000 {
 			reg = <0x00 0xa0100000 0x00 0xf00000>;
 			no-map;
 		};
-
-		mcu_r5fss0_core1_dma_memory_region: memory@a1000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa1000000 0x00 0x100000>;
-			no-map;
-		};
-
-		mcu_r5fss0_core1_memory_region: memory@a1100000 {
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
-		main_r5fss0_core1_dma_memory_region: memory@a3000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa3000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss0_core1_memory_region: memory@a3100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa3100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		main_r5fss1_core0_dma_memory_region: memory@a4000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa4000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss1_core0_memory_region: memory@a4100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa4100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		main_r5fss1_core1_dma_memory_region: memory@a5000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa5000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss1_core1_memory_region: memory@a5100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa5100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		c71_0_dma_memory_region: memory@a6000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa6000000 0x00 0x100000>;
-			no-map;
-		};
-
-		c71_0_memory_region: memory@a6100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa6100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		c71_1_dma_memory_region: memory@a7000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa7000000 0x00 0x100000>;
-			no-map;
-		};
-
-		c71_1_memory_region: memory@a7100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa7100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		rtos_ipc_memory_region: memory@a8000000 {
-			reg = <0x00 0xa8000000 0x00 0x01c00000>;
-			alignment = <0x1000>;
-			no-map;
-		};
 	};
 
 	mux0: mux-controller-0 {
@@ -516,157 +426,6 @@ partition@3fc0000 {
 	};
 };
 
-&mailbox0_cluster0 {
-	status = "okay";
-	interrupts = <436>;
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
-&mailbox0_cluster4 {
-	status = "okay";
-	interrupts = <420>;
-	mbox_c71_0: mbox-c71-0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-
-	mbox_c71_1: mbox-c71-1 {
-		ti,mbox-rx = <2 0 0>;
-		ti,mbox-tx = <3 0 0>;
-	};
-};
-
-&mcu_r5fss0 {
-	status = "okay";
-};
-
-&mcu_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core0>;
-	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
-			<&mcu_r5fss0_core0_memory_region>;
-	status = "okay";
-};
-
-&mcu_r5fss0_core1 {
-	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core1>;
-	memory-region = <&mcu_r5fss0_core1_dma_memory_region>,
-			<&mcu_r5fss0_core1_memory_region>;
-	status = "okay";
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
-&main_timer3 {
-	status = "reserved";
-};
-
-&main_timer4 {
-	status = "reserved";
-};
-
-&main_timer5 {
-	status = "reserved";
-};
-
-&main_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core0>;
-	memory-region = <&main_r5fss0_core0_dma_memory_region>,
-			<&main_r5fss0_core0_memory_region>;
-	status = "okay";
-};
-
-&main_r5fss0_core1 {
-	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core1>;
-	memory-region = <&main_r5fss0_core1_dma_memory_region>,
-			<&main_r5fss0_core1_memory_region>;
-	status = "okay";
-};
-
-&main_r5fss1_core0 {
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss1_core0>;
-	memory-region = <&main_r5fss1_core0_dma_memory_region>,
-			<&main_r5fss1_core0_memory_region>;
-	status = "okay";
-};
-
-&main_r5fss1_core1 {
-	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss1_core1>;
-	memory-region = <&main_r5fss1_core1_dma_memory_region>,
-			<&main_r5fss1_core1_memory_region>;
-	status = "okay";
-};
-
-&c71_0 {
-	status = "okay";
-	mboxes = <&mailbox0_cluster4 &mbox_c71_0>;
-	memory-region = <&c71_0_dma_memory_region>,
-			<&c71_0_memory_region>;
-};
-
-&c71_1 {
-	status = "okay";
-	mboxes = <&mailbox0_cluster4 &mbox_c71_1>;
-	memory-region = <&c71_1_dma_memory_region>,
-			<&c71_1_memory_region>;
-};
-
 &main_i2c4 {
 	bridge_dsi_edp: bridge-dsi-edp@2c {
 		compatible = "ti,sn65dsi86";
@@ -693,3 +452,5 @@ port@1 {
 		};
 	};
 };
+
+#include "k3-j721s2-ti-ipc-firmware.dtsi"
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-ti-ipc-firmware.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-ti-ipc-firmware.dtsi
new file mode 100644
index 000000000000..ebab0cc580bb
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-ti-ipc-firmware.dtsi
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/**
+ * Device Tree Source for enabling IPC using TI SDK firmware on J721S2 SoCs
+ *
+ * Copyright (C) 2021-2025 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+&reserved_memory {
+	mcu_r5fss0_core1_dma_memory_region: memory@a1000000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa1000000 0x00 0x100000>;
+		no-map;
+	};
+
+	mcu_r5fss0_core1_memory_region: memory@a1100000 {
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
+	main_r5fss0_core1_dma_memory_region: memory@a3000000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa3000000 0x00 0x100000>;
+		no-map;
+	};
+
+	main_r5fss0_core1_memory_region: memory@a3100000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa3100000 0x00 0xf00000>;
+		no-map;
+	};
+
+	main_r5fss1_core0_dma_memory_region: memory@a4000000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa4000000 0x00 0x100000>;
+		no-map;
+	};
+
+	main_r5fss1_core0_memory_region: memory@a4100000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa4100000 0x00 0xf00000>;
+		no-map;
+	};
+
+	main_r5fss1_core1_dma_memory_region: memory@a5000000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa5000000 0x00 0x100000>;
+		no-map;
+	};
+
+	main_r5fss1_core1_memory_region: memory@a5100000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa5100000 0x00 0xf00000>;
+		no-map;
+	};
+
+	c71_0_dma_memory_region: memory@a6000000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa6000000 0x00 0x100000>;
+		no-map;
+	};
+
+	c71_0_memory_region: memory@a6100000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa6100000 0x00 0xf00000>;
+		no-map;
+	};
+
+	c71_1_dma_memory_region: memory@a7000000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa7000000 0x00 0x100000>;
+		no-map;
+	};
+
+	c71_1_memory_region: memory@a7100000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa7100000 0x00 0xf00000>;
+		no-map;
+	};
+
+	rtos_ipc_memory_region: memory@a8000000 {
+		reg = <0x00 0xa8000000 0x00 0x01c00000>;
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
+&mailbox0_cluster4 {
+	status = "okay";
+	interrupts = <420>;
+
+	mbox_c71_0: mbox-c71-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+
+	mbox_c71_1: mbox-c71-1 {
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
+&main_timer3 {
+	status = "reserved";
+};
+
+&main_timer4 {
+	status = "reserved";
+};
+
+&main_timer5 {
+	status = "reserved";
+};
+
+&mcu_r5fss0 {
+	status = "okay";
+};
+
+&mcu_r5fss0_core0 {
+	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core0>;
+	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
+			<&mcu_r5fss0_core0_memory_region>;
+	status = "okay";
+};
+
+&mcu_r5fss0_core1 {
+	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core1>;
+	memory-region = <&mcu_r5fss0_core1_dma_memory_region>,
+			<&mcu_r5fss0_core1_memory_region>;
+	status = "okay";
+};
+
+&main_r5fss0 {
+	ti,cluster-mode = <0>;
+	status = "okay";
+};
+
+&main_r5fss0_core0 {
+	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core0>;
+	memory-region = <&main_r5fss0_core0_dma_memory_region>,
+			<&main_r5fss0_core0_memory_region>;
+	status = "okay";
+};
+
+&main_r5fss0_core1 {
+	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core1>;
+	memory-region = <&main_r5fss0_core1_dma_memory_region>,
+			<&main_r5fss0_core1_memory_region>;
+	status = "okay";
+};
+
+&main_r5fss1 {
+	ti,cluster-mode = <0>;
+	status = "okay";
+};
+
+&main_r5fss1_core0 {
+	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss1_core0>;
+	memory-region = <&main_r5fss1_core0_dma_memory_region>,
+			<&main_r5fss1_core0_memory_region>;
+	status = "okay";
+};
+
+&main_r5fss1_core1 {
+	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss1_core1>;
+	memory-region = <&main_r5fss1_core1_dma_memory_region>,
+			<&main_r5fss1_core1_memory_region>;
+	status = "okay";
+};
+
+&c71_0 {
+	status = "okay";
+	mboxes = <&mailbox0_cluster4 &mbox_c71_0>;
+	memory-region = <&c71_0_dma_memory_region>,
+			<&c71_0_memory_region>;
+};
+
+&c71_1 {
+	status = "okay";
+	mboxes = <&mailbox0_cluster4 &mbox_c71_1>;
+	memory-region = <&c71_1_dma_memory_region>,
+			<&c71_1_memory_region>;
+};
-- 
2.34.1



Return-Path: <linux-kernel+bounces-806084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 898BFB4919C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E2B51885FDB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D9F3126C4;
	Mon,  8 Sep 2025 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uantz9i9"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789E2311C3C;
	Mon,  8 Sep 2025 14:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341879; cv=none; b=Ntw12fzOZIAiZ8fJStI8U3F228vCNiMr415JHAlj39IJFF/zlM//b/ylhcTbs6g0IpI3hplIV+OJvIOQTxXE33M+38zu9Ft71cDMtlBylQt95itm49FQMMLpDQ5F29m2A4XtX52MuSv+HlkBVmE+X/TYbc+G+gYn0NMdOCKMgdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341879; c=relaxed/simple;
	bh=ds3JZTLOyODrcFo2OhQRn7FTy18YmqZ8g9283Ko6qig=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P+Hcdwqq9/Laq93XJlqo/5vcQKCfo108H353wjtyQ7AOhONA4vtCHBPPwvXaaD9oVCQ6KjCJ0eLxXiJWpRcPiGVGWrLZGaQZpVTLBIqCL09af0CPE3EzRy4gCPjjRCdnb5w0PbVvqNC5RkxDI/xz5DMjQ+nn/mrNjkgaECUuErc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uantz9i9; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 588EVCPh072014;
	Mon, 8 Sep 2025 09:31:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757341872;
	bh=MH0xX+dhSv7i49x0cohSOWvXUbZdl/0yPB/++ZXeBvk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=uantz9i9o9m/+pbXCKNPf0dQ055WlEm4kvIL0ZOWWBYMe+rHOJKYLRYC92aMK9BAl
	 ZEUhfMer5pRR1GfVPs7n0Anv+Eqt+MQf2eZCj6h/HKjM+rLbNzMj1LLgB4NmvOSdim
	 jAVpoHa6sDf7FOtf2SBLcIKqVWr9JBUsDwZ+btW4=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 588EVBbh3835934
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 09:31:12 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 09:31:11 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 09:31:11 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 588ESed51037553;
	Mon, 8 Sep 2025 09:31:07 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <d-gole@ti.com>, <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 27/34] arm64: dts: ti: k3-j784s4-j742s2-ti-ipc-firmware-common: Refactor IPC cfg into new dtsi
Date: Mon, 8 Sep 2025 19:58:19 +0530
Message-ID: <20250908142826.1828676-28-b-padhi@ti.com>
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

The TI K3 J784S4/J742S2 SoCs have multiple programmable remote
processors like R5F, C7x etc. The TI SDKs for J784S4/J742S2 SoCs offer
sample firmwares which could be run on these cores to demonstrate an
"echo" IPC test. Those firmware require certain memory carveouts to be
reserved from system memory, timers to be reserved, and certain mailbox
configurations for interrupt based messaging. These configurations could
be different for a different firmware.

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
https://lore.kernel.org/all/20250905051846.1189612-27-b-padhi@ti.com/

v3: Changelog:
1. None

Link to v2:
https://lore.kernel.org/all/20250823160901.2177841-27-b-padhi@ti.com/

v2: Changelog:
1. Re-ordered patch from [PATCH 11/33] to [PATCH v2 26/33].

Link to v1:
https://lore.kernel.org/all/20250814223839.3256046-12-b-padhi@ti.com/

 arch/arm64/boot/dts/ti/k3-am69-sk.dts         | 336 +----------------
 .../dts/ti/k3-j784s4-j742s2-evm-common.dtsi   | 344 +----------------
 ...-j784s4-j742s2-ti-ipc-firmware-common.dtsi | 350 ++++++++++++++++++
 3 files changed, 354 insertions(+), 676 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index 60817c1f3104..3be74d828d84 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -61,126 +61,6 @@ mcu_r5fss0_core0_memory_region: memory@a0100000 {
 			no-map;
 		};
 
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
-		main_r5fss2_core0_dma_memory_region: memory@a6000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa6000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss2_core0_memory_region: memory@a6100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa6100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		main_r5fss2_core1_dma_memory_region: memory@a7000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa7000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss2_core1_memory_region: memory@a7100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa7100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		c71_0_dma_memory_region: memory@a8000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa8000000 0x00 0x100000>;
-			no-map;
-		};
-
-		c71_0_memory_region: memory@a8100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa8100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		c71_1_dma_memory_region: memory@a9000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa9000000 0x00 0x100000>;
-			no-map;
-		};
-
-		c71_1_memory_region: memory@a9100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa9100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		c71_2_dma_memory_region: memory@aa000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xaa000000 0x00 0x100000>;
-			no-map;
-		};
-
-		c71_2_memory_region: memory@aa100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xaa100000 0x00 0xf00000>;
-			no-map;
-		};
-
 		c71_3_dma_memory_region: memory@ab000000 {
 			compatible = "shared-dma-pool";
 			reg = <0x00 0xab000000 0x00 0x100000>;
@@ -640,84 +520,7 @@ &phy_gmii_sel {
 	bootph-all;
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
-&mailbox0_cluster3 {
-	status = "okay";
-	interrupts = <424>;
-	mbox_main_r5fss2_core0: mbox-main-r5fss2-core0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-
-	mbox_main_r5fss2_core1: mbox-main-r5fss2-core1 {
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
 &mailbox0_cluster5 {
-	status = "okay";
-	interrupts = <416>;
-	mbox_c71_2: mbox-c71-2 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-
 	mbox_c71_3: mbox-c71-3 {
 		ti,mbox-rx = <2 0 0>;
 		ti,mbox-tx = <3 0 0>;
@@ -992,143 +795,6 @@ &mcu_cpsw_port1 {
 	bootph-all;
 };
 
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
-&main_timer6 {
-	status = "reserved";
-};
-
-&main_timer7 {
-	status = "reserved";
-};
-
-&main_timer8 {
-	status = "reserved";
-};
-
-&main_timer9 {
-	status = "reserved";
-};
-
-&main_r5fss2 {
-	ti,cluster-mode = <0>;
-	status = "okay";
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
-&main_r5fss2_core0 {
-	mboxes = <&mailbox0_cluster3 &mbox_main_r5fss2_core0>;
-	memory-region = <&main_r5fss2_core0_dma_memory_region>,
-			<&main_r5fss2_core0_memory_region>;
-	status = "okay";
-};
-
-&main_r5fss2_core1 {
-	mboxes = <&mailbox0_cluster3 &mbox_main_r5fss2_core1>;
-	memory-region = <&main_r5fss2_core1_dma_memory_region>,
-			<&main_r5fss2_core1_memory_region>;
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
-&c71_2 {
-	status = "okay";
-	mboxes = <&mailbox0_cluster5 &mbox_c71_2>;
-	memory-region = <&c71_2_dma_memory_region>,
-			<&c71_2_memory_region>;
-};
-
 &c71_3 {
 	status = "okay";
 	mboxes = <&mailbox0_cluster5 &mbox_c71_3>;
@@ -1418,3 +1084,5 @@ &usb0 {
 	phys = <&serdes0_usb_link>;
 	phy-names = "cdns3,usb3-phy";
 };
+
+#include "k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi"
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
index fdde1bd0e831..419c1a70e028 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
@@ -46,126 +46,6 @@ mcu_r5fss0_core0_memory_region: memory@a0100000 {
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
-		main_r5fss2_core0_dma_memory_region: memory@a6000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa6000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss2_core0_memory_region: memory@a6100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa6100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		main_r5fss2_core1_dma_memory_region: memory@a7000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa7000000 0x00 0x100000>;
-			no-map;
-		};
-
-		main_r5fss2_core1_memory_region: memory@a7100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa7100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		c71_0_dma_memory_region: memory@a8000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa8000000 0x00 0x100000>;
-			no-map;
-		};
-
-		c71_0_memory_region: memory@a8100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa8100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		c71_1_dma_memory_region: memory@a9000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa9000000 0x00 0x100000>;
-			no-map;
-		};
-
-		c71_1_memory_region: memory@a9100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xa9100000 0x00 0xf00000>;
-			no-map;
-		};
-
-		c71_2_dma_memory_region: memory@aa000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xaa000000 0x00 0x100000>;
-			no-map;
-		};
-
-		c71_2_memory_region: memory@aa100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xaa100000 0x00 0xf00000>;
-			no-map;
-		};
 	};
 
 	evm_12v0: regulator-evm12v0 {
@@ -1069,228 +949,6 @@ &main_cpsw1_port1 {
 	status = "okay";
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
-	mbox_main_r5fss2_core0: mbox-main-r5fss2-core0 {
-		ti,mbox-rx = <0 0 0>;
-		ti,mbox-tx = <1 0 0>;
-	};
-
-	mbox_main_r5fss2_core1: mbox-main-r5fss2-core1 {
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
-
-	mbox_c71_1: mbox-c71-1 {
-		ti,mbox-rx = <2 0 0>;
-		ti,mbox-tx = <3 0 0>;
-	};
-};
-
-&mailbox0_cluster5 {
-	status = "okay";
-	interrupts = <416>;
-
-	mbox_c71_2: mbox-c71-2 {
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
-&main_r5fss2 {
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
-&main_timer6 {
-	status = "reserved";
-};
-
-&main_timer7 {
-	status = "reserved";
-};
-
-&main_timer8 {
-	status = "reserved";
-};
-
-&main_timer9 {
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
-&main_r5fss2_core0 {
-	status = "okay";
-	mboxes = <&mailbox0_cluster3 &mbox_main_r5fss2_core0>;
-	memory-region = <&main_r5fss2_core0_dma_memory_region>,
-			<&main_r5fss2_core0_memory_region>;
-};
-
-&main_r5fss2_core1 {
-	status = "okay";
-	mboxes = <&mailbox0_cluster3 &mbox_main_r5fss2_core1>;
-	memory-region = <&main_r5fss2_core1_dma_memory_region>,
-			<&main_r5fss2_core1_memory_region>;
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
-&c71_2 {
-	status = "okay";
-	mboxes = <&mailbox0_cluster5 &mbox_c71_2>;
-	memory-region = <&c71_2_dma_memory_region>,
-			<&c71_2_memory_region>;
-};
-
 &tscadc0 {
 	pinctrl-0 = <&mcu_adc0_pins_default>;
 	pinctrl-names = "default";
@@ -1619,3 +1277,5 @@ &mcasp0 {
 		0 0 0 0
 	>;
 };
+
+#include "k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi"
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi
new file mode 100644
index 000000000000..455397227d4a
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi
@@ -0,0 +1,350 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/**
+ * Device Tree Source for enabling IPC using TI SDK firmware on J784S4/J742S2 SoCs
+ *
+ * Copyright (C) 2022-2025 Texas Instruments Incorporated - https://www.ti.com/
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
+	main_r5fss2_core0_dma_memory_region: memory@a6000000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa6000000 0x00 0x100000>;
+		no-map;
+	};
+
+	main_r5fss2_core0_memory_region: memory@a6100000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa6100000 0x00 0xf00000>;
+		no-map;
+	};
+
+	main_r5fss2_core1_dma_memory_region: memory@a7000000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa7000000 0x00 0x100000>;
+		no-map;
+	};
+
+	main_r5fss2_core1_memory_region: memory@a7100000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa7100000 0x00 0xf00000>;
+		no-map;
+	};
+
+	c71_0_dma_memory_region: memory@a8000000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa8000000 0x00 0x100000>;
+		no-map;
+	};
+
+	c71_0_memory_region: memory@a8100000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa8100000 0x00 0xf00000>;
+		no-map;
+	};
+
+	c71_1_dma_memory_region: memory@a9000000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa9000000 0x00 0x100000>;
+		no-map;
+	};
+
+	c71_1_memory_region: memory@a9100000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xa9100000 0x00 0xf00000>;
+		no-map;
+	};
+
+	c71_2_dma_memory_region: memory@aa000000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xaa000000 0x00 0x100000>;
+		no-map;
+	};
+
+	c71_2_memory_region: memory@aa100000 {
+		compatible = "shared-dma-pool";
+		reg = <0x00 0xaa100000 0x00 0xf00000>;
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
+	mbox_main_r5fss2_core0: mbox-main-r5fss2-core0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+
+	mbox_main_r5fss2_core1: mbox-main-r5fss2-core1 {
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
+&mailbox0_cluster5 {
+	status = "okay";
+	interrupts = <416>;
+
+	mbox_c71_2: mbox-c71-2 {
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
+&main_timer6 {
+	status = "reserved";
+};
+
+&main_timer7 {
+	status = "reserved";
+};
+
+&main_timer8 {
+	status = "reserved";
+};
+
+&main_timer9 {
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
+	ti,cluster-mode = <0>;
+	status = "okay";
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
+	ti,cluster-mode = <0>;
+	status = "okay";
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
+&main_r5fss2 {
+	ti,cluster-mode = <0>;
+	status = "okay";
+};
+
+&main_r5fss2_core0 {
+	status = "okay";
+	mboxes = <&mailbox0_cluster3 &mbox_main_r5fss2_core0>;
+	memory-region = <&main_r5fss2_core0_dma_memory_region>,
+			<&main_r5fss2_core0_memory_region>;
+};
+
+&main_r5fss2_core1 {
+	status = "okay";
+	mboxes = <&mailbox0_cluster3 &mbox_main_r5fss2_core1>;
+	memory-region = <&main_r5fss2_core1_dma_memory_region>,
+			<&main_r5fss2_core1_memory_region>;
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
+
+&c71_2 {
+	status = "okay";
+	mboxes = <&mailbox0_cluster5 &mbox_c71_2>;
+	memory-region = <&c71_2_dma_memory_region>,
+			<&c71_2_memory_region>;
+};
-- 
2.34.1



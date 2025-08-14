Return-Path: <linux-kernel+bounces-769671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B225B271BD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 00:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 306D85A79F9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 22:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73B4286D7C;
	Thu, 14 Aug 2025 22:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qOSvyO/B"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CCB2836B4;
	Thu, 14 Aug 2025 22:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755211196; cv=none; b=aPoAK+JXEAuJeYG+HqVHDuKukOrTZx3hmwHggoELbhl/vccgIzUErt4yXMPbxckDYYZsNznLZrj1YTWBdggDvPTrj92tMFOMi0AX3NQMpGm8bO5uMmdzooEw3BaudZv+gFZFem3hiA6lKU6aBPLbpVQXsggqWaXe0fp9D30d4jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755211196; c=relaxed/simple;
	bh=z2OZ8jkAkgxeRPFNUf1mN1lqYFwzBiGFcDJXJprvk8M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VOkFVlZ7EMoPGLR87kHTA9TTB6yBeqqBeAz+jH9ZM2uQR1/xBhu77M9wL4UkLtQbXDD2Hvi9PdT5LiPMJq/qwScA9C3ARRC1ryE7vGSD0W0p+NeaMo5gIZs8VjZLqkZB3Mlp2hOWa4IDYb2D4cvRFF068yHZT7+7lhcyATURAXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qOSvyO/B; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57EMdnYr2398633;
	Thu, 14 Aug 2025 17:39:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755211189;
	bh=EIEyyCD+ZNg4KgH9tbcVWoSpKyCmumkSOtdoK/g1LxA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=qOSvyO/BFVZS1O54J0jQ46XQ4xAuqHETdv+ztxSkezDID1mcw89pJ9WmZovlPLfHQ
	 dlQu0QUheeB1q6XNfdhpm34mjD9UePEYDWXtGS5nzx3V370uamKvOYqiquxAWieyyQ
	 +FW2GGJJUBBPyxyZIC5Ap2kIxOWcAwO0KrffSUHA=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57EMdnhJ1158790
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 14 Aug 2025 17:39:49 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 14
 Aug 2025 17:39:49 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 14 Aug 2025 17:39:49 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57EMcw4j096792;
	Thu, 14 Aug 2025 17:39:45 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 10/33] arm64: dts: ti: k3-j784s4-j742s2: Enable remote processors at board level
Date: Fri, 15 Aug 2025 04:08:16 +0530
Message-ID: <20250814223839.3256046-11-b-padhi@ti.com>
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

Remote Processors defined in top-level J784S4-J742S2 common SoC dtsi
files are incomplete without the memory carveouts and mailbox
assignments which are only known at board integration level.

Therefore, disable the remote processors at SoC level and enable them at
board level where above information is available.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am69-sk.dts             | 15 +++++++++++++++
 .../boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi  |  7 +++++++
 .../boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi |  9 +++++++++
 .../ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi    |  3 +++
 4 files changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index 612ac27643d2..cea096733ba2 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -992,24 +992,32 @@ &mcu_cpsw_port1 {
 	bootph-all;
 };
 
+&mcu_r5fss0 {
+	status = "okay";
+};
+
 &mcu_r5fss0_core0 {
 	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core0>;
 	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
 			<&mcu_r5fss0_core0_memory_region>;
+	status = "okay";
 };
 
 &mcu_r5fss0_core1 {
 	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core1>;
 	memory-region = <&mcu_r5fss0_core1_dma_memory_region>,
 			<&mcu_r5fss0_core1_memory_region>;
+	status = "okay";
 };
 
 &main_r5fss0 {
 	ti,cluster-mode = <0>;
+	status = "okay";
 };
 
 &main_r5fss1 {
 	ti,cluster-mode = <0>;
+	status = "okay";
 };
 
 /* Timers are used by Remoteproc firmware */
@@ -1055,42 +1063,49 @@ &main_timer9 {
 
 &main_r5fss2 {
 	ti,cluster-mode = <0>;
+	status = "okay";
 };
 
 &main_r5fss0_core0 {
 	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core0>;
 	memory-region = <&main_r5fss0_core0_dma_memory_region>,
 			<&main_r5fss0_core0_memory_region>;
+	status = "okay";
 };
 
 &main_r5fss0_core1 {
 	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core1>;
 	memory-region = <&main_r5fss0_core1_dma_memory_region>,
 			<&main_r5fss0_core1_memory_region>;
+	status = "okay";
 };
 
 &main_r5fss1_core0 {
 	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss1_core0>;
 	memory-region = <&main_r5fss1_core0_dma_memory_region>,
 			<&main_r5fss1_core0_memory_region>;
+	status = "okay";
 };
 
 &main_r5fss1_core1 {
 	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss1_core1>;
 	memory-region = <&main_r5fss1_core1_dma_memory_region>,
 			<&main_r5fss1_core1_memory_region>;
+	status = "okay";
 };
 
 &main_r5fss2_core0 {
 	mboxes = <&mailbox0_cluster3 &mbox_main_r5fss2_core0>;
 	memory-region = <&main_r5fss2_core0_dma_memory_region>,
 			<&main_r5fss2_core0_memory_region>;
+	status = "okay";
 };
 
 &main_r5fss2_core1 {
 	mboxes = <&mailbox0_cluster3 &mbox_main_r5fss2_core1>;
 	memory-region = <&main_r5fss2_core1_dma_memory_region>,
 			<&main_r5fss2_core1_memory_region>;
+	status = "okay";
 };
 
 &c71_0 {
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
index 6afa802544e9..c269e5b29b96 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
@@ -1154,6 +1154,10 @@ mbox_c71_2: mbox-c71-2 {
 	};
 };
 
+&mcu_r5fss0 {
+	status = "okay";
+};
+
 &mcu_r5fss0_core0 {
 	status = "okay";
 	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core0>;
@@ -1170,14 +1174,17 @@ &mcu_r5fss0_core1 {
 
 &main_r5fss0 {
 	ti,cluster-mode = <0>;
+	status = "okay";
 };
 
 &main_r5fss1 {
 	ti,cluster-mode = <0>;
+	status = "okay";
 };
 
 &main_r5fss2 {
 	ti,cluster-mode = <0>;
+	status = "okay";
 };
 
 /* Timers are used by Remoteproc firmware */
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
index fbbe768e7a30..9cc0901d58fb 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
@@ -2174,6 +2174,7 @@ main_r5fss0: r5fss@5c00000 {
 		ranges = <0x5c00000 0x00 0x5c00000 0x20000>,
 			 <0x5d00000 0x00 0x5d00000 0x20000>;
 		power-domains = <&k3_pds 336 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 
 		main_r5fss0_core0: r5f@5c00000 {
 			compatible = "ti,j721s2-r5f";
@@ -2188,6 +2189,7 @@ main_r5fss0_core0: r5f@5c00000 {
 			ti,atcm-enable = <1>;
 			ti,btcm-enable = <1>;
 			ti,loczrama = <1>;
+			status = "disabled";
 		};
 
 		main_r5fss0_core1: r5f@5d00000 {
@@ -2203,6 +2205,7 @@ main_r5fss0_core1: r5f@5d00000 {
 			ti,atcm-enable = <1>;
 			ti,btcm-enable = <1>;
 			ti,loczrama = <1>;
+			status = "disabled";
 		};
 	};
 
@@ -2214,6 +2217,7 @@ main_r5fss1: r5fss@5e00000 {
 		ranges = <0x5e00000 0x00 0x5e00000 0x20000>,
 			 <0x5f00000 0x00 0x5f00000 0x20000>;
 		power-domains = <&k3_pds 337 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 
 		main_r5fss1_core0: r5f@5e00000 {
 			compatible = "ti,j721s2-r5f";
@@ -2228,6 +2232,7 @@ main_r5fss1_core0: r5f@5e00000 {
 			ti,atcm-enable = <1>;
 			ti,btcm-enable = <1>;
 			ti,loczrama = <1>;
+			status = "disabled";
 		};
 
 		main_r5fss1_core1: r5f@5f00000 {
@@ -2243,6 +2248,7 @@ main_r5fss1_core1: r5f@5f00000 {
 			ti,atcm-enable = <1>;
 			ti,btcm-enable = <1>;
 			ti,loczrama = <1>;
+			status = "disabled";
 		};
 	};
 
@@ -2254,6 +2260,7 @@ main_r5fss2: r5fss@5900000 {
 		ranges = <0x5900000 0x00 0x5900000 0x20000>,
 			 <0x5a00000 0x00 0x5a00000 0x20000>;
 		power-domains = <&k3_pds 338 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 
 		main_r5fss2_core0: r5f@5900000 {
 			compatible = "ti,j721s2-r5f";
@@ -2268,6 +2275,7 @@ main_r5fss2_core0: r5f@5900000 {
 			ti,atcm-enable = <1>;
 			ti,btcm-enable = <1>;
 			ti,loczrama = <1>;
+			status = "disabled";
 		};
 
 		main_r5fss2_core1: r5f@5a00000 {
@@ -2283,6 +2291,7 @@ main_r5fss2_core1: r5f@5a00000 {
 			ti,atcm-enable = <1>;
 			ti,btcm-enable = <1>;
 			ti,loczrama = <1>;
+			status = "disabled";
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi
index 52e2965a3bf5..cc22bfb5f599 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi
@@ -595,6 +595,7 @@ mcu_r5fss0: r5fss@41000000 {
 		ranges = <0x41000000 0x00 0x41000000 0x20000>,
 			 <0x41400000 0x00 0x41400000 0x20000>;
 		power-domains = <&k3_pds 345 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 
 		mcu_r5fss0_core0: r5f@41000000 {
 			compatible = "ti,j721s2-r5f";
@@ -609,6 +610,7 @@ mcu_r5fss0_core0: r5f@41000000 {
 			ti,atcm-enable = <1>;
 			ti,btcm-enable = <1>;
 			ti,loczrama = <1>;
+			status = "disabled";
 		};
 
 		mcu_r5fss0_core1: r5f@41400000 {
@@ -624,6 +626,7 @@ mcu_r5fss0_core1: r5f@41400000 {
 			ti,atcm-enable = <1>;
 			ti,btcm-enable = <1>;
 			ti,loczrama = <1>;
+			status = "disabled";
 		};
 	};
 
-- 
2.34.1



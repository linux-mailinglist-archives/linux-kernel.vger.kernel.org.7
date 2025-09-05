Return-Path: <linux-kernel+bounces-802069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B167B44D54
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3BC97A68C8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 05:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4503827817F;
	Fri,  5 Sep 2025 05:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tGQzT3HW"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07C7274FEF;
	Fri,  5 Sep 2025 05:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757049629; cv=none; b=qvXnhf6buJTJDxw8ZJ6Oc/fmoj4GjHwIssC+r2Tv/K+KvmiJo3LpqP+nYOovkUjrUuCDsjpigVWXac3w3sDVEMhR5hAwGCQLh/ulFwrsY40D7vNkKqj6FhAdoQllUhf8NB9jLB9XSizQAFpXXiTUVnEdTMjMO4R1C72fAYsCAE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757049629; c=relaxed/simple;
	bh=IjFNzvrMphg7oH3eG3PhPXG9hkQOwHpi/YDexOUsgJ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cguNuB11ZntrKdrUAtOUxaIQ8OzbXtAh3CTNNBBrlQg4BMB2XpMXJblpQaDSRLoLZfBcmVvw+zvdBVt6UXKqElH5mt0SDOprQ8afI9Ug1bNO/tWuHbQMchH4qbN5RGTNoY/QNDzSZ20Fzv6M7U58fLIYvlbISVszEb5rDy2shsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tGQzT3HW; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5855KFv83246450;
	Fri, 5 Sep 2025 00:20:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757049615;
	bh=F2gsAN+ZOtEADHYTxoJ3USR88ppxjOvinTQO3FRDJJA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=tGQzT3HWuxWU/0NNEXhgiu3YAdv0ZfD9MeLO1Fbin3BcH3P8PZhTMX9A13OOiDqxl
	 a5zGrpbWQvNthzk03Y0XXOaiRcUukuQiZ8sLqNrGrjrWaAoGhlt0A0Mm2HbNx2zl6+
	 M+J5KlEsNg9iVC0D7SmhQgMTidsd0rwHdZbWM1M8=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5855KFvP1405474
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 5 Sep 2025 00:20:15 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 5
 Sep 2025 00:20:14 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 5 Sep 2025 00:20:14 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5855Ioik220581;
	Fri, 5 Sep 2025 00:20:10 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Josua
 Mayer <josua@solid-run.com>,
        Logan Bristol <logan.bristol@utexas.edu>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v3 17/33] arm64: dts: ti: k3-am642-sr-som: Add missing cfg for TI IPC Firmware
Date: Fri, 5 Sep 2025 10:48:30 +0530
Message-ID: <20250905051846.1189612-18-b-padhi@ti.com>
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

Currently, only R5F remote processors are enabled for k3-am642-sr SoMs,
whereas the M4F in MCU domain is disabled. Enable the M4F remote
processor at board level by reserving memory carveouts and assigning
mailboxes.

While at it, reserve the MAIN domain timers that are used by R5F remote
processors for ticks to avoid rproc crashes. This config aligns with
other AM64 boards and can be refactored out later.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
Cc: Josua Mayer <josua@solid-run.com>
Cc: Logan Bristol <logan.bristol@utexas.edu>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Requesting for review/test of this patch.

v3: Changelog:
1. None

Link to v2:
https://lore.kernel.org/all/20250823160901.2177841-18-b-padhi@ti.com/

v2: Changelog:
1. Re-ordered patch from [PATCH 27/33] to [PATCH v2 17/33].

Link to v1:
https://lore.kernel.org/all/20250814223839.3256046-28-b-padhi@ti.com/

 arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi | 54 +++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi b/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
index 81adae0a8e55..8cb61f831734 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
@@ -162,6 +162,24 @@ main_r5fss1_core1_memory_region: r5f-memory@a3100000 {
 			reg = <0x00 0xa3100000 0x00 0xf00000>;
 			no-map;
 		};
+
+		mcu_m4fss_dma_memory_region: m4f-dma-memory@a4000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa4000000 0x00 0x100000>;
+			no-map;
+		};
+
+		mcu_m4fss_memory_region: m4f-memory@a4100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa4100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		rtos_ipc_memory_region: ipc-memories@a5000000 {
+			reg = <0x00 0xa5000000 0x00 0x00800000>;
+			alignment = <0x1000>;
+			no-map;
+		};
 	};
 
 	vdd_mmc0: regulator-vdd-mmc0 {
@@ -291,6 +309,35 @@ mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
 	};
 };
 
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
 &main_i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c0_default_pins>;
@@ -524,6 +571,13 @@ &main_r5fss1_core1 {
 	status = "okay";
 };
 
+&mcu_m4fss {
+	mboxes = <&mailbox0_cluster6 &mbox_m4_0>;
+	memory-region = <&mcu_m4fss_dma_memory_region>,
+			<&mcu_m4fss_memory_region>;
+	status = "okay";
+};
+
 /* SoC default UART console */
 &main_uart0 {
 	pinctrl-names = "default";
-- 
2.34.1



Return-Path: <linux-kernel+bounces-806075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55507B49197
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B06DA17AA72
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7555310655;
	Mon,  8 Sep 2025 14:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MXdfHd4F"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C86930EF81;
	Mon,  8 Sep 2025 14:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341839; cv=none; b=beFZINaLTHv0m3ghe60HUG4EdmYAD0NsWTV4uDju4IYkAPQOZi2nz9BUVlgxctpOlHhTVPCGdZyjh2htHWaWMtN9eQN4yodznm296ptShlbpbFhiAhinKpovREWR4l4me3CqFxvDK1yNI51z1yy7EX7Pc1r0wR7/r2PbNZJhtWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341839; c=relaxed/simple;
	bh=CMzlj/mTXu3f1Ph/mb10KWRxmwVUw6FNa7cF5wMxVNw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i9s6XipB4CgJfPkoKa6ShHgpdFXZ2ne6M2+H6W7rs5Vy9vNn8TdCWA3vGilDLrL7y5Jdkd7cDjjgLO9UPqhigf8sYw1cJw/1dIFnv0h9sXJk0b9gAw3P7tlx9sZIB5CC9Ant0f07w65F4jnhkttXwTeFNeZ7AUkEu/KO8CMU1iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MXdfHd4F; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 588EUR4b3810447;
	Mon, 8 Sep 2025 09:30:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757341827;
	bh=kbdIVQLM5NyGIiDMb/i1TfEf33JV37QU6BlExm086KE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=MXdfHd4Fv6cZxlBp189DT0V0kMTE35idng6hliLNs+JGznFyBYV1PlmDqvSpbYaVF
	 YjXUzx4KXY7iQBvha1i7HQQ3Wxnze0siSi+FQyE3rl5lEngOEdRYCLVrWYZIeTnjh+
	 bws/bx0naZmwef/sumygRIJXOy8Vrl1xCs8zOHv0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 588EURiO3020962
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 09:30:27 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 09:30:26 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 09:30:26 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 588ESecu1037553;
	Mon, 8 Sep 2025 09:30:21 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <d-gole@ti.com>, <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Josua
 Mayer <josua@solid-run.com>,
        Logan Bristol <logan.bristol@utexas.edu>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v4 18/34] arm64: dts: ti: k3-am642-sr-som: Add missing cfg for TI IPC Firmware
Date: Mon, 8 Sep 2025 19:58:10 +0530
Message-ID: <20250908142826.1828676-19-b-padhi@ti.com>
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

v4: Changelog:
1. Updated carveout node names to generic 'memory@addr'

Link to v3:
https://lore.kernel.org/all/20250905051846.1189612-18-b-padhi@ti.com/

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
index 35294a5c46d5..38feda717d7a 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
@@ -162,6 +162,24 @@ main_r5fss1_core1_memory_region: memory@a3100000 {
 			reg = <0x00 0xa3100000 0x00 0xf00000>;
 			no-map;
 		};
+
+		mcu_m4fss_dma_memory_region: memory@a4000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa4000000 0x00 0x100000>;
+			no-map;
+		};
+
+		mcu_m4fss_memory_region: memory@a4100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa4100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		rtos_ipc_memory_region: memory@a5000000 {
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



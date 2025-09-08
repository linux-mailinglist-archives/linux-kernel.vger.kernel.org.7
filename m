Return-Path: <linux-kernel+bounces-806073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B1FB49191
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016F9343FA8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EAA3101C6;
	Mon,  8 Sep 2025 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rm2WxKzF"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8AA30F94A;
	Mon,  8 Sep 2025 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341829; cv=none; b=rEeoRTchdo+8VC4feoXfn54nLZ2w+k3yhInbQK9H/CQlT13Co5gJKIhfPho22zWI+dRK35C3Pxz3PiHI9IAf+wZWDtcoRo84r2oyD82ebRjNM4dsnquygamcyl7+fya7ImKCuu64tY/jpTAtgHuMR8h/QIuxGrVZJY7mas3pglY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341829; c=relaxed/simple;
	bh=gZgr0YVlb2fhS33APj95hxKndDpgifqDk/4w/M1HuRU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W++JQcTwVYDKdNTKYVT+rfSbU3ZYAlVgFq+0gxSaIEJfExIEkpB4ZRvrVsauAg+ftvjzUYNPGVzLUmS6/dPWt1wiyPM4T1WRLjcVCFbllWreyPBD2sZBGDtr6378D8CdKSAUDoq6h71Mhtn5Q5rKRJOZvp0h2f2t40Gm+9fDkwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rm2WxKzF; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 588EULi8071642;
	Mon, 8 Sep 2025 09:30:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757341821;
	bh=ws6Qr9VPCeoSMLBoOAlT2voAjJDQtxFSVHykYJ3Q/+U=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=rm2WxKzFh4yuIWYE6QZ4nZyUKM3kc0jqMpUiWgrfM/fCs8rZSoZTqUfcIVIBuiA0+
	 LrdvlkJKf7OJjlA4RnIUoB+8QH5Vl9kKR87laU40fJA0tFQsSC8Q1Y5wI/C/WsImbR
	 iIHX90dKyVJ0ury2nzIBu/sNEvRKJ7i+ANlC8nY8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 588EULL23835303
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 09:30:21 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 09:30:21 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 09:30:21 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 588ESect1037553;
	Mon, 8 Sep 2025 09:30:16 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <d-gole@ti.com>, <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Robert Nelson <robertcnelson@gmail.com>
Subject: [PATCH v4 17/34] arm64: dts: ti: k3-am62-pocketbeagle2: Add missing cfg for TI IPC Firmware
Date: Mon, 8 Sep 2025 19:58:09 +0530
Message-ID: <20250908142826.1828676-18-b-padhi@ti.com>
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

The wkup_r5fss0_core0_memory_region is used to store the text/data
sections of the Device Manager (DM) firmware itself and is necessary for
platform boot. Whereas the wkup_r5fss0_core0_dma_memory_region is used
for allocating the Virtio buffers needed for IPC with the DM core which
could be optional. The labels were incorrectly used in the
k3-am62-pocketbeagle2.dts file. Correct the firmware memory region label

Currently, only mailbox node is enabled with FIFO assignment for a
single M4F remote core. Add the missing carveouts for WKUP R5F remote
processor, and enable that by associating to the above carveout and
mailbox. This config aligns with other AM62 boards and can be
refactored out later.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
---
Cc: Robert Nelson <robertcnelson@gmail.com>
Requesting for review/test of this patch

v4: Changelog:
1. Changed node names to generic 'memory@addr'

Link to v3:
https://lore.kernel.org/all/20250905051846.1189612-17-b-padhi@ti.com/

v3: Changelog:
1. None

Link to v2:
https://lore.kernel.org/all/20250823160901.2177841-17-b-padhi@ti.com/

v2: Changelog:
1. Re-ordered patch from [PATCH 19/33] to [PATCH v2 16/33].

Link to v1:
https://lore.kernel.org/all/20250814223839.3256046-20-b-padhi@ti.com/
 .../boot/dts/ti/k3-am62-pocketbeagle2.dts     | 24 ++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts b/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts
index 2d46be298b0b..621fb6c52db1 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts
@@ -78,7 +78,13 @@ secure_ddr: optee@9e800000 {
 			no-map;
 		};
 
-		wkup_r5fss0_core0_dma_memory_region: memory@9db00000 {
+		wkup_r5fss0_core0_dma_memory_region: memory@9da00000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9da00000 0x00 0x100000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_memory_region: memory@9db00000 {
 			compatible = "shared-dma-pool";
 			reg = <0x00 0x9db00000 0x00 0xc00000>;
 			no-map;
@@ -299,6 +305,11 @@ mbox_m4_0: mbox-m4-0 {
 		ti,mbox-rx = <0 0 0>;
 		ti,mbox-tx = <1 0 0>;
 	};
+
+	mbox_r5_0: mbox-r5-0 {
+		ti,mbox-rx = <2 0 0>;
+		ti,mbox-tx = <3 0 0>;
+	};
 };
 
 &main_uart0 {
@@ -358,6 +369,17 @@ &mcu_m4fss {
 	status = "okay";
 };
 
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
 &mcu_pmx0 {
 	wkup_uart0_pins_default: wkup-uart0-default-pins {
 		pinctrl-single,pins = <
-- 
2.34.1



Return-Path: <linux-kernel+bounces-769680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3DAB271D6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 00:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFCB75E48AB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 22:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82655285CA3;
	Thu, 14 Aug 2025 22:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="k0cDMD9k"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4111B2857F9;
	Thu, 14 Aug 2025 22:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755211228; cv=none; b=sh5Ljx+7pItdVJXG16lgyZ15QReTM3Fd/LFfUNKlGxAsMDUaHHN8zXX4ARJr5JnkDJdOozOJ90ynmIE/u55L7ZOwqDjXXXBAcdbGTJ/v1EU2Vo5T8pXE7USvZ8oInCm4nE1kkyWdzllMURrR1OoJE/ZxCwVOqvyaroqzfgqaHrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755211228; c=relaxed/simple;
	bh=FtL23UFtPFNIERziGvol4nlGw2l0Xho04gk5+6JEmSk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y4ptUlMlsW1BPrSIKq0EB5HnsB+r6QNwPH1mNdxutfje3O8DxNMzMi50b8seuj6C4+K6+oJ4TIbFsHyhBQKxTwcoFCuauhTwbFHY3l/W7ifNxuUvVUFlpcv5SFU70Bun5dWYr1ZBU4QNH9wlqBb0U4d6vrpuQBSKkwuorCpF6ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=k0cDMD9k; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57EMeFt52027504;
	Thu, 14 Aug 2025 17:40:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755211215;
	bh=yzwsWLISBn/+q6XrvI0sbgk5Kv+C2qGvr5xT1CY7NlE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=k0cDMD9kyQNJt250X9iKozgKd1jsaxf7X5zP0b0ZygS28WeXS0hAKjeZbAjQaZMlX
	 It14/FsuaQTs1P0JYyRfRA7dP5NaPcO1cECSp2CIaj4ntdUrObEV98sbotxDRzHxfG
	 Q8U+bCnQUTiu4Kq0mLNnCiqu0/D2JcmRMm1DUe7Y=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57EMeFHX2016020
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 14 Aug 2025 17:40:15 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 14
 Aug 2025 17:40:15 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 14 Aug 2025 17:40:15 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57EMcw4p096792;
	Thu, 14 Aug 2025 17:40:10 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Emanuele Ghidoli
	<emanuele.ghidoli@toradex.com>,
        Parth Pancholi <parth.pancholi@toradex.com>,
        Jo_o Paulo Gon_alves <joao.goncalves@toradex.com>
Subject: [PATCH 16/33] arm64: dts: ti: k3-am62p-verdin: Add missing cfg for TI IPC Firmware
Date: Fri, 15 Aug 2025 04:08:22 +0530
Message-ID: <20250814223839.3256046-17-b-padhi@ti.com>
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

The wkup_r5fss0_core0_memory_region is used to store the text/data
sections of the Device Manager (DM) firmware itself and is necessary for
platform boot. Whereas the wkup_r5fss0_core0_dma_memory_region is used
for allocating the Virtio buffers needed for IPC with the DM core which
could be optional. The labels were incorrectly used in the
k3-am62p-verdin.dtsi file. Correct the firmware memory region label.

Currently, only mailbox node is enabled with FIFO assignment. However,
there are no users of the enabled mailboxes. Add the missing carveouts
for WKUP and MCU R5F remote processors, and enable those by associating
to the above carveout and mailboxes. This config aligns with other AM62P
boards and can be refactored out later.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Cc: Parth Pancholi <parth.pancholi@toradex.com>
Cc: Jo_o Paulo Gon_alves <joao.goncalves@toradex.com>
Requesting for a review/test.

 arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi | 42 ++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi
index 6a04b370d149..0687debf3bbb 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi
@@ -162,7 +162,25 @@ secure_ddr: optee@9e800000 {
 			no-map;
 		};
 
-		wkup_r5fss0_core0_memory_region: r5f-dma-memory@9c900000 {
+		mcu_r5fss0_core0_dma_memory_region: mcu-r5fss-dma-memory-region@9b800000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9b800000 0x00 0x100000>;
+			no-map;
+		};
+
+		mcu_r5fss0_core0_memory_region: mcu-r5fss-memory-region@9b900000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9b900000 0x00 0xf00000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9c800000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9c800000 0x00 0x100000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_memory_region: r5f-memory@9c900000 {
 			compatible = "shared-dma-pool";
 			reg = <0x00 0x9c900000 0x00 0x01e00000>;
 			no-map;
@@ -848,6 +866,28 @@ mbox_mcu_r5_0: mbox-mcu-r5-0 {
 	};
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
+
 &main0_alert {
 	temperature = <95000>;
 };
-- 
2.34.1



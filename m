Return-Path: <linux-kernel+bounces-783200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B174CB32AAE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81E4F170078
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4462578F4B;
	Sat, 23 Aug 2025 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Q95EOqRr"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025F42EBB87;
	Sat, 23 Aug 2025 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755965441; cv=none; b=cUnsQztqAoEEjYOiCzZDNPtNFJ/LWMLSyhQW3yFN8jehsZZmLOcrPUQpREd7xN8vQBQBclqX1F2ZFK9c3QAKpL5uyxYsBUBt12NtOjL/15rvtevNoZ24rdZg/fkK5BgKLdYuVklRTHbrFWcfu4PAlrzdBNJXyccIRdqvwcbNzFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755965441; c=relaxed/simple;
	bh=qph171ZhQQokuM5B/MmT8HkD0rHiR+VS/CLqp0RcOXQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NzAH4JY/qDQTlvX2RLj9EQfMe7ghap7j84lNM7H6TkFEv0AXGjWHcNfaG8kK3RzA4c31zi1LtHBGKeL8/+efJSipF7Sqv8li5hljDs5lrFTPzSLheoVNKHmaDaKIEc5wkjxH+xiee3cLncaaxr0uUp1XrNnMyD81Mgc1qHmU5gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Q95EOqRr; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57NGAURq468604;
	Sat, 23 Aug 2025 11:10:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755965430;
	bh=gcxz1JcWlXzNERGvNURQOn7LnvQ7E0+RQ2OR3eg8Eeo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Q95EOqRr/gZeOpPw/rIutZoqyJfLF/+4kR63tTJHRPC/IPQO2ZVDAjlejr3euIN54
	 kCku78+W+ZOLOn1Ze22u74bfA6jcB3GnQ3QexcTGgBocwnUSFkqYETVJeUQG962dNF
	 zzji1JaQNAWxPgIIxsVrCLo1ebxRfJgU83FIfHDU=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57NGAUe1239687
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Sat, 23 Aug 2025 11:10:30 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sat, 23
 Aug 2025 11:10:29 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Sat, 23 Aug 2025 11:10:30 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57NG9ExV1274978;
	Sat, 23 Aug 2025 11:10:24 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Hiago
 De Franco <hiago.franco@toradex.com>,
        Francesco Dolcini
	<francesco.dolcini@toradex.com>,
        Jo_o Paulo Gon_alves
	<joao.goncalves@toradex.com>,
        Stefan Eichenberger
	<stefan.eichenberger@toradex.com>,
        Max Krummenacher
	<max.krummenacher@toradex.com>,
        Andrejs Cainikovs
	<andrejs.cainikovs@toradex.com>
Subject: [PATCH v2 15/33] arm64: dts: ti: k3-am62-verdin: Add missing cfg for TI IPC Firmware
Date: Sat, 23 Aug 2025 21:38:43 +0530
Message-ID: <20250823160901.2177841-16-b-padhi@ti.com>
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

The wkup_r5fss0_core0_memory_region is used to store the text/data
sections of the Device Manager (DM) firmware itself and is necessary for
platform boot. Whereas the wkup_r5fss0_core0_dma_memory_region is used
for allocating the Virtio buffers needed for IPC with the DM core which
could be optional. The labels were incorrectly used in the
k3-am62-verdin.dtsi file. Correct the firmware memory region label.

Currently, only mailbox node is enabled with FIFO assignment for a
single M4F remote core. However, there are no users of the enabled
mailboxes. Add the missing carveouts for WKUP R5F and MCU M4F remote
processors, and enable those by associating to the above carveout and
mailboxes. This config aligns with other AM62 boards and can be
refactored out later.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Verdin AM62
---
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Hiago De Franco <hiago.franco@toradex.com>
Cc: Jo_o Paulo Gon_alves <joao.goncalves@toradex.com>
Cc: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Cc: Max Krummenacher <max.krummenacher@toradex.com>
Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Requesting for review/test of this patch

v2: Changelog:
1. Re-ordered patch from [PATCH 18/33] to [PATCH v2 15/33].
2. Added T/B tag.

Link to v1:
https://lore.kernel.org/all/20250814223839.3256046-19-b-padhi@ti.com/

 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi | 43 +++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
index cbbcb96e2e24..fa2c1dc738d6 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
@@ -206,7 +206,25 @@ secure_ddr: optee@9e800000 {
 			no-map;
 		};
 
-		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9db00000 {
+		mcu_m4fss_dma_memory_region: m4f-dma-memory@9cb00000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9cb00000 0x00 0x100000>;
+			no-map;
+		};
+
+		mcu_m4fss_memory_region: m4f-memory@9cc00000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9cc00000 0x00 0xe00000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9da00000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9da00000 0x00 0x100000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_memory_region: r5f-memory@9db00000 {
 			compatible = "shared-dma-pool";
 			reg = <0x00 0x9db00000 0x00 0xc00000>;
 			no-map;
@@ -1323,6 +1341,29 @@ mbox_m4_0: mbox-m4-0 {
 		ti,mbox-rx = <0 0 0>;
 		ti,mbox-tx = <1 0 0>;
 	};
+
+	mbox_r5_0: mbox-r5-0 {
+		ti,mbox-rx = <2 0 0>;
+		ti,mbox-tx = <3 0 0>;
+	};
+};
+
+&mcu_m4fss {
+	mboxes = <&mailbox0_cluster0 &mbox_m4_0>;
+	memory-region = <&mcu_m4fss_dma_memory_region>,
+			<&mcu_m4fss_memory_region>;
+	status = "okay";
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
 };
 
 /* Verdin CAN_1 */
-- 
2.34.1



Return-Path: <linux-kernel+bounces-783204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F5CB32AB8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F48217A315
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C718D2EC579;
	Sat, 23 Aug 2025 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eW9IqzZ/"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE612F1FF3;
	Sat, 23 Aug 2025 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755965458; cv=none; b=sl0CpBobzoo4v9WKLxfdI7KrGCLJ/7oWXLt++tl7weXLJPgYOEDfjbacpObIM029Y1qGhRTE3fEp8Gtgs9QHG5wHHopfXzyM8eClpe3gUHL05wh1hbTaFM10lk/xQaYvg4pN5ncXZIhcOyuCXFnhqXoIkgPSj7BlVJCRcEYa9Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755965458; c=relaxed/simple;
	bh=T7MRClaUCw7gGkIUz0k5ToxHQDhT8neVhlTR2OzCeHk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0vZjCg3YX3NnGQ2kbEOdy0H95n4FScjtZwdrHOEAWbUXcV8oElZxadayG2pHhYtCjZ47Vc6q4ASy2L72GqfPEuntAiAshLEq8wJEiy0Cxfw3id47NoA3eQAbhecyGJXaL51FLiRt3dXqeov4GYHYwzfpvVmdGrkhyC3n5Yj3MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eW9IqzZ/; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57NGAohs465174;
	Sat, 23 Aug 2025 11:10:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755965450;
	bh=ug1Z73rnxzhVUDebNWNivfcxnAIUl3Aw82lSJei9QO8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=eW9IqzZ/80+kbZDoFOFjIQE9CdaL9OxKteQZqEsvg2/aZYh8X8MKZgV87JqfS0cNa
	 i4VrXYp3tDNQImQvHqwxC8wReFUj+3+/yaeQ+35/69Mk0hNfDVF3rJvH45gStuBotQ
	 jUSpfRbrB1L93o71VSeqyY4dAp26wbsRvJVQX+Tk=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57NGAowU3736195
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Sat, 23 Aug 2025 11:10:50 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sat, 23
 Aug 2025 11:10:49 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Sat, 23 Aug 2025 11:10:49 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57NG9ExZ1274978;
	Sat, 23 Aug 2025 11:10:45 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2 19/33] arm64: dts: ti: k3-am642-tqma64xxl: Add missing cfg for TI IPC Firmware
Date: Sat, 23 Aug 2025 21:38:47 +0530
Message-ID: <20250823160901.2177841-20-b-padhi@ti.com>
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

Currently, only R5F remote processors are enabled for k3-am642-tqma64xxl
whereas the M4F in MCU domain is disabled. Enable the M4F remote
processor at board level by reserving memory carveouts and assigning
mailboxes.

While at it, reserve the MAIN domain timers that are used by R5F remote
processors for ticks to avoid rproc crashes. This config aligns with
other AM64 boards and can be refactored out later.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Request for review/test of this patch.

v2: Changelog:
1. Re-ordered patch from [PATCH 29/33] to [PATCH v2 19/33].

Link to v1:
https://lore.kernel.org/all/20250814223839.3256046-30-b-padhi@ti.com/

 .../arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi
index 40b619c9a6c9..860b79aa5ef5 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi
@@ -79,6 +79,18 @@ main_r5fss1_core1_memory_region: r5f-memory@a3100000 {
 			no-map;
 		};
 
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
 		rtos_ipc_memory_region: ipc-memories@a5000000 {
 			reg = <0x00 0xa5000000 0x00 0x00800000>;
 			alignment = <0x1000>;
@@ -167,6 +179,26 @@ mbox_m4_0: mbox-m4-0 {
 	};
 };
 
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
 &main_r5fss0 {
 	status = "okay";
 };
@@ -203,6 +235,13 @@ &main_r5fss1_core1 {
 	status = "okay";
 };
 
+&mcu_m4fss {
+	mboxes = <&mailbox0_cluster6 &mbox_m4_0>;
+	memory-region = <&mcu_m4fss_dma_memory_region>,
+			<&mcu_m4fss_memory_region>;
+	status = "okay";
+};
+
 &ospi0 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.34.1



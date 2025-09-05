Return-Path: <linux-kernel+bounces-802058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C8FB44D3D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24AC4176326
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 05:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127B91FAC4B;
	Fri,  5 Sep 2025 05:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s8Z3QNhB"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCD0280CC8;
	Fri,  5 Sep 2025 05:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757049575; cv=none; b=lpGy+k8Gq9w/U+dYTvB4ci6lUbiPy4CG+clZASuyn+asq8UhkFx9bnNau9Z3fRAgXvLZsKvK3Op7qiBm3XC/TwY1FUdPNruxvBfth39run1WxH5qh8K1yXJ8tkqkZsVpMX7EkvxNGdhKVBUTmBR9LdIVfh/SfdUGutYrAiJtiYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757049575; c=relaxed/simple;
	bh=t70IGfT/LGkyIW2gmLpIpTNkes/b1zQXVvjO21Q43ic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gz6GtSvl7PN9YKnIW8p0M2qdE4UkBcnLS6dvieb2iXrus9YJ+X5Zg0WkVsREuNY6WCv8esgKCDG2anFXt/5nO04tu81vuaeGkOqfRgZGZVyeALUVGpeZxHGqOmZINf+vQW8tAcWxc2Vy5P9NbMUQKcPqwYlMqG1C2c27NBf69JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=s8Z3QNhB; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5855JT9p3637200;
	Fri, 5 Sep 2025 00:19:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757049569;
	bh=8g1Me7nTagv+1RjX67dS+wwUjCxDSGo6MTr6Drmo76A=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=s8Z3QNhBEBngIzfRSc0r70gU6yevQFuwPHJc9JnH26xF8/AaMq+W1ezeb0NYh7p7Z
	 qx9puDc3LsnHZlLADN2amzdHB131ZMdhndz8T99bcbNOpVFgp/Ac4GLf8mTmifQGXD
	 kRSzFf461ZbMja3qhxTnEd6P2nI8ZVyM4pWg6rco=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5855JTp21404898
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 5 Sep 2025 00:19:29 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 5
 Sep 2025 00:19:28 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 5 Sep 2025 00:19:28 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5855Ioia220581;
	Fri, 5 Sep 2025 00:19:24 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 07/33] arm64: dts: ti: k3-am62a: Enable remote processors at board level
Date: Fri, 5 Sep 2025 10:48:20 +0530
Message-ID: <20250905051846.1189612-8-b-padhi@ti.com>
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

Remote Processors defined in top-level AM62A SoC dtsi files are
incomplete without the memory carveouts and mailbox assignments which
are only known at board integration level.

Therefore, disable the remote processors at SoC level and enable them at
board level where above information is available.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
Acked-by: Andrew Davis <afd@ti.com>
Tested-by: Judith Mendez <jm@ti.com>
---
v3: Changelog:
1. Carried A/B, T/B tags.

Link to v2:
https://lore.kernel.org/all/20250823160901.2177841-8-b-padhi@ti.com/

v2: Changelog:
1. Re-ordered patch from [PATCH 24/33] to [PATCH v2 07/33].

Link to v1:
https://lore.kernel.org/all/20250814223839.3256046-25-b-padhi@ti.com/

 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi         | 1 +
 arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi | 2 ++
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi      | 1 +
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts          | 2 ++
 arch/arm64/boot/dts/ti/k3-am62d2-evm.dts         | 1 +
 5 files changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
index ee961ced7208..d22caa7c346b 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
@@ -197,6 +197,7 @@ mcu_r5fss0_core0: r5f@79000000 {
 			ti,sci = <&dmsc>;
 			ti,sci-dev-id = <9>;
 			ti,sci-proc-ids = <0x03 0xff>;
+			status = "disabled";
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi
index 207ca00630d1..403adfbf7dce 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi
@@ -406,6 +406,7 @@ &mcu_r5fss0_core0 {
 	mboxes = <&mailbox0_cluster2 &mbox_mcu_r5_0>;
 	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
 			<&mcu_r5fss0_core0_memory_region>;
+	status = "okay";
 };
 
 &ospi0 {
@@ -444,4 +445,5 @@ &wkup_r5fss0_core0 {
 	mboxes = <&mailbox0_cluster0  &mbox_r5_0>;
 	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
 			<&wkup_r5fss0_core0_memory_region>;
+	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
index 9ef1c829a9df..23877dadc98d 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
@@ -127,6 +127,7 @@ wkup_r5fss0_core0: r5f@78000000 {
 			ti,sci = <&dmsc>;
 			ti,sci-dev-id = <121>;
 			ti,sci-proc-ids = <0x01 0xff>;
+			status = "disabled";
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index bceead5e288e..03291862f07a 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -870,6 +870,7 @@ &wkup_r5fss0_core0 {
 	mboxes = <&mailbox0_cluster0>, <&mbox_r5_0>;
 	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
 			<&wkup_r5fss0_core0_memory_region>;
+	status = "okay";
 };
 
 &mcu_r5fss0 {
@@ -880,6 +881,7 @@ &mcu_r5fss0_core0 {
 	mboxes = <&mailbox0_cluster2>, <&mbox_mcu_r5_0>;
 	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
 			<&mcu_r5fss0_core0_memory_region>;
+	status = "okay";
 };
 
 &c7x_0 {
diff --git a/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts b/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
index daea18b0bc61..d45fc42b03f3 100644
--- a/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62d2-evm.dts
@@ -586,6 +586,7 @@ &wkup_r5fss0_core0 {
 	mboxes = <&mailbox0_cluster0 &mbox_r5_0>;
 	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
 			<&wkup_r5fss0_core0_memory_region>;
+	status = "okay";
 	bootph-pre-ram;
 };
 
-- 
2.34.1



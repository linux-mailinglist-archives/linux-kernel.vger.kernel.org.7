Return-Path: <linux-kernel+bounces-769662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37723B271AD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 00:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26BA65A774F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 22:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE30280CF6;
	Thu, 14 Aug 2025 22:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="c5SLdEyg"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3CB1F9F7A;
	Thu, 14 Aug 2025 22:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755211161; cv=none; b=T4yZbx3Xx5RBde6YYyEClfzMjgQwinDbUzqpMkaN5swQdfs8/Xeg7OftbbhADfKELNBIlGc+N0Z6ag1hwOYmFiMPchYgAkEXS6N0wcUvYPTxxgrZiTg0oVwToAiih2h1Y1DdI2d/DGMDX67jYUtuCRKS2ovtWOIjYPc0qEWGcXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755211161; c=relaxed/simple;
	bh=jMHQCzqsfSzZlvrUdNxJ6JVkO4rHsNdU85oZxFS1UK8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K03BF/OZpWSey2ig9hqRNRBU3vydm4wj6M6viZSBlkJ+y+tG5RvptanMxgKptEBrL7JbW9m8/NFdvQUwEpbQ/fBQKfd3VMiMmpHfcW1HobsahcqCEvdlc2ok/4nT3xthUSbcX5U+949gqMq58t+pUgJLuzWWOzIpaarZwugJyHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=c5SLdEyg; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57EMdBdq2478849;
	Thu, 14 Aug 2025 17:39:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755211151;
	bh=Ir3LteEtJTk7Nl3SaY81FTwhyaH+OjdGVhCesQUe4z0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=c5SLdEygA1SoN88YDm+1M1+lfQVhM05a6PcrSctg+Zu1FSZkavxzqN4elGETK/I5D
	 g3gw6LZ9779GWJ1x4w6cpo15MYk8kKaZQRCBJRXmCUYWBSh+b7pFW8BA1uyMPxmDg2
	 G65+0ux05kvVjJqCK16QbAd1TZcbgs6imADWqwaw=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57EMdBKb2015477
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 14 Aug 2025 17:39:11 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 14
 Aug 2025 17:39:11 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 14 Aug 2025 17:39:11 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57EMcw4a096792;
	Thu, 14 Aug 2025 17:39:07 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 01/33] arm64: dts: ti: k3-j7200: Enable remote processors at board level
Date: Fri, 15 Aug 2025 04:08:07 +0530
Message-ID: <20250814223839.3256046-2-b-padhi@ti.com>
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

Remote Processors defined in top-level J7200 SoC dtsi files are
incomplete without the memory carveouts and mailbox assignments which
are only known at board integration level.

Therefore, disable the remote processors at SoC level and enable them at
board level where above information is available.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi       | 3 +++
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi | 3 +++
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi     | 9 +++++++++
 3 files changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 5ce5f0a3d6f5..628ff89dd72f 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -1516,6 +1516,7 @@ main_r5fss0: r5fss@5c00000 {
 		ranges = <0x5c00000 0x00 0x5c00000 0x20000>,
 			 <0x5d00000 0x00 0x5d00000 0x20000>;
 		power-domains = <&k3_pds 243 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 
 		main_r5fss0_core0: r5f@5c00000 {
 			compatible = "ti,j7200-r5f";
@@ -1530,6 +1531,7 @@ main_r5fss0_core0: r5f@5c00000 {
 			ti,atcm-enable = <1>;
 			ti,btcm-enable = <1>;
 			ti,loczrama = <1>;
+			status = "disabled";
 		};
 
 		main_r5fss0_core1: r5f@5d00000 {
@@ -1545,6 +1547,7 @@ main_r5fss0_core1: r5f@5d00000 {
 			ti,atcm-enable = <1>;
 			ti,btcm-enable = <1>;
 			ti,loczrama = <1>;
+			status = "disabled";
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index 56ab144fea07..692c4745040e 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -612,6 +612,7 @@ mcu_r5fss0: r5fss@41000000 {
 		ranges = <0x41000000 0x00 0x41000000 0x20000>,
 			 <0x41400000 0x00 0x41400000 0x20000>;
 		power-domains = <&k3_pds 249 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 
 		mcu_r5fss0_core0: r5f@41000000 {
 			compatible = "ti,j7200-r5f";
@@ -626,6 +627,7 @@ mcu_r5fss0_core0: r5f@41000000 {
 			ti,atcm-enable = <1>;
 			ti,btcm-enable = <1>;
 			ti,loczrama = <1>;
+			status = "disabled";
 		};
 
 		mcu_r5fss0_core1: r5f@41400000 {
@@ -641,6 +643,7 @@ mcu_r5fss0_core1: r5f@41400000 {
 			ti,atcm-enable = <1>;
 			ti,btcm-enable = <1>;
 			ti,loczrama = <1>;
+			status = "disabled";
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
index 291ab9bb414d..90befcdc8d08 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
@@ -254,20 +254,27 @@ mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
 	};
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
 
 /* Timers are used by Remoteproc firmware */
@@ -287,12 +294,14 @@ &main_r5fss0_core0 {
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
 
 &main_i2c0 {
-- 
2.34.1



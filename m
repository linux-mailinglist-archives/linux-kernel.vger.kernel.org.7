Return-Path: <linux-kernel+bounces-806065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6977EB4917C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D18D0442B83
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A1130F93B;
	Mon,  8 Sep 2025 14:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ErEt6pLU"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B5430CDA0;
	Mon,  8 Sep 2025 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341782; cv=none; b=gqlV8uTr85A6JRXtJPUYCOmp5VSrThid7fQALRoB6dfBJLPqbVhdZcBHJsLrDvOn56zbl+kydnqJSjjGH2kF0NYFdWXjXedfts+CZfsK1hutqxX7cCjBlgKIzUZs1Du0cwotIMfxwpzjd73VCIvR2zdhP3KIzs/zx4n4xs5mtEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341782; c=relaxed/simple;
	bh=ShV/VnIiz5w+vspmU+MAi5RZhZuwodbRUvWF3Wm/YwU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RKptbJE7Ml+iZ3aNoHScQECo3Ssk2mxkoM//tbl6COwhycaoEVxNUIrcDQYSKIiuZnTjH3Tw7wUOrfaGUxHedM/IHNBJJEJJwNkiemNIIiZpg6XIsSSfZ3sF1ReiCrTw8KALSHcZmM7U7oVECdMGEZWFuoag+0Tm8iyE4EbAj5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ErEt6pLU; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 588ETUEi071257;
	Mon, 8 Sep 2025 09:29:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757341770;
	bh=BGNfhLCUxNj5SFaaf9QythBJgcMADJFy8KYHgUhjBi8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ErEt6pLUIeLzOeyD7AuuihepsNoVOA4D0g+BBP41fEGb3Rj0k1aXraw6m75FSb+pP
	 WPKeqveJMHFGk99277DYWZlfqwRThbk17xM+9Xry0LGswxcbbiO7TD6GUUZN7mS1GH
	 PonuPk8UdqleLusKAvRfYRN5vcbCLIHHOk56RAFk=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 588ETUfh3833396
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 09:29:30 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 09:29:29 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 09:29:29 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 588ESeck1037553;
	Mon, 8 Sep 2025 09:29:25 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <d-gole@ti.com>, <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Wadim
 Egorov <w.egorov@phytec.de>
Subject: [PATCH v4 08/34] arm64: dts: ti: k3-am64: Enable remote processors at board level
Date: Mon, 8 Sep 2025 19:58:00 +0530
Message-ID: <20250908142826.1828676-9-b-padhi@ti.com>
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

Remote Processors defined in top-level AM64x SoC dtsi files are
incomplete without the memory carveouts and mailbox assignments which
are only known at board integration level.

Therefore, disable the remote processors at SoC level and enable them at
board level where above information is available.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
Tested-by: Wadim Egorov <w.egorov@phytec.de> # phycore-am64x
Acked-by: Andrew Davis <afd@ti.com>
Tested-by: Hari Nagalla <hnagalla@ti.com>
---
v4: Changelog:
1. None

Link to v3:
https://lore.kernel.org/all/20250905051846.1189612-9-b-padhi@ti.com/

v3: Changelog:
1. Carried A/B, R/B, T/B tags.

Link to v2:
https://lore.kernel.org/all/20250823160901.2177841-9-b-padhi@ti.com/

v2: Changelog:
1. Re-ordered patch from [PATCH 26/33] to [PATCH v2 08/33].

Link to v1:
https://lore.kernel.org/all/20250814223839.3256046-27-b-padhi@ti.com/

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi        |  6 ++++++
 arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi | 12 ++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts         | 12 ++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-sk.dts          | 12 ++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi     | 12 ++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi  | 12 ++++++++++++
 6 files changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index c7e5da37486a..d872cc671094 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -921,6 +921,7 @@ main_r5fss0: r5fss@78000000 {
 			 <0x78200000 0x00 0x78200000 0x08000>,
 			 <0x78300000 0x00 0x78300000 0x08000>;
 		power-domains = <&k3_pds 119 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 
 		main_r5fss0_core0: r5f@78000000 {
 			compatible = "ti,am64-r5f";
@@ -935,6 +936,7 @@ main_r5fss0_core0: r5f@78000000 {
 			ti,atcm-enable = <1>;
 			ti,btcm-enable = <1>;
 			ti,loczrama = <1>;
+			status = "disabled";
 		};
 
 		main_r5fss0_core1: r5f@78200000 {
@@ -950,6 +952,7 @@ main_r5fss0_core1: r5f@78200000 {
 			ti,atcm-enable = <1>;
 			ti,btcm-enable = <1>;
 			ti,loczrama = <1>;
+			status = "disabled";
 		};
 	};
 
@@ -963,6 +966,7 @@ main_r5fss1: r5fss@78400000 {
 			 <0x78600000 0x00 0x78600000 0x08000>,
 			 <0x78700000 0x00 0x78700000 0x08000>;
 		power-domains = <&k3_pds 120 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 
 		main_r5fss1_core0: r5f@78400000 {
 			compatible = "ti,am64-r5f";
@@ -977,6 +981,7 @@ main_r5fss1_core0: r5f@78400000 {
 			ti,atcm-enable = <1>;
 			ti,btcm-enable = <1>;
 			ti,loczrama = <1>;
+			status = "disabled";
 		};
 
 		main_r5fss1_core1: r5f@78600000 {
@@ -992,6 +997,7 @@ main_r5fss1_core1: r5f@78600000 {
 			ti,atcm-enable = <1>;
 			ti,btcm-enable = <1>;
 			ti,loczrama = <1>;
+			status = "disabled";
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
index d9d491b12c33..03c46d74ebb5 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
@@ -349,28 +349,40 @@ &main_pktdma {
 	bootph-all;
 };
 
+&main_r5fss0 {
+	status = "okay";
+};
+
 &main_r5fss0_core0 {
 	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
 	memory-region = <&main_r5fss0_core0_dma_memory_region>,
 			<&main_r5fss0_core0_memory_region>;
+	status = "okay";
 };
 
 &main_r5fss0_core1 {
 	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core1>;
 	memory-region = <&main_r5fss0_core1_dma_memory_region>,
 			<&main_r5fss0_core1_memory_region>;
+	status = "okay";
+};
+
+&main_r5fss1 {
+	status = "okay";
 };
 
 &main_r5fss1_core0 {
 	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core0>;
 	memory-region = <&main_r5fss1_core0_dma_memory_region>,
 			<&main_r5fss1_core0_memory_region>;
+	status = "okay";
 };
 
 &main_r5fss1_core1 {
 	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core1>;
 	memory-region = <&main_r5fss1_core1_dma_memory_region>,
 			<&main_r5fss1_core1_memory_region>;
+	status = "okay";
 };
 
 &mcu_m4fss {
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index e01866372293..a07503b192c9 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -764,28 +764,40 @@ mbox_m4_0: mbox-m4-0 {
 	};
 };
 
+&main_r5fss0 {
+	status = "okay";
+};
+
 &main_r5fss0_core0 {
 	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
 	memory-region = <&main_r5fss0_core0_dma_memory_region>,
 			<&main_r5fss0_core0_memory_region>;
+	status = "okay";
 };
 
 &main_r5fss0_core1 {
 	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core1>;
 	memory-region = <&main_r5fss0_core1_dma_memory_region>,
 			<&main_r5fss0_core1_memory_region>;
+	status = "okay";
+};
+
+&main_r5fss1 {
+	status = "okay";
 };
 
 &main_r5fss1_core0 {
 	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core0>;
 	memory-region = <&main_r5fss1_core0_dma_memory_region>,
 			<&main_r5fss1_core0_memory_region>;
+	status = "okay";
 };
 
 &main_r5fss1_core1 {
 	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core1>;
 	memory-region = <&main_r5fss1_core1_dma_memory_region>,
 			<&main_r5fss1_core1_memory_region>;
+	status = "okay";
 };
 
 &mcu_m4fss {
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 1deaa0be0085..ae4a6552644c 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -679,28 +679,40 @@ mbox_m4_0: mbox-m4-0 {
 	};
 };
 
+&main_r5fss0 {
+	status = "okay";
+};
+
 &main_r5fss0_core0 {
 	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
 	memory-region = <&main_r5fss0_core0_dma_memory_region>,
 			<&main_r5fss0_core0_memory_region>;
+	status = "okay";
 };
 
 &main_r5fss0_core1 {
 	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core1>;
 	memory-region = <&main_r5fss0_core1_dma_memory_region>,
 			<&main_r5fss0_core1_memory_region>;
+	status = "okay";
+};
+
+&main_r5fss1 {
+	status = "okay";
 };
 
 &main_r5fss1_core0 {
 	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core0>;
 	memory-region = <&main_r5fss1_core0_dma_memory_region>,
 			<&main_r5fss1_core0_memory_region>;
+	status = "okay";
 };
 
 &main_r5fss1_core1 {
 	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core1>;
 	memory-region = <&main_r5fss1_core1_dma_memory_region>,
 			<&main_r5fss1_core1_memory_region>;
+	status = "okay";
 };
 
 &mcu_m4fss {
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi b/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
index a5cec9a07510..d0c1e4dc1da7 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi
@@ -488,28 +488,40 @@ AM64X_IOPAD(0x02a8, PIN_OUTPUT, 0) /* USB0_DRVVBUS.USB0_DRVVBUS */
 	};
 };
 
+&main_r5fss0 {
+	status = "okay";
+};
+
 &main_r5fss0_core0 {
 	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
 	memory-region = <&main_r5fss0_core0_dma_memory_region>,
 			<&main_r5fss0_core0_memory_region>;
+	status = "okay";
 };
 
 &main_r5fss0_core1 {
 	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core1>;
 	memory-region = <&main_r5fss0_core1_dma_memory_region>,
 			<&main_r5fss0_core1_memory_region>;
+	status = "okay";
+};
+
+&main_r5fss1 {
+	status = "okay";
 };
 
 &main_r5fss1_core0 {
 	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core0>;
 	memory-region = <&main_r5fss1_core0_dma_memory_region>,
 			<&main_r5fss1_core0_memory_region>;
+	status = "okay";
 };
 
 &main_r5fss1_core1 {
 	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core1>;
 	memory-region = <&main_r5fss1_core1_dma_memory_region>,
 			<&main_r5fss1_core1_memory_region>;
+	status = "okay";
 };
 
 /* SoC default UART console */
diff --git a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi
index 828d815d6bdf..876cbb21961d 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi
@@ -167,28 +167,40 @@ mbox_m4_0: mbox-m4-0 {
 	};
 };
 
+&main_r5fss0 {
+	status = "okay";
+};
+
 &main_r5fss0_core0 {
 	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
 	memory-region = <&main_r5fss0_core0_dma_memory_region>,
 			<&main_r5fss0_core0_memory_region>;
+	status = "okay";
 };
 
 &main_r5fss0_core1 {
 	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core1>;
 	memory-region = <&main_r5fss0_core1_dma_memory_region>,
 			<&main_r5fss0_core1_memory_region>;
+	status = "okay";
+};
+
+&main_r5fss1 {
+	status = "okay";
 };
 
 &main_r5fss1_core0 {
 	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core0>;
 	memory-region = <&main_r5fss1_core0_dma_memory_region>,
 			<&main_r5fss1_core0_memory_region>;
+	status = "okay";
 };
 
 &main_r5fss1_core1 {
 	mboxes = <&mailbox0_cluster4 &mbox_main_r5fss1_core1>;
 	memory-region = <&main_r5fss1_core1_dma_memory_region>,
 			<&main_r5fss1_core1_memory_region>;
+	status = "okay";
 };
 
 &ospi0 {
-- 
2.34.1



Return-Path: <linux-kernel+bounces-868201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8B4C04A32
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D9D3BB915
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3189129C33D;
	Fri, 24 Oct 2025 07:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="alumUWzk"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3EF29B8D3;
	Fri, 24 Oct 2025 07:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761289838; cv=none; b=DtOHbii891pZPDNzg5qcTKYtoeQ4X2W3y/RQdgs3j7Kh2EmYodK9I1FjksGVSRKlPxSTG1MiZuTx8z37rgxueJL3APErpjjjr9C316BdBXoqqUNsVjC5Zm7I/wvtObyPqBfO4g3EuXOhRHPuMaVxKKVeH+/sLXexrKX/gOlIvCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761289838; c=relaxed/simple;
	bh=YzPTLurrb2lFXh6I/WPGl4ZSzIIdSwXmqok3OFkkwPc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jOJhi3hFqkAGLZik0J4LLQpN3xrV93/sLzrNoTkQZnhF0LFooecYBXJzdf1WN40wYpEX/xHz5g8lH6pR+ZgmLSngbTNagfooCrqWC5KRLbedvCgI/eJiB6mMTvReixhMnVQ0OKR6ixe8hVU2DqiZnxTwdXVeTTKJjtl2ww6DgcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=alumUWzk; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59O7AMTl700650;
	Fri, 24 Oct 2025 02:10:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761289822;
	bh=bbT+em5Wmy6gqI/mZFQzb6f62lPBs2rD+5s9CRiNCN0=;
	h=From:To:CC:Subject:Date;
	b=alumUWzkxvH1XgSoDg+SiuUZcerxks041MBgC555uwyJ8bITnWeOjUrTuK57K73ht
	 EkF9CRDxFNzx/GzH9XO6YAcgx/7b1qmiNJ8gn5/VJ1F6oEjIzkdYklGljzoTo3n5Tl
	 F50liMaVfNzCp2IFw/fFVSyuf/eG2jPlVsmiLwN4=
Received: from DFLE203.ent.ti.com (dfle203.ent.ti.com [10.64.6.61])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59O7AM4T3286329
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 Oct 2025 02:10:22 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Oct
 2025 02:10:22 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Oct 2025 02:10:22 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59O7AIZx4148604;
	Fri, 24 Oct 2025 02:10:19 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am642-evm: Add onboard clock overlay for PCIe and SERDES
Date: Fri, 24 Oct 2025 12:40:26 +0530
Message-ID: <20251024071027.1605638-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On certain variants of the AM642 EVMs, there is an onboard clock generator
named 'PCIe Clock HCSL (100MHz)' that outputs two 100 MHz differential
clock pair signals:
- One differential clock pair signal is fed to the PCIe Connector to serve
  as the PCIe reference clock output.
- The other differential clock pair signal is input to the SERDES as the
  reference clock for the SERDES.

In such a configuration, the SERDES should not output the PCIe reference
clock (avoid clock contention), and, the SERDES should use the onboard
clock generator as its reference clock.

Add a device-tree overlay to enable this.

Co-developed-by: Bin Liu <b-liu@ti.com>
Signed-off-by: Bin Liu <b-liu@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on linux-next tagged next-20251024.

Patch has been tested on an AM642-EVM variant that has the onboard clock
generator by applying the device-tree overlay at the Bootloader stage to
update the device-tree file 'k3-am642-evm.dtb'. An NVMe SSD was connected
to the PCIe Connector and the NVMe SSD has been verified to be functional
implying that both PCIe and SERDES are functional.
Test Logs:
https://gist.github.com/Siddharth-Vadapalli-at-TI/1ca4c28d7db5a0ee3f884508dd2aa348

Regards,
Siddharth.

 arch/arm64/boot/dts/ti/Makefile               |  4 ++
 ...-am642-evm-onboard-clkgen-pcie-serdes.dtso | 38 +++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-evm-onboard-clkgen-pcie-serdes.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 743115b849a7..bdc1307cac90 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -61,6 +61,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62x-sk-hdmi-audio.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-icssg1-dualemac.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-icssg1-dualemac-mii.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-onboard-clkgen-pcie-serdes.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-pcie0-ep.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t-pcie.dtb
@@ -194,6 +195,8 @@ k3-am642-evm-icssg1-dualemac-dtbs := \
 	k3-am642-evm.dtb k3-am642-evm-icssg1-dualemac.dtbo
 k3-am642-evm-icssg1-dualemac-mii-dtbs := \
 	k3-am642-evm.dtb k3-am642-evm-icssg1-dualemac-mii.dtbo
+k3-am642-evm-onboard-clkgen-pcie-serdes-dtbs := \
+	k3-am642-evm.dtb k3-am642-evm-onboard-clkgen-pcie-serdes.dtbo
 k3-am642-evm-pcie0-ep-dtbs := \
 	k3-am642-evm.dtb k3-am642-evm-pcie0-ep.dtbo
 k3-am642-phyboard-electra-disable-eth-phy-dtbs := \
@@ -267,6 +270,7 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-am62p5-sk-csi2-tevi-ov5640.dtb \
 	k3-am642-evm-icssg1-dualemac.dtb \
 	k3-am642-evm-icssg1-dualemac-mii.dtb \
+	k3-am642-evm-onboard-clkgen-pcie-serdes.dtb \
 	k3-am642-evm-pcie0-ep.dtb \
 	k3-am642-tqma64xxl-mbax4xxl-sdcard.dtb \
 	k3-am642-tqma64xxl-mbax4xxl-wlan.dtb \
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm-onboard-clkgen-pcie-serdes.dtso b/arch/arm64/boot/dts/ti/k3-am642-evm-onboard-clkgen-pcie-serdes.dtso
new file mode 100644
index 000000000000..d04c92033c7b
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm-onboard-clkgen-pcie-serdes.dtso
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/**
+ * DT Overlay for utilizing the "PCIe Clock HCSL (100MHz)" onboard clock
+ * generator. The clock generator outputs two 100 MHz differential clock
+ * pair signals for the purpose of:
+ * 1) Supplying the PCIe reference clock to the PCIe connector
+ * 2) Supplying the Reference clock to SERDES0
+ *
+ * AM642 EVM Product Link: https://www.ti.com/tool/TMDS64EVM
+ *
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/phy/phy-ti.h>
+
+/* Onboard clock generator provides 100 MHz reference clock to SERDES0 */
+&serdes_refclk {
+	clock-frequency = <100000000>;
+};
+
+&serdes0 {
+	/*
+	 * Remove 'phy_en_refclk' clock since SERDES0 doesn't have to generate the
+	 * PCIe reference clock (provided by the onboard clock generator).
+	 */
+	clocks = <&serdes_wiz0 TI_WIZ_PLL0_REFCLK>;
+	clock-names = "refclk";
+	assigned-clocks = <&serdes_wiz0 TI_WIZ_PLL0_REFCLK>,
+			  <&serdes_wiz0 TI_WIZ_PLL1_REFCLK>,
+			  <&serdes_wiz0 TI_WIZ_REFCLK_DIG>;
+	/* Use onboard clock generator as SERDES0 reference clock */
+	assigned-clock-parents = <&serdes_refclk>,
+				 <&serdes_refclk>,
+				 <&serdes_refclk>;
+};
-- 
2.51.0



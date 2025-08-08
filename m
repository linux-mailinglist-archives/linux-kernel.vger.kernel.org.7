Return-Path: <linux-kernel+bounces-760065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 739FBB1E618
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19B544E3FF6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DCA274B2A;
	Fri,  8 Aug 2025 09:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jOfEFfEI"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC19E27380F;
	Fri,  8 Aug 2025 09:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754647131; cv=none; b=DHIHtxU6sjJHLZkXFJZmzx1NnZRA1T+QPVYc9aKtG9q+dZ8oBjPPD5rIkCy03eJWCTU4uHXcqC8ZeHD4JQf4mdg9peS4GrxOqvIPrn2ORVQ/YUdmlIjqHXwlc4FTRnPRPzl31iUsuJ5rSFNZ9tSqX7yxMO8h+Eu0jewVL+RX8/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754647131; c=relaxed/simple;
	bh=gDHziIZDKAzvqROHLKKOwpmxnv9scspIBmEwFG0WlGI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e/7JrQDsPdCPxX/U/hAcNshHogAjP3hNawhEcyCckXunx6kpSUmNBG55Ng9IgotymZcCY5QJTcye/R93Lh17uQYoUOb3UIxcieuoDu130T7AIUoxxLzVYSDLZT2I0m9GFTGDcWfdZbYvpRJY8RvcnY5z4mT6O/fIcDAS9l3wOKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jOfEFfEI; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5789whEi1019667;
	Fri, 8 Aug 2025 04:58:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754647123;
	bh=EKH683Xir51ZW8viMniBr7xunwQ7zkltwZse8uZDZVg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=jOfEFfEI0K4kGRnnEnWc9KTpcAy1wHESEITyPwalN7o6uxD1zFPrZIlzndwvzqoZX
	 Y2Gl9mo4hqGSIrAWg4lYRuwPiglwFRFdfJzKfAmCS6DvRymxs5Dw201WiL1TLrh+GG
	 rfHT8UC00TnbjMQCTMnY6jUO71f1SKbXaQLvQgn4=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5789whAQ403680
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 8 Aug 2025 04:58:43 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 8
 Aug 2025 04:58:43 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 8 Aug 2025 04:58:43 -0500
Received: from abhilash-HP.dhcp.ti.com (abhilash-hp.dhcp.ti.com [10.24.68.198])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5789wCOu2574818;
	Fri, 8 Aug 2025 04:58:39 -0500
From: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <vaishnav.a@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>,
        <y-abhilashchandra@ti.com>, Jared McArthur <j-mcarthur@ti.com>
Subject: [PATCH V2 5/7] arm64: dts: ti: k3-j722s-main: Add interrupts property
Date: Fri, 8 Aug 2025 15:28:02 +0530
Message-ID: <20250808095804.544298-6-y-abhilashchandra@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250808095804.544298-1-y-abhilashchandra@ti.com>
References: <20250808095804.544298-1-y-abhilashchandra@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add interrupts property for CDNS CSI2RX. Interrupt IDs are taken from the
J722S TRM [0].

Interrupt Line     | Source Interrupt
-------------------|-------------------------
GICSS0_SPI_IN_178  | CSI_RX_IF1_CSI_ERR_IRQ_0
GICSS0_SPI_IN_179  | CSI_RX_IF1_CSI_IRQ_0
GICSS0_SPI_IN_219  | CSI_RX_IF2_CSI_ERR_IRQ_0
GICSS0_SPI_IN_232  | CSI_RX_IF2_CSI_IRQ_0
GICSS0_SPI_IN_249  | CSI_RX_IF3_CSI_ERR_IRQ_0
GICSS0_SPI_IN_250  | CSI_RX_IF3_CSI_IRQ_0

[0]: https://www.ti.com/lit/zip/sprujb3

Signed-off-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
Reviewed-by: Jared McArthur <j-mcarthur@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
index 5cfa7bf36641..6a8e5ff3b1d5 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
@@ -168,6 +168,9 @@ ti_csi2rx1: ticsi2rx@30122000 {
 		cdns_csi2rx1: csi-bridge@30121000 {
 			compatible = "ti,j721e-csi2rx", "cdns,csi2rx";
 			reg = <0x00 0x30121000 0x00 0x1000>;
+			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error_irq", "irq";
 			clocks = <&k3_clks 247 0>, <&k3_clks 247 3>, <&k3_clks 247 0>,
 				 <&k3_clks 247 0>, <&k3_clks 247 4>, <&k3_clks 247 4>;
 			clock-names = "sys_clk", "p_clk", "pixel_if0_clk",
@@ -221,6 +224,9 @@ ti_csi2rx2: ticsi2rx@30142000 {
 		cdns_csi2rx2: csi-bridge@30141000 {
 			compatible = "ti,j721e-csi2rx", "cdns,csi2rx";
 			reg = <0x00 0x30141000 0x00 0x1000>;
+			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error_irq", "irq";
 			clocks = <&k3_clks 248 0>, <&k3_clks 248 3>, <&k3_clks 248 0>,
 				 <&k3_clks 248 0>, <&k3_clks 248 4>, <&k3_clks 248 4>;
 			clock-names = "sys_clk", "p_clk", "pixel_if0_clk",
@@ -274,6 +280,9 @@ ti_csi2rx3: ticsi2rx@30162000 {
 		cdns_csi2rx3: csi-bridge@30161000 {
 			compatible = "ti,j721e-csi2rx", "cdns,csi2rx";
 			reg = <0x00 0x30161000 0x00 0x1000>;
+			interrupts = <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error_irq", "irq";
 			clocks = <&k3_clks 249 0>, <&k3_clks 249 3>, <&k3_clks 249 0>,
 				 <&k3_clks 249 0>, <&k3_clks 249 4>, <&k3_clks 249 4>;
 			clock-names = "sys_clk", "p_clk", "pixel_if0_clk",
-- 
2.34.1



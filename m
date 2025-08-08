Return-Path: <linux-kernel+bounces-760063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A57B1E613
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8AE3B7894
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06AD2741D1;
	Fri,  8 Aug 2025 09:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mXaXDB4E"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D288273D88;
	Fri,  8 Aug 2025 09:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754647121; cv=none; b=q9kQgXAwnaTwZ8St7weIojfDIuKXpzHDDg59p6/bXEb1Mg0970qRvqlT/K3M1WhPJbQiK+9yFuC1paaLV6ITj+NJH7Ef2L2BvEC/IDnHH2v/pZe4hPlOcu2XthPTlhvaApLil6+kYm4p4Ryki+DyqRS76sofmyFp7j1HclWrcow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754647121; c=relaxed/simple;
	bh=MX9/tJOQqsN14GhidOZKmDfgWmrhBV43lQyclc9exxg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KSXj6zlPqGU1KDVINAUoSxQAmBFHomUktxBZlpW+eEjHX8J5clpSUseJSfJ7zoIf/cpv94r86MCXelJbopKlfK/CxgdGj+HcXWqtKWbW+bq6CrHEmDRllHa0X1wA8Ii1oTiBamoEY5lOgX3oBIwuU+vizGvmCTEy4t+dbI2Qq04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mXaXDB4E; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5789wXcA569354;
	Fri, 8 Aug 2025 04:58:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754647113;
	bh=tpauH2KcGfPHJQZZuVwPrws80Ch7C83LRFFZv9pZ8c4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=mXaXDB4Exi0mpsJ+aC3zBsOpc816kIc7mZ8uDB7YBOfz/TB7S98FEDjEYgaJNPeSm
	 4UsUO9sw4595OEc65HJapcpenJfcFnJiudN6B+0Gz0uinDYZTEq4LgWL+GpN1IzvyR
	 Zonu9qDjyXICZxwWKOjTFA39ReO8iAZAwB52aOpg=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5789wXdZ403641
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 8 Aug 2025 04:58:33 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 8
 Aug 2025 04:58:33 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 8 Aug 2025 04:58:33 -0500
Received: from abhilash-HP.dhcp.ti.com (abhilash-hp.dhcp.ti.com [10.24.68.198])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5789wCOs2574818;
	Fri, 8 Aug 2025 04:58:29 -0500
From: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <vaishnav.a@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>,
        <y-abhilashchandra@ti.com>, Jared McArthur <j-mcarthur@ti.com>
Subject: [PATCH V2 3/7] arm64: dts: ti: k3-j784s4-j742s2-main-common: Add interrupts property
Date: Fri, 8 Aug 2025 15:28:00 +0530
Message-ID: <20250808095804.544298-4-y-abhilashchandra@ti.com>
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

Add interrupts property for CSI2RX. Interrupt IDs are taken from the
J784S4 TRM [0].

Interrupt Line      | Source Interrupt
--------------------|-------------------------
GIC500SS_SPI_IN_185 | CSI_RX_IF0_CSI_ERR_IRQ_0
GIC500SS_SPI_IN_184 | CSI_RX_IF0_CSI_IRQ_0
GIC500SS_SPI_IN_189 | CSI_RX_IF1_CSI_ERR_IRQ_0
GIC500SS_SPI_IN_188 | CSI_RX_IF1_CSI_IRQ_0
GIC500SS_SPI_IN_193 | CSI_RX_IF2_CSI_ERR_IRQ_0
GIC500SS_SPI_IN_192 | CSI_RX_IF2_CSI_IRQ_0

[0]: https://www.ti.com/lit/zip/spruj52

Signed-off-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
Reviewed-by: Jared McArthur <j-mcarthur@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
index 7c5b0c69897d..2159ce0c942f 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
@@ -819,6 +819,9 @@ ti_csi2rx0: ticsi2rx@4500000 {
 		cdns_csi2rx0: csi-bridge@4504000 {
 			compatible = "ti,j721e-csi2rx", "cdns,csi2rx";
 			reg = <0x00 0x04504000 0x00 0x00001000>;
+			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error_irq", "irq";
 			clocks = <&k3_clks 72 2>, <&k3_clks 72 0>, <&k3_clks 72 2>,
 				<&k3_clks 72 2>, <&k3_clks 72 3>, <&k3_clks 72 3>;
 			clock-names = "sys_clk", "p_clk", "pixel_if0_clk",
@@ -872,6 +875,9 @@ ti_csi2rx1: ticsi2rx@4510000 {
 		cdns_csi2rx1: csi-bridge@4514000 {
 			compatible = "ti,j721e-csi2rx", "cdns,csi2rx";
 			reg = <0x00 0x04514000 0x00 0x00001000>;
+			interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error_irq", "irq";
 			clocks = <&k3_clks 73 2>, <&k3_clks 73 0>, <&k3_clks 73 2>,
 				<&k3_clks 73 2>, <&k3_clks 73 3>, <&k3_clks 73 3>;
 			clock-names = "sys_clk", "p_clk", "pixel_if0_clk",
@@ -924,6 +930,9 @@ ti_csi2rx2: ticsi2rx@4520000 {
 		cdns_csi2rx2: csi-bridge@4524000 {
 			compatible = "ti,j721e-csi2rx", "cdns,csi2rx";
 			reg = <0x00 0x04524000 0x00 0x00001000>;
+			interrupts = <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error_irq", "irq";
 			clocks = <&k3_clks 74 2>, <&k3_clks 74 0>, <&k3_clks 74 2>,
 				<&k3_clks 74 2>, <&k3_clks 74 3>, <&k3_clks 74 3>;
 			clock-names = "sys_clk", "p_clk", "pixel_if0_clk",
-- 
2.34.1



Return-Path: <linux-kernel+bounces-729726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9F6B03ACB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9763E189B037
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B51124469B;
	Mon, 14 Jul 2025 09:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Z7onf8Md"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AD0244677;
	Mon, 14 Jul 2025 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752485289; cv=none; b=rXD8iD1k33shUgheSDtdSPlZibCpDH9G89lnIEKn/+5RhvYzOdF5lcproecYIs/22d9r6MJOtsGbwPg+NRTiSOjcwjEWcVfLw4KN/vch+Xfv1v2QToAP+xgsJwdAUBS3gop1cWeRspXvkZvskyG+NH8lapXncoOLbzRaAbOLWrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752485289; c=relaxed/simple;
	bh=0VBtYCq0GA9cnIYUEqKogBdlXajGQtYozBR2+QXfmiI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RiplnN6bpYB9KU2Bf6j+VunQDyFDQyPZqYRjSDXB4W62+CZ1ZA5hSO1rnAsHJe6w2zH1pi4JR/UqHfi2lzZKpgcQ4LcriFxB9Nn9K1O6pDvOhA2PA9sRPnHOVHcTXd4DmzLwYuSpDvNPOIY+GW0qffnRw5wRvjOhajIerJsRePU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Z7onf8Md; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56E9Rn0j1993574;
	Mon, 14 Jul 2025 04:27:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752485269;
	bh=YdhuwK6JLH73EW4lihvXxeaSNwtUWjczguONUCJEtvY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Z7onf8Mdz9BJxnLldwt60Va02sxCUpIZxFz5P+Af4uBCwLB3icVuHtQ+7/JsXtZGy
	 rpUG/PNEmmw3meHOfdZWLfX2ENzM+nCBl3pHYGH7uIOiMSpcu5VT5p1lrftIA34Zjs
	 MHrK13BRBGbFAlMHf108YSb/+hPoVEEDVZS73IcA=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56E9RnbC197603
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 14 Jul 2025 04:27:49 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 14
 Jul 2025 04:27:48 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 14 Jul 2025 04:27:48 -0500
Received: from abhilash-HP.dhcp.ti.com (abhilash-hp.dhcp.ti.com [172.24.227.115])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56E9RPVj279945;
	Mon, 14 Jul 2025 04:27:45 -0500
From: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <vaishnav.a@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <imx@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <y-abhilashchandra@ti.com>
Subject: [PATCH 3/7] arm64: dts: ti: k3-j784s4-j742s2-main-common: Add interrupts property
Date: Mon, 14 Jul 2025 14:57:04 +0530
Message-ID: <20250714092708.3944641-4-y-abhilashchandra@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250714092708.3944641-1-y-abhilashchandra@ti.com>
References: <20250714092708.3944641-1-y-abhilashchandra@ti.com>
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

Interrupt Line    | Source Interrupt
------------------|----------------------------
GIC500SS_0_SPI_IN_185 | CSI_RX_IF1_CSI_ERR_IRQ_0
GIC500SS_0_SPI_IN_184 | CSI_RX_IF1_CSI_IRQ_0
GIC500SS_0_SPI_IN_189 | CSI_RX_IF2_CSI_ERR_IRQ_0
GIC500SS_0_SPI_IN_188 | CSI_RX_IF2_CSI_IRQ_0
GIC500SS_0_SPI_IN_193 | CSI_RX_IF3_CSI_ERR_IRQ_0
GIC500SS_0_SPI_IN_192 | CSI_RX_IF3_CSI_IRQ_0

[0]: https://www.ti.com/lit/zip/spruj52

Signed-off-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
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



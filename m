Return-Path: <linux-kernel+bounces-760064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4213EB1E616
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E54223BDC10
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13ADD2737F9;
	Fri,  8 Aug 2025 09:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dFBlb5k3"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE1C270ED5;
	Fri,  8 Aug 2025 09:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754647126; cv=none; b=JLJv3g/pWpibUSq5cRvDYaoQ6/T+7OMdJv6s724XrOA1Ez/ddBbmdLpCFbAFKcsqGBQfjXh/ZZ0br37T3LRvnqYeOpRS1ZRJuj7UX+AfhFlvOw/cx3Zucb+ilF6yRoMkTKtq9GvK3bjYmzOtwgiBkhAl8Iv6AdkhwLAiWGT4t10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754647126; c=relaxed/simple;
	bh=TTJxbHvdswu751JlYztBmcmRmcG2dI+k3ZQdstLb25I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CdCIoX4l5pixN1tYBnoa4eN9hdy7GbSmpWkZ2kkks5SfBZ2CVXh+IDgpPndE4hqgt5WGRrSYt3DEK2/+s4rWHganUFdgiv3ojDHN4J4kPxLStTYvCb+V2rnLQcf8pUliEa0U7Q84aH0AmzkNLMywYOqwAjOOCYJWmkTkoWRTBwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dFBlb5k3; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5789wciv569358;
	Fri, 8 Aug 2025 04:58:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754647118;
	bh=6fEcLtOOORd170G02fTTchEZDijLG6F9UwBKHQDvMa4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=dFBlb5k3j9L79ALM6VVBlNLAR8p/9WWlceprFcrGAYdZjTFDsf1VwOdW88xDBZrzo
	 uTpxqt4eE6VLBdFJGLXNPX9PEhOQ1+ju/Dz2OBr9Ev0HArCwTadyBkdTcwCrdYMHa/
	 4uDfE3X2ebcF0AXIm0rH2uckw3Pl4OBbRkrbImg4=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5789wcRo1552371
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 8 Aug 2025 04:58:38 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 8
 Aug 2025 04:58:38 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 8 Aug 2025 04:58:37 -0500
Received: from abhilash-HP.dhcp.ti.com (abhilash-hp.dhcp.ti.com [10.24.68.198])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5789wCOt2574818;
	Fri, 8 Aug 2025 04:58:34 -0500
From: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <vaishnav.a@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>,
        <y-abhilashchandra@ti.com>, Jared McArthur <j-mcarthur@ti.com>
Subject: [PATCH V2 4/7] arm64: dts: ti: k3-am62p-j722s-common-main: Add interrupts property
Date: Fri, 8 Aug 2025 15:28:01 +0530
Message-ID: <20250808095804.544298-5-y-abhilashchandra@ti.com>
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
GICSS0_SPI_IN_175  | CSI_RX_IF0_CSI_ERR_IRQ_0
GICSS0_SPI_IN_173  | CSI_RX_IF0_CSI_IRQ_0

[0]: https://www.ti.com/lit/zip/sprujb3

Signed-off-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
Reviewed-by: Jared McArthur <j-mcarthur@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
index 2e5e25a8ca86..4427b12058a6 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
@@ -1045,6 +1045,9 @@ ti_csi2rx0: ticsi2rx@30102000 {
 		cdns_csi2rx0: csi-bridge@30101000 {
 			compatible = "ti,j721e-csi2rx", "cdns,csi2rx";
 			reg = <0x00 0x30101000 0x00 0x1000>;
+			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error_irq", "irq";
 			clocks = <&k3_clks 182 0>, <&k3_clks 182 3>, <&k3_clks 182 0>,
 				<&k3_clks 182 0>, <&k3_clks 182 4>, <&k3_clks 182 4>;
 			clock-names = "sys_clk", "p_clk", "pixel_if0_clk",
-- 
2.34.1



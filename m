Return-Path: <linux-kernel+bounces-729725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C38B03ACA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5C25188DC7E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67AB242928;
	Mon, 14 Jul 2025 09:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="u+hWzLl6"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C012224291B;
	Mon, 14 Jul 2025 09:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752485289; cv=none; b=o9BcQzp2jpofUswrlAyvXkxBGSRr+AM0wp5MBBhE6cs3JQ9oTxTnNHbFG7Q4mkYW8dZs2FdZNS4SKcY0n/jpWl7S45SciEOmwEN6hhYhY2qVu5OmnkJSFrUlgTpyj6hyJGWu8mCDyNL8oIYwdUEAV70QleSoxswn+ydaIMeA1NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752485289; c=relaxed/simple;
	bh=X1fzQTzwg3yeYES8/XPLc+MBe0nH2U3XNIW4Wse+BdY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=foQ0JVxOc5JK1urmbAzKE9bgJMuVwNZjMtSJiDV7zaQzark/U35BmKYamU3BpgdDnARyBc44zsuO7IlZI33CaJoOVZpNmD5vYrpuREVCMCV3gbyLjjMU7FGoUCVWfNPqfNtCFS9owed2WIBXCjD189obzRK1c9BGCGVJKg+vqKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=u+hWzLl6; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56E9S3QP2581062;
	Mon, 14 Jul 2025 04:28:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752485284;
	bh=DMcf/Il1d85oz1mq3/5ls77nUtsL+hrMHvkDp4f70Bg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=u+hWzLl6Tv3EsGkncRN8gu9DE5fvbWJ1CaZ4bMExhn1lMnw9moMA/Pv1+Cgw9s7M/
	 0dzQsIFz5zS3fUzLYqr0L2FOmPFwC0zg2Dz7bV2NJnJy3PK5d7Y3Z5l2sJ4V10xsa/
	 Km73nXx9d2KzxNaCXLsJzy0RfYsbozmguGqxR8dU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56E9S3Rq3170507
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 14 Jul 2025 04:28:03 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 14
 Jul 2025 04:28:03 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 14 Jul 2025 04:28:03 -0500
Received: from abhilash-HP.dhcp.ti.com (abhilash-hp.dhcp.ti.com [172.24.227.115])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56E9RPVm279945;
	Mon, 14 Jul 2025 04:28:00 -0500
From: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <vaishnav.a@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <imx@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <y-abhilashchandra@ti.com>
Subject: [PATCH 6/7] arm64: dts: ti: k3-am62-main: Add interrupts property
Date: Mon, 14 Jul 2025 14:57:07 +0530
Message-ID: <20250714092708.3944641-7-y-abhilashchandra@ti.com>
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

Add interrupts property for CDNS CSI2RX. Interrupt IDs are taken from the
AM62 TRM [0].

Input Index    | Interrupt Source
---------------|--------------------------
gicss0.spi.175 | csi_rx_if.0.csi_err_irq.0
gicss0.spi.173 | csi_rx_if.0.csi_irq.0

[0]: https://www.ti.com/lit/pdf/spruiv7

Signed-off-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 120ba8f9dd0e..029380dc1a35 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -1031,6 +1031,9 @@ ti_csi2rx0: ticsi2rx@30102000 {
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



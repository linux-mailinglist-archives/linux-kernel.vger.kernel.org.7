Return-Path: <linux-kernel+bounces-752664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B70B17906
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 00:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38B4F7AB181
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 22:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13545275B1D;
	Thu, 31 Jul 2025 22:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uqLaUiTb"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1C02676DF;
	Thu, 31 Jul 2025 22:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754000223; cv=none; b=cj5SC4YEd6DgPqHrZuWx7bKH5KK/5rbmKgrmmImx9VVdXhmJ9o0XQSFvsZ1Al08BPc5+oXh4K9Edxt0GFo8058c/ejATamackHA8uS8J5T0F5uvBG1tNVyMVmpdWHWg7j5ZxLVeubmxcotTGGZ4dg2QDu8l3ihNt5cPCOB8ro8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754000223; c=relaxed/simple;
	bh=f83U+T2+PBCeDKLnFO2gjKOrX5TKB2qVEuH5/8weOyc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hTyOWhHNkRSiR9Xd6qUPvdm1HteUnMzJmFO3uqNfRCd0t/VzOHGOMJgt9e/WQZOrsVqHMqjl4cVqLf+Q77QJd5PKDcHpouT6KA/ZSoprn0S2IWfabDYPm6e8esrRJMXTf31tordhUgNDoZqOJVFN/ZuEw0E3LqchahmA4Pq/A2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uqLaUiTb; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56VMGesW3587553;
	Thu, 31 Jul 2025 17:16:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754000200;
	bh=QN3d7kXcBabvZydAeOgZJZMx4cZdK5z524/HEbI4Q8g=;
	h=From:To:CC:Subject:Date;
	b=uqLaUiTbtVhjpONUrKFuwQRg/p9GC4n86cnHzlK42NfahIwaOPMJtqDLCuYU4aS+v
	 e+JWrF/gb0ynqW4AHYcsdizgRi4rFW/2uuufCi+0QSnuMz9Cq9OdEl7S7egVMO+svc
	 DSBvW5YCfDmdOq5NxCgx61qwKjZOu40KIRSK+x80=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56VMGel9323090
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 31 Jul 2025 17:16:40 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 31
 Jul 2025 17:16:40 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 31 Jul 2025 17:16:40 -0500
Received: from udba0500997.dhcp.ti.com (udba0500997.dhcp.ti.com [128.247.81.190])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56VMGefh3290646;
	Thu, 31 Jul 2025 17:16:40 -0500
From: Brandon Brnich <b-brnich@ti.com>
To: <linux-kernel@vger.kernel.org>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Devarsh
 Thakkar <devarsht@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Darren Etheridge
	<detheridge@ti.com>,
        Brandon Brnich <b-brnich@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j722s-main: Add E5010 JPEG Encoder
Date: Thu, 31 Jul 2025 17:16:22 -0500
Message-ID: <20250731221622.2187892-1-b-brnich@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This adds the node for E5010 JPEG Encoder. E5010 is a stateful JPEG Encoder
present in J722s SoC, supporting baseline encoding of semiplanar based
YUV420 and YUV422 raw video formats to JPEG encoding, with resolutions
supported from 64x64 to 8kx8k.

Signed-off-by: Brandon Brnich <b-brnich@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
index 5cfa7bf36641..1ada7202d192 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
@@ -385,6 +385,17 @@ c7x_1: dsp@7e200000 {
 		ti,sci-proc-ids = <0x31 0xff>;
 		status = "disabled";
 	};
+
+	e5010: e5010@fd20000 {
+		compatible = "img,e5010-jpeg-enc";
+		reg = <0x00 0xfd20000 0x00 0x100>,
+		      <0x00 0xfd20200 0x00 0x200>;
+		reg-names = "core","mmu";
+		clocks = <&k3_clks 201 0>;
+		clock-names = "core_clk";
+		power-domains = <&k3_pds 201 TI_SCI_PD_EXCLUSIVE>;
+		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+	};
 };
 
 &main_bcdma_csi {
-- 
2.34.1



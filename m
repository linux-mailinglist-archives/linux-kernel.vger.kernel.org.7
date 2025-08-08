Return-Path: <linux-kernel+bounces-760538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E556CB1EC93
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 17:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0A2B1894DDD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 15:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83F228689B;
	Fri,  8 Aug 2025 15:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Efg3ZFSc"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFFE285CB5;
	Fri,  8 Aug 2025 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668570; cv=none; b=LxlgpAqC2Ki1+2os3aCwBRalwRz/jwpvbqjE/yTOJzFOoT/HYUj8MuHUKEj/Jd84OgBY2DNXZqXxeJnOfmZcU4I2cKMz5tZ3W8jB9GNC4tnD1bfYQcj/KhvdjqEcbkvy4ZaLhyESJyO3X1z7A44agyvxkZ1IzW2jW/4kGEULE2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668570; c=relaxed/simple;
	bh=qfpzjLlQsWd/dz73rtB8Y4qWAxAkLUPES9eWN9vE8hY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=evqWmG1BQ8p4jV2757jr6bwHOjqFQDki4d/B1/GuEdJwv8oODTsyFTnE/+42RnQRu6/0+9r3EXbAbVB007s95bLYImKFHNkiArhWL9JAlRQbmqRfWaq6FJznAakJO+2bDrG4e6T3gPcsdpKOhbvEBXpEq1iylR+2b1d3TOrnylk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Efg3ZFSc; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 578Ftx23582641;
	Fri, 8 Aug 2025 10:55:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754668559;
	bh=D1eanfAkB5EEMvMI6mKH8d/IGekndB5PumogQ8P7NTY=;
	h=From:To:CC:Subject:Date;
	b=Efg3ZFSc0zmeTNG06/HXUNXRtG4hqEOUXzRiZ+EzshJoTBVHIqTrgan0OE7RdpcxG
	 h5FbVAiyT25eu2ohF9zKSqcXByZPlEebgy9pDrGMku7rzjsr+SYfDc6j2py53um8nZ
	 jtlDIp+JQJc2c4vq32oiBlLkeLI3FaxFp5T8bL4Q=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 578Ftxim1028687
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 8 Aug 2025 10:55:59 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 8
 Aug 2025 10:55:58 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 8 Aug 2025 10:55:58 -0500
Received: from udba0500997.dhcp.ti.com (udba0500997.dhcp.ti.com [128.247.81.190])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 578Ftw3I2977000;
	Fri, 8 Aug 2025 10:55:58 -0500
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
Subject: [PATCH v3] arm64: dts: ti: k3-j722s-main: Add E5010 JPEG Encoder
Date: Fri, 8 Aug 2025 10:55:55 -0500
Message-ID: <20250808155555.2632451-1-b-brnich@ti.com>
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

This adds node for E5010 JPEG Encoder which is a stateful JPEG Encoder
present in J722s SoC, supporting baseline encoding of semiplanar based
YUV420 and YUV422 raw video formats to JPEG encoding, with resolutions
supported from 64x64 to 8kx8k.

Signed-off-by: Brandon Brnich <b-brnich@ti.com>
---

Changes in v3:
  - Add TI compatible
  - Make node name more generic

Changes in v2:
  - remove invalid clock-names attribute

 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
index 5cfa7bf36641..c0a104bc87ad 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
@@ -385,6 +385,16 @@ c7x_1: dsp@7e200000 {
 		ti,sci-proc-ids = <0x31 0xff>;
 		status = "disabled";
 	};
+
+	e5010: jpeg-encoder@fd20000 {
+		compatible = "ti,am62a-jpeg-enc", "img,e5010-jpeg-enc";
+		reg = <0x00 0xfd20000 0x00 0x100>,
+		      <0x00 0xfd20200 0x00 0x200>;
+		reg-names = "core","mmu";
+		clocks = <&k3_clks 201 0>;
+		power-domains = <&k3_pds 201 TI_SCI_PD_EXCLUSIVE>;
+		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+	};
 };
 
 &main_bcdma_csi {
-- 
2.34.1



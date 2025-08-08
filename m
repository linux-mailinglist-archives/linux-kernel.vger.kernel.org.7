Return-Path: <linux-kernel+bounces-760870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F198B1F14C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 01:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA4F727690
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 23:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D081C28B7F3;
	Fri,  8 Aug 2025 23:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sMIbK83A"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42F528937B;
	Fri,  8 Aug 2025 23:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754695585; cv=none; b=K1XphrcHrFE4f8kYWnSZgZoEIKxStyJ5keQQxLEK9TO3ZkjtqpkOm5pElfmP+BwOJvDM0Zq09KjUZEKDC6WfoRFvawEx0d/kjiNcDzin0WVW8HYjycG3HdN7uQmnaDd+RmoVNadUgAR8QoG9yJad2LUa//LbPsyqIZCmUHRcyTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754695585; c=relaxed/simple;
	bh=qTy1tWnesG04xe8LijQZPAyTrSd6Nm2TLLVCi72Hcng=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZKT7GLkfJ/fDpKpcVh8pxNXezH2Lb23DjlJegidVR63SPtDR7ZzfCO4J6EtqSvNzM0TqplaE8ZA2jFTc2I6CdYOQhd9NBy+5VEH4UXJ27qYyloL38JsxcGpJFdFv/Rx6zY0S1wIUIK8XSFxt83ijj40/Yrthe20SNXh1V4RE8Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sMIbK83A; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 578NQ315695282;
	Fri, 8 Aug 2025 18:26:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754695563;
	bh=Zl3QejqPun2r+LOsmnN/PgiHG24NsWIeEiLN8ztW+jA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=sMIbK83Ab2o6pce6IRt8cSr9ECtZDbR/t7qh2sh5ojhHGWkpaHl1SQQIgnsrQukeU
	 xq5G5ld1lm4kz8kBQpGUVy2gVxqivCvg4xEgBuWHI9wbnfhkNg7wYdOuWH2FcnEVPd
	 n6Ae6P8yKTBaaGYr4Y9RMdEF5qWyBR+/GjI8KQ20=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 578NQ2RV1922250
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 8 Aug 2025 18:26:02 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 8
 Aug 2025 18:26:02 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 8 Aug 2025 18:26:02 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.144])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 578NQ2Rv3452261;
	Fri, 8 Aug 2025 18:26:02 -0500
From: <rs@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>
CC: <conor+dt@kernel.org>, <d-gole@ti.com>, <afd@ti.com>, <bb@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <detheridge@ti.com>,
        <matt.coster@imgtec.com>
Subject: [PATCH 3/3] arm64: dts: ti: k3-j784s4-j742s2: enable the bxs-4-64
Date: Fri, 8 Aug 2025 18:25:22 -0500
Message-ID: <20250808232522.1296240-3-rs@ti.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250808232522.1296240-1-rs@ti.com>
References: <20250808232522.1296240-1-rs@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Randolph Sapp <rs@ti.com>

Add the relevant device tree node for Imagination's BXS-4-64 GPU.

These devices uses a similar MSMC configuration to the J721S2. As such,
they also require the use of the dma-coherent attribute.

Signed-off-by: Randolph Sapp <rs@ti.com>
---
 .../boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi  | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
index 7c5b0c69897d..a44ca34dda62 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
@@ -2691,4 +2691,18 @@ bist_main14: bist@33c0000 {
 		bootph-pre-ram;
 		ti,sci-dev-id = <234>;
 	};
+
+	gpu: gpu@4e20000000 {
+		compatible = "ti,j721s2-gpu", "img,img-bxs-4-64", "img,img-rogue";
+		reg = <0x4e 0x20000000 0x00 0x80000>;
+		clocks = <&k3_clks 181 1>;
+		clock-names = "core";
+		assigned-clocks = <&k3_clks 181 1>;
+		assigned-clock-rates = <800000000>;
+		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 181 TI_SCI_PD_EXCLUSIVE>,
+				<&k3_pds 182 TI_SCI_PD_EXCLUSIVE>;
+		power-domain-names = "a", "b";
+		dma-coherent;
+	};
 };
-- 
2.50.1



Return-Path: <linux-kernel+bounces-760871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FBBB1F14D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 01:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4473C727B9E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 23:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AB628BA88;
	Fri,  8 Aug 2025 23:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZcqeN1n+"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59B3289E14;
	Fri,  8 Aug 2025 23:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754695585; cv=none; b=BMefKGkFzLdzQCifHEr+6nMvzJcal7X9DdG/Y7GfH6XZWoDUpMaLEOV2yluwxNEYbUzQOcB1z08V3PIUiibHhbfE5v0jd/WK7fPNoqOLXisZLzhXdNEcn1Ghmg9ca7+xuAdbBzcTPQVc72URzeZ3t+GfjJQYfoKmMtXewTeXmoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754695585; c=relaxed/simple;
	bh=ewFySAAukAuvB0n36n+W02FjD4HfQuWjCDAZ0sg/bCM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=khZ1BGMZj/YVU/m1Ozm93/JJKpzbKEiMWt6CoZbBGsLH0cF6scEqUU2XTV8PX+y3CFvEvF7cIziBo9BeZoBLGgpht7HMd7i0Wdhf/sEgXoGBHbwFZV+S5sPmEdrrlV+BVPhfN9P2iq4ghnmD6MWCTJZ2dQ8TYP3tsAYoa0w25oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZcqeN1n+; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 578NQ3p21144772;
	Fri, 8 Aug 2025 18:26:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754695563;
	bh=n/cQCpTjNp7NaTO7wwD6pgxbUD76is+JmYVN/rSHXcU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ZcqeN1n+r8k0mbHcExlq9neIQiACmIwu1o2TEWKeZx8EWRqqZzrvsyRqNdHbZkqlm
	 Xhg9krHQ/hptwOhXrkajHhhyfvMuRj5EhEymV7R5aNkIKwwFOzo1KwGpYpKGIzF96f
	 9+aJkCEhGJv7bF+N8A/g+hQQc7AjSvjweEI0En7Q=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 578NQ3QJ1922268
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 8 Aug 2025 18:26:03 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 8
 Aug 2025 18:26:02 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 8 Aug 2025 18:26:02 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.144])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 578NQ2Ru3452261;
	Fri, 8 Aug 2025 18:26:02 -0500
From: <rs@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>
CC: <conor+dt@kernel.org>, <d-gole@ti.com>, <afd@ti.com>, <bb@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <detheridge@ti.com>,
        <matt.coster@imgtec.com>
Subject: [PATCH 2/3] arm64: dts: ti: k3-am62p-j722s: enable the bxs-4-64
Date: Fri, 8 Aug 2025 18:25:21 -0500
Message-ID: <20250808232522.1296240-2-rs@ti.com>
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

These devices specifically do not set the dma-coherent bit because they
do not use the same MSMC configuration as other BXS-4-64 enabled TI
platforms.

Signed-off-by: Randolph Sapp <rs@ti.com>
---
 .../boot/dts/ti/k3-am62p-j722s-common-main.dtsi     | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
index 2e5e25a8ca86..a51db8f9dff8 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
@@ -690,6 +690,19 @@ ospi0: spi@fc40000 {
 		};
 	};
 
+	gpu: gpu@fd80000 {
+		compatible = "ti,j721s2-gpu", "img,img-bxs-4-64", "img,img-rogue";
+		reg = <0x00 0x0fd80000 0x00 0x80000>;
+		clocks = <&k3_clks 237 1>;
+		clock-names = "core";
+		assigned-clocks = <&k3_clks 237 1>;
+		assigned-clock-rates = <800000000>;
+		interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 237 TI_SCI_PD_EXCLUSIVE>,
+				<&k3_pds 242 TI_SCI_PD_EXCLUSIVE>;
+		power-domain-names = "a", "b";
+	};
+
 	cpsw3g: ethernet@8000000 {
 		compatible = "ti,am642-cpsw-nuss";
 		#address-cells = <2>;
-- 
2.50.1



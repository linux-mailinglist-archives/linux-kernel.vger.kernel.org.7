Return-Path: <linux-kernel+bounces-799635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6FFB42E5C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8DB75E8323
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C90450FE;
	Thu,  4 Sep 2025 00:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bGYZ3vJM"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BE317993;
	Thu,  4 Sep 2025 00:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756946852; cv=none; b=jMAxRcPXedAIR1Gs01yd8HEULuPGsyHnu1QITZCIZGwm8y7GCSMOQedFIf4EgS0ug4NEGXVd6KVqd94ZNT5/U/o+hVYgYhsiD4TXbE4avvDJrGwBR0181GevgpTtGrx/DFt1MLLlYzYb1S12Ril9BLQrLXp3VlYkXCWjQDV2qcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756946852; c=relaxed/simple;
	bh=AyJS54xqqCZ7YIjFNLgJ/Z/oHdn8Zj6P4vvoF1ekuaU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jG/ToKwQ6Bhy2stFWW9jkOIkN467TQwT1+6sY3inb+XhHo9/nYF9ftL9bhvIx9i1qj2a9xJi0rMxFwSAl+BK99zAQ3ZylHAhRjoj4TZhSZHiileyij8T24NG2PiqF/8NEKuDfRlrXSVcU7x8YulBJukrVI4umzNMegdtv3weOio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bGYZ3vJM; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5840lOOW3349406;
	Wed, 3 Sep 2025 19:47:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756946844;
	bh=rexbZq37ojm1gWgYILbmLhzidPbLhbryKWFIZQaYdpU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=bGYZ3vJMnT630Vnx1nX3daMbYnOH4RnN0pfJMhRpPyc/BpXIqXMjWG6/RWvTaC7iv
	 B6G6+NoAwf5/ocbDSmgXXUT0ORHFW87ijJgMLIaRJcl9mgRi3r+iSBAumGDP9M+JTl
	 Y21QLQ8ijLoPbIgFtzJ5vLZxERkw1mvuy24GctL8=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5840lOjp3984944
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 3 Sep 2025 19:47:24 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 3
 Sep 2025 19:47:23 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 3 Sep 2025 19:47:24 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5840lNZK2425599;
	Wed, 3 Sep 2025 19:47:23 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Nishanth Menon <nm@ti.com>
CC: Moteen Shah <m-shah@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] arm64: dts: ti: k3-am62p/j722s: Move sdhci0 from common
Date: Wed, 3 Sep 2025 19:47:22 -0500
Message-ID: <20250904004723.2856005-2-jm@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250904004723.2856005-1-jm@ti.com>
References: <20250904004723.2856005-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Since eMMC HS400 has been descoped for j722s due to errata i2478 [0]
and is supported for am62p SR1.2 device, remove sdhci0 node from
common-main.dtsi and include instead in each device's main.dtsi
appropriately.

[0] https://www.ti.com/lit/pdf/sprz575
Signed-off-by: Judith Mendez <jm@ti.com>
---
 .../dts/ti/k3-am62p-j722s-common-main.dtsi    | 25 -------------------
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi     | 25 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi     | 22 ++++++++++++++++
 3 files changed, 47 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
index 4427b12058a6..84083f5125df 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
@@ -566,31 +566,6 @@ main_gpio1: gpio@601000 {
 		clock-names = "gpio";
 	};
 
-	sdhci0: mmc@fa10000 {
-		compatible = "ti,am64-sdhci-8bit";
-		reg = <0x00 0x0fa10000 0x00 0x1000>, <0x00 0x0fa18000 0x00 0x400>;
-		interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
-		power-domains = <&k3_pds 57 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 57 1>, <&k3_clks 57 2>;
-		clock-names = "clk_ahb", "clk_xin";
-		bus-width = <8>;
-		mmc-ddr-1_8v;
-		mmc-hs200-1_8v;
-		mmc-hs400-1_8v;
-		ti,clkbuf-sel = <0x7>;
-		ti,strobe-sel = <0x77>;
-		ti,trm-icp = <0x8>;
-		ti,otap-del-sel-legacy = <0x1>;
-		ti,otap-del-sel-mmc-hs = <0x1>;
-		ti,otap-del-sel-ddr52 = <0x6>;
-		ti,otap-del-sel-hs200 = <0x8>;
-		ti,otap-del-sel-hs400 = <0x5>;
-		ti,itap-del-sel-legacy = <0x10>;
-		ti,itap-del-sel-mmc-hs = <0xa>;
-		ti,itap-del-sel-ddr52 = <0x3>;
-		status = "disabled";
-	};
-
 	sdhci1: mmc@fa00000 {
 		compatible = "ti,am62-sdhci";
 		reg = <0x00 0x0fa00000 0x00 0x1000>, <0x00 0x0fa08000 0x00 0x400>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
index 6aea9d3f134e..fb8473ce403a 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
@@ -31,6 +31,31 @@ usb1: usb@31100000 {
 			snps,usb2-lpm-disable;
 		};
 	};
+
+	sdhci0: mmc@fa10000 {
+		compatible = "ti,am64-sdhci-8bit";
+		reg = <0x00 0x0fa10000 0x00 0x1000>, <0x00 0x0fa18000 0x00 0x400>;
+		interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 57 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 57 1>, <&k3_clks 57 2>;
+		clock-names = "clk_ahb", "clk_xin";
+		bus-width = <8>;
+		mmc-ddr-1_8v;
+		mmc-hs200-1_8v;
+		mmc-hs400-1_8v;
+		ti,clkbuf-sel = <0x7>;
+		ti,strobe-sel = <0x77>;
+		ti,trm-icp = <0x8>;
+		ti,otap-del-sel-legacy = <0x1>;
+		ti,otap-del-sel-mmc-hs = <0x1>;
+		ti,otap-del-sel-ddr52 = <0x6>;
+		ti,otap-del-sel-hs200 = <0x8>;
+		ti,otap-del-sel-hs400 = <0x5>;
+		ti,itap-del-sel-legacy = <0x10>;
+		ti,itap-del-sel-mmc-hs = <0xa>;
+		ti,itap-del-sel-ddr52 = <0x3>;
+		status = "disabled";
+	};
 };
 
 &oc_sram {
diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
index 993828872dfb..2978fe1a151e 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
@@ -404,6 +404,28 @@ e5010: jpeg-encoder@fd20000 {
 		power-domains = <&k3_pds 201 TI_SCI_PD_EXCLUSIVE>;
 		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	sdhci0: mmc@fa10000 {
+		compatible = "ti,am64-sdhci-8bit";
+		reg = <0x00 0x0fa10000 0x00 0x1000>, <0x00 0x0fa18000 0x00 0x400>;
+		interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 57 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 57 1>, <&k3_clks 57 2>;
+		clock-names = "clk_ahb", "clk_xin";
+		bus-width = <8>;
+		mmc-ddr-1_8v;
+		mmc-hs200-1_8v;
+		ti,clkbuf-sel = <0x7>;
+		ti,trm-icp = <0x8>;
+		ti,otap-del-sel-legacy = <0x1>;
+		ti,otap-del-sel-mmc-hs = <0x1>;
+		ti,otap-del-sel-ddr52 = <0x6>;
+		ti,otap-del-sel-hs200 = <0x8>;
+		ti,itap-del-sel-legacy = <0x10>;
+		ti,itap-del-sel-mmc-hs = <0xa>;
+		ti,itap-del-sel-ddr52 = <0x3>;
+		status = "disabled";
+	};
 };
 
 &main_bcdma_csi {
-- 
2.51.0



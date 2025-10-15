Return-Path: <linux-kernel+bounces-854378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5ABBDE3A7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B04D93570E7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054501CD15;
	Wed, 15 Oct 2025 11:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LI8Q59h/"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFF231D381;
	Wed, 15 Oct 2025 11:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760526838; cv=none; b=EZ3ipskGmmkBvklT3ex3d95+Ma9L9VMqcA9IRMWz+RCmiW7PuNi0wejEHlyiLyZHeGtiZJVBIQvkBIx7wa588+D7jSryPJWPqxSiK1t/0UEbaIUhdJnDcjguthXkmNJgIBqwO1ZQyadeGN083Nf5yELxOUwdHnD0TqccSyfJGDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760526838; c=relaxed/simple;
	bh=wLFy8lfwr7MtTvVA3cKIDDM35RG4Z1R/vfJBh+nldO8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sHNVlH0A5gBY2wigp328BACk9kY19RetQIXH+6k+YZGMIrpEJ4VgnKpndNfsrm4HO6er9xsLGW+BrXVrowJTJeEk80e7ilNzq0EBYU30kvyDgvW9n1zhiEVJYTK8TpgDPYIcc8b1bpesypAHt8qkGij1zRC/3c+v6DA0JtuEvh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LI8Q59h/; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59FBDjZ81740202;
	Wed, 15 Oct 2025 06:13:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760526825;
	bh=mfRzuFZDGmx+pi4KXtpUTIsroTNbAXu2X+9+SkR1MsQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=LI8Q59h/h4V+1BKlRzqRnFEg3x5R/ARG8Hko8vHiCcavmM7wwucuQ7DU7Ri3wYjzL
	 3CP+nWNqHC1F7cfh6UXHjVe5pMbc8mwbyUf885AlGl0oz4Byz1W4ZUla0m9un7sxIN
	 2UqtxUxyBmG06TENAVBYeXPh96TsfOctfUGoG6HE=
Received: from DFLE204.ent.ti.com (dfle204.ent.ti.com [10.64.6.62])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59FBDjjr1179828
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 15 Oct 2025 06:13:45 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Oct
 2025 06:13:45 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Oct 2025 06:13:45 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59FBDbHj1809909;
	Wed, 15 Oct 2025 06:13:42 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <d.haller@phytec.de>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v4 1/5] arm64: dts: ti: k3-am62: disable "cpsw3g" in SoC file and enable in board file
Date: Wed, 15 Oct 2025 16:43:33 +0530
Message-ID: <20251015111344.3639415-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015111344.3639415-1-s-vadapalli@ti.com>
References: <20251015111344.3639415-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Following the existing convention of disabling nodes in the SoC file and
enabling only the required ones in the board file, disable "cpsw3g" node
in the SoC file "k3-am62-main.dtsi" and enable it in the board (or board
include) files:
a) k3-am62-lp-sk.dts
b) k3-am62-phycore-som.dtsi
c) k3-am625-beagleplay.dts
d) k3-am625-sk-common.dtsi

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

v3 of this patch is at:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20251014125349.3408784-2-s-vadapalli@ti.com/
Changes since v3:
- Rebased patch on next-20251014.
- Based on feedback from Dominik Haller <d.haller@phytec.de> at:
  https://lore.kernel.org/r/df6acbfe5d30956ed66e2768fa595c36d2ebe98a.camel@phytec.de/
  cpsw has been enabled in k3-am62-phycore-som.dtsi

 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts        | 4 ++++
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi        | 2 ++
 arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi | 1 +
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts  | 1 +
 arch/arm64/boot/dts/ti/k3-am625-sk-common.dtsi  | 1 +
 5 files changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
index ecfba05fe5c2..89be21783e27 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
@@ -181,6 +181,10 @@ &sdhci1 {
 	vqmmc-supply = <&vddshv_sdio>;
 };
 
+&cpsw3g {
+	status = "okay";
+};
+
 &cpsw_port2 {
 	status = "disabled";
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 40fb3c9e674c..0fd23ee996a1 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -723,6 +723,8 @@ cpsw3g: ethernet@8000000 {
 		dma-names = "tx0", "tx1", "tx2", "tx3", "tx4", "tx5", "tx6",
 			    "tx7", "rx";
 
+		status = "disabled";
+
 		ethernet-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
index eeca643fedbe..1265ec792b13 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
@@ -211,6 +211,7 @@ opp-1400000000 {
 &cpsw3g {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_rgmii1_pins_default>;
+	status = "okay";
 };
 
 &cpsw_port1 {
diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
index 7028d9835c4a..774178b9aa88 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
@@ -590,6 +590,7 @@ &cpsw3g {
 		    <&gbe_pmx_obsclk>;
 	assigned-clocks = <&k3_clks 157 70>, <&k3_clks 157 20>;
 	assigned-clock-parents = <&k3_clks 157 72>, <&k3_clks 157 22>;
+	status = "okay";
 };
 
 &cpsw_port1 {
diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am625-sk-common.dtsi
index fe0b98e1d105..73a8882a650a 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk-common.dtsi
@@ -212,6 +212,7 @@ &sdhci1 {
 &cpsw3g {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_rgmii1_pins_default>, <&main_rgmii2_pins_default>;
+	status = "okay";
 };
 
 &cpsw_port2 {
-- 
2.51.0



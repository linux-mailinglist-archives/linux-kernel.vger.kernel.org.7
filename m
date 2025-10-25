Return-Path: <linux-kernel+bounces-869840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9DFC08D67
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 09:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AB404E822F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 07:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8812E54D1;
	Sat, 25 Oct 2025 07:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aT10W6Oj"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BB12D9EFC;
	Sat, 25 Oct 2025 07:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761377895; cv=none; b=m/8YNjT2P3jNYfhPMazpqJ8Z+29IOhzrRRchEewxvGcTPAS+WuaQ7LxvtwpryGDZEYsJl4LHL6CilhNeq7lvM+4QyLOvZvLkHFVtvfRu4ttES9igU6KE4xGdvyzxLzgwoxvd8uWRpMr6VxS1nV5utw5nUMg0no1i7pfLAk+nfck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761377895; c=relaxed/simple;
	bh=B77uCjWGnLkqZiz3JqNuCKakjxMi7nXAQARWSFzlKy0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pAUWKbmn2ruWQcYSfhzYmuUzfoFJ/COeX+3LL+Ye1yKRcWZsS6B/ReS6d2QsxAGbUUmt4PQhcJP0o7DJ4rc1Csbd3o/7TujSg+IWgsKyiv85JOTixoP1dJRGkdDBKHJI4xgG3h3yXjJ9pvoRh9KldRhoBa7XqAUvEmmj4aTtuIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aT10W6Oj; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59P7buxj2053674;
	Sat, 25 Oct 2025 02:37:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761377876;
	bh=qYKT716aMY+owi+NZNJDxv+VNu37GVYDK+vvVdVsVj8=;
	h=From:To:CC:Subject:Date;
	b=aT10W6Oj0whFanBwsorhuMXW8ARYB0QQC/l/H1BZk58B2mLeJyz7V0ACbbas+RQwV
	 4KODTeKU/TZC1n0b4QAabd/SNH4AMx5fLUtrgpUApDQlOsAl7k2PU15bo0HEs2CSZn
	 1C8KVXQLDGbBRSREhDqaBj527H+tKvHhgfton0qk=
Received: from DLEE201.ent.ti.com (dlee201.ent.ti.com [157.170.170.76])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59P7buam3721762
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 25 Oct 2025 02:37:56 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 25 Oct
 2025 02:37:56 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 25 Oct 2025 02:37:56 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59P7bqnX1594606;
	Sat, 25 Oct 2025 02:37:53 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-*: Replace rgmii-rxid with rgmii-id for CPSW ports
Date: Sat, 25 Oct 2025 13:07:59 +0530
Message-ID: <20251025073802.1790437-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The MAC Ports across all of the CPSW instances (CPSW2G, CPSW3G, CPSW5G and
CPSW9G) present in various K3 SoCs only support the 'RGMII-ID' mode. This
correction has been implemented/enforced by the updates to:
a) Device-Tree binding for CPSW [0]
b) Driver for CPSW [1]
c) Driver for CPSW MAC Port's GMII [2]

To complete the transition from 'RGMII-RXID' to 'RGMII-ID', update the
'phy-mode' property for all CPSW ports by replacing 'rgmii-rxid' with
'rgmii-id'.

[0]: commit 9b357ea52523 ("dt-bindings: net: ti: k3-am654-cpsw-nuss: update phy-mode in example")
[1]: commit ca13b249f291 ("net: ethernet: ti: am65-cpsw: fixup PHY mode for fixed RGMII TX delay")
[2]: commit a22d3b0d49d4 ("phy: ti: gmii-sel: Always write the RGMII ID setting")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on linux-next tagged next-20251024.

Regards,
Siddharth.

 arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi          | 2 +-
 arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi           | 2 +-
 arch/arm64/boot/dts/ti/k3-am62-verdin-ivy.dtsi           | 2 +-
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi               | 2 +-
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts           | 2 +-
 arch/arm64/boot/dts/ti/k3-am625-sk-common.dtsi           | 3 +--
 arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi         | 2 +-
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts                  | 2 +-
 arch/arm64/boot/dts/ti/k3-am62p-verdin-dev.dtsi          | 2 +-
 arch/arm64/boot/dts/ti/k3-am62p-verdin-ivy.dtsi          | 2 +-
 arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi              | 2 +-
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts                  | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi       | 2 +-
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi           | 2 +-
 arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi          | 2 +-
 arch/arm64/boot/dts/ti/k3-am642-evm.dts                  | 4 ++--
 arch/arm64/boot/dts/ti/k3-am642-sk.dts                   | 4 ++--
 arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts   | 2 +-
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts           | 2 +-
 arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts           | 2 +-
 arch/arm64/boot/dts/ti/k3-am68-phyboard-izar.dts         | 2 +-
 arch/arm64/boot/dts/ti/k3-am68-phycore-som.dtsi          | 2 +-
 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts         | 2 +-
 arch/arm64/boot/dts/ti/k3-am69-sk.dts                    | 2 +-
 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts    | 2 +-
 arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts       | 2 +-
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts    | 2 +-
 arch/arm64/boot/dts/ti/k3-j721e-evm-gesi-exp-board.dtso  | 8 ++++----
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts                   | 2 +-
 arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts   | 2 +-
 arch/arm64/boot/dts/ti/k3-j721s2-evm-gesi-exp-board.dtso | 2 +-
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts                  | 2 +-
 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi  | 4 ++--
 33 files changed, 40 insertions(+), 41 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
index eeca643fedbe..985963774c00 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
@@ -214,7 +214,7 @@ &cpsw3g {
 };
 
 &cpsw_port1 {
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&cpsw3g_phy1>;
 	bootph-all;
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi
index 5c1284b802ad..3d1406acf680 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi
@@ -74,7 +74,7 @@ &cpsw_port1 {
 /* Verdin ETH_2_RGMII */
 &cpsw_port2 {
 	phy-handle = <&cpsw3g_phy1>;
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin-ivy.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin-ivy.dtsi
index 71c29eab0eee..844f59f772e1 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin-ivy.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin-ivy.dtsi
@@ -268,7 +268,7 @@ &cpsw_port1 {
 /* Verdin ETH_2_RGMII */
 &cpsw_port2 {
 	phy-handle = <&cpsw3g_phy1>;
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
index dc4b228a9fd7..2a7242a2fef8 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
@@ -845,7 +845,7 @@ &cpsw3g {
 /* Verdin ETH_1 (On-module PHY) */
 &cpsw_port1 {
 	phy-handle = <&cpsw3g_phy0>;
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	status = "disabled";
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
index 7028d9835c4a..7b9ae467e95a 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
@@ -593,7 +593,7 @@ &cpsw3g {
 };
 
 &cpsw_port1 {
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&cpsw3g_phy0>;
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am625-sk-common.dtsi
index fe0b98e1d105..7eb9066bff82 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk-common.dtsi
@@ -215,8 +215,7 @@ &cpsw3g {
 };
 
 &cpsw_port2 {
-	/* PCB provides an internal delay of 2ns */
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&cpsw3g_phy1>;
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi
index b3d012a5a26a..b24a63feeab8 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi
@@ -192,7 +192,7 @@ &cpsw3g {
 };
 
 &cpsw_port1 {
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&cpsw3g_phy1>;
 	bootph-all;
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index af591fe6ae4f..de850307912c 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -731,7 +731,7 @@ &phy_gmii_sel {
 
 &cpsw_port1 {
 	status = "okay";
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&cpsw3g_phy0>;
 	bootph-all;
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am62p-verdin-dev.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-verdin-dev.dtsi
index 0679d76f31bd..a0d5b15fc147 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-verdin-dev.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-verdin-dev.dtsi
@@ -78,7 +78,7 @@ &cpsw_port1 {
 /* Verdin ETH_2_RGMII */
 &cpsw_port2 {
 	phy-handle = <&carrier_eth_phy>;
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62p-verdin-ivy.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-verdin-ivy.dtsi
index 317c8818f9ee..04f13edcb166 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-verdin-ivy.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-verdin-ivy.dtsi
@@ -275,7 +275,7 @@ &cpsw_port1 {
 /* Verdin ETH_2_RGMII */
 &cpsw_port2 {
 	phy-handle = <&carrier_eth_phy>;
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi
index 99810047614e..5e050cbb9eaf 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi
@@ -813,7 +813,7 @@ som_eth_phy: ethernet-phy@0 {
 /* Verdin ETH_1 (On-module PHY) */
 &cpsw_port1 {
 	phy-handle = <&som_eth_phy>;
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	status = "disabled";
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
index a064a632680e..f04cf2d23d84 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
@@ -541,14 +541,14 @@ &cpsw3g {
 };
 
 &cpsw_port1 {
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&cpsw3g_phy0>;
 	status = "okay";
 	bootph-all;
 };
 
 &cpsw_port2 {
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&cpsw3g_phy1>;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi
index aab74d6019b0..d6e70ee15938 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra.dtsi
@@ -291,7 +291,7 @@ &cpsw3g {
 };
 
 &cpsw_port2 {
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&cpsw3g_phy3>;
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index 58f78c0de292..50ed859ae06c 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -438,7 +438,7 @@ &cpsw3g {
 
 &cpsw_port1 {
 	bootph-all;
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&cpsw3g_phy0>;
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
index 02ef1dd92eaa..d64fb81b04e2 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
@@ -178,7 +178,7 @@ cpsw3g_phy1: ethernet-phy@1 {
 };
 
 &cpsw_port1 {
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&cpsw3g_phy1>;
 	bootph-all;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 85dcff104936..80c52e06b4ce 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -579,13 +579,13 @@ &cpsw3g {
 
 &cpsw_port1 {
 	bootph-all;
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&cpsw3g_phy0>;
 	status = "okay";
 };
 
 &cpsw_port2 {
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&cpsw3g_phy3>;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 1fb1b91a1bad..34bfa99bd4b8 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -499,13 +499,13 @@ &cpsw3g {
 };
 
 &cpsw_port1 {
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&cpsw3g_phy0>;
 	status = "okay";
 };
 
 &cpsw_port2 {
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&cpsw3g_phy1>;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
index 8f64d6272b1b..e5f2f20fdb11 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
@@ -185,7 +185,7 @@ &cpsw3g {
 };
 
 &cpsw_port1 {
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&cpsw3g_phy0>;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index 0c42c486d83a..961287b6a3ed 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -586,7 +586,7 @@ phy0: ethernet-phy@0 {
 };
 
 &cpsw_port1 {
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&phy0>;
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts b/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts
index b697035df04e..5255e04b9ac7 100644
--- a/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts
+++ b/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts
@@ -249,7 +249,7 @@ cpsw3g_phy0: ethernet-phy@0 {
 };
 
 &cpsw_port1 {
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&cpsw3g_phy0>;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am68-phyboard-izar.dts b/arch/arm64/boot/dts/ti/k3-am68-phyboard-izar.dts
index 41c8f8526e15..edc9f9b12f0e 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-phyboard-izar.dts
+++ b/arch/arm64/boot/dts/ti/k3-am68-phyboard-izar.dts
@@ -281,7 +281,7 @@ J721S2_WKUP_IOPAD(0x04c, PIN_OUTPUT, 0) /* (D27) WKUP_UART0_TXD */
 };
 
 &cpsw_port1 {
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&phy0>;
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-am68-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am68-phycore-som.dtsi
index adef02bd8040..911007778bc6 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am68-phycore-som.dtsi
@@ -175,7 +175,7 @@ phy1: ethernet-phy@0 {
 
 &main_cpsw_port1 {
 	phy-handle = <&phy1>;
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
index 75a107456ce1..b8400cba832b 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
@@ -705,7 +705,7 @@ phy0: ethernet-phy@0 {
 };
 
 &cpsw_port1 {
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&phy0>;
 	bootph-all;
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index 5896e57b5b9e..3a870b9b984d 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -771,7 +771,7 @@ mcu_phy0: ethernet-phy@0 {
 
 &mcu_cpsw_port1 {
 	status = "okay";
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&mcu_phy0>;
 	bootph-all;
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index f684ce6ad9ad..4608828512d1 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -334,7 +334,7 @@ phy0: ethernet-phy@0 {
 };
 
 &cpsw_port1 {
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&phy0>;
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
index 352fb60e6ce8..2e9455ab0bfa 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
@@ -677,7 +677,7 @@ phy0: ethernet-phy@0 {
 };
 
 &cpsw_port1 {
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&phy0>;
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 45311438315f..317cd0bfa406 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -780,7 +780,7 @@ phy0: ethernet-phy@0 {
 };
 
 &cpsw_port1 {
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&phy0>;
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-evm-gesi-exp-board.dtso b/arch/arm64/boot/dts/ti/k3-j721e-evm-gesi-exp-board.dtso
index f84aa9f94547..3bfe6036a8e6 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-evm-gesi-exp-board.dtso
+++ b/arch/arm64/boot/dts/ti/k3-j721e-evm-gesi-exp-board.dtso
@@ -37,7 +37,7 @@ &rgmii3_default_pins
 &cpsw0_port1 {
 	status = "okay";
 	phy-handle = <&cpsw9g_phy12>;
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	mac-address = [00 00 00 00 00 00];
 	phys = <&cpsw0_phy_gmii_sel 1>;
 };
@@ -45,7 +45,7 @@ &cpsw0_port1 {
 &cpsw0_port2 {
 	status = "okay";
 	phy-handle = <&cpsw9g_phy15>;
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	mac-address = [00 00 00 00 00 00];
 	phys = <&cpsw0_phy_gmii_sel 2>;
 };
@@ -53,7 +53,7 @@ &cpsw0_port2 {
 &cpsw0_port3 {
 	status = "okay";
 	phy-handle = <&cpsw9g_phy0>;
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	mac-address = [00 00 00 00 00 00];
 	phys = <&cpsw0_phy_gmii_sel 3>;
 };
@@ -61,7 +61,7 @@ &cpsw0_port3 {
 &cpsw0_port4 {
 	status = "okay";
 	phy-handle = <&cpsw9g_phy3>;
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	mac-address = [00 00 00 00 00 00];
 	phys = <&cpsw0_phy_gmii_sel 4>;
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 5e5784ef6f85..febbac9262de 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -1045,7 +1045,7 @@ phy0: ethernet-phy@0 {
 };
 
 &cpsw_port1 {
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&phy0>;
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
index 9e43dcff8ef2..24f57f02588f 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
@@ -469,7 +469,7 @@ phy0: ethernet-phy@0 {
 };
 
 &cpsw_port1 {
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&phy0>;
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-evm-gesi-exp-board.dtso b/arch/arm64/boot/dts/ti/k3-j721s2-evm-gesi-exp-board.dtso
index 8583178fa1f3..6869a95c6214 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-evm-gesi-exp-board.dtso
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-evm-gesi-exp-board.dtso
@@ -80,6 +80,6 @@ main_cpsw_phy0: ethernet-phy@0 {
 
 &main_cpsw_port1 {
 	status = "okay";
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&main_cpsw_phy0>;
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index e0e303da7e15..5e7767e45130 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -388,7 +388,7 @@ cpsw3g_phy0: ethernet-phy@0 {
 };
 
 &cpsw_port1 {
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&cpsw3g_phy0>;
 	status = "okay";
 	bootph-all;
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
index 419c1a70e028..4221f172779b 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
@@ -920,7 +920,7 @@ mcu_phy0: ethernet-phy@0 {
 
 &mcu_cpsw_port1 {
 	status = "okay";
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&mcu_phy0>;
 };
 
@@ -944,7 +944,7 @@ main_cpsw1_phy0: ethernet-phy@0 {
 };
 
 &main_cpsw1_port1 {
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii-id";
 	phy-handle = <&main_cpsw1_phy0>;
 	status = "okay";
 };
-- 
2.51.0



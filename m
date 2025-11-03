Return-Path: <linux-kernel+bounces-883239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 232D7C2CDE1
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C52F21891858
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9135F314D03;
	Mon,  3 Nov 2025 15:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbeNCjIG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C92314A9B;
	Mon,  3 Nov 2025 15:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183715; cv=none; b=t7St2Ips9s/jJ99CtfEDPICukvHssx/RoieZGO9TogCLWZ1rkKN8wX7FyCTTtqx0TwDqI0CSPA10jqhTUxM8KjukkPgA+Kqxi3lIxWYKHhaYz04fICz7ipSx1i78iDqGKSOanUFCi3N2x93nGSm8wC3bI1ilNLW0b1MFBVOsNsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183715; c=relaxed/simple;
	bh=Xq/dCk1WgAkB9VEwNe7lHwdtfzlS+p4TEfMc2Az0jnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dIsSp/K3cjUeS8s91zEQF36MXm4BafP7gZknu1WLC2oGh9yUtCZX9BGCwd3CCQYMS4grp68HmTLeqbznKtJrkXyHfHJc6cou+W4nS5rTc0w3emgobb0cP9cc6o94MHzr+UoAqJbIZBsb6tTvR3SJOfmM+FgIlDjV8ROrKZyno+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbeNCjIG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85465C116B1;
	Mon,  3 Nov 2025 15:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762183714;
	bh=Xq/dCk1WgAkB9VEwNe7lHwdtfzlS+p4TEfMc2Az0jnc=;
	h=From:To:Cc:Subject:Date:From;
	b=DbeNCjIGBy4SXe4Kiv0oTk6BcxUqZLQwmja/+Wo3p7orZDWbAJENQYp3CDwv06Ywa
	 zSM2/hPPOP2xIlYFx+OAd7Jq2ao8cn9yGJFfncB1RDkyS/C7qxBI8KQsY79Shc/bCp
	 ifWJQB7XnpMsL7NV0B+IWX5rTgO51YwShvg5cCVbzd0yhCmXhCXSZauvodv7hY0AvI
	 dhdlG8QgP2QNkM9uviwMSQGtQR68AOYhLqWAt2SOT5qQkhzRVvkUJI7iY7NBHLVeF0
	 cHM/AyHkuUF1eTGZoMDusHwDpecu0EP8VgPG1t7CaFMifDlzogkmyLqbovkPqWOSrf
	 F8a2jMuf4dmXg==
From: Michael Walle <mwalle@kernel.org>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>,
	Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am62p-j722s-common-main: move audio_refclk here
Date: Mon,  3 Nov 2025 16:28:18 +0100
Message-ID: <20251103152826.1608309-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 9dee9cb2df08 ("arm64: dts: ti: k3-j722s-main: fix the audio
refclk source") the clock nodes of the am62p and j722 are the same. Move
them into the commit dtsi.

Please note, that for the j722s the nodes are renamed from clock@ to
clock-controller@.

Suggested-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 .../dts/ti/k3-am62p-j722s-common-main.dtsi    | 18 +++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi     | 20 -------------------
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi     | 18 -----------------
 3 files changed, 18 insertions(+), 38 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
index 3289244eca13..0a42fefb6915 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
@@ -46,6 +46,24 @@ main_conf: bus@100000 {
 		#size-cells = <1>;
 		ranges = <0x00 0x00 0x00100000 0x20000>;
 
+		audio_refclk0: clock-controller@82e0 {
+			compatible = "ti,am62-audio-refclk";
+			reg = <0x82e0 0x4>;
+			clocks = <&k3_clks 157 0>;
+			assigned-clocks = <&k3_clks 157 0>;
+			assigned-clock-parents = <&k3_clks 157 16>;
+			#clock-cells = <0>;
+		};
+
+		audio_refclk1: clock-controller@82e4 {
+			compatible = "ti,am62-audio-refclk";
+			reg = <0x82e4 0x4>;
+			clocks = <&k3_clks 157 18>;
+			assigned-clocks = <&k3_clks 157 18>;
+			assigned-clock-parents = <&k3_clks 157 34>;
+			#clock-cells = <0>;
+		};
+
 		phy_gmii_sel: phy@4044 {
 			compatible = "ti,am654-phy-gmii-sel";
 			reg = <0x4044 0x8>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
index 908cc0760e7d..13d32cbff186 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
@@ -42,26 +42,6 @@ &inta_main_dmss {
 	ti,interrupt-ranges = <5 69 35>;
 };
 
-&main_conf {
-	audio_refclk0: clock-controller@82e0 {
-		compatible = "ti,am62-audio-refclk";
-		reg = <0x82e0 0x4>;
-		clocks = <&k3_clks 157 0>;
-		assigned-clocks = <&k3_clks 157 0>;
-		assigned-clock-parents = <&k3_clks 157 16>;
-		#clock-cells = <0>;
-	};
-
-	audio_refclk1: clock-controller@82e4 {
-		compatible = "ti,am62-audio-refclk";
-		reg = <0x82e4 0x4>;
-		clocks = <&k3_clks 157 18>;
-		assigned-clocks = <&k3_clks 157 18>;
-		assigned-clock-parents = <&k3_clks 157 34>;
-		#clock-cells = <0>;
-	};
-};
-
 &main_gpio0 {
 	gpio-ranges = <&main_pmx0 0 0 32>, <&main_pmx0 32 33 38>,
 			<&main_pmx0 70 72 22>;
diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
index 04de29da40f1..fc85a08428c3 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
@@ -462,24 +462,6 @@ serdes_ln_ctrl: mux-controller@4080 {
 		mux-reg-masks = <0x00 0x3>, /* SERDES0 lane0 select */
 				<0x10 0x3>; /* SERDES1 lane0 select */
 	};
-
-	audio_refclk0: clock@82e0 {
-		compatible = "ti,am62-audio-refclk";
-		reg = <0x82e0 0x4>;
-		clocks = <&k3_clks 157 0>;
-		assigned-clocks = <&k3_clks 157 0>;
-		assigned-clock-parents = <&k3_clks 157 16>;
-		#clock-cells = <0>;
-	};
-
-	audio_refclk1: clock@82e4 {
-		compatible = "ti,am62-audio-refclk";
-		reg = <0x82e4 0x4>;
-		clocks = <&k3_clks 157 18>;
-		assigned-clocks = <&k3_clks 157 18>;
-		assigned-clock-parents = <&k3_clks 157 34>;
-		#clock-cells = <0>;
-	};
 };
 
 &wkup_conf {
-- 
2.47.3



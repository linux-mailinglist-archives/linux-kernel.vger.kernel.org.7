Return-Path: <linux-kernel+bounces-827265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D52B914F3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A3AF16552A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916D5309EEE;
	Mon, 22 Sep 2025 13:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYAzbIzQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93113009E3;
	Mon, 22 Sep 2025 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546695; cv=none; b=gxU9QgKZrS/1nvOqtk77Cl5GorUlMNOlZTcCkPEtOzBNsSghoy0Rdmq85S9EgSDo17oEofBkjxq8SzLogm0kewYP8eYzlpMl8nXgs+359STDM2YtTzs8nKZdTwE3ELe6V4gHGR8zvisCEZKggJeca1gvLxQOWXhGBVlqUWjP62E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546695; c=relaxed/simple;
	bh=m1F+2phx7Lb5XyIK23kbVO9XUbG8qwxx1BZm/gVYwWI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iBbYY4ribm+NTqYnOpV1TZnsJF1GBajNPGE/6p/P1ZBGJaKrSFL3t6/4qx2K4KHMDsHoH6/sCNCxYz26Z5Z6jcmILbKlxA0O7VmVYwGQgKAohfaFMzLCbpgaktWH90FKvKYjAR3qLFWiHcy8y2+POcWS+pY/VQgCtQzN3nE1Rng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYAzbIzQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95660C4CEF0;
	Mon, 22 Sep 2025 13:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758546694;
	bh=m1F+2phx7Lb5XyIK23kbVO9XUbG8qwxx1BZm/gVYwWI=;
	h=From:To:Cc:Subject:Date:From;
	b=PYAzbIzQvSb8RcK7j23d8PVZmI4mNgOMCkEtwsd8DhOZVNRht7ukIO6EfT10M0YC/
	 xXSG8tvqaxxZrgVQdMPT808SJStUzIGTWj4Qw60amA+z8KlnZlsPwMerisBRGAO6RC
	 UDq5llW6dhBV+gZVtJGjWETX/tAUO4DCOpshcZUJwcRA6nADcwNL/nFzM6gFxDzFVU
	 q7YaO7b5Log3c/Yyy8Hpfgy8GYN4Yva3VmE9Xgb1w3tkKxIqxFq0KZh7wfp8+xicA9
	 BYf7gYuTHu/YayC8m/J20wiwKot26quLv4SIxtOAdmuj3KP5tV5WprDEIhaQnoHaKK
	 3Ml8KR2cedhlQ==
From: Michael Walle <mwalle@kernel.org>
To: Nishanth Menon <nm@ti.com>,
	Bryan Brattlof <bb@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH] arm64: dts: ti: k3-j722s: add OPP table
Date: Mon, 22 Sep 2025 15:11:05 +0200
Message-Id: <20250922131105.2670932-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the A53 frequency operation points. The frequencies where taken from
the AM62P SoC and seem to be chosen rather arbitrary.
The SoC doesn't contain it's speed grade in the JTAG USER ID efuse
register, thus it has to be hardcoded in the SoC dtsi and/or board dts.

The SoC is binned into just two speed grades with different core
voltages: J (0.75V, 1.25GHz) and K (0.85V, 1.4GHz). Add the frequencies
that both speed grades support to the SoC dtsi and if a board has a
speed grade K SoC add it to the board device tree.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 .../arm64/boot/dts/ti/k3-am67a-beagley-ai.dts |  7 ++++
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts       |  7 ++++
 arch/arm64/boot/dts/ti/k3-j722s.dtsi          | 40 +++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts b/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts
index b697035df04e..464dffd46e59 100644
--- a/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts
+++ b/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts
@@ -148,6 +148,13 @@ led-1 {
 	};
 };
 
+&a53_opp_table {
+	opp-1400000000 {
+		opp-hz = /bits/ 64 <1400000000>;
+		clock-latency-ns = <6000000>;
+	};
+};
+
 &main_pmx0 {
 	main_i2c0_pins_default: main-i2c0-default-pins {
 		pinctrl-single,pins = <
diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index e0e303da7e15..ce3ed1b0f24d 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -228,6 +228,13 @@ csi23_mux: mux-controller-1 {
 	};
 };
 
+&a53_opp_table {
+	opp-1400000000 {
+		opp-hz = /bits/ 64 <1400000000>;
+		clock-latency-ns = <6000000>;
+	};
+};
+
 &cpsw_mac_syscon {
 	bootph-all;
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j722s.dtsi b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
index 0165db6e4437..acb15307addc 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
@@ -55,6 +55,7 @@ cpu0: cpu@0 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
+			operating-points-v2 = <&a53_opp_table>;
 			clocks = <&k3_clks 135 0>;
 			#cooling-cells = <2>;
 		};
@@ -71,6 +72,7 @@ cpu1: cpu@1 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
+			operating-points-v2 = <&a53_opp_table>;
 			clocks = <&k3_clks 136 0>;
 			#cooling-cells = <2>;
 		};
@@ -87,6 +89,7 @@ cpu2: cpu@2 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
+			operating-points-v2 = <&a53_opp_table>;
 			clocks = <&k3_clks 137 0>;
 			#cooling-cells = <2>;
 		};
@@ -103,11 +106,48 @@ cpu3: cpu@3 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
+			operating-points-v2 = <&a53_opp_table>;
 			clocks = <&k3_clks 138 0>;
 			#cooling-cells = <2>;
 		};
 	};
 
+	a53_opp_table: opp-table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-1250000000 {
+			opp-hz = /bits/ 64 <1250000000>;
+			clock-latency-ns = <6000000>;
+			opp-suspend;
+		};
+	};
+
 	l2_0: l2-cache0 {
 		compatible = "cache";
 		cache-unified;
-- 
2.39.5



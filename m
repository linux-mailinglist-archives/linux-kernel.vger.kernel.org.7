Return-Path: <linux-kernel+bounces-857864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3005BE81A6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D837189FB31
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5235A313523;
	Fri, 17 Oct 2025 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dT8aMD5n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB131313271;
	Fri, 17 Oct 2025 10:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760697810; cv=none; b=EkfndRHOqCqwmTHPejB+vMS7Fd9OiDtEtoxQnHKOPzvgJaQBj1yEqb9SsUOL9OWIqGjXXC2xrO4XktJvS6WvPAH+ccTkF/uv4ZEUws9YVXnLxjirWIis57TapSV0krUmHbDIFn/5eNHAAWiVT0sENydd7tOSBrxNt8z7J53w/tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760697810; c=relaxed/simple;
	bh=Xz/ka8uQqulMQJ6eacWCSLmkEPgwFHxvwPH1ZnbJNlU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J4Y2J7Pi1881VCa9xeqaNmKHcBatcoojYebCZK9s6W4pb9K870qkqnPm45ViRNcyKX+M7QfKAlEWs5fGKKhSzFwuqA3eGFZ+n9ZVAEzFkQDvjFwVE72FNc5wSbbn1fEywkP9kCg4qP/G3JQSVbY0OxbzA6/diFrzvzYgSUrVoKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dT8aMD5n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9EBC4CEE7;
	Fri, 17 Oct 2025 10:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760697810;
	bh=Xz/ka8uQqulMQJ6eacWCSLmkEPgwFHxvwPH1ZnbJNlU=;
	h=From:To:Cc:Subject:Date:From;
	b=dT8aMD5nAIX5M5W2DEBdjWGezkjTIaUgN9q75DrXBmKCBuOBKx4Wky9Sxo2xVOmSz
	 v+WoRG7bIFXR5Nxg886QJWbcWlkvNL5oQIhoichQhJo763Bojjz6+X1Dkrdz8yj4L6
	 IxayfqK8cPdrDZfzEWagJuUP7TGdRMfH+TO5w8sq4nOBibaVVLz1U2GR2w8ZZXrAmw
	 1OYknVVjH4xeNtk+mAJ+JDoXdnU/sX43tfr1fngqrssEM7T0K4sir7B+0aYrTn8YRy
	 QruZHdXhHS5dy0AsxaNxwsdMwTNywlD5eWjN3lIhggPkPit0CHY0CDNkheGSr9F2FH
	 4ap5nBoYIbwiQ==
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
Subject: [PATCH RESEND] arm64: dts: ti: k3-j722s: add OPP table
Date: Fri, 17 Oct 2025 12:42:55 +0200
Message-ID: <20251017104315.533436-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
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
2.47.3



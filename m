Return-Path: <linux-kernel+bounces-876608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD7DC1C530
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 631BB62491D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9242EA498;
	Wed, 29 Oct 2025 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTjFubei"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90087EAF9;
	Wed, 29 Oct 2025 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753386; cv=none; b=HsWqH/gHYUFCvmqJOe7EwfNvfkcVm9m2nKsamrIBSaC9mhP1gMJQF8szNLjaQIB5oeZmABVdtq15+EXfEixCVww/CmvnlMlCPcbgGUfzjcBf5yQApQKP2LpgVnUB3U2CSCb4Z66jZlK9633BOKBhXSTkHpm9i+uCbN+Ao/+/E3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753386; c=relaxed/simple;
	bh=XQghK62bd3jJF/n+cwlvTN8QRE7fiEKJz1J2lMdo9Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+0AIZY/dfbxtQ0r6E7Eiu7iZQY+paJEjtdSnAR1VvLVILOGUKRlUtDKGh3vfbQzu2Cao5VMIu+zUyNQLpSPsoBZFdjyb24bIbTpwN1fQnkJc575B5t1gljJ+d6/1Q9mE6pyz5oILfyPHVuegZZtRw3WUX07lyD+m4e5lrYCzV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTjFubei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0757C4CEF8;
	Wed, 29 Oct 2025 15:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761753386;
	bh=XQghK62bd3jJF/n+cwlvTN8QRE7fiEKJz1J2lMdo9Fc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aTjFubeiVLXz52dW2ENZrfhqGpwKV4h2zOELSGjTKtIONuXMcpLDwCxBEieTiibLz
	 98yqMcj7+XzZ34BmUkBw6g36WNWFtvrT/Yp6l+QVYw215Zjvl59lVqqzHlw978UWQC
	 niamvecCVNI1HkNi1/alqrVfI8Lnhik2WbxG30YucUKXAAEGwiWz6EVzlBwTqHSN8e
	 5T3S5LszBmKHP0gPUxGHO6y4h0ZlA1TyJkV4xXopJVA0svwa+wp5+fEsRoTQJv23Kr
	 p3/K5EmEyR6kYXWEKxv9R6eBlx3xAG6+/64hgjfh6qDBgm+JD4AsmaXZ3fHUvoG7iH
	 +OzA9X8OTkmEg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: sprd: sc9860: Simplify clock nodes
Date: Wed, 29 Oct 2025 10:56:14 -0500
Message-ID: <20251029155615.1167903-2-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029155615.1167903-1-robh@kernel.org>
References: <20251029155615.1167903-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The various "syscon" nodes in SC9860 are only referenced by clock
provider nodes in a 1:1 relationship, and nothing else references the
"syscon" nodes. There's no apparent reason for this split. The 2 nodes
can simply be merged into 1 node. The clock driver has supported using
either "reg" or "sprd,syscon" to access registers from the start, so
there shouldn't be any compatibility issues.

With this, DT schema warnings for missing a specific compatible with
"syscon" and non-MMIO devices on "simple-bus" are fixed.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm64/boot/dts/sprd/sc9860.dtsi | 62 ----------------------------
 arch/arm64/boot/dts/sprd/whale2.dtsi | 54 ++++++++++++++++--------
 2 files changed, 36 insertions(+), 80 deletions(-)

diff --git a/arch/arm64/boot/dts/sprd/sc9860.dtsi b/arch/arm64/boot/dts/sprd/sc9860.dtsi
index d2456d633c39..864ef0a17425 100644
--- a/arch/arm64/boot/dts/sprd/sc9860.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc9860.dtsi
@@ -184,20 +184,6 @@ gic: interrupt-controller@12001000 {
 						| IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
-		pmu_gate: pmu-gate {
-			compatible = "sprd,sc9860-pmu-gate";
-			sprd,syscon = <&pmu_regs>; /* 0x402b0000 */
-			clocks = <&ext_26m>;
-			#clock-cells = <1>;
-		};
-
-		pll: pll {
-			compatible = "sprd,sc9860-pll";
-			sprd,syscon = <&ana_regs>; /* 0x40400000 */
-			clocks = <&pmu_gate 0>;
-			#clock-cells = <1>;
-		};
-
 		ap_clk: clock-controller@20000000 {
 			compatible = "sprd,sc9860-ap-clk";
 			reg = <0 0x20000000 0 0x400>;
@@ -214,19 +200,6 @@ aon_prediv: aon-prediv@402d0000 {
 			#clock-cells = <1>;
 		};
 
-		apahb_gate: apahb-gate {
-			compatible = "sprd,sc9860-apahb-gate";
-			sprd,syscon = <&ap_ahb_regs>; /* 0x20210000 */
-			clocks = <&aon_prediv 0>;
-			#clock-cells = <1>;
-		};
-
-		aon_gate: aon-gate {
-			compatible = "sprd,sc9860-aon-gate";
-			sprd,syscon = <&aon_regs>; /* 0x402e0000 */
-			clocks = <&aon_prediv 0>;
-			#clock-cells = <1>;
-		};
 
 		aonsecure_clk: clock-controller@40880000 {
 			compatible = "sprd,sc9860-aonsecure-clk";
@@ -235,13 +208,6 @@ aonsecure_clk: clock-controller@40880000 {
 			#clock-cells = <1>;
 		};
 
-		agcp_gate: agcp-gate {
-			compatible = "sprd,sc9860-agcp-gate";
-			sprd,syscon = <&agcp_regs>; /* 0x415e0000 */
-			clocks = <&aon_prediv 0>;
-			#clock-cells = <1>;
-		};
-
 		gpu_clk: clock-controller@60200000 {
 			compatible = "sprd,sc9860-gpu-clk";
 			reg = <0 0x60200000 0 0x400>;
@@ -256,13 +222,6 @@ vsp_clk: clock-controller@61000000 {
 			#clock-cells = <1>;
 		};
 
-		vsp_gate: vsp-gate {
-			compatible = "sprd,sc9860-vsp-gate";
-			sprd,syscon = <&vsp_regs>; /* 0x61100000 */
-			clocks = <&vsp_clk 0>;
-			#clock-cells = <1>;
-		};
-
 		cam_clk: clock-controller@62000000 {
 			compatible = "sprd,sc9860-cam-clk";
 			reg = <0 0x62000000 0 0x4000>;
@@ -270,13 +229,6 @@ cam_clk: clock-controller@62000000 {
 			#clock-cells = <1>;
 		};
 
-		cam_gate: cam-gate {
-			compatible = "sprd,sc9860-cam-gate";
-			sprd,syscon = <&cam_regs>; /* 0x62100000 */
-			clocks = <&cam_clk 0>;
-			#clock-cells = <1>;
-		};
-
 		disp_clk: clock-controller@63000000 {
 			compatible = "sprd,sc9860-disp-clk";
 			reg = <0 0x63000000 0 0x400>;
@@ -284,20 +236,6 @@ disp_clk: clock-controller@63000000 {
 			#clock-cells = <1>;
 		};
 
-		disp_gate: disp-gate {
-			compatible = "sprd,sc9860-disp-gate";
-			sprd,syscon = <&disp_regs>; /* 0x63100000 */
-			clocks = <&disp_clk 0>;
-			#clock-cells = <1>;
-		};
-
-		apapb_gate: apapb-gate {
-			compatible = "sprd,sc9860-apapb-gate";
-			sprd,syscon = <&ap_apb_regs>; /* 0x70b00000 */
-			clocks = <&ap_clk 0>;
-			#clock-cells = <1>;
-		};
-
 		funnel@10001000 { /* SoC Funnel */
 			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 			reg = <0 0x10001000 0 0x1000>;
diff --git a/arch/arm64/boot/dts/sprd/whale2.dtsi b/arch/arm64/boot/dts/sprd/whale2.dtsi
index a551e14ce826..dac2699a79d4 100644
--- a/arch/arm64/boot/dts/sprd/whale2.dtsi
+++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
@@ -18,49 +18,67 @@ soc: soc {
 		#size-cells = <2>;
 		ranges;
 
-		ap_ahb_regs: syscon@20210000 {
-			compatible = "syscon";
+		apahb_gate: clock-controller@20210000 {
 			reg = <0 0x20210000 0 0x10000>;
+			compatible = "sprd,sc9860-apahb-gate";
+			clocks = <&aon_prediv 0>;
+			#clock-cells = <1>;
 		};
 
-		pmu_regs: syscon@402b0000 {
-			compatible = "syscon";
+		pmu_gate: clock-controller@402b0000 {
 			reg = <0 0x402b0000 0 0x10000>;
+				compatible = "sprd,sc9860-pmu-gate";
+				clocks = <&ext_26m>;
+				#clock-cells = <1>;
 		};
 
-		aon_regs: syscon@402e0000 {
-			compatible = "syscon";
+		aon_gate: clock-controller@402e0000 {
 			reg = <0 0x402e0000 0 0x10000>;
+				compatible = "sprd,sc9860-aon-gate";
+				clocks = <&aon_prediv 0>;
+				#clock-cells = <1>;
 		};
 
-		ana_regs: syscon@40400000 {
-			compatible = "syscon";
+		pll: clock-controller@40400000 {
 			reg = <0 0x40400000 0 0x10000>;
+				compatible = "sprd,sc9860-pll";
+				clocks = <&pmu_gate 0>;
+				#clock-cells = <1>;
 		};
 
-		agcp_regs: syscon@415e0000 {
-			compatible = "syscon";
+		agcp_gate: clock-controller@415e0000 {
 			reg = <0 0x415e0000 0 0x1000000>;
+				compatible = "sprd,sc9860-agcp-gate";
+				clocks = <&aon_prediv 0>;
+				#clock-cells = <1>;
 		};
 
-		vsp_regs: syscon@61100000 {
-			compatible = "syscon";
+		vsp_gate: clock-controller@61100000 {
 			reg = <0 0x61100000 0 0x10000>;
+				compatible = "sprd,sc9860-vsp-gate";
+				clocks = <&vsp_clk 0>;
+				#clock-cells = <1>;
 		};
 
-		cam_regs: syscon@62100000 {
-			compatible = "syscon";
+		cam_gate: clock-controller@62100000 {
 			reg = <0 0x62100000 0 0x10000>;
+				compatible = "sprd,sc9860-cam-gate";
+				clocks = <&cam_clk 0>;
+				#clock-cells = <1>;
 		};
 
-		disp_regs: syscon@63100000 {
-			compatible = "syscon";
+		disp_gate: clock-controller@63100000 {
 			reg = <0 0x63100000 0 0x10000>;
+				compatible = "sprd,sc9860-disp-gate";
+				clocks = <&disp_clk 0>;
+				#clock-cells = <1>;
 		};
 
-		ap_apb_regs: syscon@70b00000 {
-			compatible = "syscon";
+		apapb_gate: clock-controller@70b00000 {
 			reg = <0 0x70b00000 0 0x40000>;
+				compatible = "sprd,sc9860-apapb-gate";
+				clocks = <&ap_clk 0>;
+				#clock-cells = <1>;
 		};
 
 		ap-apb@70000000 {
-- 
2.51.0



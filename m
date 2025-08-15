Return-Path: <linux-kernel+bounces-770396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A83B27A45
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 251ABAC7BEA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D802D12E2;
	Fri, 15 Aug 2025 07:40:23 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2171B87F0;
	Fri, 15 Aug 2025 07:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755243623; cv=none; b=UEPMdFpYSqUfcqa7Ltc3s5t7iPm5D22SWeC6g8JLVc3C7Z5daT0WOSPcampJgB/BGx7EjbPnU/CAESHZ6J5VMny/FYuho2I9DqNaQHf4lfJ2j8vULK+esg3WljDFFgby9O2bpYB8AvdyRyBUmbaOcrftPGMAltdkK0K9jv3fLB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755243623; c=relaxed/simple;
	bh=XeVqOEcOcPty77QUlaMF0zPgFJynZ5xxGmxLTOfAhA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eda7iJOyiGrU4F0k2XXDfdtidcBd+QZBm+CF9NQkh7GuMx0TzgLO3/6b0W6idRFRCXQ5rp7Tm5F2vIUPoc1H2toDLE4a71ACTTsd0uf/9+PhwJGgh8xb/tesXHAPrf5bn1DRDdJcl8QG0+mw9x/D4Oo8nEdilhQqDXVCzbtF96s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 18F0BB4E0001;
	Fri, 15 Aug 2025 09:40:16 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Conor Dooley <conor@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hal Feng <hal.feng@starfivetech.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	E Shattow <e@freeshell.de>,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 3/3] riscv: dts: starfive: jh7110: bootph-pre-ram hinting needed by boot loader
Date: Fri, 15 Aug 2025 00:37:23 -0700
Message-ID: <20250815073739.79241-4-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250815073739.79241-1-e@freeshell.de>
References: <20250815073739.79241-1-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bootph-pre-ram hinting to jh7110.dtsi:
  - CPU interrupt controller(s)
  - core local interrupt timer
  - DDR memory controller
  - oscillator
  - syscrg clock-controller

Signed-off-by: E Shattow <e@freeshell.de>
---
 arch/riscv/boot/dts/starfive/jh7110.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 14df3d062a45..884a3526cb0f 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -35,6 +35,7 @@ S7_0: cpu@0 {
 
 			cpu0_intc: interrupt-controller {
 				compatible = "riscv,cpu-intc";
+				bootph-pre-ram;
 				interrupt-controller;
 				#interrupt-cells = <1>;
 			};
@@ -68,6 +69,7 @@ U74_1: cpu@1 {
 
 			cpu1_intc: interrupt-controller {
 				compatible = "riscv,cpu-intc";
+				bootph-pre-ram;
 				interrupt-controller;
 				#interrupt-cells = <1>;
 			};
@@ -101,6 +103,7 @@ U74_2: cpu@2 {
 
 			cpu2_intc: interrupt-controller {
 				compatible = "riscv,cpu-intc";
+				bootph-pre-ram;
 				interrupt-controller;
 				#interrupt-cells = <1>;
 			};
@@ -134,6 +137,7 @@ U74_3: cpu@3 {
 
 			cpu3_intc: interrupt-controller {
 				compatible = "riscv,cpu-intc";
+				bootph-pre-ram;
 				interrupt-controller;
 				#interrupt-cells = <1>;
 			};
@@ -167,6 +171,7 @@ U74_4: cpu@4 {
 
 			cpu4_intc: interrupt-controller {
 				compatible = "riscv,cpu-intc";
+				bootph-pre-ram;
 				interrupt-controller;
 				#interrupt-cells = <1>;
 			};
@@ -321,6 +326,7 @@ mclk_ext: mclk-ext-clock {
 
 	osc: oscillator {
 		compatible = "fixed-clock";
+		bootph-pre-ram;
 		clock-output-names = "osc";
 		#clock-cells = <0>;
 	};
@@ -354,6 +360,7 @@ soc {
 		clint: timer@2000000 {
 			compatible = "starfive,jh7110-clint", "sifive,clint0";
 			reg = <0x0 0x2000000 0x0 0x10000>;
+			bootph-pre-ram;
 			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>,
 					      <&cpu1_intc 3>, <&cpu1_intc 7>,
 					      <&cpu2_intc 3>, <&cpu2_intc 7>,
@@ -376,6 +383,7 @@ memory-controller@15700000 {
 			compatible = "starfive,jh7110-dmc";
 			reg = <0x0 0x15700000 0x0 0x10000>,
 			      <0x0 0x13000000 0x0 0x10000>;
+			bootph-pre-ram;
 			clocks = <&syscrg JH7110_PLLCLK_PLL1_OUT>;
 			clock-names = "pll1_out";
 			resets = <&syscrg JH7110_SYSRST_DDR_AXI>,
@@ -892,6 +900,7 @@ qspi: spi@13010000 {
 		syscrg: clock-controller@13020000 {
 			compatible = "starfive,jh7110-syscrg";
 			reg = <0x0 0x13020000 0x0 0x10000>;
+			bootph-pre-ram;
 			clocks = <&osc>, <&gmac1_rmii_refin>,
 				 <&gmac1_rgmii_rxin>,
 				 <&i2stx_bclk_ext>, <&i2stx_lrck_ext>,
-- 
2.50.0



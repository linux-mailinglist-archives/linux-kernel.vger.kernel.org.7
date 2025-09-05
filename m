Return-Path: <linux-kernel+bounces-801967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7249CB44C29
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 05:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 48A974E01DC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 03:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9FB2571C3;
	Fri,  5 Sep 2025 03:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b="COJoE5XE"
Received: from sender4-pp-o92.zoho.com (sender4-pp-o92.zoho.com [136.143.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9607F243954;
	Fri,  5 Sep 2025 03:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757041937; cv=pass; b=c1QvnGbHK1zBf8NhzQEqT4p64QRiwpMwJwPhumavzmtm9yiVmjqFH/dUUGbnXnmBrZdHMGFvXmR9MxbwJPGSPxvRE37mdtpoK75H1AN/E97lyA5Gsq4dGRzBa0KfoCuLC1l+OP+K/WmaAneNEUU+wJjEid8qZR3J5l3MSPC9Yqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757041937; c=relaxed/simple;
	bh=+jfpVhIQhTByohDJO+xAoBewgjlpm5J5XMktEz6dzw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p871H4Pc/qvM8AzOSaRCbnjZAwq6fftLIxdcKHsVmo4VMIdpuGajLJWc+Azg69MHYoI1Pn2/3cD3dvnM45kwLh9pFx1mvyDeNHTg/cYcYvOpyqR5lZv8pZWklqkH/Y0UnTDWowgAyWmUIgKnCv6r9l5F6JnEpRnMuDp8tiQG6Pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b=COJoE5XE; arc=pass smtp.client-ip=136.143.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1757041870; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ksWutTO0TtS5DYJLCjkiW+wC6H2QgVZVZuubvkBjzA+HIKoJ22Ugir1m80gjTqUhNpjmNw/4nYFZboDxmyBEOso+C30UUBPsbFXXgKA0fPxDefiW24AnGkzpHDoIHJ62FSbvR9/SO8SQUH8xEbokpRqXp0UDWvSWp7mMw0TnNaY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757041870; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Uk8p9LgpPoAiawj3uNhnu3nSqrQyd8EhyLBL85bAStc=; 
	b=TdpBWSOxvUTjDrdIQy7jWBJZsb8yBzFz0u0BrTf6eNNVeWGcRNH633ROGXCu3vsOoWtQqX6ghKEsl0poE3HMILvB2bOjOiTWen2y21OylK9jWeL3G1LLueTsmqthRxD6zCz0UHves6hqGs9Q11CTyBfiHmmc1Fm/CSk9ksG26wA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=kingxukai@zohomail.com;
	dmarc=pass header.from=<kingxukai@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757041870;
	s=zm2022; d=zohomail.com; i=kingxukai@zohomail.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
	bh=Uk8p9LgpPoAiawj3uNhnu3nSqrQyd8EhyLBL85bAStc=;
	b=COJoE5XErMBk7Dl3r1pFbsURzfVwB0SK3afeopbOWxuHvKkHgH/M9I/1lb+oIpsQ
	p8n7SdsgEuX3Gl/f3HYAaP4LCT3I9urzOQfcE6L641KiR/IEmP3S1KTxeZmco2ZQglu
	OpAZJ0jqY1cUWtuvvFAnIcgTBTtFrLokSmjbNGsA=
Received: by mx.zohomail.com with SMTPS id 175704186761279.84924659089779;
	Thu, 4 Sep 2025 20:11:07 -0700 (PDT)
From: Xukai Wang <kingxukai@zohomail.com>
Date: Fri, 05 Sep 2025 11:10:24 +0800
Subject: [PATCH v8 3/3] riscv: dts: canaan: Add clock definition for K230
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-b4-k230-clk-v8-3-96caa02d5428@zohomail.com>
References: <20250905-b4-k230-clk-v8-0-96caa02d5428@zohomail.com>
In-Reply-To: <20250905-b4-k230-clk-v8-0-96caa02d5428@zohomail.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Xukai Wang <kingxukai@zohomail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Troy Mitchell <TroyMitchell988@gmail.com>
X-Mailer: b4 0.14.2
Feedback-ID: rr080112276577ccf8d719803bae221d170000e4a2f0f6d1a916dca3570b2a7f21aceb757966839b3fa6f20e:zu0801122701a422f97b014ef830e02475000029498c51bd643567388fd60c02ad428e9d5615e9872e392baf:rf0801122c42ccd4eaa044255146e9f1930000f8a47fdf7daad49f2f5d957350efa4cbe59ce2d2602d942a58f8421da691:ZohoMail
X-ZohoMailClient: External

This patch describes the clock controller integrated in K230 SoC
and replace dummy clocks with the real ones for UARTs.

For k230-canmv and k230-evb, they provide an additional external
pulse input through a pin to serve as clock source.

Co-developed-by: Troy Mitchell <TroyMitchell988@gmail.com>
Signed-off-by: Troy Mitchell <TroyMitchell988@gmail.com>
Signed-off-by: Xukai Wang <kingxukai@zohomail.com>
---
 arch/riscv/boot/dts/canaan/k230-canmv.dts | 11 +++++++++++
 arch/riscv/boot/dts/canaan/k230-evb.dts   | 11 +++++++++++
 arch/riscv/boot/dts/canaan/k230.dtsi      | 26 ++++++++++++++++++--------
 3 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/boot/dts/canaan/k230-canmv.dts b/arch/riscv/boot/dts/canaan/k230-canmv.dts
index 9565915cead6ad2381ea8249b616e79575feb896..cf33a5df9ff520a0dbb408864e615f61a115b673 100644
--- a/arch/riscv/boot/dts/canaan/k230-canmv.dts
+++ b/arch/riscv/boot/dts/canaan/k230-canmv.dts
@@ -17,8 +17,19 @@ ddr: memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x20000000>;
 	};
+
+	timerx_pulse_in: clock-50m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <50000000>;
+	};
 };
 
 &uart0 {
 	status = "okay";
 };
+
+&sysclk {
+	clocks = <&osc24m>, <&timerx_pulse_in>;
+	clock-names = "osc24m", "timer-pulse-in";
+};
diff --git a/arch/riscv/boot/dts/canaan/k230-evb.dts b/arch/riscv/boot/dts/canaan/k230-evb.dts
index f898b8e62368c3740d6795fd1e3cb0b261a460ac..24dba44955690e01e53f11d6720e60a81a9f435d 100644
--- a/arch/riscv/boot/dts/canaan/k230-evb.dts
+++ b/arch/riscv/boot/dts/canaan/k230-evb.dts
@@ -17,8 +17,19 @@ ddr: memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x20000000>;
 	};
+
+	timerx_pulse_in: clock-50m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <50000000>;
+	};
 };
 
 &uart0 {
 	status = "okay";
 };
+
+&sysclk {
+	clocks = <&osc24m>, <&timerx_pulse_in>;
+	clock-names = "osc24m", "timer-pulse-in";
+};
diff --git a/arch/riscv/boot/dts/canaan/k230.dtsi b/arch/riscv/boot/dts/canaan/k230.dtsi
index 95c1a3d8fb1192e30113d96d3e96329545bc6ae7..7868cd4c6c9e9d82c9271f8585a71b67738d1ca7 100644
--- a/arch/riscv/boot/dts/canaan/k230.dtsi
+++ b/arch/riscv/boot/dts/canaan/k230.dtsi
@@ -3,6 +3,7 @@
  * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
  */
 
+#include <dt-bindings/clock/canaan,k230-clk.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 /dts-v1/;
@@ -58,11 +59,11 @@ l2_cache: l2-cache {
 		};
 	};
 
-	apb_clk: apb-clk-clock {
+	osc24m: clock-24m {
 		compatible = "fixed-clock";
-		clock-frequency = <50000000>;
-		clock-output-names = "apb_clk";
 		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "osc24m";
 	};
 
 	soc {
@@ -89,10 +90,19 @@ clint: timer@f04000000 {
 			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
 		};
 
+		sysclk: clock-controller@91102000 {
+			compatible = "canaan,k230-clk";
+			reg = <0x0 0x91102000 0x0 0x40>,
+			      <0x0 0x91100000 0x0 0x108>;
+			clocks = <&osc24m>;
+			clock-names = "osc24m";
+			#clock-cells = <1>;
+		};
+
 		uart0: serial@91400000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x0 0x91400000 0x0 0x1000>;
-			clocks = <&apb_clk>;
+			clocks = <&sysclk K230_LS_UART0_RATE>;
 			interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
@@ -102,7 +112,7 @@ uart0: serial@91400000 {
 		uart1: serial@91401000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x0 0x91401000 0x0 0x1000>;
-			clocks = <&apb_clk>;
+			clocks = <&sysclk K230_LS_UART1_RATE>;
 			interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
@@ -112,7 +122,7 @@ uart1: serial@91401000 {
 		uart2: serial@91402000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x0 0x91402000 0x0 0x1000>;
-			clocks = <&apb_clk>;
+			clocks = <&sysclk K230_LS_UART2_RATE>;
 			interrupts = <18 IRQ_TYPE_LEVEL_HIGH>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
@@ -122,7 +132,7 @@ uart2: serial@91402000 {
 		uart3: serial@91403000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x0 0x91403000 0x0 0x1000>;
-			clocks = <&apb_clk>;
+			clocks = <&sysclk K230_LS_UART3_RATE>;
 			interrupts = <19 IRQ_TYPE_LEVEL_HIGH>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
@@ -132,7 +142,7 @@ uart3: serial@91403000 {
 		uart4: serial@91404000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x0 0x91404000 0x0 0x1000>;
-			clocks = <&apb_clk>;
+			clocks = <&sysclk K230_LS_UART4_RATE>;
 			interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
 			reg-io-width = <4>;
 			reg-shift = <2>;

-- 
2.34.1



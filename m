Return-Path: <linux-kernel+bounces-852702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDB7BD9A70
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 17E303554E5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4AC31A809;
	Tue, 14 Oct 2025 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="hoRak8wu"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603EB318130;
	Tue, 14 Oct 2025 13:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760447550; cv=none; b=tH2UFfJxOWVvuMeyKlebwKVje7XvffERYr34ENMLA2lgS8pLJ+AHEjzMghBxty2tvDZEyy3O45d5UK8IIJJh9I+dI5HzgwqG75bTKvRdJPKPR3PAx6DtnvsA/EAdeI6oW+42Atv31OP0Wwm85X+y1QF5/GF5ochvVqdqyHAleVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760447550; c=relaxed/simple;
	bh=NkbKzHG706iJdJxu5vSJY3qj2jEFX8Hh23r4tuIRyO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xm+6KuxWtUKS/vz9WeWQlnGDMMto3JO4/0Y0C2PSNiNc7kW8Uxl3W3o2hCvKIfQ/RPagr/gK1vYmSn2jZFibr9HYP1+8cNbhSV8Hgo6jB45QYawWZBvsfY+GzHg9Ki5NHOY+fx3pEWKcIsqwRiIVZ0MG9uofw5yJH1zCNKFKl70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=hoRak8wu; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 004DE261A5;
	Tue, 14 Oct 2025 15:12:28 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lJtEv08OE0WU; Tue, 14 Oct 2025 15:12:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1760447547; bh=NkbKzHG706iJdJxu5vSJY3qj2jEFX8Hh23r4tuIRyO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hoRak8wu9H2nqhtk5pU+JvHIL3pPfYf6CeFTSYQeWQ7AZWZ4rWq9TaBJwHvtacbch
	 9ezlEXuVL0vfgulyZD2b2BsIdJagDdC37bknlRiaS+xM0uZDu1QCQQc6x+PPNCI6Jp
	 JtLrBPkG9LMWKLvotsr0JcuVyPNALqIDGfcmdslKjSRdKerbq3DVZ0Qvj6eZIOxBA9
	 Wf5DkSxIhbmK39glWHDdTT33LUo/IOF7dq5fmBKM6Z+y8bRh1a0ffvYo1ORExcZpv3
	 wOaIq59xTCJM7fmlJ9jTlW6mmguvTBO9LVeBQXEG3OhU2ww8Rut6ui94Lkyg40JH9U
	 B+5iBuAD0AofA==
From: Yao Zi <ziyao@disroot.org>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>,
	Han Gao <rabenda.cn@gmail.com>,
	Han Gao <gaohan@iscas.ac.cn>,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH v3 5/5] riscv: dts: thead: Add reset controllers of more subsystems for TH1520
Date: Tue, 14 Oct 2025 13:10:32 +0000
Message-ID: <20251014131032.49616-6-ziyao@disroot.org>
In-Reply-To: <20251014131032.49616-1-ziyao@disroot.org>
References: <20251014131032.49616-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe reset controllers for VI, MISC, AP, DSP and AO subsystems. The
one for AO subsystem is marked as reserved, since it may be used by AON
firmware.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 37 +++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index e680d1a7c821..15d64eaea89f 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -277,6 +277,12 @@ clint: timer@ffdc000000 {
 					      <&cpu3_intc 3>, <&cpu3_intc 7>;
 		};
 
+		rst_vi: reset-controller@ffe4040100 {
+			compatible = "thead,th1520-reset-vi";
+			reg = <0xff 0xe4040100 0x0 0x8>;
+			#reset-cells = <1>;
+		};
+
 		spi0: spi@ffe700c000 {
 			compatible = "thead,th1520-spi", "snps,dw-apb-ssi";
 			reg = <0xff 0xe700c000 0x0 0x1000>;
@@ -502,6 +508,18 @@ uart2: serial@ffec010000 {
 			status = "disabled";
 		};
 
+		rst_misc: reset-controller@ffec02c000 {
+			compatible = "thead,th1520-reset-misc";
+			reg = <0xff 0xec02c000 0x0 0x18>;
+			#reset-cells = <1>;
+		};
+
+		rst_vp: reset-controller@ffecc30000 {
+			compatible = "thead,th1520-reset-vp";
+			reg = <0xff 0xecc30000 0x0 0x14>;
+			#reset-cells = <1>;
+		};
+
 		clk: clock-controller@ffef010000 {
 			compatible = "thead,th1520-clk-ap";
 			reg = <0xff 0xef010000 0x0 0x1000>;
@@ -509,6 +527,18 @@ clk: clock-controller@ffef010000 {
 			#clock-cells = <1>;
 		};
 
+		rst_ap: reset-controller@ffef014000 {
+			compatible = "thead,th1520-reset-ap";
+			reg = <0xff 0xef014000 0x0 0x1000>;
+			#reset-cells = <1>;
+		};
+
+		rst_dsp: reset-controller@ffef040028 {
+			compatible = "thead,th1520-reset-dsp";
+			reg = <0xff 0xef040028 0x0 0x4>;
+			#reset-cells = <1>;
+		};
+
 		gpu: gpu@ffef400000 {
 			compatible = "thead,th1520-gpu", "img,img-bxm-4-64",
 				     "img,img-rogue";
@@ -681,6 +711,13 @@ aogpio: gpio-controller@0 {
 			};
 		};
 
+		rst_ao: reset-controller@fffff44000 {
+			compatible = "thead,th1520-reset-ao";
+			reg = <0xff 0xfff44000 0x0 0x2000>;
+			#reset-cells = <1>;
+			status = "reserved";
+		};
+
 		padctrl_aosys: pinctrl@fffff4a000 {
 			compatible = "thead,th1520-pinctrl";
 			reg = <0xff 0xfff4a000 0x0 0x2000>;
-- 
2.50.1



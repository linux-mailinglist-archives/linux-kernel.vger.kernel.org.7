Return-Path: <linux-kernel+bounces-793790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 943B7B3D83A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 06:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B0091897B83
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 04:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A31231C91;
	Mon,  1 Sep 2025 04:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Yjl+PQAo"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE45229B2A;
	Mon,  1 Sep 2025 04:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756700703; cv=none; b=HenJ8ZhImpWcM4DVO5LXOS+o4qJgKy5QqNkOq42U6fbksOQwwUOb/6ug3lHJ4DVQ3sBUOBspJrGuM54gAjnmAq0XcEnj147R04Qgg9rhHrm7hKH6z5VCe907YOMUMP9vSXArJWbCAzSpDTV+q6LPokVwg4EMvb1G9oMVdyTwSTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756700703; c=relaxed/simple;
	bh=IBslNheDZQKi8czdVueADyFl/OhJ12YV0b0a6fTRNBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQ41Ef1CB1iNYS9Yr5P8xIgW0OCfOFYZ97xBNixmfRbMwdklNLWJE5P9oEYpXb0ZuSdBQ1Kbjz5Nqk+1sYk77e1hYOWRk0LDsW1IVswSkQl1UkR03lawUL1GRvmwHnqS91RFYPvmxmYwbXBkcZe9WOzlWcxP4KPHz6hZn+bSweE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Yjl+PQAo; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 534D020A4A;
	Mon,  1 Sep 2025 06:25:00 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xqWkWWlIwsnK; Mon,  1 Sep 2025 06:24:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1756700699; bh=IBslNheDZQKi8czdVueADyFl/OhJ12YV0b0a6fTRNBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yjl+PQAo4Sqf4Q068Fp2s12iFBzveSRFGCG/8eZLYHan4kdeB7UwJ50E1UTn6MK22
	 tfuC3D9JM1NIm+ZA4MLrTNg+32gHm8Zc0uC8p1OIrIcf9yQpBYwq6PyuWaBnRYLYeQ
	 ufBpITelFgBXAguHxkoQrCHI6Zd4qHV2o3H4KChIiifJPywxrMHwiP6d/aLEi7jTjH
	 ZvclS4kk1ql2qypcfKHllsNhvqPJnex01ZvXkL5B2emA9o9K58zo6qulVqgo2x0oo+
	 e9KDC/x0/xiEmuVkn9IKBk4F4z/QQX+bkCrg7kQ5H86hwftDeN49/kxx1x+Oui13bu
	 xvObz2R0MMlOw==
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
Subject: [PATCH 4/4] riscv: dts: thead: Add reset controllers of more subsystems for TH1520
Date: Mon,  1 Sep 2025 04:23:20 +0000
Message-ID: <20250901042320.22865-5-ziyao@disroot.org>
In-Reply-To: <20250901042320.22865-1-ziyao@disroot.org>
References: <20250901042320.22865-1-ziyao@disroot.org>
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
index 03f1d7319049..e9fa0df0b56c 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -270,6 +270,12 @@ clint: timer@ffdc000000 {
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
@@ -495,6 +501,18 @@ uart2: serial@ffec010000 {
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
@@ -502,6 +520,18 @@ clk: clock-controller@ffef010000 {
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
 		rst: reset-controller@ffef528000 {
 			compatible = "thead,th1520-reset";
 			reg = <0xff 0xef528000 0x0 0x4f>;
@@ -660,6 +690,13 @@ aogpio: gpio-controller@0 {
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



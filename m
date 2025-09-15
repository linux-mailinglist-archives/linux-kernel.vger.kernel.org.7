Return-Path: <linux-kernel+bounces-816557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DD5B5755D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F7397ACC48
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF552F99B0;
	Mon, 15 Sep 2025 09:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="iLtVAy5h"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC0D2FABF0;
	Mon, 15 Sep 2025 09:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757930280; cv=none; b=ON6XVOUFQnA6Bk7GHRsJC3owG91Ay+YqGJ9eqwZC78xzTXnRecO/JSjIZtwZFLLiR7eUgBVvZaPXkR73M1uk9hHbn2ji/cKhLfhmtMUqu19UbL1Aswdymb37hcD+MoE6ce9+OPzlovjS1u6wc1rXwcSePUvY7+FYoie0aoq7VtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757930280; c=relaxed/simple;
	bh=NkbKzHG706iJdJxu5vSJY3qj2jEFX8Hh23r4tuIRyO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHCOWm51FKDC1AtyV+cKyCBXWtNNWL4iokjHbzd6Eq1rwAIKVFbGyvtrlte23T1oxiTKONI0195ECTg2R9rs85+tTHEcTdWrXkhfhNJZ+ywOsQ7MzcL13iWYTX3ixgLz3El+e0PuKdHIxb14pNn8uMYmmD/4kq7pe+OzHvtmLr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=iLtVAy5h; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 1AA3F25EA4;
	Mon, 15 Sep 2025 11:57:57 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eWK9oPfQyWsU; Mon, 15 Sep 2025 11:57:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1757930276; bh=NkbKzHG706iJdJxu5vSJY3qj2jEFX8Hh23r4tuIRyO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iLtVAy5hx2LIxlxXEcOje0/JIj0/WFQABySWR4w3lXWbavWHKrHJFcmuAaL7uuSeI
	 NzArqKdkClnHnqSq9Mo1NDcgZSwAqpxgOtAzulYUW1rgfORO+AfgJRWQP3xM546PcA
	 WT0ykAv0OOLgltXLXKL/TfgyGxXrGQLXv6myWWdzOqXc2pfkMFE/ct0vtHtGgnzOA8
	 bKH53mj/7mohFflbz6u9AF0x49aJkly7TnNn+AoCo4NFE3H4Gq5vsjU6hkP+THbHzz
	 /NmbNJEQRxgUa7B+frdJOj1dsehAX2tgmRbrKtMJJoxNB9EPcliemCZE2k2wYCVoT+
	 YxdoUQbvzlkTg==
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
Subject: [PATCH v2 5/5] riscv: dts: thead: Add reset controllers of more subsystems for TH1520
Date: Mon, 15 Sep 2025 09:57:34 +0000
Message-ID: <20250915095734.53423-1-ziyao@disroot.org>
In-Reply-To: <20250915095331.53350-1-ziyao@disroot.org>
References: <20250915095331.53350-1-ziyao@disroot.org>
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



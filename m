Return-Path: <linux-kernel+bounces-607378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5445A9057D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 16:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBDE6446F8E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 14:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D430227E8A;
	Wed, 16 Apr 2025 13:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="Jnjecutk";
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="adj2gyPj"
Received: from bayard.4d2.org (bayard.4d2.org [155.254.16.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2A52153D8;
	Wed, 16 Apr 2025 13:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.254.16.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744811689; cv=none; b=nk6Ud5IQng86vmyCzMFKCtu7dsunkE1iIuPMa0GixFo91HN/f18OjDULDhEfEq1Zzmq1MdrzHGlJKKO0p0ZPmRiEpEfoWmlc2fn0KIW8lBKplS8kBHkMCOPywnqEIiT4kYvqVWW9+jgjNHzCrpQ55Hfd3r1dkGTumxNQKdj8DUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744811689; c=relaxed/simple;
	bh=l2Ew2QaIDw/j/7Ld2pHbLd9snohEK2xnD23UVoTkGf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tuajGjUslMIb0nHdDjbE0m0I7IFYMfWlFXK8f7zv9gilb7JTfcIyr/YRszIgww7TmcsVcv3N8oO+++wbTBGnmZg3hK9vXf4S93rCbQkUQEWtHUVaIttGUfPMSvB9xR4M1cojmkzzKkRhISWpusY57CFvcAiLOg1p/dIJ4ZFFFJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org; spf=pass smtp.mailfrom=4d2.org; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=Jnjecutk; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=adj2gyPj; arc=none smtp.client-ip=155.254.16.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4d2.org
Received: from bayard.4d2.org (bayard.4d2.org [127.0.0.1])
	by bayard.4d2.org (Postfix) with ESMTP id 16ADC12FB452;
	Wed, 16 Apr 2025 06:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1744811687; bh=l2Ew2QaIDw/j/7Ld2pHbLd9snohEK2xnD23UVoTkGf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jnjecutk7IbbAlg86CJkB7SMwQsvq7qanMRrw7mk2yF8SkU4v9+Kz5dJZ6mlIncBg
	 7vUh7jwYGRC9r9XleQ/i98kVvqn0r1//YMaEn/uBU+SAo3/JAsIi7+jDvYmKey/4rq
	 5y+ucpVYmbEigGnxdqBjFpuNCrYvuWf4xCKlIEEWmFFrMUehakP8pkB7E1IB+Mw4jc
	 7HIAjR5/t2U0Wl+J17ug4VTLU8ZmJf5L0vWwZ1yrXPt6gsYUfpTbPo9V1t4QM+RdIe
	 FRz3UO3TJss4wQ6LVuyoVp9yIsEo0ttbthMaLolhNjthj43HXvCBAD3CTYud7RB3un
	 ZlQubfecvCHyg==
X-Virus-Scanned: amavisd-new at 4d2.org
Authentication-Results: bayard.4d2.org (amavisd-new); dkim=pass (2048-bit key)
 header.d=4d2.org
Received: from bayard.4d2.org ([127.0.0.1])
 by bayard.4d2.org (bayard.4d2.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ia2x2Q0G3J52; Wed, 16 Apr 2025 06:54:45 -0700 (PDT)
Received: from localhost.localdomain (unknown [183.217.80.190])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: heylenay@4d2.org)
	by bayard.4d2.org (Postfix) with ESMTPSA id 4AB0912FB450;
	Wed, 16 Apr 2025 06:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1744811685; bh=l2Ew2QaIDw/j/7Ld2pHbLd9snohEK2xnD23UVoTkGf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=adj2gyPjwKJnEZaMbSNILOgrFARTQB1ixgsPnbYDGYWoVc1wYH/5F4NsFGuhXvEnH
	 uPhG9+p0DGHASTqDeMllUCcI7jMpeHvoTuv9kNTA6y58LV+eLW8qSGsRpmORaSPoo/
	 83eviOXhSem/gzYHuqAu/XKXJV8V5nW00hqR3ilPLKsVyZhyDmZPXStyDGNDN9Fz7a
	 1MB0Yl6BN1SqahwXHKXwS4nY7mDrxQK8taXXDgNP4KX0wIBZUU76xP2x/Rxi+5KgYP
	 ynNcb4WLFplGI/elx6NfEk/IUDccV/OqZj+hedqwcINk7h76AdJ01f7Zi+QUVU7g/P
	 MVyCuytqA1o0A==
From: Haylen Chu <heylenay@4d2.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Haylen Chu <heylenay@outlook.com>,
	Yixun Lan <dlan@gentoo.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	spacemit@lists.linux.dev,
	Inochi Amaoto <inochiama@outlook.com>,
	Chen Wang <unicornxdotw@foxmail.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
	Haylen Chu <heylenay@4d2.org>,
	Alex Elder <elder@riscstar.com>
Subject: [PATCH v8 5/6] riscv: dts: spacemit: Add clock tree for SpacemiT K1
Date: Wed, 16 Apr 2025 13:54:05 +0000
Message-ID: <20250416135406.16284-6-heylenay@4d2.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416135406.16284-1-heylenay@4d2.org>
References: <20250416135406.16284-1-heylenay@4d2.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the PLL and system controllers that're capable of generating
clock signals in the devicetree.

Signed-off-by: Haylen Chu <heylenay@4d2.org>
Reviewed-by: Alex Elder <elder@riscstar.com>
Reviewed-by: Yixun Lan <dlan@gentoo.org>
---
 arch/riscv/boot/dts/spacemit/k1.dtsi | 75 ++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index c670ebf8fa12..584f0dbc60f5 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -3,6 +3,8 @@
  * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
  */
 
+#include <dt-bindings/clock/spacemit,k1-syscon.h>
+
 /dts-v1/;
 / {
 	#address-cells = <2>;
@@ -306,6 +308,36 @@ cluster1_l2_cache: l2-cache1 {
 		};
 	};
 
+	clocks {
+		vctcxo_1m: clock-1m {
+			compatible = "fixed-clock";
+			clock-frequency = <1000000>;
+			clock-output-names = "vctcxo_1m";
+			#clock-cells = <0>;
+		};
+
+		vctcxo_24m: clock-24m {
+			compatible = "fixed-clock";
+			clock-frequency = <24000000>;
+			clock-output-names = "vctcxo_24m";
+			#clock-cells = <0>;
+		};
+
+		vctcxo_3m: clock-3m {
+			compatible = "fixed-clock";
+			clock-frequency = <3000000>;
+			clock-output-names = "vctcxo_3m";
+			#clock-cells = <0>;
+		};
+
+		osc_32k: clock-32k {
+			compatible = "fixed-clock";
+			clock-frequency = <32000>;
+			clock-output-names = "osc_32k";
+			#clock-cells = <0>;
+		};
+	};
+
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&plic>;
@@ -314,6 +346,17 @@ soc {
 		dma-noncoherent;
 		ranges;
 
+		syscon_apbc: system-control@d4015000 {
+			compatible = "spacemit,k1-syscon-apbc";
+			reg = <0x0 0xd4015000 0x0 0x1000>;
+			clocks = <&osc_32k>, <&vctcxo_1m>, <&vctcxo_3m>,
+				 <&vctcxo_24m>;
+			clock-names = "osc", "vctcxo_1m", "vctcxo_3m",
+				      "vctcxo_24m";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
 		uart0: serial@d4017000 {
 			compatible = "spacemit,k1-uart", "intel,xscale-uart";
 			reg = <0x0 0xd4017000 0x0 0x100>;
@@ -409,6 +452,38 @@ pinctrl: pinctrl@d401e000 {
 			reg = <0x0 0xd401e000 0x0 0x400>;
 		};
 
+		syscon_mpmu: system-controller@d4050000 {
+			compatible = "spacemit,k1-syscon-mpmu";
+			reg = <0x0 0xd4050000 0x0 0x209c>;
+			clocks = <&osc_32k>, <&vctcxo_1m>, <&vctcxo_3m>,
+				 <&vctcxo_24m>;
+			clock-names = "osc", "vctcxo_1m", "vctcxo_3m",
+				      "vctcxo_24m";
+			#clock-cells = <1>;
+			#power-domain-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		pll: system-control@d4090000 {
+			compatible = "spacemit,k1-pll";
+			reg = <0x0 0xd4090000 0x0 0x1000>;
+			clocks = <&vctcxo_24m>;
+			spacemit,mpmu = <&syscon_mpmu>;
+			#clock-cells = <1>;
+		};
+
+		syscon_apmu: system-control@d4282800 {
+			compatible = "spacemit,k1-syscon-apmu";
+			reg = <0x0 0xd4282800 0x0 0x400>;
+			clocks = <&osc_32k>, <&vctcxo_1m>, <&vctcxo_3m>,
+				 <&vctcxo_24m>;
+			clock-names = "osc", "vctcxo_1m", "vctcxo_3m",
+				      "vctcxo_24m";
+			#clock-cells = <1>;
+			#power-domain-cells = <1>;
+			#reset-cells = <1>;
+		};
+
 		plic: interrupt-controller@e0000000 {
 			compatible = "spacemit,k1-plic", "sifive,plic-1.0.0";
 			reg = <0x0 0xe0000000 0x0 0x4000000>;
-- 
2.49.0


